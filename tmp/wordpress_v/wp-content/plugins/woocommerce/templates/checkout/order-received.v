import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_order_received_php() {
	mut var_order := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	mut var_message := rt.call_function('apply_filters', [rt.new_string('woocommerce_thankyou_order_received_text'), rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Thank you. Your order has been received.'), rt.new_string('woocommerce')])]), var_order.dup()])
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
}
