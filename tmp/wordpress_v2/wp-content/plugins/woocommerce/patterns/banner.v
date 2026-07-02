import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_banner_title := rt.call_function('__', [rt.new_string('Up to 60% off'),
		rt.new_string('woocommerce')])
	mut var_banner_button := rt.call_function('__', [rt.new_string('Shop vinyl records'),
		rt.new_string('woocommerce')])
	mut var_first_description := rt.call_function('__', [rt.new_string('Holiday Sale'),
		rt.new_string('woocommerce')])
	mut var_second_description := rt.call_function('__', [
		rt.new_string('Get your favorite vinyl at record-breaking prices.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_first_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_banner_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_second_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_banner_button.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/music-needle-turntable-black-and-white-white-photography.jpg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image used to represent products being showcased in a banner.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}
