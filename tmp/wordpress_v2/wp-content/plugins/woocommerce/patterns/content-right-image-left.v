import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_header := rt.call_function('__', [
		rt.new_string('Committed to a greener lifestyle'),
		rt.new_string('woocommerce'),
	])
	mut var_content := rt.call_function('__', [
		rt.new_string("Our passion is crafting mindful moments with locally sourced, organic, and sustainable products. We're more than a store; we're your path to a community-driven, eco-friendly lifestyle that embraces premium quality."),
		rt.new_string('woocommerce'),
	])
	mut var_button := rt.call_function('__', [rt.new_string('Meet us'),
		rt.new_string('woocommerce')])
	mut var_image_0 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/drinkware-liquid-tableware-dishware-bottle-fluid.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_0.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_content.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
