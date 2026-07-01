import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_format_audio_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		(rt.call_function('get_template_directory_uri', []rt.PhpVal{})).str() +
			'/assets/images/ruins-image.webp',
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Event image'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Episode 1: Acoma Pueblo with Prof. Fiona Presley'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Acoma Pueblo, in New Mexico, stands as a testament to the resilience and cultural heritage of the Acoma people'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
}
