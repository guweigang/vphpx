import rt

pub fn Class_WC_Helper.note_name() string {
	return 'wccom-api-failed'
}
pub fn Class_WC_Helper.cache_key_connection_data() string {
	return '_woocommerce_helper_connection_data'
}
struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn init_static_wc_helper() {
		rt.init_static_prop('WC_Helper', 'log', rt.new_null())
}

fn Class_WC_Helper.get_view_filename(var_view rt.PhpVal) string {
	return @DIR + "/views/${var_view.to_string()}"
}

fn Class_WC_Helper.load() {
	Class_WC_Helper.includes()
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'current_screen' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_output'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'render_helper_output' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'admin_enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'admin_notices' }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_loaded')])
}

fn Class_WC_Helper.remove_api_error_notice() {
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('admin-note'))
	mut var_data_store := iife_result_0
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [rt.new_string(Class_WC_Helper.note_name())])
	if !(!rt.is_true(var_note_ids)) {
		mut iter_1 := var_note_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_id := item_1.val
			mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.clone())
			if rt.is_true(var_note.get_id()) {
				rt.call_method(var_data_store, 'delete', [var_note])
			}
		}
	}
}

fn Class_WC_Helper.add_api_error_notice() {
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('admin-note'))
	mut var_data_store := iife_result_1
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [rt.new_string(Class_WC_Helper.note_name())])
	if !(!rt.is_true(var_note_ids)) {
		mut var_current_notice_id := rt.call_function('array_shift', [var_note_ids.clone()])
		mut iter_2 := var_note_ids.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_note_id := item_2.val
			mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.clone())
			if rt.is_true(var_note.get_id()) {
				rt.call_method(var_data_store, 'delete', [var_note])
			}
		}
	mut var_note := create_automattic_woocommerce_admin_notes_note(var_current_notice_id.clone())
	} else {
	var_note = create_automattic_woocommerce_admin_notes_note()
	}
	var_note.set_props(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('We’re having trouble connecting to WooCommerce.com'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: rt.call_function('__', [rt.new_string('Some subscription data may be temporarily unavailable. Please refresh the page in a few minutes to try again.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update() }, rt.ArrayItem{ key: 'name', val: Class_WC_Helper.note_name() }, rt.ArrayItem{ key: 'content_data', val: rt.array_to_object(rt.new_array()) }, rt.ArrayItem{ key: 'source', val: 'woocommerce-admin' }, rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() }, rt.ArrayItem{ key: 'is_deleted', val: false }]))
	var_note.save()
}

fn Class_WC_Helper.get_source_page() rt.PhpVal {
	mut var_page := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('page'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('page')) } else { rt.new_string('wc-admin') }])])
	return if rt.is_true(rt.call_function('in_array', [var_page.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin' }, rt.ArrayItem{ key: none, val: 'wc-addons' }]), rt.new_bool(true)])) { var_page } else { rt.new_string('wc-admin') }
}

fn Class_WC_Helper.includes() {
	rt.include_file(@DIR + '/class-wc-helper-options.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-api.php', '2')
	rt.include_file(@DIR + '/class-wc-woo-update-manager-plugin.php', '2')
	rt.include_file(@DIR + '/class-wc-woo-helper-connection.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-updater.php', '2')
	rt.include_file(@DIR + '/class-wc-plugin-api-updater.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-compat.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-sanitization.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-admin.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-subscriptions-api.php', '2')
	rt.include_file(@DIR + '/class-wc-helper-orders-api.php', '2')
	rt.include_file(@DIR + '/class-wc-product-usage-notice.php', '2')
}

fn Class_WC_Helper.render_helper_output() {
	mut iife_temp_2 := Class_WC_Helper_Options{}
	mut iife_result_2 := iife_temp_2.get(rt.new_string('auth'))
	mut var_auth := iife_result_2
	mut iife_temp_3 := Class_WC_Helper_Options{}
	mut iife_result_3 := iife_temp_3.get(rt.new_string('auth_user_data'))
	mut var_auth_user_data := iife_result_3
	mut var_notices := Class_WC_Helper._get_return_notices()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Helper.is_site_connected())))) {
		mut var_connect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-connect', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('connect')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
		rt.include_file((Class_WC_Helper.get_view_filename(rt.new_string('html-oauth-start.php'))).to_string(), '1')
		return
	}
	mut var_disconnect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-disconnect', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('disconnect')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	mut var_current_filter := Class_WC_Helper.get_current_filter()
	mut var_refresh_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-refresh', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('refresh')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	mut var_woo_plugins := Class_WC_Helper.get_local_woo_plugins()
	mut var_woo_themes := Class_WC_Helper.get_local_woo_themes()
	mut var_subscriptions_list_data := Class_WC_Helper.get_subscription_list_data()
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	mut var_subscriptions := rt.call_function('array_filter', [var_subscriptions_list_data.clone(), rt.new_closure(closure_5_fn)])
	mut iife_temp_5 := Class_WC_Helper_Updater{}
	mut iife_result_5 := iife_temp_5.get_update_data()
	mut var_updates := iife_result_5
	mut var_subscriptions_product_ids := rt.call_function('wp_list_pluck', [var_subscriptions.clone(), rt.new_string('product_id')])
	mut iter_3 := var_subscriptions.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_subscription := item_3.val
		var_subscription.array_set('activate_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-activate', val: 1 }, rt.ArrayItem{ key: 'wc-helper-product-key', val: var_subscription.array_get(rt.new_string('product_key')) }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_subscription.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('activate:' + (var_subscription.array_get(rt.new_string('product_key'))).str())]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])]))
		var_subscription.array_set('deactivate_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-deactivate', val: 1 }, rt.ArrayItem{ key: 'wc-helper-product-key', val: var_subscription.array_get(rt.new_string('product_key')) }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_subscription.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('deactivate:' + (var_subscription.array_get(rt.new_string('product_key'))).str())]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])]))
		var_subscription.array_set('update_url', rt.call_function('admin_url', [rt.new_string('update-core.php')]))
		mut var_local := rt.call_function('wp_list_filter', [rt.call_function('array_merge', [var_woo_plugins.clone(), var_woo_themes.clone()]), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_subscription.array_get(rt.new_string('product_id')) }])])
		if !(!rt.is_true(var_local)) {
			var_local = rt.call_function('array_shift', [var_local.clone()])
			if rt.is_true(rt.identical(rt.new_string('plugin'), var_local.array_get(rt.new_string('_type')))) {
				var_subscription.array_set('update_url', rt.call_function('wp_nonce_url', [rt.new_string((rt.call_function('self_admin_url', [rt.new_string('update.php?action=upgrade-plugin&plugin=')])).str() + (var_local.array_get(rt.new_string('_filename'))).str()), rt.new_string('upgrade-plugin_' + (var_local.array_get(rt.new_string('_filename'))).str())]))
			} else if rt.is_true(rt.identical(rt.new_string('theme'), var_local.array_get(rt.new_string('_type')))) {
				var_subscription.array_set('update_url', rt.call_function('wp_nonce_url', [rt.call_function('self_admin_url', [rt.new_string('update.php?action=upgrade-theme&theme=' + (var_local.array_get(rt.new_string('_stylesheet'))).str())]), rt.new_string('upgrade-theme_' + (var_local.array_get(rt.new_string('_stylesheet'))).str())]))
			}
		}
		var_subscription.array_set('download_primary', true)
		var_subscription.array_set('download_url', 'https://woocommerce.com/my-account/downloads/')
		if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed')))))) && !(!rt.is_true(var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))))) {
			var_subscription.array_set('download_url', var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('package')))
		}
		var_subscription.array_set('actions', rt.new_array())
		if rt.is_true(var_subscription.array_get(rt.new_string('has_update'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('expired')))))) {
			mut var_action := { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s is <strong>available</strong>.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('version'))])]), 'button_label': rt.call_function('__', [rt.new_string('Update'), rt.new_string('woocommerce')]), 'button_url': var_subscription.array_get(rt.new_string('update_url')), 'status': rt.new_string('update-available'), 'icon': rt.new_string('dashicons-update') }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('active')))))) {
				var_action['message'] = rt.concat(var_action['message'], rt.new_string(' ' + (rt.call_function('__', [rt.new_string('To enable this update you need to <strong>activate</strong> this subscription.'), rt.new_string('woocommerce')])).str()))
				var_action['button_label'] = rt.new_null()
				var_action['button_url'] = rt.new_null()
			}
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		}
		if rt.is_true(var_subscription.array_get(rt.new_string('has_update'))) && rt.is_true(var_subscription.array_get(rt.new_string('expired'))) {
			var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s is <strong>available</strong>.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('version'))])]), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_action['message'] = rt.concat(var_action['message'], rt.new_string(' ' + (rt.call_function('__', [rt.new_string('To enable this update you need to <strong>purchase</strong> a new subscription.'), rt.new_string('woocommerce')])).str()))
			var_action['button_label'] = rt.call_function('__', [rt.new_string('Purchase'), rt.new_string('woocommerce')])
			var_action['button_url'] = Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_subscription.array_get(rt.new_string('product_url')), rt.new_string('purchase'))
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		} else if rt.is_true(var_subscription.array_get(rt.new_string('expired'))) && !(!rt.is_true(var_subscription.array_get(rt.new_string('master_user_email')))) {
			var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription has expired. Contact the owner to <strong>renew</strong> the subscription to receive updates and support.'), rt.new_string('woocommerce')])]), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		} else if rt.is_true(var_subscription.array_get(rt.new_string('expired'))) {
			var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription has expired. Please <strong>renew</strong> to receive updates and support.'), rt.new_string('woocommerce')])]), 'button_label': rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		}
		if rt.is_true(var_subscription.array_get(rt.new_string('expiring'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get(rt.new_string('autorenew')))))) {
			var_action = { 'message': rt.call_function('__', [rt.new_string('Subscription is <strong>expiring</strong> soon.'), rt.new_string('woocommerce')]), 'button_label': rt.call_function('__', [rt.new_string('Enable auto-renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('auto-renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_subscription.array_set('download_primary', false)
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		} else if rt.is_true(var_subscription.array_get(rt.new_string('expiring'))) {
			var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription is expiring soon. Please <strong>renew</strong> to continue receiving updates and support.'), rt.new_string('woocommerce')])]), 'button_label': rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_subscription.array_set('download_primary', false)
			var_subscription.array_get_mut('actions').array_push(var_action.clone())
		}
		mut iter_4 := var_subscription.array_get(rt.new_string('actions')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_action_shadow := item_4.val
			mut var_key := item_4.key
			if !(!rt.is_true(var_action_shadow['button_label'])) {
				var_subscription.array_get_mut('actions').array_get_mut(var_key).array_set('primary', true)
				break
			}
		}
	}
	var_subscription = rt.new_null()
	mut var_no_subscriptions := rt.new_array()
	mut iter_5 := rt.call_function('array_merge', [var_woo_plugins.clone(), var_woo_themes.clone()]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_data := item_5.val
		mut var_filename := item_5.key
		if rt.is_true(rt.call_function('in_array', [var_data.array_get(rt.new_string('_product_id')), var_subscriptions_product_ids.clone()])) {
			continue
		}
		var_data.array_set('_product_url', '#')
		var_data.array_set('_has_update', false)
		if !(!rt.is_true(var_updates.array_get(var_data.array_get(rt.new_string('_product_id'))))) {
			var_data.array_set('_has_update', rt.call_function('version_compare', [var_updates.array_get(var_data.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('version')), var_data.array_get(rt.new_string('Version')), rt.new_string('>')]))
			if !(!rt.is_true(var_updates.array_get(var_data.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('url')))) {
				var_data.array_set('_product_url', var_updates.array_get(var_data.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('url')))
			} else if !(!rt.is_true(var_data.array_get(rt.new_string('PluginURI')))) {
				var_data.array_set('_product_url', var_data.array_get(rt.new_string('PluginURI')))
			}
		}
		var_data.array_set('_actions', rt.new_array())
		if rt.is_true(var_data.array_get(rt.new_string('_has_update'))) {
			mut var_action := { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s is <strong>available</strong>. To enable this update you need to <strong>purchase</strong> a new subscription.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_updates.array_get(var_data.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('version'))])]), 'button_label': rt.call_function('__', [rt.new_string('Purchase'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_data.array_get(rt.new_string('_product_url')), rt.new_string('purchase')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_data.array_get_mut('_actions').array_push(var_action.clone())
		} else {
			var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('To receive updates and support for this extension, you need to <strong>purchase</strong> a new subscription or consolidate your extensions to one connected account by <strong><a href="%1$s" title="Sharing Docs">sharing</a> or <a href="%2$s" title="Transferring Docs">transferring</a></strong> this extension to this connected account.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/managing-woocommerce-com-subscriptions/#section-10'), rt.new_string('https://woocommerce.com/document/managing-woocommerce-com-subscriptions/#section-5')]), 'button_label': rt.call_function('__', [rt.new_string('Purchase'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_data.array_get(rt.new_string('_product_url')), rt.new_string('purchase')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
			var_data.array_get_mut('_actions').array_push(var_action.clone())
		}
		var_no_subscriptions.array_set(var_filename, var_data.clone())
	}
	if !rt.is_true(var_auth.array_get(rt.new_string('user_id'))) {
		var_auth.array_set('user_id', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	mut iife_temp_6 := Class_WC_Helper_Options{}
	mut iife_result_6 := iife_temp_6.update(rt.new_string('auth'), var_auth.clone())
	}
	rt.call_function('uasort', [var_subscriptions.clone(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: '_sort_by_product_name' }])])
	rt.call_function('uasort', [var_no_subscriptions.clone(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: '_sort_by_name' }])])
	Class_WC_Helper.get_filters_counts(var_subscriptions.clone())
	Class_WC_Helper._filter(var_subscriptions.clone(), Class_WC_Helper.get_current_filter())
	rt.include_file((Class_WC_Helper.get_view_filename(rt.new_string('html-main.php'))).to_string(), '1')
	return
}

fn Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_url rt.PhpVal, var_utm_content rt.PhpVal) string {
	mut var_url_mutated := var_url
	mut var_utm_params := rt.new_string('utm_source=subscriptionsscreen&' + 'utm_medium=product&' + 'utm_campaign=wcaddons&' + 'utm_content=' + (var_utm_content).str())
	if rt.is_true(rt.call_function('strpos', [var_url_mutated.clone(), rt.new_string('?')])) {
		return (var_url_mutated).str() + '&' + (var_utm_params).str()
	}
	return (var_url_mutated).str() + '?' + (var_utm_params).str()
}

fn Class_WC_Helper.get_filters() rt.PhpVal {
	mut var_filters := rt.create_array([rt.ArrayItem{ key: 'all', val: rt.call_function('__', [rt.new_string('All'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'active', val: rt.call_function('__', [rt.new_string('Active'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'inactive', val: rt.call_function('__', [rt.new_string('Inactive'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'installed', val: rt.call_function('__', [rt.new_string('Installed'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'update-available', val: rt.call_function('__', [rt.new_string('Update Available'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'expiring', val: rt.call_function('__', [rt.new_string('Expiring Soon'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'expired', val: rt.call_function('__', [rt.new_string('Expired'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download', val: rt.call_function('__', [rt.new_string('Download'), rt.new_string('woocommerce')]) }])
	return var_filters.clone()
}

fn Class_WC_Helper.get_filters_counts(var_subscriptions rt.PhpVal) rt.PhpVal {
	mut var_subscriptions_mutated := var_subscriptions
	mut var_filters := rt.new_null()
	if !(var_filters).is_null() {
		return var_filters.clone()
	}
	var_filters = rt.call_function('array_fill_keys', [rt.func_array_keys(Class_WC_Helper.get_filters()), rt.new_int(0)])
	if !(var_subscriptions_mutated.clone().is_array()) || !rt.is_true(var_subscriptions_mutated) {
		return rt.new_array()
	}
	mut iter_6 := var_filters.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_count := item_6.val
		mut var_key := item_6.key
		mut var__subs := var_subscriptions_mutated.clone()
		Class_WC_Helper._filter(var__subs.clone(), var_key.clone())
		var_filters.array_set(var_key, var__subs.clone().array_count())
	}
	return var_filters.clone()
}

fn Class_WC_Helper.get_current_filter() rt.PhpVal {
	mut var_current_filter := rt.new_string('all')
	mut var_valid_filters := rt.func_array_keys(Class_WC_Helper.get_filters())
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter')))) && rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('filter'))]), var_valid_filters.clone()])) {
	var_current_filter = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('filter'))])])
	}
	return var_current_filter.clone()
}

fn Class_WC_Helper._filter(var_subscriptions rt.PhpVal, var_filter rt.PhpVal) {
	mut var_subscriptions_mutated := var_subscriptions
	mut switch_val_1 := var_filter
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('active'))) {
	var_subscriptions_mutated = rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'active', val: true }])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('inactive'))) {
	var_subscriptions_mutated = rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'active', val: false }])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('installed'))) {
		mut iter_7 := var_subscriptions_mutated.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_subscription := item_7.val
			mut var_key := item_7.key
			if !rt.is_true(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))) {
				var_subscriptions_mutated.array_unset(var_key)
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-available'))) {
	var_subscriptions_mutated = rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'has_update', val: true }])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('expiring'))) {
	var_subscriptions_mutated = rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'expiring', val: true }])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('expired'))) {
	var_subscriptions_mutated = rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'expired', val: true }])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download'))) {
		mut iter_8 := var_subscriptions_mutated.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_subscription := item_8.val
			mut var_key := item_8.key
			if rt.is_true(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))) || rt.is_true(var_subscription.array_get(rt.new_string('expired'))) {
				var_subscriptions_mutated.array_unset(var_key)
			}
		}
	}
}

fn Class_WC_Helper.admin_enqueue_scripts() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	mut var_wc_screen_id := rt.new_string('woocommerce')
	if rt.is_true(rt.identical((var_wc_screen_id).str() + '_page_wc-addons', var_screen_id)) || rt.is_true(rt.identical((var_wc_screen_id).str() + '_page_wc-admin', var_screen_id)) && rt.get_superglobal('_GET').array_isset(rt.new_string('section')) && rt.is_true(rt.identical(rt.new_string('helper'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))) {
		mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('WC_VERSION'))
		rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-helper'), rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/helper.css'), rt.new_array(), iife_result_7])
		rt.call_function('wp_style_add_data', [rt.new_string('woocommerce-helper'), rt.new_string('rtl'), rt.new_string('replace')])
	}
}

fn Class_WC_Helper._get_return_notices() rt.PhpVal {
	mut var_return_status := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-status')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-status'))])]) } else { rt.new_null() }
	mut var_notices := rt.new_array()
	mut switch_val_2 := var_return_status
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('activate-success'))) {
		mut var_product_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		mut var_subscription := Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'updated' }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s activated successfully. You will now receive updates for this product.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>')]) }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('activate-error'))) {
		var_product_id = if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		var_subscription = Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error has occurred when activating %s. Please try again later.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>')]) }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('deactivate-success'))) {
		var_product_id = if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		var_subscription = Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		mut var_local := Class_WC_Helper._get_local_from_product_id(var_product_id.clone())
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Subscription for %s deactivated successfully. You will no longer receive updates for this product.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>')])
		if rt.is_true(var_local) && rt.is_true(rt.call_function('is_plugin_active', [var_local.array_get(rt.new_string('_filename'))])) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')])) {
		mut var_deactivate_plugin_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: Class_WC_Helper.get_current_filter() }, rt.ArrayItem{ key: 'wc-helper-deactivate-plugin', val: 1 }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_subscription.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('deactivate-plugin:' + (var_subscription.array_get(rt.new_string('product_id'))).str())]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Subscription for %1$s deactivated successfully. You will no longer receive updates for this product. <a href="%2$s">Click here</a> if you wish to deactivate the plugin as well.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>'), rt.call_function('esc_url', [var_deactivate_plugin_url.clone()])])
		}
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'type', val: 'updated' }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('deactivate-error'))) {
		var_product_id = if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		var_subscription = Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error has occurred when deactivating the subscription for %s. Please try again later.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>')]) }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('deactivate-plugin-success'))) {
		var_product_id = if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		var_subscription = Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'updated' }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The extension %s has been deactivated successfully.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>')]) }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('deactivate-plugin-error'))) {
		var_product_id = if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
		var_subscription = Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool())
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error has occurred when deactivating the extension %1$s. Please proceed to the <a href="%2$s">Plugins screen</a> to deactivate it manually.'), rt.new_string('woocommerce')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_subscription.array_get(rt.new_string('product_name'))])).str() + '</strong>'), rt.call_function('admin_url', [rt.new_string('plugins.php')])]) }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('helper-connected'))) {
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('You have successfully connected your store to WooCommerce.com'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'updated' }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('helper-disconnected'))) {
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('You have successfully disconnected your store from WooCommerce.com'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'updated' }]))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('helper-refreshed'))) {
		var_notices.array_push(rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Authentication and subscription caches refreshed successfully.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'updated' }]))
	}
	return var_notices.clone()
}

fn Class_WC_Helper.current_screen(var_screen rt.PhpVal) rt.PhpVal {
	mut var_screen_mutated := var_screen
	mut var_wc_screen_id := rt.new_string('woocommerce')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical((var_wc_screen_id).str() + '_page_wc-addons', rt.get_property(var_screen_mutated, 'id'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical((var_wc_screen_id).str() + '_page_wc-admin', rt.get_property(var_screen_mutated, 'id'))))) {
		return rt.new_null()
	}
	Class_WC_Helper.maybe_redirect_to_new_marketplace_installer()
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('section'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('helper'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))))) {
		return rt.new_null()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-connect')))) {
		return Class_WC_Helper._helper_auth_connect()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-return')))) {
		return Class_WC_Helper._helper_auth_return()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-disconnect')))) {
		return Class_WC_Helper._helper_auth_disconnect()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-refresh')))) {
		return Class_WC_Helper._helper_auth_refresh()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-activate')))) {
		return Class_WC_Helper._helper_subscription_activate()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-deactivate')))) {
		return Class_WC_Helper.helper_subscription_deactivate()
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-deactivate-plugin')))) {
		return Class_WC_Helper._helper_plugin_deactivate()
	}
	return rt.new_null()
}

fn Class_WC_Helper.maybe_redirect_to_new_marketplace_installer() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('install'))) {
		return
	}
	rt.call_function('wp_safe_redirect', [Class_WC_Helper.get_helper_redirect_url(rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }]))])
}

fn Class_WC_Helper.get_helper_redirect_url(var_args rt.PhpVal) rt.PhpVal {
	mut var_current_screen := rt.new_null()
	mut var_redirect_admin_url := if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect_admin_url')) { rt.call_function('esc_url_raw', [rt.call_function('urldecode', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('redirect_admin_url'))])])]) } else { rt.new_string('') }
	mut var_install_product_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('install')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('install'))])]) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-addons'), rt.get_property(var_current_screen, 'id'))) || rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-admin'), rt.get_property(var_current_screen, 'id'))) && rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(!rt.is_true(var_redirect_admin_url)))) || rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(!rt.is_true(var_install_product_key)))) {
		if rt.is_true(rt.identical(rt.call_function('strpos', [var_redirect_admin_url.clone(), rt.call_function('admin_url', [rt.new_string('admin.php')])]), rt.new_int(0))) {
		mut var_new_url := var_redirect_admin_url.clone()
		} else {
		var_new_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' }, rt.ArrayItem{ key: 'tab', val: 'my-subscriptions' }, rt.ArrayItem{ key: 'path', val: rt.call_function('rawurlencode', [rt.new_string('/extensions')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
		}
		if !(!rt.is_true(var_install_product_key)) {
		var_new_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'install', val: var_install_product_key }]), var_new_url.clone()])
		}
		return var_new_url.clone()
	}
	return rt.call_function('add_query_arg', [var_args.clone(), rt.call_function('admin_url', [rt.new_string('admin.php')])])
}

fn Class_WC_Helper._helper_auth_connect() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('connect')]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_auth_connect')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	mut var_redirect_url_args := { 'page': Class_WC_Helper.get_source_page(), 'section': rt.new_string('helper'), 'wc-helper-return': rt.new_int(1), 'wc-helper-nonce': rt.call_function('wp_create_nonce', [rt.new_string('connect')]) }
	if rt.get_superglobal('_GET').array_isset(rt.new_string('install')) {
		var_redirect_url_args['install'] = rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('install'))])])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('utm_source')) {
		var_redirect_url_args['utm_source'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('utm_source'))])])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('utm_campaign')) {
		var_redirect_url_args['utm_campaign'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('utm_campaign'))])])
	}
	mut var_redirect_uri := rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_redirect_url_args), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	mut iife_temp_8 := Class_WC_Helper_API{}
	mut iife_result_8 := iife_temp_8.post(rt.new_string('oauth/request_token'), rt.create_array([rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'redirect_uri', val: var_redirect_uri }]) }]))
	mut var_request := iife_result_8
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Call to oauth/request_token returned a non-200 response code (%d)'), var_code.clone()])).str())
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	mut var_secret := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()])])
	if !rt.is_true(var_secret) {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Call to oauth/request_token returned an invalid body: %s'), rt.call_function('wp_remote_retrieve_body', [var_request.clone()])])).str())
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connect_start')])
	rt.call_function('delete_metadata', [rt.new_string('user'), rt.new_int(0), Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_connect_notice(), rt.new_string(''), rt.new_bool(true)])
	mut iife_temp_9 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_9 := iife_temp_9.is_plugin_installed()
	mut iife_temp_10 := Class_WC_Helper_API{}
	mut iife_result_10 := iife_temp_10.url(rt.new_string('oauth/authorize'))
	mut var_connect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('rawurlencode', [rt.call_function('home_url', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'redirect_uri', val: rt.call_function('rawurlencode', [var_redirect_uri.clone()]) }, rt.ArrayItem{ key: 'secret', val: rt.call_function('rawurlencode', [var_secret.clone()]) }, rt.ArrayItem{ key: 'redirect_admin_url', val: if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect_admin_url')) { rt.call_function('rawurlencode', [rt.call_function('esc_url_raw', [rt.call_function('urldecode', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('redirect_admin_url'))])])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'wum-installed', val: if rt.is_true(iife_result_9) { '1' } else { '0' } }]), iife_result_10])
	rt.call_function('wp_redirect', [rt.call_function('esc_url_raw', [var_connect_url.clone()])])
	exit(0)
}

fn Class_WC_Helper._helper_auth_return() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('connect')]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_auth_return')
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('deny')))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_denied')])
		rt.call_function('wp_safe_redirect', [Class_WC_Helper.get_helper_redirect_url(rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }]))])
		exit(0)
	}
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('request_token'))) {
		Class_WC_Helper.log('Request token not found in _helper_auth_return')
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	mut iife_temp_11 := Class_WC_Helper_API{}
	mut iife_result_11 := iife_temp_11.post(rt.new_string('oauth/access_token'), rt.create_array([rt.ArrayItem{ key: 'timeout', val: 30 }, rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'request_token', val: rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('request_token'))]) }, rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) }]) }]))
	mut var_request := iife_result_11
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Call to oauth/access_token returned a non-200 response code (%d)'), var_code.clone()])).str())
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	mut var_access_token := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_access_token)))) {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Call to oauth/access_token returned an invalid body: %s'), rt.call_function('wp_remote_retrieve_body', [var_request.clone()])])).str())
		rt.call_function('wp_die', [rt.new_string('Something went wrong')])
	}
	Class_WC_Helper.update_auth_option((var_access_token.array_get(rt.new_string('access_token'))).str(), (var_access_token.array_get(rt.new_string('access_token_secret'))).str(), (var_access_token.array_get(rt.new_string('site_id'))).to_i64(), (rt.call_function('home_url', []rt.PhpVal{})).str())
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_connected')])
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracker')])) {
		mut var_prev_value := rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('no')])
		rt.call_function('update_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('yes')])
		mut iife_temp_12 := Class_WC_Tracker{}
		mut iife_result_12 := iife_temp_12.send_tracking_data(rt.new_bool(true))
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracks')])) && rt.is_true(rt.identical(rt.new_string('no'), var_prev_value)) {
		mut iife_temp_13 := Class_WC_Tracks{}
		mut iife_result_13 := iife_temp_13.track_woocommerce_allow_tracking_toggled(var_prev_value.clone(), rt.new_string('yes'), rt.new_string('wccom_connect'))
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wccom-install-url')))) {
		rt.call_function('wp_redirect', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wccom-install-url'))])])
		exit(0)
	}
	rt.call_function('wp_safe_redirect', [Class_WC_Helper.get_helper_redirect_url(rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-status', val: 'helper-connected' }]))])
	exit(0)
}

fn Class_WC_Helper._helper_auth_disconnect() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('disconnect')]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_auth_disconnect')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_disconnected')])
	mut var_redirect_uri := Class_WC_Helper.get_helper_redirect_url(rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-status', val: 'helper-disconnected' }]))
	Class_WC_Helper.disconnect()
	rt.call_function('wp_safe_redirect', [var_redirect_uri.clone()])
	exit(0)
}

fn Class_WC_Helper._helper_auth_refresh() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('refresh')]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_auth_refresh')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	Class_WC_Helper.refresh_helper_subscriptions()
	mut var_redirect_uri := Class_WC_Helper.get_helper_redirect_url(rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: Class_WC_Helper.get_current_filter() }, rt.ArrayItem{ key: 'wc-helper-status', val: 'helper-refreshed' }]))
	rt.call_function('wp_safe_redirect', [var_redirect_uri.clone()])
	exit(0)
}

fn Class_WC_Helper.refresh_helper_subscriptions() {
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscriptions_refresh')])
	Class_WC_Helper._flush_authentication_cache()
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	Class_WC_Helper.flush_product_usage_notice_rules_cache()
}

fn Class_WC_Helper._helper_subscription_activate() {
	mut var_product_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-key')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-key'))])]) } else { rt.new_string('') }
	mut var_product_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('activate:' + (var_product_key).str())]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_subscription_activate')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	mut var_activated := Class_WC_Helper.activate_helper_subscription(var_product_key.clone(), var_product_id.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		var_activated = rt.new_bool(false)
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	mut var_redirect_uri := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: Class_WC_Helper.get_current_filter() }, rt.ArrayItem{ key: 'wc-helper-status', val: if rt.is_true(var_activated) { 'activate-success' } else { 'activate-error' } }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_product_id }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	rt.call_function('wp_safe_redirect', [var_redirect_uri.clone()])
	exit(0)
}

fn Class_WC_Helper.activate_helper_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
	mut var_product_key_mutated := var_product_key
	mut var_subscription := Class_WC_Helper.get_subscription(var_product_key_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Subscription not found'), rt.new_string('woocommerce')]))))
	}
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	mut list_tmp_1 := Class_WC_Helper.wccom_activate(var_product_key_mutated.clone())
	var_activation_response = (list_tmp_1).array_get(0)
	var_activated = (list_tmp_1).array_get(1)
	var_body = (list_tmp_1).array_get(2)
	if rt.is_true(var_activated) {
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_success'), var_product_id.clone(), var_product_key_mutated.clone(), var_activation_response.clone()])
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_error'), var_product_id.clone(), var_product_key_mutated.clone(), var_activation_response.clone()])
		mut var_status_code := rt.new_int(if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_remote_retrieve_response_code')])) { rt.new_int((rt.call_function('wp_remote_retrieve_response_code', [var_activation_response.clone()])).to_i64()) } else { rt.new_int((if !(var_body.array_get(rt.new_string('data')).array_get(rt.new_string('status'))).is_null() { var_body.array_get(rt.new_string('data')).array_get(rt.new_string('status')) } else { rt.new_int(400) }).to_i64()) })
		mut var_error_data := if var_body.array_isset(rt.new_string('data')) && var_body.array_get(rt.new_string('data')).is_array() { var_body.array_get(rt.new_string('data')) } else { rt.new_array() }
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(rt.call_function('esc_html', [if !(var_body.array_get(rt.new_string('code'))).is_null() { var_body.array_get(rt.new_string('code')) } else { rt.new_string('unknown_error') }]), if var_body.array_isset(rt.new_string('message')) { rt.call_function('esc_html', [var_body.array_get(rt.new_string('message'))]) } else { rt.call_function('esc_html__', [rt.new_string('Unknown error'), rt.new_string('woocommerce')]) }, rt.new_int((var_status_code).to_i64()), if rt.is_true(rt.call_function('function_exists', [rt.new_string('map_deep')])) { rt.call_function('map_deep', [var_error_data.clone(), rt.new_string('esc_html')]) } else { rt.call_function('array_map', [rt.new_string('esc_html'), var_error_data.clone()]) })))
	}
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	Class_WC_Helper.flush_product_usage_notice_rules_cache()
	return var_activated.clone()
}

fn Class_WC_Helper.activate_plugin(var_product_key rt.PhpVal) bool {
	mut var_product_key_mutated := var_product_key
	mut var_subscription := Class_WC_Helper.get_subscription(var_product_key_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Subscription not found'), rt.new_string('woocommerce')])]))))
	}
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	mut var_local := Class_WC_Helper._get_local_from_product_id(var_product_id.clone())
	if rt.is_true(rt.call_function('is_plugin_active', [var_local.array_get(rt.new_string('_filename'))])) {
		return true
	}
	mut var_response := rt.new_bool(false)
	if rt.is_true(var_local) && rt.is_true(rt.identical(rt.new_string('plugin'), var_local.array_get(rt.new_string('_type')))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')])) {
		var_response = rt.call_function('activate_plugin', [var_local.array_get(rt.new_string('_filename'))])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
			Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Error activating plugin (%s)'), rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})])).str())
		}
	var_response = rt.identical(rt.new_null(), var_response)
	}
	return (var_response).to_bool()
}

fn Class_WC_Helper.helper_subscription_deactivate() {
	mut var_product_key := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-key')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-key'))])]) } else { rt.new_string('') }
	mut var_product_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('deactivate:' + (var_product_key).str())]))))) {
		Class_WC_Helper.log('Could not verify nonce in helper_subscription_deactivate')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	mut var_deactivated := Class_WC_Helper.deactivate_helper_subscription(var_product_key.clone())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		var_deactivated = rt.new_bool(false)
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	mut var_redirect_uri := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: Class_WC_Helper.get_current_filter() }, rt.ArrayItem{ key: 'wc-helper-status', val: if rt.is_true(var_deactivated) { 'deactivate-success' } else { 'deactivate-error' } }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_product_id }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	rt.call_function('wp_safe_redirect', [var_redirect_uri.clone()])
	exit(0)
}

fn Class_WC_Helper.deactivate_helper_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
	mut var_subscription := Class_WC_Helper.get_subscription(var_product_key_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Subscription not found'), rt.new_string('woocommerce')]))))
	}
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	mut iife_temp_14 := Class_WC_Helper_API{}
	mut iife_result_14 := iife_temp_14.post(rt.new_string('deactivate'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'product_key', val: var_product_key_mutated }])]) }]))
	mut var_deactivation_response := iife_result_14
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_deactivation_response.clone()])
	mut var_deactivated := rt.identical(rt.new_int(200), var_code)
	if rt.is_true(var_deactivated) {
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_deactivate_success'), var_product_id.clone(), var_product_key_mutated.clone(), var_deactivation_response.clone()])
	} else {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Deactivate API call returned a non-200 response code (%d)'), var_code.clone()])).str())
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_deactivate_error'), var_product_id.clone(), var_product_key_mutated.clone(), var_deactivation_response.clone()])
		mut var_body := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_deactivation_response.clone()]), rt.new_bool(true)])
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(if !(var_body.array_get(rt.new_string('message'))).is_null() { var_body.array_get(rt.new_string('message')) } else { rt.call_function('__', [rt.new_string('Unknown error'), rt.new_string('woocommerce')]) })))
	}
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	Class_WC_Helper.flush_product_usage_notice_rules_cache()
	return var_deactivated.clone()
}

fn Class_WC_Helper.get_subscription_install_url(var_product_key rt.PhpVal, var_product_slug rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
	mut var_install_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product-key', val: rt.call_function('rawurlencode', [var_product_key_mutated.clone()]) }]), rt.new_string((Class_WC_Helper.get_install_base_url()).str() + "${var_product_slug.to_string()}/")])
	mut iife_temp_15 := Class_WC_Helper_API{}
	mut iife_result_15 := iife_temp_15.add_auth_parameters(var_install_url.clone())
	return iife_result_15
}

fn Class_WC_Helper._helper_plugin_deactivate() {
	mut var_product_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-product-id')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-product-id'))]) } else { rt.new_int(0) }
	mut var_deactivated := rt.new_bool(false)
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-helper-nonce'))]), rt.new_string('deactivate-plugin:' + (var_product_id).str())]))))) {
		Class_WC_Helper.log('Could not verify nonce in _helper_plugin_deactivate')
		rt.call_function('wp_die', [rt.new_string('Could not verify nonce')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		rt.call_function('wp_die', [rt.new_string('You are not allowed to manage plugins on this site.')])
	}
	mut var_local := rt.call_function('wp_list_filter', [rt.call_function('array_merge', [Class_WC_Helper.get_local_woo_plugins(), Class_WC_Helper.get_local_woo_themes()]), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_product_id }])])
	if !(!rt.is_true(var_local)) {
		var_local = rt.call_function('array_shift', [var_local.clone()])
		if rt.is_true(rt.call_function('is_plugin_active', [var_local.array_get(rt.new_string('_filename'))])) {
			rt.call_function('deactivate_plugins', [var_local.array_get(rt.new_string('_filename'))])
		}
	var_deactivated = rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_local.array_get(rt.new_string('_filename'))]))))
	}
	mut var_redirect_uri := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: Class_WC_Helper.get_current_filter() }, rt.ArrayItem{ key: 'wc-helper-status', val: if rt.is_true(var_deactivated) { 'deactivate-plugin-success' } else { 'deactivate-plugin-error' } }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_product_id }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	rt.call_function('wp_safe_redirect', [var_redirect_uri.clone()])
	exit(0)
}

fn Class_WC_Helper._get_local_from_product_id(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	mut var_local := rt.call_function('wp_list_filter', [rt.call_function('array_merge', [Class_WC_Helper.get_local_woo_plugins(), Class_WC_Helper.get_local_woo_themes()]), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_product_id_mutated }])])
	if !(!rt.is_true(var_local)) {
		return (rt.call_function('array_shift', [var_local.clone()])).to_bool()
	}
	return false
}

fn Class_WC_Helper.has_product_subscription(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	mut var_subscription := Class_WC_Helper._get_subscriptions_from_product_id((var_product_id_mutated).to_bool(), rt.new_bool(true))
	return !(!rt.is_true(var_subscription))
}

fn Class_WC_Helper.get_installed_subscriptions() rt.PhpVal {
	mut var_installed_subscriptions := rt.new_null()
	if rt.is_true(rt.new_bool(var_installed_subscriptions.clone().is_null())) {
		mut iife_temp_16 := Class_WC_Helper_Options{}
		mut iife_result_16 := iife_temp_16.get(rt.new_string('auth'))
		mut var_auth := iife_result_16
		mut var_site_id := if var_auth.array_isset(rt.new_string('site_id')) { rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))]) } else { rt.new_int(0) }
		if rt.is_true(rt.identical(rt.new_int(0), var_site_id)) {
			var_installed_subscriptions = rt.new_array()
			return var_installed_subscriptions.clone()
		}
	closure_18_fn := fn [var_site_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [var_site_id.clone(), var_subscription.array_get(rt.new_string('connections')), rt.new_bool(true)])
		}
	var_installed_subscriptions = rt.call_function('array_filter', [Class_WC_Helper.get_subscriptions(), rt.new_closure(closure_18_fn)])
	}
	return var_installed_subscriptions.clone()
}

fn Class_WC_Helper.get_unconnected_subscriptions() rt.PhpVal {
	mut var_unconnected_subscriptions := rt.new_null()
	if rt.is_true(rt.new_bool(var_unconnected_subscriptions.clone().is_null())) {
		mut iife_temp_18 := Class_WC_Helper_Options{}
		mut iife_result_18 := iife_temp_18.get(rt.new_string('auth'))
		mut var_auth := iife_result_18
		mut var_site_id := if var_auth.array_isset(rt.new_string('site_id')) { rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))]) } else { rt.new_int(0) }
		if rt.is_true(rt.identical(rt.new_int(0), var_site_id)) {
			var_unconnected_subscriptions = rt.new_array()
			return var_unconnected_subscriptions.clone()
		}
	closure_20_fn := fn [var_site_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(var_subscription.array_get(rt.new_string('connections'))))
		}
	var_unconnected_subscriptions = rt.call_function('array_filter', [Class_WC_Helper.get_subscriptions(), rt.new_closure(closure_20_fn)])
	}
	return var_unconnected_subscriptions.clone()
}

fn Class_WC_Helper.get_product_subscription_state(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_product_subscriptions := rt.call_function('wp_list_filter', [Class_WC_Helper.get_installed_subscriptions(), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id_mutated }])])
	mut var_subscription := if !(!rt.is_true(var_product_subscriptions)) { rt.call_function('array_shift', [var_product_subscriptions.clone()]) } else { rt.new_array() }
	return rt.create_array([rt.ArrayItem{ key: 'unregistered', val: rt.new_bool(!rt.is_true(var_subscription)) }, rt.ArrayItem{ key: 'expired', val: var_subscription.array_isset(rt.new_string('expired')) && rt.is_true(var_subscription.array_get(rt.new_string('expired'))) }, rt.ArrayItem{ key: 'expiring', val: var_subscription.array_isset(rt.new_string('expiring')) && rt.is_true(var_subscription.array_get(rt.new_string('expiring'))) }, rt.ArrayItem{ key: 'key', val: if !(var_subscription.array_get(rt.new_string('product_key'))).is_null() { var_subscription.array_get(rt.new_string('product_key')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'order_id', val: if !(var_subscription.array_get(rt.new_string('order_id'))).is_null() { var_subscription.array_get(rt.new_string('order_id')) } else { rt.new_string('') } }])
}

fn Class_WC_Helper._get_subscriptions_from_product_id(var_product_id rt.PhpVal, single bool) bool {
	mut var_product_id_mutated := var_product_id
	mut var_subscriptions := rt.call_function('wp_list_filter', [Class_WC_Helper.get_subscriptions(), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id_mutated }])])
	if !(!rt.is_true(var_subscriptions)) {
		return (if var_single { rt.call_function('array_shift', [var_subscriptions.clone()]) } else { var_subscriptions }).to_bool()
	}
	return false
}

fn Class_WC_Helper.get_local_plugins() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_output_plugins := rt.new_array()
	mut iter_9 := var_plugins.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_data := item_9.val
		mut var_filename := item_9.key
		var_output_plugins.clone().array_push(rt.create_array([rt.ArrayItem{ key: '_filename', val: var_filename }, rt.ArrayItem{ key: '_type', val: 'plugin' }, rt.ArrayItem{ key: 'slug', val: rt.call_function('dirname', [var_filename.clone()]) }, rt.ArrayItem{ key: 'Version', val: var_data.array_get(rt.new_string('Version')) }]))
	}
	return var_output_plugins.clone()
}

fn Class_WC_Helper.get_local_themes() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_themes')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	}
	mut var_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	mut var_output_themes := rt.new_array()
	mut iter_10 := var_themes.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_theme := item_10.val
		var_output_themes.clone().array_push(rt.create_array([rt.ArrayItem{ key: '_filename', val: (rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})).str() + '/style.css' }, rt.ArrayItem{ key: '_stylesheet', val: rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: '_type', val: 'theme' }, rt.ArrayItem{ key: 'slug', val: rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'Version', val: rt.call_method(var_theme, 'get', [rt.new_string('Version')]) }]))
	}
	return var_output_themes.clone()
}

fn Class_WC_Helper.get_local_woo_plugins() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_file_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	if !(!rt.is_true(var_plugins)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('current', [var_plugins.clone()]).array_isset(rt.new_string('Woo'))))))) {
		rt.call_function('wp_clean_plugins_cache', [rt.new_bool(false)])
	var_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
	}
	mut var_woo_plugins := rt.new_array()
	mut var__compat := rt.new_array()
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('woothemes_queued_updates')))) {
		mut iter_11 := var_GLOBALS.array_get(rt.new_string('woothemes_queued_updates')).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var__compat_plugin := item_11.val
			var__compat.array_set(rt.get_property(var__compat_plugin, 'file'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.get_property(var__compat_plugin, 'product_id') }, rt.ArrayItem{ key: 'file_id', val: rt.get_property(var__compat_plugin, 'file_id') }]))
		}
	}
	mut iter_12 := var_plugins.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_data := item_12.val
		mut var_filename := item_12.key
		if !rt.is_true(var_data.array_get(rt.new_string('Woo'))) && !(!rt.is_true(var__compat.array_get(var_filename))) {
			var_data.array_set('Woo', rt.call_function('sprintf', [rt.new_string('%d:%s'), var__compat.array_get(var_filename).array_get(rt.new_string('product_id')), var__compat.array_get(var_filename).array_get(rt.new_string('file_id'))]))
		}
		if !rt.is_true(var_data.array_get(rt.new_string('Woo'))) {
			continue
		}
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string(':'), var_data.array_get(rt.new_string('Woo'))])
		var_product_id = (list_tmp_2).array_get(0)
		var_file_id = (list_tmp_2).array_get(1)
		if !rt.is_true(var_product_id) || !rt.is_true(var_file_id) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('WooCommerce'), var_data.array_get(rt.new_string('Name')))) {
			continue
		}
		var_data.array_set('_filename', var_filename.clone())
		var_data.array_set('_product_id', rt.call_function('absint', [var_product_id.clone()]))
		var_data.array_set('_file_id', var_file_id.clone())
		var_data.array_set('_type', 'plugin')
		var_data.array_set('slug', rt.call_function('dirname', [var_filename.clone()]))
		var_woo_plugins.array_set(var_filename, var_data.clone())
	}
	return var_woo_plugins.clone()
}

fn Class_WC_Helper.get_local_woo_themes() rt.PhpVal {
	mut var_product_id := rt.new_null()
	mut var_file_id := rt.new_null()
	mut var_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	mut var_woo_themes := rt.new_array()
	mut iter_13 := var_themes.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_theme := item_13.val
		mut var_header := rt.call_method(var_theme, 'get', [rt.new_string('Woo')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_header)))) {
			mut var_txt := rt.new_string((rt.call_method(var_theme, 'get_stylesheet_directory', []rt.PhpVal{})).str() + '/theme_info.txt')
			if rt.is_true(rt.call_function('is_readable', [var_txt.clone()])) {
				var_txt = rt.call_function('file_get_contents', [var_txt.clone()])
				var_txt = rt.call_function('preg_split', [rt.new_string('#\\s#'), var_txt.clone()])
				if var_txt.clone().is_array() && var_txt.clone().array_count() >= 2 {
				var_header = rt.call_function('sprintf', [rt.new_string('%d:%s'), var_txt.array_get(rt.new_int(0)), var_txt.array_get(rt.new_int(1))])
				}
			}
		}
		if !rt.is_true(var_header) {
			continue
		}
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string(':'), var_header.clone()])
		var_product_id = (list_tmp_3).array_get(0)
		var_file_id = (list_tmp_3).array_get(1)
		if !rt.is_true(var_product_id) || !rt.is_true(var_file_id) {
			continue
		}
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'Name', val: rt.call_method(var_theme, 'get', [rt.new_string('Name')]) }, rt.ArrayItem{ key: 'Version', val: rt.call_method(var_theme, 'get', [rt.new_string('Version')]) }, rt.ArrayItem{ key: 'Woo', val: var_header }, rt.ArrayItem{ key: '_filename', val: (rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})).str() + '/style.css' }, rt.ArrayItem{ key: '_stylesheet', val: rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: '_product_id', val: rt.call_function('absint', [var_product_id.clone()]) }, rt.ArrayItem{ key: '_file_id', val: var_file_id }, rt.ArrayItem{ key: '_type', val: 'theme' }, rt.ArrayItem{ key: 'slug', val: rt.call_function('dirname', [rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})]) }])
		var_woo_themes.array_set(var_data.array_get(rt.new_string('_filename')), var_data.clone())
	}
	return var_woo_themes.clone()
}

fn Class_WC_Helper.get_product_usage_notice_rules() rt.PhpVal {
	mut var_cache_key := rt.new_string('_woocommerce_helper_product_usage_notice_rules')
	mut var_data := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_data)))) {
		if rt.is_true(rt.new_bool(var_data.clone().is_array())) {
			return var_data.clone()
		}
		rt.call_function('delete_transient', [var_cache_key.clone()])
	}
	mut iife_temp_20 := Class_WC_Helper_API{}
	mut iife_result_20 := iife_temp_20.get(rt.new_string('product-usage-notice-rules'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: false }, rt.ArrayItem{ key: 'timeout', val: 2 }]))
	mut var_request := iife_result_20
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}), rt.new_int((rt.call_method(var_request, 'get_error_data', []rt.PhpVal{})).to_i64()))))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(Class_WC_Helper.get_message_for_response_code((var_code).to_i64()), var_code.clone())))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_data = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if !(var_data.clone().is_array()) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('WooCommerce.com API returned an invalid response.'), rt.new_string('woocommerce')]), rt.new_int(422))))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_function('set_transient', [var_cache_key.clone(), var_data.clone(), rt.get_constant('DAY_IN_SECONDS')])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	Class_WC_Helper.remove_api_error_notice()
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	return var_data.clone()
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.clone()
		if rt.is_true(rt.less(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.new_int(404))) {
			Class_WC_Helper.remove_api_error_notice()
		} else {
			Class_WC_Helper.log('Error getting product usage notice rules: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.new_string('error'))
			Class_WC_Helper.add_api_error_notice()
		}
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.new_array()
}

fn Class_WC_Helper.verify_request_hash(request_hash string) bool {
	mut iife_temp_21 := Class_WC_Helper_API{}
	mut iife_result_21 := iife_temp_21.get(rt.new_string('verify-request-hash'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'query_string', val: '?request_hash=' + request_hash }]))
	mut var_request := iife_result_21
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()]), rt.new_int(200))))) {
		return false
	}
	mut var_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	return var_data.array_isset(rt.new_string('success')) && rt.is_true(rt.identical(rt.new_bool(true), var_data.array_get(rt.new_string('success'))))
}

fn Class_WC_Helper.get_cached_connection_data() rt.PhpVal {
	mut var_data := rt.call_function('get_transient', [rt.new_string(Class_WC_Helper.cache_key_connection_data())])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_data)))) && !(var_data.clone().is_array()) {
		rt.call_function('delete_transient', [rt.new_string(Class_WC_Helper.cache_key_connection_data())])
		return rt.new_bool(false)
	}
	return var_data.clone()
}

fn Class_WC_Helper.fetch_helper_connection_info() rt.PhpVal {
	mut var_data := Class_WC_Helper.get_cached_connection_data()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_data)))) {
		if !(!rt.is_true(var_data.array_get(rt.new_string('maybe_deleted_connection')))) {
			return create_wp_error(rt.new_string('deleted_connection'), rt.new_string('Connection may have been deleted'))
		}
		return var_data.clone()
	}
	mut iife_temp_22 := Class_WC_Helper_API{}
	mut iife_result_22 := iife_temp_22.get(rt.new_string('connection-info'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'query_string', val: '?url=' + (rt.call_function('rawurlencode', [rt.call_function('home_url', []rt.PhpVal{})])).str() }]))
	mut var_request := iife_result_22
	mut var_status := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	mut var_body := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	mut var_connection_data := if var_body.clone().is_array() { var_body } else { rt.new_array() }
	mut var_message := if !(var_connection_data.array_get(rt.new_string('message'))).is_null() { var_connection_data.array_get(rt.new_string('message')) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_status)))) {
		if rt.is_true(rt.identical(rt.new_string('Connected site not found.'), var_message)) || rt.is_true(rt.identical(rt.new_string('Invalid access token'), var_message)) {
			rt.call_function('set_transient', [rt.new_string(Class_WC_Helper.cache_key_connection_data()), rt.create_array([rt.ArrayItem{ key: 'maybe_deleted_connection', val: true }]), rt.mul(rt.new_int(1), rt.get_constant('HOUR_IN_SECONDS'))])
		}
		return create_wp_error(rt.new_string('invalid_response'), rt.new_string('Invalid response from WooCommerce.com'), rt.create_array([rt.ArrayItem{ key: 'status', val: var_status }]))
	}
	mut var_url := if !(var_connection_data.array_get(rt.new_string('url'))).is_null() { var_connection_data.array_get(rt.new_string('url')) } else { rt.new_string('') }
	if !(!rt.is_true(var_url)) {
		mut iife_temp_23 := Class_WC_Helper_Options{}
		mut iife_result_23 := iife_temp_23.get(rt.new_string('auth'))
		mut var_auth := iife_result_23
		var_auth.array_set('url', var_url.clone())
		mut iife_temp_24 := Class_WC_Helper_Options{}
		mut iife_result_24 := iife_temp_24.update(rt.new_string('auth'), var_auth.clone())
		rt.call_function('set_transient', [rt.new_string(Class_WC_Helper.cache_key_connection_data()), var_connection_data.clone(), rt.mul(rt.new_int(1), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_connection_data.clone()
}

fn Class_WC_Helper.get_subscriptions() rt.PhpVal {
	mut var_cache_key := rt.new_string('_woocommerce_helper_subscriptions')
	mut var_data := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_data)))) {
		if rt.is_true(rt.new_bool(var_data.clone().is_array())) {
			return var_data.clone()
		}
		rt.call_function('delete_transient', [var_cache_key.clone()])
	}
	mut var_request_uri := rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')) } else { rt.new_string('') }])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_source := rt.new_string('')
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('wc/v3/marketplace/refresh')]))))) {
		var_source = rt.new_string('refresh-button')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('my-subscriptions')]))))) {
		var_source = rt.new_string('my-subscriptions')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('plugins.php')]))))) {
		var_source = rt.new_string('plugins')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('wc-admin')]))))) {
		var_source = rt.new_string('inbox-notes')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('admin-ajax.php')]))))) {
		var_source = rt.new_string('heartbeat-api')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_request_uri.clone(), rt.new_string('installer')]))))) {
		var_source = rt.new_string('wccom-site-installer')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	} else if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')) {
		var_source = rt.new_string('wc-cli')
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut iife_temp_25 := Class_WC_Helper_API{}
	mut iife_result_25 := iife_temp_25.get(rt.new_string('subscriptions'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'query_string', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_source)))) { rt.call_function('esc_url', [rt.new_string('?source=' + (var_source).str())]) } else { rt.new_string('') } }]))
	mut var_request := iife_result_25
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}), rt.new_int((rt.call_method(var_request, 'get_error_data', []rt.PhpVal{})).to_i64()))))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_code)))) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(Class_WC_Helper.get_message_for_response_code((var_code).to_i64()), var_code.clone())))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	var_data = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if !(var_data.clone().is_array()) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		if rt.has_exception() { unsafe { goto catch_label_6 } }
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('WooCommerce.com API returned an invalid response.'), rt.new_string('woocommerce')]), rt.new_int(422))))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.call_function('set_transient', [var_cache_key.clone(), var_data.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	Class_WC_Helper.remove_api_error_notice()
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	return var_data.clone()
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Exception') {
		mut var_e := var_e_6.clone()
		if rt.is_true(rt.less(rt.call_method(var_e, 'getCode', []rt.PhpVal{}), rt.new_int(404))) {
			Class_WC_Helper.remove_api_error_notice()
		} else {
			Class_WC_Helper.log('Error getting subscriptions: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.new_string('error'))
			Class_WC_Helper.add_api_error_notice()
		}
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	return rt.new_array()
}

fn Class_WC_Helper.get_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
	mut var_subscriptions := rt.call_function('wp_list_filter', [Class_WC_Helper.get_subscriptions(), rt.create_array([rt.ArrayItem{ key: 'product_key', val: var_product_key_mutated }])])
	if !rt.is_true(var_subscriptions) {
		return rt.new_bool(false)
	}
	mut var_subscription := rt.call_function('array_shift', [var_subscriptions.clone()])
	var_subscription.array_set('local', Class_WC_Helper.get_subscription_local_data(mut rt.cast_object_ptr[Class_array](var_subscription)))
	return var_subscription.clone()
}

fn Class_WC_Helper.get_subscription_list_data() rt.PhpVal {
	mut var_subscriptions := Class_WC_Helper.get_subscriptions()
	mut var_woo_plugins := Class_WC_Helper.get_local_woo_plugins()
	mut var_woo_themes := Class_WC_Helper.get_local_woo_themes()
	mut var_subscriptions_product_ids := rt.call_function('wp_list_pluck', [var_subscriptions.clone(), rt.new_string('product_id')])
	mut iife_temp_26 := Class_WC_Helper_Options{}
	mut iife_result_26 := iife_temp_26.get(rt.new_string('auth'))
	mut var_auth := iife_result_26
	mut var_site_id := if var_auth.array_isset(rt.new_string('site_id')) { rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))]) } else { rt.new_int(0) }
	mut iter_14 := rt.call_function('array_merge', [var_woo_plugins.clone(), var_woo_themes.clone()]).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_data := item_14.val
		mut var_filename := item_14.key
		if rt.is_true(rt.call_function('in_array', [var_data.array_get(rt.new_string('_product_id')), var_subscriptions_product_ids.clone(), rt.new_bool(true)])) {
			continue
		}
		var_subscriptions.array_push(rt.create_array([rt.ArrayItem{ key: 'product_key', val: '' }, rt.ArrayItem{ key: 'product_id', val: var_data.array_get(rt.new_string('_product_id')) }, rt.ArrayItem{ key: 'product_name', val: var_data.array_get(rt.new_string('Name')) }, rt.ArrayItem{ key: 'product_url', val: if !(var_data.array_get(rt.new_string('PluginURI'))).is_null() { var_data.array_get(rt.new_string('PluginURI')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'zip_slug', val: var_data.array_get(rt.new_string('slug')) }, rt.ArrayItem{ key: 'documentation_url', val: '' }, rt.ArrayItem{ key: 'key_type', val: '' }, rt.ArrayItem{ key: 'key_type_label', val: '' }, rt.ArrayItem{ key: 'lifetime', val: false }, rt.ArrayItem{ key: 'product_status', val: 'publish' }, rt.ArrayItem{ key: 'connections', val: rt.new_array() }, rt.ArrayItem{ key: 'expires', val: 0 }, rt.ArrayItem{ key: 'expired', val: true }, rt.ArrayItem{ key: 'expiring', val: false }, rt.ArrayItem{ key: 'sites_max', val: 0 }, rt.ArrayItem{ key: 'sites_active', val: 0 }, rt.ArrayItem{ key: 'autorenew', val: false }, rt.ArrayItem{ key: 'maxed', val: false }]))
	}
	mut iife_temp_27 := Class_WC_Helper_Updater{}
	mut iife_result_27 := iife_temp_27.get_update_data()
	mut var_updates := iife_result_27
	mut iter_15 := var_subscriptions.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_subscription := item_15.val
		var_subscription.array_set('active', rt.call_function('in_array', [var_site_id.clone(), var_subscription.array_get(rt.new_string('connections')), rt.new_bool(true)]))
		var_subscription.array_set('local', Class_WC_Helper.get_subscription_local_data(mut rt.cast_object_ptr[Class_array](var_subscription)))
		var_subscription.array_set('has_update', false)
		if rt.is_true(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))) && !(!rt.is_true(var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))))) {
			var_subscription.array_set('has_update', rt.call_function('version_compare', [var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('version')), var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('version')), rt.new_string('>')]))
		}
		if !(!rt.is_true(var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))))) {
			var_subscription.array_set('version', var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('version')))
		}
		if !(!rt.is_true(var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('url')))) {
			var_subscription.array_set('product_url', var_updates.array_get(var_subscription.array_get(rt.new_string('product_id'))).array_get(rt.new_string('url')))
		}
	}
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_compare_value := rt.call_function('strcasecmp', [var_a.array_get(rt.new_string('product_name')), var_b.array_get(rt.new_string('product_name'))])
		if rt.is_true(rt.identical(rt.new_int(0), var_compare_value)) {
			return rt.call_function('strcasecmp', [var_a.array_get(rt.new_string('expires')), var_b.array_get(rt.new_string('expires'))])
		}
		return var_compare_value.clone()
		}
	rt.call_function('usort', [var_subscriptions.clone(), rt.new_closure(closure_29_fn)])
	mut iter_16 := var_subscriptions.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_subscription := item_16.val
		var_subscription.array_set('subscription_available', Class_WC_Helper.is_subscription_available(var_subscription.clone(), var_subscriptions.clone()))
		var_subscription.array_set('subscription_installed', Class_WC_Helper.is_subscription_installed(var_subscription.clone(), var_subscriptions.clone()))
	}
	var_subscription = rt.new_null()
	return var_subscriptions.clone()
}

fn Class_WC_Helper.is_subscription_available(var_subscription rt.PhpVal, var_subscriptions rt.PhpVal) bool {
	mut var_subscription_mutated := var_subscription
	mut var_subscriptions_mutated := var_subscriptions
	if rt.is_true(rt.identical(rt.new_bool(true), var_subscription_mutated.array_get(rt.new_string('active')))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_subscription_mutated.array_get(rt.new_string('expired')))) {
		return false
	}
	mut var_product_subscriptions := rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_subscription_mutated.array_get(rt.new_string('product_id')) }, rt.ArrayItem{ key: 'active', val: true }])])
	if !rt.is_true(var_product_subscriptions) {
		return true
	}
	return false
}

fn Class_WC_Helper.is_subscription_installed(var_subscription rt.PhpVal, var_subscriptions rt.PhpVal) bool {
	mut var_subscription_mutated := var_subscription
	mut var_subscriptions_mutated := var_subscriptions
	if rt.is_true(rt.identical(rt.new_bool(false), var_subscription_mutated.array_get(rt.new_string('local')).array_get(rt.new_string('installed')))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_subscription_mutated.array_get(rt.new_string('active')))) {
		return true
	}
	mut var_product_subscriptions := rt.call_function('wp_list_filter', [var_subscriptions_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_subscription_mutated.array_get(rt.new_string('product_id')) }])])
	if !rt.is_true(var_product_subscriptions) {
		return false
	}
	if 1 == var_product_subscriptions.clone().array_count() {
		return true
	}
	mut var_active_subscription := rt.call_function('wp_list_filter', [var_product_subscriptions.clone(), rt.create_array([rt.ArrayItem{ key: 'active', val: true }])])
	if !(!rt.is_true(var_active_subscription)) {
		return false
	}
	mut var_product_subscriptions_without_maxed_connections := rt.call_function('wp_list_filter', [var_product_subscriptions.clone(), rt.create_array([rt.ArrayItem{ key: 'maxed', val: false }])])
	if 0 < var_product_subscriptions_without_maxed_connections.clone().array_count() {
	mut var_product_subscription := rt.call_function('array_shift', [var_product_subscriptions_without_maxed_connections.clone()])
	} else {
	var_product_subscription = rt.call_function('array_shift', [var_product_subscriptions.clone()])
	}
	if rt.is_true(rt.identical(var_product_subscription.array_get(rt.new_string('product_key')), var_subscription_mutated.array_get(rt.new_string('product_key')))) {
		return true
	}
	return false
}

fn Class_WC_Helper.get_subscription_local_data(mut var_subscription Class_array) rt.PhpVal {
	mut var_subscription_mutated := var_subscription
	mut var_local_plugins := Class_WC_Helper.get_local_plugins()
	mut var_local_themes := Class_WC_Helper.get_local_themes()
	mut var_installed_product := rt.call_function('wp_list_filter', [rt.call_function('array_merge', [var_local_plugins.clone(), var_local_themes.clone()]), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_subscription_mutated.array_get(rt.new_string('zip_slug')) }])])
	var_installed_product = rt.call_function('array_shift', [var_installed_product.clone()])
	if !rt.is_true(var_installed_product) {
		return rt.create_array([rt.ArrayItem{ key: 'installed', val: false }, rt.ArrayItem{ key: 'active', val: false }, rt.ArrayItem{ key: 'version', val: rt.new_null() }, rt.ArrayItem{ key: 'type', val: rt.new_null() }, rt.ArrayItem{ key: 'slug', val: rt.new_null() }, rt.ArrayItem{ key: 'path', val: rt.new_null() }])
	}
	mut var_local_data := { 'installed': rt.new_bool(true), 'active': rt.new_bool(false), 'version': var_installed_product.array_get(rt.new_string('Version')), 'type': var_installed_product.array_get(rt.new_string('_type')), 'slug': rt.new_null(), 'path': var_installed_product.array_get(rt.new_string('_filename')) }
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_installed_product.array_get(rt.new_string('_type')))) {
		var_local_data['slug'] = var_installed_product.array_get(rt.new_string('slug'))
		if rt.is_true(rt.call_function('is_plugin_active', [var_installed_product.array_get(rt.new_string('_filename'))])) {
			var_local_data['active'] = rt.new_bool(true)
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_plugin_active_for_network', [var_installed_product.array_get(rt.new_string('_filename'))])) {
			var_local_data['active'] = rt.new_bool(true)
		}
	} else if rt.is_true(rt.identical(rt.new_string('theme'), var_installed_product.array_get(rt.new_string('_type')))) {
		var_local_data['slug'] = var_installed_product.array_get(rt.new_string('_stylesheet'))
		if rt.is_true(rt.call_function('in_array', [var_installed_product.array_get(rt.new_string('_stylesheet')), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_stylesheet', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_function('get_template', []rt.PhpVal{}) }]), rt.new_bool(true)])) {
			var_local_data['active'] = rt.new_bool(true)
		}
	}
	return var_local_data.clone()
}

fn Class_WC_Helper.activated_plugin(var_filename rt.PhpVal) {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
	mut var_plugins := Class_WC_Helper.get_local_woo_plugins()
	if !rt.is_true(var_plugins.array_get(var_filename)) {
		return
	}
	mut iife_temp_29 := Class_WC_Helper_Options{}
	mut iife_result_29 := iife_temp_29.get(rt.new_string('auth'))
	mut var_auth := iife_result_29
	if !rt.is_true(var_auth) {
		return
	}
	mut var_plugin := var_plugins.array_get(var_filename)
	mut var_product_id := var_plugin.array_get(rt.new_string('_product_id'))
	mut var_subscription := Class_WC_Helper.get_available_subscription(var_product_id.clone())
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		return
	}
	mut var_product_key := var_subscription.array_get(rt.new_string('product_key'))
	mut list_tmp_4 := Class_WC_Helper.wccom_activate(var_product_key.clone())
	var_activation_response = (list_tmp_4).array_get(0)
	var_activated = (list_tmp_4).array_get(1)
	var_body = (list_tmp_4).array_get(2)
	if rt.is_true(var_activated) {
		Class_WC_Helper.log('Auto-activated a subscription for ' + (var_filename).str())
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_success'), var_product_id.clone(), var_product_key.clone(), var_activation_response.clone()])
	} else {
		Class_WC_Helper.log('Could not activate a subscription upon plugin activation: ' + (var_filename).str())
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_error'), var_product_id.clone(), var_product_key.clone(), var_activation_response.clone()])
	}
}

fn Class_WC_Helper.connect_theme(var_product_id rt.PhpVal) {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
	mut var_product_id_mutated := var_product_id
	mut iife_temp_30 := Class_WC_Helper_Options{}
	mut iife_result_30 := iife_temp_30.get(rt.new_string('auth'))
	mut var_auth := iife_result_30
	if !rt.is_true(var_auth) {
		return
	}
	rt.call_function('wp_clean_themes_cache', [rt.new_bool(false)])
	mut var_themes := Class_WC_Helper.get_local_woo_themes()
	closure_32_fn := fn [var_product_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_theme := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	var_themes = rt.call_function('array_filter', [var_themes.clone(), rt.new_closure(closure_32_fn)])
	if !rt.is_true(var_themes) {
		return
	}
	mut var_theme := rt.call_function('reset', [var_themes.clone()])
	mut var_subscription := Class_WC_Helper.get_available_subscription(var_product_id_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		return
	}
	mut var_product_key := var_subscription.array_get(rt.new_string('product_key'))
	mut list_tmp_5 := Class_WC_Helper.wccom_activate(var_product_key.clone())
	var_activation_response = (list_tmp_5).array_get(0)
	var_activated = (list_tmp_5).array_get(1)
	var_body = (list_tmp_5).array_get(2)
	if rt.is_true(var_activated) {
		Class_WC_Helper.log('Auto-activated a subscription for ' + (var_theme.array_get(rt.new_string('Name'))).str())
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_success'), var_product_id_mutated.clone(), var_product_key.clone(), var_activation_response.clone()])
	} else {
		Class_WC_Helper.log('Could not activate a subscription for theme: ' + (var_theme.array_get(rt.new_string('Name'))).str())
		rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_activate_error'), var_product_id_mutated.clone(), var_product_key.clone(), var_activation_response.clone()])
	}
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
}

fn Class_WC_Helper.deactivated_plugin(var_filename rt.PhpVal) {
	mut var_plugins := Class_WC_Helper.get_local_woo_plugins()
	if !rt.is_true(var_plugins.array_get(var_filename)) {
		return
	}
	mut iife_temp_32 := Class_WC_Helper_Options{}
	mut iife_result_32 := iife_temp_32.get(rt.new_string('auth'))
	mut var_auth := iife_result_32
	if !rt.is_true(var_auth) {
		return
	}
	mut var_plugin := var_plugins.array_get(var_filename)
	mut var_product_id := var_plugin.array_get(rt.new_string('_product_id'))
	mut var_subscriptions := Class_WC_Helper._get_subscriptions_from_product_id((var_product_id).to_bool(), rt.new_bool(false))
	mut var_site_id := rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))])
	if !rt.is_true(var_subscriptions) {
		return
	}
	mut var_deactivated := rt.new_int(0)
	mut iter_17 := var_subscriptions.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_subscription := item_17.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_site_id.clone(), var_subscription.array_get(rt.new_string('connections')), rt.new_bool(true)]))))) {
			continue
		}
		mut var_product_key := var_subscription.array_get(rt.new_string('product_key'))
		mut iife_temp_33 := Class_WC_Helper_API{}
		mut iife_result_33 := iife_temp_33.post(rt.new_string('deactivate'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'product_key', val: var_product_key }])]) }]))
		mut var_deactivation_response := iife_result_33
		if rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_deactivation_response.clone()]), rt.new_int(200))) {
			rt.pre_inc(var_deactivated)
			rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_deactivate_success'), var_product_id.clone(), var_product_key.clone(), var_deactivation_response.clone()])
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_helper_subscription_deactivate_error'), var_product_id.clone(), var_product_key.clone(), var_deactivation_response.clone()])
		}
	}
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	if rt.is_true(var_deactivated) {
		Class_WC_Helper.log((rt.call_function('sprintf', [rt.new_string('Auto-deactivated %d subscription(s) for %s'), var_deactivated.clone(), var_filename.clone()])).str())
	}
}

fn Class_WC_Helper.admin_notices() {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_helper_suppress_admin_notices'), rt.new_bool(false)])) {
		return
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('update-core'), var_screen_id)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Helper._woo_core_update_available())))) {
		return
	}
	mut var_notice := Class_WC_Helper._get_extensions_update_notice()
	if !(!rt.is_true(var_notice)) {
		print('<div class="updated woocommerce-message"><p>' + (var_notice).str() + '</p></div>')
	}
}

fn Class_WC_Helper._get_extensions_update_notice() rt.PhpVal {
	mut var_plugins := Class_WC_Helper.get_local_woo_plugins()
	mut iife_temp_34 := Class_WC_Helper_Updater{}
	mut iife_result_34 := iife_temp_34.get_update_data()
	mut var_updates := iife_result_34
	mut var_available := rt.new_int(0)
	mut iter_18 := var_plugins.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_data := item_18.val
		if !rt.is_true(var_updates.array_get(var_data.array_get(rt.new_string('_product_id')))) {
			continue
		}
		mut var_product_id := var_data.array_get(rt.new_string('_product_id'))
		if rt.is_true(rt.call_function('version_compare', [var_updates.array_get(var_product_id).array_get(rt.new_string('version')), var_data.array_get(rt.new_string('Version')), rt.new_string('>')])) {
			rt.pre_inc(var_available)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_available)))) {
		return rt.new_null()
	}
	return rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Note: You currently have <a href="%1$s">%2$d paid extension</a> which should be updated first before updating WooCommerce.'), rt.new_string('Note: You currently have <a href="%1$s">%2$d paid extensions</a> which should be updated first before updating WooCommerce.'), var_available.clone(), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=' + (Class_WC_Helper.get_source_page()).str() + ' &section=helper')]), var_available.clone()])
}

fn Class_WC_Helper._woo_core_update_available() bool {
	mut var_updates := rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
	if !rt.is_true(rt.get_property(var_updates, 'response')) {
		return false
	}
	if !rt.is_true(rt.get_property(var_updates, 'response').array_get(rt.new_string('woocommerce/woocommerce.php'))) {
		return false
	}
	mut var_data := rt.get_property(var_updates, 'response').array_get(rt.new_string('woocommerce/woocommerce.php'))
	mut iife_temp_35 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_35 := iife_temp_35.get_constant(rt.new_string('WC_VERSION'))
	mut iife_temp_36 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_36 := iife_temp_36.get_constant(rt.new_string('WC_VERSION'))
	if rt.is_true(rt.call_function('version_compare', [iife_result_35, rt.get_property(var_data, 'new_version'), rt.new_string('>=')])) {
		return false
	}
	return true
}

fn Class_WC_Helper._flush_subscriptions_cache() {
	rt.call_function('delete_transient', [rt.new_string('_woocommerce_helper_subscriptions')])
}

fn Class_WC_Helper.flush_product_usage_notice_rules_cache() {
	rt.call_function('delete_transient', [rt.new_string('_woocommerce_helper_product_usage_notice_rules')])
}

fn Class_WC_Helper.flush_connection_data_cache() {
	rt.call_function('delete_transient', [rt.new_string(Class_WC_Helper.cache_key_connection_data())])
}

fn Class_WC_Helper._flush_authentication_cache() bool {
	mut iife_temp_37 := Class_WC_Helper_API{}
	mut iife_result_37 := iife_temp_37.get(rt.new_string('oauth/me'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'timeout', val: 30 }]))
	mut var_request := iife_result_37
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()]), rt.new_int(200))))) {
		return false
	}
	mut var_user_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_data)))) {
		return false
	}
	mut iife_temp_38 := Class_WC_Helper_Options{}
	mut iife_result_38 := iife_temp_38.update(rt.new_string('auth_user_data'), rt.create_array([rt.ArrayItem{ key: 'name', val: var_user_data.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'email', val: var_user_data.array_get(rt.new_string('email')) }]))
	return true
}

fn Class_WC_Helper._flush_updates_cache() {
mut iife_temp_39 := Class_WC_Helper_Updater{}
mut iife_result_39 := iife_temp_39.flush_updates_cache()
}

fn Class_WC_Helper._sort_by_product_name(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strcmp', [var_a.array_get(rt.new_string('product_name')), var_b.array_get(rt.new_string('product_name'))])
}

fn Class_WC_Helper._sort_by_name(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strcmp', [var_a.array_get(rt.new_string('Name')), var_b.array_get(rt.new_string('Name'))])
}

fn Class_WC_Helper.log(var_message rt.PhpVal, level string) {
	mut var_message_mutated := var_message
	mut iife_temp_40 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_40 := iife_temp_40.is_true(rt.new_string('WP_DEBUG'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_40)))) {
		return
	}
	if !(!(rt.get_static_prop('WC_Helper', 'log')).is_null()) {
		rt.set_static_prop('WC_Helper', 'log', rt.call_function('wc_get_logger', []rt.PhpVal{}))
	}
	rt.call_method(rt.get_static_prop('WC_Helper', 'log'), 'log', [rt.new_string(level), var_message_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'helper' }])])
}

fn Class_WC_Helper.disconnect() {
	mut iife_temp_41 := Class_WC_Helper_API{}
	mut iife_result_41 := iife_temp_41.post(rt.new_string('oauth/invalidate_token'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }]))
	mut iife_temp_42 := Class_WC_Helper_Options{}
	mut iife_result_42 := iife_temp_42.get(rt.new_string('auth_user_data'))
	mut var_data := iife_result_42
	mut iife_temp_43 := Class_WC_Helper_Options{}
	mut iife_result_43 := iife_temp_43.update(rt.new_string('last_disconnected_user_data'), var_data.clone())
	rt.call_function('delete_metadata', [rt.new_string('user'), rt.new_int(0), Class_Automattic_WooCommerce_Admin_PluginsHelper.dismiss_disconnect_notice(), rt.new_string(''), rt.new_bool(true)])
	mut iife_temp_44 := Class_WC_Helper_Options{}
	mut iife_result_44 := iife_temp_44.update(rt.new_string('auth'), rt.new_array())
	mut iife_temp_45 := Class_WC_Helper_Options{}
	mut iife_result_45 := iife_temp_45.update(rt.new_string('auth_user_data'), rt.new_array())
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	Class_WC_Helper.flush_product_usage_notice_rules_cache()
	Class_WC_Helper.flush_connection_data_cache()
}

fn Class_WC_Helper.is_site_connected() bool {
	mut iife_temp_46 := Class_WC_Helper_Options{}
	mut iife_result_46 := iife_temp_46.get(rt.new_string('auth'))
	mut var_auth := iife_result_46
	return !(!rt.is_true(var_auth.array_get(rt.new_string('access_token'))))
}

fn Class_WC_Helper.connect_with_password(password string) rt.PhpVal {
	mut iife_temp_47 := Class_WC_Helper_API{}
	mut iife_result_47 := iife_temp_47.post(rt.new_string('connect'), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'X-API-Key', val: password }, rt.ArrayItem{ key: 'Content-Type', val: 'application/json' }]) }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'home_url', val: rt.call_function('home_url', []rt.PhpVal{}) }])]) }, rt.ArrayItem{ key: 'authenticated', val: false }]))
	mut var_request := iife_result_47
	mut var_code := rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()])
	if rt.is_true(rt.identical(var_code, rt.new_int(403))) {
		mut var_message := rt.new_string('Invalid password')
		Class_WC_Helper.log((var_message).str())
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('connect-with-password-invalid-password'), var_message.clone()))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_code, rt.new_int(200))))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Call to /connect returned a non-200 response code (%d)'), var_code.clone()])
		Class_WC_Helper.log((var_message).str())
		return rt.new_object('WP_Error', []string{}, create_wp_error('connect-with-password-' + (var_code).str(), var_message.clone()))
	}
	mut var_access_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if !rt.is_true(var_access_data.array_get(rt.new_string('access_token'))) || !rt.is_true(var_access_data.array_get(rt.new_string('access_token_secret'))) {
		var_message = rt.call_function('sprintf', [rt.new_string('Call to /connect returned an invalid body: %s'), rt.call_function('wp_remote_retrieve_body', [var_request.clone()])])
		Class_WC_Helper.log((var_message).str())
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('connect-with-password-invalid-response'), var_message.clone()))
	}
	Class_WC_Helper.update_auth_option((var_access_data.array_get(rt.new_string('access_token'))).str(), (var_access_data.array_get(rt.new_string('access_token_secret'))).str(), (var_access_data.array_get(rt.new_string('site_id'))).to_i64(), (rt.call_function('home_url', []rt.PhpVal{})).str())
	return rt.new_null()
}

fn Class_WC_Helper.update_auth_option(access_token string, access_token_secret string, site_id i64, home_url string) {
	mut access_token_mutated := access_token
	mut site_id_mutated := site_id
	mut iife_temp_48 := Class_WC_Helper_Options{}
	mut iife_result_48 := iife_temp_48.update(rt.new_string('auth'), rt.create_array([rt.ArrayItem{ key: 'access_token', val: access_token_mutated }, rt.ArrayItem{ key: 'access_token_secret', val: access_token_secret }, rt.ArrayItem{ key: 'site_id', val: site_id_mutated }, rt.ArrayItem{ key: 'url', val: home_url }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Helper._flush_authentication_cache())))) {
		Class_WC_Helper.log('Could not obtain connected user info in _helper_auth_return.')
		mut iife_temp_49 := Class_WC_Helper_Options{}
		mut iife_result_49 := iife_temp_49.update(rt.new_string('auth'), rt.new_array())
		rt.call_function('wp_die', [rt.new_string('Something went wrong. Could not obtain connected user info in _helper_auth_return.')])
	}
	Class_WC_Helper._flush_subscriptions_cache()
	Class_WC_Helper._flush_updates_cache()
	Class_WC_Helper.flush_product_usage_notice_rules_cache()
}

fn Class_WC_Helper.get_woocommerce_com_base_url() rt.PhpVal {
	return rt.call_function('trailingslashit', [rt.call_function('apply_filters', [rt.new_string('woo_com_base_url'), rt.new_string('https://woocommerce.com/')])])
}

fn Class_WC_Helper.get_install_base_url() string {
	return (Class_WC_Helper.get_woocommerce_com_base_url()).str() + 'auto-install-init/'
}

fn Class_WC_Helper.get_notices() rt.PhpVal {
	mut var_cache_key := rt.new_string('_woocommerce_helper_notices')
	mut var_cached_data := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_data)))) {
		if rt.is_true(rt.new_bool(var_cached_data.clone().is_array())) {
			return var_cached_data.clone()
		}
		rt.call_function('delete_transient', [var_cache_key.clone()])
	}
	mut iife_temp_50 := Class_WC_Helper_API{}
	mut iife_result_50 := iife_temp_50.get(rt.new_string('notices'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }]))
	mut var_request := iife_result_50
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_request.clone()]))))) {
		rt.call_function('set_transient', [var_cache_key.clone(), rt.new_array(), rt.mul(rt.new_int(15), rt.get_constant('MINUTE_IN_SECONDS'))])
		return rt.new_array()
	}
	mut var_data := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.clone()]), rt.new_bool(true)])
	if !rt.is_true(var_data) || !(var_data.clone().is_array()) {
	var_data = rt.new_array()
	}
	rt.call_function('set_transient', [var_cache_key.clone(), var_data.clone(), rt.mul(rt.new_int(1), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_data.clone()
}

fn Class_WC_Helper.wccom_activate(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
	mut iife_temp_51 := Class_WC_Helper_API{}
	mut iife_result_51 := iife_temp_51.post(rt.new_string('activate'), rt.create_array([rt.ArrayItem{ key: 'authenticated', val: true }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'product_key', val: var_product_key_mutated }])]) }]))
	mut var_activation_response := iife_result_51
	mut var_activated := rt.identical(rt.call_function('wp_remote_retrieve_response_code', [var_activation_response.clone()]), rt.new_int(200))
	mut var_body := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_activation_response.clone()]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_activated)))) && !(!rt.is_true(var_body.array_get(rt.new_string('code')))) && rt.is_true(rt.identical(rt.new_string('already_connected'), var_body.array_get(rt.new_string('code')))) {
	var_activated = rt.new_bool(true)
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_activation_response }, rt.ArrayItem{ key: none, val: var_activated }, rt.ArrayItem{ key: none, val: var_body }])
}

fn Class_WC_Helper.get_available_subscription(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_subscriptions := Class_WC_Helper._get_subscriptions_from_product_id((var_product_id_mutated).to_bool(), rt.new_bool(false))
	if !rt.is_true(var_subscriptions) {
		return rt.new_null()
	}
	mut var_subscription := rt.new_null()
	mut iter_19 := var_subscriptions.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var__sub := item_19.val
		if rt.is_true(var__sub.array_get(rt.new_string('expired'))) {
			continue
		}
		if var__sub.array_isset(rt.new_string('maxed')) && rt.is_true(var__sub.array_get(rt.new_string('maxed'))) {
			continue
		}
		var_subscription = var__sub
		break
	}
	return var_subscription.clone()
}

fn Class_WC_Helper.get_message_for_response_code(code i64) string {
	mut code_mutated := code
	if 429 == code_mutated {
		return (rt.call_function('__', [rt.new_string('You have exceeded the request limit. Please try again after a few minutes.'), rt.new_string('woocommerce')])).str()
	} else if 403 == code_mutated {
		return (rt.call_function('__', [rt.new_string('Authentication failed. Please try again after a few minutes. If the issue persists, disconnect your store from WooCommerce.com and reconnect.'), rt.new_string('woocommerce')])).str()
	}
	return (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WooCommerce.com API returned HTTP status code %d.'), rt.new_string('woocommerce')]), rt.new_int(code_mutated).clone()])).str()
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_api(_args ...rt.PhpVal) &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_woo_update_manager_plugin(_args ...rt.PhpVal) &Class_WC_Woo_Update_Manager_Plugin {
	mut obj := &Class_WC_Woo_Update_Manager_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_data_exception(_args ...rt.PhpVal) &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
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

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_view_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Helper.get_view_filename(dispatch_arg_0))
		}
		'load' {
			Class_WC_Helper.load()
			return rt.new_null()
		}
		'remove_api_error_notice' {
			Class_WC_Helper.remove_api_error_notice()
			return rt.new_null()
		}
		'add_api_error_notice' {
			Class_WC_Helper.add_api_error_notice()
			return rt.new_null()
		}
		'get_source_page' {
			return Class_WC_Helper.get_source_page()
		}
		'includes' {
			Class_WC_Helper.includes()
			return rt.new_null()
		}
		'render_helper_output' {
			Class_WC_Helper.render_helper_output()
			return rt.new_null()
		}
		'add_utm_params_to_url_for_subscription_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WC_Helper.add_utm_params_to_url_for_subscription_link(dispatch_arg_0, dispatch_arg_1))
		}
		'get_filters' {
			return Class_WC_Helper.get_filters()
		}
		'get_filters_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.get_filters_counts(dispatch_arg_0)
		}
		'get_current_filter' {
			return Class_WC_Helper.get_current_filter()
		}
		'_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper._filter(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'admin_enqueue_scripts' {
			Class_WC_Helper.admin_enqueue_scripts()
			return rt.new_null()
		}
		'_get_return_notices' {
			return Class_WC_Helper._get_return_notices()
		}
		'current_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.current_screen(dispatch_arg_0)
		}
		'maybe_redirect_to_new_marketplace_installer' {
			Class_WC_Helper.maybe_redirect_to_new_marketplace_installer()
			return rt.new_null()
		}
		'get_helper_redirect_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.get_helper_redirect_url(dispatch_arg_0)
		}
		'_helper_auth_connect' {
			Class_WC_Helper._helper_auth_connect()
			return rt.new_null()
		}
		'_helper_auth_return' {
			Class_WC_Helper._helper_auth_return()
			return rt.new_null()
		}
		'_helper_auth_disconnect' {
			Class_WC_Helper._helper_auth_disconnect()
			return rt.new_null()
		}
		'_helper_auth_refresh' {
			Class_WC_Helper._helper_auth_refresh()
			return rt.new_null()
		}
		'refresh_helper_subscriptions' {
			Class_WC_Helper.refresh_helper_subscriptions()
			return rt.new_null()
		}
		'_helper_subscription_activate' {
			Class_WC_Helper._helper_subscription_activate()
			return rt.new_null()
		}
		'activate_helper_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.activate_helper_subscription(dispatch_arg_0)
		}
		'activate_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper.activate_plugin(dispatch_arg_0))
		}
		'helper_subscription_deactivate' {
			Class_WC_Helper.helper_subscription_deactivate()
			return rt.new_null()
		}
		'deactivate_helper_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.deactivate_helper_subscription(dispatch_arg_0)
		}
		'get_subscription_install_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper.get_subscription_install_url(dispatch_arg_0, dispatch_arg_1)
		}
		'_helper_plugin_deactivate' {
			Class_WC_Helper._helper_plugin_deactivate()
			return rt.new_null()
		}
		'_get_local_from_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper._get_local_from_product_id(dispatch_arg_0))
		}
		'has_product_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper.has_product_subscription(dispatch_arg_0))
		}
		'get_installed_subscriptions' {
			return Class_WC_Helper.get_installed_subscriptions()
		}
		'get_unconnected_subscriptions' {
			return Class_WC_Helper.get_unconnected_subscriptions()
		}
		'get_product_subscription_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.get_product_subscription_state(dispatch_arg_0)
		}
		'_get_subscriptions_from_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_WC_Helper._get_subscriptions_from_product_id(dispatch_arg_0, dispatch_arg_1))
		}
		'get_local_plugins' {
			return Class_WC_Helper.get_local_plugins()
		}
		'get_local_themes' {
			return Class_WC_Helper.get_local_themes()
		}
		'get_local_woo_plugins' {
			return Class_WC_Helper.get_local_woo_plugins()
		}
		'get_local_woo_themes' {
			return Class_WC_Helper.get_local_woo_themes()
		}
		'get_product_usage_notice_rules' {
			return Class_WC_Helper.get_product_usage_notice_rules()
		}
		'verify_request_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WC_Helper.verify_request_hash(dispatch_arg_0))
		}
		'get_cached_connection_data' {
			return Class_WC_Helper.get_cached_connection_data()
		}
		'fetch_helper_connection_info' {
			return Class_WC_Helper.fetch_helper_connection_info()
		}
		'get_subscriptions' {
			return Class_WC_Helper.get_subscriptions()
		}
		'get_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.get_subscription(dispatch_arg_0)
		}
		'get_subscription_list_data' {
			return Class_WC_Helper.get_subscription_list_data()
		}
		'is_subscription_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper.is_subscription_available(dispatch_arg_0, dispatch_arg_1))
		}
		'is_subscription_installed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper.is_subscription_installed(dispatch_arg_0, dispatch_arg_1))
		}
		'get_subscription_local_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Helper.get_subscription_local_data(mut dispatch_arg_0)
		}
		'activated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper.activated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'connect_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper.connect_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'deactivated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper.deactivated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'admin_notices' {
			Class_WC_Helper.admin_notices()
			return rt.new_null()
		}
		'_get_extensions_update_notice' {
			return Class_WC_Helper._get_extensions_update_notice()
		}
		'_woo_core_update_available' {
			return rt.new_bool(Class_WC_Helper._woo_core_update_available())
		}
		'_flush_subscriptions_cache' {
			Class_WC_Helper._flush_subscriptions_cache()
			return rt.new_null()
		}
		'flush_product_usage_notice_rules_cache' {
			Class_WC_Helper.flush_product_usage_notice_rules_cache()
			return rt.new_null()
		}
		'flush_connection_data_cache' {
			Class_WC_Helper.flush_connection_data_cache()
			return rt.new_null()
		}
		'_flush_authentication_cache' {
			return rt.new_bool(Class_WC_Helper._flush_authentication_cache())
		}
		'_flush_updates_cache' {
			Class_WC_Helper._flush_updates_cache()
			return rt.new_null()
		}
		'_sort_by_product_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper._sort_by_product_name(dispatch_arg_0, dispatch_arg_1)
		}
		'_sort_by_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Helper._sort_by_name(dispatch_arg_0, dispatch_arg_1)
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_WC_Helper.log(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'disconnect' {
			Class_WC_Helper.disconnect()
			return rt.new_null()
		}
		'is_site_connected' {
			return rt.new_bool(Class_WC_Helper.is_site_connected())
		}
		'connect_with_password' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Helper.connect_with_password(dispatch_arg_0)
		}
		'update_auth_option' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			Class_WC_Helper.update_auth_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_woocommerce_com_base_url' {
			return Class_WC_Helper.get_woocommerce_com_base_url()
		}
		'get_install_base_url' {
			return rt.new_string(Class_WC_Helper.get_install_base_url())
		}
		'get_notices' {
			return Class_WC_Helper.get_notices()
		}
		'wccom_activate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.wccom_activate(dispatch_arg_0)
		}
		'get_available_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper.get_available_subscription(dispatch_arg_0)
		}
		'get_message_for_response_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_WC_Helper.get_message_for_response_code(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	Class_WC_Helper.load()
}
