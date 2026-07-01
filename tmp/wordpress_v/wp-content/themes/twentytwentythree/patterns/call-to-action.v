import rt

pub fn init_wp_content_themes_twentytwentythree_patterns_call_to_action_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Got any book recommendations?'),
		rt.new_string('sample content for call to action'),
		rt.new_string('twentytwentythree'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Get In Touch'),
		rt.new_string('sample content for call to action button'),
		rt.new_string('twentytwentythree')]))
	// unsupported statement: Stmt_InlineHTML
}
