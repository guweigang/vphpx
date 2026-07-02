import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('feed_content_type', [rt.new_string('atom')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		rt.new_bool(true),
	])
	mut var_more := 1
	print('<?xml version="1.0" encoding="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
	rt.call_function('do_action', [rt.new_string('rss_tag_pre'),
		rt.new_string('atom')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('language')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('atom_ns')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_title_rss', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_feed_build_date', [
		rt.new_string('Y-m-d\\TH:i:s\\Z'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('atom_url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('self_link', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('atom_head')])
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_author', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		mut var_author_url := rt.call_function('get_the_author_meta', [
			rt.new_string('url'),
		])
		if !(!rt.is_true(var_author_url)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_author_meta', [rt.new_string('url')])
			// unsupported statement: Stmt_InlineHTML
		}
		rt.call_function('do_action', [rt.new_string('atom_author')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('html_type_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_title_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('bloginfo_rss', [rt.new_string('html_type')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_guid', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_post_modified_time', [
			rt.new_string('Y-m-d\\TH:i:s\\Z'),
			rt.new_bool(true),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_post_time', [rt.new_string('Y-m-d\\TH:i:s\\Z'),
			rt.new_bool(true)]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_category_rss', [rt.new_string('atom')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('html_type_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_excerpt_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
			rt.new_string('rss_use_excerpt'),
		])))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('html_type_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_permalink_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_content_feed', [rt.new_string('atom')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('atom_enclosure', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('atom_entry')])
		if rt.is_true(rt.call_function('get_comments_number', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('comments_open', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('bloginfo_rss', [rt.new_string('html_type')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_permalink_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_comments_number', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('get_post_comments_feed_link', [
					rt.new_int(0), rt.new_string('atom')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_comments_number', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_comments_number', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
