import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames {
	rt.PhpObjectBase
pub mut:
		knownOperationNames rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.knownOperationNames = rt.new_array()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_operationName := rt.get_property(var_node, 'name')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !(this.knownOperationNames.array_isset(rt.get_property(var_operationName, 'value'))) {
			this.knownOperationNames.array_set(rt.get_property(var_operationName, 'value'), var_operationName.dup())
		} else {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames.duplicateoperationnamemessage((rt.get_property(var_operationName, 'value')).str()), rt.create_array([rt.ArrayItem{ key: none, val: this.knownOperationNames.array_get(rt.get_property(var_operationName, 'value')) }, rt.ArrayItem{ key: none, val: var_operationName }])))
		}
	}
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition(), val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.fragment_definition(), val: rt.new_closure(closure_2_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames.duplicateoperationnamemessage(operationName string) string {
	return "There can be only one operation named \"${var_operationName}\"."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniqueoperationnames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames{
		PhpObjectBase: rt.PhpObjectBase{}
		knownOperationNames: rt.new_null()
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

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'duplicateOperationNameMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames.duplicateoperationnamemessage(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'knownOperationNames' { return this.knownOperationNames }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'knownOperationNames' { this.knownOperationNames = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniqueoperationnames_php() {
	// unsupported statement: Stmt_Declare
}
