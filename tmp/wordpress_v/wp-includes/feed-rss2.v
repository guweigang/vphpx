import rt

pub fn init_wp_includes_feed_rss2_php() {
	rt.call_function('header', [
		'Content-Type: ' + (rt.call_function('feed_content_type', [rt.new_string('rss2')])).str() +
			'; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str(),
		rt.new_bool(true),
	])
	mut var_more := 1
	print('<?xml version="1.0" encoding="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
	rt.call_function('do_action', [rt.new_string('rss_tag_pre'),
		rt.new_string('rss2')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss2_ns')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_title_rss', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('self_link', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_feed_build_date', [rt.new_string('r')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('language')])
	// unsupported statement: Stmt_InlineHTML
	mut var_duration := 'hourly'
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_period'),
		rt.new_string(var_duration).dup()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_frequency := '1'
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_frequency'),
		rt.new_string(var_frequency).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss2_head')])
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_title_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('get_comments_number', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('comments_open', []rt.PhpVal{}))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('comments_link_feed', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_author', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('mysql2date', [
			rt.new_string('D, d M Y H:i:s +0000'),
			rt.call_function('get_post_time', [rt.new_string('Y-m-d H:i:s'),
				rt.new_bool(true)]),
			rt.new_bool(false),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_category_rss', [rt.new_string('rss2')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_guid', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_option', [rt.new_string('rss_use_excerpt')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_excerpt_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_excerpt_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			mut var_content := rt.call_function('get_the_content_feed', [
				rt.new_string('rss2'),
			])
			// unsupported statement: Stmt_InlineHTML
			if var_content.dup().to_string().len > 0 {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_content)
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('the_excerpt_rss', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.call_function('get_comments_number', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('comments_open', []rt.PhpVal{}))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('get_post_comments_feed_link', [
					rt.new_null(), rt.new_string('rss2')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_comments_number', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('rss_enclosure', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('rss2_item')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
