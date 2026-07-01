import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_footer_centered_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Designed with %s'),
			rt.new_string('twentytwentyfive')]),
		'<a href="' +
			(rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org'), rt.new_string('twentytwentyfive')])])).str() +
			'" rel="nofollow">WordPress</a>',
	])
	// unsupported statement: Stmt_InlineHTML
}
