import rt

pub fn init_wp_content_themes_twentytwentyfour_patterns_cta_rsvp_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('RSVP'),
		rt.new_string('Name of RSVP pattern'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('RSVP'),
		rt.new_string('Initials for ´please respond´'), rt.new_string('twentytwentyfour')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Experience the fusion of imagination and expertise with Études Arch Summit, February 2025.'),
		rt.new_string('RSVP call to action description'),
		rt.new_string('twentytwentyfour'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Reserve your spot'),
		rt.new_string('Call to action button text for the reservation button'),
		rt.new_string('twentytwentyfour')]))
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
