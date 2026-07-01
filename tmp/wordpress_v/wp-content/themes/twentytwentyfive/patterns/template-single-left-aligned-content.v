import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_template_single_left_aligned_content_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('by'),
		rt.new_string('Prefix before the author name. The post author name is displayed in a separate block.'),
		rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('·'),
		rt.new_string('Separator between date and categories.'),
		rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Post navigation'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Post navigation'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
}
