import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_page_newsletter_landing_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Subscribe to the newsletter and stay connected with our community'),
		rt.new_string('sample content for newsletter subscription'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Sign up'),
		rt.new_string('Sample content for newsletter subscribe button'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
