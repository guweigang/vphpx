import rt

pub fn init_wp_content_plugins_woocommerce_patterns_no_products_found_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('No products were found matching your selection.'),
		rt.new_string('Message explaining that there are no products returned from a search'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
