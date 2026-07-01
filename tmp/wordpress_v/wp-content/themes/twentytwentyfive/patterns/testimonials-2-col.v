import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_testimonials_2_col_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Picture of a person'),
		rt.new_string('Alt text for testimonial image.'), rt.new_string('twentytwentyfive')]))
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
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Picture of a person'),
		rt.new_string('Alt text for testimonial image.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('“Amazing quality and care. I love all your products.”'),
		rt.new_string('Sample testimonial.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('_x', [
			rt.new_string('Otto Reid <br><sub>Springfield, IL</sub>'),
			rt.new_string('Sample testimonial citation.'),
			rt.new_string('twentytwentyfive'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
