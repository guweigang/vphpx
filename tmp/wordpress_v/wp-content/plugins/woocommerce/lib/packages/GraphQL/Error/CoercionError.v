import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError {
	rt.PhpObjectBase
pub mut:
		inputPath rt.PhpVal = rt.new_null()
		invalidValue rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError.make(message string, mut var_inputPath Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array, var_invalidValue rt.PhpVal, mut var_previous Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable) rt.PhpVal {
	mut var_instance := create_automattic_woocommerce_vendor_graphql_error_static(rt.new_string(message).dup(), rt.new_null(), rt.new_null(), rt.new_array(), rt.new_null(), var_previous.dup())
	rt.set_property(var_instance, 'inputPath', var_inputPath.dup())
	rt.set_property(var_instance, 'invalidValue', var_invalidValue.dup())
	return mut var_instance
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) printinputpath() string {
	if rt.is_true(rt.identical(this.inputPath, rt.new_null())) {
		return (rt.new_null()).str()
	}
	mut var_path := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := this.inputPath.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return (var_path).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) printinvalidvalue() string {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(this.invalidValue)).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_coercionerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError{
		PhpObjectBase: rt.PhpObjectBase{}
		inputPath: rt.new_null()
		invalidValue: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_static() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'make' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Error_?Throwable](if args.len > 3 { args[3] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError.make(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'printInputPath' {
			return rt.new_string(this.printinputpath())
		}
		'printInvalidValue' {
			return rt.new_string(this.printinvalidvalue())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'inputPath' { return this.inputPath }
		'invalidValue' { return this.invalidValue }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_CoercionError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'inputPath' { this.inputPath = val; return true }
		'invalidValue' { this.invalidValue = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_error_coercionerror_php() {
	// unsupported statement: Stmt_Declare
}
