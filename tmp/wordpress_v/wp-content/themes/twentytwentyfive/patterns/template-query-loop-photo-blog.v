import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_template_query_loop_photo_blog_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Sorry, but nothing was found. Please try a search with different keywords.'),
		rt.new_string('Message explaining that there are no results returned from a search.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
