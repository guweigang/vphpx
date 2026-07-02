import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_pattern_title := rt.call_function('__', [
		rt.new_string('Sound like no other'),
		rt.new_string('woocommerce'),
	])
	mut var_pattern_description := rt.call_function('__', [
		rt.new_string('Experience your music like never before with our latest generation of hi-fidelity headphones.'),
		rt.new_string('woocommerce'),
	])
	mut var_pattern_button := rt.call_function('__', [rt.new_string('Shop now'),
		rt.new_string('woocommerce')])
	mut var_pattern_image := rt.call_function('plugins_url', [
		rt.new_string('assets/images/pattern-placeholders/man-person-music-black-and-white-white-photography.jpg'),
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_pattern_image.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_pattern_image.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_pattern_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_pattern_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_pattern_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
