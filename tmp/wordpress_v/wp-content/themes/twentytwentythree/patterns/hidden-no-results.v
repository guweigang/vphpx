import rt

pub fn init_wp_content_themes_twentytwentythree_patterns_hidden_no_results_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Sorry, but nothing matched your search terms. Please try again with some different keywords.'),
		rt.new_string('Message explaining that there are no results returned from a search'),
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
