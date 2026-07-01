import rt

struct Class_WC_Helper_Subscriptions_API {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Subscriptions_API.load()  {
	rt.call_function('add_filter', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'register_rest_routes' }])])
}

fn Class_WC_Helper_Subscriptions_API.register_rest_routes()  {
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/refresh'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'refresh' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_subscriptions' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions/connect'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'connect' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions/activate-plugin'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'activate_plugin' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions/disconnect'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'disconnect' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions/activate'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'activate' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }])])
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'), rt.new_string('/marketplace/subscriptions/install-url'), rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'install_url' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_permission' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_key', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }])])
}

fn Class_WC_Helper_Subscriptions_API.get_permission() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])
}

fn Class_WC_Helper_Subscriptions_API.get_subscriptions()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.is_site_connected() }(), rt.new_bool(true))) && !rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('my_subscriptions_tab_loaded'))))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.update(arg_0, arg_1) }(rt.new_string('my_subscriptions_tab_loaded'), rt.call_function('date', [rt.new_string('Y-m-d H:i:s')]))
	}
	mut var_subscriptions := fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscription_list_data() }()
	rt.call_function('wp_send_json', [rt.call_function('array_values', [var_subscriptions.dup()])])
}

fn Class_WC_Helper_Subscriptions_API.refresh()  {
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.refresh_helper_subscriptions() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscriptions() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_product_usage_notice_rules() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.fetch_helper_connection_info() }()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	Class_WC_Helper_Subscriptions_API.get_subscriptions()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }]), rt.new_int(400)])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_WC_Helper_Subscriptions_API.connect(var_request rt.PhpVal)  {
	mut var_product_key := rt.call_method(var_request, 'get_param', [rt.new_string('product_key')])
	mut var_success := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.activate_helper_subscription(arg_0) }(var_product_key.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		mut var_error_data := rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])
		if rt.is_true(rt.new_bool(rt.instance_of(var_e, 'WC_Data_Exception'))) {
			var_error_data.array_set('code', rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{}))
			var_error_data.array_set('data', rt.call_method(var_e, 'getErrorData', []rt.PhpVal{}))
			mut var_status_code := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.new_int(100), var_status_code)) || rt.is_true(rt.less(rt.new_int(599), var_status_code)))) {
				var_status_code = rt.new_int(rt.new_int(400))
			}
		} else {
			var_status_code = rt.new_int(rt.new_int(400))
		}
		rt.call_function('wp_send_json_error', [var_error_data.dup(), var_status_code.dup()])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Your subscription has been connected.'), rt.new_string('woocommerce')]) }])])
	} else {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an error connecting your subscription. Please try again.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
}

fn Class_WC_Helper_Subscriptions_API.activate_plugin(var_request rt.PhpVal)  {
	mut var_product_key := rt.call_method(var_request, 'get_param', [rt.new_string('product_key')])
	mut var_success := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.activate_plugin(arg_0) }(var_product_key.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.dup()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }]), rt.new_int(400)])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('The plugin for your subscription has been activated.'), rt.new_string('woocommerce')]) }])])
	} else {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('The plugin for your subscription couldn\'t be activated.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
}

fn Class_WC_Helper_Subscriptions_API.disconnect(var_request rt.PhpVal)  {
	mut var_product_key := rt.call_method(var_request, 'get_param', [rt.new_string('product_key')])
	mut var_success := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.deactivate_helper_subscription(arg_0) }(var_product_key.dup())
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.dup()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }]), rt.new_int(400)])
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	if rt.is_true(var_success) {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Your subscription has been disconnected.'), rt.new_string('woocommerce')]) }])])
	} else {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an error disconnecting your subscription. Please try again.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
}

fn Class_WC_Helper_Subscriptions_API.activate(var_request rt.PhpVal)  {
	mut var_product_key := rt.call_method(var_request, 'get_param', [rt.new_string('product_key')])
	mut var_subscription := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscription(arg_0) }(var_product_key.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('We couldn\'t find a subscription for this product.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(var_subscription.array_get('local').array_isset(rt.new_string('active'))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('This product is not installed.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_subscription.array_get('local').array_get('active'))) {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('This product is already active.'), rt.new_string('woocommerce')]) }])])
	}
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_subscription.array_get('product_type'))) {
		mut var_success := rt.call_function('activate_plugin', [var_subscription.array_get('local').array_get('path')])
		if rt.is_true(rt.call_function('is_wp_error', [var_success.dup()])) {
			rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an error activating this plugin.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
		}
	} else if rt.is_true(rt.identical(rt.new_string('theme'), var_subscription.array_get('product_type'))) {
		rt.call_function('switch_theme', [var_subscription.array_get('local').array_get('slug')])
		mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an error activating this theme.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
		}
	}
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('This product has been activated.'), rt.new_string('woocommerce')]) }])])
}

fn Class_WC_Helper_Subscriptions_API.install_url(var_request rt.PhpVal)  {
	mut var_product_key := rt.call_method(var_request, 'get_param', [rt.new_string('product_key')])
	mut var_subscription := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscription(arg_0) }(var_product_key.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subscription)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('We couldn\'t find a subscription for this product.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_subscription.array_get('local').array_get('installed'))) {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('This product is already installed.'), rt.new_string('woocommerce')]) }])])
	}
	mut var_install_url := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_subscription_install_url(arg_0, arg_1) }(var_subscription.array_get('product_key'), var_subscription.array_get('product_slug'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_install_url)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an error getting the install URL for this product.'), rt.new_string('woocommerce')]) }]), rt.new_int(400)])
	}
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'url', val: var_install_url }])])
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_wc_helper_subscriptions_api() &Class_WC_Helper_Subscriptions_API {
	mut obj := &Class_WC_Helper_Subscriptions_API{
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

fn create_wc_helper() &Class_WC_Helper {
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_class_wc_helper_subscriptions_api_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	Class_WC_Helper_Subscriptions_API.load()
}
