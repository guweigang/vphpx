import rt

pub fn Class_WC_Helper_Admin.cache_tool_id() string {
	return 'clear_woocommerce_helper_cache'
}

struct Class_WC_Helper_Admin {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Admin.load() {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		mut var_is_wc_home_or_in_app_marketplace := rt.new_bool(
			rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
			&& rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page')))))
		if rt.is_true(var_is_wc_home_or_in_app_marketplace) {
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_admin_shared_settings'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'add_marketplace_settings' }]),
			])
		}
		rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'register_cache_clear_tool' }])])
	}
	rt.call_function('add_filter', [rt.new_string('rest_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_rest_routes' }])])
}

fn Class_WC_Helper_Admin.add_marketplace_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('connect')) {
		rt.call_function('wp_safe_redirect', [
			Class_WC_Helper_Admin.get_connection_url(),
		])
		exit(0)
	}
	mut iife_temp_1 := Class_WC_Helper_Options{}
	mut iife_result_1 := iife_temp_1.get(rt.new_string('auth_user_data'), rt.new_array())
	mut var_auth_user_data := iife_result_1
	mut var_auth_user_email := if var_auth_user_data.array_isset(rt.new_string('email')) {
		var_auth_user_data.array_get(rt.new_string('email'))
	} else {
		rt.new_string('')
	}
	mut iife_temp_2 := Class_WC_Helper{}
	mut iife_result_2 := iife_temp_2.get_local_plugins()
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_local_themes()
	mut iife_temp_4 := Class_WC_Helper{}
	mut iife_result_4 := iife_temp_4.get_local_plugins()
	mut var_installed_products := rt.call_function('array_merge', [iife_result_2, iife_result_3])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product.array_get(rt.new_string('slug'))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product.array_get(rt.new_string('slug'))
	}
	var_installed_products = rt.call_function('array_map', [rt.new_closure(closure_6_fn),
		var_installed_products.clone()])
	mut var_blog_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	mut iife_temp_7 := Class_WC_Helper{}
	mut iife_result_7 := iife_temp_7.is_site_connected()
	mut iife_temp_8 := Class_WC_Admin_Addons{}
	mut iife_result_8 := iife_temp_8.get_in_app_purchase_url_params()
	mut iife_temp_9 := Class_WC_Helper_Options{}
	mut iife_result_9 := iife_temp_9.get(rt.new_string('my_subscriptions_tab_loaded'))
	mut iife_temp_10 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_10 := iife_temp_10.is_plugin_installed()
	mut iife_temp_11 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_11 := iife_temp_11.is_plugin_active()
	mut iife_temp_12 := Class_WC_Woo_Update_Manager_Plugin{}
	mut iife_result_12 := iife_temp_12.generate_install_url()
	var_settings_mutated.array_set('wccomHelper', rt.create_array([
		rt.ArrayItem{ key: 'isConnected', val: iife_result_7 },
		rt.ArrayItem{ key: 'connectURL', val: Class_WC_Helper_Admin.get_connection_url() },
		rt.ArrayItem{ key: 'reConnectURL', val: Class_WC_Helper_Admin.get_connection_url(true) },
		rt.ArrayItem{ key: 'userEmail', val: var_auth_user_email },
		rt.ArrayItem{ key: 'userAvatar', val: rt.call_function('get_avatar_url', [
			var_auth_user_email.clone(),
			rt.create_array([rt.ArrayItem{ key: 'size', val: '48' }]),
		]) },
		rt.ArrayItem{ key: 'storeCountry', val: rt.call_function('wc_get_base_location',
			[]rt.PhpVal{}).array_get(rt.new_string('country')) },
		rt.ArrayItem{
			key: 'storeName'
			val: if rt.is_true(var_blog_name) { var_blog_name } else { rt.new_string('') }
		},
		rt.ArrayItem{ key: 'inAppPurchaseURLParams', val: iife_result_8 },
		rt.ArrayItem{ key: 'installedProducts', val: var_installed_products },
		rt.ArrayItem{ key: 'mySubscriptionsTabLoaded', val: iife_result_9 },
		rt.ArrayItem{ key: 'wooUpdateManagerInstalled', val: iife_result_10 },
		rt.ArrayItem{ key: 'wooUpdateManagerActive', val: iife_result_11 },
		rt.ArrayItem{ key: 'wooUpdateManagerInstallUrl', val: iife_result_12 },
		rt.ArrayItem{
			key: 'wooUpdateManagerPluginSlug'
			val: Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_slug()
		},
		rt.ArrayItem{ key: 'dismissNoticeNonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('dismiss_notice'),
		]) },
		rt.ArrayItem{ key: 'trackingAllowed', val: rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_allow_tracking'),
		])) },
	]))
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('path'))))
		&& rt.is_true(rt.identical(rt.new_string('/extensions'), rt.get_superglobal('_GET').array_get(rt.new_string('path')))) {
		mut iife_temp_13 := Class_WC_Helper_Updater{}
		mut iife_result_13 := iife_temp_13.get_updates_count_based_on_site_status()
		var_settings_mutated.array_get_mut('wccomHelper').array_set('wooUpdateCount',
			iife_result_13)
		mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
		mut iife_result_14 := iife_temp_14.get_wccom_connected_notice(var_auth_user_email.clone())
		var_settings_mutated.array_get_mut('wccomHelper').array_set('connected_notice',
			iife_result_14)
		mut iife_temp_15 := Class_WC_Helper_Updater{}
		mut iife_result_15 := iife_temp_15.get_woo_connect_notice_type()
		var_settings_mutated.array_get_mut('wccomHelper').array_set('woocomConnectNoticeType',
			iife_result_15)
		mut iife_temp_16 := Class_WC_Helper{}
		mut iife_result_16 := iife_temp_16.is_site_connected()
		if rt.is_true(iife_result_16) {
			mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_17 := iife_temp_17.get_expired_subscription_notice(rt.new_bool(false))
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_expired_notice',
				iife_result_17)
			mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_18 := iife_temp_18.get_expiring_subscription_notice(rt.new_bool(false))
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_expiring_notice',
				iife_result_18)
			mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_19 := iife_temp_19.get_missing_subscription_notice()
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_missing_notice',
				iife_result_19)
			mut iife_temp_20 := Class_WC_Woo_Helper_Connection{}
			mut iife_result_20 := iife_temp_20.get_connection_url_notice()
			var_settings_mutated.array_get_mut('wccomHelper').array_set('connection_url_notice',
				iife_result_20)
			mut iife_temp_21 := Class_WC_Woo_Helper_Connection{}
			mut iife_result_21 := iife_temp_21.has_host_plan_orders()
			var_settings_mutated.array_get_mut('wccomHelper').array_set('has_host_plan_orders',
				iife_result_21)
			mut iife_temp_22 := Class_WC_Woo_Helper_Connection{}
			mut iife_result_22 := iife_temp_22.get_deleted_connection_notice()
			var_settings_mutated.array_get_mut('wccomHelper').array_set('maybe_deleted_connection',
				iife_result_22)
		} else {
			mut iife_temp_23 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
			mut iife_result_23 := iife_temp_23.get_wccom_disconnected_notice()
			var_settings_mutated.array_get_mut('wccomHelper').array_set('disconnected_notice',
				iife_result_23)
		}
	}
	return var_settings_mutated.clone()
}

fn Class_WC_Helper_Admin.get_connection_url(reconnect bool) rt.PhpVal {
	mut var_connect_url_args := {
		'page':    rt.new_string('wc-addons')
		'section': rt.new_string('helper')
	}
	mut iife_temp_24 := Class_WC_Helper{}
	mut iife_result_24 := iife_temp_24.is_site_connected()
	if rt.is_true(iife_result_24) && !var_reconnect {
		var_connect_url_args['wc-helper-disconnect'] = rt.new_int(1)
		var_connect_url_args['wc-helper-nonce'] = rt.call_function('wp_create_nonce', [
			rt.new_string('disconnect'),
		])
	} else {
		var_connect_url_args['wc-helper-connect'] = rt.new_int(1)
		var_connect_url_args['wc-helper-nonce'] = rt.call_function('wp_create_nonce', [
			rt.new_string('connect'),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('utm_source')))) {
		var_connect_url_args['utm_source'] = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('utm_source'))]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('utm_campaign')))) {
		var_connect_url_args['utm_campaign'] = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('utm_campaign'))]),
		])
	}
	return rt.call_function('add_query_arg', [
		rt.create_array_from_native_map(var_connect_url_args),
		rt.call_function('admin_url', [rt.new_string('admin.php')]),
	])
}

fn Class_WC_Helper_Admin.register_rest_routes() {
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/featured'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_featured' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v1'),
		rt.new_string('/marketplace/product-preview'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_product_preview' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
		])])
}

fn Class_WC_Helper_Admin.get_permission() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
}

fn Class_WC_Helper_Admin.get_featured() {
	mut iife_temp_25 := Class_WC_Admin_Addons{}
	mut iife_result_25 := iife_temp_25.fetch_featured()
	mut var_featured := iife_result_25
	if rt.is_true(rt.call_function('is_wp_error', [var_featured.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_featured,
					'get_error_message', []rt.PhpVal{}) },
			]),
		])
	}
	rt.call_function('wp_send_json', [var_featured.clone()])
}

fn Class_WC_Helper_Admin.get_product_preview(var_request rt.PhpVal) {
	mut var_product_id := rt.new_int((rt.call_method(var_request, 'get_param', [
		rt.new_string('product_id'),
	])).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Missing product ID'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
	mut iife_temp_26 := Class_WC_Admin_Addons{}
	mut iife_result_26 := iife_temp_26.fetch_product_preview(var_product_id.clone())
	mut var_product_preview := iife_result_26
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_preview)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string("We couldn't find a preview for this product."),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(404),
		])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_product_preview.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_product_preview,
					'get_error_message', []rt.PhpVal{}) },
			]),
		])
	}
	if !(var_product_preview.array_isset(rt.new_string('css')))
		|| !(var_product_preview.array_get(rt.new_string('css')).is_string())
		|| !(var_product_preview.array_isset(rt.new_string('html')))
		|| !(var_product_preview.array_get(rt.new_string('html')).is_string()) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('API response is missing required elements, or they are in the wrong form.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(500),
		])
	}
	mut iife_temp_27 := Class_WC_Helper_Sanitization{}
	mut iife_result_27 :=
		iife_temp_27.sanitize_css(var_product_preview.array_get(rt.new_string('css')))
	mut iife_temp_28 := Class_WC_Helper_Sanitization{}
	mut iife_result_28 :=
		iife_temp_28.sanitize_html(var_product_preview.array_get(rt.new_string('html')))
	mut var_sanitized_product_preview := {
		'css':  iife_result_27
		'html': iife_result_28
	}
	rt.call_function('wp_send_json', [
		rt.create_array_from_native_map(var_sanitized_product_preview),
	])
}

fn Class_WC_Helper_Admin.register_cache_clear_tool(var_debug_tools rt.PhpVal) rt.PhpVal {
	mut var_debug_tools_mutated := var_debug_tools
	var_debug_tools_mutated.array_set(Class_WC_Helper_Admin.cache_tool_id(), rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Clear WooCommerce.com cache'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
			rt.new_string('Clear'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('This tool will empty the WooCommerce.com data cache, used in WooCommerce Extensions.'),
				rt.new_string('woocommerce'),
			]),
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'run_clear_cache_tool' },
		]) },
	]))
	return var_debug_tools_mutated.clone()
}

fn Class_WC_Helper_Admin.run_clear_cache_tool() rt.PhpVal {
	mut iife_temp_29 := Class_WC_Helper{}
	mut iife_result_29 := iife_temp_29._flush_subscriptions_cache()
	mut iife_temp_30 := Class_WC_Helper{}
	mut iife_result_30 := iife_temp_30.flush_product_usage_notice_rules_cache()
	mut iife_temp_31 := Class_WC_Helper{}
	mut iife_result_31 := iife_temp_31.flush_connection_data_cache()
	mut iife_temp_32 := Class_WC_Helper_Updater{}
	mut iife_result_32 := iife_temp_32.flush_updates_cache()
	return rt.call_function('__', [rt.new_string('Helper cache cleared.'),
		rt.new_string('woocommerce')])
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Addons {
	rt.PhpObjectBase
}

struct Class_WC_Woo_Update_Manager_Plugin {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_WC_Woo_Helper_Connection {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Sanitization {
	rt.PhpObjectBase
}

fn create_wc_helper_admin(_args ...rt.PhpVal) &Class_WC_Helper_Admin {
	mut obj := &Class_WC_Helper_Admin{
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

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_addons(_args ...rt.PhpVal) &Class_WC_Admin_Addons {
	mut obj := &Class_WC_Admin_Addons{
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

fn create_wc_helper_updater(_args ...rt.PhpVal) &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
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

fn create_wc_woo_helper_connection(_args ...rt.PhpVal) &Class_WC_Woo_Helper_Connection {
	mut obj := &Class_WC_Woo_Helper_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_sanitization(_args ...rt.PhpVal) &Class_WC_Helper_Sanitization {
	mut obj := &Class_WC_Helper_Sanitization{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_Admin.load()
			return rt.new_null()
		}
		'add_marketplace_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Admin.add_marketplace_settings(dispatch_arg_0)
		}
		'get_connection_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_WC_Helper_Admin.get_connection_url(dispatch_arg_0)
		}
		'register_rest_routes' {
			Class_WC_Helper_Admin.register_rest_routes()
			return rt.new_null()
		}
		'get_permission' {
			return Class_WC_Helper_Admin.get_permission()
		}
		'get_featured' {
			Class_WC_Helper_Admin.get_featured()
			return rt.new_null()
		}
		'get_product_preview' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Admin.get_product_preview(dispatch_arg_0)
			return rt.new_null()
		}
		'register_cache_clear_tool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Admin.register_cache_clear_tool(dispatch_arg_0)
		}
		'run_clear_cache_tool' {
			return Class_WC_Helper_Admin.run_clear_cache_tool()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Addons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Addons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Addons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Woo_Helper_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Woo_Helper_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Woo_Helper_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Sanitization) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Sanitization) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Sanitization) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	Class_WC_Helper_Admin.load()
}
