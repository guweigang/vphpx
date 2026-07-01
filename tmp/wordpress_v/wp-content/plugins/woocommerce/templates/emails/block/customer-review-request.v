import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_block_customer_review_request_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Rate your recent purchases'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.new_string('<!--[woocommerce/customer-first-name]-->')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('We’d love to know what you thought of the products you ordered. Your review helps other shoppers make better decisions and helps us improve.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	mut var_order_meta_format := rt.call_function('esc_html__', [rt.new_string('Order #%1$s (%2$s)'), rt.new_string('woocommerce')])
	rt.call_function('printf', [var_order_meta_format.dup(), rt.new_string('<!--[woocommerce/order-number]-->'), rt.new_string('<!--[woocommerce/order-date]-->')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}
