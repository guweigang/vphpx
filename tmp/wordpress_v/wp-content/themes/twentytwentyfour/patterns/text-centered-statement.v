import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_text_centered_statement_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('__', [
			rt.new_string('<em>Études</em> is not confined to the past—we are passionate about the cutting edge designs shaping our world today.'),
			rt.new_string('twentytwentyfour'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
