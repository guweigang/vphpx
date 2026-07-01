import rt

pub fn init_wp_content_plugins_woocommerce_patterns_testimonials_single_php() {
	mut var_testimonials_title := rt.call_function('__', [
		rt.new_string('A ‘brewtiful’ experience :-)'),
		rt.new_string('woocommerce'),
	])
	mut var_description := rt.call_function('__', [
		rt.new_string('Exceptional flavors, sustainable choices. The carefully curated collection of coffee pots and accessories turned my kitchen into a haven of style and taste.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('plugins_url', [
			rt.new_string('assets/images/pattern-placeholders/portrait.png'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Placeholder image with the avatar of the user who is writing the testimonial.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_testimonials_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
