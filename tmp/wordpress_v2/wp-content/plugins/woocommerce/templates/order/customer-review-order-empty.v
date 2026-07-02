import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_meta(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_reviewed_count := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_Meta{}
	mut iife_result_0 := iife_temp_0.parts_for_order(var_order.clone())
	mut var_meta_parts := iife_result_0
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('implode', [rt.new_string(' · '), var_meta_parts.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(var_reviewed_count, rt.new_int(0))) {
		rt.call_function('esc_html_e', [rt.new_string('Thank you for your reviews'),
			rt.new_string('woocommerce')])
	} else {
		rt.call_function('esc_html_e', [rt.new_string('Nothing to review here'),
			rt.new_string('woocommerce')])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(var_reviewed_count, rt.new_int(0))) {
		rt.call_function('esc_html_e', [
			rt.new_string('Your feedback helps other customers make better purchasing decisions.'),
			rt.new_string('woocommerce'),
		])
	} else {
		rt.call_function('esc_html_e', [
			rt.new_string('There are no products on this order that are open for reviews right now.'),
			rt.new_string('woocommerce'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
}
