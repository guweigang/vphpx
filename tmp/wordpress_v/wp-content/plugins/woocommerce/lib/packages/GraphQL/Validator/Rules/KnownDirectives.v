import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	mut var_locationsMap := rt.new_array()
	mut var_schema := var_context.getschema()
	mut var_definedDirectives := if rt.is_true(rt.identical(var_schema, rt.new_null())) { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}; return temp.getinternaldirectives() }() } else { rt.call_method(var_schema, 'getDirectives', []rt.PhpVal{}) }
	{
		mut iter_1 := var_definedDirectives.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			var_locationsMap.array_set(rt.get_property(var_directive, 'name'), rt.get_property(var_directive, 'locations'))
		}
	}
	mut var_astDefinition := rt.get_property(var_context.getdocument(), 'definitions')
	{
		mut iter_1 := var_astDefinition.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_def := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_def, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode'))) {
				mut var_locationNames := rt.new_array()
				{
					mut iter_2 := rt.get_property(var_def, 'locations').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_location := item_2.val
						var_locationNames.array_push(rt.get_property(var_location, 'value'))
					}
				}
				var_locationsMap.array_set(rt.get_property(rt.get_property(var_def, 'name'), 'value'), var_locationNames.dup())
			}
		}
	}
	closure_1_fn := fn [var_context, var_locationsMap] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_key := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_parent := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	mut var_path := if args.len > 3 { args[3].dup() } else { rt.new_null() }
	mut var_ancestors := if args.len > 4 { args[4].dup() } else { rt.new_null() }
	mut var_name := rt.get_property(rt.get_property(var_node, 'name'), 'value')
	mut var_locations := if !(var_locationsMap.array_get(var_name)).is_null() { var_locationsMap.array_get(var_name) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_locations, rt.new_null())) {
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.unknowndirectivemessage((var_name).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
		return rt.new_null()
	}
	mut var_candidateLocation := rt.new_string(this.getdirectivelocationforastpath(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_ancestors)))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_candidateLocation, rt.new_string(''))) || rt.is_true(rt.call_function('in_array', [var_candidateLocation.dup(), var_locations.dup(), rt.new_bool(true)])))) {
		return rt.new_null()
	}
	var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.misplaceddirectivemessage((var_name).str(), (var_candidateLocation).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.directive(), val: rt.new_closure(closure_1_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.unknowndirectivemessage(directiveName string) string {
	return "Unknown directive \"@${var_directiveName}\"."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) getdirectivelocationforastpath(mut var_ancestors Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_appliedTo := var_ancestors.array_get(var_ancestors.array_count() - 1)
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))) {
		mut switch_val_2 := rt.get_property(var_appliedTo, 'operation')
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('query'))) {
			return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.query()).str()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mutation'))) {
			return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.mutation()).str()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('subscription'))) {
			return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.subscription()).str()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.field()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.fragment_spread()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.inline_fragment()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.fragment_definition()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.variable_definition()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.schema()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.scalar()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.object()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.field_definition()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.iface()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.union()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.enum()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.enum_value()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.input_object()).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(var_appliedTo, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode')))) {
		mut var_parentNode := var_ancestors.array_get(var_ancestors.array_count() - 3)
		return (if rt.is_true(rt.new_bool(rt.instance_of(var_parentNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode'))) { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.input_field_definition() } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation.argument_definition() }).str()
	} else {
		mut var_unknownLocation := rt.call_function('get_class', [var_appliedTo.dup()])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_validator_rules_exception(rt.new_string("Unknown directive location: ${var_unknownLocation.to_string()}."))))
	}
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.misplaceddirectivemessage(directiveName string, location string) string {
	return "Directive \"${var_directiveName}\" may not be used on \"${var_location}\"."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_knowndirectives() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_exception() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'getASTVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getastvisitor(mut dispatch_arg_0)
		}
		'unknownDirectiveMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.unknowndirectivemessage(dispatch_arg_0))
		}
		'getDirectiveLocationForASTPath' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getdirectivelocationforastpath(mut dispatch_arg_0))
		}
		'misplacedDirectiveMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives.misplaceddirectivemessage(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownDirectives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_knowndirectives_php() {
	// unsupported statement: Stmt_Declare
}
