import rt

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException {
	rt.PhpObjectBase
pub mut:
	error_code      rt.PhpVal = rt.new_null()
	additional_data rt.PhpVal = rt.new_array()
	error           rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) construct(var_error_code rt.PhpVal, var_error rt.PhpVal, var_additional_data rt.PhpVal) {
	this.error_code = var_error_code.clone()
	this.error = var_error.clone()
	this.additional_data = rt.call_function('array_filter', [
		rt.cast_array(var_additional_data),
	])
	this.Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception.construct(rt.new_string(''),
		rt.new_int(409))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) geterrorcode() rt.PhpVal {
	return this.error_code
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) geterror() rt.PhpVal {
	return this.error
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) getadditionaldata() rt.PhpVal {
	return this.additional_data
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_exceptions_invalidstocklevelsincartexception(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException{
		PhpObjectBase:   rt.PhpObjectBase{}
		error_code:      rt.new_null()
		additional_data: rt.new_array()
		error:           rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'getErrorCode' {
			return this.geterrorcode()
		}
		'getError' {
			return this.geterror()
		}
		'getAdditionalData' {
			return this.getadditionaldata()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error_code' { return this.error_code }
		'additional_data' { return this.additional_data }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_InvalidStockLevelsInCartException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error_code' {
			this.error_code = val
			return true
		}
		'additional_data' {
			this.additional_data = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
