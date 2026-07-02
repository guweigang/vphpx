import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_image1 := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/table-wood-house-chair-floor-window.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	mut var_category_title := rt.call_function('__', [
		rt.new_string('Sit back and relax'),
		rt.new_string('woocommerce'),
	])
	mut var_description := rt.call_function('__', [
		rt.new_string('With a wide range of designer chairs to elevate your living space.'),
		rt.new_string('woocommerce'),
	])
	mut var_button := rt.call_function('__', [rt.new_string('Shop chairs'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_image1.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_category_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
