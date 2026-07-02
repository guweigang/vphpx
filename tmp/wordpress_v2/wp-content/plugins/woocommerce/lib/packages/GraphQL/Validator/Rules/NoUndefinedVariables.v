import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	mut var_variableNameDefined := rt.new_array()
	closure_1_fn := fn [mut var_variableNameDefined] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		var_variableNameDefined = rt.new_array()
		return rt.new_null()
		}
	closure_2_fn := fn [mut var_variableNameDefined, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_operation := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_usages := var_context.getrecursivevariableusages(var_operation.clone())
		mut iter_1 := var_usages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_usage := item_1.val
			mut var_node := var_usage.array_get(rt.new_string('node'))
			mut var_varName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
			if !(var_variableNameDefined.array_isset(var_varName)) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables.undefinedvarmessage((var_varName).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string](if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_operation, 'name'), rt.new_null())))) { rt.get_property(rt.get_property(var_operation, 'name'), 'value') } else { rt.new_null() })), rt.create_array([rt.ArrayItem{ key: none, val: var_node }, rt.ArrayItem{ key: none, val: var_operation }])))
			}
		}
		return rt.new_null()
		}
	closure_3_fn := fn [mut var_variableNameDefined] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_def := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_variableNameDefined.array_set(rt.get_property(rt.get_property(rt.get_property(var_def, 'variable'), 'name'), 'value'), true)
		return rt.new_null()
		}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition(), val: rt.create_array([rt.ArrayItem{ key: 'enter', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_2_fn) }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition(), val: rt.new_closure(closure_3_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables.undefinedvarmessage(varName string, mut var_opName Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string) string {
	return if rt.is_true(rt.identical(var_opName, rt.new_null())) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), rt.new_string(varName)), rt.new_string('" is not defined by operation "')), var_opName), rt.new_string('".')) } else { rt.concat(rt.concat(rt.new_string('Variable "$'), rt.new_string(varName)), rt.new_string('" is not defined.')) }
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_noundefinedvariables(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'undefinedVarMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables.undefinedvarmessage(dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUndefinedVariables) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
