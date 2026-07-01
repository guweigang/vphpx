import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_schema := var_context.getschema()
	mut var_definedOperationTypes := rt.new_array()
	mut var_existingOperationTypes := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.create_array([rt.ArrayItem{ key: 'query', val: rt.call_method(var_schema, 'getQueryType', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'mutation', val: rt.call_method(var_schema, 'getMutationType', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'subscription', val: rt.call_method(var_schema, 'getSubscriptionType', []rt.PhpVal{}) }]) } else { rt.new_array() }
	closure_1_fn := fn [var_context, mut var_definedOperationTypes, var_existingOperationTypes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	{
		mut iter_1 := rt.get_property(var_node, 'operationTypes').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_operationType := item_1.val
			mut var_operation := rt.get_property(var_operationType, 'operation')
			mut var_alreadyDefinedOperationType := if !(var_definedOperationTypes.array_get(var_operation)).is_null() { var_definedOperationTypes.array_get(var_operation) } else { rt.new_null() }
			if var_existingOperationTypes.array_isset(var_operation) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Type for ${var_operation.to_string()} already defined in the schema. It cannot be redefined."), var_operationType.dup()))
			} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("There can be only one ${var_operation.to_string()} type in schema."), rt.create_array([rt.ArrayItem{ key: none, val: var_alreadyDefinedOperationType }, rt.ArrayItem{ key: none, val: var_operationType }])))
			} else {
				var_definedOperationTypes.array_set(var_operation, var_operationType.dup())
			}
		}
	}
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	mut var_checkOperationTypes := rt.new_closure(closure_1_fn)
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.schema_definition(), val: var_checkOperationTypes }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.schema_extension(), val: var_checkOperationTypes }])
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniqueoperationtypes() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueOperationTypes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniqueoperationtypes_php() {
	// unsupported statement: Stmt_Declare
}
