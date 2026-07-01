import rt

pub fn init_wp_content_plugins_woocommerce_patterns_product_collection_4_columns_php() {
	mut var_products_title := rt.call_function('__', [rt.new_string('Staff picks'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_products_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
