import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_footer_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('About'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('About'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Team'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('History'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Careers'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Privacy'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Privacy'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Privacy Policy'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Terms and Conditions'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Contact Us'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Social'), rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Social Media'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Facebook'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Instagram'),
		rt.new_string('twentytwentyfour')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Twitter/X'),
		rt.new_string('twentytwentyfour')])
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
