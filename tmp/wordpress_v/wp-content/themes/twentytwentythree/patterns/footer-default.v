import rt

pub fn init_wp_content_themes_twentytwentythree_patterns_footer_default_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Proudly powered by %s'),
			rt.new_string('twentytwentythree')]),
		'<a href="' +
			(rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org'), rt.new_string('twentytwentythree')])])).str() +
			'" rel="nofollow">WordPress</a>',
	])
	// unsupported statement: Stmt_InlineHTML
}
