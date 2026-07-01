import rt

pub fn init_wp_content_plugins_woocommerce_templates_brands_brand_description_php() {
	mut var_thumbnail := rt.new_null()
	// unsupported statement: Stmt_Declare
	mut var_image_size := rt.call_function('wc_get_image_size', [
		rt.new_string('shop_catalog'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_thumbnail) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_thumbnail.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_image_size.array_get('width')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('do_shortcode', [
		rt.call_function('wpautop', [
			rt.call_function('wptexturize', [
				rt.call_function('term_description', []rt.PhpVal{}),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
