import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post := rt.new_null()
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('feed_content_type', [rt.new_string('rdf')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		rt.new_bool(true),
	])
	mut var_more := 1
	print('<?xml version="1.0" encoding="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"?' + '>')
	rt.call_function('do_action', [rt.new_string('rss_tag_pre'),
		rt.new_string('rdf')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rdf_ns')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_title_rss', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_feed_build_date', [
		rt.new_string('Y-m-d\\TH:i:s\\Z'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_period'),
		rt.new_string('hourly')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('rss_update_frequency'),
		rt.new_string('1')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rdf_header')])
	// unsupported statement: Stmt_InlineHTML
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('rewind_posts', []rt.PhpVal{})
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_title_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_permalink_rss', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_author', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('mysql2date', [rt.new_string('Y-m-d\\TH:i:s\\Z'),
			rt.get_property(var_post, 'post_date_gmt'), rt.new_bool(false)]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_category_rss', [rt.new_string('rdf')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_option', [rt.new_string('rss_use_excerpt')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_excerpt_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_excerpt_rss', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('the_content_feed', [rt.new_string('rdf')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('rdf_item')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
