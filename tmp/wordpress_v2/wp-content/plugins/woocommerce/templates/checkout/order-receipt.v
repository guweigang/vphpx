import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order number:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Date:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('wc_format_datetime', [
			rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Payment method:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_receipt_' +
			(rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})).str()),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
}
