import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_node := rt.new_null()
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		rt.call_function('assert', [
			rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode')))
				|| rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode')))))
				|| rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode')))))
				|| rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode')))),
		])
		{
			mut iter_1 := rt.get_property(var_node, 'fields').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_fieldDef := item_1.val
				Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames.checkarguniqueness(rt.concat(rt.concat(rt.get_property(rt.get_property(var_node,
					'name'), 'value'), rt.new_string('.')), rt.get_property(rt.get_property(var_fieldDef,
					'name'), 'value')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_fieldDef,
					'arguments')), mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext',
					[]string{}, var_context))
			}
		}
		return fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			return temp.skipnode()
		}()
	}
	mut var_checkArgUniquenessPerField := rt.new_closure(closure_1_fn)
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames.checkarguniqueness(rt.concat(rt.new_string('@'), rt.get_property(rt.get_property(var_node,
			'name'), 'value')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node,
			'arguments')), mut var_context)
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.directive_definition()
			val: rt.new_closure(closure_2_fn)
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_definition()
			val: var_checkArgUniquenessPerField
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.interface_type_extension()
			val: var_checkArgUniquenessPerField
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_definition()
			val: var_checkArgUniquenessPerField
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_type_extension()
			val: var_checkArgUniquenessPerField
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames.checkarguniqueness(parentName string, mut var_arguments Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_seenArgs := rt.new_array()
	{
		mut iter_1 := var_arguments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argument := item_1.val
			var_seenArgs.array_get_mut(rt.get_property(rt.get_property(var_argument, 'name'),
				'value')).array_push(var_argument.dup())
		}
	}
	{
		mut iter_1 := var_seenArgs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_argNodes := item_1.val
			mut var_argName := item_1.key
			if var_argNodes.dup().array_count() > 1 {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Argument \"${var_parentName}(${var_argName.to_string()}:)\" can only be defined once."),
					var_argNodes.dup()))
			}
		}
	}
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		return temp.skipnode()
	}()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniqueargumentdefinitionnames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'checkArgUniqueness' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames.checkarguniqueness(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueArgumentDefinitionNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniqueargumentdefinitionnames_php() {
	// unsupported statement: Stmt_Declare
}
