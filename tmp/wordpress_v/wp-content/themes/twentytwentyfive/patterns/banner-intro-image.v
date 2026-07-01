import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_banner_intro_image_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Picture of a flower'),
		rt.new_string('Alt text for intro picture.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('New arrivals'),
		rt.new_string('Heading for banner pattern.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Like flowers that bloom in unexpected places, every story unfolds with beauty and resilience, revealing hidden wonders.'),
		rt.new_string('Sample description for banner with flower.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
