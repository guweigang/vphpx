import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	mut var_knownArgumentNamesOnDirectives := create_automattic_woocommerce_vendor_graphql_validator_rules_knownargumentnamesondirectives()
	closure_3_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_arg := rt.new_null()
	mut var_argDef := var_context.getargument()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_fieldDef := var_context.getfielddef()
	if rt.is_true(rt.identical(var_fieldDef, rt.new_null())) {
		return rt.new_null()
	}
	mut var_parentType := var_context.getparenttype()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parentType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')))))) {
		return rt.new_null()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_arg := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_arg, 'name')
	}
	mut var_arg := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_arg, 'name')
	}
	var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames.unknownargmessage((rt.get_property(rt.get_property(var_node, 'name'), 'value')).str(), (rt.get_property(var_fieldDef, 'name')).str(), (rt.get_property(var_parentType, 'name')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.suggestionlist(arg_0, arg_1) }(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.call_function('array_map', [rt.new_closure(closure_2_fn), rt.get_property(var_fieldDef, 'args')])))), rt.create_array([rt.ArrayItem{ key: none, val: var_node }])))
	return rt.new_null()
	}
	return rt.add(var_knownArgumentNamesOnDirectives.getvisitor(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context)), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.argument(), val: rt.new_closure(closure_3_fn) }]))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames.unknownargmessage(argName string, fieldName string, typeName string, mut var_suggestedArgs Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_message := rt.new_string(rt.new_string("Unknown argument \"${var_argName}\" on field \"${var_fieldName}\" of type \"${var_typeName}\"."))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_suggestions := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.quotedorlist(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array', []string{}, var_suggestedArgs))
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_message).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_knownargumentnames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames{
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_knownargumentnamesondirectives() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives{
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'unknownArgMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames.unknownargmessage(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_knownargumentnames_php() {
	// unsupported statement: Stmt_Declare
}
