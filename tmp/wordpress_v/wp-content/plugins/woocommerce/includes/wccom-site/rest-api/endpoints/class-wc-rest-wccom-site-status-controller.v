import rt

struct Class_WC_REST_WCCOM_Site_Status_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('status')
}

fn (mut this Class_WC_REST_WCCOM_Site_Status_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_WCCOM_Site_Status_Controller', ['WC_REST_WCCOM_Site_Controller'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Status_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'handle_status_request' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_WCCOM_Site_Status_Controller', ['WC_REST_WCCOM_Site_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_permission' }]) }]) }])])
}

fn (mut this Class_WC_REST_WCCOM_Site_Status_Controller) user_has_permission(var_user rt.PhpVal) bool {
	return rt.is_true(rt.call_function('user_can', [var_user.dup(), rt.new_string('install_plugins')])) && rt.is_true(rt.call_function('user_can', [var_user.dup(), rt.new_string('activate_plugins')]))
}

fn (mut this Class_WC_REST_WCCOM_Site_Status_Controller) handle_status_request(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'wc_version', val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') }, rt.ArrayItem{ key: 'woo_update_manager_installed', val: fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_installed() }() }, rt.ArrayItem{ key: 'woo_update_manager_active', val: fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_active() }() }]) }])])
}

struct Class_WC_REST_WCCOM_Site_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_status_controller() &Class_WC_REST_WCCOM_Site_Status_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Status_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('status')
	}
	return obj
}

fn create_wc_rest_wccom_site_controller() &Class_WC_REST_WCCOM_Site_Controller {
	mut obj := &Class_WC_REST_WCCOM_Site_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_woo_update_manager_plugin() &Class_WC_Woo_Update_Manager_Plugin {
	mut obj := &Class_WC_Woo_Update_Manager_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Status_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'user_has_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.user_has_permission(dispatch_arg_0))
		}
		'handle_status_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.handle_status_request(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_WCCOM_Site_Status_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_WCCOM_Site_Status_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Woo_Update_Manager_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Woo_Update_Manager_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_rest_api_endpoints_class_wc_rest_wccom_site_status_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
