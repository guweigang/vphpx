import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_contact_location_and_link_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Visit us at 123 Example St. Manhattan, NY 10300, United States'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Get directions'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('The business location'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
