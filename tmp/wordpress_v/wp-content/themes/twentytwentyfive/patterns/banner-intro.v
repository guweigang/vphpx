import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_banner_intro_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html_x', [
			rt.new_string("We're %s, our mission is to deliver exquisite flower arrangements that not only adorn living spaces but also inspire a deeper appreciation for natural beauty."),
			rt.new_string('Pattern placeholder text.'),
			rt.new_string('twentytwentyfive'),
		]),
		'<strong>' +
			(rt.call_function('esc_html_x', [rt.new_string('Fleurs'), rt.new_string('Example brand name.'), rt.new_string('twentytwentyfive')])).str() +
			'</strong>',
	])
	// unsupported statement: Stmt_InlineHTML
}
