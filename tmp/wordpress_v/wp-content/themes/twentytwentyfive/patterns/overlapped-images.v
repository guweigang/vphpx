import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_overlapped_images_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Photography close up of a red flower.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Black and white photography close up of a flower.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('About Us'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('%s is a flower delivery and subscription business. Based in the EU, our mission is not only to deliver stunning flower arrangements across but also foster knowledge and enthusiasm on the beautiful gift of nature: flowers.'),
			rt.new_string('twentytwentyfive'),
		]),
		'<strong>' +
			(rt.call_function('esc_html_x', [rt.new_string('Fleurs'), rt.new_string('Example brand name.'), rt.new_string('twentytwentyfive')])).str() +
			'</strong>',
	])
	// unsupported statement: Stmt_InlineHTML
}
