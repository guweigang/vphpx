import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_hidden_written_by_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Written by '),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('in'), rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
