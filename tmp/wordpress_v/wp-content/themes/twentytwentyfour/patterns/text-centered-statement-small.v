import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_text_centered_statement_small_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	mut var_about_link := rt.new_string('<a href="#" rel="nofollow">' +
		(rt.call_function('esc_html__', [rt.new_string('Money Studies'), rt.new_string('twentytwentyfour')])).str() +
		'</a>')
	rt.echo_val(rt.call_function('sprintf', [
		rt.call_function('esc_html__', [
			rt.new_string('I write about finance, management and economy, my book “%1$s” is out now.'),
			rt.new_string('twentytwentyfour'),
		]),
		var_about_link.dup(),
	]))
	// unsupported statement: Stmt_InlineHTML
}
