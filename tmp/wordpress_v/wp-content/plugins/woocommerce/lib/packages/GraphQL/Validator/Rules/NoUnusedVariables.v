import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables {
	rt.PhpObjectBase
pub mut:
		variableDefs rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.variableDefs = rt.new_array()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	this.variableDefs = rt.new_array()
	return rt.new_null()
	}
	mut var_operation := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_variableNameUsed := rt.new_array()
	mut var_usages := var_context.getrecursivevariableusages(var_operation.dup())
	mut var_opName := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.get_property(rt.get_property(var_operation, 'name'), 'value') } else { rt.new_null() }
	{
		mut iter_1 := var_usages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_usage := item_1.val
			mut var_node := var_usage.array_get('node')
			var_variableNameUsed.array_set(rt.get_property(rt.get_property(var_node, 'name'), 'value'), true)
		}
	}
	{
		mut iter_1 := this.variableDefs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_variableDef := item_1.val
			mut var_variableName := rt.get_property(rt.get_property(rt.get_property(var_variableDef, 'variable'), 'name'), 'value')
			if !(var_variableNameUsed.array_isset(var_variableName)) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables.unusedvariablemessage((var_variableName).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string](var_opName)), rt.create_array([rt.ArrayItem{ key: none, val: var_variableDef }])))
			}
		}
	}
	return rt.new_null()
	}
	mut var_def := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.variableDefs.array_push(var_def.dup())
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition(), val: rt.create_array([rt.ArrayItem{ key: 'enter', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_2_fn) }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition(), val: rt.new_closure(closure_3_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables.unusedvariablemessage(varName string, mut var_opName Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string) string {
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Variable "$'), rt.new_string(varName)), rt.new_string('" is never used in operation "')), var_opName), rt.new_string('".')) } else { rt.concat(rt.concat(rt.new_string('Variable "$'), rt.new_string(varName)), rt.new_string('" is never used.')) }
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_nounusedvariables() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables{
		PhpObjectBase: rt.PhpObjectBase{}
		variableDefs: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'unusedVariableMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables.unusedvariablemessage(dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'variableDefs' { return this.variableDefs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_NoUnusedVariables) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'variableDefs' { this.variableDefs = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_nounusedvariables_php() {
	// unsupported statement: Stmt_Declare
}
