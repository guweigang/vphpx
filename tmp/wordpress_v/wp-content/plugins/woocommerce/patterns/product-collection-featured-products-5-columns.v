import rt

pub fn init_wp_content_plugins_woocommerce_patterns_product_collection_featured_products_5_columns_php() {
	mut var_collection_title := rt.call_function('__', [
		rt.new_string('Shop new arrivals'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_collection_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop All'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
