import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	rt.PhpObjectBase
pub mut:
	error_code      string
	additional_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) construct(error_code string, message string, http_status_code i64, mut var_additional_data Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_array) {
	this.error_code = error_code
	this.additional_data = rt.call_function('array_filter', [
		rt.cast_array(var_additional_data),
	])
	this.Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception.construct(rt.new_string(message),
		rt.new_int(http_status_code))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) geterrorcode() string {
	return this.error_code
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) getadditionaldata() rt.PhpVal {
	return this.additional_data
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(error_code string, message string, http_status_code i64, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException{
		PhpObjectBase:   rt.PhpObjectBase{}
		error_code:      ''
		additional_data: rt.new_array()
	}
	obj.construct(error_code, message, http_status_code, arg_3)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'getErrorCode' {
			return rt.new_string(this.geterrorcode())
		}
		'getAdditionalData' {
			return this.getadditionaldata()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error_code' { return rt.new_string(this.error_code) }
		'additional_data' { return this.additional_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error_code' {
			this.error_code = val.str()
			return true
		}
		'additional_data' {
			this.additional_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
