import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_post_navigation_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Posts'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Posts'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Previous: '),
		rt.new_string('Label before the title of the previous post. There is a space after the colon.'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Next: '),
		rt.new_string('Label before the title of the next post. There is a space after the colon.'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
