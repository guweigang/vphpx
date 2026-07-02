import rt

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) construct(message string, error_code string, mut var_extensions Class_Automattic_WooCommerce_Api_array, status_code i64, mut var_previous Class_Automattic_WooCommerce_Api_?Throwable) {
	this.Class_Automattic_WooCommerce_Api_RuntimeException.construct(rt.new_string(message), rt.new_int(status_code), rt.new_object('Automattic_WooCommerce_Api_?Throwable', []string{}, var_previous))
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) geterrorcode() string {
	return (rt.get_property(rt.new_object('Automattic_WooCommerce_Api_ApiException', ['Automattic_WooCommerce_Api_RuntimeException'], &this), 'error_code')).str()
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) getextensions() rt.PhpVal {
	return rt.get_property(rt.new_object('Automattic_WooCommerce_Api_ApiException', ['Automattic_WooCommerce_Api_RuntimeException'], &this), 'extensions')
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) getstatuscode() i64 {
	return (this.getcode()).to_i64()
}

struct Class_Automattic_WooCommerce_Api_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_apiexception(message string, error_code string, arg_2 rt.PhpVal, status_code i64, arg_4 rt.PhpVal) &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(message, error_code, arg_2, status_code, arg_4)
	return obj
}

fn create_automattic_woocommerce_api_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Api_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_?Throwable](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'getErrorCode' {
			return rt.new_string(this.geterrorcode())
		}
		'getExtensions' {
			return this.getextensions()
		}
		'getStatusCode' {
			return rt.new_int(this.getstatuscode())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
