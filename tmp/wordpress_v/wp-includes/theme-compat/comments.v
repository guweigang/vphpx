import rt

pub fn init_wp_includes_theme_compat_comments_php() {
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
	if rt.is_true(rt.new_bool(
		!(!rt.is_true(rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME')))
		&& rt.is_true(rt.identical(rt.new_string('comments.php'), rt.call_function('basename', [rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME')])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('This post is password protected. Enter the password to view comments.'),
		])
		// unsupported statement: Stmt_InlineHTML
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('have_comments', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_comments_number',
			[]rt.PhpVal{})))
		{
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('One response to %s')]),
				'&#8220;' + (rt.call_function('get_the_title', []rt.PhpVal{})).str() + '&#8221;',
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('_n', [rt.new_string('%1$s response to %2$s'),
					rt.new_string('%1$s responses to %2$s'),
					rt.call_function('get_comments_number',
						[]rt.PhpVal{})]),
				rt.call_function('number_format_i18n', [
					rt.call_function('get_comments_number', []rt.PhpVal{}),
				]),
				'&#8220;' + (rt.call_function('get_the_title', []rt.PhpVal{})).str() + '&#8221;',
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('previous_comments_link', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('next_comments_link', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_list_comments', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('previous_comments_link', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('next_comments_link', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('comments_open', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Comments are closed.')])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_form', []rt.PhpVal{})
}
