import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_string('The `String` scalar type represents textual data, represented as UTF-8\ncharacter sequences. The String type is most often used by Automattic\\WooCommerce\\Vendor\\GraphQL to\nrepresent free-form human-readable text.')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) serialize(var_value rt.PhpVal) string {
	mut var_canCast := rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_value.clone()])) || (var_value.clone().is_object() && rt.is_true(rt.call_function('method_exists', [var_value.clone(), rt.new_string('__toString')]))) || rt.is_true(rt.identical(var_value, rt.new_null())))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_canCast)))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafe(var_value.clone())
		mut var_notStringable := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.new_string("String cannot represent value: ${var_notStringable.to_string()}"))))
	}
	return (var_value).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) parsevalue(var_value rt.PhpVal) string {
	if !(var_value.clone().is_string()) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_1 := iife_temp_1.printsafejson(var_value.clone())
		mut var_notString := iife_result_1
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("String cannot represent a non string value: ${var_notString.to_string()}"))))
	}
	return (var_value).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) parseliteral(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array) string {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode'))) {
		return (rt.get_property(var_valueNode, 'value')).str()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
	mut iife_result_2 := iife_temp_2.doprint(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode))
	mut var_notString := iife_result_2
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("String cannot represent a non string value: ${var_notString.to_string()}"), var_valueNode)))
	return ''
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_stringtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		description: rt.new_string('The `String` scalar type represents textual data, represented as UTF-8\ncharacter sequences. The String type is most often used by Automattic\\WooCommerce\\Vendor\\GraphQL to\nrepresent free-form human-readable text.')
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_scalartype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType{
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

fn create_automattic_woocommerce_vendor_graphql_error_serializationerror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.serialize(dispatch_arg_0))
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parsevalue(dispatch_arg_0))
		}
		'parseLiteral' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.parseliteral(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_StringType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
