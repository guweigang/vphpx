import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_cta_subscribe_centered_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Join 900+ subscribers'),
		rt.new_string('Sample text for Subscriber Heading with numbers'),
		rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Stay in the loop with everything you need to know.'),
		rt.new_string('Sample text for Subscriber Description'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Sign up'),
		rt.new_string('Sample text for Sign Up Button'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
}
