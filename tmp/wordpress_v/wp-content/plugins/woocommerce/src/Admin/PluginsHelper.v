import rt

pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url() string {
	return 'https://woocommerce.com/my-account/my-subscriptions/'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url() string {
	return 'https://woocommerce.com/cart/'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_add_payment_method_url() string {
	return 'https://woocommerce.com/my-account/add-payment-method/'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expired_subs_notice() string {
	return 'woo_subscription_expired_notice_dismiss'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expiring_subs_notice() string {
	return 'woo_subscription_expiring_notice_dismiss'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_missing_subs_notice() string {
	return 'woo_subscription_missing_notice_dismiss'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_disconnect_notice() string {
	return 'woo_disconnect_notice_dismiss'
}
pub fn Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_connect_notice() string {
	return 'woo_connect_notice_dismiss'
}
struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
pub mut:
		subscription_usage_notices_already_shown rt.PhpVal = rt.new_bool(false)
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_callback'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'install_plugins' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_and_activate_async_callback'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'install_and_activate_plugins_async_callback' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_activate_callback'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'activate_plugins' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_show_connect_notice_in_plugin_list' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_enqueue_scripts_for_connect_notice' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_enqueue_scripts_for_notices_in_plugins' }])])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_slug rt.PhpVal) bool {
	mut var_slug_mutated := var_slug
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	if rt.is_true(rt.call_function('strstr', [var_slug_mutated.dup(), rt.new_string('/')])) {
		return (var_slug_mutated).to_bool()
	}
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_plugin_path := item_1.key
			mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
			if rt.is_true(rt.identical(var_path_parts.array_get(0), var_slug_mutated)) {
				return (var_plugin_path).to_bool()
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugin_slugs() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_plugin_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	mut var_plugin_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(rt.call_function('get_plugins', []rt.PhpVal{}))])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugins_paths() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_installed_plugins := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_path := item_1.key
			mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_path.dup()])
			mut var_slug := var_path_parts.array_get(0)
			var_installed_plugins.array_set(var_slug, var_path.dup())
		}
	}
	return var_installed_plugins.dup()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_active_plugin_slugs() rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_absolute_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plugin_path := rt.call_function('str_replace', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/', rt.new_string(''), var_absolute_path.dup()])
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	mut var_absolute_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plugin_path := rt.call_function('str_replace', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/', rt.new_string(''), var_absolute_path.dup()])
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	mut var_absolute_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plugin_path := rt.call_function('str_replace', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/', rt.new_string(''), var_absolute_path.dup()])
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	mut var_absolute_path := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plugin_path := rt.call_function('str_replace', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/', rt.new_string(''), var_absolute_path.dup()])
	mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.dup()])
	return var_path_parts.array_get(0)
	}
	return rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_closure(closure_3_fn), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_PluginUtil.class()]), 'get_all_active_valid_plugins', []rt.PhpVal{})])])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_installed(var_plugin rt.PhpVal) bool {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.dup())
	return if rt.is_true(var_plugin_path) { rt.call_function('get_plugins', []rt.PhpVal{}).array_isset(var_plugin_path.dup()) } else { false }
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_active(var_plugin rt.PhpVal) bool {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.dup())
	return rt.is_true(var_plugin_path) && rt.is_true(rt.call_function('is_plugin_active', [var_plugin_path.dup()]))
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_data(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.dup())
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	return if var_plugins.array_isset(var_plugin_path) { var_plugins.array_get(var_plugin_path) } else { rt.new_bool(false) }
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.install_plugins(var_plugins rt.PhpVal, mut var_logger Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger, mut var_source Class_Automattic_WooCommerce_Admin_?string) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_logger_mutated := var_logger
	var_plugins_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_plugins_pre_install'), var_plugins_mutated.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_plugins_mutated) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugins_mutated.dup().is_array()))))))) {
		return create_wp_error(rt.new_string('woocommerce_plugins_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/admin.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/plugin-install.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/plugin.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-wp-upgrader.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-plugin-upgrader.php', '2')
	mut var_existing_plugins := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugins_paths()
	mut var_installed_plugins := rt.new_array()
	mut var_results := rt.new_array()
	mut var_time := rt.new_array()
	mut var_errors := create_wp_error()
	mut var_install_start_time := rt.call_function('time', []rt.PhpVal{})
	{
		mut iter_1 := var_plugins_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_slug := rt.call_function('sanitize_key', [var_plugin.dup()])
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.install_requested(var_plugin.dup())))
			if var_existing_plugins.array_isset(var_slug) {
				var_installed_plugins.array_push(var_plugin.dup())
				rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.installed(var_plugin.dup(), rt.new_int(0))))
				continue
			}
			mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
			mut var_api := rt.call_function('plugins_api', [rt.new_string('plugin_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }]) }])])
			if rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])) {
				mut var_properties := rt.create_array([rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed. Plugin API call failed.'), rt.new_string('woocommerce')]), var_slug.dup()]) }, rt.ArrayItem{ key: 'api_error_message', val: rt.call_method(var_api, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'slug', val: var_slug }])
				rt.call_function('wc_admin_record_tracks_event', [rt.new_string('install_plugin_error'), var_properties.dup()])
				rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_api_error'), var_slug.dup(), var_api.dup()])
				mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed. Plugin API call failed.'), rt.new_string('woocommerce')]), var_slug.dup()])
				var_errors.add(var_plugin.dup(), var_error_message.dup())
				rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.add_error(var_plugin.dup(), var_error_message.dup())))
				continue
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_before'), var_slug.dup(), var_source])
			mut var_upgrader := create_plugin_upgrader(create_automatic_upgrader_skin())
			mut var_result := var_upgrader.install(rt.get_property(var_api, 'download_link'))
			var_results.array_set(var_plugin, var_result.dup())
			var_time.array_set(var_plugin, rt.call_function('round', [rt.mul(rt.sub(rt.call_function('microtime', []), var_start_time), rt.new_int(1000))]))
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) || rt.is_true(rt.new_bool(var_result.dup().is_null())))) {
				var_properties = rt.create_array([rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [, .dup()]) }, rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'api_version', val: rt.get_property(, 'version') }, rt.ArrayItem{ key: 'api_download_link', val: rt.get_property(, 'download_link') }, rt.ArrayItem{ key: 'upgrader_skin_message', val: rt.call_function('implode', [, ]) }, rt.ArrayItem{ key: 'result', val: if rt.is_true() {  } else {  } }])
				rt.call_function('wc_admin_record_tracks_event', [rt.new_string('install_plugin_error'), var_properties.dup()])
				rt.call_function('do_action', [, .dup(), .dup(), .dup(), ])
				
			}
			
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.install_and_activate_plugins_async_callback(mut var_plugins Class_Automattic_WooCommerce_Admin_array, job_id string, mut var_source Class_Automattic_WooCommerce_Admin_?string) bool {
	mut var_plugins_mutated := var_plugins
	mut job_id_mutated := job_id
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_install_plugins(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.activate_plugins(var_plugins rt.PhpVal, mut var_logger Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_logger_mutated := var_logger
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_activate_plugins(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installation_status(var_job_id rt.PhpVal) rt.PhpVal {
	mut var_job_id_mutated := var_job_id
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_action_data(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_activation_status(var_job_id rt.PhpVal) rt.PhpVal {
	mut var_job_id_mutated := var_job_id
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_connect_notice_in_plugin_list()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_connect_notice()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_notices_in_plugins()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expired_subscriptions_notice()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expiring_subscriptions_notice()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_subscription_notice()  {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut var_all_subs Class_Automattic_WooCommerce_Admin_array, mut var_subs_to_show Class_Automattic_WooCommerce_Admin_array, total i64, mut var_messages Class_Automattic_WooCommerce_Admin_array, type string) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.has_active_usable_product_subscription(product_id i64, mut var_subscriptions Class_Automattic_WooCommerce_Admin_array) bool {
	mut product_id_mutated := product_id
	mut var_subscriptions_mutated := var_subscriptions
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expiring_subscription_notice(allowed_link bool) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expired_subscription_notice(allowed_link bool) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_subscription_notice() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_disconnected_notice() string {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_connected_notice(var_user_email rt.PhpVal) string {
	mut var_user_email_mutated := var_user_email
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice(var_dismiss_notice_meta rt.PhpVal, show_after_one_month bool) bool {
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_payment_method_notice(allowed_link bool, total_expiring_subscriptions i64) rt.PhpVal {
	mut total_expiring_subscriptions_mutated := total_expiring_subscriptions
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
		subscription_usage_notices_already_shown: rt.new_bool(false)
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader() &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin() &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.init()
			return rt.new_null()
		}
		'get_plugin_path_from_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(dispatch_arg_0))
		}
		'get_installed_plugin_slugs' {
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugin_slugs()
		}
		'get_installed_plugins_paths' {
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugins_paths()
		}
		'get_active_plugin_slugs' {
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_active_plugin_slugs()
		}
		'is_plugin_installed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_installed(dispatch_arg_0))
		}
		'is_plugin_active' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_active(dispatch_arg_0))
		}
		'get_plugin_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_data(dispatch_arg_0)
		}
		'install_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.install_plugins(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'install_and_activate_plugins_async_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.install_and_activate_plugins_async_callback(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'schedule_install_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_install_plugins(dispatch_arg_0)
		}
		'activate_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.activate_plugins(dispatch_arg_0, mut dispatch_arg_1)
		}
		'schedule_activate_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_activate_plugins(dispatch_arg_0)
		}
		'get_installation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installation_status(dispatch_arg_0)
		}
		'get_action_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_action_data(dispatch_arg_0)
		}
		'get_activation_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_activation_status(dispatch_arg_0)
		}
		'maybe_show_connect_notice_in_plugin_list' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_connect_notice_in_plugin_list()
			return rt.new_null()
		}
		'maybe_enqueue_scripts_for_connect_notice' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_connect_notice()
			return rt.new_null()
		}
		'maybe_enqueue_scripts_for_notices_in_plugins' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_notices_in_plugins()
			return rt.new_null()
		}
		'maybe_show_expired_subscriptions_notice' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expired_subscriptions_notice()
			return rt.new_null()
		}
		'maybe_show_expiring_subscriptions_notice' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expiring_subscriptions_notice()
			return rt.new_null()
		}
		'maybe_enqueue_scripts_for_subscription_notice' {
			Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_subscription_notice()
			return rt.new_null()
		}
		'get_subscriptions_notice_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4)
		}
		'has_active_usable_product_subscription' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.has_active_usable_product_subscription(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_expiring_subscription_notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expiring_subscription_notice(dispatch_arg_0)
		}
		'get_expired_subscription_notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expired_subscription_notice(dispatch_arg_0)
		}
		'get_missing_subscription_notice' {
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_subscription_notice()
		}
		'get_wccom_disconnected_notice' {
			return rt.new_string(Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_disconnected_notice())
		}
		'get_wccom_connected_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_connected_notice(dispatch_arg_0))
		}
		'should_show_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice(dispatch_arg_0, dispatch_arg_1))
		}
		'get_missing_payment_method_notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_payment_method_notice(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'subscription_usage_notices_already_shown' { return this.subscription_usage_notices_already_shown }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'subscription_usage_notices_already_shown' { this.subscription_usage_notices_already_shown = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_pluginshelper_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
}
