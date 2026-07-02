import rt

fn main() {
	defer {
		rt.shutdown()
	}

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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('dynamic_sidebar')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('dynamic_sidebar', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('get_search_form', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Author')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_day', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_month', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_year', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_paged', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You are currently browsing the archives for the %s category.'),
					]),
					rt.call_function('single_cat_title', [
						rt.new_string(''),
						rt.new_bool(false),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You are currently browsing the %1$s blog archives for the day %2$s.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s/">%2$s</a>'),
						rt.call_function('get_bloginfo', [rt.new_string('url')]),
						rt.call_function('get_bloginfo', [rt.new_string('name')]),
					]),
					rt.call_function('get_the_time', [
						rt.call_function('__', [rt.new_string('l, F jS, Y')]),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You are currently browsing the %1$s blog archives for %2$s.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s/">%2$s</a>'),
						rt.call_function('get_bloginfo', [rt.new_string('url')]),
						rt.call_function('get_bloginfo', [rt.new_string('name')]),
					]),
					rt.call_function('get_the_time', [
						rt.call_function('__', [rt.new_string('F, Y')]),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You are currently browsing the %1$s blog archives for the year %2$s.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s/">%2$s</a>'),
						rt.call_function('get_bloginfo', [rt.new_string('url')]),
						rt.call_function('get_bloginfo', [rt.new_string('name')]),
					]),
					rt.call_function('get_the_time', [
						rt.new_string('Y'),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You have searched the %1$s blog archives for <strong>&#8216;%2$s&#8217;</strong>. If you are unable to find anything in these search results, you can try one of these links.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s/">%2$s</a>'),
						rt.call_function('get_bloginfo', [rt.new_string('url')]),
						rt.call_function('get_bloginfo', [rt.new_string('name')]),
					]),
					rt.call_function('esc_html', [
						rt.call_function('get_search_query', []rt.PhpVal{}),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('paged'))
				&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('paged')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('You are currently browsing the %s blog archives.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="%1$s/">%2$s</a>'),
						rt.call_function('get_bloginfo', [rt.new_string('url')]),
						rt.call_function('get_bloginfo', [rt.new_string('name')]),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_list_pages', [
			rt.new_string('title_li=<h2>' +
				(rt.call_function('__', [rt.new_string('Pages')])).str() + '</h2>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Archives')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_get_archives', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'monthly' }]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_list_categories', [
			rt.create_array([rt.ArrayItem{ key: 'show_count', val: 1 },
				rt.ArrayItem{ key: 'title_li', val: '<h2>' +
					(rt.call_function('__', [rt.new_string('Categories')])).str() + '</h2>' }]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_list_bookmarks', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Meta')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_register', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_loginout', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_meta', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
