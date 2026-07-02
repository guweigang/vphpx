import rt

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn init_static_wc_admin_notices() {
		rt.init_static_prop('WC_Admin_Notices', 'notices', rt.new_array())
		rt.init_static_prop('WC_Admin_Notices', 'core_notices', rt.create_array([rt.ArrayItem{ key: 'update', val: 'update_notice' }, rt.ArrayItem{ key: 'template_files', val: 'template_file_check_notice' }, rt.ArrayItem{ key: 'legacy_shipping', val: 'legacy_shipping_notice' }, rt.ArrayItem{ key: 'no_shipping_methods', val: 'no_shipping_methods_notice' }, rt.ArrayItem{ key: 'regenerating_thumbnails', val: 'regenerating_thumbnails_notice' }, rt.ArrayItem{ key: 'regenerating_lookup_table', val: 'regenerating_lookup_table_notice' }, rt.ArrayItem{ key: 'no_secure_connection', val: 'secure_connection_notice' }, rt.ArrayItem{ key: 'maxmind_license_key', val: 'maxmind_missing_license_key_notice' }, rt.ArrayItem{ key: 'redirect_download_method', val: 'redirect_download_method_notice' }, rt.ArrayItem{ key: 'uploads_directory_is_unprotected', val: 'uploads_directory_is_unprotected_notice' }, rt.ArrayItem{ key: 'base_tables_missing', val: 'base_tables_missing_notice' }, rt.ArrayItem{ key: 'download_directories_sync_complete', val: 'download_directories_sync_complete' }, rt.ArrayItem{ key: 'hpos_sync_on_read_disabled', val: 'sync_on_read_disabled_notice' }]))
		rt.init_static_prop('WC_Admin_Notices', 'is_multisite', rt.new_null())
}

fn Class_WC_Admin_Notices.init() {
	rt.set_static_prop('WC_Admin_Notices', 'is_multisite', rt.call_function('is_multisite', []rt.PhpVal{}))
	Class_WC_Admin_Notices.set_notices(mut rt.cast_object_ptr[Class_array](rt.call_function('get_option', [rt.new_string('woocommerce_admin_notices'), rt.new_array()])))
	rt.call_function('add_action', [rt.new_string('switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'reset_admin_notices' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'reset_admin_notices' }])])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_file_download_method'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_redirect_download_method_notice' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'hide_notices' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_remove_legacy_api_removal_notice' }]), rt.new_int(20)])
	mut iife_temp_0 := Class_WC_Install{}
	mut iife_result_0 := iife_temp_0.is_new_install()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_running_from_async_action_scheduler', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'store_notices' }])])
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) {
		rt.call_function('add_action', [rt.new_string('admin_print_styles'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_notices' }])])
	}
}

fn Class_WC_Admin_Notices.prepare_note_with_nonce(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN), rt.new_string('5.4.0')])
	return var_response_mutated.clone()
}

fn Class_WC_Admin_Notices.store_notices() {
	mut var_current_notices := Class_WC_Admin_Notices.get_notices()
	mut var_prev_notices := rt.call_function('get_option', [rt.new_string('woocommerce_admin_notices'), rt.new_array()])
	rt.call_function('update_option', [rt.new_string('woocommerce_admin_notices'), var_current_notices.clone()])
	mut iter_1 := rt.call_function('array_diff', [var_prev_notices.clone(), var_current_notices.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_notice := item_1.val
		if rt.get_static_prop('WC_Admin_Notices', 'core_notices').array_isset(var_notice) {
			continue
		}
		rt.call_function('delete_option', [rt.new_string('woocommerce_admin_notice_' + (var_notice).str())])
	}
}

fn Class_WC_Admin_Notices.get_notices() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_Admin_Notices', 'is_multisite'))))) {
		return rt.get_static_prop('WC_Admin_Notices', 'notices')
	}
	mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
	mut var_notices := if !(rt.get_static_prop('WC_Admin_Notices', 'notices').array_get(var_blog_id)).is_null() { rt.get_static_prop('WC_Admin_Notices', 'notices').array_get(var_blog_id) } else { rt.new_null() }
	if !(var_notices.clone().is_null()) {
		return var_notices.clone()
	}
	rt.get_static_prop('WC_Admin_Notices', 'notices').array_set(var_blog_id, rt.call_function('get_option', [rt.new_string('woocommerce_admin_notices'), rt.new_array()]))
	return rt.get_static_prop('WC_Admin_Notices', 'notices').array_get(var_blog_id)
}

fn Class_WC_Admin_Notices.set_notices(mut var_notices Class_array) {
	mut var_notices_mutated := var_notices
	if rt.is_true(rt.get_static_prop('WC_Admin_Notices', 'is_multisite')) {
		rt.get_static_prop('WC_Admin_Notices', 'notices').array_set(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_notices_mutated)
	} else {
		rt.set_static_prop('WC_Admin_Notices', 'notices', var_notices_mutated)
	}
}

fn Class_WC_Admin_Notices.remove_all_notices() {
	Class_WC_Admin_Notices.set_notices(mut rt.cast_object_ptr[Class_array](rt.new_array()))
}

fn Class_WC_Admin_Notices.reset_admin_notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Admin_Notices.is_ssl())))) {
		Class_WC_Admin_Notices.add_notice('no_secure_connection')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Admin_Notices.is_uploads_directory_protected())))) {
		Class_WC_Admin_Notices.add_notice('uploads_directory_is_unprotected')
	}
	Class_WC_Admin_Notices.add_notice('template_files')
	Class_WC_Admin_Notices.add_min_version_notice()
	Class_WC_Admin_Notices.add_maxmind_missing_license_key_notice()
	Class_WC_Admin_Notices.maybe_add_legacy_api_removal_notice()
}

fn Class_WC_Admin_Notices.maybe_add_legacy_api_removal_notice() {
	if rt.is_true(rt.greater(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil.class()]), 'get_legacy_webhooks_count', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{}))))) {
		Class_WC_Admin_Notices.add_custom_notice(rt.new_string('legacy_webhooks_unsupported_in_woo_90'), rt.call_function('sprintf', [rt.new_string('%s%s'), rt.call_function('sprintf', [rt.new_string('<h4>%s</h4>'), rt.call_function('esc_html__', [rt.new_string('WooCommerce webhooks that use the Legacy REST API are unsupported'), rt.new_string('woocommerce')])]), rt.call_function('sprintf', [rt.call_function('wpautop', [rt.call_function('__', [rt.new_string('⚠️ The WooCommerce Legacy REST API has been removed from WooCommerce, this will cause <a href="%1$s">webhooks on this site that are configured to use the Legacy REST API</a> to stop working. <a target="_blank" href="%2$s">A separate WooCommerce extension is available</a> to allow these webhooks to keep using the Legacy REST API without interruption. You can also edit these webhooks to use the current REST API version to generate the payload instead. <b><a target="_blank" href="%3$s">Learn more about this change.</a></b>'), rt.new_string('woocommerce')])]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks&legacy=true')]), rt.new_string('https://wordpress.org/plugins/woocommerce-legacy-rest-api/'), rt.new_string('https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/')])]))
	}
}

fn Class_WC_Admin_Notices.maybe_remove_legacy_api_removal_notice() {
	if rt.is_true(Class_WC_Admin_Notices.has_notice(rt.new_string('legacy_webhooks_unsupported_in_woo_90'))) && rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil.class()]), 'get_legacy_webhooks_count', []rt.PhpVal{}))) {
		Class_WC_Admin_Notices.remove_notice('legacy_webhooks_unsupported_in_woo_90')
	}
}

fn Class_WC_Admin_Notices.add_notice(var_name rt.PhpVal, force_save bool) {
	Class_WC_Admin_Notices.set_notices(mut rt.cast_object_ptr[Class_array](rt.call_function('array_unique', [rt.call_function('array_merge', [Class_WC_Admin_Notices.get_notices(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }])])])))
	if var_force_save {
		Class_WC_Admin_Notices.store_notices()
	}
}

fn Class_WC_Admin_Notices.remove_notice(var_name rt.PhpVal, force_save bool) {
	if rt.is_true(Class_WC_Admin_Notices.has_notice(var_name.clone())) {
		Class_WC_Admin_Notices.set_notices(mut rt.cast_object_ptr[Class_array](rt.call_function('array_diff', [Class_WC_Admin_Notices.get_notices(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }])])))
	}
	if var_force_save {
		Class_WC_Admin_Notices.store_notices()
	}
}

fn Class_WC_Admin_Notices.remove_notices(var_names_array_or_regex rt.PhpVal, force_save bool) {
	mut var_notice_name := rt.new_null()
	mut var_names_array_or_regex_mutated := var_names_array_or_regex
	if !(var_names_array_or_regex_mutated.clone().is_array()) {
	closure_2_fn := fn [var_names_array_or_regex] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_notice_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_int(1), rt.call_function('preg_match', [var_names_array_or_regex_mutated.clone(), var_notice_name.clone()]))
		}
	var_names_array_or_regex_mutated = rt.call_function('array_filter', [Class_WC_Admin_Notices.get_notices(), rt.new_closure(closure_2_fn)])
	}
	Class_WC_Admin_Notices.set_notices(mut rt.cast_object_ptr[Class_array](rt.call_function('array_diff', [Class_WC_Admin_Notices.get_notices(), var_names_array_or_regex_mutated.clone()])))
	if var_force_save {
		Class_WC_Admin_Notices.store_notices()
	}
}

fn Class_WC_Admin_Notices.has_notice(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_name.clone(), Class_WC_Admin_Notices.get_notices(), rt.new_bool(true)])
}

fn Class_WC_Admin_Notices.hide_notices() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-hide-notice')) && rt.get_superglobal('_GET').array_isset(rt.new_string('_wc_notice_nonce')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wc_notice_nonce'))])]), rt.new_string('woocommerce_hide_notices_nonce')]))))) {
			rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Action failed. Please refresh the page and retry.'), rt.new_string('woocommerce')])])
		}
		mut var_notice_name := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-hide-notice'))])])
		mut var_required_capability := rt.call_function('apply_filters', [rt.new_string('woocommerce_dismiss_admin_notice_capability'), rt.new_string('manage_woocommerce'), var_notice_name.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_required_capability.clone()]))))) {
			rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You don&#8217;t have permission to do this.'), rt.new_string('woocommerce')])])
		}
		Class_WC_Admin_Notices.hide_notice(var_notice_name.clone())
	}
}

fn Class_WC_Admin_Notices.hide_notice(var_name rt.PhpVal) {
	Class_WC_Admin_Notices.remove_notice((var_name).to_bool())
	rt.call_function('update_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_' + (var_name).str() + '_notice'), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_hide_' + (var_name).str() + '_notice')])
}

fn Class_WC_Admin_Notices.user_has_dismissed_notice(name string, mut var_user_id Class_?int) bool {
	return (rt.call_function('get_user_meta', [if !(var_user_id).is_null() { var_user_id } else { rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.new_string("dismissed_${var_name}_notice"), rt.new_bool(true)])).to_bool()
}

fn Class_WC_Admin_Notices.add_notices() {
	mut var_notices := Class_WC_Admin_Notices.get_notices()
	if !rt.is_true(var_notices) {
		return
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/wc-admin-functions.php', '4')
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	mut var_show_on_screens := ['dashboard', 'plugins']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_screen_id.clone(), rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_screen_id.clone(), rt.create_array_from_list(var_show_on_screens), rt.new_bool(true)]))))) {
		return
	}
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-activation'), rt.call_function('plugins_url', [rt.new_string('/assets/css/activation.css'), rt.get_constant('WC_PLUGIN_FILE')]), rt.new_array(), iife_result_2])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce-activation'), rt.new_string('rtl'), rt.new_string('replace')])
	mut iter_2 := var_notices.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_notice := item_2.val
		if !(!rt.is_true(rt.get_static_prop('WC_Admin_Notices', 'core_notices').array_get(var_notice))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_show_admin_notice'), rt.new_bool(true), var_notice.clone()])) {
			rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: rt.get_static_prop('WC_Admin_Notices', 'core_notices').array_get(var_notice) }])])
		} else {
			rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output_custom_notices' }])])
		}
	}
}

fn Class_WC_Admin_Notices.add_custom_notice(var_name rt.PhpVal, var_notice_html rt.PhpVal) {
	mut var_notice_html_mutated := var_notice_html
	Class_WC_Admin_Notices.add_notice((var_name).to_bool())
	rt.call_function('update_option', [rt.new_string('woocommerce_admin_notice_' + (var_name).str()), rt.call_function('wp_kses_post', [var_notice_html_mutated.clone()])])
}

fn Class_WC_Admin_Notices.output_custom_notices() {
	mut var_notices := Class_WC_Admin_Notices.get_notices()
	if !(!rt.is_true(var_notices)) {
		mut iter_3 := var_notices.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_notice := item_3.val
			if !rt.is_true(rt.get_static_prop('WC_Admin_Notices', 'core_notices').array_get(var_notice)) {
				mut var_notice_html := rt.call_function('get_option', [rt.new_string('woocommerce_admin_notice_' + (var_notice).str())])
				if rt.is_true(var_notice_html) {
					rt.include_file(@DIR + '/views/html-notice-custom.php', '1')
				}
			}
		}
	}
}

fn Class_WC_Admin_Notices.update_notice() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(rt.call_function('in_array', [var_screen_id.clone(), rt.call_function('wc_get_screen_ids', []rt.PhpVal{}), rt.new_bool(true)])) {
		return
	}
	mut iife_temp_3 := Class_WC_Install{}
	mut iife_result_3 := iife_temp_3.needs_db_update()
	if rt.is_true(iife_result_3) {
		mut var_next_scheduled_date := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [rt.new_string('woocommerce_run_update_callback'), rt.new_null(), rt.new_string('woocommerce-db-updates')])
		if rt.is_true(var_next_scheduled_date) || !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('do_update_woocommerce')))) {
			rt.include_file(@DIR + '/views/html-notice-updating.php', '1')
		} else {
			rt.include_file(@DIR + '/views/html-notice-update.php', '1')
		}
	} else {
		rt.include_file(@DIR + '/views/html-notice-updated.php', '1')
	}
}

fn Class_WC_Admin_Notices.install_notice() {
	rt.call_function('_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN), rt.new_string('4.6.0'), rt.call_function('esc_html__', [rt.new_string('Onboarding is maintained in WooCommerce Admin.'), rt.new_string('woocommerce')])])
}

fn Class_WC_Admin_Notices.template_file_check_notice() {
	mut iife_temp_4 := Class_WC_Admin_Status{}
	mut iife_result_4 := iife_temp_4.scan_template_files(rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates'))
	mut var_core_templates := iife_result_4
	mut var_outdated := rt.new_bool(false)
	mut iter_4 := var_core_templates.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_file := item_4.val
		mut var_theme_file := rt.new_bool(false)
		if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())])) {
		var_theme_file = rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())
		} else if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_file).str())])) {
		var_theme_file = rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_file).str())
		} else if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())])) {
		var_theme_file = rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (var_file).str())
		} else if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_file).str())])) {
		var_theme_file = rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_file).str())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_theme_file)))) {
			mut iife_temp_5 := Class_WC_Admin_Status{}
			mut iife_result_5 := iife_temp_5.get_file_version(rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates/' + (var_file).str()))
			mut var_core_version := iife_result_5
			mut iife_temp_6 := Class_WC_Admin_Status{}
			mut iife_result_6 := iife_temp_6.get_file_version(var_theme_file.clone())
			mut var_theme_version := iife_result_6
			if rt.is_true(var_core_version) && rt.is_true(var_theme_version) && rt.is_true(rt.call_function('version_compare', [var_theme_version.clone(), var_core_version.clone(), rt.new_string('<')])) {
				var_outdated = rt.new_bool(true)
				break
			}
		}
	}
	if rt.is_true(var_outdated) {
		rt.include_file(@DIR + '/views/html-notice-template-check.php', '1')
	} else {
		Class_WC_Admin_Notices.remove_notice('template_files')
	}
}

fn Class_WC_Admin_Notices.legacy_shipping_notice() {
	mut var_maybe_load_legacy_methods := ['flat_rate', 'free_shipping', 'international_delivery', 'local_delivery', 'local_pickup']
	mut var_enabled := rt.new_bool(false)
	for var_method in var_maybe_load_legacy_methods {
		mut var_options := rt.call_function('get_option', [rt.new_string('woocommerce_' + method + '_settings')])
		if rt.is_true(var_options) && var_options.array_isset(rt.new_string('enabled')) && rt.is_true(rt.identical(rt.new_string('yes'), var_options.array_get(rt.new_string('enabled')))) {
		var_enabled = rt.new_bool(true)
		}
	}
	if rt.is_true(var_enabled) {
		rt.include_file(@DIR + '/views/html-notice-legacy-shipping.php', '1')
	} else {
		Class_WC_Admin_Notices.remove_notice('legacy_shipping')
	}
}

fn Class_WC_Admin_Notices.no_shipping_methods_notice() {
	if rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wc_admin_settings_page', []rt.PhpVal{}))))) || !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tab'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('shipping'), rt.get_superglobal('_GET').array_get(rt.new_string('tab')))))) {
		mut var_product_count := rt.call_function('wp_count_posts', [rt.new_string('product')])
		mut var_method_count := rt.call_function('wc_get_shipping_method_count', []rt.PhpVal{})
		if rt.is_true(rt.greater(rt.get_property(var_product_count, 'publish'), rt.new_int(0))) && rt.is_true(rt.identical(rt.new_int(0), var_method_count)) {
			rt.include_file(@DIR + '/views/html-notice-no-shipping-methods.php', '1')
		}
		if rt.is_true(rt.greater(var_method_count, rt.new_int(0))) {
			Class_WC_Admin_Notices.remove_notice('no_shipping_methods')
		}
	}
}

fn Class_WC_Admin_Notices.regenerating_thumbnails_notice() {
	rt.include_file(@DIR + '/views/html-notice-regenerating-thumbnails.php', '1')
}

fn Class_WC_Admin_Notices.secure_connection_notice() {
	if rt.is_true(Class_WC_Admin_Notices.is_ssl()) || rt.is_true(rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_no_secure_connection_notice'), rt.new_bool(true)])) {
		return
	}
	rt.include_file(@DIR + '/views/html-notice-secure-connection.php', '1')
}

fn Class_WC_Admin_Notices.regenerating_lookup_table_notice() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_update_product_lookup_tables_is_running', []rt.PhpVal{}))))) {
		Class_WC_Admin_Notices.remove_notice('regenerating_lookup_table')
		return
	}
	rt.include_file(@DIR + '/views/html-notice-regenerating-lookup-table.php', '1')
}

fn Class_WC_Admin_Notices.add_min_version_notice() {
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('phpversion', []rt.PhpVal{}), rt.get_constant('WC_NOTICE_MIN_PHP_VERSION'), rt.new_string('<')])) || rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.get_constant('WC_NOTICE_MIN_WP_VERSION'), rt.new_string('<')])) {
		Class_WC_Admin_Notices.add_notice((rt.get_constant('WC_PHP_MIN_REQUIREMENTS_NOTICE')).to_bool())
	}
}

fn Class_WC_Admin_Notices.wp_php_min_requirements_notice() {
}

fn Class_WC_Admin_Notices.add_maxmind_missing_license_key_notice() {
	mut var_default_address := rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_default_address.clone(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax() }]), rt.new_bool(true)]))))) {
		return
	}
	mut var_integration_options := rt.call_function('get_option', [rt.new_string('woocommerce_maxmind_geolocation_settings')])
	if !rt.is_true(var_integration_options.array_get(rt.new_string('license_key'))) {
		Class_WC_Admin_Notices.add_notice('maxmind_license_key')
	}
}

fn Class_WC_Admin_Notices.add_redirect_download_method_notice() {
	if rt.is_true(rt.identical(rt.new_string('redirect'), rt.call_function('get_option', [rt.new_string('woocommerce_file_download_method')]))) {
		Class_WC_Admin_Notices.add_notice('redirect_download_method')
	} else {
		Class_WC_Admin_Notices.remove_notice('redirect_download_method')
	}
}

fn Class_WC_Admin_Notices.download_directories_sync_complete() {
	mut var_notice_dismissed := rt.call_function('apply_filters', [rt.new_string('woocommerce_hide_download_directories_sync_complete'), rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('download_directories_sync_complete'), rt.new_bool(true)])])
	if rt.is_true(var_notice_dismissed) {
		Class_WC_Admin_Notices.remove_notice('download_directories_sync_complete')
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_7 := iife_temp_7.is_site_administrator()
	if rt.is_true(iife_result_7) {
		rt.include_file(@DIR + '/views/html-notice-download-dir-sync-complete.php', '1')
	}
}

fn Class_WC_Admin_Notices.maxmind_missing_license_key_notice() {
	mut var_user_dismissed_notice := rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_maxmind_license_key_notice'), rt.new_bool(true)])
	mut var_filter_dismissed_notice := rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_maxmind_geolocation_display_notices'), rt.new_bool(true)]))))
	if rt.is_true(var_user_dismissed_notice) || rt.is_true(var_filter_dismissed_notice) {
		Class_WC_Admin_Notices.remove_notice('maxmind_license_key')
		return
	}
	rt.include_file(@DIR + '/views/html-notice-maxmind-license-key.php', '1')
}

fn Class_WC_Admin_Notices.redirect_download_method_notice() {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_hide_redirect_method_nag'), rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_redirect_download_method_notice'), rt.new_bool(true)])])) {
		Class_WC_Admin_Notices.remove_notice('redirect_download_method')
		return
	}
	rt.include_file(@DIR + '/views/html-notice-redirect-only-download.php', '1')
}

fn Class_WC_Admin_Notices.uploads_directory_is_unprotected_notice() {
	if rt.is_true(rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_uploads_directory_is_unprotected_notice'), rt.new_bool(true)])) || rt.is_true(Class_WC_Admin_Notices.is_uploads_directory_protected()) {
		Class_WC_Admin_Notices.remove_notice('uploads_directory_is_unprotected')
		return
	}
	rt.include_file(@DIR + '/views/html-notice-uploads-directory-is-unprotected.php', '1')
}

fn Class_WC_Admin_Notices.base_tables_missing_notice() {
	mut var_notice_dismissed := rt.call_function('apply_filters', [rt.new_string('woocommerce_hide_base_tables_missing_nag'), rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_base_tables_missing_notice'), rt.new_bool(true)])])
	if rt.is_true(var_notice_dismissed) {
		Class_WC_Admin_Notices.remove_notice('base_tables_missing')
	}
	rt.include_file(@DIR + '/views/html-notice-base-table-missing.php', '1')
}

fn Class_WC_Admin_Notices.sync_on_read_disabled_notice() {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_8 := iife_temp_8.custom_orders_table_usage_is_enabled()
	mut var_dismiss := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()]), 'data_sync_is_enabled', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('dismissed_hpos_sync_on_read_disabled_notice'), rt.new_bool(true)])))
	if rt.is_true(var_dismiss) {
		Class_WC_Admin_Notices.remove_notice('hpos_sync_on_read_disabled')
		return
	}
	rt.include_file(@DIR + '/views/html-notice-sync-on-read-disabled.php', '1')
}

fn Class_WC_Admin_Notices.is_ssl() bool {
	mut var_shop_page := rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])
	return rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('substr', [var_shop_page.clone(), rt.new_int(0), rt.new_int(5)])))
}

fn Class_WC_Admin_Notices.is_plugin_active(var_plugin rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('is_plugin_active')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '2')
	}
	return rt.call_function('is_plugin_active', [var_plugin.clone()])
}

fn Class_WC_Admin_Notices.simplify_commerce_notice() {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Admin_Notices::simplify_commerce_notice'), rt.new_string('3.6.0')])
}

fn Class_WC_Admin_Notices.theme_check_notice() {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Admin_Notices::theme_check_notice'), rt.new_string('3.3.0')])
}

fn Class_WC_Admin_Notices.is_uploads_directory_protected() rt.PhpVal {
	mut var_cache_key := rt.new_string('_woocommerce_upload_directory_status')
	mut var_status := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_status)))) {
		return rt.identical(rt.new_string('protected'), var_status)
	}
	mut var_uploads := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	mut var_response := rt.call_function('wp_safe_remote_get', [rt.call_function('esc_url_raw', [rt.new_string((var_uploads.array_get(rt.new_string('baseurl'))).str() + '/woocommerce_uploads/')]), rt.create_array([rt.ArrayItem{ key: 'redirection', val: 0 }])])
	mut var_response_code := rt.new_int(rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]).to_i64())
	mut var_response_content := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	mut var_is_protected := rt.new_bool(rt.is_true(rt.identical(rt.new_int(200), var_response_code)) && !rt.is_true(var_response_content) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))))
	rt.call_function('set_transient', [var_cache_key.clone(), rt.new_string((if rt.is_true(var_is_protected) { 'protected' } else { 'unprotected' }).str()), rt.mul(rt.new_int(1), rt.get_constant('DAY_IN_SECONDS'))])
	return var_is_protected.clone()
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install(_args ...rt.PhpVal) &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_status(_args ...rt.PhpVal) &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Admin_Notices.init()
			return rt.new_null()
		}
		'prepare_note_with_nonce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Notices.prepare_note_with_nonce(dispatch_arg_0)
		}
		'store_notices' {
			Class_WC_Admin_Notices.store_notices()
			return rt.new_null()
		}
		'get_notices' {
			return Class_WC_Admin_Notices.get_notices()
		}
		'set_notices' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_WC_Admin_Notices.set_notices(mut dispatch_arg_0)
			return rt.new_null()
		}
		'remove_all_notices' {
			Class_WC_Admin_Notices.remove_all_notices()
			return rt.new_null()
		}
		'reset_admin_notices' {
			Class_WC_Admin_Notices.reset_admin_notices()
			return rt.new_null()
		}
		'maybe_add_legacy_api_removal_notice' {
			Class_WC_Admin_Notices.maybe_add_legacy_api_removal_notice()
			return rt.new_null()
		}
		'maybe_remove_legacy_api_removal_notice' {
			Class_WC_Admin_Notices.maybe_remove_legacy_api_removal_notice()
			return rt.new_null()
		}
		'add_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_Admin_Notices.add_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_Admin_Notices.remove_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_notices' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_Admin_Notices.remove_notices(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'has_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Notices.has_notice(dispatch_arg_0)
		}
		'hide_notices' {
			Class_WC_Admin_Notices.hide_notices()
			return rt.new_null()
		}
		'hide_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Notices.hide_notice(dispatch_arg_0)
			return rt.new_null()
		}
		'user_has_dismissed_notice' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_WC_Admin_Notices.user_has_dismissed_notice(dispatch_arg_0, mut dispatch_arg_1))
		}
		'add_notices' {
			Class_WC_Admin_Notices.add_notices()
			return rt.new_null()
		}
		'add_custom_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Admin_Notices.add_custom_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'output_custom_notices' {
			Class_WC_Admin_Notices.output_custom_notices()
			return rt.new_null()
		}
		'update_notice' {
			Class_WC_Admin_Notices.update_notice()
			return rt.new_null()
		}
		'install_notice' {
			Class_WC_Admin_Notices.install_notice()
			return rt.new_null()
		}
		'template_file_check_notice' {
			Class_WC_Admin_Notices.template_file_check_notice()
			return rt.new_null()
		}
		'legacy_shipping_notice' {
			Class_WC_Admin_Notices.legacy_shipping_notice()
			return rt.new_null()
		}
		'no_shipping_methods_notice' {
			Class_WC_Admin_Notices.no_shipping_methods_notice()
			return rt.new_null()
		}
		'regenerating_thumbnails_notice' {
			Class_WC_Admin_Notices.regenerating_thumbnails_notice()
			return rt.new_null()
		}
		'secure_connection_notice' {
			Class_WC_Admin_Notices.secure_connection_notice()
			return rt.new_null()
		}
		'regenerating_lookup_table_notice' {
			Class_WC_Admin_Notices.regenerating_lookup_table_notice()
			return rt.new_null()
		}
		'add_min_version_notice' {
			Class_WC_Admin_Notices.add_min_version_notice()
			return rt.new_null()
		}
		'wp_php_min_requirements_notice' {
			Class_WC_Admin_Notices.wp_php_min_requirements_notice()
			return rt.new_null()
		}
		'add_maxmind_missing_license_key_notice' {
			Class_WC_Admin_Notices.add_maxmind_missing_license_key_notice()
			return rt.new_null()
		}
		'add_redirect_download_method_notice' {
			Class_WC_Admin_Notices.add_redirect_download_method_notice()
			return rt.new_null()
		}
		'download_directories_sync_complete' {
			Class_WC_Admin_Notices.download_directories_sync_complete()
			return rt.new_null()
		}
		'maxmind_missing_license_key_notice' {
			Class_WC_Admin_Notices.maxmind_missing_license_key_notice()
			return rt.new_null()
		}
		'redirect_download_method_notice' {
			Class_WC_Admin_Notices.redirect_download_method_notice()
			return rt.new_null()
		}
		'uploads_directory_is_unprotected_notice' {
			Class_WC_Admin_Notices.uploads_directory_is_unprotected_notice()
			return rt.new_null()
		}
		'base_tables_missing_notice' {
			Class_WC_Admin_Notices.base_tables_missing_notice()
			return rt.new_null()
		}
		'sync_on_read_disabled_notice' {
			Class_WC_Admin_Notices.sync_on_read_disabled_notice()
			return rt.new_null()
		}
		'is_ssl' {
			return rt.new_bool(Class_WC_Admin_Notices.is_ssl())
		}
		'is_plugin_active' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Notices.is_plugin_active(dispatch_arg_0)
		}
		'simplify_commerce_notice' {
			Class_WC_Admin_Notices.simplify_commerce_notice()
			return rt.new_null()
		}
		'theme_check_notice' {
			Class_WC_Admin_Notices.theme_check_notice()
			return rt.new_null()
		}
		'is_uploads_directory_protected' {
			return Class_WC_Admin_Notices.is_uploads_directory_protected()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	Class_WC_Admin_Notices.init()
}
