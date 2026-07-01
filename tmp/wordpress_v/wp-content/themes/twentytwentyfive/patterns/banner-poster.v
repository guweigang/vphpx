import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_banner_poster_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Picture of a historical building in ruins.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('_x', [
			rt.new_string('“Stories, <span lang="es">historias</span>, <span lang="uk">iсторії</span>, <span lang="el">iστορίες</span>”'),
			rt.new_string('Placeholder heading in four languages.'),
			rt.new_string('twentytwentyfive'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Aug 08—10 2025'),
		rt.new_string('Example event date in pattern.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Fuego Bar, Mexico City'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Let’s hear them.'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('#stories'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
