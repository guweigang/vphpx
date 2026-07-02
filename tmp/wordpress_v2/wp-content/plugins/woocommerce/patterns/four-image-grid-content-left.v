import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_header := rt.call_function('__', [rt.new_string('Create anything'),
		rt.new_string('woocommerce')])
	mut var_content := rt.call_function('__', [
		rt.new_string("Navigating life's intricate fabric, choices unfold paths to the extraordinary, demanding creativity, curiosity, and courage for a truly fulfilling journey."),
		rt.new_string('woocommerce'),
	])
	mut var_button := rt.call_function('__', [rt.new_string('Get Started'),
		rt.new_string('woocommerce')])
	mut var_image_0 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/sun-glass-vase-green-ceramic-shelf.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image_1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/white-vase-decoration-pattern-ceramic-lamp.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image_2 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/plant-white-leaf-flower-vase-green.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image_3 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/tree-branch-plant-wood-leaf-flower.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_content.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_0.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_3.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
