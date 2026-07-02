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
}

fn init_static_automattic_woocommerce_admin_pluginshelper() {
		rt.init_static_prop('Automattic_WooCommerce_Admin_PluginsHelper', 'subscription_usage_notices_already_shown', rt.new_bool(false))
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.init() {
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
	if rt.is_true(rt.call_function('strstr', [var_slug_mutated.clone(), rt.new_string('/')])) {
		return (var_slug_mutated).to_bool()
	}
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_plugin_path := item_1.key
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		if rt.is_true(rt.identical(var_path_parts.array_get(rt.new_int(0)), var_slug_mutated)) {
			return (var_plugin_path).to_bool()
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugin_slugs() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(rt.call_function('get_plugins', []rt.PhpVal{}))])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugins_paths() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_installed_plugins := rt.new_array()
	mut iter_2 := var_plugins.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin := item_2.val
		mut var_path := item_2.key
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_path.clone()])
		mut var_slug := var_path_parts.array_get(rt.new_int(0))
		var_installed_plugins.array_set(var_slug, var_path.clone())
	}
	return var_installed_plugins.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_active_plugin_slugs() rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_absolute_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_path := rt.call_function('str_replace', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/'), rt.new_string(''), var_absolute_path.clone()])
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_absolute_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_path := rt.call_function('str_replace', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/'), rt.new_string(''), var_absolute_path.clone()])
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_absolute_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_path := rt.call_function('str_replace', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/'), rt.new_string(''), var_absolute_path.clone()])
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_absolute_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_plugin_path := rt.call_function('str_replace', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/'), rt.new_string(''), var_absolute_path.clone()])
		mut var_path_parts := rt.call_function('explode', [rt.new_string('/'), var_plugin_path.clone()])
		return var_path_parts.array_get(rt.new_int(0))
		}
	return rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_closure(closure_3_fn), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_PluginUtil.class()]), 'get_all_active_valid_plugins', []rt.PhpVal{})])])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_installed(var_plugin rt.PhpVal) bool {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.clone())
	return if rt.is_true(var_plugin_path) { rt.call_function('get_plugins', []rt.PhpVal{}).array_isset(var_plugin_path.clone()) } else { false }
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.is_plugin_active(var_plugin rt.PhpVal) bool {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.clone())
	return rt.is_true(var_plugin_path) && rt.is_true(rt.call_function('is_plugin_active', [var_plugin_path.clone()]))
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_data(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_path := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_plugin_path_from_slug(var_plugin.clone())
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	return if var_plugins.array_isset(var_plugin_path) { var_plugins.array_get(var_plugin_path) } else { rt.new_bool(false) }
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.install_plugins(var_plugins rt.PhpVal, mut var_logger Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger, mut var_source Class_Automattic_WooCommerce_Admin_?string) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_logger_mutated := var_logger
	var_plugins_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_plugins_pre_install'), var_plugins_mutated.clone()])
	if !rt.is_true(var_plugins_mutated) || !(var_plugins_mutated.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_plugins_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')])))
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
	mut iter_3 := var_plugins_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin := item_3.val
		mut var_slug := rt.call_function('sanitize_key', [var_plugin.clone()])
		rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.install_requested(var_plugin.clone())))
		if var_existing_plugins.array_isset(var_slug) {
			var_installed_plugins.array_push(var_plugin.clone())
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.installed(var_plugin.clone(), rt.new_int(0))))
			continue
		}
		mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
		mut var_api := rt.call_function('plugins_api', [rt.new_string('plugin_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }]) }])])
		if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
			mut var_properties := rt.create_array([rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed. Plugin API call failed.'), rt.new_string('woocommerce')]), var_slug.clone()]) }, rt.ArrayItem{ key: 'api_error_message', val: rt.call_method(var_api, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'slug', val: var_slug }])
			rt.call_function('wc_admin_record_tracks_event', [rt.new_string('install_plugin_error'), var_properties.clone()])
			rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_api_error'), var_slug.clone(), var_api.clone()])
			mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed. Plugin API call failed.'), rt.new_string('woocommerce')]), var_slug.clone()])
			var_errors.add(var_plugin.clone(), var_error_message.clone())
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.add_error(var_plugin.clone(), var_error_message.clone())))
			continue
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_before'), var_slug.clone(), var_source])
		mut var_upgrader := create_plugin_upgrader(create_automatic_upgrader_skin())
		mut var_result := var_upgrader.install(rt.get_property(var_api, 'download_link'))
		var_results.array_set(var_plugin, var_result.clone())
		var_time.array_set(var_plugin, rt.call_function('round', [rt.mul(rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time), rt.new_int(1000))]))
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) || var_result.clone().is_null() {
			var_properties = rt.create_array([rt.ArrayItem{ key: 'error_message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed.'), rt.new_string('woocommerce')]), var_slug.clone()]) }, rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'api_version', val: rt.get_property(var_api, 'version') }, rt.ArrayItem{ key: 'api_download_link', val: rt.get_property(var_api, 'download_link') }, rt.ArrayItem{ key: 'upgrader_skin_message', val: rt.call_function('implode', [rt.new_string(','), rt.call_method(rt.get_property(var_upgrader, 'skin'), 'get_upgrade_messages', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'result', val: if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) { rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}) } else { rt.new_string('null') } }])
			rt.call_function('wc_admin_record_tracks_event', [rt.new_string('install_plugin_error'), var_properties.clone()])
			rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_error'), var_slug.clone(), var_api.clone(), var_result.clone(), var_upgrader])
			mut var_install_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be installed. Upgrader install failed.'), rt.new_string('woocommerce')]), var_slug.clone()])
			var_errors.add(var_plugin.clone(), var_install_error_message.clone())
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.add_error(var_plugin.clone(), var_install_error_message.clone())))
			continue
		}
		var_installed_plugins.array_push(var_plugin.clone())
		rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.installed(var_plugin.clone(), var_time.array_get(var_plugin))))
		rt.call_function('do_action', [rt.new_string('woocommerce_plugins_install_after'), var_slug.clone(), var_source])
	}
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'installed', val: var_installed_plugins }, rt.ArrayItem{ key: 'results', val: var_results }, rt.ArrayItem{ key: 'errors', val: var_errors }, rt.ArrayItem{ key: 'time', val: var_time }])
	rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.complete(rt.call_function('array_merge', [var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'start_time', val: var_install_start_time }])]))))
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.install_and_activate_plugins_async_callback(mut var_plugins Class_Automattic_WooCommerce_Admin_array, job_id string, mut var_source Class_Automattic_WooCommerce_Admin_?string) bool {
	mut var_plugins_mutated := var_plugins
	mut job_id_mutated := job_id
	mut var_option_name := rt.new_string('woocommerce_onboarding_plugins_install_and_activate_async_' + job_id_mutated)
	mut var_logger := create_automattic_woocommerce_admin_pluginsinstallloggers_asyncpluginsinstalllogger(var_option_name.clone())
	Class_Automattic_WooCommerce_Admin_PluginsHelper.install_plugins(mut var_plugins_mutated, mut var_logger, rt.new_object('Automattic_WooCommerce_Admin_?string', []string{}, var_source))
	Class_Automattic_WooCommerce_Admin_PluginsHelper.activate_plugins(mut var_plugins_mutated, rt.new_object('Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger', []string{}, var_logger))
	return true
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_install_plugins(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	if !rt.is_true(var_plugins_mutated) || !(var_plugins_mutated.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_plugins_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]), rt.new_int(404)))
	}
	mut var_job_id := rt.call_function('uniqid', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(5)), rt.new_string('woocommerce_plugins_install_callback'), rt.create_array([rt.ArrayItem{ key: none, val: var_plugins_mutated }])])
	return var_job_id.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.activate_plugins(var_plugins rt.PhpVal, mut var_logger Class_Automattic_WooCommerce_Admin_?PluginsInstallLogger) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_logger_mutated := var_logger
	if !rt.is_true(var_plugins_mutated) || !(var_plugins_mutated.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_plugins_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]), rt.new_int(404)))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	var_plugins_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_plugins_pre_activate'), var_plugins_mutated.clone()])
	mut var_plugin_paths := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installed_plugins_paths()
	mut var_errors := create_wp_error()
	mut var_activated_plugins := rt.new_array()
	mut iter_4 := var_plugins_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin := item_4.val
		mut var_slug := var_plugin
		mut var_path := if var_plugin_paths.array_isset(var_slug) { var_plugin_paths.array_get(var_slug) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
			mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s`. is not yet installed.'), rt.new_string('woocommerce')]), var_slug.clone()])
			var_errors.add(var_plugin.clone(), var_message.clone())
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.add_error(var_plugin.clone(), var_message.clone())))
			continue
		}
		mut var_result := rt.call_function('activate_plugin', [var_path.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_path.clone()]))))) {
			rt.call_function('do_action', [rt.new_string('woocommerce_plugins_activate_error'), var_slug.clone(), var_result.clone()])
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested plugin `%s` could not be activated.'), rt.new_string('woocommerce')]), var_slug.clone()])
			var_errors.add(var_plugin.clone(), var_message.clone())
			rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.add_error(var_plugin.clone(), var_message.clone())))
			continue
		}
		var_activated_plugins.array_push(var_plugin.clone())
		rt.new_bool(rt.is_true(var_logger_mutated) && rt.is_true(var_logger_mutated.activated(var_plugin.clone())))
	}
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'activated', val: var_activated_plugins }, rt.ArrayItem{ key: 'active', val: Class_Automattic_WooCommerce_Admin_PluginsHelper.get_active_plugin_slugs() }, rt.ArrayItem{ key: 'errors', val: var_errors }])
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.schedule_activate_plugins(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	if !rt.is_true(var_plugins_mutated) || !(var_plugins_mutated.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_plugins_invalid_plugins'), rt.call_function('__', [rt.new_string('Plugins must be a non-empty array.'), rt.new_string('woocommerce')]), rt.new_int(404)))
	}
	mut var_job_id := rt.call_function('uniqid', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(5)), rt.new_string('woocommerce_plugins_activate_callback'), rt.create_array([rt.ArrayItem{ key: none, val: var_plugins_mutated }, rt.ArrayItem{ key: none, val: var_job_id }])])
	return var_job_id.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_installation_status(var_job_id rt.PhpVal) rt.PhpVal {
	mut var_job_id_mutated := var_job_id
	mut var_actions := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'search', [rt.create_array([rt.ArrayItem{ key: 'hook', val: 'woocommerce_plugins_install_callback' }, rt.ArrayItem{ key: 'search', val: var_job_id_mutated }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])
	return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_action_data(var_actions.clone())
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_action_data(var_actions rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	mut var_data := rt.new_array()
	mut iter_5 := var_actions_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_action := item_5.val
		mut var_action_id := item_5.key
		mut var_store := create_actionscheduler_dbstore()
		mut var_args := rt.call_method(var_action, 'get_args', []rt.PhpVal{})
		var_data.array_push(rt.create_array([rt.ArrayItem{ key: 'job_id', val: var_args.array_get(rt.new_int(1)) }, rt.ArrayItem{ key: 'plugins', val: var_args.array_get(rt.new_int(0)) }, rt.ArrayItem{ key: 'status', val: var_store.get_status(var_action_id.clone()) }]))
	}
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_activation_status(var_job_id rt.PhpVal) rt.PhpVal {
	mut var_job_id_mutated := var_job_id
	mut var_actions := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'search', [rt.create_array([rt.ArrayItem{ key: 'hook', val: 'woocommerce_plugins_activate_callback' }, rt.ArrayItem{ key: 'search', val: var_job_id_mutated }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])
	return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_action_data(var_actions.clone())
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_connect_notice_in_plugin_list() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut iife_temp_6 := Class_WC_Helper_Updater{}
	mut iife_result_6 := iife_temp_6.get_woo_connect_notice_type()
	mut var_notice_type := iife_result_6
	if rt.is_true(rt.identical(rt.new_string('none'), var_notice_type)) {
		return
	}
	mut var_notice_string := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('long'), var_notice_type)) {
		var_notice_string = rt.concat(var_notice_string, rt.call_function('__', [rt.new_string('Your store might be at risk as you are running old versions of WooCommerce plugins.'), rt.new_string('woocommerce')]))
		var_notice_string = rt.concat(var_notice_string, rt.new_string(' '))
	}
	mut var_connect_page_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' }, rt.ArrayItem{ key: 'tab', val: 'my-subscriptions' }, rt.ArrayItem{ key: 'path', val: rt.call_function('rawurlencode', [rt.new_string('/extensions')]) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_setting_screen_connect' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	var_notice_string = rt.concat(var_notice_string, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a id="woo-connect-notice-url" href="%s">Connect your store</a> to WooCommerce.com to get updates and streamlined support for your subscriptions.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [var_connect_page_url.clone()])]))
	print('<div class="woo-connect-notice notice notice-error is-dismissible">\n\t    \t\t<p class="widefat">' + (rt.call_function('wp_kses_post', [var_notice_string.clone()])).str() + '</p>\n\t    \t</div>')
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_connect_notice() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut iife_temp_7 := Class_WC_Helper_Updater{}
	mut iife_result_7 := iife_temp_7.get_woo_connect_notice_type()
	mut var_notice_type := iife_result_7
	if rt.is_true(rt.identical(rt.new_string('none'), var_notice_type)) {
		return
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_8 := iife_temp_8.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-connect-notice'))
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-connect-notice')])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_notices_in_plugins() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_9 := iife_temp_9.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-plugin-update-connect-notice'))
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_10 := iife_temp_10.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-enable-autorenew'))
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_11 := iife_temp_11.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-renew-subscription'))
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-plugin-update-connect-notice')])
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-enable-autorenew')])
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-renew-subscription')])
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-purchase-subscription')])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expired_subscriptions_notice() {
	mut iife_temp_12 := Class_WC_Helper{}
	mut iife_result_12 := iife_temp_12.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut var_notice := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expired_subscription_notice()
	if var_notice.array_isset(rt.new_string('description')) {
		print('<div id="woo-subscription-expired-notice" class="woo-subscription-expired-notice woo-subscription-notices notice notice-error is-dismissible" data-dismissnonce="' + (rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [rt.new_string('dismiss_notice')])])).str() + '">\n\t    \t\t<p class="widefat">' + (rt.call_function('wp_kses_post', [var_notice.array_get(rt.new_string('description'))])).str() + '</p>\n\t    \t</div>')
	}
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_show_expiring_subscriptions_notice() {
	mut iife_temp_13 := Class_WC_Helper{}
	mut iife_result_13 := iife_temp_13.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13)))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut var_notice := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expiring_subscription_notice()
	if var_notice.array_isset(rt.new_string('description')) {
		print('<div id="woo-subscription-expiring-notice" class="woo-subscription-expiring-notice woo-subscription-notices notice notice-error is-dismissible" data-dismissnonce="' + (rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [rt.new_string('dismiss_notice')])])).str() + '">\n\t    \t\t<p class="widefat">' + (rt.call_function('wp_kses_post', [var_notice.array_get(rt.new_string('description'))])).str() + '</p>\n\t    \t</div>')
	}
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.maybe_enqueue_scripts_for_subscription_notice() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id'))))) {
		return
	}
	mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_14 := iife_temp_14.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-subscriptions-notice'))
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-subscriptions-notice')])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut var_all_subs Class_Automattic_WooCommerce_Admin_array, mut var_subs_to_show Class_Automattic_WooCommerce_Admin_array, total i64, mut var_messages Class_Automattic_WooCommerce_Admin_array, type string) rt.PhpVal {
	mut var_utm_campaign := rt.new_string((if rt.is_true(rt.identical(rt.new_string('expired'), rt.new_string(type))) { 'pu_settings_screen_renew' } else { if rt.is_true(rt.identical(rt.new_string('missing'), rt.new_string(type))) { 'pu_settings_screen_purchase' } else { 'pu_settings_screen_enable_autorenew' } }).str())
	if 1 < total {
		mut var_hyperlink_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: var_utm_campaign }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url()])
		mut var_parsed_message := rt.call_function('sprintf', [var_messages.array_get(rt.new_string('different_subscriptions')), rt.call_function('esc_attr', [rt.new_int(total)]), rt.call_function('esc_url', [var_hyperlink_url.clone()]), rt.call_function('esc_attr', [rt.new_int(total)])])
		closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_sub.array_get(rt.new_string('product_id'))
			}
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_sub.array_get(rt.new_string('product_id'))
			}
		mut var_product_ids := rt.call_function('array_map', [rt.new_closure(closure_16_fn), var_subs_to_show])
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'different_subscriptions' }, rt.ArrayItem{ key: 'parsed_message', val: var_parsed_message }, rt.ArrayItem{ key: 'product_id', val: var_product_ids }])
	}
	mut var_subscription := rt.call_function('reset', [var_subs_to_show])
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	closure_18_fn := fn [var_product_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_product_id, var_sub.array_get(rt.new_string('product_id')))
		}
	closure_19_fn := fn [var_product_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_product_id, var_sub.array_get(rt.new_string('product_id')))
		}
	mut var_has_multiple_subs_for_product := rt.new_bool(1 < rt.call_function('array_filter', [var_all_subs, rt.new_closure(closure_18_fn)]).array_count())
	mut var_message_key := rt.new_string((if rt.is_true(var_has_multiple_subs_for_product) { 'multiple_manage' } else { 'single_manage' }).str())
	if rt.is_true(rt.identical(rt.new_string('expired'), rt.new_string(type))) && rt.is_true(var_has_multiple_subs_for_product) {
		if rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.has_active_usable_product_subscription((var_product_id).to_i64(), mut var_all_subs)) {
		var_message_key = rt.new_string('multiple_manage_site_covered')
		}
	}
	mut var_renew_string := rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')])
	mut var_subscribe_string := rt.call_function('__', [rt.new_string('Subscribe'), rt.new_string('woocommerce')])
	if var_subscription.array_isset(rt.new_string('product_regular_price')) {
	var_renew_string = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Renew for %1$s'), rt.new_string('woocommerce')]), var_subscription.array_get(rt.new_string('product_regular_price'))])
	}
	mut var_expiry_date := rt.call_function('date_i18n', [rt.new_string('F jS'), var_subscription.array_get(rt.new_string('expires'))])
	var_hyperlink_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }, rt.ArrayItem{ key: 'type', val: type }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: var_utm_campaign }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url()])
	if var_messages.array_isset(var_message_key) {
		var_parsed_message = rt.call_function('sprintf', [var_messages.array_get(var_message_key), rt.call_function('esc_attr', [var_subscription.array_get(rt.new_string('product_name'))]), rt.call_function('esc_attr', [var_expiry_date.clone()]), rt.call_function('esc_url', [var_hyperlink_url.clone()]), if rt.is_true(rt.identical(rt.new_string('missing'), rt.new_string(type))) { rt.call_function('esc_attr', [var_subscribe_string.clone()]) } else { rt.call_function('esc_attr', [var_renew_string.clone()]) }])
		return rt.create_array([rt.ArrayItem{ key: 'type', val: var_message_key }, rt.ArrayItem{ key: 'parsed_message', val: var_parsed_message }, rt.ArrayItem{ key: 'product_id', val: var_product_id }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'invalid' }, rt.ArrayItem{ key: 'parsed_message', val: '' }, rt.ArrayItem{ key: 'product_id', val: '' }])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.has_active_usable_product_subscription(product_id i64, mut var_subscriptions Class_Automattic_WooCommerce_Admin_array) bool {
	mut product_id_mutated := product_id
	mut var_subscriptions_mutated := var_subscriptions
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_WC_Helper_Options{}
	mut iife_result_19 := iife_temp_19.get(rt.new_string('auth'))
	mut var_auth := iife_result_19
	mut var_site_id := if var_auth.array_isset(rt.new_string('site_id')) { rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))]) } else { rt.new_int(0) }
	if rt.is_true(rt.identical(rt.new_int(0), var_site_id)) {
		return false
	}
	mut iter_6 := var_subscriptions_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_subscription := item_6.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('absint', [if !(var_subscription.array_get(rt.new_string('product_id'))).is_null() { var_subscription.array_get(rt.new_string('product_id')) } else { rt.new_int(0) }]), rt.new_int(product_id_mutated))))) {
			continue
		}
		mut var_connections := if var_subscription.array_isset(rt.new_string('connections')) && var_subscription.array_get(rt.new_string('connections')).is_array() { var_subscription.array_get(rt.new_string('connections')) } else { rt.new_array() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_site_id.clone(), var_connections.clone(), rt.new_bool(true)]))))) {
			continue
		}
		if !rt.is_true(var_subscription.array_get(rt.new_string('expired'))) || !(!rt.is_true(var_subscription.array_get(rt.new_string('lifetime')))) {
			return true
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expiring_subscription_notice(allowed_link bool) rt.PhpVal {
	mut iife_temp_20 := Class_WC_Helper{}
	mut iife_result_20 := iife_temp_20.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_20)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_PluginsHelper', 'subscription_usage_notices_already_shown')) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice((Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expiring_subs_notice()).to_bool()))))) {
		return rt.new_array()
	}
	mut iife_temp_21 := Class_WC_Helper{}
	mut iife_result_21 := iife_temp_21.get_subscription_list_data()
	mut var_subscriptions := iife_result_21
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(!rt.is_true(var_sub.array_get(rt.new_string('local')).array_get(rt.new_string('installed')))) && !(!rt.is_true(var_sub.array_get(rt.new_string('product_key')))) && rt.is_true(var_sub.array_get(rt.new_string('active'))) || !rt.is_true(var_sub.array_get(rt.new_string('connections'))) && rt.is_true(var_sub.array_get(rt.new_string('expiring'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_sub.array_get(rt.new_string('autorenew')))))))
		}
	mut var_expiring_subscriptions := rt.call_function('array_filter', [var_subscriptions.clone(), rt.new_closure(closure_23_fn)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_expiring_subscriptions)))) {
		return rt.new_array()
	}
	mut var_total_expiring_subscriptions := rt.new_int(var_expiring_subscriptions.clone().array_count())
	rt.set_static_prop('Automattic_WooCommerce_Admin_PluginsHelper', 'subscription_usage_notices_already_shown', rt.new_bool(true))
	mut iife_temp_23 := Class_WC_Helper{}
	mut iife_result_23 := iife_temp_23.get_notices()
	mut var_helper_notices := iife_result_23
	if !(!rt.is_true(var_helper_notices.array_get(rt.new_string('missing_payment_method_notice')))) {
		return Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_payment_method_notice(allowed_link, (var_total_expiring_subscriptions).to_i64())
	}
	mut var_notice_data := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_subscriptions), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_expiring_subscriptions), (var_total_expiring_subscriptions).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](rt.create_array([rt.ArrayItem{ key: 'single_manage', val: rt.call_function('__', [rt.new_string('Your subscription for <strong>%1$s</strong> expires on %2$s. <a href="%3$s">Enable auto-renewal</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'multiple_manage', val: rt.call_function('__', [rt.new_string('One of your subscriptions for <strong>%1$s</strong> expires on %2$s. <a href="%3$s">Enable auto-renewal</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'different_subscriptions', val: rt.call_function('__', [rt.new_string('You have <strong>%1$s Woo extension subscriptions</strong> expiring soon. <a href="%2$s">Enable auto-renewal</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }])), 'expiring')
	mut var_button_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_in_apps_screen_enable_autorenew' }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url()])
	if rt.is_true(rt.call_function('in_array', [var_notice_data.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'single_manage' }, rt.ArrayItem{ key: none, val: 'multiple_manage' }]), rt.new_bool(true)])) {
	var_button_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_notice_data.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'type', val: 'expiring' }]), var_button_link.clone()])
	}
	return rt.create_array([rt.ArrayItem{ key: 'description', val: if var_allowed_link { var_notice_data.array_get(rt.new_string('parsed_message')) } else { rt.call_function('preg_replace', [rt.new_string('#<a.*?>(.*?)</a>#i'), rt.new_string('\\1'), var_notice_data.array_get(rt.new_string('parsed_message'))]) } }, rt.ArrayItem{ key: 'button_text', val: rt.call_function('__', [rt.new_string('Enable auto-renewal'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button_link', val: var_button_link }])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_expired_subscription_notice(allowed_link bool) rt.PhpVal {
	mut iife_temp_24 := Class_WC_Helper{}
	mut iife_result_24 := iife_temp_24.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_24)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice((Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_expired_subs_notice()).to_bool()))))) {
		return rt.new_array()
	}
	mut iife_temp_25 := Class_WC_Helper{}
	mut iife_result_25 := iife_temp_25.get_subscription_list_data()
	mut var_subscriptions := iife_result_25
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(!rt.is_true(var_sub.array_get(rt.new_string('local')).array_get(rt.new_string('installed')))) && !(!rt.is_true(var_sub.array_get(rt.new_string('product_key')))) && rt.is_true(var_sub.array_get(rt.new_string('active'))) || !rt.is_true(var_sub.array_get(rt.new_string('connections'))) && rt.is_true(var_sub.array_get(rt.new_string('expired'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_sub.array_get(rt.new_string('lifetime')))))))
		}
	mut var_expired_subscriptions := rt.call_function('array_filter', [var_subscriptions.clone(), rt.new_closure(closure_27_fn)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_expired_subscriptions)))) {
		return rt.new_array()
	}
	mut var_total_expired_subscriptions := rt.new_int(var_expired_subscriptions.clone().array_count())
	rt.set_static_prop('Automattic_WooCommerce_Admin_PluginsHelper', 'subscription_usage_notices_already_shown', rt.new_bool(true))
	mut var_notice_data := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_subscriptions), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_expired_subscriptions), (var_total_expired_subscriptions).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](rt.create_array([rt.ArrayItem{ key: 'single_manage', val: rt.call_function('__', [rt.new_string('Your subscription for <strong>%1$s</strong> expired. <a href="%3$s">%4$s</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'multiple_manage', val: rt.call_function('__', [rt.new_string('One of your subscriptions for <strong>%1$s</strong> has expired. <a href="%3$s">%4$s</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'multiple_manage_site_covered', val: rt.call_function('__', [rt.new_string('One of your subscriptions for <strong>%1$s</strong> has expired. This store is still covered by another active subscription.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'different_subscriptions', val: rt.call_function('__', [rt.new_string('You have <strong>%1$s Woo extension subscriptions</strong> that expired. <a href="%2$s">Renew</a> to continue receiving updates and streamlined support.'), rt.new_string('woocommerce')]) }])), 'expired')
	mut var_button_text := rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')])
	mut var_button_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_notice_data.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: if var_allowed_link { 'pu_settings_screen_renew' } else { 'pu_in_apps_screen_renew' } }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url()])
	if rt.is_true(rt.identical(rt.new_string('multiple_manage_site_covered'), var_notice_data.array_get(rt.new_string('type')))) {
	var_button_text = rt.call_function('__', [rt.new_string('Review subscriptions'), rt.new_string('woocommerce')])
	var_button_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_notice_data.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'type', val: 'expired' }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: if var_allowed_link { 'pu_settings_screen_review_subscriptions' } else { 'pu_in_apps_screen_review_subscriptions' } }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url()])
	} else if rt.is_true(rt.call_function('in_array', [var_notice_data.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'single_manage' }, rt.ArrayItem{ key: none, val: 'multiple_manage' }]), rt.new_bool(true)])) {
	var_button_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_notice_data.array_get(rt.new_string('product_id')) }]), var_button_link.clone()])
	}
	return rt.create_array([rt.ArrayItem{ key: 'description', val: if var_allowed_link { var_notice_data.array_get(rt.new_string('parsed_message')) } else { rt.call_function('preg_replace', [rt.new_string('#<a.*?>(.*?)</a>#i'), rt.new_string('\\1'), var_notice_data.array_get(rt.new_string('parsed_message'))]) } }, rt.ArrayItem{ key: 'button_text', val: var_button_text }, rt.ArrayItem{ key: 'button_link', val: var_button_link }])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_subscription_notice() rt.PhpVal {
	mut iife_temp_27 := Class_WC_Helper{}
	mut iife_result_27 := iife_temp_27.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_27)))) {
		return rt.new_array()
	}
	if rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_PluginsHelper', 'subscription_usage_notices_already_shown')) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice((Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_missing_subs_notice()).to_bool()))))) {
		return rt.new_array()
	}
	mut iife_temp_28 := Class_WC_Helper{}
	mut iife_result_28 := iife_temp_28.get_subscription_list_data()
	mut var_subscriptions := iife_result_28
	closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(!rt.is_true(var_sub.array_get(rt.new_string('local')).array_get(rt.new_string('installed')))) && !rt.is_true(var_sub.array_get(rt.new_string('product_key'))))
		}
	mut var_missing_subscriptions := rt.call_function('array_filter', [var_subscriptions.clone(), rt.new_closure(closure_30_fn)])
	closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sub := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woo-update-manager'), var_sub.array_get(rt.new_string('zip_slug')))))
		}
	var_missing_subscriptions = rt.call_function('array_filter', [var_missing_subscriptions.clone(), rt.new_closure(closure_31_fn)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_missing_subscriptions)))) {
		return rt.new_array()
	}
	mut var_total_missing_subscriptions := rt.new_int(var_missing_subscriptions.clone().array_count())
	mut var_notice_data := Class_Automattic_WooCommerce_Admin_PluginsHelper.get_subscriptions_notice_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_subscriptions), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](var_missing_subscriptions), (var_total_missing_subscriptions).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_array](rt.create_array([rt.ArrayItem{ key: 'single_manage', val: rt.call_function('__', [rt.new_string('You don\'t have a subscription for <strong>%1$s</strong>. Subscribe to receive updates and streamlined support.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'different_subscriptions', val: rt.call_function('__', [rt.new_string('You don\'t have subscriptions for <strong>%1$s Woo extensions</strong>. Subscribe to receive updates and streamlined support.'), rt.new_string('woocommerce')]) }])), 'missing')
	mut var_button_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_notice_data.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_in_apps_screen_purchase' }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url()])
	if rt.is_true(rt.call_function('in_array', [var_notice_data.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'single_manage' }, rt.ArrayItem{ key: none, val: 'multiple_manage' }]), rt.new_bool(true)])) {
	var_button_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_notice_data.array_get(rt.new_string('product_id')) }]), var_button_link.clone()])
	}
	mut var_button_text := rt.call_function('__', [rt.new_string('Subscribe'), rt.new_string('woocommerce')])
	return rt.create_array([rt.ArrayItem{ key: 'description', val: var_notice_data.array_get(rt.new_string('parsed_message')) }, rt.ArrayItem{ key: 'button_text', val: var_button_text }, rt.ArrayItem{ key: 'button_link', val: var_button_link }])
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_disconnected_notice() string {
	mut iife_temp_31 := Class_WC_Helper{}
	mut iife_result_31 := iife_temp_31.is_site_connected()
	if rt.is_true(iife_result_31) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice((Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_disconnect_notice()).to_bool(), rt.new_bool(false)))))) {
		return ''
	}
	mut iife_temp_32 := Class_Automattic_WooCommerce_Admin_WC_Helper_Options{}
	mut iife_result_32 := iife_temp_32.get(rt.new_string('last_disconnected_user_data'))
	mut var_user_email := if !(iife_result_32.array_get(rt.new_string('email'))).is_null() { iife_result_32.array_get(rt.new_string('email')) } else { rt.new_null() }
	if !rt.is_true(var_user_email) {
		return ''
	}
	return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Successfully disconnected from <b>%1$s</b>.'), rt.new_string('woocommerce')]), var_user_email.clone()])).str()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_wccom_connected_notice(var_user_email rt.PhpVal) string {
	mut var_user_email_mutated := var_user_email
	mut iife_temp_33 := Class_WC_Helper{}
	mut iife_result_33 := iife_temp_33.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_33)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice((Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_connect_notice()).to_bool(), rt.new_bool(false)))))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_email_mutated)))) {
		return ''
	}
	return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Successfully connected to <b>%s</b>.'), rt.new_string('woocommerce')]), var_user_email_mutated.clone()])).str()
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.should_show_notice(var_dismiss_notice_meta rt.PhpVal, show_after_one_month bool) bool {
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_dismissed_timestamp := rt.call_function('get_user_meta', [var_user_id.clone(), var_dismiss_notice_meta.clone(), rt.new_bool(true)])
	if !(var_show_after_one_month) {
		return (rt.new_bool(!rt.is_true(var_dismissed_timestamp))).to_bool()
	}
	if !(!rt.is_true(var_dismissed_timestamp)) && rt.is_true(rt.less(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_dismissed_timestamp), rt.mul(rt.new_int(30), rt.get_constant('DAY_IN_SECONDS')))) {
		return false
	}
	if !(!rt.is_true(var_dismissed_timestamp)) {
		rt.call_function('delete_user_meta', [var_user_id.clone(), var_dismiss_notice_meta.clone()])
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_PluginsHelper.get_missing_payment_method_notice(allowed_link bool, total_expiring_subscriptions i64) rt.PhpVal {
	mut total_expiring_subscriptions_mutated := total_expiring_subscriptions
	mut var_add_payment_method_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: if var_allowed_link { 'pu_settings_screen_add_payment_method' } else { 'pu_in_apps_screen_add_payment_method' } }]), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PluginsHelper.woo_add_payment_method_url()])
	mut var_description := if var_allowed_link { rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Your WooCommerce extension subscription is missing a payment method for renewal. <a href="%s">Add a payment method</a> to ensure you continue receiving updates and streamlined support.'), rt.new_string('Your WooCommerce extension subscriptions are missing a payment method for renewal. <a href="%s">Add a payment method</a> to ensure you continue receiving updates and streamlined support.'), rt.new_int(total_expiring_subscriptions_mutated).clone(), rt.new_string('woocommerce')]), var_add_payment_method_link.clone()]) } else { rt.call_function('_n', [rt.new_string('Your WooCommerce extension subscription is missing a payment method for renewal. Add a payment method to ensure you continue receiving updates and streamlined support.'), rt.new_string('Your WooCommerce extension subscriptions are missing a payment method for renewal. Add a payment method to ensure you continue receiving updates and streamlined support.'), rt.new_int(total_expiring_subscriptions_mutated).clone(), rt.new_string('woocommerce')]) }
	return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'button_text', val: rt.call_function('__', [rt.new_string('Add payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button_link', val: var_add_payment_method_link }])
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

struct Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DBStore {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WC_Helper_Options {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
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

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginsinstallloggers_asyncpluginsinstalllogger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_dbstore(_args ...rt.PhpVal) &Class_ActionScheduler_DBStore {
	mut obj := &Class_ActionScheduler_DBStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater(_args ...rt.PhpVal) &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wc_helper_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Admin_WC_Helper_Options{
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_DBStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DBStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DBStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
}
