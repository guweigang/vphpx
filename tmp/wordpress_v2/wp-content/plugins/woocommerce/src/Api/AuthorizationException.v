import rt

struct Class_Automattic_WooCommerce_Api_AuthorizationException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_AuthorizationException) construct(message string, mut var_previous Class_Automattic_WooCommerce_Api_?Throwable) {
	this.Class_Automattic_WooCommerce_Api_ApiException.construct(rt.new_string(message), rt.new_string('UNAUTHORIZED'), rt.new_array(), rt.new_int(401), rt.new_object('Automattic_WooCommerce_Api_?Throwable', []string{}, var_previous))
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_authorizationexception(message string, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Api_AuthorizationException {
	mut obj := &Class_Automattic_WooCommerce_Api_AuthorizationException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(message, arg_1)
	return obj
}

fn create_automattic_woocommerce_api_apiexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_?Throwable](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_AuthorizationException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
