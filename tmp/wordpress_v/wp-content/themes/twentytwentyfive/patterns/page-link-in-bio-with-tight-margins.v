import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_page_link_in_bio_with_tight_margins_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Black and white photo focusing on a woman and a child from afar.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('I’m Asahachi Kōno, a Japanese photographer, a member of Los Angeles’s Japanese Camera Pictorialists of California. Before returning to Japan, I worked as a photo retoucher.'),
		rt.new_string('twentytwentyfive'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Instagram'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('X'),
		rt.new_string('Refers to the social media platform formerly known as Twitter.'),
		rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('TikTok'), rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
