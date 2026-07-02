import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_header := rt.call_function('__', [rt.new_string('Our services'),
		rt.new_string('woocommerce')])
	mut var_product_title := rt.call_function('__', [rt.new_string('Create anything'),
		rt.new_string('woocommerce')])
	mut var_description := rt.call_function('__', [
		rt.new_string("Navigating life's intricate fabric, choices unfold paths to the extraordinary, demanding creativity, curiosity, and courage for a truly fulfilling journey."),
		rt.new_string('woocommerce'),
	])
	mut var_image_0 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/table-wood-house-chair-floor-window.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image_1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/hand-light-architecture-wood-white-house.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_image_2 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/Image-table-wood-chair-stool-interior-restaurant.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_0.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_image_2.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
