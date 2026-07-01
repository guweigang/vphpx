import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_cart_errors_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('There are some issues with the items in your cart. Please go back to the cart page and resolve these issues before checking out.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_has_errors')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Return to cart'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
