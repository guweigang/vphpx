import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_block_customer_failed_order_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Sorry, your order was unsuccessful'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/customer-first-name]-->')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Unfortunately, we couldn\'t complete your order due to an issue with your payment method.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('If you\'d like to continue with your purchase, please return to %s and try a different method of payment.'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/site-title]-->')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Your order details are as follows:'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Thanks again! If you need any help with your order, please contact us at %s.'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/store-email]-->')])
	// unsupported statement: Stmt_InlineHTML
}
