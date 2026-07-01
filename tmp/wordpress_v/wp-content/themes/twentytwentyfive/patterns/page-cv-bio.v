import rt

pub fn init_wp_content_themes_twentytwentyfive_patterns_page_cv_bio_php() {
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Hey,'),
		rt.new_string('Example heading in pattern.'), rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [
		rt.new_string('My name is Nora Winslow Keene, and I’m a committed public interest attorney. Living in Denver, Colorado, I’ve spent years championing the rights of underrepresented workers. A graduate of Stanford University, I played a key role in securing critical protections for agricultural laborers, ensuring better wages and access to healthcare. My work has focused on advocating for environmental justice and improving the quality of life for rural communities. Every case I take on is driven by the belief that everyone deserves dignity and fair treatment in the workplace.'),
		rt.new_string('Pattern placeholder text.'),
		rt.new_string('twentytwentyfive'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_template_directory_uri', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Woman on beach, splashing water.'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Instagram'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('LinkedIn'),
		rt.new_string('twentytwentyfive')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Now'),
		rt.new_string('Link to a page with information about what the person is working on right now.'),
		rt.new_string('twentytwentyfive')]))
	// unsupported statement: Stmt_InlineHTML
}
