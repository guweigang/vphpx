import rt

struct Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('onboarding/plugins')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) register_routes() {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		return
	}
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/install-and-activate-async'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'POST' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'install_and_activate_async' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'can_install_and_activate_plugins' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'plugins', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: 'A list of plugins to install' },
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'items', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_3_fn) },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'source', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: 'The source of the request' },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						rt.ArrayItem{ key: 'required', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
					'WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_install_async_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/install-and-activate'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'POST' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'install_and_activate' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'can_install_and_activate_plugins' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
					'WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_install_activate_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/scheduled-installs/(?P<job_id>\\w+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_scheduled_installs' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'can_install_plugins' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
					'WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_install_async_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/jetpack-authorization-url'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: 'GET' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_jetpack_authorization_url' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
						'WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'can_install_plugins' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'redirect_url', val: rt.create_array([
						rt.ArrayItem{
							key: 'description'
							val: 'The URL to redirect to after authorization'
						},
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'from', val: rt.create_array([
						rt.ArrayItem{
							key: 'description'
							val: 'from value for the jetpack authorization page'
						},
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
						rt.ArrayItem{ key: 'required', val: false },
						rt.ArrayItem{ key: 'default', val: 'woocommerce-onboarding' },
					]) },
				]) },
			]) },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_error'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
				'WC_REST_Data_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'log_plugins_install_error' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_plugins_install_api_error'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingPlugins', [
				'WC_REST_Data_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'log_plugins_install_api_error' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) install_and_activate(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_response := rt.new_array()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_3 :=
		iife_temp_3.install_plugins(var_request.get_param(rt.new_string('plugins')))
	var_response.array_set('install', iife_result_3)
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_4 :=
		iife_temp_4.activate_plugins(var_response.array_get(rt.new_string('install')).array_get(rt.new_string('installed')))
	var_response.array_set('activate', iife_result_4)
	return rt.new_object('WP_REST_Response', []string{},
		create_wp_rest_response(var_response.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) install_and_activate_async(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_plugins := var_request.get_param(rt.new_string('plugins'))
	mut var_source := var_request.get_param(rt.new_string('source'))
	mut var_job_id := rt.call_function('uniqid', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
		'add', [rt.new_string('woocommerce_plugins_install_and_activate_async_callback'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_plugins },
			rt.ArrayItem{ key: none, val: var_job_id }, rt.ArrayItem{ key: none, val: var_source }])])
	mut var_plugin_status := rt.new_array()
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		var_plugin_status.array_set(var_plugin, rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'pending' },
			rt.ArrayItem{ key: 'errors', val: rt.new_array() },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'job_id', val: var_job_id },
		rt.ArrayItem{ key: 'status', val: 'pending' }, rt.ArrayItem{
			key: 'plugins'
			val: var_plugin_status
		}])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) get_scheduled_installs(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_job_id := var_request.get_param(rt.new_string('job_id'))
	mut var_actions := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'queue', []rt.PhpVal{}), 'search', [
		rt.create_array([
			rt.ArrayItem{
				key: 'hook'
				val: 'woocommerce_plugins_install_and_activate_async_callback'
			},
			rt.ArrayItem{ key: 'search', val: var_job_id },
			rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
		]),
	])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_5 := iife_temp_5.get_action_data(var_actions.clone())
	closure_7_fn := fn [var_job_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_action := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_action.array_get(rt.new_string('job_id')), var_job_id)
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_7 := iife_temp_7.get_action_data(var_actions.clone())
	var_actions = rt.call_function('array_filter', [iife_result_5, rt.new_closure(closure_7_fn)])
	if !rt.is_true(var_actions) {
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.new_null(),
			rt.new_int(404)))
	}
	mut var_response := rt.create_array([
		rt.ArrayItem{
			key: 'job_id'
			val: var_actions.array_get(rt.new_int(0)).array_get(rt.new_string('job_id'))
		},
		rt.ArrayItem{
			key: 'status'
			val: var_actions.array_get(rt.new_int(0)).array_get(rt.new_string('status'))
		},
	])
	mut var_option := rt.call_function('get_option', [
		rt.new_string('woocommerce_onboarding_plugins_install_and_activate_async_' +
			var_job_id.str()),
	])
	if var_option.array_isset(rt.new_string('plugins')) {
		var_response.array_set('plugins', var_option.array_get(rt.new_string('plugins')))
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) get_jetpack_authorization_url(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{}
	mut iife_result_8 := iife_temp_8.get_authorization_url(var_request.get_param(rt.new_string('redirect_url')),
		var_request.get_param(rt.new_string('from')))
	return iife_result_8
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) can_install_plugins() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [
			rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) can_install_and_activate_plugins() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [
			rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) get_install_async_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'Install Async Schema' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'job_id', val: 'integer' },
				rt.ArrayItem{ key: 'status', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'pending' },
						rt.ArrayItem{ key: none, val: 'complete' },
						rt.ArrayItem{ key: none, val: 'failed' },
					]) },
				]) },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) get_install_activate_schema() rt.PhpVal {
	mut var_error_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'patternProperties', val: rt.create_array([
			rt.ArrayItem{ key: '^.*$', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) }])
	mut var_install_schema := rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'installed', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'results', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'errors', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'errors', val: var_error_schema },
					rt.ArrayItem{ key: 'error_data', val: var_error_schema },
				]) },
			]) },
		]) },
	])
	mut var_activate_schema := rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'activated', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'active', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'errors', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'errors', val: var_error_schema },
					rt.ArrayItem{ key: 'error_data', val: var_error_schema },
				]) },
			]) },
		]) },
	])
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'Install and Activate Schema' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'install', val: var_install_schema },
				rt.ArrayItem{ key: 'activate', val: var_activate_schema },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) log_plugins_install_error(var_slug rt.PhpVal, var_api rt.PhpVal, var_result rt.PhpVal, var_upgrader rt.PhpVal) {
	mut var_properties := rt.create_array([
		rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The requested plugin `%s` could not be installed.'),
				rt.new_string('woocommerce'),
			]),
			var_slug.clone(),
		]) },
		rt.ArrayItem{ key: 'type', val: 'plugin_info_api_error' },
		rt.ArrayItem{ key: 'slug', val: var_slug },
		rt.ArrayItem{ key: 'api_version', val: rt.get_property(var_api, 'version') },
		rt.ArrayItem{ key: 'api_download_link', val: rt.get_property(var_api, 'download_link') },
		rt.ArrayItem{ key: 'upgrader_skin_message', val: rt.call_function('implode', [
			rt.new_string(','),
			rt.call_method(rt.get_property(var_upgrader, 'skin'), 'get_upgrade_messages',
				[]rt.PhpVal{}),
		]) },
		rt.ArrayItem{
			key: 'result'
			val: if rt.is_true(rt.call_function('is_wp_error', [
				var_result.clone(),
			]))
			{
				rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})
			} else {
				rt.new_string('null')
			}
		},
	])
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('coreprofiler_install_plugin_error'),
		var_properties.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) log_plugins_install_api_error(var_slug rt.PhpVal, var_api rt.PhpVal) {
	mut var_properties := rt.create_array([
		rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The requested plugin `%s` could not be installed. Plugin API call failed.'),
				rt.new_string('woocommerce'),
			]),
			var_slug.clone(),
		]) },
		rt.ArrayItem{ key: 'type', val: 'plugin_install_error' },
		rt.ArrayItem{ key: 'api_error_message', val: rt.call_method(var_api, 'get_error_message',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'slug', val: var_slug },
	])
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('coreprofiler_install_plugin_error'),
		var_properties.clone(),
	])
}

struct Class_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_onboardingplugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('onboarding/plugins')
	}
	return obj
}

fn create_wc_rest_data_controller(_args ...rt.PhpVal) &Class_WC_REST_Data_Controller {
	mut obj := &Class_WC_REST_Data_Controller{
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

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_jetpack_jetpackconnection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'install_and_activate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.install_and_activate(mut dispatch_arg_0)
		}
		'install_and_activate_async' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.install_and_activate_async(mut dispatch_arg_0)
		}
		'get_scheduled_installs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_scheduled_installs(mut dispatch_arg_0)
		}
		'get_jetpack_authorization_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_jetpack_authorization_url(mut dispatch_arg_0)
		}
		'can_install_plugins' {
			return rt.new_bool(this.can_install_plugins())
		}
		'can_install_and_activate_plugins' {
			return rt.new_bool(this.can_install_and_activate_plugins())
		}
		'get_install_async_schema' {
			return this.get_install_async_schema()
		}
		'get_install_activate_schema' {
			return this.get_install_activate_schema()
		}
		'log_plugins_install_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.log_plugins_install_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'log_plugins_install_api_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.log_plugins_install_api_error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
