import rt

struct Class_WC_Helper_Subscriptions_API {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Subscriptions_API.load() {
	rt.call_function('add_filter', [rt.new_string('rest_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_rest_routes' }])])
}

fn Class_WC_Helper_Subscriptions_API.register_rest_routes() {
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/refresh'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'refresh' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_subscriptions' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions/connect'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'connect' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_key', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions/activate-plugin'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'activate_plugin' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_key', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions/disconnect'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'disconnect' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_key', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions/activate'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'activate' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_key', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/subscriptions/install-url'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'install_url' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_key', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) }])])
}

fn Class_WC_Helper_Subscriptions_API.get_permission() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
}

fn Class_WC_Helper_Subscriptions_API.get_subscriptions() {
	mut iife_temp_0 := Class_WC_Helper_Options{}
	mut iife_result_0 := iife_temp_0.get(rt.new_string('my_subscriptions_tab_loaded'))
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.is_site_connected()
	if rt.is_true(rt.identical(iife_result_1, rt.new_bool(true))) && !rt.is_true(iife_result_0) {
		mut iife_temp_2 := Class_WC_Helper_Options{}
		mut iife_result_2 := iife_temp_2.update(rt.new_string('my_subscriptions_tab_loaded'), rt.call_function('date', [
			rt.new_string('Y-m-d H:i:s'),
		]))
	}
	mut iife_temp_3 := Class_WC_Helper{}
	mut iife_result_3 := iife_temp_3.get_subscription_list_data()
	mut var_subscriptions := iife_result_3
	rt.call_function('wp_send_json', [
		rt.call_function('array_values', [var_subscriptions.clone()]),
	])
}

fn Class_WC_Helper_Subscriptions_API.refresh() {
	mut iife_temp_4 := Class_WC_Helper{}
	mut iife_result_4 := iife_temp_4.refresh_helper_subscriptions()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_5 := Class_WC_Helper{}
	mut iife_result_5 := iife_temp_5.get_subscriptions()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_6 := Class_WC_Helper{}
	mut iife_result_6 := iife_temp_6.get_product_usage_notice_rules()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_7 := Class_WC_Helper{}
	mut iife_result_7 := iife_temp_7.fetch_helper_connection_info()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	Class_WC_Helper_Subscriptions_API.get_subscriptions()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage',
					[]rt.PhpVal{}) },
			]),
			rt.new_int(400),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn Class_WC_Helper_Subscriptions_API.connect(var_request rt.PhpVal) {
	mut var_product_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('product_key'),
	])
	mut iife_temp_8 := Class_WC_Helper{}
	mut iife_result_8 := iife_temp_8.activate_helper_subscription(var_product_key.clone())
	mut var_success := iife_result_8
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		mut var_error_data := rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) },
		])
		if rt.is_true(rt.new_bool(rt.instance_of(var_e, 'WC_Data_Exception'))) {
			var_error_data.array_set('code', rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}))
			var_error_data.array_set('data', rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
			mut var_status_code :=
				rt.new_int((rt.call_method(var_e, 'getCode', []rt.PhpVal{})).to_i64())
			if rt.is_true(rt.greater(rt.new_int(100), var_status_code))
				|| rt.is_true(rt.less(rt.new_int(599), var_status_code)) {
				var_status_code = rt.new_int(400)
			}
		} else {
			var_status_code = rt.new_int(400)
		}
		rt.call_function('wp_send_json_error', [var_error_data.clone(),
			var_status_code.clone()])
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Your subscription has been connected.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('There was an error connecting your subscription. Please try again.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
}

fn Class_WC_Helper_Subscriptions_API.activate_plugin(var_request rt.PhpVal) {
	mut var_product_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('product_key'),
	])
	mut iife_temp_9 := Class_WC_Helper{}
	mut iife_result_9 := iife_temp_9.activate_plugin(var_product_key.clone())
	mut var_success := iife_result_9
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage',
					[]rt.PhpVal{}) },
			]),
			rt.new_int(400),
		])
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('The plugin for your subscription has been activated.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string("The plugin for your subscription couldn't be activated."),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
}

fn Class_WC_Helper_Subscriptions_API.disconnect(var_request rt.PhpVal) {
	mut var_product_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('product_key'),
	])
	mut iife_temp_10 := Class_WC_Helper{}
	mut iife_result_10 := iife_temp_10.deactivate_helper_subscription(var_product_key.clone())
	mut var_success := iife_result_10
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage',
					[]rt.PhpVal{}) },
			]),
			rt.new_int(400),
		])
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Your subscription has been disconnected.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('There was an error disconnecting your subscription. Please try again.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
}

fn Class_WC_Helper_Subscriptions_API.activate(var_request rt.PhpVal) {
	mut var_product_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('product_key'),
	])
	mut iife_temp_11 := Class_WC_Helper{}
	mut iife_result_11 := iife_temp_11.get_subscription(var_product_key.clone())
	mut var_subscription := iife_result_11
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string("We couldn't find a subscription for this product."),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))))))
		|| !(var_subscription.array_get(rt.new_string('local')).array_isset(rt.new_string('active'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('This product is not installed.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('active'))))
	{
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('This product is already active.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('plugin'),
		var_subscription.array_get(rt.new_string('product_type'))))
	{
		mut var_success := rt.call_function('activate_plugin', [
			var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('path')),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_success.clone()])) {
			rt.call_function('wp_send_json_error', [
				rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('There was an error activating this plugin.'),
						rt.new_string('woocommerce'),
					]) },
				]),
				rt.new_int(400),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_string('theme'),
		var_subscription.array_get(rt.new_string('product_type'))))
	{
		rt.call_function('switch_theme',
			[var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('slug'))])
		mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('slug')), rt.call_method(var_theme,
			'get_stylesheet', []rt.PhpVal{})))))
		{
			rt.call_function('wp_send_json_error', [
				rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('There was an error activating this theme.'),
						rt.new_string('woocommerce'),
					]) },
				]),
				rt.new_int(400),
			])
		}
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('This product has been activated.'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
}

fn Class_WC_Helper_Subscriptions_API.install_url(var_request rt.PhpVal) {
	mut var_product_key := rt.call_method(var_request, 'get_param', [
		rt.new_string('product_key'),
	])
	mut iife_temp_12 := Class_WC_Helper{}
	mut iife_result_12 := iife_temp_12.get_subscription(var_product_key.clone())
	mut var_subscription := iife_result_12
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string("We couldn't find a subscription for this product."),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_subscription.array_get(rt.new_string('local')).array_get(rt.new_string('installed'))))
	{
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('This product is already installed.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	mut iife_temp_13 := Class_WC_Helper{}
	mut iife_result_13 := iife_temp_13.get_subscription_install_url(var_subscription.array_get(rt.new_string('product_key')),
		var_subscription.array_get(rt.new_string('product_slug')))
	mut var_install_url := iife_result_13
	if rt.is_true(rt.new_bool(!(rt.is_true(var_install_url)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('There was an error getting the install URL for this product.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(400),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'url', val: var_install_url }]),
	])
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper_subscriptions_api(_args ...rt.PhpVal) &Class_WC_Helper_Subscriptions_API {
	mut obj := &Class_WC_Helper_Subscriptions_API{
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

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Subscriptions_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_Subscriptions_API.load()
			return rt.new_null()
		}
		'register_rest_routes' {
			Class_WC_Helper_Subscriptions_API.register_rest_routes()
			return rt.new_null()
		}
		'get_permission' {
			return Class_WC_Helper_Subscriptions_API.get_permission()
		}
		'get_subscriptions' {
			Class_WC_Helper_Subscriptions_API.get_subscriptions()
			return rt.new_null()
		}
		'refresh' {
			Class_WC_Helper_Subscriptions_API.refresh()
			return rt.new_null()
		}
		'connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Subscriptions_API.connect(dispatch_arg_0)
			return rt.new_null()
		}
		'activate_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Subscriptions_API.activate_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'disconnect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Subscriptions_API.disconnect(dispatch_arg_0)
			return rt.new_null()
		}
		'activate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Subscriptions_API.activate(dispatch_arg_0)
			return rt.new_null()
		}
		'install_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Helper_Subscriptions_API.install_url(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Subscriptions_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Subscriptions_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	Class_WC_Helper_Subscriptions_API.load()
}
