import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	mut var_definedTypes := rt.new_array()
	mut iter_1 := rt.get_property(var_context.getdocument(), 'definitions').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_def := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_def,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode')))
		{
			var_definedTypes.array_push(rt.get_property(rt.call_method(var_def, 'getName',
				[]rt.PhpVal{}), 'value'))
		}
	}
	closure_2_fn := fn [var_context, var_definedTypes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var__1 := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_parent := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var__2 := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		mut var_ancestors := if args.len > 4 { args[4].clone() } else { rt.new_null() }
		mut var_typeName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
		mut var_schema := var_context.getschema()
		if rt.is_true(rt.call_function('in_array', [var_typeName.clone(),
			var_definedTypes.clone(), rt.new_bool(true)]))
		{
			return rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema, rt.new_null()))))
			&& rt.is_true(rt.call_method(var_schema, 'hasType', [var_typeName.clone()])) {
			return rt.new_null()
		}
		mut var_definitionNode := if !(var_ancestors.array_get(rt.new_int(2))).is_null() {
			var_ancestors.array_get(rt.new_int(2))
		} else {
			var_parent
		}
		mut var_isSDL := rt.new_bool(
			rt.is_true(rt.new_bool(rt.instance_of(var_definitionNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeSystemDefinitionNode')))
			|| rt.is_true(rt.new_bool(rt.instance_of(var_definitionNode, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeSystemExtensionNode'))))
		if rt.is_true(var_isSDL)
			&& rt.is_true(rt.call_function('in_array', [var_typeName.clone(), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_type_names(), rt.new_bool(true)])) {
			return rt.new_null()
		}
		mut var_existingTypesMap := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema,
			rt.new_null()))))
		{
			rt.call_method(var_schema, 'getTypeMap', []rt.PhpVal{})
		} else {
			rt.new_array()
		}
		mut var_typeNames := rt.create_array([
			rt.ArrayItem{ key: none, val: rt.func_array_keys(var_existingTypesMap.clone()) },
			rt.ArrayItem{ key: none, val: var_definedTypes },
		])
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_1 := iife_temp_1.suggestionlist(var_typeName.clone(), if rt.is_true(var_isSDL) { rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.built_in_type_names()
				},
				rt.ArrayItem{ key: none, val: var_typeNames },
			]) } else { var_typeNames })
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames.unknowntypemessage(var_typeName.str(), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](iife_result_1)), rt.create_array([
			rt.ArrayItem{ key: none, val: var_node },
		])))
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.named_type()
			val: rt.new_closure(closure_2_fn)
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames.unknowntypemessage(type string, mut var_suggestedTypes Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_message := rt.new_string("Unknown type \"${var_type}\".")
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestedTypes, rt.new_array())))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_2 := iife_temp_2.quotedorlist(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array',
			[]string{}, var_suggestedTypes))
		mut var_suggestionList := iife_result_2
		var_message = rt.concat(var_message,
			rt.new_string(' Did you mean ${var_suggestionList.to_string()}?'))
	}
	return var_message.str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_knowntypenames(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'getASTVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getastvisitor(mut dispatch_arg_0)
		}
		'unknownTypeMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames.unknowntypemessage(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownTypeNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
