import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_page_link_in_bio_wide_margins_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Woman on beach, splashing water.'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Nora Winslow Keene'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('I’m Nora, a dedicated public interest attorney based in Denver. I’m a graduate of Stanford University.'),
		rt.new_string('Pattern placeholder text.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
