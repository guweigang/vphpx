import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_404_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Page Not Found'),
		rt.new_string('Heading for a webpage that is not found'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('The page you are looking for does not exist, or it has been moved. Please try searching using the form below.'),
		rt.new_string('Message to convey that a webpage could not be found'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
