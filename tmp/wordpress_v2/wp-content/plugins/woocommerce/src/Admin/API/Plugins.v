import rt

struct Class_Automattic_WooCommerce_Admin_API_Plugins {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('plugins')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) register_routes() {
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'install_plugins' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/install/status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_installation_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/install/status/(?P<job_id>[a-z0-9_\\-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_job_installation_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/active'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'active_plugins' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/installed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'installed_plugins' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/activate'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'activate_plugins' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/activate/status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_activation_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/activate/status/(?P<job_id>[a-z0-9_\\-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_job_activation_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/connect-jetpack'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'connect_jetpack' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_connect_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/request-wccom-connect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'POST' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'request_wccom_connect' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_connect_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/finish-wccom-connect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'POST' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'finish_wccom_connect' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_connect_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/connect-wcpay'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'connect_wcpay' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_connect_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/connect-square'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'connect_square' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Plugins', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_connect_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [
			rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) install_plugin(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.call_function('wc_deprecated_function', [rt.new_string('install_plugin'),
		rt.new_string('4.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Admin\\API\\Plugins()->install_plugins')])
	var_request_mutated.array_set('plugins', var_request_mutated.array_get(rt.new_string('plugin')))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Plugins{}
	mut iife_result_0 := iife_temp_0.install_plugins(var_request_mutated.clone())
	return iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) install_plugins(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_plugins := rt.call_function('explode', [rt.new_string(','),
		var_request_mutated.array_get(rt.new_string('plugins'))])
	mut var_source := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('source')))) {
		var_request_mutated.array_get(rt.new_string('source'))
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_request_mutated.array_get(rt.new_string('plugins')))
		|| !(var_plugins.clone().is_array()) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_plugins'), rt.call_function('__', [
			rt.new_string('Plugins must be a non-empty array.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))
	}
	if var_request_mutated.array_isset(rt.new_string('async'))
		&& rt.is_true(var_request_mutated.array_get(rt.new_string('async'))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
		mut iife_result_1 := iife_temp_1.schedule_install_plugins(var_plugins.clone())
		mut var_job_id := iife_result_1
		return rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: 'job_id', val: var_job_id },
				rt.ArrayItem{ key: 'plugins', val: var_plugins },
			]) },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Plugin installation has been scheduled.'),
				rt.new_string('woocommerce'),
			]) },
		])
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_2 := iife_temp_2.install_plugins(var_plugins.clone(), rt.new_null(),
		var_source.clone())
	mut var_data := iife_result_2
	mut var_plugin_details := rt.new_array()
	if rt.is_true(rt.new_bool(var_data.array_get(rt.new_string('installed')).is_array())) {
		mut iter_1 := var_data.array_get(rt.new_string('installed')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_slug := item_1.val
			mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_3 := iife_temp_3.get_plugin_data(var_plugin_slug.clone())
			mut var_plugin_data := iife_result_3
			if !rt.is_true(var_plugin_data) {
				continue
			}
			var_plugin_details.array_set(var_plugin_slug, rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get(rt.new_string('Name')) },
				rt.ArrayItem{
					key: 'description'
					val: var_plugin_data.array_get(rt.new_string('Description'))
				},
				rt.ArrayItem{ key: 'uri', val: var_plugin_data.array_get(rt.new_string('PluginURI')) },
				rt.ArrayItem{
					key: 'version'
					val: var_plugin_data.array_get(rt.new_string('Version'))
				},
			]))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'installed', val: var_data.array_get(rt.new_string('installed')) },
			rt.ArrayItem{ key: 'results', val: var_data.array_get(rt.new_string('results')) },
			rt.ArrayItem{ key: 'install_time', val: var_data.array_get(rt.new_string('time')) },
			rt.ArrayItem{ key: 'plugin_details', val: var_plugin_details },
		]) },
		rt.ArrayItem{ key: 'errors', val: var_data.array_get(rt.new_string('errors')) },
		rt.ArrayItem{ key: 'success', val: rt.new_bool(rt.get_property(var_data.array_get(rt.new_string('errors')),
			'errors').array_count() == 0) },
		rt.ArrayItem{
			key: 'message'
			val: if rt.get_property(var_data.array_get(rt.new_string('errors')), 'errors').array_count() == 0 { rt.call_function('__', [
					rt.new_string('Plugins were successfully installed.'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('There was a problem installing some of the requested plugins.'),
					rt.new_string('woocommerce'),
				]) }
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_installation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_4 := iife_temp_4.get_installation_status()
	return iife_result_4
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_job_installation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_job_id := rt.call_method(var_request_mutated, 'get_param', [
		rt.new_string('job_id'),
	])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_5 := iife_temp_5.get_installation_status(var_job_id.clone())
	mut var_jobs := iife_result_5
	return rt.call_function('reset', [var_jobs.clone()])
}

fn Class_Automattic_WooCommerce_Admin_API_Plugins.active_plugins() rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_6 := iife_temp_6.get_active_plugin_slugs()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_7 := iife_temp_7.get_active_plugin_slugs()
	return rt.create_array([
		rt.ArrayItem{ key: 'plugins', val: rt.call_function('array_values', [
			iife_result_6,
		]) },
	])
}

fn Class_Automattic_WooCommerce_Admin_API_Plugins.get_active_plugins() rt.PhpVal {
	mut var_data := Class_Automattic_WooCommerce_Admin_API_Plugins.active_plugins()
	return var_data.array_get(rt.new_string('plugins'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) installed_plugins() rt.PhpVal {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_8 := iife_temp_8.get_installed_plugin_slugs()
	return rt.create_array([rt.ArrayItem{ key: 'plugins', val: iife_result_8 }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) activate_plugins(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_plugins := rt.call_function('explode', [rt.new_string(','),
		var_request_mutated.array_get(rt.new_string('plugins'))])
	if !rt.is_true(var_request_mutated.array_get(rt.new_string('plugins')))
		|| !(var_plugins.clone().is_array()) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_plugins'), rt.call_function('__', [
			rt.new_string('Plugins must be a non-empty array.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))
	}
	if var_request_mutated.array_isset(rt.new_string('async'))
		&& rt.is_true(var_request_mutated.array_get(rt.new_string('async'))) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
		mut iife_result_9 := iife_temp_9.schedule_activate_plugins(var_plugins.clone())
		mut var_job_id := iife_result_9
		return rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: 'job_id', val: var_job_id },
				rt.ArrayItem{ key: 'plugins', val: var_plugins },
			]) },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Plugin activation has been scheduled.'),
				rt.new_string('woocommerce'),
			]) },
		])
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_10 := iife_temp_10.activate_plugins(var_plugins.clone())
	mut var_data := iife_result_10
	mut var_plugin_details := rt.new_array()
	if rt.is_true(rt.new_bool(var_data.array_get(rt.new_string('activated')).is_array())) {
		mut iter_2 := var_data.array_get(rt.new_string('activated')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_plugin_slug := item_2.val
			mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_11 := iife_temp_11.get_plugin_data(var_plugin_slug.clone())
			mut var_plugin_data := iife_result_11
			if !rt.is_true(var_plugin_data) {
				continue
			}
			var_plugin_details.array_set(var_plugin_slug, rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get(rt.new_string('Name')) },
				rt.ArrayItem{
					key: 'description'
					val: var_plugin_data.array_get(rt.new_string('Description'))
				},
				rt.ArrayItem{ key: 'uri', val: var_plugin_data.array_get(rt.new_string('PluginURI')) },
				rt.ArrayItem{
					key: 'version'
					val: var_plugin_data.array_get(rt.new_string('Version'))
				},
			]))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'activated', val: var_data.array_get(rt.new_string('activated')) },
			rt.ArrayItem{ key: 'active', val: var_data.array_get(rt.new_string('active')) },
			rt.ArrayItem{ key: 'plugin_details', val: var_plugin_details },
		]) },
		rt.ArrayItem{ key: 'errors', val: var_data.array_get(rt.new_string('errors')) },
		rt.ArrayItem{ key: 'success', val: rt.new_bool(rt.get_property(var_data.array_get(rt.new_string('errors')),
			'errors').array_count() == 0) },
		rt.ArrayItem{
			key: 'message'
			val: if rt.get_property(var_data.array_get(rt.new_string('errors')), 'errors').array_count() == 0 { rt.call_function('__', [
					rt.new_string('Plugins were successfully activated.'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('There was a problem activating some of the requested plugins.'),
					rt.new_string('woocommerce'),
				]) }
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_activation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_12 := iife_temp_12.get_activation_status()
	return iife_result_12
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_job_activation_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_job_id := rt.call_method(var_request_mutated, 'get_param', [
		rt.new_string('job_id'),
	])
	mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_13 := iife_temp_13.get_activation_status(var_job_id.clone())
	mut var_jobs := iife_result_13
	return rt.call_function('reset', [var_jobs.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_jetpack(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('\\Jetpack'),
	])))))
	{
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_jetpack_not_active'), rt.call_function('__', [
			rt.new_string('Jetpack is not installed or active.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))
	}
	mut var_redirect_url := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_onboarding_jetpack_connect_redirect_url'),
		rt.call_function('esc_url_raw',
			[var_request_mutated.array_get(rt.new_string('redirect_url'))]),
	])
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_API_Jetpack{}
	mut iife_result_14 := iife_temp_14.init()
	mut var_connect_url := rt.call_method(iife_result_14, 'build_connect_url', [
		rt.new_bool(true),
		var_redirect_url.clone(),
		rt.new_string('woocommerce-onboarding'),
	])
	mut var_calypso_env := if
		rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_CALYPSO_ENVIRONMENT')]))
		&& rt.is_true(rt.call_function('in_array', [rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'development'
	}, rt.ArrayItem{ key: none, val: 'wpcalypso' }, rt.ArrayItem{ key: none, val: 'horizon' }, rt.ArrayItem{
		key: none
		val: 'stage'
	}]), rt.new_bool(true)])) {
		rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT')
	} else {
		rt.new_string('production')
	}
	var_connect_url = rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'calypso_env', val: var_calypso_env }]),
		var_connect_url.clone(),
	])
	return rt.create_array([rt.ArrayItem{ key: 'slug', val: 'jetpack' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Jetpack'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'connectAction', val: var_connect_url }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) request_wccom_connect() rt.PhpVal {
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-api.php',
		'2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Helper_API'),
	])))))
	{
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_not_active'), rt.call_function('__', [
			rt.new_string('There was an error loading the WooCommerce.com Helper API.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))
	}
	mut var_redirect_uri := rt.call_function('wc_admin_url', [
		rt.new_string('&task=connect&wccom-connected=1'),
	])
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}
	mut iife_result_15 := iife_temp_15.post(rt.new_string('oauth/request_token'), rt.create_array([
		rt.ArrayItem{ key: 'body', val: rt.create_array([
			rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'redirect_uri', val: var_redirect_uri },
		]) },
	]))
	mut var_request := iife_result_15
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_request.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	mut var_secret := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_request.clone()]),
	])
	if !rt.is_true(var_secret) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connect_start')])
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}
	mut iife_result_16 := iife_temp_16.url(rt.new_string('oauth/authorize'))
	mut var_connect_url := rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{ key: 'home_url', val: rt.call_function('rawurlencode', [
				rt.call_function('home_url', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'redirect_uri', val: rt.call_function('rawurlencode', [
				var_redirect_uri.clone(),
			]) },
			rt.ArrayItem{ key: 'secret', val: rt.call_function('rawurlencode', [
				var_secret.clone(),
			]) },
			rt.ArrayItem{ key: 'wccom-from', val: 'onboarding' },
		]),
		iife_result_16,
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WOOCOMMERCE_CALYPSO_ENVIRONMENT')]))
		&& rt.is_true(rt.call_function('in_array', [rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'development'
	}, rt.ArrayItem{ key: none, val: 'wpcalypso' }, rt.ArrayItem{ key: none, val: 'horizon' }, rt.ArrayItem{
		key: none
		val: 'stage'
	}]), rt.new_bool(true)])) {
		var_connect_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{
					key: 'calypso_env'
					val: rt.get_constant('WOOCOMMERCE_CALYPSO_ENVIRONMENT')
				},
			]),
			var_connect_url.clone(),
		])
	}
	return rt.create_array([rt.ArrayItem{ key: 'connectAction', val: var_connect_url }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) finish_wccom_connect(var_rest_request rt.PhpVal) rt.PhpVal {
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper.php', '2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-api.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-updater.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/helper/class-wc-helper-options.php',
		'2')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Helper_API'),
	])))))
	{
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_not_active'), rt.call_function('__', [
			rt.new_string('There was an error loading the WooCommerce.com Helper API.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))
	}
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{}
	mut iife_result_17 := iife_temp_17.post(rt.new_string('oauth/access_token'), rt.create_array([
		rt.ArrayItem{ key: 'body', val: rt.create_array([
			rt.ArrayItem{ key: 'request_token', val: rt.call_function('wp_unslash', [
				var_rest_request.array_get(rt.new_string('request_token')),
			]) },
			rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) },
		]) },
	]))
	mut var_request := iife_result_17
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_request.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	mut var_access_token := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_request.clone()]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_access_token)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{}
	mut iife_result_18 := iife_temp_18.update(rt.new_string('auth'), rt.create_array([
		rt.ArrayItem{
			key: 'access_token'
			val: var_access_token.array_get(rt.new_string('access_token'))
		},
		rt.ArrayItem{
			key: 'access_token_secret'
			val: var_access_token.array_get(rt.new_string('access_token_secret'))
		},
		rt.ArrayItem{ key: 'site_id', val: var_access_token.array_get(rt.new_string('site_id')) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) },
	]))
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_API_WC_Helper{}
	mut iife_result_19 := iife_temp_19._flush_authentication_cache()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_19)))) {
		mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{}
		mut iife_result_20 := iife_temp_20.update(rt.new_string('auth'), rt.new_array())
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to WooCommerce.com. Please try again.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	rt.call_function('delete_transient', [
		rt.new_string('_woocommerce_helper_subscriptions'),
	])
	mut iife_temp_21 := Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater{}
	mut iife_result_21 := iife_temp_21.flush_updates_cache()
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connected')])
	return rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_square() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('\\WooCommerce\\Square\\Handlers\\Connection'),
	])))))
	{
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error connecting to Square.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	mut var_has_cbd_industry := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('US'), rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})))
	{
		mut var_profile := rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
			rt.new_array(),
		])
		if !(!rt.is_true(var_profile.array_get(rt.new_string('industry')))) {
			var_has_cbd_industry = rt.call_function('in_array', [
				rt.new_string('cbd-other-hemp-derived-products'),
				rt.call_function('array_column', [
					var_profile.array_get(rt.new_string('industry')),
					rt.new_string('slug'),
				]),
				rt.new_bool(true),
			])
		}
	}
	if rt.is_true(var_has_cbd_industry) {
		mut var_url :=
			rt.new_string('https://squareup.com/t/f_partnerships/d_referrals/p_woocommerce/c_general/o_none/l_us/dt_alldevice/pr_payments/?route=/solutions/cbd')
	} else {
		var_url =
			Class_Automattic_WooCommerce_Admin_API_WooCommerce_Square_Handlers_Connection.connect_url_production()
	}
	mut var_redirect_url := rt.call_function('wp_nonce_url', [
		rt.call_function('wc_admin_url', [
			rt.new_string('&task=payments&method=square&square-connect-finish=1'),
		]),
		rt.new_string('wc_square_connected'),
	])
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'redirect', val: rt.call_function('rawurlencode', [
			rt.call_function('rawurlencode', [var_redirect_url.clone()]),
		]) },
		rt.ArrayItem{ key: 'scopes', val: rt.call_function('implode', [
			rt.new_string(','),
			rt.create_array([rt.ArrayItem{ key: none, val: 'MERCHANT_PROFILE_READ' },
				rt.ArrayItem{ key: none, val: 'PAYMENTS_READ' },
				rt.ArrayItem{ key: none, val: 'PAYMENTS_WRITE' },
				rt.ArrayItem{ key: none, val: 'ORDERS_READ' },
				rt.ArrayItem{ key: none, val: 'ORDERS_WRITE' },
				rt.ArrayItem{ key: none, val: 'CUSTOMERS_READ' },
				rt.ArrayItem{ key: none, val: 'CUSTOMERS_WRITE' },
				rt.ArrayItem{ key: none, val: 'SETTLEMENTS_READ' },
				rt.ArrayItem{ key: none, val: 'ITEMS_READ' },
				rt.ArrayItem{ key: none, val: 'ITEMS_WRITE' },
				rt.ArrayItem{ key: none, val: 'INVENTORY_READ' },
				rt.ArrayItem{ key: none, val: 'INVENTORY_WRITE' }]),
		]) },
	])
	mut var_connect_url := rt.call_function('add_query_arg', [
		var_args.clone(), var_url.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'connectUrl', val: var_connect_url }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) connect_wcpay() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Payments'),
	])))))
	{
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_helper_connect'), rt.call_function('__', [
			rt.new_string('There was an error communicating with the WooPayments plugin.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(500))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'connectUrl', val: rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'wcpay-connect', val: '1' },
				rt.ArrayItem{ key: 'from', val: 'WCADMIN_PAYMENT_TASK' },
				rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('wcpay-connect'),
				]) }]),
			rt.call_function('admin_url', [rt.new_string('admin.php')]),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'plugins' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Plugin slug.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Plugin name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Plugin status.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) get_connect_schema() rt.PhpVal {
	mut var_schema := this.get_item_schema()
	var_schema.array_get(rt.new_string('properties')).array_unset(rt.new_string('status'))
	var_schema.array_get_mut('properties').array_set('connectAction', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Action that should be completed to connect Jetpack.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	return var_schema.clone()
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

fn create_automattic_woocommerce_admin_api_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('plugins')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_jetpack(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Jetpack {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_api(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_Helper_API {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_Helper {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_helper_updater(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_Helper_Updater {
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
		else {
			return none
		}
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
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
