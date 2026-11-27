module parser

import compiler.syntax as ast
import compiler.repr

// parse_structural_elements 扫描并提取所有结构要素（Interface, Enum, globals Struct, 普通 Struct）
pub fn parse_structural_elements(all_stmts []ast.Stmt,
	table &ast.Table,
	decl_modules map[string]string) !([]repr.PhpRepr, repr.PhpGlobalsRepr, map[string]repr.PhpParamsStruct) {
	mut elements := []repr.PhpRepr{}
	mut globals_repr := repr.PhpGlobalsRepr{}
	mut trait_rules := collect_native_trait_rules(all_stmts)!
	mut property_contracts := collect_property_contracts(all_stmts, 'PhpInterfaceProperties',
		'PhpInterfaceProperty')!
	mut abstract_properties := collect_property_contracts(all_stmts, 'PhpAbstractProperties',
		'PhpAbstractProperty')!
	mut interface_defaults := collect_interface_defaults(all_stmts)!
	mut interface_methods := collect_interface_methods(all_stmts)!
	mut declared_properties := collect_declared_properties(all_stmts)!

	for stmt in all_stmts {
		if stmt is ast.InterfaceDecl {
			if mut iface := parse_interface_decl(stmt, table) {
				iface.min_php_version = type_min_php_version(stmt.attrs, iface.php_name)!
				target := qualified_v_type(iface.module_name, iface.name)
				if properties := property_contracts[target] {
					iface.properties = properties
					property_contracts.delete(target)
				}
				bind_interface_static_methods(mut iface, stmt.attrs)!
				elements << iface
				continue
			}
			reject_unexported_type_version(stmt.attrs, stmt.name)!
		}

		if stmt is ast.EnumDecl {
			if mut enum_repr := parse_enum_decl(stmt, table) {
				if enum_repr.parse_err != '' {
					return error(enum_repr.parse_err)
				}
				enum_repr.min_php_version = type_min_php_version(stmt.attrs, enum_repr.php_name)!
				enum_repr.module_name = decl_modules['enum:${stmt.name}']
				elements << enum_repr
				continue
			}
			reject_unexported_type_version(stmt.attrs, stmt.name)!
		}

		if stmt is ast.StructDecl {
			if !stmt.attrs.any(it.name == 'params') {
				for field in stmt.fields {
					if field.attrs.any(it.name == 'vphp.PhpSensitiveField') {
						return error('PhpSensitiveField requires a field of a @[params] struct: ${stmt.name}.${field.name}')
					}
				}
			}
			if stmt.attrs.any(it.name == 'vphp.PhpUsesTraits')
				&& !stmt.attrs.any(it.name == 'vphp.PhpExportTrait') {
				return error('PhpUsesTraits requires an exported native PHP trait: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpTraitAliases')
				&& !stmt.attrs.any(it.name == 'vphp.PhpExportTrait') {
				return error('PhpTraitAliases requires an exported native PHP trait: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpTraitAdaptations')
				&& !stmt.attrs.any(it.name == 'vphp.PhpExportTrait') {
				return error('PhpTraitAdaptations requires an exported native PHP trait: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpTraitPrecedences')
				&& !stmt.attrs.any(it.name == 'vphp.PhpExportTrait') {
				return error('PhpTraitPrecedences requires an exported native PHP trait: ${stmt.name}')
			}
			if g_repr := parse_globals_decl(stmt, table) {
				reject_unexported_type_version(stmt.attrs, stmt.name)!
				if globals_repr.name != '' {
					return error('multiple PHP module globals declarations: ${globals_repr.name} and ${g_repr.name}')
				}
				globals_repr = g_repr
				continue
			}

			if mut cls := parse_class_decl(stmt, table, module_for_stmt(stmt, decl_modules)) {
				if cls.is_trait && !cls.is_native_trait {
					reject_unexported_type_version(stmt.attrs, stmt.name)!
				}
				cls.min_php_version = type_min_php_version(stmt.attrs, cls.php_name)!
				target := qualified_v_type(cls.module_name, cls.name)
				if properties := abstract_properties[target] {
					bind_abstract_properties(mut cls, properties)!
					abstract_properties.delete(target)
				}
				if properties := declared_properties[target] {
					for prop in properties {
						if cls.properties.any(it.name == prop.name) {
							return error('PHP ${cls.php_name}::$${prop.name}: duplicate property declaration')
						}
						cls.properties << prop
					}
					declared_properties.delete(target)
				}
				apply_declared_property_modifiers(mut cls, stmt.attrs)!
				if cls.is_native_trait {
					bind_native_trait_declarations(mut cls, stmt.attrs, all_stmts, trait_rules[target])!
					trait_rules.delete(target)
				}
				elements << cls
				continue
			}
			reject_unexported_type_version(stmt.attrs, stmt.name)!
		}
	}
	params_structs := collect_params_structs(all_stmts, table, elements)
	for mut element in elements {
		if mut element is repr.PhpInterfaceRepr {
			bind_interface_params(mut element, params_structs)
			target := qualified_v_type(element.module_name, element.name)
			if methods := interface_methods[target] {
				bind_interface_methods(mut element, methods)!
				interface_methods.delete(target)
			}
			if defaults := interface_defaults[target] {
				bind_interface_defaults(mut element, defaults)!
				interface_defaults.delete(target)
			}
		}
	}
	for target, rule in trait_rules {
		return error('PhpTraitRules constant `${rule.name}` must target an exported native PHP trait: ${target}')
	}
	for target, _ in property_contracts {
		return error('PhpInterfaceProperties must target an exported PHP interface: ${target}')
	}
	for target, _ in interface_defaults {
		return error('PhpInterfaceDefaults must target an exported PHP interface: ${target}')
	}
	for target, _ in interface_methods {
		return error('PhpInterfaceMethods must target an exported PHP interface: ${target}')
	}
	for target, _ in abstract_properties {
		return error('PhpAbstractProperties must target an exported abstract PHP class: ${target}')
	}
	for target, _ in declared_properties {
		return error('PhpDeclaredProperties must target an exported PHP class or trait: ${target}')
	}
	return elements, globals_repr, params_structs
}

fn type_min_php_version(attrs []ast.Attr, name string) !int {
	return export_min_php_version(attrs, 'vphp.PhpTypeSince', 'PHP type ${name}')
}

fn reject_unexported_type_version(attrs []ast.Attr, name string) ! {
	if attrs.any(it.name == 'vphp.PhpTypeSince') {
		return error('PhpTypeSince requires an exported PHP type: ${name}')
	}
}

fn bind_abstract_properties(mut class_ repr.PhpClassRepr, properties []repr.PhpInterfacePropertyRepr) ! {
	if !class_.is_abstract || class_.is_trait {
		return error('PhpAbstractProperties requires PhpAbstractClass on ${class_.php_name}')
	}
	for property in properties {
		if class_.properties.any(it.name == property.name) {
			return error('PHP abstract property ${class_.php_name}::$${property.name}: already declared')
		}
		class_.properties << repr.PhpClassPropRepr{
			name:                      property.name
			v_field_name:              property.name
			php_type:                  property.php_type
			visibility:                'public'
			is_mut:                    true
			is_property_only:          true
			abstract_get:              property.has_get
			abstract_get_by_reference: property.get_by_reference
			abstract_set:              property.has_set
			min_php_version:           property.min_php_version
		}
	}
}

// parse_behavioral_elements 扫描并挂载行为要素（普通函数, 类方法, 静态方法, 常量, 并发任务）
pub fn parse_behavioral_elements(all_stmts []ast.Stmt,
	table &ast.Table,
	mut elements []repr.PhpRepr,
	field_types map[string]string,
	params_structs map[string]repr.PhpParamsStruct,
	resolved_borrowed map[string]bool,
	method_return_types map[string]string) ! {
	mut class_index := map[string]int{}
	for idx, el in elements {
		if el is repr.PhpClassRepr {
			class_index[el.name] = idx
		} else if el is repr.PhpEnumRepr {
			class_index[el.name] = idx
		}
	}

	for stmt in all_stmts {
		if stmt is ast.FnDecl {
			reject_unexported_type_version(stmt.attrs, stmt.name)!
			if stmt.is_method && stmt.attrs.any(it.name == 'vphp.PhpFunctionSince') {
				return error('PhpFunctionSince requires an exported PHP function: ${stmt.name}')
			}
			if stmt.is_method {
				receiver_type := table.get_type_name(stmt.receiver.typ).all_after_last('.')
				if receiver_type in class_index {
					idx := class_index[receiver_type]
					mut el := elements[idx]
					if mut el is repr.PhpClassRepr {
						add_class_method(mut el, stmt, table, field_types, resolved_borrowed,
							method_return_types, params_structs)!
						elements[idx] = el
					} else if mut el is repr.PhpEnumRepr {
						mut owner := el.method_owner()
						add_class_method(mut owner, stmt, table, field_types, resolved_borrowed,
							method_return_types, params_structs)!
						el.methods = owner.methods
						elements[idx] = el
					}
					continue
				}
			}

			if stmt.name.contains('__static__') {
				parts := stmt.name.split('__static__')
				if parts.len == 2 {
					raw_class := parts[0]
					class_name := if raw_class.contains('.') {
						raw_class.all_after_last('.')
					} else {
						raw_class
					}
					method_name := parts[1]

					if class_name in class_index {
						if stmt.attrs.any(it.name == 'vphp.PhpFunctionSince') {
							return error('PhpFunctionSince requires an exported PHP function: ${stmt.name}')
						}
						idx := class_index[class_name]
						mut el := elements[idx]
						if mut el is repr.PhpClassRepr {
							add_class_static_method(mut el, stmt, table, method_name,
								params_structs)!
							elements[idx] = el
						} else if mut el is repr.PhpEnumRepr {
							mut owner := el.method_owner()
							add_class_static_method(mut owner, stmt, table, method_name, params_structs)!
							el.methods = owner.methods
							elements[idx] = el
						}
						continue
					}
				}
			}

			if stmt.attrs.any(it.name == 'vphp.PhpFinalMethod') {
				return error('PhpFinalMethod requires an exported PHP method: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpMethodVisibility') {
				return error('PhpMethodVisibility requires an exported PHP method: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpMethodSince') {
				return error('PhpMethodSince requires an exported PHP method: ${stmt.name}')
			}
			if stmt.attrs.any(it.name in ['vphp.PhpPropertyGet', 'vphp.PhpPropertySet']) {
				return error('PHP property hook ${stmt.name}: requires an instance method on an exported class')
			}
			attrs := parse_callable_attrs(stmt.attrs, 'php_function', '')
			if mut func := parse_function_with_attrs(stmt, attrs, table, params_structs) {
				validate_parameter_attribute_targets(attrs, func.args, func.name)!
				func.min_php_version = export_min_php_version(stmt.attrs, 'vphp.PhpFunctionSince',
					'PHP function ${func.name}')!
				elements << func
				continue
			}
			if stmt.attrs.any(it.name == 'vphp.PhpFunctionSince') {
				return error('PhpFunctionSince requires an exported PHP function: ${stmt.name}')
			}
			if stmt.attrs.any(it.name == 'vphp.PhpSensitiveParameter') {
				return error('PhpSensitiveParameter requires an exported PHP callable: ${stmt.name}')
			}
		}

		if stmt is ast.ConstDecl {
			reject_unexported_type_version(stmt.attrs, 'constant declaration')!
			parse_constant_decl(stmt, table, mut elements)!
			continue
		}

		if task := parse_task_decl(stmt, table) {
			elements << task
			continue
		}
	}
}

fn module_for_stmt(stmt ast.Stmt, decl_modules map[string]string) string {
	key := decl_key(stmt)
	if module_name := decl_modules[key] {
		return module_name
	}
	short_key := decl_short_key(stmt)
	return decl_modules[short_key] or { 'main' }
}
