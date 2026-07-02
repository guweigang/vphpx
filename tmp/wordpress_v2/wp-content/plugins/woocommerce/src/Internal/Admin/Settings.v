import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_settings() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Settings', 'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Settings',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Settings', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Settings', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) construct() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_components_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_component_settings' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_component_settings' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings_groups'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_settings_group' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings-wc_admin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_settings' },
		])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(var_statuses rt.PhpVal) rt.PhpVal {
	mut var_formatted_statuses := rt.new_array()
	mut iter_1 := var_statuses.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut var_formatted_key := rt.call_function('preg_replace', [
			rt.new_string('/^wc-/'),
			rt.new_string(''),
			var_key.clone(),
		])
		var_formatted_statuses.array_set(var_formatted_key, var_value.clone())
	}
	return var_formatted_statuses.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_unregistered_order_statuses() rt.PhpVal {
	mut var_registered_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_0 := iife_temp_0.get_all_statuses()
	mut var_all_synced_statuses := iife_result_0
	mut var_unregistered_statuses := rt.call_function('array_diff', [
		var_all_synced_statuses.clone(), rt.func_array_keys(var_registered_statuses.clone())])
	mut var_formatted_status_keys := Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('array_fill_keys', [
		var_unregistered_statuses.clone(),
		rt.new_string(''),
	]))
	mut var_formatted_statuses := rt.func_array_keys(var_formatted_status_keys.clone())
	return rt.call_function('array_combine', [var_formatted_statuses.clone(),
		var_formatted_statuses.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_currency_settings() rt.PhpVal {
	mut var_code := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	return rt.call_function('apply_filters', [rt.new_string('wc_currency_settings'),
		rt.create_array([rt.ArrayItem{ key: 'code', val: var_code },
			rt.ArrayItem{ key: 'precision', val: rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'symbol', val: rt.call_function('html_entity_decode', [
				rt.call_function('get_woocommerce_currency_symbol', [
					var_code.clone()]),
			]) }, rt.ArrayItem{ key: 'symbolPosition', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_currency_pos'),
			]) }, rt.ArrayItem{ key: 'decimalSeparator', val: rt.call_function('wc_get_price_decimal_separator',
				[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'thousandSeparator', val: rt.call_function('wc_get_price_thousand_separator',
				[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'priceFormat', val: rt.call_function('html_entity_decode', [
				rt.call_function('get_woocommerce_price_format', []rt.PhpVal{}),
			]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_blocks_container'),
	])))))
	{
		var_settings_mutated.array_set('orderStatuses', Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_order_statuses',
			[]rt.PhpVal{})))
		var_settings_mutated.array_set('stockStatuses', Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_product_stock_status_options',
			[]rt.PhpVal{})))
		var_settings_mutated.array_set('currency',
			Class_Automattic_WooCommerce_Internal_Admin_Settings.get_currency_settings())
		var_settings_mutated.array_set('locale', rt.create_array([
			rt.ArrayItem{
				key: 'siteLocale'
				val: if var_settings_mutated.array_isset(rt.new_string('siteLocale')) {
					var_settings_mutated.array_get(rt.new_string('siteLocale'))
				} else {
					rt.call_function('get_locale', []rt.PhpVal{})
				}
			},
			rt.ArrayItem{
				key: 'userLocale'
				val: if var_settings_mutated.array_get(rt.new_string('l10n')).array_isset(rt.new_string('userLocale')) {
					var_settings_mutated.array_get(rt.new_string('l10n')).array_get(rt.new_string('userLocale'))
				} else {
					rt.call_function('get_user_locale', []rt.PhpVal{})
				}
			},
			rt.ArrayItem{
				key: 'weekdaysShort'
				val: if var_settings_mutated.array_get(rt.new_string('l10n')).array_isset(rt.new_string('weekdaysShort')) { var_settings_mutated.array_get(rt.new_string('l10n')).array_get(rt.new_string('weekdaysShort')) } else { rt.call_function('array_values', [
						rt.get_property(var_wp_locale, 'weekday_abbrev'),
					]) }
			},
		]))
	}
	mut var_preload_data_endpoints := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_component_settings_preload_endpoints'),
		rt.new_array(),
	])
	var_preload_data_endpoints.array_set('jetpackStatus', '/jetpack/v4/connection')
	if !(!rt.is_true(var_preload_data_endpoints)) {
		mut var_preload_data := rt.call_function('array_reduce', [
			rt.call_function('array_values', [var_preload_data_endpoints.clone()]),
			rt.new_string('rest_preload_api_request'),
		])
	}
	mut var_preload_options := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_preload_options'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_preload_options)) {
		rt.call_function('wp_prime_option_caches', [var_preload_options.clone()])
		mut iter_2 := var_preload_options.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_option := item_2.val
			var_settings_mutated.array_get_mut('preloadOptions').array_set(var_option, rt.call_function('get_option', [
				var_option.clone(),
			]))
		}
	}
	mut var_preload_settings := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_preload_settings'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_preload_settings)) {
		mut var_setting_options :=
			create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller()
		mut iter_3 := var_preload_settings.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_group := item_3.val
			mut var_group_settings := var_setting_options.get_group_settings(var_group.clone())
			var_preload_settings = rt.new_array()
			mut iter_4 := var_group_settings.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_option := item_4.val
				if rt.is_true(rt.new_bool(var_option.clone().array_isset(rt.new_string('id'))))
					&& rt.is_true(rt.new_bool(var_option.clone().array_isset(rt.new_string('value')))) {
					var_preload_settings.array_set(var_option.array_get(rt.new_string('id')),
						var_option.array_get(rt.new_string('value')))
				}
			}
			var_settings_mutated.array_get_mut('preloadSettings').array_set(var_group,
				var_preload_settings.clone())
		}
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
	mut iife_result_1 := iife_temp_1.get_user_data()
	var_settings_mutated.array_set('currentUserData', iife_result_1)
	var_settings_mutated.array_set('reviewsEnabled', rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_reviews'),
	]))
	var_settings_mutated.array_set('manageStock', rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	]))
	var_settings_mutated.array_set('commentModeration', rt.call_function('get_option', [
		rt.new_string('comment_moderation'),
	]))
	var_settings_mutated.array_set('notifyLowStockAmount', rt.call_function('get_option', [
		rt.new_string('woocommerce_notify_low_stock_amount'),
	]))
	var_settings_mutated.array_set('wcAdminAssetUrl', rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL'))
	var_settings_mutated.array_set('wcVersion', rt.get_constant('WC_VERSION'))
	var_settings_mutated.array_set('siteUrl', rt.call_function('site_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('shopUrl', rt.call_function('get_permalink', [
		rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
	]))
	var_settings_mutated.array_set('homeUrl', rt.call_function('home_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('dateFormat', rt.call_function('get_option', [
		rt.new_string('date_format'),
	]))
	var_settings_mutated.array_set('timeZone',
		rt.call_function('wc_timezone_string', []rt.PhpVal{}))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_2 := iife_temp_2.get_installed_plugin_slugs()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Plugins{}
	mut iife_result_3 := iife_temp_3.get_active_plugins()
	var_settings_mutated.array_set('plugins', rt.create_array([
		rt.ArrayItem{ key: 'installedPlugins', val: iife_result_2 },
		rt.ArrayItem{ key: 'activePlugins', val: iife_result_3 },
	]))
	var_settings_mutated.array_set('__experimentalFlags', rt.new_array())
	var_settings_mutated.array_set('woocommerceTranslation', rt.call_function('__', [
		rt.new_string('WooCommerce'),
		rt.new_string('woocommerce'),
	]))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_4 := iife_temp_4.is_admin_page()
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_5 := iife_temp_5.is_enabled(rt.new_string('analytics'))
	if rt.is_true(iife_result_4) && rt.is_true(iife_result_5) {
		var_settings_mutated.array_set('unregisteredOrderStatuses',
			this.get_unregistered_order_statuses())
		mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_6 := iife_temp_6.uses_new_full_refund_data()
		var_settings_mutated.array_set('usesNewFullRefundData', iife_result_6)
	}
	var_settings_mutated.array_set('variationTitleAttributesSeparator', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_variation_title_attributes_separator'),
		rt.new_string(' - '),
		create_automattic_woocommerce_internal_admin_wc_product(),
	]))
	if !(!rt.is_true(var_preload_data_endpoints)) {
		var_settings_mutated.array_set('dataEndpoints', if var_settings_mutated.array_isset(rt.new_string('dataEndpoints')) {
			var_settings_mutated.array_get(rt.new_string('dataEndpoints'))
		} else {
			rt.new_array()
		})
		mut iter_5 := var_preload_data_endpoints.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_endpoint := item_5.val
			mut var_key := item_5.key
			if !rt.is_true(var_preload_data.array_get(var_endpoint)) {
				var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key,
					rt.new_array())
			} else {
				var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key,
					var_preload_data.array_get(var_endpoint).array_get(rt.new_string('body')))
			}
		}
	}
	var_settings_mutated = this.get_custom_settings(var_settings_mutated.clone())
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_7 := iife_temp_7.is_embed_page()
	if rt.is_true(iife_result_7) {
		var_settings_mutated.array_set('embedBreadcrumbs', rt.call_function('wc_admin_get_breadcrumbs',
			[]rt.PhpVal{}))
	}
	mut iife_temp_8 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_8 := iife_temp_8.allow_suggestions()
	var_settings_mutated.array_set('allowMarketplaceSuggestions', iife_result_8)
	var_settings_mutated.array_set('connectNonce', rt.call_function('wp_create_nonce', [
		rt.new_string('connect'),
	]))
	var_settings_mutated.array_set('wcpay_welcome_page_connect_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('wcpay-connect'),
	]))
	var_settings_mutated.array_set('email_preview_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('email-preview-nonce'),
	]))
	var_settings_mutated.array_set('email_listing_nonce', rt.call_function('wp_create_nonce', [
		rt.new_string('email-listing-nonce'),
	]))
	var_settings_mutated.array_set('wc_helper_nonces', rt.create_array([
		rt.ArrayItem{ key: 'refresh', val: rt.call_function('wp_create_nonce', [
			rt.new_string('refresh'),
		]) },
	]))
	var_settings_mutated.array_set('features', this.get_features())
	mut var_has_gutenberg := rt.call_function('is_plugin_active', [
		rt.new_string('gutenberg/gutenberg.php'),
	])
	mut var_gutenberg_version := rt.new_string('')
	if rt.is_true(var_has_gutenberg) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')])) {
			var_gutenberg_version = rt.get_constant('GUTENBERG_VERSION')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_version)))) {
			mut var_gutenberg_data := rt.call_function('get_plugin_data', [
				rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/gutenberg/gutenberg.php'),
			])
			var_gutenberg_version = var_gutenberg_data.array_get(rt.new_string('Version'))
		}
	}
	var_settings_mutated.array_set('gutenberg_version', if rt.is_true(var_has_gutenberg) {
		var_gutenberg_version
	} else {
		rt.new_int(0)
	})
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_features() rt.PhpVal {
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_9 := iife_temp_9.get_features(rt.new_bool(true), rt.new_bool(true))
	mut var_features := iife_result_9
	mut var_new_features := rt.new_array()
	mut iter_6 := rt.func_array_keys(var_features.clone()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_feature_id := item_6.val
		var_new_features.array_set(var_feature_id, rt.create_array([
			rt.ArrayItem{
				key: 'is_enabled'
				val: var_features.array_get(var_feature_id).array_get(rt.new_string('is_enabled'))
			},
			rt.ArrayItem{
				key: 'is_experimental'
				val: if !(var_features.array_get(var_feature_id).array_get(rt.new_string('is_experimental'))).is_null() {
					var_features.array_get(var_feature_id).array_get(rt.new_string('is_experimental'))
				} else {
					rt.new_bool(false)
				}
			},
		]))
	}
	return var_new_features.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_settings_group(var_groups rt.PhpVal) rt.PhpVal {
	mut var_groups_mutated := var_groups
	var_groups_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'wc_admin' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('WooCommerce Admin'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Settings for WooCommerce admin reporting.'),
			rt.new_string('woocommerce'),
		]) },
	]))
	return var_groups_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_unregistered_statuses := this.get_unregistered_order_statuses()
	mut var_registered_statuses := Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_order_statuses',
		[]rt.PhpVal{}))
	mut var_all_statuses := rt.call_function('array_merge', [
		var_unregistered_statuses.clone(), var_registered_statuses.clone()])
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce_excluded_report_order_statuses' },
		rt.ArrayItem{ key: 'option_key', val: 'woocommerce_excluded_report_order_statuses' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Excluded report order statuses'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Statuses that should not be included when calculating report totals.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'default', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'pending' },
			rt.ArrayItem{ key: none, val: 'cancelled' },
			rt.ArrayItem{ key: none, val: 'failed' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'multiselect' },
		rt.ArrayItem{ key: 'options', val: var_all_statuses },
	]))
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce_actionable_order_statuses' },
		rt.ArrayItem{ key: 'option_key', val: 'woocommerce_actionable_order_statuses' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Actionable order statuses'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Statuses that require extra action on behalf of the store admin.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'default', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'processing' },
			rt.ArrayItem{ key: none, val: 'on-hold' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'multiselect' },
		rt.ArrayItem{ key: 'options', val: var_all_statuses },
	]))
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce_default_date_range' },
		rt.ArrayItem{ key: 'option_key', val: 'woocommerce_default_date_range' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Default Date Range'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Default Date Range'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'default', val: 'period=month&compare=previous_year' },
		rt.ArrayItem{ key: 'type', val: 'text' },
	]))
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce_date_type' },
		rt.ArrayItem{ key: 'option_key', val: 'woocommerce_date_type' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Date Type'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Database date field considered for Revenue and Orders reports'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'select' },
		rt.ArrayItem{ key: 'options', val: rt.create_array([
			rt.ArrayItem{ key: 'date_created', val: 'date_created' },
			rt.ArrayItem{ key: 'date_paid', val: 'date_paid' },
			rt.ArrayItem{ key: 'date_completed', val: 'date_completed' },
		]) },
	]))
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_10 := iife_temp_10.is_enabled(rt.new_string('analytics-scheduled-import'))
	if rt.is_true(iife_result_10) {
		var_settings_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_analytics_scheduled_import' },
			rt.ArrayItem{ key: 'option_key', val: 'woocommerce_analytics_scheduled_import' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Updates'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Controls how analytics data is imported from orders.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'radio' },
			rt.ArrayItem{ key: 'default', val: rt.new_null() },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'yes', val: rt.call_function('__', [
					rt.new_string('Scheduled (recommended)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'no', val: rt.call_function('__', [
					rt.new_string('Immediately'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]))
		mut iife_temp_11 :=
			Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
		mut iife_result_11 := iife_temp_11.get_import_interval()
		mut var_import_interval := iife_result_11
		var_import_interval = rt.call_function('absint', [var_import_interval.clone()])
		mut var_import_interval_string := rt.call_function('human_time_diff', [
			rt.new_int(0),
			var_import_interval.clone(),
		])
		var_settings_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_analytics_import_interval' },
			rt.ArrayItem{ key: 'option_key', val: 'woocommerce_analytics_import_interval' },
			rt.ArrayItem{ key: 'type', val: 'hidden' },
			rt.ArrayItem{ key: 'default', val: var_import_interval_string },
		]))
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_custom_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_wc_rest_settings_options_controller :=
		create_automattic_woocommerce_internal_admin_wc_rest_setting_options_controller()
	mut var_wc_admin_group_settings :=
		var_wc_rest_settings_options_controller.get_group_settings(rt.new_string('wc_admin'))
	var_settings_mutated.array_set('wcAdminSettings', rt.new_array())
	mut iter_7 := var_wc_admin_group_settings.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_setting := item_7.val
		if !(!rt.is_true(var_setting.array_get(rt.new_string('id')))) {
			var_settings_mutated.array_get_mut('wcAdminSettings').array_set(var_setting.array_get(rt.new_string('id')),
				var_setting.array_get(rt.new_string('value')))
		}
	}
	return var_settings_mutated.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Plugins {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings() &Class_Automattic_WooCommerce_Internal_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
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

fn create_automattic_woocommerce_admin_api_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
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

fn create_automattic_woocommerce_internal_admin_wc_product(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_automattic_woocommerce_internal_admin_schedulers_ordersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Settings.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_order_statuses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(dispatch_arg_0)
		}
		'get_unregistered_order_statuses' {
			return this.get_unregistered_order_statuses()
		}
		'get_currency_settings' {
			return Class_Automattic_WooCommerce_Internal_Admin_Settings.get_currency_settings()
		}
		'add_component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_component_settings(dispatch_arg_0)
		}
		'get_features' {
			return this.get_features()
		}
		'add_settings_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings_group(dispatch_arg_0)
		}
		'add_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_settings(dispatch_arg_0)
		}
		'get_custom_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_settings(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
