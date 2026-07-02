import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception {
	rt.PhpObjectBase
pub mut:
	wp_error rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception.create_from_wp_error(mut var_wp_error Class_WP_Error) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception{}
	mut iife_result_0 := iife_temp_0.create()
	mut var_exception := rt.call_method(iife_result_0, 'withMessage', [
		var_wp_error.get_error_message(),
	])
	rt.set_property(var_exception, 'wp_error', var_wp_error)
	return var_exception.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) get_wp_error() rt.PhpVal {
	return this.wp_error
}

struct Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_validation_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		wp_error:      rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_unexpectedvalueexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create_from_wp_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Error](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception.create_from_wp_error(mut dispatch_arg_0)
		}
		'get_wp_error' {
			return this.get_wp_error()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wp_error' { return this.wp_error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Validation_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wp_error' {
			this.wp_error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
