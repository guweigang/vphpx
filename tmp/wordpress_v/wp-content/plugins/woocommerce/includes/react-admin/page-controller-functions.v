import rt

fn wc_admin_connect_page(var_options rt.PhpVal) {
	mut var_controller := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}()
	rt.call_method(var_controller, 'connect_page', [var_options.dup()])
}

fn wc_admin_register_page(var_options rt.PhpVal) {
	mut var_controller := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}()
	rt.call_method(var_controller, 'register_page', [var_options.dup()])
}

fn wc_admin_is_connected_page() rt.PhpVal {
	mut var_controller := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}()
	return rt.call_method(var_controller, 'is_connected_page', []rt.PhpVal{})
}

fn wc_admin_is_registered_page() rt.PhpVal {
	mut var_controller := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}()
	return rt.call_method(var_controller, 'is_registered_page', []rt.PhpVal{})
}

fn wc_admin_get_breadcrumbs() rt.PhpVal {
	mut var_controller := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_PageController{}
		return temp.get_instance()
	}()
	return rt.call_method(var_controller, 'get_breadcrumbs', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
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

pub fn init_wp_content_plugins_woocommerce_includes_react_admin_page_controller_functions_php() {
}
