import rt

pub fn init_wp_content_themes_twentytwentythree_patterns_hidden_heading_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Mindblown: a blog about philosophy.'),
		rt.new_string('Main heading for homepage'),
		rt.new_string('twentytwentythree'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
