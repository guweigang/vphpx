import rt
import crypto.md5

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Updater.load() {
	rt.call_function('add_action', [
		rt.new_string('pre_set_site_transient_update_plugins'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'transient_update_plugins' }]),
		rt.new_int(21),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('pre_set_site_transient_update_themes'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'transient_update_themes' }]),
		rt.new_int(21),
		rt.new_int(1),
	])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'upgrader_process_complete' }])])
	rt.call_function('add_action', [rt.new_string('upgrader_pre_download'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'block_expired_updates' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_hook_for_modifying_update_notices' }])])
}

fn Class_WC_Helper_Updater.add_hook_for_modifying_update_notices() {
	mut iife_temp_0 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_0 := iife_temp_0.is_plugin_active()
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		rt.call_function('add_action', [rt.new_string('load-plugins.php'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'setup_update_plugins_messages' }]),
			rt.new_int(11)])
	}
	mut iife_temp_2 := Class_WC_Helper{}
	mut iife_result_2 := iife_temp_2.is_site_connected()
	if rt.is_true(iife_result_2) {
		rt.call_function('add_action', [rt.new_string('load-plugins.php'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'setup_message_for_expired_and_expiring_subscriptions' }]),
			rt.new_int(11)])
		rt.call_function('add_action', [rt.new_string('load-plugins.php'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'setup_message_for_plugins_without_subscription' }]),
			rt.new_int(11)])
	}
}

fn Class_WC_Helper_Updater.setup_message_for_expired_and_expiring_subscriptions() {
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_local_woo_plugins()
	mut iter_1 := iife_result_3.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		rt.call_function('add_action', [
			rt.new_string('in_plugin_update_message-' +
				(var_plugin.array_get(rt.new_string('_filename'))).str()),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{
					key: none
					val: 'display_notice_for_expired_and_expiring_subscriptions'
				}]),
			rt.new_int(10),
			rt.new_int(2),
		])
	}
}

fn Class_WC_Helper_Updater.setup_message_for_plugins_without_subscription() {
	mut iife_temp_4 := Class_WC_Helper{}
	mut iife_result_4 := iife_temp_4.get_local_woo_plugins()
	mut iter_2 := iife_result_4.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin := item_2.val
		rt.call_function('add_action', [
			rt.new_string('in_plugin_update_message-' +
				(var_plugin.array_get(rt.new_string('_filename'))).str()),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'display_notice_for_plugins_without_subscription' }]),
			rt.new_int(10),
			rt.new_int(2),
		])
	}
}

fn Class_WC_Helper_Updater.transient_update_plugins(var_transient rt.PhpVal) rt.PhpVal {
	mut var_transient_mutated := var_transient
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	mut iife_temp_5 := Class_WC_Helper{}
	mut iife_result_5 := iife_temp_5.get_local_woo_plugins()
	mut iter_3 := iife_result_5.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin := item_3.val
		if !rt.is_true(var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id')))) {
			continue
		}
		mut var_data :=
			var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id')))
		mut var_filename := var_plugin.array_get(rt.new_string('_filename'))
		mut var_item := rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce-com-' +
				(var_plugin.array_get(rt.new_string('_product_id'))).str() },
			rt.ArrayItem{ key: 'slug', val: 'woocommerce-com-' +
				(var_data.array_get(rt.new_string('slug'))).str() },
			rt.ArrayItem{ key: 'plugin', val: var_filename },
			rt.ArrayItem{ key: 'new_version', val: var_data.array_get(rt.new_string('version')) },
			rt.ArrayItem{ key: 'url', val: var_data.array_get(rt.new_string('url')) },
			rt.ArrayItem{ key: 'package', val: '' },
			rt.ArrayItem{
				key: 'upgrade_notice'
				val: var_data.array_get(rt.new_string('upgrade_notice'))
			},
		])
		var_item = rt.call_function('apply_filters', [
			rt.new_string('update_woo_com_subscription_details'),
			var_item.clone(),
			var_data.clone(),
			var_plugin.array_get(rt.new_string('_product_id')),
		])
		if var_data.array_isset(rt.new_string('requires_php')) {
			var_item.array_set('requires_php', var_data.array_get(rt.new_string('requires_php')))
		}
		if var_data.array_isset(rt.new_string('tested')) {
			var_item.array_set('tested', var_data.array_get(rt.new_string('tested')))
		}
		if var_data.array_isset(rt.new_string('icons')) {
			var_item.array_set('icons', var_data.array_get(rt.new_string('icons')))
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_transient_mutated, 'stdClass'))) {
			if rt.is_true(rt.call_function('version_compare', [
				var_plugin.array_get(rt.new_string('Version')),
				var_data.array_get(rt.new_string('version')),
				rt.new_string('<'),
			]))
			{
				rt.get_property(var_transient_mutated, 'response').array_set(var_filename,
					rt.array_to_object(var_item))
				rt.get_property(var_transient_mutated, 'no_update').array_unset(var_filename)
			} else {
				rt.get_property(var_transient_mutated, 'no_update').array_set(var_filename,
					rt.array_to_object(var_item))
				rt.get_property(var_transient_mutated, 'response').array_unset(var_filename)
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_transient_mutated, 'stdClass'))) {
		mut var_translations := Class_WC_Helper_Updater.get_translations_update_data()
		rt.set_property(var_transient_mutated, 'translations', rt.call_function('array_merge', [
			if !(rt.get_property(var_transient_mutated, 'translations')).is_null() {
				rt.get_property(var_transient_mutated, 'translations')
			} else {
				rt.new_array()
			},
			var_translations.clone(),
		]))
	}
	return var_transient_mutated.clone()
}

fn Class_WC_Helper_Updater.transient_update_themes(var_transient rt.PhpVal) rt.PhpVal {
	mut var_transient_mutated := var_transient
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	mut iife_temp_6 := Class_WC_Helper{}
	mut iife_result_6 := iife_temp_6.get_local_woo_themes()
	mut iter_4 := iife_result_6.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme := item_4.val
		if !rt.is_true(var_update_data.array_get(var_theme.array_get(rt.new_string('_product_id')))) {
			continue
		}
		mut var_data := var_update_data.array_get(var_theme.array_get(rt.new_string('_product_id')))
		mut var_slug := var_theme.array_get(rt.new_string('_stylesheet'))
		mut var_item := rt.create_array([rt.ArrayItem{ key: 'theme', val: var_slug },
			rt.ArrayItem{ key: 'new_version', val: var_data.array_get(rt.new_string('version')) },
			rt.ArrayItem{ key: 'url', val: var_data.array_get(rt.new_string('url')) },
			rt.ArrayItem{ key: 'package', val: '' }])
		var_item = rt.call_function('apply_filters', [
			rt.new_string('update_woo_com_subscription_details'),
			var_item.clone(),
			var_data.clone(),
			var_theme.array_get(rt.new_string('_product_id')),
		])
		if rt.is_true(rt.call_function('version_compare', [
			var_theme.array_get(rt.new_string('Version')),
			var_data.array_get(rt.new_string('version')),
			rt.new_string('<'),
		]))
		{
			rt.get_property(var_transient_mutated, 'response').array_set(var_slug, var_item.clone())
		} else {
			rt.get_property(var_transient_mutated, 'response').array_unset(var_slug)
			rt.get_property(var_transient_mutated, 'checked').array_set(var_slug,
				var_data.array_get(rt.new_string('version')))
		}
	}
	return var_transient_mutated.clone()
}

fn Class_WC_Helper_Updater.setup_update_plugins_messages() {
	mut iife_temp_7 := Class_WC_Helper{}
	mut iife_result_7 := iife_temp_7.is_site_connected()
	mut var_is_site_connected := iife_result_7
	mut iife_temp_8 := Class_WC_Helper{}
	mut iife_result_8 := iife_temp_8.get_local_woo_plugins()
	mut iter_5 := iife_result_8.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_plugin := item_5.val
		mut var_filename := var_plugin.array_get(rt.new_string('_filename'))
		if rt.is_true(var_is_site_connected) {
			rt.call_function('add_action', [
				rt.new_string('in_plugin_update_message-' + var_filename.str()),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'add_install_marketplace_plugin_message' }]),
				rt.new_int(10),
				rt.new_int(2),
			])
		} else {
			rt.call_function('add_action', [
				rt.new_string('in_plugin_update_message-' + var_filename.str()),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'add_connect_woocom_plugin_message' }]),
			])
		}
	}
}

fn Class_WC_Helper_Updater.add_connect_woocom_plugin_message() {
	mut var_connect_page_url := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' },
			rt.ArrayItem{ key: 'tab', val: 'my-subscriptions' },
			rt.ArrayItem{ key: 'path', val: rt.call_function('rawurlencode', [
				rt.new_string('/extensions'),
			]) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' },
			rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_connect' }]),
		rt.call_function('admin_url', [rt.new_string('admin.php')]),
	])
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string(' <a href="%1$s" class="woocommerce-connect-your-store">Connect your store</a> to woocommerce.com to update.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
					rt.ArrayItem{ key: 'class', val: rt.new_array() },
				]) },
			]),
		]),
		rt.call_function('esc_url', [
			var_connect_page_url.clone(),
		]),
	])
}

fn Class_WC_Helper_Updater.add_install_marketplace_plugin_message(var_plugin_data rt.PhpVal, var_response rt.PhpVal) {
	mut var_response_mutated := var_response
	mut iife_temp_9 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_9 := iife_temp_9.is_plugin_active()
	if !(!rt.is_true(rt.get_property(var_response_mutated, 'package'))) || rt.is_true(iife_result_9) {
		return
	}
	mut iife_temp_10 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_10 := iife_temp_10.is_plugin_installed()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_10)))) {
		mut iife_temp_11 := Class_WC_Woo_Update_Manager_Plugin{}
		mut iife_result_11 := iife_temp_11.generate_install_url()
		mut iife_temp_12 := Class_WC_Woo_Update_Manager_Plugin{}
		mut iife_result_12 := iife_temp_12.generate_install_url()
		rt.call_function('printf', [
			rt.call_function('wp_kses', [
				rt.call_function('__', [
					rt.new_string(' <a href="%1$s">Install WooCommerce.com Update Manager</a> to update.'),
					rt.new_string('woocommerce'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'a', val: rt.create_array([
						rt.ArrayItem{ key: 'href', val: rt.new_array() },
					]) },
				]),
			]),
			rt.call_function('esc_url', [
				iife_result_11,
			]),
		])
		return
	}
	mut iife_temp_13 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_13 := iife_temp_13.is_plugin_active()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13)))) {
		rt.call_function('esc_html_e', [
			rt.new_string(' Activate WooCommerce.com Update Manager to update.'),
			rt.new_string('woocommerce'),
		])
	}
}

fn Class_WC_Helper_Updater.display_notice_for_expired_and_expiring_subscriptions(var_plugin_data rt.PhpVal, var_response rt.PhpVal) {
	mut var_response_mutated := var_response
	mut var_product_id := rt.call_function('preg_replace', [rt.new_string('/[^0-9]/'),
		rt.new_string(''), rt.get_property(var_response_mutated, 'id')])
	mut iife_temp_14 := Class_WC_Helper{}
	mut iife_result_14 := iife_temp_14.get_installed_subscriptions()
	mut iife_temp_15 := Class_WC_Helper{}
	mut iife_result_15 := iife_temp_15.get_unconnected_subscriptions()
	mut iife_temp_16 := Class_WC_Helper{}
	mut iife_result_16 := iife_temp_16.get_installed_subscriptions()
	mut var_installed_or_unconnected := rt.call_function('array_merge', [
		iife_result_14,
		iife_result_15,
	])
	mut var_subscriptions := rt.call_function('wp_list_filter', [
		var_installed_or_unconnected.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: var_product_id },
		])])
	if !rt.is_true(var_subscriptions) {
		return
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_expired_subscription := rt.call_function('current', [
		rt.call_function('array_filter', [var_subscriptions.clone(),
			rt.new_closure(closure_18_fn)]),
	])
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subscription := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_expiring_subscription := rt.call_function('current', [
		rt.call_function('array_filter', [var_subscriptions.clone(),
			rt.new_closure(closure_20_fn)]),
	])
	mut var_expiry_notice := rt.new_string('')
	if !(!rt.is_true(var_expired_subscription)) {
		mut var_renew_link := rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_product_id },
				rt.ArrayItem{ key: 'utm_source', val: 'pu' },
				rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_renew' }]),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url(),
		])
		mut var_product_price := if !(!rt.is_true(var_expired_subscription.array_get(rt.new_string('product_regular_price')))) { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('for %s '),
					rt.new_string('woocommerce')]),
				rt.call_function('esc_html', [var_expired_subscription.array_get(rt.new_string('product_regular_price'))]),
			]) } else { rt.new_string('') }
		var_expiry_notice = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string(' Your subscription expired, <a href="%1$s" class="woocommerce-renew-subscription">renew %2$s</a>to update.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				var_renew_link.clone(),
			]),
			var_product_price.clone(),
		])
	} else if !(!rt.is_true(var_expiring_subscription)) {
		var_renew_link = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'utm_source', val: 'pu' },
				rt.ArrayItem{ key: 'utm_campaign', val: 'pu_plugin_screen_enable_autorenew' }]),
			Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_subscription_page_url(),
		])
		var_expiry_notice = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string(' Your subscription expires on %1$s, <a href="%2$s" class="woocommerce-enable-autorenew">enable auto-renew</a> to continue receiving updates.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('date_i18n', [
				rt.new_string('F jS'),
				var_expiring_subscription.array_get(rt.new_string('expires')),
			]),
			rt.call_function('esc_url', [
				var_renew_link.clone(),
			]),
		])
	}
	if !(!rt.is_true(var_expiry_notice)) {
		rt.echo_val(rt.call_function('wp_kses', [var_expiry_notice.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: rt.new_array() },
					rt.ArrayItem{ key: 'class', val: rt.new_array() },
				]) },
			])]))
	}
}

fn Class_WC_Helper_Updater.display_notice_for_plugins_without_subscription(var_plugin_data rt.PhpVal, var_response rt.PhpVal) {
	mut var_response_mutated := var_response
	mut var_product_id := rt.call_function('preg_replace', [rt.new_string('/[^0-9]/'),
		rt.new_string(''), rt.get_property(var_response_mutated, 'id')])
	mut iife_temp_21 := Class_WC_Helper{}
	mut iife_result_21 := iife_temp_21.has_product_subscription(var_product_id.clone())
	if rt.is_true(iife_result_21) {
		return
	}
	mut var_purchase_link := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: var_product_id },
			rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{
				key: 'utm_campaign'
				val: 'pu_plugin_screen_purchase'
			}]),
		Class_Automattic_WooCommerce_Admin_PluginsHelper.woo_cart_page_url(),
	])
	mut var_notice := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string(' You don\'t have a subscription, <a href="%1$s" class="woocommerce-purchase-subscription">subscribe</a> to update.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_url', [
			var_purchase_link.clone(),
		]),
	])
	rt.echo_val(rt.call_function('wp_kses', [var_notice.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.new_array() },
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
			]) },
		])]))
}

fn Class_WC_Helper_Updater.get_available_extensions_downloads_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut iife_temp_22 := Class_WC_Helper{}
	mut iife_result_22 := iife_temp_22.get_subscriptions()
	mut var_subscriptions := iife_result_22
	mut iter_6 := var_subscriptions.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_subscription := item_6.val
		var_payload.array_set(var_subscription.array_get(rt.new_string('product_id')), rt.create_array([
			rt.ArrayItem{
				key: 'product_id'
				val: var_subscription.array_get(rt.new_string('product_id'))
			},
			rt.ArrayItem{ key: 'file_id', val: '' },
		]))
	}
	mut iife_temp_23 := Class_WC_Helper{}
	mut iife_result_23 := iife_temp_23.get_local_woo_plugins()
	mut iter_7 := iife_result_23.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_data := item_7.val
		if !(var_payload.array_isset(var_data.array_get(rt.new_string('_product_id')))) {
			var_payload.array_set(var_data.array_get(rt.new_string('_product_id')), rt.create_array([
				rt.ArrayItem{
					key: 'product_id'
					val: var_data.array_get(rt.new_string('_product_id'))
				},
			]))
		}
		var_payload.array_get_mut(var_data.array_get(rt.new_string('_product_id'))).array_set('file_id',
			var_data.array_get(rt.new_string('_file_id')))
	}
	return Class_WC_Helper_Updater._update_check(var_payload.clone())
}

fn Class_WC_Helper_Updater.get_update_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut iife_temp_24 := Class_WC_Helper{}
	mut iife_result_24 := iife_temp_24.get_subscriptions()
	mut var_subscriptions := iife_result_24
	mut iter_8 := var_subscriptions.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_subscription := item_8.val
		var_payload.array_set(var_subscription.array_get(rt.new_string('product_id')), rt.create_array([
			rt.ArrayItem{
				key: 'product_id'
				val: var_subscription.array_get(rt.new_string('product_id'))
			},
			rt.ArrayItem{ key: 'file_id', val: '' },
		]))
	}
	mut iife_temp_25 := Class_WC_Helper{}
	mut iife_result_25 := iife_temp_25.get_local_woo_plugins()
	mut iter_9 := iife_result_25.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_data := item_9.val
		if !(var_payload.array_isset(var_data.array_get(rt.new_string('_product_id')))) {
			var_payload.array_set(var_data.array_get(rt.new_string('_product_id')), rt.create_array([
				rt.ArrayItem{
					key: 'product_id'
					val: var_data.array_get(rt.new_string('_product_id'))
				},
			]))
		}
		var_payload.array_get_mut(var_data.array_get(rt.new_string('_product_id'))).array_set('file_id',
			var_data.array_get(rt.new_string('_file_id')))
	}
	mut iife_temp_26 := Class_WC_Helper{}
	mut iife_result_26 := iife_temp_26.get_local_woo_themes()
	mut iter_10 := iife_result_26.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_data := item_10.val
		if !(var_payload.array_isset(var_data.array_get(rt.new_string('_product_id')))) {
			var_payload.array_set(var_data.array_get(rt.new_string('_product_id')), rt.create_array([
				rt.ArrayItem{
					key: 'product_id'
					val: var_data.array_get(rt.new_string('_product_id'))
				},
			]))
		}
		var_payload.array_get_mut(var_data.array_get(rt.new_string('_product_id'))).array_set('file_id',
			var_data.array_get(rt.new_string('_file_id')))
	}
	return Class_WC_Helper_Updater._update_check(var_payload.clone())
}

fn Class_WC_Helper_Updater.get_translations_update_data() rt.PhpVal {
	mut var_payload := rt.new_array()
	mut var_installed_translations := rt.call_function('wp_get_installed_translations', [
		rt.new_string('plugins'),
	])
	mut var_locales := rt.call_function('array_values', [
		rt.call_function('get_available_languages', []rt.PhpVal{}),
	])
	var_locales = rt.call_function('apply_filters', [
		rt.new_string('plugins_update_check_locales'),
		var_locales.clone(),
	])
	var_locales = rt.call_function('array_unique', [var_locales.clone()])
	if !rt.is_true(var_locales) {
		return rt.new_array()
	}
	mut iife_temp_27 := Class_WC_Helper{}
	mut iife_result_27 := iife_temp_27.get_local_woo_plugins()
	mut var_plugins := iife_result_27
	mut var_active_woo_plugins := rt.call_function('array_intersect', [
		rt.func_array_keys(var_plugins.clone()),
		rt.call_function('get_option', [rt.new_string('active_plugins'),
			rt.new_array()]),
	])
	closure_29_fn := fn [var_plugins] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('apply_filters', [
			rt.new_string('woocommerce_translations_updates_for_' +
				(var_plugins.array_get(var_plugin).array_get(rt.new_string('slug'))).str()),
			rt.new_bool(false),
		])
	}
	mut var_active_for_translations := rt.call_function('array_filter', [
		var_active_woo_plugins.clone(), rt.new_closure(closure_29_fn)])
	if !rt.is_true(var_active_for_translations) {
		return rt.new_array()
	}
	if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) {
		mut var_timeout := rt.new_int(30)
	} else {
		var_timeout = rt.new_int(3 + var_active_for_translations.clone().array_count() / 10)
	}
	mut var_request_body := {
		'locales': var_locales
		'plugins': rt.new_array()
	}
	mut iter_11 := var_active_for_translations.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_active_plugin := item_11.val
		mut var_plugin := var_plugins.array_get(var_active_plugin)
		var_request_body.array_get_mut('plugins').array_set(var_plugin.array_get(rt.new_string('slug')), rt.create_array([
			rt.ArrayItem{ key: 'version', val: var_plugin.array_get(rt.new_string('Version')) },
		]))
	}
	mut var_raw_response := rt.call_function('wp_remote_post', [
		rt.new_string('https://translate.wordpress.com/api/translations-updates/woocommerce'),
		rt.create_array([
			rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_request_body),
			]) },
			rt.ArrayItem{ key: 'headers', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Content-Type: application/json' },
			]) },
			rt.ArrayItem{ key: 'timeout', val: var_timeout },
		]),
	])
	mut var_response_code := rt.call_function('wp_remote_retrieve_response_code', [
		var_raw_response.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))) {
		return rt.new_array()
	}
	mut var_response := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_raw_response.clone()]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('success'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_response.array_get(rt.new_string('success')))) {
		return rt.new_array()
	}
	mut var_translations := rt.new_array()
	mut iter_12 := var_response.array_get(rt.new_string('data')).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_language_packs := item_12.val
		mut var_plugin_name := item_12.key
		mut iter_13 := var_language_packs.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_language_pack := item_13.val
			if rt.is_true(rt.new_bool(var_installed_translations.clone().array_isset(var_plugin_name.clone())))
				&& rt.is_true(rt.new_bool(var_installed_translations.array_get(var_plugin_name).array_isset(var_language_pack.array_get(rt.new_string('wp_locale'))))) {
				mut var_installed_translation_revision_time :=
					create_datetime(var_installed_translations.array_get(var_plugin_name).array_get(var_language_pack.array_get(rt.new_string('wp_locale'))).array_get(rt.new_string('PO-Revision-Date')))
				mut var_new_translation_revision_time :=
					create_datetime(var_language_pack.array_get(rt.new_string('last_modified')))
				if rt.is_true(rt.less_equal(var_new_translation_revision_time,
					var_installed_translation_revision_time))
				{
					continue
				}
			}
			var_translations.array_push(rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'plugin' },
				rt.ArrayItem{ key: 'slug', val: var_plugin_name },
				rt.ArrayItem{
					key: 'language'
					val: var_language_pack.array_get(rt.new_string('wp_locale'))
				},
				rt.ArrayItem{
					key: 'version'
					val: var_language_pack.array_get(rt.new_string('version'))
				},
				rt.ArrayItem{
					key: 'updated'
					val: var_language_pack.array_get(rt.new_string('last_modified'))
				},
				rt.ArrayItem{
					key: 'package'
					val: var_language_pack.array_get(rt.new_string('package'))
				},
				rt.ArrayItem{ key: 'autoupdate', val: true },
			]))
		}
	}
	return var_translations.clone()
}

fn Class_WC_Helper_Updater.should_use_cached_update_data(var_data rt.PhpVal, var_hash rt.PhpVal) bool {
	mut var_data_mutated := var_data
	mut var_hash_mutated := var_hash
	if !(var_data_mutated.clone().is_array()) {
		return false
	}
	if !(var_data_mutated.array_isset(rt.new_string('hash'))
		&& var_data_mutated.array_isset(rt.new_string('products'))) {
		return false
	}
	if !(var_data_mutated.array_get(rt.new_string('hash')).is_string())
		|| !(var_data_mutated.array_get(rt.new_string('products')).is_array()) {
		return false
	}
	return (rt.call_function('hash_equals', [var_hash_mutated.clone(),
		var_data_mutated.array_get(rt.new_string('hash'))])).to_bool()
}

fn Class_WC_Helper_Updater._update_check(var_payload rt.PhpVal) rt.PhpVal {
	mut var_payload_mutated := var_payload
	if !rt.is_true(var_payload_mutated) {
		return rt.new_array()
	}
	rt.call_function('ksort', [var_payload_mutated.clone()])
	mut var_hash := rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [
		var_payload_mutated.clone(),
	]).to_string()))
	mut var_cache_key := rt.new_string('_woocommerce_helper_updates')
	mut var_data := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(Class_WC_Helper_Updater.should_use_cached_update_data(var_data.clone(),
		var_hash.clone()))
	{
		return var_data.array_get(rt.new_string('products'))
	}
	var_data = rt.create_array([rt.ArrayItem{ key: 'hash', val: var_hash },
		rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'products', val: rt.new_array() },
		rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	mut var_request_uri := rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
	} else {
		rt.new_string('')
	}])
	mut var_source := rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
		var_request_uri.clone(),
		rt.new_string('wc/v3/marketplace/refresh'),
	]), rt.new_bool(false)))))
	{
		var_source = rt.new_string('refresh-button')
	}
	mut var_request_body := {
		'products': var_payload_mutated
	}
	if !(!rt.is_true(var_source)) {
		var_request_body['source'] = var_source.clone()
	}
	mut iife_temp_29 := Class_WC_Helper{}
	mut iife_result_29 := iife_temp_29.is_site_connected()
	if rt.is_true(iife_result_29) {
		mut iife_temp_30 := Class_WC_Helper_API{}
		mut iife_result_30 := iife_temp_30.post(rt.new_string('update-check'), rt.create_array([
			rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_request_body),
			]) },
			rt.ArrayItem{ key: 'authenticated', val: true },
		]))
		mut var_request := iife_result_30
	} else {
		mut iife_temp_31 := Class_WC_Helper_API{}
		mut iife_result_31 := iife_temp_31.post(rt.new_string('update-check-public'), rt.create_array([
			rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_request_body),
			]) },
		]))
		var_request = iife_result_31
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [
		var_request.clone(),
	]), rt.new_int(200)))))
	{
		var_data.array_get_mut('errors').array_push('http-error')
	} else {
		var_data.array_set('products', rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_request.clone()]),
			rt.new_bool(true),
		]))
	}
	rt.call_function('set_transient', [var_cache_key.clone(),
		var_data.clone(), rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_data.array_get(rt.new_string('products'))
}

fn Class_WC_Helper_Updater.get_updates_count() i64 {
	mut var_cache_key := rt.new_string('_woocommerce_helper_updates_count')
	mut var_count := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_count)))) {
		return var_count.to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_transient', [
		rt.new_string('_woocommerce_helper_subscriptions'),
	])))))
	{
		return 0
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_transient', [
		rt.new_string('_woocommerce_helper_updates'),
	])))))
	{
		return 0
	}
	var_count = rt.new_int(0)
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	if !rt.is_true(var_update_data) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			var_count.clone(), rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))])
		return var_count.to_i64()
	}
	mut iife_temp_32 := Class_WC_Helper{}
	mut iife_result_32 := iife_temp_32.get_local_woo_plugins()
	mut iter_14 := iife_result_32.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_plugin := item_14.val
		if !rt.is_true(var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id')))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [
			var_plugin.array_get(rt.new_string('_filename')),
		])))))
		{
			continue
		}
		if rt.is_true(rt.call_function('version_compare', [
			var_plugin.array_get(rt.new_string('Version')),
			var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('version')),
			rt.new_string('<'),
		]))
		{
			rt.pre_inc(var_count)
		}
	}
	mut iife_temp_33 := Class_WC_Helper{}
	mut iife_result_33 := iife_temp_33.get_local_woo_themes()
	mut iter_15 := iife_result_33.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_theme := item_15.val
		if !rt.is_true(var_update_data.array_get(var_theme.array_get(rt.new_string('_product_id')))) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_stylesheet',
			[]rt.PhpVal{}), var_theme.array_get(rt.new_string('_stylesheet'))))))
		{
			continue
		}
		if rt.is_true(rt.call_function('version_compare', [
			var_theme.array_get(rt.new_string('Version')),
			var_update_data.array_get(var_theme.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('version')),
			rt.new_string('<'),
		]))
		{
			rt.pre_inc(var_count)
		}
	}
	rt.call_function('set_transient', [var_cache_key.clone(),
		var_count.clone(), rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_count.to_i64()
}

fn Class_WC_Helper_Updater.get_updates_count_based_on_site_status() i64 {
	mut iife_temp_34 := Class_WC_Helper{}
	mut iife_result_34 := iife_temp_34.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_34)))) {
		return 0
	}
	mut var_count := if !(Class_WC_Helper_Updater.get_updates_count()).is_null() {
		Class_WC_Helper_Updater.get_updates_count()
	} else {
		rt.new_int(0)
	}
	mut iife_temp_35 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_35 := iife_temp_35.is_plugin_installed()
	mut iife_temp_36 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_36 := iife_temp_36.is_plugin_active()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_35))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_36)))) {
		rt.pre_inc(var_count)
	}
	return var_count.to_i64()
}

fn Class_WC_Helper_Updater.get_woo_connect_notice_type() string {
	mut iife_temp_37 := Class_WC_Helper{}
	mut iife_result_37 := iife_temp_37.is_site_connected()
	if rt.is_true(iife_result_37) {
		return 'none'
	}
	mut iife_temp_38 := Class_WC_Helper{}
	mut iife_result_38 := iife_temp_38.get_local_woo_plugins()
	mut var_woo_plugins := iife_result_38
	if !rt.is_true(var_woo_plugins) {
		return 'none'
	}
	mut var_update_data := Class_WC_Helper_Updater.get_update_data()
	if !rt.is_true(var_update_data) {
		return 'short'
	}
	mut iter_16 := var_woo_plugins.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_plugin := item_16.val
		if !rt.is_true(var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id')))) {
			continue
		}
		if rt.is_true(rt.call_function('version_compare', [
			var_plugin.array_get(rt.new_string('Version')),
			var_update_data.array_get(var_plugin.array_get(rt.new_string('_product_id'))).array_get(rt.new_string('version')),
			rt.new_string('<'),
		]))
		{
			return 'long'
		}
	}
	return 'short'
}

fn Class_WC_Helper_Updater.get_updates_count_html() rt.PhpVal {
	mut var_count := Class_WC_Helper_Updater.get_updates_count_based_on_site_status()
	mut var_count_html := rt.call_function('sprintf', [
		rt.new_string(' <span class="update-plugins count-%d"><span class="update-count">%d</span></span>'),
		var_count.clone(),
		rt.call_function('number_format_i18n', [var_count.clone()]),
	])
	return var_count_html.clone()
}

fn Class_WC_Helper_Updater.flush_updates_cache() {
	rt.call_function('delete_transient', [rt.new_string('_woocommerce_helper_updates')])
	rt.call_function('delete_transient', [
		rt.new_string('_woocommerce_helper_updates_count'),
	])
	rt.call_function('delete_site_transient', [rt.new_string('update_plugins')])
	rt.call_function('delete_site_transient', [rt.new_string('update_themes')])
}

fn Class_WC_Helper_Updater.upgrader_process_complete() {
	rt.call_function('delete_transient', [
		rt.new_string('_woocommerce_helper_updates_count'),
	])
}

fn Class_WC_Helper_Updater.block_expired_updates(var_reply rt.PhpVal, var_package rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_reply)))) {
		return var_reply.to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
		var_package.clone(),
		rt.new_string('woocommerce-com-expired-'),
	])))))
	{
		return false
	}
	return (create_wp_error(rt.new_string('woocommerce_subscription_expired'), rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Please visit the <a href="%s" target="_blank">subscriptions page</a> and renew to continue receiving updates.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-admin&tab=my-subscriptions&path=%2Fextensions'),
			]),
		]),
	]))).to_bool()
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_helper_updater(_args ...rt.PhpVal) &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
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

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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
			Class_WC_Helper_Updater.add_install_marketplace_plugin_message(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'display_notice_for_expired_and_expiring_subscriptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper_Updater.display_notice_for_expired_and_expiring_subscriptions(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'display_notice_for_plugins_without_subscription' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Helper_Updater.display_notice_for_plugins_without_subscription(dispatch_arg_0,
				dispatch_arg_1)
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
			return rt.new_bool(Class_WC_Helper_Updater.should_use_cached_update_data(dispatch_arg_0,
				dispatch_arg_1))
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
			return rt.new_bool(Class_WC_Helper_Updater.block_expired_updates(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
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

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	Class_WC_Helper_Updater.load()
}
