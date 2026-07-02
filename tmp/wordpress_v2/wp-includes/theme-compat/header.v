import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_withcomments := rt.new_null()
	rt.call_function('_deprecated_file', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Theme without %s')]),
			rt.call_function('basename', [rt.new_string(@FILE)]),
		]),
		rt.new_string('3.0.0'),
		rt.new_null(),
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Please include a %s template in your theme.')]),
			rt.call_function('basename', [rt.new_string(@FILE)]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_get_document_title', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('stylesheet_url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('pingback_url')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() +
			'/images/kubrickbgwide.jpg'),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		if !rt.is_true(var_withcomments)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('stylesheet_directory')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('text_direction')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo', [rt.new_string('stylesheet_directory')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('comment-reply')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_head', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('home_url', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
}
