import rt

struct Class_WC_Coupon_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Coupon_Tracking) init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_coupon_object_updated_props'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Coupon_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_coupon_updated' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Coupon_Tracking) track_coupon_updated(var_coupon rt.PhpVal, var_updated_props rt.PhpVal) {
	mut var_properties := {
		'discount_code':        rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})
		'free_shipping':        rt.call_method(var_coupon, 'get_free_shipping', []rt.PhpVal{})
		'individual_use':       rt.call_method(var_coupon, 'get_individual_use', []rt.PhpVal{})
		'exclude_sale_items':   rt.call_method(var_coupon, 'get_exclude_sale_items', []rt.PhpVal{})
		'usage_limits_applied': rt.new_bool(
			0 < rt.call_method(var_coupon, 'get_usage_limit', []rt.PhpVal{}).to_i64()
			|| 0 < rt.call_method(var_coupon, 'get_usage_limit_per_user', []rt.PhpVal{}).to_i64()
			|| 0 < rt.call_method(var_coupon, 'get_limit_usage_to_x_items', []rt.PhpVal{}).to_i64())
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Tracks{}
		return temp.record_event(arg_0, arg_1)
	}(rt.new_string('coupon_updated'), var_properties.dup())
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_coupon_tracking() &Class_WC_Coupon_Tracking {
	mut obj := &Class_WC_Coupon_Tracking{
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

fn (mut this Class_WC_Coupon_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_coupon_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_coupon_updated(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Coupon_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_coupon_tracking_php() {
}
