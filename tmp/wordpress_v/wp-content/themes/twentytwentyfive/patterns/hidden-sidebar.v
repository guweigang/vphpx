import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_hidden_sidebar_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Other Posts'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Add text or blocks that will display when a query returns no results.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Sorry, but nothing was found. Please try a search with different keywords.'),
		rt.new_string('Message explaining that there are no results returned from a search.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
