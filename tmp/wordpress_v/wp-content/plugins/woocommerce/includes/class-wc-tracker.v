import rt
import crypto.md5

struct Class_WC_Tracker {
	rt.PhpObjectBase
pub mut:
		api_url rt.PhpVal = rt.new_string('https://tracking.woocommerce.com/v1/')
}

fn Class_WC_Tracker.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_tracker_send_event'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'send_tracking_data' }])])
}

fn Class_WC_Tracker.send_tracking_data(override bool)  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('DOING_AJAX'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_tracker_send_override'), rt.new_bool(override)]))))) {
		mut var_last_send := Class_WC_Tracker.get_last_send_time()
		if rt.is_true(rt.new_bool(rt.is_true(var_last_send) && rt.is_true(rt.greater(var_last_send, rt.call_function('apply_filters', [rt.new_string('woocommerce_tracker_last_send_interval'), rt.call_function('strtotime', [rt.new_string('-1 week')])]))))) {
			return rt.new_null()
		}
	} else {
		var_last_send = Class_WC_Tracker.get_last_send_time()
		if rt.is_true(rt.new_bool(rt.is_true(var_last_send) && rt.is_true(rt.greater(var_last_send, rt.call_function('strtotime', [rt.new_string('-1 hours')]))))) {
			return rt.new_null()
		}
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_tracker_last_send'), rt.call_function('time', []rt.PhpVal{})])
	mut var_params := Class_WC_Tracker.get_tracking_data()
	rt.call_function('wp_safe_remote_post', [// unsupported expression: Expr_StaticPropertyFetch, rt.create_array([rt.ArrayItem{ key: 'method', val: 'POST' }, rt.ArrayItem{ key: 'timeout', val: 45 }, rt.ArrayItem{ key: 'redirection', val: 5 }, rt.ArrayItem{ key: 'httpversion', val: '1.0' }, rt.ArrayItem{ key: 'blocking', val: false }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'user-agent', val: 'WooCommerceTracker/' + md5.hexhash(rt.call_function('esc_url_raw', [rt.call_function('home_url', [rt.new_string('/')])]).to_string()) + ';' }]) }, rt.ArrayItem{ key: 'body', val: rt.call_function('wp_json_encode', [var_params.dup()]) }, rt.ArrayItem{ key: 'cookies', val: rt.new_array() }])])
}

fn Class_WC_Tracker.get_last_send_time() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_tracker_last_send_time'), rt.call_function('get_option', [rt.new_string('woocommerce_tracker_last_send'), rt.new_bool(false)])])
}

fn Class_WC_Tracker.is_jetpack_staging_site() bool {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\Jetpack\\Status')])) {
		mut var_jp_status := create_automattic_jetpack_status()
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_jp_status }, rt.ArrayItem{ key: none, val: 'in_safe_mode' }])])) {
			return (var_jp_status.in_safe_mode()).to_bool()
		} else if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_jp_status }, rt.ArrayItem{ key: none, val: 'is_staging_site' }])])) {
			return (var_jp_status.is_staging_site()).to_bool()
		}
	}
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')])) && rt.is_true(rt.call_function('is_callable', [rt.new_string('Jetpack::is_staging_site')])))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_staging_site() }())
}

fn Class_WC_Tracker.get_tracking_data() rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_start_time := rt.call_function('microtime', [rt.new_bool(true)])
	var_data.array_set('url', rt.call_function('home_url', []rt.PhpVal{}))
	var_data.array_set('store_id', rt.call_function('get_option', [Class_WC_Install.store_id_option(), rt.new_null()]))
	var_data.array_set('blog_id', if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack_Options')])) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id')) } else { rt.new_null() })
	var_data.array_set('email', rt.call_function('apply_filters', [rt.new_string('woocommerce_tracker_admin_email'), rt.call_function('get_option', [rt.new_string('admin_email')])]))
	var_data.array_set('theme', Class_WC_Tracker.get_theme_info())
	var_data.array_set('wp', Class_WC_Tracker.get_wordpress_info())
	var_data.array_set('server', Class_WC_Tracker.get_server_info())
	mut var_all_plugins := Class_WC_Tracker.get_all_plugins()
	var_data.array_set('active_plugins', var_all_plugins.array_get('active_plugins'))
	var_data.array_set('inactive_plugins', var_all_plugins.array_get('inactive_plugins'))
	var_data.array_set('jetpack_version', if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('JETPACK__VERSION'))) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('JETPACK__VERSION')) } else { rt.new_string('none') })
	var_data.array_set('jetpack_connected', if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')])) && rt.is_true(rt.call_function('is_callable', [rt.new_string('Jetpack::is_active')])))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_active() }()))) { 'yes' } else { 'no' })
	var_data.array_set('jetpack_is_staging', if rt.is_true(Class_WC_Tracker.is_jetpack_staging_site()) { 'yes' } else { 'no' })
	var_data.array_set('connect_installed', if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Connect_Loader')])) { 'yes' } else { 'no' })
	var_data.array_set('connect_active', if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Connect_Loader')])) && rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wc_connect_fetch_service_schemas')])))) { 'yes' } else { 'no' })
	var_data.array_set('helper_connected', Class_WC_Tracker.get_helper_connected())
	var_data.array_set('users', Class_WC_Tracker.get_user_counts())
	var_data.array_set('products', Class_WC_Tracker.get_product_counts())
	var_data.array_set('orders', Class_WC_Tracker.get_orders())
	var_data.array_set('reviews', Class_WC_Tracker.get_review_counts())
	var_data.array_set('categories', Class_WC_Tracker.get_category_counts())
	var_data.array_set('brands', Class_WC_Tracker.get_brands_counts())
	var_data.array_set('migrator', Class_WC_Tracker.get_migrator_data())
	var_data.array_set('order_snapshot', Class_WC_Tracker.get_order_snapshot())
	var_data.array_set('gateways', Class_WC_Tracker.get_active_payment_gateways())
	var_data.array_set('wcpay_settings', Class_WC_Tracker.get_wcpay_settings())
	var_data.array_set('shipping_methods', Class_WC_Tracker.get_active_shipping_methods())
	var_data.array_set('enabled_features', Class_WC_Tracker.get_enabled_features())
	var_data.array_set('settings', Class_WC_Tracker.get_all_woocommerce_options_values())
	mut var_template_overrides := Class_WC_Tracker.get_all_template_overrides()
	var_data.array_set('template_overrides', var_template_overrides.dup())
	var_data.array_set('cart_checkout', Class_WC_Tracker.get_cart_checkout_info())
	if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('5.9'), rt.new_string('>=')])) {
		var_data.array_set('mini_cart_block', Class_WC_Tracker.get_mini_cart_info())
	}
	var_data.array_set('wc_admin_disabled', if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_disabled'), rt.new_bool(false)])) { 'yes' } else { 'no' })
	var_data.array_set('wc_mobile_usage', Class_WC_Tracker.get_woocommerce_mobile_usage())
	var_data.array_set('woocommerce_allow_tracking', rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('no')]))
	var_data.array_set('woocommerce_allow_tracking_last_modified', rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking_last_modified'), rt.new_string('unknown')]))
	var_data.array_set('woocommerce_allow_tracking_first_optin', rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking_first_optin'), rt.new_string('unknown')]))
	var_data.array_set('email_improvements', Class_WC_Tracker.get_email_improvements_info(var_template_overrides.dup()))
	var_data.array_set('store_emails', Class_WC_Tracker.get_store_emails())
	var_data.array_set('address_autocomplete', Class_WC_Tracker.get_address_autocomplete_info())
	var_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_tracker_data'), var_data.dup()])
	var_data.array_set('snapshot_generation_time', rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_start_time))
	return var_data.dup()
}

fn Class_WC_Tracker.get_address_autocomplete_info() rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'enabled', val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('wc_bool_to_string', [rt.call_function('get_option', [rt.new_string('woocommerce_address_autocomplete_enabled'), rt.new_string('no')])]))) { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'providers', val: rt.new_array() }, rt.ArrayItem{ key: 'preferred_provider', val: '' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()]))))) {
		var_data.array_set('enabled', 'no')
		return var_data.dup()
	}
	mut var_autocomplete_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()])
	rt.call_method(var_autocomplete_controller, 'init', []rt.PhpVal{})
	mut var_providers := rt.call_method(var_autocomplete_controller, 'get_providers', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_providers.dup().is_array())) {
		{
			mut iter_1 := var_providers.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_provider := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_provider, 'WC_Address_Provider')))))) {
					continue
				}
				var_data.array_get_mut('providers').array_push(rt.get_property(var_provider, 'id'))
			}
		}
	}
	if !rt.is_true(var_data.array_get('providers')) {
		var_data.array_set('enabled', 'no')
		return var_data.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('no'), var_data.array_get('enabled'))) {
		return var_data.dup()
	}
	var_data.array_set('preferred_provider', rt.call_method(var_autocomplete_controller, 'get_preferred_provider', []rt.PhpVal{}))
	return var_data.dup()
}

fn Class_WC_Tracker.get_theme_info() rt.PhpVal {
	mut var_theme_data := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_theme_child_theme := rt.call_function('wc_bool_to_string', [rt.call_function('is_child_theme', []rt.PhpVal{})])
	mut var_theme_wc_support := rt.call_function('wc_bool_to_string', [rt.call_function('current_theme_supports', [rt.new_string('woocommerce')])])
	mut var_theme_is_block_theme := rt.call_function('wc_bool_to_string', [rt.call_function('wp_is_block_theme', []rt.PhpVal{})])
	return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_theme_data, 'Name') }, rt.ArrayItem{ key: 'version', val: rt.get_property(var_theme_data, 'Version') }, rt.ArrayItem{ key: 'child_theme', val: var_theme_child_theme }, rt.ArrayItem{ key: 'wc_support', val: var_theme_wc_support }, rt.ArrayItem{ key: 'block_theme', val: var_theme_is_block_theme }])
}

fn Class_WC_Tracker.get_wordpress_info() rt.PhpVal {
	mut var_wp_data := rt.new_array()
	mut var_memory := rt.call_function('wc_let_to_num', [rt.get_constant('WP_MEMORY_LIMIT')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('memory_get_usage')])) {
		mut var_system_memory := rt.call_function('wc_let_to_num', [rt.call_function('ini_get', [rt.new_string('memory_limit')])])
		var_memory = rt.call_function('max', [var_memory.dup(), var_system_memory.dup()])
	}
	mut var_environment_type := rt.new_string(rt.new_string('production'))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_environment_type')])) {
		var_environment_type = rt.call_function('wp_get_environment_type', []rt.PhpVal{})
	}
	var_wp_data['memory_limit'] = rt.call_function('size_format', [var_memory.dup()])
	var_wp_data['debug_mode'] = if rt.is_true() {  } else {  }
	[] = 
	
}

fn Class_WC_Tracker.get_server_info() rt.PhpVal {
}

fn Class_WC_Tracker.get_all_plugins() rt.PhpVal {
}

fn Class_WC_Tracker.get_wcpay_settings() rt.PhpVal {
}

fn Class_WC_Tracker.get_helper_connected() string {
}

fn Class_WC_Tracker.get_user_counts() rt.PhpVal {
}

fn Class_WC_Tracker.get_product_counts() rt.PhpVal {
}

fn Class_WC_Tracker.get_order_counts() rt.PhpVal {
}

fn Class_WC_Tracker.get_orders() rt.PhpVal {
}

fn Class_WC_Tracker.get_order_totals() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_order_dates() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.extract_group_key(var_objects rt.PhpVal, var_default_key rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Tracker.get_orders_by_gateway() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_orders_origins() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_review_counts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_category_counts() rt.PhpVal {
}

fn Class_WC_Tracker.get_brands_counts() i64 {
}

fn Class_WC_Tracker.get_migrator_data() rt.PhpVal {
	return rt.new_null()
}

fn Class_WC_Tracker.get_active_payment_gateways() rt.PhpVal {
}

fn Class_WC_Tracker.get_active_shipping_methods() rt.PhpVal {
}

fn Class_WC_Tracker.get_enabled_features() rt.PhpVal {
}

fn Class_WC_Tracker.get_all_woocommerce_options_values() rt.PhpVal {
}

fn Class_WC_Tracker.get_all_template_overrides() rt.PhpVal {
}

fn Class_WC_Tracker.post_contains_text(var_post_id rt.PhpVal, var_text rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_block_tracker_data(var_block_name rt.PhpVal, var_woo_page_name rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Tracker.get_pickup_location_data() rt.PhpVal {
}

fn Class_WC_Tracker.get_checkout_additional_fields_data() rt.PhpVal {
}

fn Class_WC_Tracker.get_cart_checkout_info() rt.PhpVal {
}

fn Class_WC_Tracker.get_mini_cart_info() rt.PhpVal {
}

fn Class_WC_Tracker.get_woocommerce_mobile_usage() rt.PhpVal {
}

fn Class_WC_Tracker.map_legacy_meta_key_name(var_meta_key rt.PhpVal)  {
	mut var_meta_key_mutated := var_meta_key
}

fn Class_WC_Tracker.get_order_data(sort_order string, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tracker.get_additional_order_data(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn Class_WC_Tracker.get_refund_order_data(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn Class_WC_Tracker.get_order_snapshot() rt.PhpVal {
}

fn Class_WC_Tracker.get_email_improvements_info(var_template_overrides rt.PhpVal) rt.PhpVal {
	mut var_template_overrides_mutated := var_template_overrides
}

fn Class_WC_Tracker.get_store_emails() rt.PhpVal {
}

fn Class_WC_Tracker.get_core_email_status_counts() rt.PhpVal {
}

fn Class_WC_Tracker.get_core_email_overrides(var_template_overrides rt.PhpVal) rt.PhpVal {
	mut var_template_overrides_mutated := var_template_overrides
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Status {
	rt.PhpObjectBase
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_Jetpack_Options {
	rt.PhpObjectBase
}

fn create_wc_tracker() &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
		api_url: rt.new_string('https://tracking.woocommerce.com/v1/')
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_status() &Class_Automattic_Jetpack_Status {
	mut obj := &Class_Automattic_Jetpack_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack() &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options() &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Tracker.init()
			return rt.new_null()
		}
		'send_tracking_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class_WC_Tracker.send_tracking_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_last_send_time' {
			return Class_WC_Tracker.get_last_send_time()
		}
		'is_jetpack_staging_site' {
			return rt.new_bool(Class_WC_Tracker.is_jetpack_staging_site())
		}
		'get_tracking_data' {
			return Class_WC_Tracker.get_tracking_data()
		}
		'get_address_autocomplete_info' {
			return Class_WC_Tracker.get_address_autocomplete_info()
		}
		'get_theme_info' {
			return Class_WC_Tracker.get_theme_info()
		}
		'get_wordpress_info' {
			return Class_WC_Tracker.get_wordpress_info()
		}
		'get_server_info' {
			return Class_WC_Tracker.get_server_info()
		}
		'get_all_plugins' {
			return Class_WC_Tracker.get_all_plugins()
		}
		'get_wcpay_settings' {
			return Class_WC_Tracker.get_wcpay_settings()
		}
		'get_helper_connected' {
			return rt.new_string(Class_WC_Tracker.get_helper_connected())
		}
		'get_user_counts' {
			return Class_WC_Tracker.get_user_counts()
		}
		'get_product_counts' {
			return Class_WC_Tracker.get_product_counts()
		}
		'get_order_counts' {
			return Class_WC_Tracker.get_order_counts()
		}
		'get_orders' {
			return Class_WC_Tracker.get_orders()
		}
		'get_order_totals' {
			return Class_WC_Tracker.get_order_totals()
		}
		'get_order_dates' {
			return Class_WC_Tracker.get_order_dates()
		}
		'extract_group_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tracker.extract_group_key(dispatch_arg_0, dispatch_arg_1)
		}
		'get_orders_by_gateway' {
			return Class_WC_Tracker.get_orders_by_gateway()
		}
		'get_orders_origins' {
			return Class_WC_Tracker.get_orders_origins()
		}
		'get_review_counts' {
			return Class_WC_Tracker.get_review_counts()
		}
		'get_category_counts' {
			return Class_WC_Tracker.get_category_counts()
		}
		'get_brands_counts' {
			return rt.new_int(Class_WC_Tracker.get_brands_counts())
		}
		'get_migrator_data' {
			return Class_WC_Tracker.get_migrator_data()
		}
		'get_active_payment_gateways' {
			return Class_WC_Tracker.get_active_payment_gateways()
		}
		'get_active_shipping_methods' {
			return Class_WC_Tracker.get_active_shipping_methods()
		}
		'get_enabled_features' {
			return Class_WC_Tracker.get_enabled_features()
		}
		'get_all_woocommerce_options_values' {
			return Class_WC_Tracker.get_all_woocommerce_options_values()
		}
		'get_all_template_overrides' {
			return Class_WC_Tracker.get_all_template_overrides()
		}
		'post_contains_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WC_Tracker.post_contains_text(dispatch_arg_0, dispatch_arg_1))
		}
		'get_block_tracker_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tracker.get_block_tracker_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_pickup_location_data' {
			return Class_WC_Tracker.get_pickup_location_data()
		}
		'get_checkout_additional_fields_data' {
			return Class_WC_Tracker.get_checkout_additional_fields_data()
		}
		'get_cart_checkout_info' {
			return Class_WC_Tracker.get_cart_checkout_info()
		}
		'get_mini_cart_info' {
			return Class_WC_Tracker.get_mini_cart_info()
		}
		'get_woocommerce_mobile_usage' {
			return Class_WC_Tracker.get_woocommerce_mobile_usage()
		}
		'map_legacy_meta_key_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Tracker.map_legacy_meta_key_name(dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_Tracker.get_order_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_additional_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracker.get_additional_order_data(dispatch_arg_0)
		}
		'get_refund_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracker.get_refund_order_data(dispatch_arg_0)
		}
		'get_order_snapshot' {
			return Class_WC_Tracker.get_order_snapshot()
		}
		'get_email_improvements_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracker.get_email_improvements_info(dispatch_arg_0)
		}
		'get_store_emails' {
			return Class_WC_Tracker.get_store_emails()
		}
		'get_core_email_status_counts' {
			return Class_WC_Tracker.get_core_email_status_counts()
		}
		'get_core_email_overrides' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracker.get_core_email_overrides(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api_url' { return this.api_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api_url' { this.api_url = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_Jetpack_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_tracker_php() {
	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
