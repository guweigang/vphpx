import rt

pub fn init_wp_content_plugins_woocommerce_patterns_hero_product_3_split_php() {
	mut var_main_title := rt.call_function('__', [rt.new_string('New: Retro Glass Jug'),
		rt.new_string('woocommerce')])
	mut var_first_title := rt.call_function('__', [rt.new_string('Timeless elegance'),
		rt.new_string('woocommerce')])
	mut var_second_title := rt.call_function('__', [rt.new_string('Durable glass'),
		rt.new_string('woocommerce')])
	mut var_third_title := rt.call_function('__', [rt.new_string('Versatile charm'),
		rt.new_string('woocommerce')])
	mut var_first_description := rt.call_function('__', [
		rt.new_string('Elevate your table with a 330ml Retro Glass Jug, blending classic design and durable hardened glass.'),
		rt.new_string('woocommerce'),
	])
	mut var_second_description := rt.call_function('__', [
		rt.new_string('Crafted from resilient thick glass, this jug ensures lasting quality, making it perfect for everyday use with a touch of vintage charm.'),
		rt.new_string('woocommerce'),
	])
	mut var_third_description := rt.call_function('__', [
		rt.new_string("The Retro Glass Jug's classic silhouette effortlessly complements any setting, making it the ideal choice for serving beverages with style and flair."),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/drinkware-liquid-tableware-dishware-bottle-fluid.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent a product being showcased.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/drinkware-liquid-tableware-dishware-bottle-fluid.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_main_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop now'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
