import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_hidden_post_meta_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('by'),
		rt.new_string('Prefix for the post author block: By author name'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('in '),
		rt.new_string('Prefix for the post category block: in category name'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
