import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_image1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/drinkware-liquid-tableware-dishware-bottle-fluid.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image2 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/watch-hand-brand-jewellery-strap-platinum.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image3 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/tree-branch-plant-wood-leaf-flower.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image4 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/road-sport-vintage-wheel-retro-old.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_social_title := rt.call_function('__', [rt.new_string('Stay in the loop'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_social_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased under the social media icons. 1 out of 4.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased under the social media icons. 2 out of 4.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image3.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased under the social media icons. 3 out of 4.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image4.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased under the social media icons. 4 out of 4.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}
