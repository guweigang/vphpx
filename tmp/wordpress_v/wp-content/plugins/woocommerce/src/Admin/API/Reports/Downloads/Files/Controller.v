import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
		rest_base rt.PhpVal = rt.new_string('reports/downloads/files')
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_downloads_files_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
		rest_base: rt.new_string('reports/downloads/files')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_downloads_files_wc_rest_reports_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Files_WC_REST_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_downloads_files_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
