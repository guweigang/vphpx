import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_hidden_search_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Search'),
		rt.new_string('Search form label.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Type here...'),
		rt.new_string('Search input field placeholder text.'),
		rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search'),
		rt.new_string('Button text. Verb.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
}
