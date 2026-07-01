import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) construct()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_components_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_component_settings' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_component_settings' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings_groups'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_settings_group' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_settings-wc_admin'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_settings' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(var_statuses rt.PhpVal) rt.PhpVal {
	mut var_formatted_statuses := rt.new_array()
	{
		mut iter_1 := var_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_formatted_key := rt.call_function('preg_replace', [rt.new_string('/^wc-/'), rt.new_string(''), var_key.dup()])
			var_formatted_statuses.array_set(var_formatted_key, var_value.dup())
		}
	}
	return var_formatted_statuses.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_unregistered_order_statuses() rt.PhpVal {
	mut var_registered_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_all_synced_statuses := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}; return temp.get_all_statuses() }()
	mut var_unregistered_statuses := rt.call_function('array_diff', [var_all_synced_statuses.dup(), rt.func_array_keys(var_registered_statuses.dup())])
	mut var_formatted_status_keys := Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('array_fill_keys', [var_unregistered_statuses.dup(), rt.new_string('')]))
	mut var_formatted_statuses := rt.func_array_keys(var_formatted_status_keys.dup())
	return rt.call_function('array_combine', [var_formatted_statuses.dup(), var_formatted_statuses.dup()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings.get_currency_settings() rt.PhpVal {
	mut var_code := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	return rt.call_function('apply_filters', [rt.new_string('wc_currency_settings'), rt.create_array([rt.ArrayItem{ key: 'code', val: var_code }, rt.ArrayItem{ key: 'precision', val: rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'symbol', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_currency_symbol', [var_code.dup()])]) }, rt.ArrayItem{ key: 'symbolPosition', val: rt.call_function('get_option', [rt.new_string('woocommerce_currency_pos')]) }, rt.ArrayItem{ key: 'decimalSeparator', val: rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'thousandSeparator', val: rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'priceFormat', val: rt.call_function('html_entity_decode', [rt.call_function('get_woocommerce_price_format', []rt.PhpVal{})]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_component_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_blocks_container')]))))) {
		// unsupported statement: Stmt_Global
		var_settings_mutated.array_set('orderStatuses', Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})))
		var_settings_mutated.array_set('stockStatuses', Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})))
		var_settings_mutated.array_set('currency', Class_Automattic_WooCommerce_Internal_Admin_Settings.get_currency_settings())
		var_settings_mutated.array_set('locale', rt.create_array([rt.ArrayItem{ key: 'siteLocale', val: if var_settings_mutated.array_isset(rt.new_string('siteLocale')) { var_settings_mutated.array_get('siteLocale') } else { rt.call_function('get_locale', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'userLocale', val: if var_settings_mutated.array_get('l10n').array_isset(rt.new_string('userLocale')) { var_settings_mutated.array_get('l10n').array_get('userLocale') } else { rt.call_function('get_user_locale', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'weekdaysShort', val: if var_settings_mutated.array_get('l10n').array_isset(rt.new_string('weekdaysShort')) { var_settings_mutated.array_get('l10n').array_get('weekdaysShort') } else { rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) } }]))
	}
	mut var_preload_data_endpoints := rt.call_function('apply_filters', [rt.new_string('woocommerce_component_settings_preload_endpoints'), rt.new_array()])
	var_preload_data_endpoints.array_set('jetpackStatus', '/jetpack/v4/connection')
	if !(!rt.is_true(var_preload_data_endpoints)) {
		mut var_preload_data := rt.call_function('array_reduce', [rt.call_function('array_values', [var_preload_data_endpoints.dup()]), rt.new_string('rest_preload_api_request')])
	}
	mut var_preload_options := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_preload_options'), rt.new_array()])
	if !(!rt.is_true(var_preload_options)) {
		rt.call_function('wp_prime_option_caches', [var_preload_options.dup()])
		{
			mut iter_1 := var_preload_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_option := item_1.val
				var_settings_mutated.array_get_mut('preloadOptions').array_set(var_option, rt.call_function('get_option', [var_option.dup()]))
			}
		}
	}
	mut var_preload_settings := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_preload_settings'), rt.new_array()])
	if !(!rt.is_true(var_preload_settings)) {
		mut var_setting_options := create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller()
		{
			mut iter_1 := var_preload_settings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_group := item_1.val
				mut var_group_settings := var_setting_options.get_group_settings(var_group.dup())
				var_preload_settings = rt.new_array()
				{
					mut iter_2 := var_group_settings.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_option := item_2.val
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_option.dup().array_isset(rt.new_string('id')))) && rt.is_true(rt.new_bool(var_option.dup().array_isset(rt.new_string('value')))))) {
							var_preload_settings.array_set(var_option.array_get('id'), var_option.array_get('value'))
						}
					}
				}
				var_settings_mutated.array_get_mut('preloadSettings').array_set(var_group, var_preload_settings.dup())
			}
		}
	}
	var_settings_mutated.array_set('currentUserData', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}; return temp.get_user_data() }())
	var_settings_mutated.array_set('reviewsEnabled', rt.call_function('get_option', [rt.new_string('woocommerce_enable_reviews')]))
	var_settings_mutated.array_set('manageStock', rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))
	var_settings_mutated.array_set('commentModeration', rt.call_function('get_option', [rt.new_string('comment_moderation')]))
	var_settings_mutated.array_set('notifyLowStockAmount', rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]))
	var_settings_mutated.array_set('wcAdminAssetUrl', rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL'))
	var_settings_mutated.array_set('wcVersion', rt.get_constant('WC_VERSION'))
	var_settings_mutated.array_set('siteUrl', rt.call_function('site_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('shopUrl', rt.call_function('get_permalink', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]))
	var_settings_mutated.array_set('homeUrl', rt.call_function('home_url', []rt.PhpVal{}))
	var_settings_mutated.array_set('dateFormat', rt.call_function('get_option', [rt.new_string('date_format')]))
	var_settings_mutated.array_set('timeZone', rt.call_function('wc_timezone_string', []rt.PhpVal{}))
	var_settings_mutated.array_set('plugins', rt.create_array([rt.ArrayItem{ key: 'installedPlugins', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installed_plugin_slugs() }() }, rt.ArrayItem{ key: 'activePlugins', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Plugins{}; return temp.get_active_plugins() }() }]))
	var_settings_mutated.array_set('__experimentalFlags', rt.new_array())
	var_settings_mutated.array_set('woocommerceTranslation', rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]))
	if rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }()) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics'))))) {
		var_settings_mutated.array_set('unregisteredOrderStatuses', this.get_unregistered_order_statuses())
		var_settings_mutated.array_set('usesNewFullRefundData', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.uses_new_full_refund_data() }())
	}
	var_settings_mutated.array_set('variationTitleAttributesSeparator', rt.call_function('apply_filters', [rt.new_string('woocommerce_product_variation_title_attributes_separator'), rt.new_string(' - '), create_automattic_woocommerce_internal_admin_wc_product()]))
	if !(!rt.is_true(var_preload_data_endpoints)) {
		var_settings_mutated.array_set('dataEndpoints', if var_settings_mutated.array_isset(rt.new_string('dataEndpoints')) { var_settings_mutated.array_get('dataEndpoints') } else { rt.new_array() })
		{
			mut iter_1 := var_preload_data_endpoints.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_endpoint := item_1.val
				mut var_key := item_1.key
				if !rt.is_true(var_preload_data.array_get(var_endpoint)) {
					var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key, rt.new_array())
				} else {
					var_settings_mutated.array_get_mut('dataEndpoints').array_set(var_key, var_preload_data.array_get(var_endpoint).array_get('body'))
				}
			}
		}
	}
	var_settings_mutated = this.get_custom_settings(var_settings_mutated.dup())
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_embed_page() }()) {
		var_settings_mutated.array_set('embedBreadcrumbs', rt.call_function('wc_admin_get_breadcrumbs', []rt.PhpVal{}))
	}
	var_settings_mutated.array_set('allowMarketplaceSuggestions', fn () rt.PhpVal { mut temp := Class_WC_Marketplace_Suggestions{}; return temp.allow_suggestions() }())
	var_settings_mutated.array_set('connectNonce', rt.call_function('wp_create_nonce', [rt.new_string('connect')]))
	var_settings_mutated.array_set('wcpay_welcome_page_connect_nonce', rt.call_function('wp_create_nonce', [rt.new_string('wcpay-connect')]))
	var_settings_mutated.array_set('email_preview_nonce', rt.call_function('wp_create_nonce', [rt.new_string('email-preview-nonce')]))
	var_settings_mutated.array_set('email_listing_nonce', rt.call_function('wp_create_nonce', [rt.new_string('email-listing-nonce')]))
	var_settings_mutated.array_set('wc_helper_nonces', rt.create_array([rt.ArrayItem{ key: 'refresh', val: rt.call_function('wp_create_nonce', [rt.new_string('refresh')]) }]))
	var_settings_mutated.array_set('features', this.get_features())
	mut var_has_gutenberg := rt.call_function('is_plugin_active', [rt.new_string('gutenberg/gutenberg.php')])
	mut var_gutenberg_version := rt.new_string(rt.new_string(''))
	if rt.is_true(var_has_gutenberg) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')])) {
			var_gutenberg_version = rt.get_constant('GUTENBERG_VERSION')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_version)))) {
			mut var_gutenberg_data := rt.call_function('get_plugin_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/gutenberg/gutenberg.php'])
			var_gutenberg_version = var_gutenberg_data.array_get('Version')
		}
	}
	var_settings_mutated.array_set('gutenberg_version', if rt.is_true(var_has_gutenberg) { var_gutenberg_version } else { rt.new_int(0) })
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_features() rt.PhpVal {
	mut var_features := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.get_features(arg_0, arg_1) }(rt.new_bool(true), rt.new_bool(true))
	mut var_new_features := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_features.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature_id := item_1.val
			var_new_features.array_set(var_feature_id, rt.create_array([rt.ArrayItem{ key: 'is_enabled', val: var_features.array_get(var_feature_id).array_get('is_enabled') }, rt.ArrayItem{ key: 'is_experimental', val: if !(var_features.array_get(var_feature_id).array_get('is_experimental')).is_null() { var_features.array_get(var_feature_id).array_get('is_experimental') } else { rt.new_bool(false) } }]))
		}
	}
	return var_new_features.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_settings_group(var_groups rt.PhpVal) rt.PhpVal {
	mut var_groups_mutated := var_groups
	var_groups_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'wc_admin' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('WooCommerce Admin'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Settings for WooCommerce admin reporting.'), rt.new_string('woocommerce')]) }]))
	return var_groups_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) add_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_unregistered_statuses := this.get_unregistered_order_statuses()
	mut var_registered_statuses := Class_Automattic_WooCommerce_Internal_Admin_Settings.get_order_statuses(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))
	mut var_all_statuses := rt.call_function('array_merge', [.dup(), .dup()])
	.array_push()
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) get_custom_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
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

fn create_automattic_woocommerce_internal_admin_settings() &Class_Automattic_WooCommerce_Internal_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_rest_setting_options_v2_controller() &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_REST_Setting_Options_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_plugins() &Class_Automattic_WooCommerce_Admin_API_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wc_product() &Class_Automattic_WooCommerce_Internal_Admin_WC_Product {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_marketplace_suggestions() &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_php() {
}
