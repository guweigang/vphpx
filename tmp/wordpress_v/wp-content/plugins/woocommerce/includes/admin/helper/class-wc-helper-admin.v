import rt

pub fn Class_WC_Helper_Admin.cache_tool_id() string {
	return 'clear_woocommerce_helper_cache'
}
struct Class_WC_Helper_Admin {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Admin.load()  {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		mut var_is_wc_home_or_in_app_marketplace := rt.new_bool(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('page')) && rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get('page')))))
		if rt.is_true(var_is_wc_home_or_in_app_marketplace) {
			rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_marketplace_settings' }])])
		}
		rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_cache_clear_tool' }])])
	}
	rt.call_function('add_filter', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_rest_routes' }])])
}

fn Class_WC_Helper_Admin.add_marketplace_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }())))) && rt.get_superglobal('_GET').array_isset(rt.new_string('connect')))) {
		rt.call_function('wp_safe_redirect', [Class_WC_Helper_Admin.get_connection_url()])
		// unsupported expression: Expr_Exit
	}
	mut var_auth_user_data := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0, arg_1) }(rt.new_string('auth_user_data'), rt.new_array())
	mut var_auth_user_email := if var_auth_user_data.array_isset(rt.new_string('email')) { var_auth_user_data.array_get('email') } else { rt.new_string('') }
	mut var_installed_products := rt.call_function('array_merge', [fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_plugins() }(), fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_local_themes() }()])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_product := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_product.array_get('slug')
	}
	mut var_product := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_product.array_get('slug')
	}
	var_installed_products = rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_installed_products.dup()])
	mut var_blog_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	var_settings_mutated.array_set('wccomHelper', rt.create_array([rt.ArrayItem{ key: 'isConnected', val: fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }() }, rt.ArrayItem{ key: 'connectURL', val: Class_WC_Helper_Admin.get_connection_url() }, rt.ArrayItem{ key: 'reConnectURL', val: Class_WC_Helper_Admin.get_connection_url(true) }, rt.ArrayItem{ key: 'userEmail', val: var_auth_user_email }, rt.ArrayItem{ key: 'userAvatar', val: rt.call_function('get_avatar_url', [var_auth_user_email.dup(), rt.create_array([rt.ArrayItem{ key: 'size', val: '48' }])]) }, rt.ArrayItem{ key: 'storeCountry', val: rt.call_function('wc_get_base_location', []rt.PhpVal{}).array_get('country') }, rt.ArrayItem{ key: 'storeName', val: if rt.is_true(var_blog_name) { var_blog_name } else { rt.new_string('') } }, rt.ArrayItem{ key: 'inAppPurchaseURLParams', val: fn () rt.PhpVal { mut temp := Class_WC_Admin_Addons{}; return temp.get_in_app_purchase_url_params() }() }, rt.ArrayItem{ key: 'installedProducts', val: var_installed_products }, rt.ArrayItem{ key: 'mySubscriptionsTabLoaded', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('my_subscriptions_tab_loaded')) }, rt.ArrayItem{ key: 'wooUpdateManagerInstalled', val: fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_installed() }() }, rt.ArrayItem{ key: 'wooUpdateManagerActive', val: fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.is_plugin_active() }() }, rt.ArrayItem{ key: 'wooUpdateManagerInstallUrl', val: fn () rt.PhpVal { mut temp := Class_WC_Woo_Update_Manager_Plugin{}; return temp.generate_install_url() }() }, rt.ArrayItem{ key: 'wooUpdateManagerPluginSlug', val: Class_WC_Woo_Update_Manager_Plugin.woo_update_manager_slug() }, rt.ArrayItem{ key: 'dismissNoticeNonce', val: rt.call_function('wp_create_nonce', [rt.new_string('dismiss_notice')]) }, rt.ArrayItem{ key: 'trackingAllowed', val: rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking')])) }]))
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('path'))) && rt.is_true(rt.identical(rt.new_string('/extensions'), rt.get_superglobal('_GET').array_get('path'))))) {
		var_settings_mutated.array_get_mut('wccomHelper').array_set('wooUpdateCount', fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_updates_count_based_on_site_status() }())
		var_settings_mutated.array_get_mut('wccomHelper').array_set('connected_notice', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_wccom_connected_notice(arg_0) }(var_auth_user_email.dup()))
		var_settings_mutated.array_get_mut('wccomHelper').array_set('woocomConnectNoticeType', fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_woo_connect_notice_type() }())
		if rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()) {
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_expired_notice', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_expired_subscription_notice(arg_0) }(rt.new_bool(false)))
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_expiring_notice', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_expiring_subscription_notice(arg_0) }(rt.new_bool(false)))
			var_settings_mutated.array_get_mut('wccomHelper').array_set('subscription_missing_notice', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_missing_subscription_notice() }())
			var_settings_mutated.array_get_mut('wccomHelper').array_set('connection_url_notice', fn () rt.PhpVal { mut temp := Class_WC_Woo_Helper_Connection{}; return temp.get_connection_url_notice() }())
			var_settings_mutated.array_get_mut('wccomHelper').array_set('has_host_plan_orders', fn () rt.PhpVal { mut temp := Class_WC_Woo_Helper_Connection{}; return temp.has_host_plan_orders() }())
			var_settings_mutated.array_get_mut('wccomHelper').array_set('maybe_deleted_connection', fn () rt.PhpVal { mut temp := Class_WC_Woo_Helper_Connection{}; return temp.get_deleted_connection_notice() }())
		} else {
			var_settings_mutated.array_get_mut('wccomHelper').array_set('disconnected_notice', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_wccom_disconnected_notice() }())
		}
	}
	return var_settings_mutated.dup()
}

fn Class_WC_Helper_Admin.get_connection_url(reconnect bool) rt.PhpVal {
	mut var_connect_url_args := { 'page': rt.new_string('wc-addons'), 'section': rt.new_string('helper') }
	if rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }()) && !(var_reconnect))) {
		var_connect_url_args['wc-helper-disconnect'] = rt.new_int(1)
		var_connect_url_args['wc-helper-nonce'] = rt.call_function('wp_create_nonce', [rt.new_string('disconnect')])
	} else {
		var_connect_url_args['wc-helper-connect'] = rt.new_int(1)
		var_connect_url_args['wc-helper-nonce'] = rt.call_function('wp_create_nonce', [rt.new_string('connect')])
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('utm_source'))) {
		var_connect_url_args['utm_source'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('utm_source')])])
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('utm_campaign'))) {
		var_connect_url_args['utm_campaign'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('utm_campaign')])])
		// unsupported statement: Stmt_Nop
	}
	return rt.call_function('add_query_arg', [var_connect_url_args.dup(), rt.call_function('admin_url', [rt.new_string('admin.php')])])
}

fn Class_WC_Helper_Admin.register_rest_routes()  {
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/featured'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_featured' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v1'), rt.new_string('/marketplace/product-preview'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_product_preview' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }])])
}

fn Class_WC_Helper_Admin.get_permission() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
}

fn Class_WC_Helper_Admin.get_featured()  {
	mut var_featured := fn () rt.PhpVal { mut temp := Class_WC_Admin_Addons{}; return temp.fetch_featured() }()
	if rt.is_true(rt.call_function('is_wp_error', [var_featured.dup()])) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_featured, 'get_error_message', []rt.PhpVal{}) }])])
	}
	rt.call_function('wp_send_json', [var_featured.dup()])
}

fn Class_WC_Helper_Admin.get_product_preview(var_request rt.PhpVal)  {
	mut var_product_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Missing product ID'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
	mut var_product_preview := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Addons{}; return temp.fetch_product_preview(arg_0) }(var_product_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_preview)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('We couldn\'t find a preview for this product.'), rt.new_string('woocommerce')]) }]), rt.new_int(404)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_product_preview.dup()])) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_product_preview, 'get_error_message', []rt.PhpVal{}) }])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_product_preview.array_isset(rt.new_string('css'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_product_preview.array_get('css').is_string()))))))) || !(var_product_preview.array_isset(rt.new_string('html'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_product_preview.array_get('html').is_string()))))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('API response is missing required elements, or they are in the wrong form.'), rt.new_string('woocommerce')]) }]), rt.new_int(500)])
	}
	mut var_sanitized_product_preview := { 'css': fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Sanitization{}; return temp.sanitize_css(arg_0) }(var_product_preview.array_get('css')), 'html': fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Sanitization{}; return temp.sanitize_html(arg_0) }(var_product_preview.array_get('html')) }
	rt.call_function('wp_send_json', [var_sanitized_product_preview.dup()])
}

fn Class_WC_Helper_Admin.register_cache_clear_tool(var_debug_tools rt.PhpVal) rt.PhpVal {
	mut var_debug_tools_mutated := var_debug_tools
	var_debug_tools_mutated.array_set(Class_WC_Helper_Admin.cache_tool_id(), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear WooCommerce.com cache'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This tool will empty the WooCommerce.com data cache, used in WooCommerce Extensions.'), rt.new_string('woocommerce')])]) }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'run_clear_cache_tool' }]) }]))
	return var_debug_tools_mutated.dup()
}

fn Class_WC_Helper_Admin.run_clear_cache_tool() rt.PhpVal {
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp._flush_subscriptions_cache() }()
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.flush_product_usage_notice_rules_cache() }()
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.flush_connection_data_cache() }()
	fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.flush_updates_cache() }()
	return rt.call_function('__', [rt.new_string('Helper cache cleared.'), rt.new_string('woocommerce')])
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

fn create_wc_helper_admin() &Class_WC_Helper_Admin {
	mut obj := &Class_WC_Helper_Admin{
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

fn create_wc_helper_options() &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_addons() &Class_WC_Admin_Addons {
	mut obj := &Class_WC_Admin_Addons{
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

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
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

fn create_wc_woo_helper_connection() &Class_WC_Woo_Helper_Connection {
	mut obj := &Class_WC_Woo_Helper_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_sanitization() &Class_WC_Helper_Sanitization {
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_helper_admin_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	Class_WC_Helper_Admin.load()
}
