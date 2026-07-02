import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_print_notice', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_checkout_coupon_message'),
			rt.new_string(
				(rt.call_function('esc_html__', [rt.new_string('Have a coupon?'), rt.new_string('woocommerce')])).str() +
				' <a href="#" role="button" aria-label="' +
				(rt.call_function('esc_attr__', [rt.new_string('Enter your coupon code'), rt.new_string('woocommerce')])).str() +
				'" aria-controls="woocommerce-checkout-form-coupon" aria-expanded="false" class="showcoupon">' +
				(rt.call_function('esc_html__', [rt.new_string('Click here to enter your code'), rt.new_string('woocommerce')])).str() +
				'</a>'),
		]),
		rt.new_string('notice'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Coupon:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Coupon code'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button'),
		]))
		{
			' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
		} else {
			''
		}).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Apply coupon'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Apply coupon'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
