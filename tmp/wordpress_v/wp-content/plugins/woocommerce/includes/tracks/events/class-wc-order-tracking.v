import rt

struct Class_WC_Order_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Order_Tracking) init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_order_data_after_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Order_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_order_viewed' }])])
}

fn (mut this Class_WC_Order_Tracking) track_order_viewed(var_order rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	mut var_properties := { 'current_status': rt.call_method(var_order, 'get_status', []rt.PhpVal{}), 'date_created': if rt.is_true(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'format', [Class_DateTime.atom()]) } else { rt.new_string('') }, 'payment_method': rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{}) }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('single_order_view'), var_properties.dup())
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_order_tracking() &Class_WC_Order_Tracking {
	mut obj := &Class_WC_Order_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_order_viewed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_order_viewed(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Order_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_order_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
