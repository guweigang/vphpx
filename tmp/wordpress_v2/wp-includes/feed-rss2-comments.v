import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_comment := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('feed_content_type', [rt.new_string('rss2')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		rt.new_bool(true),
	])
	print('<?xml version="1.0" encoding="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
	rt.call_function('do_action', [rt.new_string('rss_tag_pre'),
		rt.new_string('rss2-comments')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss2_ns')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss2_comments_ns')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		rt.call_function('printf', [
			rt.call_function('ent2ncr', [
				rt.call_function('__', [rt.new_string('Comments on: %s')]),
			]),
			rt.call_function('get_the_title_rss', []rt.PhpVal{}),
		])
	} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		rt.call_function('printf', [
			rt.call_function('ent2ncr', [
				rt.call_function('__', [
					rt.new_string('Comments for %1$s searching on %2$s'),
				]),
			]),
			rt.call_function('get_bloginfo_rss', [
				rt.new_string('name'),
			]),
			rt.call_function('get_search_query', []rt.PhpVal{}),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('ent2ncr', [
				rt.call_function('__', [rt.new_string('Comments for %s')]),
			]),
			rt.call_function('get_wp_title_rss', []rt.PhpVal{}),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('self_link', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_single', []rt.PhpVal{})) {
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
	} else {
		rt.call_function('bloginfo_rss', [rt.new_string('url')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_feed_build_date', [rt.new_string('r')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_period'),
		rt.new_string('hourly')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_frequency'),
		rt.new_string('1')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('commentsrss2_head')])
	for rt.is_true(rt.call_function('have_comments', []rt.PhpVal{})) {
		rt.call_function('the_comment', []rt.PhpVal{})
		mut var_comment_post := rt.call_function('get_post', [
			rt.get_property(var_comment, 'comment_post_ID'),
		])
		var_GLOBALS.array_set('post', var_comment_post.clone())
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
			mut var_title := rt.call_function('get_the_title', [
				rt.get_property(var_comment_post, 'ID'),
			])
			var_title = rt.call_function('apply_filters', [
				rt.new_string('the_title_rss'),
				var_title.clone(),
			])
			rt.call_function('printf', [
				rt.call_function('ent2ncr', [
					rt.call_function('__', [rt.new_string('Comment on %1$s by %2$s')]),
				]),
				var_title.clone(),
				rt.call_function('get_comment_author_rss', []rt.PhpVal{}),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('ent2ncr', [
					rt.call_function('__', [rt.new_string('By: %s')]),
				]),
				rt.call_function('get_comment_author_rss', []rt.PhpVal{}),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_link', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('get_comment_author_rss', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('mysql2date', [
			rt.new_string('D, d M Y H:i:s +0000'),
			rt.call_function('get_comment_time', [rt.new_string('Y-m-d H:i:s'),
				rt.new_bool(true), rt.new_bool(false)]),
			rt.new_bool(false),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_guid', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_password_required', [
			var_comment_post.clone()]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('ent2ncr', [
				rt.call_function('__', [
					rt.new_string('Protected Comments: Please enter your password to view comments.'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_the_password_form', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_text_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comment_text', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('commentrss2_item'),
			rt.get_property(var_comment, 'comment_ID'), rt.get_property(var_comment_post, 'ID')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
