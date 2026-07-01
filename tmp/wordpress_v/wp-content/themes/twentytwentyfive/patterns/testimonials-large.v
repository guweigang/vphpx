import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_testimonials_large_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('What people are saying'),
		rt.new_string('Testimonial heading.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('“Superb product and customer service!”'),
		rt.new_string('Sample testimonial.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('_x', [
			rt.new_string('Jo Mulligan <br /><sub>Atlanta, GA</sub>'),
			rt.new_string('Sample testimonial citation.'),
			rt.new_string('twentytwentyfive'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [
		rt.new_string('Picture of a person typing on a typewriter.'),
		rt.new_string('Alt text for testimonial image.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
