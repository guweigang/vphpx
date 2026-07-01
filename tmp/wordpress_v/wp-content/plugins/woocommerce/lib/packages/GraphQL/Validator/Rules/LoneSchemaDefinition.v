import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.schemadefinitionnotalonemessage() string {
	return 'Must provide only one schema definition.'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.cannotdefineschemawithinextensionmessage() string {
	return 'Cannot define a new schema within a schema extension.'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	mut var_oldSchema := var_context.getschema()
	mut var_alreadyDefined := rt.new_bool(if rt.is_true(rt.identical(var_oldSchema, rt.new_null())) { rt.new_bool(false) } else { rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)) })
	mut var_schemaDefinitionsCount := rt.new_int(rt.new_int(0))
	closure_1_fn := fn [var_alreadyDefined, var_context, mut var_schemaDefinitionsCount] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(var_alreadyDefined) {
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.cannotdefineschemawithinextensionmessage(), var_node.dup()))
		return rt.new_null()
	}
	if rt.is_true(rt.greater(var_schemaDefinitionsCount, rt.new_int(0))) {
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.schemadefinitionnotalonemessage(), var_node.dup()))
	}
	rt.pre_inc(var_schemaDefinitionsCount)
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.schema_definition(), val: rt.new_closure(closure_1_fn) }])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_loneschemadefinition() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'schemaDefinitionNotAloneMessage' {
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.schemadefinitionnotalonemessage())
		}
		'canNotDefineSchemaWithinExtensionMessage' {
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition.cannotdefineschemawithinextensionmessage())
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_LoneSchemaDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_loneschemadefinition_php() {
	// unsupported statement: Stmt_Declare
}
