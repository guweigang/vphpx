import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_banner_hero_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('A commitment to innovation and sustainability'),
		rt.new_string('Heading of the hero section'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Études is a pioneering firm that seamlessly merges creativity and functionality to redefine architectural excellence.'),
		rt.new_string('Content of the hero section'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('About us'),
		rt.new_string('Button text of the hero section'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Building exterior in Toronto, Canada'),
		rt.new_string('twentytwentyfour'),
	])
	// unsupported statement: Stmt_InlineHTML
}
