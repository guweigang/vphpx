import rt

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) construct() {
	this.Class_WC_Data_Exception.construct(rt.new_string('woocommerce_invalid_push_token'),
		rt.new_string('Push token could not be found.'), Class_WP_Http.not_found())
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception() &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_data_exception(_args ...rt.PhpVal) &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
