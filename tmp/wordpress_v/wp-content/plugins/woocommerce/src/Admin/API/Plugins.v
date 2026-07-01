import rt

struct Class_Automattic_WooCommerce_Admin_API_Plugins {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('plugins')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/install', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'install_plugins' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/install/status', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_installation_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/install/status/(?P<job_id>[a-z0-9_\\-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_job_installation_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/active', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'active_plugins' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/installed', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'installed_plugins' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/activate', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'activate_plugins' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/activate/status', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_activation_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/activate/status/(?P<job_id>[a-z0-9_\\-]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_job_activation_status' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/connect-jetpack', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'connect_jetpack' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_connect_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/request-wccom-connect', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'request_wccom_connect' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_connect_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/finish-wccom-connect', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'finish_wccom_connect' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_connect_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/connect-wcpay', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'connect_wcpay' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_connect_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/connect-square', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'connect_square' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_connect_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) install_plugin(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.call_function('wc_deprecated_function', [rt.new_string('install_plugin'), rt.new_string('4.3'), rt.new_string('\\Automattic\\WooCommerce\\Admin\\API\\Plugins()->install_plugins')])
	var_request_mutated.array_set('plugins', var_request_mutated.array_get('plugin'))
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Plugins{}; return temp.install_plugins(arg_0) }(var_request_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) install_plugins(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_plugins := rt.call_function('explode', [rt.new_string(','), var_request_mutated.array_get('plugins')])
	mut var_source := if !(!rt.is_true(var_request_mutated.array_get('source'))) { var_request_mutated.array_get('source') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!rt.is_true(var_request_mutated.array_get('plugins')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugins.dup().is_array()))))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_isset(rt.new_string('async')) && rt.is_true(var_request_mutated.array_get('async')))) {
		mut var_job_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.schedule_install_plugins(arg_0) }(var_plugins.dup())
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'job_id', val: var_job_id }, rt.ArrayItem{ key: 'plugins', val: var_plugins }]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Plugin installation has been scheduled.'), rt.new_string('woocommerce')]) }])
	}
	mut var_data := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.install_plugins(arg_0, arg_1, arg_2) }(var_plugins.dup(), rt.new_null(), var_source.dup())
	mut var_plugin_details := rt.new_array()
	if rt.is_true(rt.new_bool(var_data.array_get('installed').is_array())) {
		{
			mut iter_1 := var_data.array_get('installed').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin_slug := item_1.val
				mut var_plugin_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_plugin_data(arg_0) }(var_plugin_slug.dup())
				if !rt.is_true(var_plugin_data) {
					continue
				}
				var_plugin_details.array_set(var_plugin_slug, rt.create_array([rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get('Name') }, rt.ArrayItem{ key: 'description', val: var_plugin_data.array_get('Description') }, rt.ArrayItem{ key: 'uri', val: var_plugin_data.array_get('PluginURI') }, rt.ArrayItem{ key: 'version', val: var_plugin_data.array_get('Version') }]))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'installed', val: var_data.array_get('installed') }, rt.ArrayItem{ key: 'results', val: var_data.array_get('results') }, rt.ArrayItem{ key: 'install_time', val: var_data.array_get('time') }, rt.ArrayItem{ key: 'plugin_details', val: var_plugin_details }]) }, rt.ArrayItem{ key: 'errors', val: var_data.array_get('errors') }, rt.ArrayItem{ key: 'success', val: rt.new_bool(rt.get_property(var_data.array_get('errors'), 'errors').array_count() == 0) }, rt.ArrayItem{ key: 'message', val: if rt.get_property(var_data.array_get('errors'), 'errors').array_count() == 0 { rt.call_function('__', [rt.new_string('Plugins were successfully installed.'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('There was a problem installing some of the requested plugins.'), rt.new_string('woocommerce')]) } }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_installation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installation_status() }()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_job_installation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_job_id := rt.call_method(var_request_mutated, 'get_param', [rt.new_string('job_id')])
	mut var_jobs := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installation_status(arg_0) }(var_job_id.dup())
	return rt.call_function('reset', [var_jobs.dup()])
}

fn Class_Automattic_WooCommerce_Admin_API_Plugins.active_plugins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'plugins', val: rt.call_function('array_values', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_active_plugin_slugs() }()]) }])
}

fn Class_Automattic_WooCommerce_Admin_API_Plugins.get_active_plugins() rt.PhpVal {
	mut var_data := Class_Automattic_WooCommerce_Admin_API_Plugins.active_plugins()
	return var_data.array_get('plugins')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) installed_plugins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'plugins', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installed_plugin_slugs() }() }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) activate_plugins(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_plugins := rt.call_function('explode', [rt.new_string(','), var_request_mutated.array_get('plugins')])
	if rt.is_true(rt.new_bool(!rt.is_true(var_request_mutated.array_get('plugins')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugins.dup().is_array()))))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_isset(rt.new_string('async')) && rt.is_true(var_request_mutated.array_get('async')))) {
		mut var_job_id := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.schedule_activate_plugins(arg_0) }(var_plugins.dup())
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'job_id', val: var_job_id }, rt.ArrayItem{ key: 'plugins', val: var_plugins }]) }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Plugin activation has been scheduled.'), rt.new_string('woocommerce')]) }])
	}
	mut var_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.activate_plugins(arg_0) }(var_plugins.dup())
	mut var_plugin_details := rt.new_array()
	if rt.is_true(rt.new_bool(var_data.array_get('activated').is_array())) {
		{
			mut iter_1 := var_data.array_get('activated').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin_slug := item_1.val
				mut var_plugin_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_plugin_data(arg_0) }(var_plugin_slug.dup())
				if !rt.is_true(var_plugin_data) {
					continue
				}
				var_plugin_details.array_set(var_plugin_slug, rt.create_array([rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get('Name') }, rt.ArrayItem{ key: 'description', val: var_plugin_data.array_get('Description') }, rt.ArrayItem{ key: 'uri', val: var_plugin_data.array_get('PluginURI') }, rt.ArrayItem{ key: 'version', val: var_plugin_data.array_get('Version') }]))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: 'activated', val: var_data.array_get('activated') }, rt.ArrayItem{ key: 'active', val: var_data.array_get('active') }, rt.ArrayItem{ key: 'plugin_details', val: var_plugin_details }]) }, rt.ArrayItem{ key: 'errors', val: var_data.array_get('errors') }, rt.ArrayItem{ key: 'success', val: rt.new_bool(rt.get_property(var_data.array_get('errors'), 'errors').array_count() == 0) }, rt.ArrayItem{ key: 'message', val: if rt.get_property(var_data.array_get('errors'), 'errors').array_count() == 0 { rt.call_function('__', [rt.new_string('Plugins were successfully activated.'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('There was a problem activating some of the requested plugins.'), rt.new_string('woocommerce')]) } }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_activation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_activation_status() }()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_job_activation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_job_id := rt.call_method(var_request_mutated, 'get_param', [rt.new_string('job_id')])
	mut var_jobs := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_activation_status(arg_0) }(var_job_id.dup())
	return rt.call_function('reset', [var_jobs.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_jetpack(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Jetpack')]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_jetpack_not_active'), rt.call_function('__', [rt.new_string('Jetpack is not installed or active.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	mut var_redirect_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_jetpack_connect_redirect_url'), rt.call_function('esc_url_raw', [var_request_mutated.array_get('redirect_url')])])
	mut var_connect_url := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Jetpack{}; return temp.init() }(), 'build_connect_url', [rt.new_bool(true), var_redirect_url.dup(), rt.new_string('woocommerce-onboarding')])
	mut var_calypso_env := if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_CALYPSO_ENVIRONMENT')])) && rt.is_true(rt.call_function('in_array', [rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT'), rt.create_array([rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{ key: none, val: 'wpcalypso' }, rt.ArrayItem{ key: none, val: 'horizon' }, rt.ArrayItem{ key: none, val: 'stage' }]), rt.new_bool(true)])))) { rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT') } else { rt.new_string('production') }
	var_connect_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'calypso_env', val: var_calypso_env }]), var_connect_url.dup()])
	return rt.create_array([rt.ArrayItem{ key: 'slug', val: 'jetpack' }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Jetpack'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'connectAction', val: var_connect_url }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) request_wccom_connect() rt.PhpVal {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-api.php', '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Helper_API')]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_not_active'), rt.call_function('__', [rt.new_string('There was an error loading the WooCommerce.com Helper API.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	mut var_redirect_uri := rt.call_function('wc_admin_url', [rt.new_string('&task=connect&wccom-connected=1')])
	mut var_request := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}; return temp.post(arg_0, arg_1) }(rt.new_string('oauth/request_token'), rt.create_array([rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'redirect_uri', val: var_redirect_uri }]) }]))
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	mut var_secret := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.dup()])])
	if !rt.is_true(var_secret) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connect_start')])
	mut var_connect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('rawurlencode', [rt.call_function('home_url', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'redirect_uri', val: rt.call_function('rawurlencode', [var_redirect_uri.dup()]) }, rt.ArrayItem{ key: 'secret', val: rt.call_function('rawurlencode', [var_secret.dup()]) }, rt.ArrayItem{ key: 'wccom-from', val: 'onboarding' }]), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}; return temp.url(arg_0) }(rt.new_string('oauth/authorize'))])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_CALYPSO_ENVIRONMENT')])) && rt.is_true(rt.call_function('in_array', [rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT'), rt.create_array([rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{ key: none, val: 'wpcalypso' }, rt.ArrayItem{ key: none, val: 'horizon' }, rt.ArrayItem{ key: none, val: 'stage' }]), rt.new_bool(true)])))) {
		var_connect_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'calypso_env', val: rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT') }]), var_connect_url.dup()])
	}
	return rt.create_array([rt.ArrayItem{ key: 'connectAction', val: var_connect_url }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) finish_wccom_connect(var_rest_request rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-api.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-updater.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-options.php', '2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Helper_API')]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_not_active'), rt.call_function('__', [rt.new_string('There was an error loading the WooCommerce.com Helper API.'), rt.new_string('woocommerce')]), rt.new_int(404))
	}
	mut var_request := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}; return temp.post(arg_0, arg_1) }(rt.new_string('oauth/access_token'), rt.create_array([rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'request_token', val: rt.call_function('wp_unslash', [var_rest_request.array_get('request_token')]) }, rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) }]) }]))
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	mut var_access_token := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.dup()]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_access_token)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{}; return temp.update(arg_0, arg_1) }(rt.new_string('auth'), rt.create_array([rt.ArrayItem{ key: 'access_token', val: var_access_token.array_get('access_token') }, rt.ArrayItem{ key: 'access_token_secret', val: var_access_token.array_get('access_token_secret') }, rt.ArrayItem{ key: 'site_id', val: var_access_token.array_get('site_id') }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper{}; return temp._flush_authentication_cache() }())))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{}; return temp.update(arg_0, arg_1) }(rt.new_string('auth'), rt.new_array())
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	rt.call_function('delete_transient', [rt.new_string('_woocommerce_helper_subscriptions')])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater{}; return temp.flush_updates_cache() }()
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connected')])
	return rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_square() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WooCommerce\\Square\\Handlers\\Connection')]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [rt.new_string('There was an error connecting to Square.'), rt.new_string('woocommerce')]), rt.new_int(500))
	}
	mut var_has_cbd_industry := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_string('US'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}))) {
		mut var_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
		if !(!rt.is_true(var_profile.array_get('industry'))) {
			var_has_cbd_industry = 
		}
	}
	if rt.is_true(var_has_cbd_industry) {
		mut var_url := rt.new_string()
	} else {
		
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_wcpay() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_item_schema() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_connect_schema() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Jetpack {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_plugins() &Class_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('plugins')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
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

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_jetpack() &Class_Automattic_WooCommerce_Admin_API_Jetpack {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_api() &Class_Automattic_WooCommerce_Admin_API_WC_Helper_API {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_options() &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper() &Class_Automattic_WooCommerce_Admin_API_WC_Helper {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_updater() &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'install_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install_plugin(dispatch_arg_0)
		}
		'install_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install_plugins(dispatch_arg_0)
		}
		'get_installation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_installation_status(dispatch_arg_0)
		}
		'get_job_installation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_job_installation_status(dispatch_arg_0)
		}
		'active_plugins' {
			return Class_Automattic_WooCommerce_Admin_API_Plugins.active_plugins()
		}
		'get_active_plugins' {
			return Class_Automattic_WooCommerce_Admin_API_Plugins.get_active_plugins()
		}
		'installed_plugins' {
			return this.installed_plugins()
		}
		'activate_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.activate_plugins(dispatch_arg_0)
		}
		'get_activation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_activation_status(dispatch_arg_0)
		}
		'get_job_activation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_job_activation_status(dispatch_arg_0)
		}
		'connect_jetpack' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.connect_jetpack(dispatch_arg_0)
		}
		'request_wccom_connect' {
			return this.request_wccom_connect()
		}
		'finish_wccom_connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.finish_wccom_connect(dispatch_arg_0)
		}
		'connect_square' {
			return this.connect_square()
		}
		'connect_wcpay' {
			return this.connect_wcpay()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_connect_schema' {
			return this.get_connect_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_plugins_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
