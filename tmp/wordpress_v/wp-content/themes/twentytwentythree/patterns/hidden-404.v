import rt

pub fn init_wp_content_themes_twentytwentythree_patterns_hidden_404_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('404'),
		rt.new_string('Error code for a webpage that is not found.'),
		rt.new_string('twentytwentythree')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('This page could not be found.'),
		rt.new_string('Message to convey that a webpage could not be found'),
		rt.new_string('twentytwentythree'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Search'),
		rt.new_string('label'), rt.new_string('twentytwentythree')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search...'),
		rt.new_string('placeholder for search field'), rt.new_string('twentytwentythree')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search'), rt.new_string('twentytwentythree')])
	// unsupported statement: Stmt_InlineHTML
}
