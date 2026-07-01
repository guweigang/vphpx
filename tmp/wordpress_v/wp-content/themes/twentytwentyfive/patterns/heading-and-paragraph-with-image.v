import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_heading_and_paragraph_with_image_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('About the event'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('Held over a weekend, the event is structured around a series of exhibitions, workshops, and panel discussions. The exhibitions showcase a curated selection of photographs that tell compelling stories from various corners of the globe, each image accompanied by detailed narratives that provide context and deeper insight into the historical significance of the scenes depicted. These photographs are drawn from the archives of renowned photographers, as well as emerging talents, ensuring a blend of both classical and contemporary perspectives.'),
		rt.new_string('Event Overview Text.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		(rt.call_function('get_template_directory_uri', []rt.PhpVal{})).str() +
			'/assets/images/ruins-image.webp',
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Cliff Palace, Colorado'),
		rt.new_string('Alt text for Overview picture.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
}
