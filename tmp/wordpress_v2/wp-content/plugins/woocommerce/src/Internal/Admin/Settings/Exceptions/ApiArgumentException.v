import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_exceptions_apiexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Exceptions_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
