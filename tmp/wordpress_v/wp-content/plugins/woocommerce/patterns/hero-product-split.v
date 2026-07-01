import rt

pub fn init_wp_content_plugins_woocommerce_patterns_hero_product_split_php() {
	mut var_hero_title := rt.call_function('__', [
		rt.new_string('Keep dry with 50% off rain jackets'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_hero_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop the sale'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/man-person-winter-photography-statue-coat.png'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent a product being showcased in a hero section.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}
