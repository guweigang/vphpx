import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_no_results_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('No posts were found.'),
		rt.new_string('Message explaining that there are no results returned from a search'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
