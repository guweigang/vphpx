import rt

fn main() {
	defer {
		rt.shutdown()
	}

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
	rt.echo_val(rt.call_function('esc_html', [var_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_content.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image_0.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
