import rt

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

fn Class_WC_Site_Tracking.is_tracking_enabled() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_user_tracking'), rt.new_bool(true)])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_tracking'), rt.new_bool(true)]))))) {
		return false
	}
	mut var_is_obw_opting_in := rt.new_bool(
		rt.get_superglobal('_POST').array_isset(rt.new_string('wc_tracker_checkbox'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_tracker_checkbox'))]))))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_obw_opting_in)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Tracks'),
	])))))
	{
		return false
	}
	return true
}

fn Class_WC_Site_Tracking.register_scripts() {
	rt.call_function('wp_register_script', [rt.new_string('woo-tracks'),
		rt.new_string('https://stats.wp.com/w.js'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
		]),
		rt.call_function('gmdate', [
			rt.new_string('YW'),
		]),
		rt.new_bool(false)])
}

fn Class_WC_Site_Tracking.enqueue_scripts() {
	rt.call_function('wp_enqueue_script', [rt.new_string('woo-tracks')])
}

fn Class_WC_Site_Tracking.add_tracking_function() {
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut iife_temp_0 := Class_WC_Tracks{}
	mut iife_result_0 := iife_temp_0.get_server_details()
	mut var_server_details := iife_result_0
	mut iife_temp_1 := Class_WC_Tracks{}
	mut iife_result_1 := iife_temp_1.get_blog_details(rt.get_property(var_user, 'ID'))
	mut var_blog_details := iife_result_1
	mut iife_temp_2 := Class_WC_Tracks_Client{}
	mut iife_result_2 := iife_temp_2.get_identity(rt.get_property(var_user, 'ID'))
	mut var_tracks_identity := iife_result_2
	mut iife_temp_3 := Class_WC_Tracks{}
	mut iife_result_3 := iife_temp_3.get_role_details(var_user.clone())
	mut var_role_details := iife_result_3
	mut var_client_tracking_properties := rt.call_function('array_merge', [
		var_server_details.clone(), var_blog_details.clone(),
		var_role_details.clone()])
	mut var_filtered_properties := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_tracks_event_properties'),
		var_client_tracking_properties.clone(),
		rt.new_bool(false),
	])
	mut var_environment_type := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_environment_type'),
	]))
	{
		rt.call_function('wp_get_environment_type', []rt.PhpVal{})
	} else {
		rt.new_string('production')
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(Class_WC_Site_Tracking.is_tracking_enabled()) { 'true' } else { 'false' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('anon'),
		var_tracks_identity.array_get(rt.new_string('_ut'))))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_js',
			[var_tracks_identity.array_get(rt.new_string('_ui'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [Class_WC_Tracks_Event.event_name_regex()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_environment_type,
		rt.new_string('production')))))
	{
		'true'
	} else {
		'false'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [Class_WC_Tracks_Event.prop_name_regex()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_environment_type,
		rt.new_string('production')))))
	{
		'true'
	} else {
		'false'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [Class_WC_Tracks.prefix()]))
	// unsupported statement: Stmt_InlineHTML
	print(rt.json_encode(var_filtered_properties.clone()))
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Site_Tracking.add_enable_tracking_function() {
	mut var_wp_scripts := rt.new_null()
	if !(rt.get_property(var_wp_scripts, 'registered').array_isset(rt.new_string('woo-tracks'))) {
		return
	}
	mut var_woo_tracks_script := rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(rt.new_string('woo-tracks')),
		'src')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_woo_tracks_script.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Site_Tracking.init() {
	Class_WC_Site_Tracking.register_scripts()
	rt.call_function('add_filter', [rt.new_string('admin_footer'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_tracking_function' }]),
		rt.new_int(24)])
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Site_Tracking.is_tracking_enabled())))) {
		rt.call_function('add_filter', [rt.new_string('admin_footer'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'add_enable_tracking_function' }]),
			rt.new_int(24)])
		return
	}
	Class_WC_Site_Tracking.enqueue_scripts()
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-admin-setup-wizard-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-extensions-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-importer-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-products-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-orders-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-settings-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-status-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-coupons-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-order-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-coupon-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-theme-tracking.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/events/class-wc-product-collection-block-tracking.php',
		'2')
	mut var_tracking_classes := ['WC_Extensions_Tracking', 'WC_Importer_Tracking',
		'WC_Products_Tracking', 'WC_Orders_Tracking', 'WC_Settings_Tracking', 'WC_Status_Tracking',
		'WC_Coupons_Tracking', 'WC_Order_Tracking', 'WC_Coupon_Tracking', 'WC_Theme_Tracking',
		'WC_Product_Collection_Block_Tracking']
	for var_tracking_class in var_tracking_classes {
		mut var_tracker_instance := rt.create_object_dynamically(tracking_class, []rt.PhpVal{})
		mut var_tracker_init_method := [var_tracker_instance, rt.new_string('init')]
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array_from_list(var_tracker_init_method),
		]))
		{
			rt.call_function('call_user_func', [
				rt.create_array_from_list(var_tracker_init_method),
			])
		}
	}
	rt.call_function('add_filter', [
		rt.new_string('pre_update_option_woocommerce_allow_tracking'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_unschedule_deferred_tracks' }]),
	])
}

fn Class_WC_Site_Tracking.maybe_unschedule_deferred_tracks(var_new_option_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), var_new_option_value)))) {
		rt.call_function('as_unschedule_all_actions', [rt.new_string(''),
			rt.new_array(), rt.new_string('woocommerce-tracks')])
	}
	return var_new_option_value.clone()
}

fn Class_WC_Site_Tracking.set_tracking_cookie(cookie_key string, cookie_value string, expire i64, secure bool, http_only bool) bool {
	if rt.is_true(Class_WC_Site_Tracking.is_tracking_enabled()) {
		rt.call_function('wc_setcookie', [rt.new_string(cookie_key),
			rt.new_string(cookie_value), rt.new_int(expire), rt.new_bool(secure),
			rt.new_bool(http_only)])
		return true
	}
	return false
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Client {
	rt.PhpObjectBase
}

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
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

fn create_wc_tracks_client(_args ...rt.PhpVal) &Class_WC_Tracks_Client {
	mut obj := &Class_WC_Tracks_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_tracking_enabled' {
			return rt.new_bool(Class_WC_Site_Tracking.is_tracking_enabled())
		}
		'register_scripts' {
			Class_WC_Site_Tracking.register_scripts()
			return rt.new_null()
		}
		'enqueue_scripts' {
			Class_WC_Site_Tracking.enqueue_scripts()
			return rt.new_null()
		}
		'add_tracking_function' {
			Class_WC_Site_Tracking.add_tracking_function()
			return rt.new_null()
		}
		'add_enable_tracking_function' {
			Class_WC_Site_Tracking.add_enable_tracking_function()
			return rt.new_null()
		}
		'init' {
			Class_WC_Site_Tracking.init()
			return rt.new_null()
		}
		'maybe_unschedule_deferred_tracks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Site_Tracking.maybe_unschedule_deferred_tracks(dispatch_arg_0)
		}
		'set_tracking_cookie' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_WC_Site_Tracking.set_tracking_cookie(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tracks_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Site_Tracking', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_site_tracking()
		return rt.new_object('WC_Site_Tracking', []string{}, obj)
	})
	rt.register_class_factory('WC_Tracks', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tracks()
		return rt.new_object('WC_Tracks', []string{}, obj)
	})
	rt.register_class_factory('WC_Tracks_Client', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tracks_client()
		return rt.new_object('WC_Tracks_Client', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
