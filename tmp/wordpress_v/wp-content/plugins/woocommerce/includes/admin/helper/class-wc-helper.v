import rt

pub fn Class_WC_Helper.note_name() string {
	return 'wccom-api-failed'
}
pub fn Class_WC_Helper.cache_key_connection_data() string {
	return '_woocommerce_helper_connection_data'
}
struct Class_WC_Helper {
	rt.PhpObjectBase
pub mut:
		log rt.PhpVal = rt.new_null()
}

fn Class_WC_Helper.get_view_filename(var_view rt.PhpVal) string {
	return @DIR + "/views/${var_view.to_string()}"
}

fn Class_WC_Helper.load()  {
	Class_WC_Helper.includes()
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'current_screen' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_output'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'render_helper_output' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'admin_enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'admin_notices' }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_helper_loaded')])
}

fn Class_WC_Helper.remove_api_error_notice()  {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('admin-note'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [Class_WC_Helper.note_name()])
	if !(!rt.is_true(var_note_ids)) {
		{
			mut iter_1 := var_note_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_note_id := item_1.val
				mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
				if rt.is_true(var_note.get_id()) {
					rt.call_method(var_data_store, 'delete', [var_note])
				}
			}
		}
	}
}

fn Class_WC_Helper.add_api_error_notice()  {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('admin-note'))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [Class_WC_Helper.note_name()])
	if !(!rt.is_true(var_note_ids)) {
		mut var_current_notice_id := rt.call_function('array_shift', [var_note_ids.dup()])
		{
			mut iter_1 := var_note_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_note_id := item_1.val
				mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
				if rt.is_true(var_note.get_id()) {
					rt.call_method(var_data_store, 'delete', [var_note])
				}
			}
		}
		mut var_note := create_automattic_woocommerce_admin_notes_note(var_current_notice_id.dup())
	} else {
		var_note = create_automattic_woocommerce_admin_notes_note()
	}
	var_note.set_props(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('We’re having trouble connecting to WooCommerce.com'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: rt.call_function('__', [rt.new_string('Some subscription data may be temporarily unavailable. Please refresh the page in a few minutes to try again.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update() }, rt.ArrayItem{ key: 'name', val: Class_WC_Helper.note_name() }, rt.ArrayItem{ key: 'content_data', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'source', val: 'woocommerce-admin' }, rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() }, rt.ArrayItem{ key: 'is_deleted', val: false }]))
	var_note.save()
}

fn Class_WC_Helper.get_source_page() rt.PhpVal {
	mut var_page := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get('page')).is_null() { rt.get_superglobal('_GET').array_get('page') } else { rt.new_string('wc-admin') }])])
	return if rt.is_true(rt.call_function('in_array', [var_page.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin' }, rt.ArrayItem{ key: none, val: 'wc-addons' }]), rt.new_bool(true)])) { var_page } else { rt.new_string('wc-admin') }
}

fn Class_WC_Helper.includes()  {
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

fn Class_WC_Helper.render_helper_output()  {
	mut var_auth := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth'))
	mut var_auth_user_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('auth_user_data'))
	mut var_notices := Class_WC_Helper._get_return_notices()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Helper.is_site_connected())))) {
		mut var_connect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-connect', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('connect')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
		rt.include_file((Class_WC_Helper.get_view_filename(rt.new_string('html-oauth-start.php'))).to_string(), '1')
		return rt.new_null()
	}
	mut var_disconnect_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'wc-helper-disconnect', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('disconnect')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	mut var_current_filter := Class_WC_Helper.get_current_filter()
	mut var_refresh_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-refresh', val: 1 }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('refresh')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	mut var_woo_plugins := Class_WC_Helper.get_local_woo_plugins()
	mut var_woo_themes := Class_WC_Helper.get_local_woo_themes()
	mut var_subscriptions_list_data := Class_WC_Helper.get_subscription_list_data()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_subscription := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_subscription.array_get('product_key'))))
	}
	mut var_subscriptions := rt.call_function('array_filter', [var_subscriptions_list_data.dup(), rt.new_closure(closure_1_fn)])
	mut var_updates := fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_update_data() }()
	mut var_subscriptions_product_ids := rt.call_function('wp_list_pluck', [var_subscriptions.dup(), rt.new_string('product_id')])
	{
		mut iter_1 := var_subscriptions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subscription := item_1.val
			var_subscription.array_set('activate_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-activate', val: 1 }, rt.ArrayItem{ key: 'wc-helper-product-key', val: var_subscription.array_get('product_key') }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_subscription.array_get('product_id') }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', ['activate:' + (var_subscription.array_get('product_key')).str()]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])]))
			var_subscription.array_set('deactivate_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: Class_WC_Helper.get_source_page() }, rt.ArrayItem{ key: 'section', val: 'helper' }, rt.ArrayItem{ key: 'filter', val: var_current_filter }, rt.ArrayItem{ key: 'wc-helper-deactivate', val: 1 }, rt.ArrayItem{ key: 'wc-helper-product-key', val: var_subscription.array_get('product_key') }, rt.ArrayItem{ key: 'wc-helper-product-id', val: var_subscription.array_get('product_id') }, rt.ArrayItem{ key: 'wc-helper-nonce', val: rt.call_function('wp_create_nonce', ['deactivate:' + (var_subscription.array_get('product_key')).str()]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])]))
			var_subscription.array_set('update_url', rt.call_function('admin_url', [rt.new_string('update-core.php')]))
			mut var_local := rt.call_function('wp_list_filter', [rt.call_function('array_merge', [var_woo_plugins.dup(), var_woo_themes.dup()]), rt.create_array([rt.ArrayItem{ key: '_product_id', val: var_subscription.array_get('product_id') }])])
			if !(!rt.is_true(var_local)) {
				var_local = rt.call_function('array_shift', [var_local.dup()])
				if rt.is_true(rt.identical(rt.new_string('plugin'), var_local.array_get('_type'))) {
					var_subscription.array_set('update_url', rt.call_function('wp_nonce_url', [rt.concat(rt.call_function('self_admin_url', [rt.new_string('update.php?action=upgrade-plugin&plugin=')]), var_local.array_get('_filename')), 'upgrade-plugin_' + (var_local.array_get('_filename')).str()]))
				} else if rt.is_true(rt.identical(rt.new_string('theme'), var_local.array_get('_type'))) {
					var_subscription.array_set('update_url', rt.call_function('wp_nonce_url', [rt.call_function('self_admin_url', ['update.php?action=upgrade-theme&theme=' + (var_local.array_get('_stylesheet')).str()]), 'upgrade-theme_' + (var_local.array_get('_stylesheet')).str()]))
				}
			}
			var_subscription.array_set('download_primary', true)
			var_subscription.array_set('download_url', 'https://woocommerce.com/my-account/downloads/')
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('local').array_get('installed'))))) && !(!rt.is_true(var_updates.array_get(var_subscription.array_get('product_id')))))) {
				var_subscription.array_set('download_url', var_updates.array_get(var_subscription.array_get('product_id')).array_get('package'))
			}
			var_subscription.array_set('actions', rt.new_array())
			if rt.is_true(rt.new_bool(rt.is_true(var_subscription.array_get('has_update')) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('expired'))))))) {
				mut var_action := { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s is <strong>available</strong>.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_updates.array_get(var_subscription.array_get('product_id')).array_get('version')])]), 'button_label': rt.call_function('__', [rt.new_string('Update'), rt.new_string('woocommerce')]), 'button_url': var_subscription.array_get('update_url'), 'status': rt.new_string('update-available'), 'icon': rt.new_string('dashicons-update') }
				if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('active'))))) {
					// unsupported expression: Expr_AssignOp_Concat
					var_action['button_label'] = rt.new_null()
					var_action['button_url'] = rt.new_null()
				}
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_subscription.array_get('has_update')) && rt.is_true(var_subscription.array_get('expired')))) {
				var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s is <strong>available</strong>.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_updates.array_get(var_subscription.array_get('product_id')).array_get('version')])]), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
				// unsupported expression: Expr_AssignOp_Concat
				var_action['button_label'] = rt.call_function('__', [rt.new_string('Purchase'), rt.new_string('woocommerce')])
				var_action['button_url'] = Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_subscription.array_get('product_url'), rt.new_string('purchase'))
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			} else if rt.is_true(rt.new_bool(rt.is_true(var_subscription.array_get('expired')) && !(!rt.is_true(var_subscription.array_get('master_user_email'))))) {
				var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription has expired. Contact the owner to <strong>renew</strong> the subscription to receive updates and support.'), rt.new_string('woocommerce')])]), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			} else if rt.is_true(var_subscription.array_get('expired')) {
				var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription has expired. Please <strong>renew</strong> to receive updates and support.'), rt.new_string('woocommerce')])]), 'button_label': rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_subscription.array_get('expiring')) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('autorenew'))))))) {
				var_action = { 'message': rt.call_function('__', [rt.new_string('Subscription is <strong>expiring</strong> soon.'), rt.new_string('woocommerce')]), 'button_label': rt.call_function('__', [rt.new_string('Enable auto-renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('auto-renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
				var_subscription.array_set('download_primary', false)
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			} else if rt.is_true(var_subscription.array_get('expiring')) {
				var_action = { 'message': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This subscription is expiring soon. Please <strong>renew</strong> to continue receiving updates and support.'), rt.new_string('woocommerce')])]), 'button_label': rt.call_function('__', [rt.new_string('Renew'), rt.new_string('woocommerce')]), 'button_url': Class_WC_Helper.add_utm_params_to_url_for_subscription_link(rt.new_string('https://woocommerce.com/my-account/my-subscriptions/'), rt.new_string('renew')), 'status': rt.new_string('expired'), 'icon': rt.new_string('dashicons-info') }
				var_subscription.array_set('download_primary', false)
				var_subscription.array_get_mut('actions').array_push(var_action.dup())
			}
			{
				mut iter_2 := var_subscription.array_get('actions').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_action_shadow := item_2.val
					mut var_key := item_2.key
					if !(!rt.is_true(var_action_shadow.array_get('button_label'))) {
						var_subscription.array_get_mut('actions').array_get_mut(var_key).array_set('primary', true)
						break
					}
				}
			}
		}
	}
	var_subscription = rt.new_null()
	mut var_no_subscriptions := rt.new_array()
	{
		mut iter_1 := rt.call_function('array_merge', [.dup(), .dup()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_filename := item_1.key
			if rt.is_true() {
			}
			
		}
	}
}

fn Class_WC_Helper.add_utm_params_to_url_for_subscription_link(var_url rt.PhpVal, var_utm_content rt.PhpVal) string {
	mut var_url_mutated := var_url
}

fn Class_WC_Helper.get_filters() rt.PhpVal {
}

fn Class_WC_Helper.get_filters_counts(var_subscriptions rt.PhpVal) rt.PhpVal {
	mut var_subscriptions_mutated := var_subscriptions
}

fn Class_WC_Helper.get_current_filter() rt.PhpVal {
}

fn Class_WC_Helper._filter(var_subscriptions rt.PhpVal, var_filter rt.PhpVal)  {
	mut var_subscriptions_mutated := var_subscriptions
}

fn Class_WC_Helper.admin_enqueue_scripts()  {
}

fn Class_WC_Helper._get_return_notices() rt.PhpVal {
}

fn Class_WC_Helper.current_screen(var_screen rt.PhpVal) rt.PhpVal {
	mut var_screen_mutated := var_screen
	return rt.new_null()
}

fn Class_WC_Helper.maybe_redirect_to_new_marketplace_installer()  {
}

fn Class_WC_Helper.get_helper_redirect_url(var_args rt.PhpVal) rt.PhpVal {
	mut var_current_screen := rt.new_null()
}

fn Class_WC_Helper._helper_auth_connect()  {
}

fn Class_WC_Helper._helper_auth_return()  {
}

fn Class_WC_Helper._helper_auth_disconnect()  {
}

fn Class_WC_Helper._helper_auth_refresh()  {
}

fn Class_WC_Helper.refresh_helper_subscriptions()  {
}

fn Class_WC_Helper._helper_subscription_activate()  {
}

fn Class_WC_Helper.activate_helper_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper.activate_plugin(var_product_key rt.PhpVal) bool {
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper.helper_subscription_deactivate()  {
}

fn Class_WC_Helper.deactivate_helper_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper.get_subscription_install_url(var_product_key rt.PhpVal, var_product_slug rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper._helper_plugin_deactivate()  {
}

fn Class_WC_Helper._get_local_from_product_id(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper.has_product_subscription(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper.get_installed_subscriptions() rt.PhpVal {
}

fn Class_WC_Helper.get_unconnected_subscriptions() rt.PhpVal {
}

fn Class_WC_Helper.get_product_subscription_state(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper._get_subscriptions_from_product_id(var_product_id rt.PhpVal, single bool) bool {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper.get_local_plugins() rt.PhpVal {
}

fn Class_WC_Helper.get_local_themes() rt.PhpVal {
}

fn Class_WC_Helper.get_local_woo_plugins() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_file_id := rt.new_null()
}

fn Class_WC_Helper.get_local_woo_themes() rt.PhpVal {
	mut var_product_id := rt.new_null()
	mut var_file_id := rt.new_null()
}

fn Class_WC_Helper.get_product_usage_notice_rules() rt.PhpVal {
}

fn Class_WC_Helper.verify_request_hash(request_hash string) bool {
}

fn Class_WC_Helper.get_cached_connection_data() rt.PhpVal {
}

fn Class_WC_Helper.fetch_helper_connection_info() rt.PhpVal {
}

fn Class_WC_Helper.get_subscriptions() rt.PhpVal {
}

fn Class_WC_Helper.get_subscription(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper.get_subscription_list_data() rt.PhpVal {
}

fn Class_WC_Helper.is_subscription_available(var_subscription rt.PhpVal, var_subscriptions rt.PhpVal) bool {
	mut var_subscription_mutated := var_subscription
	mut var_subscriptions_mutated := var_subscriptions
}

fn Class_WC_Helper.is_subscription_installed(var_subscription rt.PhpVal, var_subscriptions rt.PhpVal) bool {
	mut var_subscription_mutated := var_subscription
	mut var_subscriptions_mutated := var_subscriptions
}

fn Class_WC_Helper.get_subscription_local_data(mut var_subscription Class_array) rt.PhpVal {
	mut var_subscription_mutated := var_subscription
}

fn Class_WC_Helper.activated_plugin(var_filename rt.PhpVal)  {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
}

fn Class_WC_Helper.connect_theme(var_product_id rt.PhpVal)  {
	mut var_activation_response := rt.new_null()
	mut var_activated := rt.new_null()
	mut var_body := rt.new_null()
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper.deactivated_plugin(var_filename rt.PhpVal)  {
}

fn Class_WC_Helper.admin_notices()  {
}

fn Class_WC_Helper._get_extensions_update_notice() rt.PhpVal {
}

fn Class_WC_Helper._woo_core_update_available() bool {
}

fn Class_WC_Helper._flush_subscriptions_cache()  {
}

fn Class_WC_Helper.flush_product_usage_notice_rules_cache()  {
}

fn Class_WC_Helper.flush_connection_data_cache()  {
}

fn Class_WC_Helper._flush_authentication_cache() bool {
}

fn Class_WC_Helper._flush_updates_cache()  {
}

fn Class_WC_Helper._sort_by_product_name(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Helper._sort_by_name(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Helper.log(var_message rt.PhpVal, level string)  {
	mut var_message_mutated := var_message
}

fn Class_WC_Helper.disconnect()  {
}

fn Class_WC_Helper.is_site_connected() bool {
}

fn Class_WC_Helper.connect_with_password(password string) rt.PhpVal {
	return rt.new_null()
}

fn Class_WC_Helper.update_auth_option(access_token string, access_token_secret string, site_id i64, home_url string)  {
	mut access_token_mutated := access_token
	mut site_id_mutated := site_id
}

fn Class_WC_Helper.get_woocommerce_com_base_url() rt.PhpVal {
}

fn Class_WC_Helper.get_install_base_url() string {
}

fn Class_WC_Helper.get_notices() rt.PhpVal {
}

fn Class_WC_Helper.wccom_activate(var_product_key rt.PhpVal) rt.PhpVal {
	mut var_product_key_mutated := var_product_key
}

fn Class_WC_Helper.get_available_subscription(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
}

fn Class_WC_Helper.get_message_for_response_code(code i64) string {
	mut code_mutated := code
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

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
		log: rt.new_null()
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options() &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
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
	match prop_name {
		'log' { return this.log }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'log' { this.log = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_helper_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
