import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_string('The `Boolean` scalar type represents `true` or `false`.')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) serialize(var_value rt.PhpVal) bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) parsevalue(var_value rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_value.dup().is_bool())) {
		return (var_value).to_bool()
	}
	mut var_notBoolean := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(var_value.dup())
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Boolean cannot represent a non boolean value: ${var_notBoolean.to_string()}"))))
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) parseliteral(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode'))) {
		return (rt.get_property(var_valueNode, 'value')).to_bool()
	}
	mut var_notBoolean := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode))
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Boolean cannot represent a non boolean value: ${var_notBoolean.to_string()}"), var_valueNode.dup())))
	return false
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_booleantype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		description: rt.new_string('The `Boolean` scalar type represents `true` or `false`.')
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_scalartype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType{
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

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.serialize(dispatch_arg_0))
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.parsevalue(dispatch_arg_0))
		}
		'parseLiteral' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.parseliteral(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BooleanType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'description' { this.description = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_booleantype_php() {
	// unsupported statement: Stmt_Declare
}
