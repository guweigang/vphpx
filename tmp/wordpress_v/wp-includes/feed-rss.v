import rt

pub fn init_wp_includes_feed_rss_php() {
	rt.call_function('header', [
		'Content-Type: ' + (rt.call_function('feed_content_type', [rt.new_string('rss')])).str() +
			'; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str(),
		rt.new_bool(true),
	])
	mut var_more := 1
	print('<?xml version="1.0" encoding="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_title_rss', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_feed_build_date', [
		rt.new_string('D, d M Y H:i:s +0000'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('language')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss_head')])
	// unsupported statement: Stmt_InlineHTML
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_title_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_excerpt_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('rss_item')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
