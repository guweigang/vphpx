import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_event_rsvp_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('_x', [
			rt.new_string('“Stories, <span lang="es">historias</span>, <span lang="uk">iсторії</span>, <span lang="el">iστορίες</span>”'),
			rt.new_string('Placeholder heading in four languages.'),
			rt.new_string('twentytwentyfive'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Mon, Jan 1'),
		rt.new_string('Example event date in pattern.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Free Workshop'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('This immersive event celebrates the universal human experience through the lenses of history and ancestry, featuring a diverse array of photographers whose works capture the essence of different cultures and historical moments.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('RSVP'),
		rt.new_string('Abbreviation for "Please respond".'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Close up photo of white flowers on a grey background'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
}
