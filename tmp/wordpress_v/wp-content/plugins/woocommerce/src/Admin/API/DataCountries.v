import rt

struct Class_Automattic_WooCommerce_Admin_API_DataCountries {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DataCountries) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_DataCountries', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller'], &this), 'rest_base')).str() + '/locales', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_DataCountries', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_locales' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_DataCountries', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_DataCountries', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller.register_routes()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DataCountries) get_locales() rt.PhpVal {
	mut var_locales := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [var_locales.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_datacountries() &Class_Automattic_WooCommerce_Admin_API_DataCountries {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_DataCountries{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_countries_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DataCountries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_locales' {
			return this.get_locales()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_DataCountries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_DataCountries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Countries_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_datacountries_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
