import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_show_shipping :=
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(var_order, 'needs_shipping_address', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	if var_show_shipping {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Billing address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_order, 'get_formatted_billing_address', [
			rt.call_function('esc_html__', [rt.new_string('N/A'),
				rt.new_string('woocommerce')]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_details_after_customer_address'),
		rt.new_string('billing'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if var_show_shipping {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shipping address'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_order, 'get_formatted_shipping_address', [
				rt.call_function('esc_html__', [rt.new_string('N/A'),
					rt.new_string('woocommerce')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_details_after_customer_address'),
			rt.new_string('shipping'),
			var_order.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_details_after_customer_details'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}
