import rt

struct Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper.is_connected() bool {
	mut var_helper_options := rt.call_function('get_option', [
		rt.new_string('woocommerce_helper_data'),
		rt.new_array(),
	])
	if var_helper_options.clone().is_array()
		&& rt.is_true(rt.new_bool(var_helper_options.clone().array_isset(rt.new_string('auth'))))
		&& !(!rt.is_true(var_helper_options.array_get(rt.new_string('auth')))) {
		return true
	}
	return false
}

fn create_automattic_woocommerce_internal_wccom_connectionhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_connected' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper.is_connected())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
