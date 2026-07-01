import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_footer_centered_logo_nav_php() {
	// unsupported statement: Stmt_Nop
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
