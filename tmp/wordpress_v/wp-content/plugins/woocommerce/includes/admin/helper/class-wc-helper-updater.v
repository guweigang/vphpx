import rt

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Updater.load()  {
	rt.call_function('add_action', [rt.new_string('pre_set_site_transient_update_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'transient_update_plugins' }]), rt.new_int(21), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('pre_set_site_transient_update_themes'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'transient_update_themes' }]), rt.new_int(21), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'upgrader_process_complete' }])])
	rt.call_function('add_action', [rt.new_string('upgrader_pre_download'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'block_expired_updates' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_hook_for_modifying_update_notices' }])])
}

fn Class_WC_Helper_Updater.add_hook_for_modifying_update_notices()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_active() }())))) || rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }())))))) {
		rt.call_function('add_action', [rt.new_string('load-plugins.php'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'setup_update_plugins_messages' }]), rt.new_int(11)])
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()) {
		rt.call_function('add_action', [rt.new_string('load-plugins.php'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'setup_message_for_expired_and_expiring_subscriptions' }]), rt.new_int(11)])
		rt.call_function('add_action', [rt.new_string('load-plugins.php'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'setup_message_for_plugins_without_subscription' }]), rt.new_int(11)])
	}
}

fn Class_WC_Helper_Updater.setup_message_for_expired_and_expiring_subscriptions()  {
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			rt.call_function('add_action', ['in_plugin_update_message-' + (var_plugin.array_get('_filename')).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'display_notice_for_expired_and_expiring_subscriptions' }]), rt.new_int(10), rt.new_int(2)])
		}
	}
}

fn Class_WC_Helper_Updater.setup_message_for_plugins_without_subscription()  {
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			rt.call_function('add_action', ['in_plugin_update_message-' + (var_plugin.array_get('_filename')).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'display_notice_for_plugins_without_subscription' }]), rt.new_int(10), rt.new_int(2)])
		}
	}
}

fn Class_WC_Helper_Updater.transient_update_plugins(var_transient rt.PhpVal) rt.PhpVal {
	mut var_transient_mutated := var_transient
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if !rt.is_true(var_update_data.array_get(var_plugin.array_get('_product_id'))) {
				continue
			}
			mut var_data := var_update_data.array_get(var_plugin.array_get('_product_id'))
			mut var_filename := var_plugin.array_get('_filename')
			mut var_item := rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-com-' + (var_plugin.array_get('_product_id')).str() }, rt.ArrayItem{ key: 'slug', val: 'woocommerce-com-' + (var_data.array_get('slug')).str() }, rt.ArrayItem{ key: 'plugin', val: var_filename }, rt.ArrayItem{ key: 'new_version', val: var_data.array_get('version') }, rt.ArrayItem{ key: 'url', val: var_data.array_get('url') }, rt.ArrayItem{ key: 'package', val: '' }, rt.ArrayItem{ key: 'upgrade_notice', val: var_data.array_get('upgrade_notice') }])
			var_item = rt.call_function('apply_filters', [rt.new_string('update_woo_com_subscription_details'), var_item.dup(), var_data.dup(), var_plugin.array_get('_product_id')])
			if var_data.array_isset(rt.new_string('requires_php')) {
				var_item.array_set('requires_php', var_data.array_get('requires_php'))
			}
			if var_data.array_isset(rt.new_string('tested')) {
				var_item.array_set('tested', var_data.array_get('tested'))
			}
			if var_data.array_isset(rt.new_string('icons')) {
				var_item.array_set('icons', var_data.array_get('icons'))
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_transient_mutated, 'stdClass'))) {
				if rt.is_true(rt.call_function('version_compare', [var_plugin.array_get('Version'), var_data.array_get('version'), rt.new_string('<')])) {
					rt.get_property(var_transient_mutated, 'response').array_set(var_filename, // unsupported expression: Expr_Cast_Object)
					rt.get_property(var_transient_mutated, 'no_update').array_unset(var_filename)
				} else {
					rt.get_property(var_transient_mutated, 'no_update').array_set(var_filename, // unsupported expression: Expr_Cast_Object)
					rt.get_property(var_transient_mutated, 'response').array_unset(var_filename)
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_transient_mutated, 'stdClass'))) {
		mut var_translations := Class_WC_Helper_Updater.get_translations_update_data()
		rt.set_property(var_transient_mutated, 'translations', rt.call_function('array_merge', [if !(rt.get_property(var_transient_mutated, 'translations')).is_null() { rt.get_property(var_transient_mutated, 'translations') } else { rt.new_array() }, var_translations.dup()]))
	}
	return var_transient_mutated.dup()
}

fn Class_WC_Helper_Updater.transient_update_themes(var_transient rt.PhpVal) rt.PhpVal {
	mut var_transient_mutated := var_transient
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_themes() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme := item_1.val
			if !rt.is_true(var_update_data.array_get(var_theme.array_get('_product_id'))) {
				continue
			}
			mut var_data := var_update_data.array_get(var_theme.array_get('_product_id'))
			mut var_slug := var_theme.array_get('_stylesheet')
			mut var_item := rt.create_array([rt.ArrayItem{ key: 'theme', val: var_slug }, rt.ArrayItem{ key: 'new_version', val: var_data.array_get('version') }, rt.ArrayItem{ key: 'url', val: var_data.array_get('url') }, rt.ArrayItem{ key: 'package', val: '' }])
			var_item = rt.call_function('apply_filters', [rt.new_string('update_woo_com_subscription_details'), var_item.dup(), var_data.dup(), var_theme.array_get('_product_id')])
			if rt.is_true(rt.call_function('version_compare', [var_theme.array_get('Version'), var_data.array_get('version'), rt.new_string('<')])) {
				rt.get_property(var_transient_mutated, 'response').array_set(var_slug, var_item.dup())
			} else {
				rt.get_property(var_transient_mutated, 'response').array_unset(var_slug)
				rt.get_property(var_transient_mutated, 'checked').array_set(var_slug, var_data.array_get('version'))
			}
		}
	}
	return var_transient_mutated.dup()
}

fn Class_WC_Helper_Updater.setup_update_plugins_messages()  {
	mut var_is_site_connected := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_filename := var_plugin.array_get('_filename')
			if rt.is_true(var_is_site_connected) {
				rt.call_function('add_action', ['in_plugin_update_message-' + (var_filename).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_install_marketplace_plugin_message' }]), rt.new_int(10), rt.new_int(2)])
			} else {
				rt.call_function('add_action', ['in_plugin_update_message-' + (var_filename).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_connect_woocom_plugin_message' }])])
			}
		}
	}
}

fn Class_WC_Helper_Updater.add_connect_woocom_plugin_message()  {
	mut var_connect_page_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' }, rt.ArrayItem{ key: 'tab', val: 'my-subscriptions' }, rt.ArrayItem{ key: 'path', val: rt.call_function('rawurlencode', [rt.new_string('/extensions')]) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_connect' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	rt.call_function('printf', [rt.call_function('wp_kses', [rt.call_function('__', [rt.new_string(' <a href="%1$s" class="woocommerce-connect-your-store">Connect your store</a> to woocommerce.com to update.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }, rt.ArrayItem{ key: 'class', val: rt.new_array() }]) }])]), rt.call_function('esc_url', [var_connect_page_url.dup()])])
}

fn Class_WC_Helper_Updater.add_install_marketplace_plugin_message(var_plugin_data rt.PhpVal, var_response rt.PhpVal)  {
	mut var_response_mutated := var_response
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_response_mutated, 'package'))) || rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_active() }()))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_installed() }())))) {
		rt.call_function('printf', [rt.call_function('wp_kses', [rt.call_function('__', [rt.new_string(' <a href="%1$s">Install WooCommerce.com Update Manager</a> to update.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }]) }])]), rt.call_function('esc_url', [fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.generate_install_url() }()])])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_active() }())))) {
		rt.call_function('esc_html_e', [rt.new_string(' Activate WooCommerce.com Update Manager to update.'), rt.new_string('woocommerce')])
	}
}

fn Class_WC_Helper_Updater.display_notice_for_expired_and_expiring_subscriptions(var_plugin_data rt.PhpVal, var_response rt.PhpVal)  {
	mut var_response_mutated := var_response
	mut var_product_id := rt.call_function('preg_replace', [rt.new_string('/[^0-9]/'), rt.new_string(''), rt.get_property(var_response_mutated, 'id')])
	mut var_installed_or_unconnected := rt.call_function('array_merge', [fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_installed_subscriptions() }(), fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_unconnected_subscriptions() }()])
	mut var_subscriptions := rt.call_function('wp_list_filter', [var_installed_or_unconnected.dup(), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }])])
	if !rt.is_true(var_subscriptions) {
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_subscription := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_subscription.array_get('expired'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('lifetime'))))))
	}
	mut var_subscription := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_subscription.array_get('expired'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('lifetime'))))))
	}
	mut var_expired_subscription := rt.call_function('current', [rt.call_function('array_filter', [var_subscriptions.dup(), rt.new_closure(closure_1_fn)])])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_subscription := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_subscription.array_get('expiring'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('autorenew'))))))
	}
	mut var_subscription := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_subscription.array_get('expiring'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_subscription.array_get('autorenew'))))))
	}
	mut var_expiring_subscription := rt.call_function('current', [rt.call_function('array_filter', [var_subscriptions.dup(), rt.new_closure(closure_3_fn)])])
	mut var_expiry_notice := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(var_expired_subscription)) {
		mut var_renew_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_product_id }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_renew' }]), Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url()])
		mut var_product_price := if !(!rt.is_true(var_expired_subscription.array_get('product_regular_price'))) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('for %s '), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_expired_subscription.array_get('product_regular_price')])]) } else { rt.new_string('') }
		var_expiry_notice = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string(' Your subscription expired, <a href="%1$s" class="woocommerce-renew-subscription">renew %2$s</a>to update.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [var_renew_link.dup()]), var_product_price.dup()])
	} else if !(!rt.is_true(var_expiring_subscription)) {
		var_renew_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_enable_autorenew' }]), Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url()])
		var_expiry_notice = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string(' Your subscription expires on %1$s, <a href="%2$s" class="woocommerce-enable-autorenew">enable auto-renew</a> to continue receiving updates.'), rt.new_string('woocommerce')]), rt.call_function('date_i18n', [rt.new_string('F jS'), var_expiring_subscription.array_get('expires')]), rt.call_function('esc_url', [var_renew_link.dup()])])
	}
	if !(!rt.is_true(var_expiry_notice)) {
		rt.echo_val(rt.call_function('wp_kses', [var_expiry_notice.dup(), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }, rt.ArrayItem{ key: 'class', val: rt.new_array() }]) }])]))
	}
}

fn Class_WC_Helper_Updater.display_notice_for_plugins_without_subscription(var_plugin_data rt.PhpVal, var_response rt.PhpVal)  {
	mut var_response_mutated := var_response
	mut var_product_id := rt.call_function('preg_replace', [rt.new_string('/[^0-9]/'), rt.new_string(''), rt.get_property(var_response_mutated, 'id')])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.has_product_subscription(arg_0) }(var_product_id.dup())) {
		return rt.new_null()
	}
	mut var_purchase_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_product_id }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_purchase' }]), Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url()])
	mut var_notice := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string(' You don\'t have a subscription, <a href="%1$s" class="woocommerce-purchase-subscription">subscribe</a> to update.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [var_purchase_link.dup()])])
	rt.echo_val(rt.call_function('wp_kses', [var_notice.dup(), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.new_array() }, rt.ArrayItem{ key: 'class', val: rt.new_array() }]) }])]))
}

fn Class_WC_Helper_Updater.get_available_extensions_downloads_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut var_subscriptions := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscriptions() }()
	{
		mut iter_1 := var_subscriptions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subscription := item_1.val
			var_payload.array_set(var_subscription.array_get('product_id'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_subscription.array_get('product_id') }, rt.ArrayItem{ key: 'file_id', val: '' }]))
		}
	}
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			if !(var_payload.array_isset(var_data.array_get('_product_id'))) {
				var_payload.array_set(var_data.array_get('_product_id'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_data.array_get('_product_id') }]))
			}
			var_payload.array_get_mut(var_data.array_get('_product_id')).array_set('file_id', var_data.array_get('_file_id'))
		}
	}
	return Class_WC_Helper_Updater._update_check(var_payload.dup())
}

fn Class_WC_Helper_Updater.get_update_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut var_subscriptions := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscriptions() }()
	{
		mut iter_1 := var_subscriptions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subscription := item_1.val
			var_payload.array_set(var_subscription.array_get('product_id'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_subscription.array_get('product_id') }, rt.ArrayItem{ key: 'file_id', val: '' }]))
		}
	}
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_plugins() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			if !(var_payload.array_isset(var_data.array_get('_product_id'))) {
				var_payload.array_set(var_data.array_get('_product_id'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_data.array_get('_product_id') }]))
			}
			var_payload.array_get_mut(var_data.array_get('_product_id')).array_set('file_id', var_data.array_get('_file_id'))
		}
	}
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_woo_themes() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			if !(var_payload.array_isset(var_data.array_get('_product_id'))) {
				var_payload.array_set(var_data.array_get('_product_id'), rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_data.array_get('_product_id') }]))
			}
			var_payload.array_get_mut(var_data.array_get('_product_id')).array_set('file_id', var_data.array_get('_file_id'))
		}
	}
	return Class_WC_Helper_Updater._update_check(var_payload.dup())
}

fn Class_WC_Helper_Updater.get_translations_update_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut var_installed_translations := rt.call_function('wp_get_installed_translations', [rt.new_string('plugins')])
	mut var_locales := rt.call_function('array_values', [])
	var_locales = 
	
}

fn Class_WC_Helper_Updater.should_use_cached_update_data(var_data rt.PhpVal, var_hash rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_hash_mutated := var_hash
}

fn Class_WC_Helper_Updater._update_check(var_payload rt.PhpVal) rt.PhpVal {
	mut var_payload_mutated := var_payload
}

fn Class_WC_Helper_Updater.get_updates_count() i64 {
}

fn Class_WC_Helper_Updater.get_updates_count_based_on_site_status() i64 {
}

fn Class_WC_Helper_Updater.get_woo_connect_notice_type() string {
}

fn Class_WC_Helper_Updater.get_updates_count_html() rt.PhpVal {
}

fn Class_WC_Helper_Updater.flush_updates_cache()  {
}

fn Class_WC_Helper_Updater.upgrader_process_complete()  {
}

fn Class_WC_Helper_Updater.block_expired_updates(var_reply rt.PhpVal, var_package rt.PhpVal) bool {
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_woo_update_manager_plugin() &Class_WC_Woo_Update_Manager_Plugin {
	mut obj := &Class_WC_Woo_Update_Manager_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_Updater.load()
			return rt.new_null()
		}
		'add_hook_for_modifying_update_notices' {
			Class_WC_Helper_Updater.add_hook_for_modifying_update_notices()
			return rt.new_null()
		}
		'setup_message_for_expired_and_expiring_subscriptions' {
			Class_WC_Helper_Updater.setup_message_for_expired_and_expiring_subscriptions()
			return rt.new_null()
		}
		'setup_message_for_plugins_without_subscription' {
			Class_WC_Helper_Updater.setup_message_for_plugins_without_subscription()
			return rt.new_null()
		}
		'transient_update_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Updater.transient_update_plugins(dispatch_arg_0)
		}
		'transient_update_themes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Updater.transient_update_themes(dispatch_arg_0)
		}
		'setup_update_plugins_messages' {
			Class_WC_Helper_Updater.setup_update_plugins_messages()
			return rt.new_null()
		}
		'add_connect_woocom_plugin_message' {
			Class_WC_Helper_Updater.add_connect_woocom_plugin_message()
			return rt.new_null()
		}
		'add_install_marketplace_plugin_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper_Updater.add_install_marketplace_plugin_message(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display_notice_for_expired_and_expiring_subscriptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper_Updater.display_notice_for_expired_and_expiring_subscriptions(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display_notice_for_plugins_without_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper_Updater.display_notice_for_plugins_without_subscription(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_available_extensions_downloads_data' {
			return Class_WC_Helper_Updater.get_available_extensions_downloads_data()
		}
		'get_update_data' {
			return Class_WC_Helper_Updater.get_update_data()
		}
		'get_translations_update_data' {
			return Class_WC_Helper_Updater.get_translations_update_data()
		}
		'should_use_cached_update_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper_Updater.should_use_cached_update_data(dispatch_arg_0, dispatch_arg_1))
		}
		'_update_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Updater._update_check(dispatch_arg_0)
		}
		'get_updates_count' {
			return rt.new_int(Class_WC_Helper_Updater.get_updates_count())
		}
		'get_updates_count_based_on_site_status' {
			return rt.new_int(Class_WC_Helper_Updater.get_updates_count_based_on_site_status())
		}
		'get_woo_connect_notice_type' {
			return rt.new_string(Class_WC_Helper_Updater.get_woo_connect_notice_type())
		}
		'get_updates_count_html' {
			return Class_WC_Helper_Updater.get_updates_count_html()
		}
		'flush_updates_cache' {
			Class_WC_Helper_Updater.flush_updates_cache()
			return rt.new_null()
		}
		'upgrader_process_complete' {
			Class_WC_Helper_Updater.upgrader_process_complete()
			return rt.new_null()
		}
		'block_expired_updates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Helper_Updater.block_expired_updates(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_helper_updater_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
