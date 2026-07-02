import rt

fn wc_admin_connect_page(var_options rt.PhpVal) {
	mut var_controller := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_controller = iife_result_0
	rt.call_method(var_controller, 'connect_page', [var_options.clone()])
}

fn wc_admin_register_page(var_options rt.PhpVal) {
	mut var_controller := rt.new_null()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_1 := iife_temp_1.get_instance()
	var_controller = iife_result_1
	rt.call_method(var_controller, 'register_page', [var_options.clone()])
}

fn wc_admin_is_connected_page() rt.PhpVal {
	mut var_controller := rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_controller = iife_result_2
	return rt.call_method(var_controller, 'is_connected_page', []rt.PhpVal{})
}

fn wc_admin_is_registered_page() rt.PhpVal {
	mut var_controller := rt.new_null()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_3 := iife_temp_3.get_instance()
	var_controller = iife_result_3
	return rt.call_method(var_controller, 'is_registered_page', []rt.PhpVal{})
}

fn wc_admin_get_breadcrumbs() rt.PhpVal {
	mut var_controller := rt.new_null()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_4 := iife_temp_4.get_instance()
	var_controller = iife_result_4
	return rt.call_method(var_controller, 'get_breadcrumbs', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
