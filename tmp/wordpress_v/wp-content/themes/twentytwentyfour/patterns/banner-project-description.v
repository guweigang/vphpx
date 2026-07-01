import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_banner_project_description_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Art Gallery — Overview'),
		rt.new_string('Sample title for a project or post'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string("This transformative project seeks to enhance the gallery's infrastructure, accessibility, and exhibition spaces while preserving its rich cultural heritage."),
		rt.new_string('Sample descriptive text for a project or post.'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Hyatt Regency San Francisco, San Francisco, United States'),
		rt.new_string('twentytwentyfour'),
	])
	// unsupported statement: Stmt_InlineHTML
}
