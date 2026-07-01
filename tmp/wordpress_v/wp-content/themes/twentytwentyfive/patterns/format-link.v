import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_format_link_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('The Stories Book, a fine collection of moments in time featuring photographs from Louis Fleckenstein, Paul Strand and Asahachi Kōno, is available for pre-order'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('https://example.com'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
