import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_search_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search'),
		rt.new_string('search form label'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search'),
		rt.new_string('search button text'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
