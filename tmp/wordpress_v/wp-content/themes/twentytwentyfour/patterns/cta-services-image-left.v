import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_cta_services_image_left_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('White abstract geometric artwork from Dresden, Germany'),
		rt.new_string('twentytwentyfour'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Guiding your business through the project'),
		rt.new_string('Sample heading of the services pattern'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Experience the fusion of imagination and expertise with Études—the catalyst for architectural transformations that enrich the world around us.'),
		rt.new_string('Sample description of the services pattern'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Our services'),
		rt.new_string('Sample button text to view the services'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
