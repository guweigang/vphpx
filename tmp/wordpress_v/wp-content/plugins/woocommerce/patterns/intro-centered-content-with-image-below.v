import rt

pub fn init_wp_content_plugins_woocommerce_patterns_intro_centered_content_with_image_below_php() {
	// unsupported statement: Stmt_Declare
	mut var_header := rt.call_function('__', [rt.new_string('Find your shade'),
		rt.new_string('woocommerce')])
	mut var_content := rt.call_function('__', [
		rt.new_string('Explore our exclusive collection of sunglasses, crafted to elevate your look and safeguard your eyes. Find your perfect pair and see the world through a new lens.'),
		rt.new_string('woocommerce'),
	])
	mut var_button := rt.call_function('__', [rt.new_string('Shop now'),
		rt.new_string('woocommerce')])
	mut var_image_0 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/girls-in-the-hills.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_header.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_content.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image_0.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
