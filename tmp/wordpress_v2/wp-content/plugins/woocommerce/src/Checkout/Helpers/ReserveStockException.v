import rt

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException {
	rt.PhpObjectBase
pub mut:
	error_code rt.PhpVal = rt.new_null()
	error_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) construct(var_code rt.PhpVal, var_message rt.PhpVal, http_status_code i64, var_data rt.PhpVal) {
	this.error_code = var_code.clone()
	this.error_data = var_data.clone()
	this.Class_Automattic_WooCommerce_Checkout_Helpers_Exception.construct(var_message.clone(),
		rt.new_int(http_status_code))
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) geterrorcode() rt.PhpVal {
	return this.error_code
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) geterrordata() rt.PhpVal {
	return this.error_data
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_checkout_helpers_reservestockexception(http_status_code i64, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException{
		PhpObjectBase: rt.PhpObjectBase{}
		error_code:    rt.new_null()
		error_data:    rt.new_null()
	}
	obj.construct(http_status_code, arg_1, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_checkout_helpers_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_Exception {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'getErrorCode' {
			return this.geterrorcode()
		}
		'getErrorData' {
			return this.geterrordata()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error_code' { return this.error_code }
		'error_data' { return this.error_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error_code' {
			this.error_code = val
			return true
		}
		'error_data' {
			this.error_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
