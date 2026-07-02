import rt

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Oops! That embed cannot be found.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('It looks like nothing was found at this location. Maybe try visiting %s directly?'),
		]),
		rt.new_string('<strong><a href="' +
			(rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})])).str() +
			'">' +
			(rt.call_function('esc_html', [rt.call_function('get_bloginfo', [rt.new_string('name')])])).str() +
			'</a></strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('embed_content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_embed_site_title', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
}
