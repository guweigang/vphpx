import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.max_int() i64 {
	return 2147483647
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.min_int() rt.PhpVal {
	return // unsupported expression: Expr_UnaryMinus
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_string('The `Int` scalar type represents non-fractional signed whole numeric\nvalues. Int can represent values between -(2^31) and 2^31 - 1. ')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) serialize(var_value rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_long())) && rt.is_true(rt.less_equal(var_value, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.max_int())))) && rt.is_true(rt.greater_equal(var_value, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.min_int())))) {
		return (var_value).to_i64()
	}
	mut var_float := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double())) || rt.is_true(rt.new_bool(var_value.dup().is_bool())))) { // unsupported expression: Expr_Cast_Double } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_float, rt.new_null())) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_notInt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_value.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.new_string("Int cannot represent non-integer value: ${var_notInt.to_string()}"))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_float, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.max_int())) || rt.is_true(rt.less(var_float, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.min_int())))) {
		mut var_outOfRangeInt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_value.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.new_string("Int cannot represent non 32-bit signed integer value: ${var_outOfRangeInt.to_string()}"))))
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) parsevalue(var_value rt.PhpVal) i64 {
	mut var_isInt := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_long())) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_double())) && rt.is_true(rt.identical(rt.call_function('floor', [var_value.dup()]), var_value))))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_isInt)))) {
		mut var_notInt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(var_value.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Int cannot represent non-integer value: ${var_notInt.to_string()}"))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_value, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.max_int())) || rt.is_true(rt.less(var_value, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.min_int())))) {
		mut var_outOfRangeInt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(var_value.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Int cannot represent non 32-bit signed integer value: ${var_outOfRangeInt.to_string()}"))))
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) parseliteral(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array) i64 {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode'))) {
		mut var_val := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_valueNode, 'value'), // unsupported expression: Expr_Cast_String)) && rt.is_true(rt.greater_equal(var_val, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.min_int())))) && rt.is_true(rt.less_equal(var_val, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType.max_int())))) {
			return (var_val).to_i64()
		}
	}
	mut var_notInt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode))
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Int cannot represent non-integer value: ${var_notInt.to_string()}"), var_valueNode.dup())))
	return i64(0)
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		description: rt.new_string('The `Int` scalar type represents non-fractional signed whole numeric\nvalues. Int can represent values between -(2^31) and 2^31 - 1. ')
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

fn create_automattic_woocommerce_vendor_graphql_error_serializationerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.serialize(dispatch_arg_0))
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.parsevalue(dispatch_arg_0))
		}
		'parseLiteral' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(this.parseliteral(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_IntType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_inttype_php() {
	// unsupported statement: Stmt_Declare
}
