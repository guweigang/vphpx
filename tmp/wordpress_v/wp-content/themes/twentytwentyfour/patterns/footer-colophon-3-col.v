import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_footer_colophon_3_col_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Keep up, get in touch.'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Contact'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('info@example.com'),
		rt.new_string('Example email in site footer'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Follow'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Instagram'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Facebook'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('&copy;'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	mut var_wordpress_link := rt.new_string('<a href="' +
		(rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org'), rt.new_string('twentytwentyfour')])])).str() +
		'" rel="nofollow">WordPress</a>')
	rt.echo_val(rt.call_function('sprintf', [
		rt.call_function('esc_html__', [rt.new_string('Designed with %1$s'),
			rt.new_string('twentytwentyfour')]),
		var_wordpress_link.dup(),
	]))
	// unsupported statement: Stmt_InlineHTML
}
