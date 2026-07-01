import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_parameterexception() &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_data_exception() &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_parameterexception_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
