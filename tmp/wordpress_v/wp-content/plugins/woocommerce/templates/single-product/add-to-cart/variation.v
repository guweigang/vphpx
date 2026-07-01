import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_add_to_cart_variation_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Sorry, this product is unavailable. Please choose a different combination.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
