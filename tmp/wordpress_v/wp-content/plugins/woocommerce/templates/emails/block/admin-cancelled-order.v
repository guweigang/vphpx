import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_block_admin_cancelled_order_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Canceled order: #%s,'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/order-number]-->')])
	// unsupported statement: Stmt_InlineHTML
	mut var_text := rt.call_function('__', [rt.new_string('We’re getting in touch to let you know that order #%1$s from %2$s has been cancelled.'), rt.new_string('woocommerce')])
	rt.call_function('printf', [rt.call_function('esc_html', [var_text.dup()]), rt.new_string('<!--[woocommerce/order-number]-->'), rt.new_string('<!--[woocommerce/customer-full-name]-->')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Thanks for reading.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}
