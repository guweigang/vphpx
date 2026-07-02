import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_image1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/tree-branch-plant-wood-leaf-flower.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image2 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/watch-hand-brand-jewellery-strap-platinum.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image3 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/white-vase-decoration-pattern-ceramic-lamp.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_first_title := rt.call_function('__', [rt.new_string('Home decor'),
		rt.new_string('woocommerce')])
	mut var_second_title := rt.call_function('__', [rt.new_string('Retro photography'),
		rt.new_string('woocommerce')])
	mut var_third_title := rt.call_function('__', [rt.new_string('Handmade gifts'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased in featured categories banner. 1 out of 3.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop Now'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased in featured categories banner. 2 out of 3.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop Now'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image3.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased in featured categories banner. 3 out of 3'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image3.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_third_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shop Now'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
