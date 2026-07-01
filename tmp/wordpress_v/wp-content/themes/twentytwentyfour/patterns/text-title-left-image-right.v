import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_text_title_left_image_right_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Études offers comprehensive consulting, management, design, and research solutions. Every architectural endeavor is an opportunity to shape the future.'),
		rt.new_string('Headline for the About pattern'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Leaving an indelible mark on the landscape of tomorrow.'),
		rt.new_string('Description for the About pattern'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('About us'),
		rt.new_string('Call to Action button text'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('A ramp along a curved wall in the Kiasma Museu, Helsinki, Finland'),
		rt.new_string('twentytwentyfour'),
	])
	// unsupported statement: Stmt_InlineHTML
}
