import rt



pub fn init_wp_content_plugins_woocommerce_templates_loop_no_products_found_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_print_notice', [rt.call_function('esc_html__', [rt.new_string('No products were found matching your selection.'), rt.new_string('woocommerce')]), rt.new_string('notice')])
	// unsupported statement: Stmt_InlineHTML
}
