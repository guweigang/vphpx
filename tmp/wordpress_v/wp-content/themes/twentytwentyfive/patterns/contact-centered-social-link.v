import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_contact_centered_social_link_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('_x', [
			rt.new_string('Got questions? <br><a href="#" rel="nofollow">Feel free to reach out.</a>'),
			rt.new_string('Heading of the Contact social link pattern'),
			rt.new_string('twentytwentyfive'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
