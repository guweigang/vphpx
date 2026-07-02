import rt

struct Class_WC_Meta_Box_Order_Items {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Order_Items.output(var_post rt.PhpVal) {
	mut var_theorder := rt.new_null()
	mut var_thepostid := rt.get_superglobal('thepostid')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.init_theorder_object(var_post.clone())
	if !(var_thepostid.clone().is_long())
		&& rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
		var_thepostid = rt.get_property(var_post, 'ID')
	}
	mut var_order := var_theorder
	mut var_data := if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) { rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
		]) } else { rt.new_array() }
	rt.include_file(@DIR + '/views/html-order-items.php', '1')
}

fn Class_WC_Meta_Box_Order_Items.save(var_post_id rt.PhpVal) {
	rt.call_function('wc_save_order_items', [var_post_id.clone(),
		rt.get_superglobal('_POST').clone()])
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_wc_meta_box_order_items(_args ...rt.PhpVal) &Class_WC_Meta_Box_Order_Items {
	mut obj := &Class_WC_Meta_Box_Order_Items{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Order_Items) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Items.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Items.save(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Order_Items) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Order_Items) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
