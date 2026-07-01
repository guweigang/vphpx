import rt

pub fn init_wp_content_plugins_woocommerce_templates_checkout_form_checkout_php() {
	mut var_checkout := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_checkout_form'),
		var_checkout.dup()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_checkout, 'is_registration_enabled', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(var_checkout, 'is_registration_required', []rt.PhpVal{}))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))))
	{
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_checkout_must_be_logged_in_message'),
				rt.call_function('__', [
					rt.new_string('You must be logged in to checkout.'),
					rt.new_string('woocommerce'),
				]),
			]),
		]))
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_checkout_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Checkout'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_checkout, 'get_checkout_fields', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_before_customer_details'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_billing')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_shipping')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_checkout_after_customer_details'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_before_order_review_heading'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Your order'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_before_order_review'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_order_review')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_checkout_after_order_review'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_checkout_form'),
		var_checkout.dup()])
}
