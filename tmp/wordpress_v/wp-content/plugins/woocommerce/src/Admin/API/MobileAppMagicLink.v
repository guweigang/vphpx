import rt

struct Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('mobile-app')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/send-magic-link', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MobileAppMagicLink', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'send_magic_link' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MobileAppMagicLink', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MobileAppMagicLink', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller.register_routes()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink) send_magic_link() rt.PhpVal {
	if rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Manager.class()])) {
		mut var_jetpack_connection_manager := create_automattic_jetpack_connection_manager()
		if rt.is_true(var_jetpack_connection_manager.is_active()) {
			if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack_IXR_Client')])) {
				mut var_xml := create_automattic_woocommerce_admin_api_jetpack_ixr_client(rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }]))
				var_xml.query(rt.new_string('jetpack.sendMobileMagicLink'), rt.create_array([rt.ArrayItem{ key: 'app', val: 'woocommerce' }]))
				if rt.is_true(var_xml.iserror()) {
					return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('error_sending_mobile_magic_link'), rt.call_function('sprintf', [rt.new_string('%s: %s'), var_xml.geterrorcode(), var_xml.geterrormessage()]))
				}
				return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'success' }])])
			}
		}
	}
	return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('jetpack_not_connected'), rt.call_function('__', [rt.new_string('Jetpack is not connected.'), rt.new_string('woocommerce')]))
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_mobileappmagiclink() &Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('mobile-app')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager() &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_jetpack_ixr_client() &Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'send_magic_link' {
			return this.send_magic_link()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MobileAppMagicLink) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Jetpack_IXR_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_mobileappmagiclink_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
