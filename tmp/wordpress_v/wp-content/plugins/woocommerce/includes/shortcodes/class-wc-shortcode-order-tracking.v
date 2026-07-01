import rt

struct Class_WC_Shortcode_Order_Tracking {
	rt.PhpObjectBase
}

fn Class_WC_Shortcode_Order_Tracking.get(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shortcodes{}; return temp.shortcode_wrapper(arg_0, arg_1) }(rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output' }]), var_atts_mutated.dup())
}

fn Class_WC_Shortcode_Order_Tracking.output(var_atts rt.PhpVal)  {
	mut var_atts_mutated := var_atts
	if rt.is_true(rt.new_bool(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart').is_null())) {
		return rt.new_null()
	}
	var_atts_mutated = rt.call_function('shortcode_atts', [rt.new_array(), var_atts_mutated.dup(), rt.new_string('woocommerce_order_tracking')])
	mut var_nonce_value := rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('woocommerce-order-tracking-nonce'), rt.call_function('wc_get_var', [rt.get_superglobal('_REQUEST').array_get('_wpnonce'), rt.new_string('')])])
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderid')) && rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce_value.dup(), rt.new_string('woocommerce-order_tracking')])))) {
		mut var_order_id := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('orderid')) { rt.new_int(0) } else { rt.new_string(rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('orderid')])]).to_string().trim_left(' \t\n\r')) }
		mut var_order_email := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('order_email')) { rt.new_string('') } else { rt.call_function('sanitize_email', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('order_email')])]) }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
			rt.call_function('wc_print_notice', [rt.call_function('__', [rt.new_string('Please enter a valid order ID'), rt.new_string('woocommerce')]), rt.new_string('error')])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_order_email)))) {
			rt.call_function('wc_print_notice', [rt.call_function('__', [rt.new_string('Please enter a valid email address'), rt.new_string('woocommerce')]), rt.new_string('error')])
		} else {
			mut var_order := rt.call_function('wc_get_order', [rt.call_function('apply_filters', [rt.new_string('woocommerce_shortcode_order_tracking_order_id'), var_order_id.dup()])])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))) && rt.is_true(rt.call_function('is_a', [var_order.dup(), rt.new_string('WC_Order')])))) && rt.is_true(rt.identical(rt.new_string(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}).to_string().to_lower()), rt.new_string(var_order_email.dup().to_string().to_lower()))))) {
				rt.call_function('do_action', [rt.new_string('woocommerce_track_order'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
				rt.call_function('wc_get_template', [rt.new_string('order/tracking.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }])])
				return rt.new_null()
			} else {
				rt.call_function('wc_print_notice', [rt.call_function('__', [rt.new_string('Sorry, the order could not be found. Please contact us if you are having difficulty finding your order details.'), rt.new_string('woocommerce')]), rt.new_string('error')])
			}
		}
	}
	rt.call_function('wc_get_template', [rt.new_string('order/form-tracking.php')])
}

struct Class_WC_Shortcodes {
	rt.PhpObjectBase
}

fn create_wc_shortcode_order_tracking() &Class_WC_Shortcode_Order_Tracking {
	mut obj := &Class_WC_Shortcode_Order_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcodes() &Class_WC_Shortcodes {
	mut obj := &Class_WC_Shortcodes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shortcode_Order_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcode_Order_Tracking.get(dispatch_arg_0)
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Shortcode_Order_Tracking.output(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Shortcode_Order_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Order_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shortcodes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcodes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcodes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_shortcodes_class_wc_shortcode_order_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
