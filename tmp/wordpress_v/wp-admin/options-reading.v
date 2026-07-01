import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage options for this site.')])])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Reading Settings')])
	mut var_parent_file := 'options-general.php'
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_string('options_reading_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('This screen contains the settings that affect the display of your content.')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can choose what&#8217;s displayed on the homepage of your site. It can be posts in reverse chronological order (classic blog), or a fixed/static page. To set a static homepage, you first need to create two <a href="%s">Pages</a>. One will become the homepage, and the other will be where your posts are displayed.')]), rt.new_string('post-new.php?post_type=page')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can also control the display of your content in RSS feeds, including the maximum number of posts to display and whether to show full text or an excerpt. <a href="%s">Learn more about feeds</a>.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/feeds/')])])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('You must click the Save Changes button at the bottom of the screen for new settings to take effect.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'site-visibility' }, rt.ArrayItem{ key: 'title', val: if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) { rt.call_function('__', [rt.new_string('Site visibility')]) } else { rt.call_function('__', [rt.new_string('Search engine visibility')]) } }, rt.ArrayItem{ key: 'content', val: '<p>' + (rt.call_function('__', [rt.new_string('You can choose whether or not your site will be crawled by robots, ping services, and spiders. If you want those services to ignore your site, click the checkbox next to &#8220;Discourage search engines from indexing this site&#8221; and click the Save Changes button at the bottom of the screen.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('Note that even when set to discourage search engines, your site is still visible on the web and not all search engines adhere to this directive.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('When this setting is in effect, a reminder is shown in the At a Glance box of the Dashboard that says, &#8220;Search engines discouraged&#8221;, to remind you that you have directed search engines to not crawl your site.')])).str() + '</p>' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', ['<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/settings-reading-screen/">Documentation on Reading Settings</a>')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() + '</p>'])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('settings_fields', [rt.new_string('reading')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_utf8_charset', []rt.PhpVal{}))))) {
		rt.call_function('add_settings_field', [rt.new_string('blog_charset'), rt.call_function('__', [rt.new_string('Encoding for pages and feeds')]), rt.new_string('options_reading_blog_charset'), rt.new_string('reading'), rt.new_string('default'), rt.create_array([rt.ArrayItem{ key: 'label_for', val: 'blog_charset' }])])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_pages', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('update_option', [rt.new_string('show_on_front'), rt.new_string('posts')])
		}
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('page_for_posts')]))))))) {
			rt.call_function('update_option', [rt.new_string('show_on_front'), rt.new_string('posts')])
		}
		mut var_your_homepage_displays_title := rt.call_function('__', [rt.new_string('Your homepage displays')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_your_homepage_displays_title)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_your_homepage_displays_title)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('posts'), rt.call_function('get_option', [rt.new_string('show_on_front')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Your latest posts')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('A <a href="%s">static page</a> (select below)')]), rt.new_string('edit.php?post_type=page')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Homepage: %s')]), rt.call_function('wp_dropdown_pages', [rt.create_array([rt.ArrayItem{ key: 'name', val: 'page_on_front' }, rt.ArrayItem{ key: 'echo', val: 0 }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [rt.new_string('&mdash; Select &mdash;')]) }, rt.ArrayItem{ key: 'option_none_value', val: '0' }, rt.ArrayItem{ key: 'selected', val: rt.call_function('get_option', [rt.new_string('page_on_front')]) }])])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Posts page: %s')]), rt.call_function('wp_dropdown_pages', [rt.create_array([rt.ArrayItem{ key: 'name', val: 'page_for_posts' }, rt.ArrayItem{ key: 'echo', val: 0 }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [rt.new_string('&mdash; Select &mdash;')]) }, rt.ArrayItem{ key: 'option_none_value', val: '0' }, rt.ArrayItem{ key: 'selected', val: rt.call_function('get_option', [rt.new_string('page_for_posts')]) }])])])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('page_for_posts')]), rt.call_function('get_option', [rt.new_string('page_on_front')]))))) {
			rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('<strong>Warning:</strong> these pages should not be the same!')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'id', val: 'front-page-warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inline' }]) }])])
		}
		mut var_privacy_policy_page := rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])
		if rt.is_true(rt.new_bool(rt.is_true(var_privacy_policy_page) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('page_for_posts')]), var_privacy_policy_page)) || rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('page_on_front')]), var_privacy_policy_page)))))) {
			rt.call_function('wp_admin_notice', [rt.call_function('__', [rt.new_string('<strong>Warning:</strong> these pages should not be the same as your Privacy Policy page!')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'id', val: 'privacy-policy-page-warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inline' }]) }])])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Blog pages show at most')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('posts_per_page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('posts')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Syndication feeds show the most recent')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('form_option', [rt.new_string('posts_per_rss')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('items')])
	// unsupported statement: Stmt_InlineHTML
	mut var_rss_use_excerpt_title := rt.call_function('__', [rt.new_string('For each post in a feed, include')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_rss_use_excerpt_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_rss_use_excerpt_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_int(0), rt.call_function('get_option', [rt.new_string('rss_use_excerpt')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Full text')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_int(1), rt.call_function('get_option', [rt.new_string('rss_use_excerpt')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Excerpt')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Your theme determines how content is displayed in browsers. <a href="%s">Learn more about feeds</a>.')]), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/feeds/')])])
	// unsupported statement: Stmt_InlineHTML
	mut var_blog_privacy_selector_title := if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) { rt.call_function('__', [rt.new_string('Site visibility')]) } else { rt.call_function('__', [rt.new_string('Search engine visibility')]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_blog_privacy_selector_title)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('has_action', [rt.new_string('blog_privacy_selector')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('1'), rt.call_function('get_option', [rt.new_string('blog_public')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Allow search engines to index this site')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('0'), rt.call_function('get_option', [rt.new_string('blog_public')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Discourage search engines from indexing this site')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Note: Neither of these options blocks access to your site &mdash; it is up to search engines to honor your request.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('blog_privacy_selector')])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_string('0'), rt.call_function('get_option', [rt.new_string('blog_public')])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Discourage search engines from indexing this site')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('It is up to search engines to honor this request.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_fields', [rt.new_string('reading'), rt.new_string('default')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_settings_sections', [rt.new_string('reading')])
	// unsupported statement: Stmt_InlineHTML
	
}
