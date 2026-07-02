import rt

fn wp_install(var_blog_title rt.PhpVal, var_user_name rt.PhpVal, var_user_email rt.PhpVal, var_is_public rt.PhpVal, deprecated string, user_password string, language string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_user_password := user_password
	mut var_language := language
	mut var_guessurl := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_email_password := false
	mut var_user_created := false
	mut var_message := rt.new_null()
	mut var_user := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.6.0')])
	}
	wp_check_mysql_version()
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	make_db_current_silent('')
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_version_check')])
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_update_plugins')])
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_update_themes')])
	rt.call_function('wp_schedule_event', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS')),
		rt.new_string('twicedaily'),
		rt.new_string('wp_version_check'),
	])
	rt.call_function('wp_schedule_event', [
		rt.call_function('time', []rt.PhpVal{}) + 1.5 * rt.get_constant('HOUR_IN_SECONDS'),
		rt.new_string('twicedaily'),
		rt.new_string('wp_update_plugins'),
	])
	rt.call_function('wp_schedule_event', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(2),
			rt.get_constant('HOUR_IN_SECONDS'))),
		rt.new_string('twicedaily'),
		rt.new_string('wp_update_themes'),
	])
	rt.call_function('populate_options', []rt.PhpVal{})
	rt.call_function('populate_roles', []rt.PhpVal{})
	rt.call_function('update_option', [rt.new_string('blogname'),
		var_blog_title.clone()])
	rt.call_function('update_option', [rt.new_string('admin_email'),
		var_user_email.clone()])
	rt.call_function('update_option', [rt.new_string('blog_public'),
		var_is_public.clone()])
	rt.call_function('update_option', [rt.new_string('fresh_site'),
		rt.new_int(1), rt.new_bool(false)])
	if var_language.len > 0 && var_language != '0' {
		rt.call_function('update_option', [rt.new_string('WPLANG'),
			rt.new_string(language)])
	}
	var_guessurl = rt.call_function('wp_guess_url', []rt.PhpVal{})
	rt.call_function('update_option', [rt.new_string('siteurl'),
		var_guessurl.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_public)))) {
		rt.call_function('update_option', [rt.new_string('default_pingback_flag'),
			rt.new_int(0)])
	}
	var_user_id = rt.call_function('username_exists', [var_user_name.clone()])
	var_user_password = var_user_password.trim_space()
	var_email_password = false
	var_user_created = false
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && var_user_password == '' {
		var_user_password = (rt.call_function('wp_generate_password', [
			rt.new_int(12), rt.new_bool(false)])).str()
		var_message = rt.call_function('__', [
			rt.new_string('<strong><em>Note that password</em></strong> carefully! It is a <em>random</em> password that was generated just for you.'),
		])
		var_user_id = rt.call_function('wp_create_user', [var_user_name.clone(),
			rt.new_string(var_user_password.str()), var_user_email.clone()])
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('default_password_nag'), rt.new_bool(true)])
		var_email_password = true
		var_user_created = true
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		var_message = rt.new_string('<em>' +
			(rt.call_function('__', [rt.new_string('Your chosen password.')])).str() + '</em>')
		var_user_id = rt.call_function('wp_create_user', [var_user_name.clone(),
			rt.new_string(var_user_password.str()), var_user_email.clone()])
		var_user_created = true
	} else {
		var_message = rt.call_function('__', [
			rt.new_string('User already exists. Password inherited.'),
		])
	}
	var_user = create_wp_user(var_user_id.clone())
	var_user.set_role(rt.new_string('administrator'))
	if var_user_created {
		rt.set_property(var_user, 'user_url', var_guessurl.clone())
		rt.call_function('wp_update_user', [var_user])
	}
	wp_install_defaults(var_user_id.clone())
	rt.new_bool(wp_install_maybe_enable_pretty_permalinks())
	rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	wp_new_blog_notification(var_blog_title.clone(), var_guessurl.clone(), var_user_id.clone(), if var_email_password { rt.new_string(var_user_password.str()) } else { rt.call_function('__', [
			rt.new_string('The password you chose during installation.'),
		]) })
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('wp_install'), var_user])
	return rt.create_array([rt.ArrayItem{ key: 'url', val: var_guessurl },
		rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{
			key: 'password'
			val: var_user_password
		}, rt.ArrayItem{ key: 'password_message', val: var_message }])
}

fn wp_install_defaults(var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_table_prefix := rt.new_null()
	mut var_cat_name := rt.new_null()
	mut var_cat_slug := rt.new_null()
	mut var_cat_id := i64(0)
	mut var_cat_tt_id := rt.new_null()
	mut var_now := rt.new_null()
	mut var_now_gmt := rt.new_null()
	mut var_first_post_guid := rt.new_null()
	mut var_first_post := rt.new_null()
	mut var_first_comment_author := rt.new_null()
	mut var_first_comment_email := rt.new_null()
	mut var_first_comment_url := rt.new_null()
	mut var_first_comment := rt.new_null()
	mut var_first_page := rt.new_null()
	mut var_privacy_policy_content := rt.new_null()
	mut var_privacy_policy_guid := rt.new_null()
	mut var_user := rt.new_null()
	var_cat_name = rt.call_function('__', [rt.new_string('Uncategorized')])
	var_cat_slug = rt.call_function('sanitize_title', [
		rt.call_function('_x', [rt.new_string('Uncategorized'),
			rt.new_string('Default category slug')]),
	])
	var_cat_id = 1
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'terms'),
		rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_cat_id },
			rt.ArrayItem{ key: 'name', val: var_cat_name }, rt.ArrayItem{
				key: 'slug'
				val: var_cat_slug
			}, rt.ArrayItem{ key: 'term_group', val: 0 }])])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'term_taxonomy'),
		rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_cat_id },
			rt.ArrayItem{ key: 'taxonomy', val: 'category' },
			rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'parent', val: 0 },
			rt.ArrayItem{ key: 'count', val: 1 }])])
	var_cat_tt_id = rt.get_property(var_wpdb, 'insert_id')
	var_now = rt.call_function('current_time', [rt.new_string('mysql')])
	var_now_gmt = rt.call_function('current_time', [rt.new_string('mysql'),
		rt.new_bool(true)])
	var_first_post_guid = rt.new_string(
		(rt.call_function('get_option', [rt.new_string('home')])).str() + '/?p=1')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_first_post = rt.call_function('get_site_option', [
			rt.new_string('first_post'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_first_post)))) {
			var_first_post = rt.new_string('<!-- wp:paragraph -->\n<p>' +
				(rt.call_function('__', [rt.new_string('Welcome to %s. This is your first post. Edit or delete it, then start writing!')])).str() +
				'</p>\n<!-- /wp:paragraph -->')
		}
		var_first_post = rt.call_function('sprintf', [var_first_post.clone(),
			rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('network_home_url', []rt.PhpVal{}),
				]),
				rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')])])
		var_first_post = rt.call_function('str_replace', [rt.new_string('SITE_URL'),
			rt.call_function('esc_url', [
				rt.call_function('network_home_url', []rt.PhpVal{}),
			]),
			var_first_post.clone()])
		var_first_post = rt.call_function('str_replace', [rt.new_string('SITE_NAME'),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
			var_first_post.clone()])
	} else {
		var_first_post = rt.new_string('<!-- wp:paragraph -->\n<p>' +
			(rt.call_function('__', [rt.new_string('Welcome to WordPress. This is your first post. Edit or delete it, then start writing!')])).str() +
			'</p>\n<!-- /wp:paragraph -->')
	}
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'posts'),
		rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id },
			rt.ArrayItem{ key: 'post_date', val: var_now }, rt.ArrayItem{
				key: 'post_date_gmt'
				val: var_now_gmt
			}, rt.ArrayItem{ key: 'post_content', val: var_first_post },
			rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [
				rt.new_string('Hello world!'),
			]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('sanitize_title', [
				rt.call_function('_x', [rt.new_string('hello-world'),
					rt.new_string('Default post slug')]),
			]) }, rt.ArrayItem{ key: 'post_modified', val: var_now },
			rt.ArrayItem{ key: 'post_modified_gmt', val: var_now_gmt },
			rt.ArrayItem{ key: 'guid', val: var_first_post_guid },
			rt.ArrayItem{ key: 'comment_count', val: 1 }, rt.ArrayItem{ key: 'to_ping', val: '' },
			rt.ArrayItem{ key: 'pinged', val: '' }, rt.ArrayItem{
				key: 'post_content_filtered'
				val: ''
			}])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('update_posts_count', []rt.PhpVal{})
	}
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'term_relationships'),
		rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_cat_tt_id },
			rt.ArrayItem{ key: 'object_id', val: 1 }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_first_comment_author = rt.call_function('get_site_option', [
			rt.new_string('first_comment_author'),
		])
		var_first_comment_email = rt.call_function('get_site_option', [
			rt.new_string('first_comment_email'),
		])
		var_first_comment_url = rt.call_function('get_site_option', [
			rt.new_string('first_comment_url'),
			rt.call_function('network_home_url', []rt.PhpVal{}),
		])
		var_first_comment = rt.call_function('get_site_option', [
			rt.new_string('first_comment'),
		])
	}
	var_first_comment_author = if !(!rt.is_true(var_first_comment_author)) { var_first_comment_author } else { rt.call_function('__', [
			rt.new_string('A WordPress Commenter'),
		]) }
	var_first_comment_email = if !(!rt.is_true(var_first_comment_email)) {
		var_first_comment_email
	} else {
		rt.new_string('wapuu@wordpress.example')
	}
	var_first_comment_url = if !(!rt.is_true(var_first_comment_url)) { var_first_comment_url } else { rt.call_function('esc_url', [
			rt.call_function('__', [rt.new_string('https://wordpress.org/')]),
		]) }
	var_first_comment = if !(!rt.is_true(var_first_comment)) { var_first_comment } else { rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href="%s">Gravatar</a>.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('__', [rt.new_string('https://gravatar.com/')]),
			]),
		]) }
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'comments'),
		rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: 1 },
			rt.ArrayItem{ key: 'comment_author', val: var_first_comment_author },
			rt.ArrayItem{ key: 'comment_author_email', val: var_first_comment_email },
			rt.ArrayItem{ key: 'comment_author_url', val: var_first_comment_url },
			rt.ArrayItem{ key: 'comment_date', val: var_now },
			rt.ArrayItem{ key: 'comment_date_gmt', val: var_now_gmt },
			rt.ArrayItem{ key: 'comment_content', val: var_first_comment },
			rt.ArrayItem{ key: 'comment_type', val: 'comment' }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_first_page = rt.call_function('get_site_option', [
			rt.new_string('first_page'),
		])
	}
	if !rt.is_true(var_first_page) {
		var_first_page = rt.new_string('<!-- wp:paragraph -->\n<p>')
		var_first_page = rt.concat(var_first_page, rt.call_function('__', [
			rt.new_string("This is an example page. It's different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:"),
		]))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('</p>\n<!-- /wp:paragraph -->\n\n'))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('<!-- wp:quote -->\n<blockquote class="wp-block-quote">\n<!-- wp:paragraph -->\n<p>'))
		var_first_page = rt.concat(var_first_page, rt.call_function('__', [
			rt.new_string("Hi there! I'm a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin' caught in the rain.)"),
		]))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('</p>\n<!-- /wp:paragraph -->\n</blockquote>\n<!-- /wp:quote -->\n\n'))
		var_first_page = rt.concat(var_first_page, rt.new_string('<!-- wp:paragraph -->\n<p>'))
		var_first_page = rt.concat(var_first_page, rt.call_function('__', [
			rt.new_string('...or something like this:'),
		]))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('</p>\n<!-- /wp:paragraph -->\n\n'))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('<!-- wp:quote -->\n<blockquote class="wp-block-quote">\n<!-- wp:paragraph -->\n<p>'))
		var_first_page = rt.concat(var_first_page, rt.call_function('__', [
			rt.new_string('The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.'),
		]))
		var_first_page = rt.concat(var_first_page,
			rt.new_string('</p>\n<!-- /wp:paragraph -->\n</blockquote>\n<!-- /wp:quote -->\n\n'))
		var_first_page = rt.concat(var_first_page, rt.new_string('<!-- wp:paragraph -->\n<p>'))
		var_first_page = rt.concat(var_first_page, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('As a new WordPress user, you should go to <a href="%s">your dashboard</a> to delete this page and create new pages for your content. Have fun!'),
			]),
			rt.call_function('admin_url', []rt.PhpVal{}),
		]))
		var_first_page = rt.concat(var_first_page, rt.new_string('</p>\n<!-- /wp:paragraph -->'))
	}
	var_first_post_guid = rt.new_string(
		(rt.call_function('get_option', [rt.new_string('home')])).str() + '/?page_id=2')
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'posts'),
		rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id },
			rt.ArrayItem{ key: 'post_date', val: var_now }, rt.ArrayItem{
				key: 'post_date_gmt'
				val: var_now_gmt
			}, rt.ArrayItem{ key: 'post_content', val: var_first_page },
			rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{
				key: 'comment_status'
				val: 'closed'
			}, rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [
				rt.new_string('Sample Page'),
			]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('__', [
				rt.new_string('sample-page'),
			]) }, rt.ArrayItem{ key: 'post_modified', val: var_now },
			rt.ArrayItem{ key: 'post_modified_gmt', val: var_now_gmt },
			rt.ArrayItem{ key: 'guid', val: var_first_post_guid },
			rt.ArrayItem{ key: 'post_type', val: 'page' }, rt.ArrayItem{ key: 'to_ping', val: '' },
			rt.ArrayItem{ key: 'pinged', val: '' }, rt.ArrayItem{
				key: 'post_content_filtered'
				val: ''
			}])])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'postmeta'),
		rt.create_array([rt.ArrayItem{ key: 'post_id', val: 2 },
			rt.ArrayItem{ key: 'meta_key', val: '_wp_page_template' },
			rt.ArrayItem{ key: 'meta_value', val: 'default' }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_privacy_policy_content = rt.call_function('get_site_option', [
			rt.new_string('default_privacy_policy_content'),
		])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
			rt.new_string('WP_Privacy_Policy_Content'),
		])))))
		{
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-privacy-policy-content.php',
				'4')
		}
		mut iife_temp_0 := Class_WP_Privacy_Policy_Content{}
		mut iife_result_0 := iife_temp_0.get_default_content()
		var_privacy_policy_content = iife_result_0
	}
	if !(!rt.is_true(var_privacy_policy_content)) {
		var_privacy_policy_guid = rt.new_string(
			(rt.call_function('get_option', [rt.new_string('home')])).str() + '/?page_id=3')
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id },
				rt.ArrayItem{ key: 'post_date', val: var_now },
				rt.ArrayItem{ key: 'post_date_gmt', val: var_now_gmt },
				rt.ArrayItem{ key: 'post_content', val: var_privacy_policy_content },
				rt.ArrayItem{ key: 'post_excerpt', val: '' },
				rt.ArrayItem{ key: 'comment_status', val: 'closed' },
				rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [
					rt.new_string('Privacy Policy'),
				]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('__', [
					rt.new_string('privacy-policy'),
				]) }, rt.ArrayItem{ key: 'post_modified', val: var_now },
				rt.ArrayItem{ key: 'post_modified_gmt', val: var_now_gmt },
				rt.ArrayItem{ key: 'guid', val: var_privacy_policy_guid },
				rt.ArrayItem{ key: 'post_type', val: 'page' },
				rt.ArrayItem{ key: 'post_status', val: 'draft' },
				rt.ArrayItem{ key: 'to_ping', val: '' }, rt.ArrayItem{ key: 'pinged', val: '' },
				rt.ArrayItem{ key: 'post_content_filtered', val: '' }])])
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'postmeta'),
			rt.create_array([rt.ArrayItem{ key: 'post_id', val: 3 },
				rt.ArrayItem{ key: 'meta_key', val: '_wp_page_template' },
				rt.ArrayItem{ key: 'meta_value', val: 'default' }])])
		rt.call_function('update_option', [rt.new_string('wp_page_for_privacy_policy'),
			rt.new_int(3)])
	}
	rt.call_function('update_option', [rt.new_string('widget_block'),
		rt.create_array([
			rt.ArrayItem{ key: 2, val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: '<!-- wp:search /-->' },
			]) },
			rt.ArrayItem{ key: 3, val: rt.create_array([
				rt.ArrayItem{ key: 'content', val:
					'<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>' +
					(rt.call_function('__', [rt.new_string('Recent Posts')])).str() +
					'</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->' },
			]) },
			rt.ArrayItem{ key: 4, val: rt.create_array([
				rt.ArrayItem{
					key: 'content'
					val: '<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>' +
						(rt.call_function('__', [rt.new_string('Recent Comments')])).str() +
						'</h2><!-- /wp:heading --><!-- wp:latest-comments {"displayAvatar":false,"displayDate":false,"displayExcerpt":false} /--></div><!-- /wp:group -->'
				},
			]) },
			rt.ArrayItem{ key: 5, val: rt.create_array([
				rt.ArrayItem{ key: 'content', val:
					'<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>' +
					(rt.call_function('__', [rt.new_string('Archives')])).str() +
					'</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->' },
			]) },
			rt.ArrayItem{ key: 6, val: rt.create_array([
				rt.ArrayItem{ key: 'content', val:
					'<!-- wp:group --><div class="wp-block-group"><!-- wp:heading --><h2>' +
					(rt.call_function('__', [rt.new_string('Categories')])).str() +
					'</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->' },
			]) },
			rt.ArrayItem{ key: '_multiwidget', val: 1 },
		])])
	rt.call_function('update_option', [rt.new_string('sidebars_widgets'),
		rt.create_array([rt.ArrayItem{ key: 'wp_inactive_widgets', val: rt.new_array() },
			rt.ArrayItem{ key: 'sidebar-1', val: rt.create_array([
				rt.ArrayItem{ key: 0, val: 'block-2' },
				rt.ArrayItem{ key: 1, val: 'block-3' },
				rt.ArrayItem{ key: 2, val: 'block-4' },
			]) }, rt.ArrayItem{ key: 'sidebar-2', val: rt.create_array([
				rt.ArrayItem{ key: 0, val: 'block-5' },
				rt.ArrayItem{ key: 1, val: 'block-6' },
			]) }, rt.ArrayItem{ key: 'array_version', val: 3 }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('show_welcome_panel'), rt.new_int(1)])
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_super_admin', [var_user_id.clone()])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string('user'), var_user_id.clone(), rt.new_string('show_welcome_panel')]))))) {
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('show_welcome_panel'), rt.new_int(2)])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_method(var_wp_rewrite, 'init', []rt.PhpVal{})
		rt.call_method(var_wp_rewrite, 'flush_rules', []rt.PhpVal{})
		var_user = create_wp_user(var_user_id.clone())
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'options'),
			rt.create_array([
				rt.ArrayItem{ key: 'option_value', val: rt.get_property(var_user, 'user_email') },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'option_name', val: 'admin_email' },
			])])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(' WHERE user_id != %d AND meta_key = %s')),
				var_user_id.clone(),
				rt.new_string(var_table_prefix.str() + 'user_level'),
			]),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(' WHERE user_id != %d AND meta_key = %s')),
				var_user_id.clone(),
				rt.new_string(var_table_prefix.str() + 'capabilities'),
			]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_super_admin', [var_user_id.clone()])))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_user_id)))) {
			rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'usermeta'),
				rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id },
					rt.ArrayItem{ key: 'meta_key', val:
						(rt.get_property(var_wpdb, 'base_prefix')).str() + '1_capabilities' }])])
		}
	}
}

fn wp_install_maybe_enable_pretty_permalinks() bool {
	mut var_wp_rewrite := rt.new_null()
	mut var_permalink_structures := []rt.PhpVal{}
	mut var_permalink_structure := rt.new_null()
	mut var_test_url := rt.new_null()
	mut var_first_post := rt.new_null()
	mut var_response := rt.new_null()
	mut var_x_pingback_header := rt.new_null()
	mut var_pretty_permalinks := false
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		return true
	}
	var_permalink_structures = ['/%year%/%monthnum%/%day%/%postname%/',
		'/index.php/%year%/%monthnum%/%day%/%postname%/']
	mut iter_1 := rt.cast_array(var_permalink_structures).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_permalink_structure_shadow := item_1.val
		rt.call_method(var_wp_rewrite, 'set_permalink_structure', [
			var_permalink_structure_shadow.clone()])
		rt.call_method(var_wp_rewrite, 'flush_rules', [rt.new_bool(true)])
		var_test_url = rt.new_string('')
		var_first_post = rt.call_function('get_page_by_path', [
			rt.call_function('sanitize_title', [
				rt.call_function('_x', [rt.new_string('hello-world'),
					rt.new_string('Default post slug')]),
			]),
			rt.get_constant('OBJECT'),
			rt.new_string('post'),
		])
		if rt.is_true(var_first_post) {
			var_test_url = rt.call_function('get_permalink', [
				rt.get_property(var_first_post, 'ID'),
			])
		}
		var_response = rt.call_function('wp_remote_get', [var_test_url.clone(),
			rt.create_array([rt.ArrayItem{ key: 'timeout', val: 5 }])])
		var_x_pingback_header = rt.call_function('wp_remote_retrieve_header', [
			var_response.clone(),
			rt.new_string('X-Pingback'),
		])
		var_pretty_permalinks = rt.is_true(var_x_pingback_header)
			&& rt.is_true(rt.identical(rt.call_function('get_bloginfo', [rt.new_string('pingback_url')]), var_x_pingback_header))
		if var_pretty_permalinks {
			return true
		}
	}
	rt.call_method(var_wp_rewrite, 'set_permalink_structure', [
		rt.new_string('')])
	rt.call_method(var_wp_rewrite, 'flush_rules', [rt.new_bool(true)])
	return false
}

fn wp_new_blog_notification(var_blog_title rt.PhpVal, var_blog_url rt.PhpVal, var_user_id rt.PhpVal, var_password rt.PhpVal) {
	mut var_user := rt.new_null()
	mut var_email := rt.new_null()
	mut var_name := rt.new_null()
	mut var_login_url := rt.new_null()
	mut var_message := rt.new_null()
	mut var_installed_email := rt.new_null()
	var_user = create_wp_user(var_user_id.clone())
	var_email = rt.get_property(var_user, 'user_email')
	var_name = rt.get_property(var_user, 'user_login')
	var_login_url = rt.call_function('wp_login_url', []rt.PhpVal{})
	var_message = rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Your new WordPress site has been successfully set up at:\n\n%1$s\n\nYou can log in to the administrator account with the following information:\n\nUsername: %2$s\nPassword: %3$s\nLog in here: %4$s\n\nWe hope you enjoy your new site. Thanks!\n\n--The WordPress Team\nhttps://wordpress.org/\n'),
		]),
		var_blog_url.clone(),
		var_name.clone(),
		var_password.clone(),
		var_login_url.clone(),
	])
	var_installed_email = rt.create_array([rt.ArrayItem{ key: 'to', val: var_email },
		rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
			rt.new_string('New WordPress Site'),
		]) }, rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'headers', val: '' }])
	var_installed_email = rt.call_function('apply_filters', [
		rt.new_string('wp_installed_email'),
		var_installed_email.clone(),
		var_user,
		var_blog_title.clone(),
		var_blog_url.clone(),
		var_password.clone(),
	])
	rt.call_function('wp_mail', [var_installed_email.array_get(rt.new_string('to')),
		var_installed_email.array_get(rt.new_string('subject')),
		var_installed_email.array_get(rt.new_string('message')),
		var_installed_email.array_get(rt.new_string('headers'))])
}

fn wp_upgrade() {
	mut var_wp_db_version := rt.new_null()
	mut var_wp_current_db_version := rt.new_null()
	var_wp_current_db_version = rt.new_int((__get_option('db_version')).to_i64())
	if rt.is_true(rt.identical(var_wp_db_version, var_wp_current_db_version)) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return
	}
	wp_check_mysql_version()
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	pre_schema_upgrade()
	make_db_current_silent('')
	upgrade_all()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
		upgrade_network()
	}
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('update_site_meta', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
			rt.new_string('db_version'),
			var_wp_db_version.clone(),
		])
		rt.call_function('update_site_meta', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
			rt.new_string('db_last_updated'),
			rt.call_function('microtime', []rt.PhpVal{}),
		])
	}
	rt.call_function('delete_transient', [rt.new_string('wp_core_block_css_files')])
	rt.call_function('do_action', [rt.new_string('wp_upgrade'),
		var_wp_db_version.clone(), var_wp_current_db_version.clone()])
}

fn upgrade_all() {
	mut var_wp_db_version := rt.new_null()
	mut var_wp_current_db_version := rt.new_null()
	mut var_template := rt.new_null()
	var_wp_current_db_version = rt.new_int((__get_option('db_version')).to_i64())
	if rt.is_true(rt.identical(var_wp_db_version, var_wp_current_db_version)) {
		return
	}
	if !rt.is_true(var_wp_current_db_version) {
		var_wp_current_db_version = rt.new_int(0)
		var_template = __get_option('template')
		if !(!rt.is_true(var_template)) {
			var_wp_current_db_version = rt.new_int(2541)
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(6039))) {
		upgrade_230_options_table()
	}
	rt.call_function('populate_options', []rt.PhpVal{})
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(2541))) {
		upgrade_100()
		upgrade_101()
		upgrade_110()
		upgrade_130()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(3308))) {
		upgrade_160()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(4772))) {
		upgrade_210()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(4351))) {
		upgrade_old_slugs()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(5539))) {
		upgrade_230()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(6124))) {
		upgrade_230_old_tables()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(7499))) {
		upgrade_250()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(7935))) {
		upgrade_252()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(8201))) {
		upgrade_260()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(8989))) {
		upgrade_270()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(10360))) {
		upgrade_280()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(11958))) {
		upgrade_290()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(15260))) {
		upgrade_300()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19389))) {
		upgrade_330()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(20080))) {
		upgrade_340()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(22422))) {
		upgrade_350()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(25824))) {
		upgrade_370()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(26148))) {
		upgrade_372()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(26691))) {
		upgrade_380()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(29630))) {
		upgrade_400()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(33055))) {
		upgrade_430()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(33056))) {
		upgrade_431()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(35700))) {
		upgrade_440()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(36686))) {
		upgrade_450()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(37965))) {
		upgrade_460()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(44719))) {
		upgrade_510()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(45744))) {
		upgrade_530()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(48575))) {
		upgrade_550()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(49752))) {
		upgrade_560()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(51917))) {
		upgrade_590()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(53011))) {
		upgrade_600()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(55853))) {
		upgrade_630()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(56657))) {
		upgrade_640()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(57155))) {
		upgrade_650()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(58975))) {
		upgrade_670()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(60421))) {
		upgrade_682()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(61644))) {
		upgrade_700()
	}
	maybe_disable_link_manager()
	maybe_disable_automattic_widgets()
	rt.call_function('update_option', [rt.new_string('db_version'),
		var_wp_db_version.clone()])
	rt.call_function('update_option', [rt.new_string('db_upgraded'),
		rt.new_bool(true)])
}

fn upgrade_100() {
	mut var_wpdb := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_newtitle := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_category := rt.new_null()
	mut var_sql := ''
	mut var_done_ids := rt.new_null()
	mut var_done_posts := []rt.PhpVal{}
	mut var_done_id := rt.new_null()
	mut var_catwhere := rt.new_null()
	mut var_allposts := rt.new_null()
	mut var_cat := rt.new_null()
	var_posts = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT ID, post_title, post_name FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(" WHERE post_name = ''")),
	])
	if rt.is_true(var_posts) {
		mut iter_2 := var_posts.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_post_shadow := item_2.val
			if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_post_shadow,
				'post_name')))
			{
				var_newtitle = rt.call_function('sanitize_title', [
					rt.get_property(var_post_shadow, 'post_title'),
				])
				rt.call_method(var_wpdb, 'query', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
							'posts')), rt.new_string(' SET post_name = %s WHERE ID = %d')),
						var_newtitle.clone(),
						rt.get_property(var_post_shadow, 'ID'),
					]),
				])
			}
		}
	}
	var_categories = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT cat_ID, cat_name, category_nicename FROM '), rt.get_property(var_wpdb,
			'categories')),
	])
	mut iter_3 := var_categories.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category_shadow := item_3.val
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_category_shadow,
			'category_nicename')))
		{
			var_newtitle = rt.call_function('sanitize_title', [
				rt.get_property(var_category_shadow, 'cat_name'),
			])
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'categories'),
				rt.create_array([
					rt.ArrayItem{ key: 'category_nicename', val: var_newtitle },
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'cat_ID', val: rt.get_property(var_category_shadow, 'cat_ID') },
				])])
		}
	}
	var_sql = rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'options')),
		rt.new_string("\n\t\tSET option_value = REPLACE(option_value, 'wp-links/links-images/', 'wp-images/links/')\n\t\tWHERE option_name LIKE %s\n\t\tAND option_value LIKE %s"))
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string(var_sql.str()).clone(),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('links_rating_image')])).str() +
				'%'),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('wp-links/links-images/')])).str() +
				'%')]),
	])
	var_done_ids = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT DISTINCT post_id FROM '), rt.get_property(var_wpdb,
			'post2cat')),
	])
	if rt.is_true(var_done_ids) {
		var_done_posts = rt.new_array()
		mut iter_4 := var_done_ids.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_done_id_shadow := item_4.val
			var_done_posts << rt.get_property(var_done_id_shadow, 'post_id')
		}
		var_catwhere = rt.new_string(
			' AND ID NOT IN (' + (rt.call_function('implode', [rt.new_string(','), rt.create_array_from_list(var_done_posts)])).str() +
			')')
	} else {
		var_catwhere = rt.new_string('')
	}
	var_allposts = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID, post_category FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(" WHERE post_category != '0' ")), var_catwhere),
	])
	if rt.is_true(var_allposts) {
		mut iter_5 := var_allposts.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_post_shadow := item_5.val
			var_cat = rt.call_method(var_wpdb, 'get_row', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
						'post2cat')), rt.new_string(' WHERE post_id = %d AND category_id = %d')),
					rt.get_property(var_post_shadow, 'ID'),
					rt.get_property(var_post_shadow, 'post_category'),
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_cat))))
				&& rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_post_shadow, 'post_category')).to_i64()))) {
				rt.call_method(var_wpdb, 'insert', [
					rt.get_property(var_wpdb, 'post2cat'),
					rt.create_array([
						rt.ArrayItem{ key: 'post_id', val: rt.get_property(var_post_shadow, 'ID') },
						rt.ArrayItem{ key: 'category_id', val: rt.get_property(var_post_shadow,
							'post_category') },
					]),
				])
			}
		}
	}
}

fn upgrade_101() {
	mut var_wpdb := rt.new_null()
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'posts'), 'post_name'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'posts'), 'post_status'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'categories'), 'category_nicename'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'comments'), 'comment_approved'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'comments'), 'comment_post_ID'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'links'), 'link_category'))
	rt.new_bool(add_clean_index(rt.get_property(var_wpdb, 'links'), 'link_visible'))
}

fn upgrade_110() {
	mut var_wpdb := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user := rt.new_null()
	mut var_newname := rt.new_null()
	mut var_all_options := rt.new_null()
	mut var_time_difference := rt.new_null()
	mut var_server_time := rt.new_null()
	mut var_weblogger_time := rt.new_null()
	mut var_gmt_time := rt.new_null()
	mut var_diff_gmt_server := rt.new_null()
	mut var_diff_weblogger_server := rt.new_null()
	mut var_diff_gmt_weblogger := rt.new_null()
	mut var_gmt_offset := rt.new_null()
	mut var_got_gmt_fields := rt.new_null()
	mut var_add_hours := rt.new_null()
	mut var_add_minutes := rt.new_null()
	var_users = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT ID, user_nickname, user_nicename FROM '), rt.get_property(var_wpdb,
			'users')),
	])
	mut iter_6 := var_users.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_user_shadow := item_6.val
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user_shadow,
			'user_nicename')))
		{
			var_newname = rt.call_function('sanitize_title', [
				rt.get_property(var_user_shadow, 'user_nickname'),
			])
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'),
				rt.create_array([rt.ArrayItem{ key: 'user_nicename', val: var_newname }]),
				rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_user_shadow,
					'ID') }])])
		}
	}
	var_all_options = get_alloptions_110()
	var_time_difference = rt.get_property(var_all_options, 'time_difference')
	var_server_time = rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int((rt.call_function('gmdate', [
		rt.new_string('Z'),
	])).to_i64()))
	var_weblogger_time = rt.add(var_server_time, rt.mul(var_time_difference,
		rt.get_constant('HOUR_IN_SECONDS')))
	var_gmt_time = rt.call_function('time', []rt.PhpVal{})
	var_diff_gmt_server = rt.div(rt.sub(var_gmt_time, var_server_time),
		rt.get_constant('HOUR_IN_SECONDS'))
	var_diff_weblogger_server = rt.div(rt.sub(var_weblogger_time, var_server_time),
		rt.get_constant('HOUR_IN_SECONDS'))
	var_diff_gmt_weblogger = rt.sub(var_diff_gmt_server, var_diff_weblogger_server)
	var_gmt_offset = rt.sub(rt.new_int(0), var_diff_gmt_weblogger)
	rt.call_function('add_option', [rt.new_string('gmt_offset'),
		var_gmt_offset.clone()])
	var_got_gmt_fields = rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.call_method(var_wpdb,
		'get_var', [
		rt.concat(rt.new_string('SELECT MAX(post_date_gmt) FROM '), rt.get_property(var_wpdb,
			'posts')),
	]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_got_gmt_fields)))) {
		var_add_hours = rt.new_int(var_diff_gmt_weblogger.to_i64())
		var_add_minutes = rt.new_int((rt.mul(rt.new_int(60), rt.sub(var_diff_gmt_weblogger,
			var_add_hours))).to_i64())
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" SET post_date_gmt = DATE_ADD(post_date, INTERVAL '")),
				var_add_hours), rt.new_string(':')), var_add_minutes),
				rt.new_string("' HOUR_MINUTE)")),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(' SET post_modified = post_date')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" SET post_modified_gmt = DATE_ADD(post_modified, INTERVAL '")),
				var_add_hours), rt.new_string(':')), var_add_minutes),
				rt.new_string("' HOUR_MINUTE) WHERE post_modified != '0000-00-00 00:00:00'")),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'comments')),
				rt.new_string(" SET comment_date_gmt = DATE_ADD(comment_date, INTERVAL '")),
				var_add_hours), rt.new_string(':')), var_add_minutes),
				rt.new_string("' HOUR_MINUTE)")),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'users')),
				rt.new_string(" SET user_registered = DATE_ADD(user_registered, INTERVAL '")),
				var_add_hours), rt.new_string(':')), var_add_minutes),
				rt.new_string("' HOUR_MINUTE)")),
		])
	}
}

fn upgrade_130() {
	mut var_wpdb := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_content := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_post_excerpt := rt.new_null()
	mut var_guid := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_comment_content := rt.new_null()
	mut var_comment_author := rt.new_null()
	mut var_links := rt.new_null()
	mut var_link := rt.new_null()
	mut var_link_name := rt.new_null()
	mut var_link_description := rt.new_null()
	mut var_active_plugins := rt.new_null()
	mut var_options := rt.new_null()
	mut var_option := rt.new_null()
	mut var_limit := rt.new_null()
	mut var_dupe_ids := rt.new_null()
	var_posts = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT ID, post_title, post_content, post_excerpt, guid, post_date, post_name, post_status, post_author FROM '), rt.get_property(var_wpdb,
			'posts')),
	])
	if rt.is_true(var_posts) {
		mut iter_7 := var_posts.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_post_shadow := item_7.val
			var_post_content = rt.call_function('addslashes', [
				deslash(rt.get_property(var_post_shadow, 'post_content')),
			])
			var_post_title = rt.call_function('addslashes', [
				deslash(rt.get_property(var_post_shadow, 'post_title')),
			])
			var_post_excerpt = rt.call_function('addslashes', [
				deslash(rt.get_property(var_post_shadow, 'post_excerpt')),
			])
			if !rt.is_true(rt.get_property(var_post_shadow, 'guid')) {
				var_guid = rt.call_function('get_permalink', [
					rt.get_property(var_post_shadow, 'ID'),
				])
			} else {
				var_guid = rt.get_property(var_post_shadow, 'guid')
			}
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
				rt.call_function('compact', [rt.new_string('post_title'),
					rt.new_string('post_content'), rt.new_string('post_excerpt'),
					rt.new_string('guid')]),
				rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post_shadow,
					'ID') }])])
		}
	}
	var_comments = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT comment_ID, comment_author, comment_content FROM '), rt.get_property(var_wpdb,
			'comments')),
	])
	if rt.is_true(var_comments) {
		mut iter_8 := var_comments.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_comment_shadow := item_8.val
			var_comment_content = deslash(rt.get_property(var_comment_shadow, 'comment_content'))
			var_comment_author = deslash(rt.get_property(var_comment_shadow, 'comment_author'))
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'comments'),
				rt.call_function('compact', [rt.new_string('comment_content'),
					rt.new_string('comment_author')]),
				rt.create_array([rt.ArrayItem{ key: 'comment_ID', val: rt.get_property(var_comment_shadow,
					'comment_ID') }])])
		}
	}
	var_links = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT link_id, link_name, link_description FROM '), rt.get_property(var_wpdb,
			'links')),
	])
	if rt.is_true(var_links) {
		mut iter_9 := var_links.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_link_shadow := item_9.val
			var_link_name = deslash(rt.get_property(var_link_shadow, 'link_name'))
			var_link_description = deslash(rt.get_property(var_link_shadow, 'link_description'))
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'links'),
				rt.call_function('compact', [rt.new_string('link_name'),
					rt.new_string('link_description')]),
				rt.create_array([rt.ArrayItem{ key: 'link_id', val: rt.get_property(var_link_shadow,
					'link_id') }])])
		}
	}
	var_active_plugins = __get_option('active_plugins')
	if !(var_active_plugins.clone().is_array()) {
		var_active_plugins = rt.call_function('explode', [rt.new_string('\n'),
			rt.new_string(var_active_plugins.clone().to_string().trim_space())])
		rt.call_function('update_option', [rt.new_string('active_plugins'),
			var_active_plugins.clone()])
	}
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'optionvalues'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'optiontypes'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'optiongroups'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'optiongroup_options'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'comments')),
			rt.new_string(" SET comment_type='trackback', comment_content = REPLACE(comment_content, '<trackback />', '') WHERE comment_content LIKE '<trackback />%'")),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'comments')),
			rt.new_string(" SET comment_type='pingback', comment_content = REPLACE(comment_content, '<pingback />', '') WHERE comment_content LIKE '<pingback />%'")),
	])
	var_options = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT option_name, COUNT(option_name) AS dupes FROM `'), rt.get_property(var_wpdb,
			'options')), rt.new_string('` GROUP BY option_name')),
	])
	mut iter_10 := var_options.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_option_shadow := item_10.val
		if rt.is_true(rt.greater(rt.get_property(var_option_shadow, 'dupes'), rt.new_int(1))) {
			var_limit = rt.sub(rt.get_property(var_option_shadow, 'dupes'), rt.new_int(1))
			var_dupe_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT option_id FROM '), rt.get_property(var_wpdb,
						'options')), rt.new_string(' WHERE option_name = %s LIMIT %d')),
					rt.get_property(var_option_shadow, 'option_name'),
					var_limit.clone(),
				]),
			])
			if rt.is_true(var_dupe_ids) {
				var_dupe_ids = rt.call_function('implode', [rt.new_string(','),
					var_dupe_ids.clone()])
				rt.call_method(var_wpdb, 'query', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
						'options')), rt.new_string(' WHERE option_id IN (')), var_dupe_ids),
						rt.new_string(')')),
				])
			}
		}
	}
	rt.new_bool(make_site_theme())
}

fn upgrade_160() {
	mut var_wpdb := rt.new_null()
	mut var_wp_current_db_version := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user := rt.new_null()
	mut var_idmode := rt.new_null()
	mut var_id := rt.new_null()
	mut var_caps := rt.new_null()
	mut var_level := rt.new_null()
	mut var_role := rt.new_null()
	mut var_old_user_fields := []rt.PhpVal{}
	mut var_old := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_objects := rt.new_null()
	mut var_object := rt.new_null()
	mut var_meta := rt.new_null()
	rt.call_function('populate_roles_160', []rt.PhpVal{})
	var_users = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'users')),
	])
	mut iter_11 := var_users.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_user_shadow := item_11.val
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_firstname'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('first_name'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_firstname'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_lastname'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('last_name'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_lastname'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_nickname'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('nickname'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_nickname'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_level'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'user_level'),
				rt.get_property(var_user_shadow, 'user_level')])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_icq'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('icq'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_icq'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_aim'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('aim'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_aim'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_msn'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('msn'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_msn'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_yim'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('yim'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_icq'),
				])])
		}
		if !(!rt.is_true(rt.get_property(var_user_shadow, 'user_description'))) {
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string('description'),
				rt.call_function('wp_slash', [
					rt.get_property(var_user_shadow, 'user_description'),
				])])
		}
		if !(rt.get_property(var_user_shadow, 'user_idmode')).is_null() {
			var_idmode = rt.get_property(var_user_shadow, 'user_idmode')
			if rt.is_true(rt.identical(rt.new_string('nickname'), var_idmode)) {
				var_id = rt.get_property(var_user_shadow, 'user_nickname')
			}
			if rt.is_true(rt.identical(rt.new_string('login'), var_idmode)) {
				var_id = rt.get_property(var_user_shadow, 'user_login')
			}
			if rt.is_true(rt.identical(rt.new_string('firstname'), var_idmode)) {
				var_id = rt.get_property(var_user_shadow, 'user_firstname')
			}
			if rt.is_true(rt.identical(rt.new_string('lastname'), var_idmode)) {
				var_id = rt.get_property(var_user_shadow, 'user_lastname')
			}
			if rt.is_true(rt.identical(rt.new_string('namefl'), var_idmode)) {
				var_id = rt.new_string((rt.get_property(var_user_shadow, 'user_firstname')).str() +
					' ' + (rt.get_property(var_user_shadow, 'user_lastname')).str())
			}
			if rt.is_true(rt.identical(rt.new_string('namelf'), var_idmode)) {
				var_id = rt.new_string((rt.get_property(var_user_shadow, 'user_lastname')).str() +
					' ' + (rt.get_property(var_user_shadow, 'user_firstname')).str())
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_idmode)))) {
				var_id = rt.get_property(var_user_shadow, 'user_nickname')
			}
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'),
				rt.create_array([rt.ArrayItem{ key: 'display_name', val: var_id }]),
				rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_user_shadow,
					'ID') }])])
		}
		var_caps = rt.call_function('get_user_meta', [
			rt.get_property(var_user_shadow, 'ID'),
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'capabilities'),
		])
		if !rt.is_true(var_caps)
			|| rt.is_true(rt.call_function('defined', [rt.new_string('RESET_CAPS')])) {
			var_level = rt.call_function('get_user_meta', [
				rt.get_property(var_user_shadow, 'ID'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'user_level'),
				rt.new_bool(true),
			])
			var_role = rt.new_string(translate_level_to_role(var_level.clone()))
			rt.call_function('update_user_meta', [rt.get_property(var_user_shadow, 'ID'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'capabilities'),
				rt.create_array([rt.ArrayItem{ key: var_role, val: true }])])
		}
	}
	var_old_user_fields = ['user_firstname', 'user_lastname', 'user_icq', 'user_aim', 'user_msn',
		'user_yim', 'user_idmode', 'user_ip', 'user_domain', 'user_browser', 'user_description',
		'user_nickname', 'user_level']
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	for var_old_shadow in var_old_user_fields {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
				'users')), rt.new_string(' DROP ')), rt.new_string(var_old_shadow.str())),
		])
	}
	rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
	var_comments = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT comment_post_ID, COUNT(*) as c FROM '), rt.get_property(var_wpdb,
			'comments')), rt.new_string(" WHERE comment_approved = '1' GROUP BY comment_post_ID")),
	])
	if rt.is_true(rt.new_bool(var_comments.clone().is_array())) {
		mut iter_12 := var_comments.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_comment_shadow := item_12.val
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
				rt.create_array([
					rt.ArrayItem{ key: 'comment_count', val: rt.get_property(var_comment_shadow,
						'c') },
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.get_property(var_comment_shadow,
						'comment_post_ID') },
				])])
		}
	}
	if rt.is_true(rt.greater(var_wp_current_db_version, rt.new_int(2541)))
		&& rt.is_true(rt.less_equal(var_wp_current_db_version, rt.new_int(3091))) {
		var_objects = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT ID, post_type FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" WHERE post_status = 'object'")),
		])
		mut iter_13 := var_objects.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_object_shadow := item_13.val
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
				rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'attachment' },
					rt.ArrayItem{ key: 'post_mime_type', val: rt.get_property(var_object_shadow,
						'post_type') }, rt.ArrayItem{ key: 'post_type', val: '' }]),
				rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_object_shadow,
					'ID') }])])
			var_meta = rt.call_function('get_post_meta', [
				rt.get_property(var_object_shadow, 'ID'),
				rt.new_string('imagedata'),
				rt.new_bool(true),
			])
			if !(!rt.is_true(var_meta.array_get(rt.new_string('file')))) {
				rt.call_function('update_attached_file', [
					rt.get_property(var_object_shadow, 'ID'),
					var_meta.array_get(rt.new_string('file')),
				])
			}
		}
	}
}

fn upgrade_210() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_status := rt.new_null()
	mut var_type := ''
	mut var_now := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(3506))) {
		var_posts = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.new_string('SELECT ID, post_status FROM '), rt.get_property(var_wpdb,
				'posts')),
		])
		if !(!rt.is_true(var_posts)) {
			mut iter_14 := var_posts.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_post_shadow := item_14.val
				var_status = rt.get_property(var_post_shadow, 'post_status')
				var_type = 'post'
				if rt.is_true(rt.identical(rt.new_string('static'), var_status)) {
					var_status = rt.new_string('publish')
					var_type = 'page'
				} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_status)) {
					var_status = rt.new_string('inherit')
					var_type = 'attachment'
				}
				rt.call_method(var_wpdb, 'query', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
							'posts')),
							rt.new_string(' SET post_status = %s, post_type = %s WHERE ID = %d')),
						var_status.clone(),
						rt.new_string(var_type.str()).clone(),
						rt.get_property(var_post_shadow, 'ID'),
					]),
				])
			}
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(3845))) {
		rt.call_function('populate_roles_210', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(3531))) {
		var_now = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:59')])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" SET post_status = 'future' WHERE post_status = 'publish' AND post_date_gmt > '")),
				var_now), rt.new_string("'")),
		])
		var_posts = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT ID, post_date FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" WHERE post_status ='future'")),
		])
		if !(!rt.is_true(var_posts)) {
			mut iter_15 := var_posts.iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_post_shadow := item_15.val
				rt.call_function('wp_schedule_single_event', [
					rt.call_function('mysql2date', [rt.new_string('U'),
						rt.get_property(var_post_shadow, 'post_date'),
						rt.new_bool(false)]),
					rt.new_string('publish_future_post'),
					rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_post_shadow,
						'ID') }]),
				])
			}
		}
	}
}

fn upgrade_230() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_tt_ids := rt.new_null()
	mut var_have_tags := false
	mut var_categories := rt.new_null()
	mut var_category := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_term_group := rt.new_null()
	mut var_exists := rt.new_null()
	mut var_id := rt.new_null()
	mut var_num := i64(0)
	mut var_alt_slug := rt.new_null()
	mut var_slug_check := rt.new_null()
	mut var_count := rt.new_null()
	mut var_taxonomy := ''
	mut var_select := ''
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var_link_cat_id_map := rt.new_null()
	mut var_default_link_cat := rt.new_null()
	mut var_link_cats := rt.new_null()
	mut var_cat_id := rt.new_null()
	mut var_links := rt.new_null()
	mut var_link := rt.new_null()
	mut var_link_id := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(5200))) {
		rt.call_function('populate_roles_230', []rt.PhpVal{})
	}
	var_tt_ids = rt.new_array()
	var_have_tags = false
	var_categories = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
			rt.get_property(var_wpdb, 'categories')), rt.new_string(' ORDER BY cat_ID')),
	])
	mut iter_16 := var_categories.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_category_shadow := item_16.val
		var_term_id = rt.new_int((rt.get_property(var_category_shadow, 'cat_ID')).to_i64())
		var_name = rt.get_property(var_category_shadow, 'cat_name')
		var_description = rt.get_property(var_category_shadow, 'category_description')
		var_slug = rt.get_property(var_category_shadow, 'category_nicename')
		var_parent = rt.get_property(var_category_shadow, 'category_parent')
		var_term_group = rt.new_int(0)
		var_exists = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT term_id, term_group FROM '), rt.get_property(var_wpdb,
					'terms')), rt.new_string(' WHERE slug = %s')),
				var_slug.clone(),
			]),
		])
		if rt.is_true(var_exists) {
			var_term_group = rt.get_property(var_exists.array_get(rt.new_int(0)), 'term_group')
			var_id = rt.get_property(var_exists.array_get(rt.new_int(0)), 'term_id')
			var_num = 2
			for {
				var_alt_slug = rt.new_string(var_slug.str() + '-${var_num.str()}')
				var_num += 1
				var_slug_check = rt.call_method(var_wpdb, 'get_var', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT slug FROM '), rt.get_property(var_wpdb,
							'terms')), rt.new_string(' WHERE slug = %s')),
						var_alt_slug.clone(),
					]),
				])
				if !(rt.is_true(var_slug_check)) {
					break
				}
			}
			var_slug = var_alt_slug.clone()
			if !rt.is_true(var_term_group) {
				var_term_group = rt.add(rt.call_method(var_wpdb, 'get_var', [
					rt.concat(rt.concat(rt.new_string('SELECT MAX(term_group) FROM '), rt.get_property(var_wpdb,
						'terms')), rt.new_string(' GROUP BY term_group')),
				]), rt.new_int(1))
				rt.call_method(var_wpdb, 'query', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
							'terms')), rt.new_string(' SET term_group = %d WHERE term_id = %d')),
						var_term_group.clone(),
						var_id.clone(),
					]),
				])
			}
		}
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
					'terms')),
					rt.new_string(' (term_id, name, slug, term_group) VALUES\n\t\t(%d, %s, %s, %d)')),
				var_term_id.clone(),
				var_name.clone(),
				var_slug.clone(),
				var_term_group.clone(),
			]),
		])
		var_count = rt.new_int(0)
		if !(!rt.is_true(rt.get_property(var_category_shadow, 'category_count'))) {
			var_count =
				rt.new_int((rt.get_property(var_category_shadow, 'category_count')).to_i64())
			var_taxonomy = 'category'
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
						'term_taxonomy')),
						rt.new_string(' (term_id, taxonomy, description, parent, count) VALUES ( %d, %s, %s, %d, %d)')),
					var_term_id.clone(),
					rt.new_string(var_taxonomy.str()).clone(),
					var_description.clone(),
					var_parent.clone(),
					var_count.clone(),
				]),
			])
			var_tt_ids.array_get_mut(var_term_id).array_set(var_taxonomy, rt.new_int((rt.get_property(var_wpdb,
				'insert_id')).to_i64()))
		}
		if !(!rt.is_true(rt.get_property(var_category_shadow, 'link_count'))) {
			var_count = rt.new_int((rt.get_property(var_category_shadow, 'link_count')).to_i64())
			var_taxonomy = 'link_category'
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
						'term_taxonomy')),
						rt.new_string(' (term_id, taxonomy, description, parent, count) VALUES ( %d, %s, %s, %d, %d)')),
					var_term_id.clone(),
					rt.new_string(var_taxonomy.str()).clone(),
					var_description.clone(),
					var_parent.clone(),
					var_count.clone(),
				]),
			])
			var_tt_ids.array_get_mut(var_term_id).array_set(var_taxonomy, rt.new_int((rt.get_property(var_wpdb,
				'insert_id')).to_i64()))
		}
		if !(!rt.is_true(rt.get_property(var_category_shadow, 'tag_count'))) {
			var_have_tags = true
			var_count = rt.new_int((rt.get_property(var_category_shadow, 'tag_count')).to_i64())
			var_taxonomy = 'post_tag'
			rt.call_method(var_wpdb, 'insert', [
				rt.get_property(var_wpdb, 'term_taxonomy'),
				rt.call_function('compact', [rt.new_string('term_id'),
					rt.new_string('taxonomy'), rt.new_string('description'),
					rt.new_string('parent'), rt.new_string('count')]),
			])
			var_tt_ids.array_get_mut(var_term_id).array_set(var_taxonomy, rt.new_int((rt.get_property(var_wpdb,
				'insert_id')).to_i64()))
		}
		if !rt.is_true(var_count) {
			var_count = rt.new_int(0)
			var_taxonomy = 'category'
			rt.call_method(var_wpdb, 'insert', [
				rt.get_property(var_wpdb, 'term_taxonomy'),
				rt.call_function('compact', [rt.new_string('term_id'),
					rt.new_string('taxonomy'), rt.new_string('description'),
					rt.new_string('parent'), rt.new_string('count')]),
			])
			var_tt_ids.array_get_mut(var_term_id).array_set(var_taxonomy, rt.new_int((rt.get_property(var_wpdb,
				'insert_id')).to_i64()))
		}
	}
	var_select = 'post_id, category_id'
	if var_have_tags {
		var_select = var_select + ', rel_type'
	}
	var_posts = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
			rt.new_string(var_select.str())), rt.new_string(' FROM ')), rt.get_property(var_wpdb,
			'post2cat')), rt.new_string(' GROUP BY post_id, category_id')),
	])
	mut iter_17 := var_posts.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_post_shadow := item_17.val
		var_post_id = rt.new_int((rt.get_property(var_post_shadow, 'post_id')).to_i64())
		var_term_id = rt.new_int((rt.get_property(var_post_shadow, 'category_id')).to_i64())
		var_taxonomy = 'category'
		if !(!rt.is_true(rt.get_property(var_post_shadow, 'rel_type')))
			&& rt.is_true(rt.identical(rt.new_string('tag'), rt.get_property(var_post_shadow, 'rel_type'))) {
			var_taxonomy = 'tag'
		}
		var_tt_id = var_tt_ids.array_get(var_term_id).array_get(rt.new_string(var_taxonomy.str()))
		if !rt.is_true(var_tt_id) {
			continue
		}
		rt.call_method(var_wpdb, 'insert', [
			rt.get_property(var_wpdb, 'term_relationships'),
			rt.create_array([rt.ArrayItem{ key: 'object_id', val: var_post_id },
				rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }]),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(3570))) {
		var_link_cat_id_map = rt.new_array()
		var_default_link_cat = rt.new_int(0)
		var_tt_ids = rt.new_array()
		var_link_cats = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string('SELECT cat_id, cat_name FROM ' +
				(rt.get_property(var_wpdb, 'prefix')).str() + 'linkcategories'),
		])
		mut iter_18 := var_link_cats.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_category_shadow := item_18.val
			var_cat_id = rt.new_int((rt.get_property(var_category_shadow, 'cat_id')).to_i64())
			var_term_id = rt.new_int(0)
			var_name = rt.call_function('wp_slash', [
				rt.get_property(var_category_shadow, 'cat_name'),
			])
			var_slug = rt.call_function('sanitize_title', [var_name.clone()])
			var_term_group = rt.new_int(0)
			var_exists = rt.call_method(var_wpdb, 'get_results', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT term_id, term_group FROM '), rt.get_property(var_wpdb,
						'terms')), rt.new_string(' WHERE slug = %s')),
					var_slug.clone(),
				]),
			])
			if rt.is_true(var_exists) {
				var_term_group = rt.get_property(var_exists.array_get(rt.new_int(0)), 'term_group')
				var_term_id = rt.get_property(var_exists.array_get(rt.new_int(0)), 'term_id')
			}
			if !rt.is_true(var_term_id) {
				rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'terms'),
					rt.call_function('compact', [rt.new_string('name'),
						rt.new_string('slug'), rt.new_string('term_group')])])
				var_term_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
			}
			var_link_cat_id_map.array_set(var_cat_id, var_term_id.clone())
			var_default_link_cat = var_term_id.clone()
			rt.call_method(var_wpdb, 'insert', [
				rt.get_property(var_wpdb, 'term_taxonomy'),
				rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id },
					rt.ArrayItem{ key: 'taxonomy', val: 'link_category' },
					rt.ArrayItem{ key: 'description', val: '' },
					rt.ArrayItem{ key: 'parent', val: 0 }, rt.ArrayItem{ key: 'count', val: 0 }]),
			])
			var_tt_ids.array_set(var_term_id,
				rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64()))
		}
		var_links = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.new_string('SELECT link_id, link_category FROM '), rt.get_property(var_wpdb,
				'links')),
		])
		if !(!rt.is_true(var_links)) {
			mut iter_19 := var_links.iterator()
			for {
				item_19 := iter_19.next() or { break }
				mut var_link_shadow := item_19.val
				if 0 == rt.new_int((rt.get_property(var_link_shadow, 'link_category')).to_i64()) {
					continue
				}
				if !(var_link_cat_id_map.array_isset(rt.get_property(var_link_shadow,
					'link_category'))) {
					continue
				}
				var_term_id = var_link_cat_id_map.array_get(rt.get_property(var_link_shadow,
					'link_category'))
				var_tt_id = var_tt_ids.array_get(var_term_id)
				if !rt.is_true(var_tt_id) {
					continue
				}
				rt.call_method(var_wpdb, 'insert', [
					rt.get_property(var_wpdb, 'term_relationships'),
					rt.create_array([
						rt.ArrayItem{ key: 'object_id', val: rt.get_property(var_link_shadow,
							'link_id') },
						rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id },
					]),
				])
			}
		}
		rt.call_function('update_option', [rt.new_string('default_link_category'),
			var_default_link_cat.clone()])
	} else {
		var_links = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT link_id, category_id FROM '), rt.get_property(var_wpdb,
				'link2cat')), rt.new_string(' GROUP BY link_id, category_id')),
		])
		mut iter_20 := var_links.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_link_shadow := item_20.val
			var_link_id = rt.new_int((rt.get_property(var_link_shadow, 'link_id')).to_i64())
			var_term_id = rt.new_int((rt.get_property(var_link_shadow, 'category_id')).to_i64())
			var_taxonomy = 'link_category'
			var_tt_id =
				var_tt_ids.array_get(var_term_id).array_get(rt.new_string(var_taxonomy.str()))
			if !rt.is_true(var_tt_id) {
				continue
			}
			rt.call_method(var_wpdb, 'insert', [
				rt.get_property(var_wpdb, 'term_relationships'),
				rt.create_array([rt.ArrayItem{ key: 'object_id', val: var_link_id },
					rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }]),
			])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(4772))) {
		rt.call_method(var_wpdb, 'query', [
			rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
				'linkcategories'),
		])
	}
	var_terms = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT term_taxonomy_id, taxonomy FROM '), rt.get_property(var_wpdb,
			'term_taxonomy')),
	])
	mut iter_21 := rt.cast_array(var_terms).iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_term_shadow := item_21.val
		if rt.is_true(rt.identical(rt.new_string('post_tag'), rt.get_property(var_term_shadow, 'taxonomy')))
			|| rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_term_shadow, 'taxonomy'))) {
			var_count = rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
						'term_relationships')), rt.new_string(', ')), rt.get_property(var_wpdb,
						'posts')), rt.new_string(' WHERE ')), rt.get_property(var_wpdb, 'posts')),
						rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'term_relationships')),
						rt.new_string(".object_id AND post_status = 'publish' AND post_type = 'post' AND term_taxonomy_id = %d")),
					rt.get_property(var_term_shadow, 'term_taxonomy_id'),
				]),
			])
		} else {
			var_count = rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
						'term_relationships')), rt.new_string(' WHERE term_taxonomy_id = %d')),
					rt.get_property(var_term_shadow, 'term_taxonomy_id'),
				]),
			])
		}
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
			rt.create_array([rt.ArrayItem{ key: 'count', val: var_count }]),
			rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: rt.get_property(var_term_shadow,
				'term_taxonomy_id') }])])
	}
}

fn upgrade_230_options_table() {
	mut var_wpdb := rt.new_null()
	mut var_old_options_fields := []rt.PhpVal{}
	mut var_old := rt.new_null()
	var_old_options_fields = ['option_can_override', 'option_type', 'option_width', 'option_height',
		'option_description', 'option_admin_level']
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	for var_old_shadow in var_old_options_fields {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' DROP ')), rt.new_string(var_old_shadow.str())),
		])
	}
	rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
}

fn upgrade_230_old_tables() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'categories'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'link2cat'),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('DROP TABLE IF EXISTS ' + (rt.get_property(var_wpdb, 'prefix')).str() +
			'post2cat'),
	])
}

fn upgrade_old_slugs() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
			rt.new_string(" SET meta_key = '_wp_old_slug' WHERE meta_key = 'old_slug'")),
	])
}

fn upgrade_250() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(6689))) {
		rt.call_function('populate_roles_250', []rt.PhpVal{})
	}
}

fn upgrade_252() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'users')),
			rt.new_string(" SET user_activation_key = ''")),
	])
}

fn upgrade_260() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(8000))) {
		rt.call_function('populate_roles_260', []rt.PhpVal{})
	}
}

fn upgrade_270() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(8980))) {
		rt.call_function('populate_roles_270', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(8921))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(" SET post_date = post_modified WHERE post_date = '0000-00-00 00:00:00'")),
		])
	}
}

fn upgrade_280() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_start := i64(0)
	mut var_rows := rt.new_null()
	mut var_row := rt.new_null()
	mut var_value := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(10360))) {
		rt.call_function('populate_roles_280', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_start = 0
		var_rows = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT option_name, option_value FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' ORDER BY option_id LIMIT ')), rt.new_int(var_start)),
				rt.new_string(', 20')),
		])
		for rt.is_true(var_rows) {
			mut iter_22 := var_rows.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_row_shadow := item_22.val
				var_value = rt.call_function('maybe_unserialize', [
					rt.get_property(var_row_shadow, 'option_value'),
				])
				if rt.is_true(rt.identical(var_value, rt.get_property(var_row_shadow,
					'option_value')))
				{
					var_value = rt.call_function('stripslashes', [
						var_value.clone()])
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.get_property(var_row_shadow,
					'option_value')))))
				{
					rt.call_function('update_option', [
						rt.get_property(var_row_shadow, 'option_name'),
						var_value.clone(),
					])
				}
			}
			var_start = var_start + 20
		}
		rt.call_function('clean_blog_cache', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		])
	}
}

fn upgrade_290() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(11958))) {
		if 1 == rt.new_int((rt.call_function('get_option', [
			rt.new_string('thread_comments_depth'),
		])).to_i64()) {
			rt.call_function('update_option', [rt.new_string('thread_comments_depth'),
				rt.new_int(2)])
			rt.call_function('update_option', [rt.new_string('thread_comments'),
				rt.new_int(0)])
		}
	}
}

fn upgrade_300() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_sql := ''
	mut var_prefix := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(15093))) {
		rt.call_function('populate_roles_300', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(14139)))
		&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])))))
		&& rt.is_true(rt.identical(rt.call_function('get_site_option', [rt.new_string('siteurl')]), rt.new_bool(false))) {
		rt.call_function('add_site_option', [rt.new_string('siteurl'),
			rt.new_string('')])
	}
	if rt.is_true(rt.new_bool(wp_should_upgrade_global_tables())) {
		var_sql = rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
			'usermeta')),
			rt.new_string("\n\t\t\tWHERE meta_key LIKE %s\n\t\t\tOR meta_key LIKE %s\n\t\t\tOR meta_key LIKE %s\n\t\t\tOR meta_key LIKE %s\n\t\t\tOR meta_key LIKE %s\n\t\t\tOR meta_key LIKE %s\n\t\t\tOR meta_key = 'manageedittagscolumnshidden'\n\t\t\tOR meta_key = 'managecategoriescolumnshidden'\n\t\t\tOR meta_key = 'manageedit-tagscolumnshidden'\n\t\t\tOR meta_key = 'manageeditcolumnshidden'\n\t\t\tOR meta_key = 'categories_per_page'\n\t\t\tOR meta_key = 'edit_tags_per_page'"))
		var_prefix = rt.call_method(var_wpdb, 'esc_like', [
			rt.get_property(var_wpdb, 'base_prefix'),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [rt.new_string(var_sql.str()).clone(),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('meta-box-hidden')])).str() +
					'%'),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('closedpostboxes')])).str() +
					'%'),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('manage-')])).str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('-columns-hidden')])).str() +
					'%'),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('meta-box-order')])).str() +
					'%'),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('metaboxorder')])).str() +
					'%'),
				rt.new_string(var_prefix.str() + '%' +
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('screen_layout')])).str() +
					'%')]),
		])
	}
}

fn upgrade_330() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var__sidebars_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_index := rt.new_null()
	mut var_name := rt.new_null()
	mut var_i := rt.new_null()
	mut var_id := rt.new_null()
	mut var_found := rt.new_null()
	mut var_widget := rt.new_null()
	mut var_widget_id := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19061)))
		&& wp_should_upgrade_global_tables() {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '),
				rt.get_property(var_wpdb, 'usermeta')),
				rt.new_string(" WHERE meta_key IN ('show_admin_bar_admin', 'plugins_last_view')")),
		])
	}
	if rt.is_true(rt.greater_equal(var_wp_current_db_version, rt.new_int(11548))) {
		return
	}
	var_sidebars_widgets = rt.call_function('get_option', [
		rt.new_string('sidebars_widgets'),
		rt.new_array(),
	])
	var__sidebars_widgets = rt.new_array()
	if var_sidebars_widgets.array_isset(rt.new_string('wp_inactive_widgets'))
		|| !rt.is_true(var_sidebars_widgets) {
		var_sidebars_widgets.array_set('array_version', 3)
	} else if !(var_sidebars_widgets.array_isset(rt.new_string('array_version'))) {
		var_sidebars_widgets.array_set('array_version', 1)
	}
	mut switch_val_1 := var_sidebars_widgets.array_get(rt.new_string('array_version'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		mut iter_23 := rt.cast_array(var_sidebars_widgets).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_sidebar_shadow := item_23.val
			mut var_index_shadow := item_23.key
			if rt.is_true(rt.new_bool(var_sidebar_shadow.clone().is_array())) {
				mut iter_24 := rt.cast_array(var_sidebar_shadow).iterator()
				for {
					item_24 := iter_24.next() or { break }
					mut var_name_shadow := item_24.val
					mut var_i_shadow := item_24.key
					var_id = rt.new_string(var_name_shadow.clone().to_string().to_lower())
					if var_wp_registered_widgets.array_isset(var_id) {
						var__sidebars_widgets.array_get_mut(var_index_shadow).array_set(var_i_shadow,
							var_id.clone())
						continue
					}
					var_id = rt.call_function('sanitize_title', [
						var_name_shadow.clone()])
					if var_wp_registered_widgets.array_isset(var_id) {
						var__sidebars_widgets.array_get_mut(var_index_shadow).array_set(var_i_shadow,
							var_id.clone())
						continue
					}
					var_found = rt.new_bool(false)
					mut iter_25 := var_wp_registered_widgets.iterator()
					for {
						item_25 := iter_25.next() or { break }
						mut var_widget_shadow := item_25.val
						mut var_widget_id_shadow := item_25.key
						if rt.is_true(rt.identical(rt.new_string(var_widget_shadow.array_get(rt.new_string('name')).to_string().to_lower()),
							rt.new_string(var_name_shadow.clone().to_string().to_lower())))
						{
							var__sidebars_widgets.array_get_mut(var_index_shadow).array_set(var_i_shadow,
								var_widget_shadow.array_get(rt.new_string('id')))
							var_found = rt.new_bool(true)
						} else if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
							var_widget_shadow.array_get(rt.new_string('name')),
						]), rt.call_function('sanitize_title', [
							var_name_shadow.clone()])))
						{
							var__sidebars_widgets.array_get_mut(var_index_shadow).array_set(var_i_shadow,
								var_widget_shadow.array_get(rt.new_string('id')))
							var_found = rt.new_bool(true)
						}
					}
					if rt.is_true(var_found) {
						continue
					}
					var__sidebars_widgets.array_get(var_index_shadow).array_unset(var_i_shadow)
				}
			}
		}
		var__sidebars_widgets.array_set('array_version', 2)
		var_sidebars_widgets = var__sidebars_widgets.clone()
		var__sidebars_widgets = rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		var_sidebars_widgets = rt.call_function('retrieve_widgets', []rt.PhpVal{})
		var_sidebars_widgets.array_set('array_version', 3)
		rt.call_function('update_option', [rt.new_string('sidebars_widgets'),
			var_sidebars_widgets.clone()])
	}
}

fn upgrade_340() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_uninstall_plugins := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19798))) {
		rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' DROP COLUMN blog_id')),
		])
		rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19799))) {
		rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '),
				rt.get_property(var_wpdb, 'comments')),
				rt.new_string(' DROP INDEX comment_approved')),
		])
		rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(20022)))
		&& wp_should_upgrade_global_tables() {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '),
				rt.get_property(var_wpdb, 'usermeta')),
				rt.new_string(" WHERE meta_key = 'themes_last_view'")),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(20080))) {
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT autoload FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(" WHERE option_name = 'uninstall_plugins'")),
		])))
		{
			var_uninstall_plugins = rt.call_function('get_option', [
				rt.new_string('uninstall_plugins'),
			])
			rt.call_function('delete_option', [rt.new_string('uninstall_plugins')])
			rt.call_function('add_option', [rt.new_string('uninstall_plugins'),
				var_uninstall_plugins.clone(), rt.new_null(),
				rt.new_bool(false)])
		}
	}
}

fn upgrade_350() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_meta_keys := rt.new_null()
	mut var_name := rt.new_null()
	mut var_term := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(22006)))
		&& rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' LIMIT 1'))])) {
		rt.call_function('update_option', [rt.new_string('link_manager_enabled'),
			rt.new_int(1)])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(21811)))
		&& wp_should_upgrade_global_tables() {
		var_meta_keys = rt.new_array()
		mut iter_26 := rt.call_function('array_merge', [
			rt.call_function('get_post_types', []rt.PhpVal{}),
			rt.call_function('get_taxonomies', []rt.PhpVal{}),
		]).iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_name_shadow := item_26.val
			if rt.is_true(rt.call_function('str_contains', [var_name_shadow.clone(),
				rt.new_string('-')]))
			{
				var_meta_keys.array_push('edit_' +
					(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_name_shadow.clone()])).str() +
					'_per_page')
			}
		}
		if rt.is_true(var_meta_keys) {
			var_meta_keys = rt.call_function('implode', [rt.new_string("', '"),
				var_meta_keys.clone()])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(" WHERE meta_key IN ('")), var_meta_keys),
					rt.new_string("')")),
			])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(22422))) {
		var_term = rt.call_function('get_term_by', [rt.new_string('slug'),
			rt.new_string('post-format-standard'), rt.new_string('post_format')])
		if rt.is_true(var_term) {
			rt.call_function('wp_delete_term', [rt.get_property(var_term, 'term_id'),
				rt.new_string('post_format')])
		}
	}
}

fn upgrade_370() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(25824))) {
		rt.call_function('wp_clear_scheduled_hook', [
			rt.new_string('wp_auto_updates_maybe_update'),
		])
	}
}

fn upgrade_372() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(26148))) {
		rt.call_function('wp_clear_scheduled_hook', [
			rt.new_string('wp_maybe_auto_update'),
		])
	}
}

fn upgrade_380() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(26691))) {
		rt.call_function('deactivate_plugins', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'mp6/mp6.php' }]),
			rt.new_bool(true),
		])
	}
}

fn upgrade_400() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(29630))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('WPLANG')]))) {
			if rt.is_true(rt.call_function('defined', [rt.new_string('WPLANG')]))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_constant('WPLANG')))))
				&& rt.is_true(rt.call_function('in_array', [rt.get_constant('WPLANG'), rt.call_function('get_available_languages', []rt.PhpVal{}), rt.new_bool(true)])) {
				rt.call_function('update_option', [rt.new_string('WPLANG'),
					rt.get_constant('WPLANG')])
			} else {
				rt.call_function('update_option', [rt.new_string('WPLANG'),
					rt.new_string('')])
			}
		}
	}
}

fn upgrade_420() {
}

fn upgrade_430() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_tables := rt.new_null()
	mut var_global_tables := rt.new_null()
	mut var_table := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(32364))) {
		upgrade_430_fix_comments()
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(32814))) {
		rt.call_function('update_option', [
			rt.new_string('finished_splitting_shared_terms'),
			rt.new_int(0),
		])
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(1),
				rt.get_constant('MINUTE_IN_SECONDS'))),
			rt.new_string('wp_split_shared_term_batch'),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(33055)))
		&& rt.is_true(rt.identical(rt.new_string('utf8mb4'), rt.get_property(var_wpdb, 'charset'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_tables = rt.call_method(var_wpdb, 'tables', [
				rt.new_string('blog')])
		} else {
			var_tables = rt.call_method(var_wpdb, 'tables', [
				rt.new_string('all')])
			if !(wp_should_upgrade_global_tables()) {
				var_global_tables = rt.call_method(var_wpdb, 'tables', [
					rt.new_string('global'),
				])
				var_tables = rt.call_function('array_diff_assoc', [
					var_tables.clone(), var_global_tables.clone()])
			}
		}
		mut iter_27 := var_tables.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_table_shadow := item_27.val
			rt.new_bool(maybe_convert_table_to_utf8mb4(var_table_shadow.clone()))
		}
	}
}

fn upgrade_430_fix_comments() {
	mut var_wpdb := rt.new_null()
	mut var_content_length := rt.new_null()
	mut var_length := rt.new_null()
	mut var_allowed_length := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_comment := rt.new_null()
	var_content_length = rt.call_method(var_wpdb, 'get_col_length', [
		rt.get_property(var_wpdb, 'comments'),
		rt.new_string('comment_content'),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_content_length.clone()])) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_content_length)) {
		var_content_length = rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' },
			rt.ArrayItem{ key: 'length', val: 65535 }])
	} else if !(var_content_length.clone().is_array()) {
		var_length = rt.new_int(if rt.new_int(var_content_length.to_i64()) > 0 {
			rt.new_int(var_content_length.to_i64())
		} else {
			65535
		})
		var_content_length = rt.create_array([rt.ArrayItem{ key: 'type', val: 'byte' },
			rt.ArrayItem{ key: 'length', val: var_length }])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('byte'), var_content_length.array_get(rt.new_string('type'))))))
		|| rt.is_true(rt.identical(rt.new_int(0), var_content_length.array_get(rt.new_string('length')))) {
		return
	}
	var_allowed_length = rt.new_int((var_content_length.array_get(rt.new_string('length'))).to_i64()) - 10
	var_comments = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT `comment_ID` FROM `'), rt.get_property(var_wpdb,
			'comments')),
			rt.new_string("`\n\t\t\tWHERE `comment_date_gmt` > '2015-04-26'\n\t\t\tAND LENGTH( `comment_content` ) >= ")),
			var_allowed_length),
			rt.new_string("\n\t\t\tAND ( `comment_content` LIKE '%<%' OR `comment_content` LIKE '%>%' )")),
	])
	mut iter_28 := var_comments.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_comment_shadow := item_28.val
		rt.call_function('wp_delete_comment', [
			rt.get_property(var_comment_shadow, 'comment_ID'),
			rt.new_bool(true),
		])
	}
}

fn upgrade_431() {
	mut var_cron_array := rt.new_null()
	var_cron_array = rt.call_function('_get_cron_array', []rt.PhpVal{})
	if var_cron_array.array_isset(rt.new_string('wp_batch_split_terms')) {
		var_cron_array.array_unset(rt.new_string('wp_batch_split_terms'))
		rt.call_function('_set_cron_array', [var_cron_array.clone()])
	}
}

fn upgrade_440() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_roles := rt.new_null()
	mut var_role := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(34030))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' MODIFY option_name VARCHAR(191)')),
		])
	}
	var_roles = rt.call_function('wp_roles', []rt.PhpVal{})
	mut iter_29 := rt.get_property(var_roles, 'role_objects').iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_role_shadow := item_29.val
		if rt.is_true(rt.call_method(var_role_shadow, 'has_cap', [
			rt.new_string('add_users'),
		]))
		{
			rt.call_method(var_role_shadow, 'remove_cap', [rt.new_string('add_users')])
		}
	}
}

fn upgrade_450() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(36180))) {
		rt.call_function('wp_clear_scheduled_hook', [
			rt.new_string('wp_maybe_auto_update'),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(36679)))
		&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(" WHERE option_name REGEXP '^[0-9]+_new_email$'")),
		])
	}
	rt.call_function('delete_user_setting', [rt.new_string('wplink')])
}

fn upgrade_460() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_uninstall_plugins := rt.new_null()
	mut var_callback := []rt.PhpVal{}
	mut var_basename := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(37854))) {
		rt.call_function('delete_post_meta_by_key', [
			rt.new_string('_post_restored_from'),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(37965))) {
		var_uninstall_plugins = rt.call_function('get_option', [
			rt.new_string('uninstall_plugins'),
			rt.new_array(),
		])
		if !(!rt.is_true(var_uninstall_plugins)) {
			mut iter_30 := var_uninstall_plugins.iterator()
			for {
				item_30 := iter_30.next() or { break }
				mut var_callback_shadow := item_30.val
				mut var_basename_shadow := item_30.key
				if var_callback_shadow.clone().is_array() && var_callback_shadow[0].is_object() {
					var_uninstall_plugins.array_unset(var_basename_shadow)
				}
			}
			rt.call_function('update_option', [rt.new_string('uninstall_plugins'),
				var_uninstall_plugins.clone()])
		}
	}
}

fn upgrade_500() {
}

fn upgrade_510() {
	rt.call_function('delete_site_option', [
		rt.new_string('upgrade_500_was_gutenberg_active'),
	])
}

fn upgrade_530() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('current_user_can')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('update_option', [rt.new_string('admin_email_lifespan'),
			rt.new_int(0)])
	}
}

fn upgrade_550() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_comment_previously_approved := rt.new_null()
	mut var_disallowed_list := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(48121))) {
		var_comment_previously_approved = rt.call_function('get_option', [
			rt.new_string('comment_whitelist'),
			rt.new_string(''),
		])
		rt.call_function('update_option', [rt.new_string('comment_previously_approved'),
			var_comment_previously_approved.clone()])
		rt.call_function('delete_option', [rt.new_string('comment_whitelist')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(48575))) {
		var_disallowed_list = rt.call_function('get_option', [
			rt.new_string('blacklist_keys'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_disallowed_list)) {
			var_disallowed_list = rt.call_function('get_option', [
				rt.new_string('blocklist_keys'),
			])
		}
		rt.call_function('update_option', [rt.new_string('disallowed_keys'),
			var_disallowed_list.clone()])
		rt.call_function('delete_option', [rt.new_string('blacklist_keys')])
		rt.call_function('delete_option', [rt.new_string('blocklist_keys')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(48748))) {
		rt.call_function('update_option', [
			rt.new_string('finished_updating_comment_type'),
			rt.new_int(0),
		])
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(1),
				rt.get_constant('MINUTE_IN_SECONDS'))),
			rt.new_string('wp_update_comment_type_batch'),
		])
	}
}

fn upgrade_560() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_post_category_exists := rt.new_null()
	mut var_results := rt.new_null()
	mut var_network_id := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(49572))) {
		var_post_category_exists = rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SHOW COLUMNS FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" LIKE 'post_category'")),
		])
		if !(var_post_category_exists.clone().is_null()) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' DROP COLUMN `post_category`')),
			])
		}
		rt.call_function('update_option', [rt.new_string('auto_update_core_major'),
			rt.new_string('unset')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(49632))) {
		rt.call_function('save_mod_rewrite_rules', []rt.PhpVal{})
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(49735))) {
		rt.call_function('delete_transient', [rt.new_string('dirsize_cache')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(49752))) {
		var_results = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT 1 FROM '), rt.get_property(var_wpdb,
					'usermeta')), rt.new_string(' WHERE meta_key = %s LIMIT 1')),
				Class_WP_Application_Passwords.usermeta_key_application_passwords(),
			]),
		])
		if !(!rt.is_true(var_results)) {
			var_network_id = rt.call_function('get_main_network_id', []rt.PhpVal{})
			rt.call_function('update_network_option', [var_network_id.clone(),
				Class_WP_Application_Passwords.option_key_in_use(),
				rt.new_int(1)])
		}
	}
}

fn upgrade_590() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_crons := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(51917))) {
		var_crons = rt.call_function('_get_cron_array', []rt.PhpVal{})
		if rt.is_true(var_crons) && var_crons.clone().is_array() {
			var_crons = rt.call_function('array_filter', [var_crons.clone()])
			rt.call_function('_set_cron_array', [var_crons.clone()])
		}
	}
}

fn upgrade_600() {
	mut var_wp_current_db_version := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(53011))) {
		rt.call_function('wp_update_user_counts', []rt.PhpVal{})
	}
}

fn upgrade_630() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_can_compress_scripts := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(55853))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
			var_can_compress_scripts = rt.call_function('get_option', [
				rt.new_string('can_compress_scripts'),
				rt.new_bool(false),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
				var_can_compress_scripts))))
			{
				rt.call_function('delete_option', [rt.new_string('can_compress_scripts')])
				rt.call_function('add_option', [rt.new_string('can_compress_scripts'),
					var_can_compress_scripts.clone(), rt.new_string(''),
					rt.new_bool(true)])
			}
		}
	}
}

fn upgrade_640() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_scheduled := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(56657))) {
		rt.call_function('update_option', [rt.new_string('wp_attachment_pages_enabled'),
			rt.new_int(1)])
		var_scheduled = rt.call_function('wp_get_scheduled_event', [
			rt.new_string('wp_https_detection'),
		])
		if rt.is_true(var_scheduled) {
			rt.call_function('wp_clear_scheduled_hook', [
				rt.new_string('wp_https_detection'),
			])
		}
	}
}

fn upgrade_650() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_theme_mods_options := rt.new_null()
	mut var_autoload := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(57155))) {
		var_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
		var_theme_mods_options = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb,
					'options')),
					rt.new_string(" WHERE autoload = 'yes' AND option_name != %s AND option_name LIKE %s")),
				rt.new_string('theme_mods_${var_stylesheet.to_string()}'),
				rt.new_string(
					(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('theme_mods_')])).str() +
					'%'),
			]),
		])
		var_autoload = rt.call_function('array_fill_keys', [var_theme_mods_options.clone(),
			rt.new_bool(false)])
		rt.call_function('wp_set_option_autoload_values', [var_autoload.clone()])
	}
}

fn upgrade_670() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_options := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(58975))) {
		var_options = rt.create_array([
			rt.ArrayItem{ key: none, val: 'recently_activated' },
			rt.ArrayItem{ key: none, val: '_wp_suggested_policy_text_has_changed' },
			rt.ArrayItem{ key: none, val: 'dashboard_widget_options' },
			rt.ArrayItem{ key: none, val: 'ftp_credentials' },
			rt.ArrayItem{ key: none, val: 'adminhash' },
			rt.ArrayItem{ key: none, val: 'nav_menu_options' },
			rt.ArrayItem{ key: none, val: 'wp_force_deactivated_plugins' },
			rt.ArrayItem{ key: none, val: 'delete_blog_hash' },
			rt.ArrayItem{ key: none, val: 'allowedthemes' },
			rt.ArrayItem{ key: none, val: 'recovery_keys' },
			rt.ArrayItem{ key: none, val: 'https_detection_errors' },
			rt.ArrayItem{ key: none, val: 'fresh_site' },
		])
		rt.call_function('wp_set_options_autoload', [var_options.clone(),
			rt.new_bool(false)])
	}
}

fn upgrade_682() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_ping_sites_value := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(60421))) {
		var_ping_sites_value = rt.call_function('get_option', [
			rt.new_string('ping_sites'),
		])
		var_ping_sites_value = rt.call_function('explode', [rt.new_string('\n'),
			var_ping_sites_value.clone()])
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_url := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_url = rt.new_string(var_url.clone().to_string().trim_space())
			var_url = rt.call_function('sanitize_url', [var_url.clone()])
			if rt.is_true(rt.call_function('str_ends_with', [rt.call_function('trailingslashit', [var_url.clone()]), rt.new_string('://rpc.pingomatic.com/')]))
				|| rt.is_true(rt.call_function('str_ends_with', [rt.call_function('trailingslashit', [var_url.clone()]), rt.new_string('://rpc.twingly.com/')])) {
				var_url = rt.call_function('set_url_scheme', [
					var_url.clone(), rt.new_string('https')])
			}
			return
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_url := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_url = rt.new_string(var_url.clone().to_string().trim_space())
			var_url = rt.call_function('sanitize_url', [var_url.clone()])
			if rt.is_true(rt.call_function('str_ends_with', [rt.call_function('trailingslashit', [var_url.clone()]), rt.new_string('://rpc.pingomatic.com/')]))
				|| rt.is_true(rt.call_function('str_ends_with', [rt.call_function('trailingslashit', [var_url.clone()]), rt.new_string('://rpc.twingly.com/')])) {
				var_url = rt.call_function('set_url_scheme', [
					var_url.clone(), rt.new_string('https')])
			}
			return
		}
		var_ping_sites_value = rt.call_function('array_map', [
			rt.new_closure(closure_2_fn),
			var_ping_sites_value.clone(),
		])
		var_ping_sites_value = rt.call_function('array_filter', [
			var_ping_sites_value.clone()])
		var_ping_sites_value = rt.call_function('implode', [rt.new_string('\n'),
			var_ping_sites_value.clone()])
		rt.call_function('update_option', [rt.new_string('ping_sites'),
			var_ping_sites_value.clone()])
	}
}

fn upgrade_700() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(61644))) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'usermeta'),
			rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'modern' }]),
			rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'admin_color' },
				rt.ArrayItem{ key: 'meta_value', val: 'fresh' }])])
	}
}

fn upgrade_network() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wpmu_sitewide_plugins := rt.new_null()
	mut var_active_sitewide_plugins := rt.new_null()
	mut var_sitewide_plugins := rt.new_null()
	mut var_start := i64(0)
	mut var_rows := rt.new_null()
	mut var_row := rt.new_null()
	mut var_value := rt.new_null()
	mut var_allowedthemes := rt.new_null()
	mut var_allowed_themes := rt.new_null()
	mut var_converted := rt.new_null()
	mut var_themes := rt.new_null()
	mut var_theme_data := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_illegal_names := rt.new_null()
	mut var_illegal_name := rt.new_null()
	mut var_tables := rt.new_null()
	mut var_table := rt.new_null()
	mut var_upgrade := false
	mut var_indexes := rt.new_null()
	mut var_index := rt.new_null()
	mut var_network_id := rt.new_null()
	rt.call_function('delete_expired_transients', [rt.new_bool(true)])
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(11549))) {
		var_wpmu_sitewide_plugins = rt.call_function('get_site_option', [
			rt.new_string('wpmu_sitewide_plugins'),
		])
		var_active_sitewide_plugins = rt.call_function('get_site_option', [
			rt.new_string('active_sitewide_plugins'),
		])
		if rt.is_true(var_wpmu_sitewide_plugins) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_active_sitewide_plugins)))) {
				var_sitewide_plugins = rt.cast_array(var_wpmu_sitewide_plugins)
			} else {
				var_sitewide_plugins = rt.call_function('array_merge', [
					rt.cast_array(var_active_sitewide_plugins),
					rt.cast_array(var_wpmu_sitewide_plugins),
				])
			}
			rt.call_function('update_site_option', [
				rt.new_string('active_sitewide_plugins'),
				var_sitewide_plugins.clone(),
			])
		}
		rt.call_function('delete_site_option', [rt.new_string('wpmu_sitewide_plugins')])
		rt.call_function('delete_site_option', [
			rt.new_string('deactivated_sitewide_plugins'),
		])
		var_start = 0
		var_rows = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT meta_key, meta_value FROM '), rt.get_property(var_wpdb,
				'sitemeta')), rt.new_string(' ORDER BY meta_id LIMIT ')), rt.new_int(var_start)),
				rt.new_string(', 20')),
		])
		for rt.is_true(var_rows) {
			mut iter_31 := var_rows.iterator()
			for {
				item_31 := iter_31.next() or { break }
				mut var_row_shadow := item_31.val
				var_value = rt.get_property(var_row_shadow, 'meta_value')
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('unserialize', [
					var_value.clone(),
				])))))
				{
					var_value = rt.call_function('stripslashes', [
						var_value.clone()])
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.get_property(var_row_shadow,
					'meta_value')))))
				{
					rt.call_function('update_site_option', [
						rt.get_property(var_row_shadow, 'meta_key'),
						var_value.clone(),
					])
				}
			}
			var_start = var_start + 20
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(13576))) {
		rt.call_function('update_site_option', [rt.new_string('global_terms_enabled'),
			rt.new_string('1')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19390))) {
		rt.call_function('update_site_option', [rt.new_string('initial_db_version'),
			var_wp_current_db_version.clone()])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(19470))) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_site_option', [
			rt.new_string('active_sitewide_plugins'),
		])))
		{
			rt.call_function('update_site_option', [
				rt.new_string('active_sitewide_plugins'),
				rt.new_array(),
			])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(20148))) {
		var_allowedthemes = rt.call_function('get_site_option', [
			rt.new_string('allowedthemes'),
		])
		var_allowed_themes = rt.call_function('get_site_option', [
			rt.new_string('allowed_themes'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_allowedthemes))
			&& var_allowed_themes.clone().is_array() && rt.is_true(var_allowed_themes) {
			var_converted = rt.new_array()
			var_themes = rt.call_function('wp_get_themes', []rt.PhpVal{})
			mut iter_32 := var_themes.iterator()
			for {
				item_32 := iter_32.next() or { break }
				mut var_theme_data_shadow := item_32.val
				mut var_stylesheet_shadow := item_32.key
				if var_allowed_themes.array_isset(rt.call_method(var_theme_data_shadow, 'get', [
					rt.new_string('Name'),
				]))
				{
					var_converted.array_set(var_stylesheet_shadow, true)
				}
			}
			rt.call_function('update_site_option', [rt.new_string('allowedthemes'),
				var_converted.clone()])
			rt.call_function('delete_site_option', [rt.new_string('allowed_themes')])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(21823))) {
		rt.call_function('update_site_option', [rt.new_string('ms_files_rewriting'),
			rt.new_string('1')])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(24448))) {
		var_illegal_names = rt.call_function('get_site_option', [
			rt.new_string('illegal_names'),
		])
		if var_illegal_names.clone().is_array() && var_illegal_names.clone().array_count() == 1 {
			var_illegal_name = rt.call_function('reset', [var_illegal_names.clone()])
			var_illegal_names = rt.call_function('explode', [
				rt.new_string(' '), var_illegal_name.clone()])
			rt.call_function('update_site_option', [rt.new_string('illegal_names'),
				var_illegal_names.clone()])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(31351)))
		&& rt.is_true(rt.identical(rt.new_string('utf8mb4'), rt.get_property(var_wpdb, 'charset'))) {
		if rt.is_true(rt.new_bool(wp_should_upgrade_global_tables())) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'usermeta')),
					rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '),
					rt.get_property(var_wpdb, 'site')),
					rt.new_string(' DROP INDEX domain, ADD INDEX domain(domain(140),path(51))')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'sitemeta')),
					rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'signups')),
					rt.new_string(' DROP INDEX domain_path, ADD INDEX domain_path(domain(140),path(51))')),
			])
			var_tables = rt.call_method(var_wpdb, 'tables', [
				rt.new_string('global')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.concat(rt.new_string("SHOW TABLES LIKE '"),
					var_tables.array_get(rt.new_string('sitecategories'))), rt.new_string("'")),
			])))))
			{
				var_tables.array_unset(rt.new_string('sitecategories'))
			}
			mut iter_33 := var_tables.iterator()
			for {
				item_33 := iter_33.next() or { break }
				mut var_table_shadow := item_33.val
				rt.new_bool(maybe_convert_table_to_utf8mb4(var_table_shadow.clone()))
			}
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(33055)))
		&& rt.is_true(rt.identical(rt.new_string('utf8mb4'), rt.get_property(var_wpdb, 'charset'))) {
		if rt.is_true(rt.new_bool(wp_should_upgrade_global_tables())) {
			var_upgrade = false
			var_indexes = rt.call_method(var_wpdb, 'get_results', [
				rt.concat(rt.new_string('SHOW INDEXES FROM '), rt.get_property(var_wpdb, 'signups')),
			])
			mut iter_34 := var_indexes.iterator()
			for {
				item_34 := iter_34.next() or { break }
				mut var_index_shadow := item_34.val
				if rt.is_true(rt.identical(rt.new_string('domain_path'), rt.get_property(var_index_shadow, 'Key_name')))
					&& rt.is_true(rt.identical(rt.new_string('domain'), rt.get_property(var_index_shadow, 'Column_name')))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('140'), rt.get_property(var_index_shadow, 'Sub_part'))))) {
					var_upgrade = true
					break
				}
			}
			if var_upgrade {
				rt.call_method(var_wpdb, 'query', [
					rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
						'signups')),
						rt.new_string(' DROP INDEX domain_path, ADD INDEX domain_path(domain(140),path(51))')),
				])
			}
			var_tables = rt.call_method(var_wpdb, 'tables', [
				rt.new_string('global')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.concat(rt.new_string("SHOW TABLES LIKE '"),
					var_tables.array_get(rt.new_string('sitecategories'))), rt.new_string("'")),
			])))))
			{
				var_tables.array_unset(rt.new_string('sitecategories'))
			}
			mut iter_35 := var_tables.iterator()
			for {
				item_35 := iter_35.next() or { break }
				mut var_table_shadow := item_35.val
				rt.new_bool(maybe_convert_table_to_utf8mb4(var_table_shadow.clone()))
			}
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(44467))) {
		var_network_id = rt.call_function('get_main_network_id', []rt.PhpVal{})
		rt.call_function('delete_network_option', [var_network_id.clone(),
			rt.new_string('site_meta_supported')])
		rt.call_function('is_site_meta_supported', []rt.PhpVal{})
	}
}

fn maybe_create_table(var_table_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.new_null()
	var_query = rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SHOW TABLES LIKE %s'),
		rt.call_method(var_wpdb, 'esc_like', [var_table_name.clone()]),
	])
	if rt.is_true(rt.identical(rt.call_method(var_wpdb, 'get_var', [
		var_query.clone()]), var_table_name))
	{
		return true
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.clone()])
	if rt.is_true(rt.identical(rt.call_method(var_wpdb, 'get_var', [
		var_query.clone()]), var_table_name))
	{
		return true
	}
	return false
}

fn drop_index(var_table rt.PhpVal, var_index rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_i := i64(0)
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('ALTER TABLE `${var_table.to_string()}` DROP INDEX `${var_index.to_string()}`'),
	])
	var_i = 0
	for {
		if !(var_i < 25) { break
		 }
		rt.call_method(var_wpdb, 'query', [
			rt.new_string('ALTER TABLE `${var_table.to_string()}` DROP INDEX `${var_index.to_string()}_${var_i.str()}`'),
		])
		var_i += 1
	}
	rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
	return true
}

fn add_clean_index(var_table rt.PhpVal, index string) bool {
	mut var_index := index
	mut var_wpdb := rt.new_null()
	rt.new_bool(drop_index(var_table.clone(), rt.new_string(index)))
	rt.call_method(var_wpdb, 'query', [
		rt.new_string('ALTER TABLE `${var_table.to_string()}` ADD INDEX ( `${var_index}` )'),
	])
	return true
}

fn maybe_add_column(var_table_name rt.PhpVal, var_column_name rt.PhpVal, var_create_ddl rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_column := rt.new_null()
	mut iter_36 := rt.call_method(var_wpdb, 'get_col', [
		rt.new_string('DESC ${var_table_name.to_string()}'),
		rt.new_int(0),
	]).iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_column_shadow := item_36.val
		if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
			return true
		}
	}
	rt.call_method(var_wpdb, 'query', [var_create_ddl.clone()])
	mut iter_37 := rt.call_method(var_wpdb, 'get_col', [
		rt.new_string('DESC ${var_table_name.to_string()}'),
		rt.new_int(0),
	]).iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_column_shadow := item_37.val
		if rt.is_true(rt.identical(var_column_shadow, var_column_name)) {
			return true
		}
	}
	return false
}

fn maybe_convert_table_to_utf8mb4(var_table rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_results := rt.new_null()
	mut var_column := rt.new_null()
	mut var_charset := ''
	mut var_table_details := rt.new_null()
	mut var_table_charset := ''
	var_results = rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('SHOW FULL COLUMNS FROM `${var_table.to_string()}`'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
		return false
	}
	mut iter_38 := var_results.iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_column_shadow := item_38.val
		if rt.is_true(rt.get_property(var_column_shadow, 'Collation')) {
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('_'),
				rt.get_property(var_column_shadow, 'Collation')])
			var_charset = list_tmp_1.array_get(0)
			var_charset = var_charset.to_lower()
			if rt.is_true(rt.new_bool('utf8' != var_charset))
				&& rt.is_true(rt.new_bool('utf8mb4' != var_charset)) {
				return false
			}
		}
	}
	var_table_details = rt.call_method(var_wpdb, 'get_row', [
		rt.new_string("SHOW TABLE STATUS LIKE '${var_table.to_string()}'"),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table_details)))) {
		return false
	}
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string('_'),
		rt.get_property(var_table_details, 'Collation')])
	var_table_charset = list_tmp_2.array_get(0)
	var_table_charset = var_table_charset.to_lower()
	if rt.is_true(rt.identical(rt.new_string('utf8mb4'), rt.new_string(var_table_charset.str()))) {
		return true
	}
	return (rt.call_method(var_wpdb, 'query', [
		rt.new_string('ALTER TABLE ${var_table.to_string()} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci'),
	])).to_bool()
}

fn get_alloptions_110() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_all_options := rt.new_null()
	mut var_options := rt.new_null()
	mut var_option := rt.new_null()
	var_all_options = create_stdclass()
	var_options = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.new_string('SELECT option_name, option_value FROM '), rt.get_property(var_wpdb,
			'options')),
	])
	if rt.is_true(var_options) {
		mut iter_39 := var_options.iterator()
		for {
			item_39 := iter_39.next() or { break }
			mut var_option_shadow := item_39.val
			if rt.is_true(rt.identical(rt.new_string('siteurl'), rt.get_property(var_option_shadow, 'option_name')))
				|| rt.is_true(rt.identical(rt.new_string('home'), rt.get_property(var_option_shadow, 'option_name')))
				|| rt.is_true(rt.identical(rt.new_string('category_base'), rt.get_property(var_option_shadow, 'option_name'))) {
				rt.set_property(var_option_shadow, 'option_value', rt.call_function('untrailingslashit', [
					rt.get_property(var_option_shadow, 'option_value'),
				]))
			}
			rt.set_property(var_all_options,
				'{"nodeType":"Expr_PropertyFetch","line":2847,"var":{"nodeType":"Expr_Variable","line":2847,"name":"option"},"name":"option_name"}', rt.call_function('stripslashes', [
				rt.get_property(var_option_shadow, 'option_value'),
			]))
		}
	}
	return var_all_options.clone()
}

fn __get_option(setting string) rt.PhpVal {
	mut var_setting := setting
	mut var_wpdb := rt.new_null()
	mut var_option := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('home'), rt.new_string(setting)))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')])) {
		return rt.call_function('untrailingslashit', [rt.get_constant('WP_HOME')])
	}
	if rt.is_true(rt.identical(rt.new_string('siteurl'), rt.new_string(setting)))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')])) {
		return rt.call_function('untrailingslashit', [rt.get_constant('WP_SITEURL')])
	}
	var_option = rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' WHERE option_name = %s')),
			rt.new_string(setting),
		]),
	])
	if rt.is_true(rt.identical(rt.new_string('home'), rt.new_string(setting)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_option)))) {
		return __get_option('siteurl')
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(setting),
		rt.create_array([rt.ArrayItem{ key: none, val: 'siteurl' },
			rt.ArrayItem{ key: none, val: 'home' }, rt.ArrayItem{ key: none, val: 'category_base' },
			rt.ArrayItem{ key: none, val: 'tag_base' }]),
		rt.new_bool(true)]))
	{
		var_option = rt.call_function('untrailingslashit', [var_option.clone()])
	}
	return rt.call_function('maybe_unserialize', [var_option.clone()])
}

fn deslash(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	var_content = rt.call_function('preg_replace', [rt.new_string("/\\\\+'/"),
		rt.new_string("'"), var_content.clone()])
	var_content = rt.call_function('preg_replace', [rt.new_string('/\\\\+"/'),
		rt.new_string('"'), var_content.clone()])
	var_content = rt.call_function('preg_replace', [rt.new_string('/\\\\+/'),
		rt.new_string('\\'), var_content.clone()])
	return var_content.clone()
}

fn dbdelta(queries string, execute bool) rt.PhpVal {
	mut var_queries := queries
	mut var_execute := execute
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_match2 := []rt.PhpVal{}
	mut var_fvals := []rt.PhpVal{}
	mut var_index_matches := rt.new_null()
	mut var_index_column_matches := rt.new_null()
	mut var_cqueries := rt.new_null()
	mut var_iqueries := rt.new_null()
	mut var_for_update := rt.new_null()
	mut var_qry := rt.new_null()
	mut var_table_name := ''
	mut var_text_fields := []rt.PhpVal{}
	mut var_blob_fields := []rt.PhpVal{}
	mut var_int_fields := []rt.PhpVal{}
	mut var_global_tables := rt.new_null()
	mut var_db_version := rt.new_null()
	mut var_db_server_info := rt.new_null()
	mut var_table := rt.new_null()
	mut var_suppress := rt.new_null()
	mut var_tablefields := rt.new_null()
	mut var_cfields := rt.new_null()
	mut var_indices := rt.new_null()
	mut var_indices_without_subparts := rt.new_null()
	mut var_qryline := ''
	mut var_flds := rt.new_null()
	mut var_fld := ''
	mut var_fieldname := ''
	mut var_fieldname_lowercased := ''
	mut var_validfield := false
	mut var_index_type := rt.new_null()
	mut var_index_name := rt.new_null()
	mut var_index_columns := ''
	mut var_index_columns_without_subparts := rt.new_null()
	mut var_index_column := rt.new_null()
	mut var_id := rt.new_null()
	mut var_tablefield := rt.new_null()
	mut var_tablefield_field_lowercased := ''
	mut var_tablefield_type_lowercased := ''
	mut var_tablefield_type_without_parentheses := rt.new_null()
	mut var_tablefield_type_base := rt.new_null()
	mut var_fieldtype := rt.new_null()
	mut var_fieldtype_lowercased := ''
	mut var_fieldtype_without_parentheses := rt.new_null()
	mut var_fieldtype_base := rt.new_null()
	mut var_do_change := false
	mut var_default_value := rt.new_null()
	mut var_fielddef := rt.new_null()
	mut var_tableindices := rt.new_null()
	mut var_index_ary := rt.new_null()
	mut var_tableindex := rt.new_null()
	mut var_keyname := ''
	mut var_index_data := map[string]rt.PhpVal{}
	mut var_index_string := ''
	mut var_column_data := map[string]rt.PhpVal{}
	mut var_aindex := rt.new_null()
	mut var_index := rt.new_null()
	mut var_allqueries := rt.new_null()
	mut var_query := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_queries.str()),
		rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'blog' }, rt.ArrayItem{ key: none, val: 'global' },
			rt.ArrayItem{ key: none, val: 'ms_global' }]),
		rt.new_bool(true)]))
	{
		var_queries = (rt.call_function('wp_get_db_schema', [
			rt.new_string(var_queries.str()),
		])).str()
	}
	if !(rt.new_string(var_queries.str()).is_array()) {
		var_queries = (rt.call_function('explode', [rt.new_string(';'),
			rt.new_string(var_queries.str())])).str()
		var_queries = (rt.call_function('array_filter', [
			rt.new_string(var_queries.str()),
		])).str()
	}
	var_queries = (rt.call_function('apply_filters', [rt.new_string('dbdelta_queries'),
		rt.new_string(var_queries.str())])).str()
	var_cqueries = rt.new_array()
	var_iqueries = rt.new_array()
	var_for_update = rt.new_array()
	mut iter_40 := rt.new_string(var_queries.str()).iterator()
	for {
		item_40 := iter_40.next() or { break }
		mut var_qry_shadow := item_40.val
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('|CREATE TABLE ([^ ]*)|'),
			var_qry_shadow.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_table_name = var_matches[1].to_string().trim_space()
			var_cqueries.array_set(var_table_name, var_qry_shadow.clone())
			var_for_update.array_set(var_table_name, 'Created table ' + (var_matches[1]).str())
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('|CREATE DATABASE ([^ ]*)|'),
			var_qry_shadow.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			rt.call_function('array_unshift', [var_cqueries.clone(),
				var_qry_shadow.clone()])
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('|INSERT INTO ([^ ]*)|'),
			var_qry_shadow.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_iqueries.array_push(var_qry_shadow.clone())
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|UPDATE ([^ ]*)|'),
			var_qry_shadow.clone(), rt.create_array_from_list(var_matches)]))
		{
			var_iqueries.array_push(var_qry_shadow.clone())
			continue
		}
	}
	var_cqueries = rt.call_function('apply_filters', [
		rt.new_string('dbdelta_create_queries'),
		var_cqueries.clone(),
	])
	var_iqueries = rt.call_function('apply_filters', [
		rt.new_string('dbdelta_insert_queries'),
		var_iqueries.clone(),
	])
	var_text_fields = ['tinytext', 'text', 'mediumtext', 'longtext']
	var_blob_fields = ['tinyblob', 'blob', 'mediumblob', 'longblob']
	var_int_fields = ['tinyint', 'smallint', 'mediumint', 'int', 'integer', 'bigint']
	var_global_tables = rt.call_method(var_wpdb, 'tables', [rt.new_string('global')])
	var_db_version = rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})
	var_db_server_info = rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
	mut iter_41 := var_cqueries.iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_qry_shadow := item_41.val
		mut var_table_shadow := item_41.key
		if rt.is_true(rt.call_function('in_array', [var_table_shadow.clone(), var_global_tables.clone(), rt.new_bool(true)]))
			&& !(wp_should_upgrade_global_tables()) {
			var_cqueries.array_unset(var_table_shadow)
			var_for_update.array_unset(var_table_shadow)
			continue
		}
		var_suppress = rt.call_method(var_wpdb, 'suppress_errors', []rt.PhpVal{})
		var_tablefields = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string('DESCRIBE ${var_table.to_string()};'),
		])
		rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tablefields)))) {
			continue
		}
		var_cfields = rt.new_array()
		var_indices = rt.new_array()
		var_indices_without_subparts = rt.new_array()
		rt.call_function('preg_match', [rt.new_string('|\\((.*)\\)|ms'),
			var_qry_shadow.clone(), rt.create_array_from_list(var_match2)])
		var_qryline = var_match2[1].to_string().trim_space()
		var_flds = rt.call_function('explode', [rt.new_string('\n'),
			rt.new_string(var_qryline.str()).clone()])
		mut iter_42 := var_flds.iterator()
		for {
			item_42 := iter_42.next() or { break }
			mut var_fld_shadow := item_42.val
			var_fld_shadow = rt.new_string(var_fld_shadow.trim_space())
			rt.call_function('preg_match', [rt.new_string('|^([^ ]*)|'),
				rt.new_string(var_fld_shadow.str()), rt.create_array_from_list(var_fvals)])
			var_fieldname = var_fvals[1].to_string().trim_space()
			var_fieldname_lowercased = var_fieldname.to_lower()
			var_validfield = true
			mut switch_val_2 := rt.new_string(var_fieldname_lowercased.str())
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('primary')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('index')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('fulltext')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('unique')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('key')))
				|| rt.is_true(rt.equal(switch_val_2, rt.new_string('spatial'))) {
				var_validfield = false
				rt.call_function('preg_match', [
					rt.new_string('/^\n\t\t\t\t\t\t\t(?P<index_type>             # 1) Type of the index.\n\t\t\t\t\t\t\t\tPRIMARY\\s+KEY|(?:UNIQUE|FULLTEXT|SPATIAL)\\s+(?:KEY|INDEX)|KEY|INDEX\n\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\t\\s+                         # Followed by at least one white space character.\n\t\t\t\t\t\t\t(?:                         # Name of the index. Optional if type is PRIMARY KEY.\n\t\t\t\t\t\t\t\t`?                      # Name can be escaped with a backtick.\n\t\t\t\t\t\t\t\t\t(?P<index_name>     # 2) Name of the index.\n\t\t\t\t\t\t\t\t\t\t(?:[0-9a-zA-Z$_-]|[\\xC2-\\xDF][\\x80-\\xBF])+\n\t\t\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\t\t`?                      # Name can be escaped with a backtick.\n\t\t\t\t\t\t\t\t\\s+                     # Followed by at least one white space character.\n\t\t\t\t\t\t\t)*\n\t\t\t\t\t\t\t\\(                          # Opening bracket for the columns.\n\t\t\t\t\t\t\t\t(?P<index_columns>\n\t\t\t\t\t\t\t\t\t.+?                 # 3) Column names, index prefixes, and orders.\n\t\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\t\\)                          # Closing bracket for the columns.\n\t\t\t\t\t\t$/imx'),
					rt.new_string(var_fld_shadow.str()),
					var_index_matches.clone(),
				])
				var_index_type = rt.new_string(rt.call_function('preg_replace', [
					rt.new_string('/\\s+/'),
					rt.new_string(' '),
					rt.new_string(var_index_matches.array_get(rt.new_string('index_type')).to_string().trim_space()),
				]).to_string().to_upper())
				var_index_type = rt.call_function('str_replace', [
					rt.new_string('INDEX'), rt.new_string('KEY'),
					var_index_type.clone()])
				var_index_name = rt.new_string((if rt.is_true(rt.identical(rt.new_string('PRIMARY KEY'),
					var_index_type))
				{
					''
				} else {
					'`' +
						var_index_matches.array_get(rt.new_string('index_name')).to_string().to_lower() +
						'`'
				}).str())
				var_index_columns = (rt.call_function('array_map', [
					rt.new_string('trim'),
					rt.call_function('explode', [rt.new_string(','),
						var_index_matches.array_get(rt.new_string('index_columns'))]),
				])).str()
				var_index_columns_without_subparts = rt.new_string(var_index_columns.str()).clone()
				mut iter_43 := rt.new_string(var_index_columns.str()).iterator()
				for {
					item_43 := iter_43.next() or { break }
					mut var_index_column_shadow := item_43.val
					mut var_id_shadow := item_43.key
					rt.call_function('preg_match', [
						rt.new_string('/\n\t\t\t\t\t\t\t\t`?                      # Name can be escaped with a backtick.\n\t\t\t\t\t\t\t\t\t(?P<column_name>    # 1) Name of the column.\n\t\t\t\t\t\t\t\t\t\t(?:[0-9a-zA-Z$_-]|[\\xC2-\\xDF][\\x80-\\xBF])+\n\t\t\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\t\t`?                      # Name can be escaped with a backtick.\n\t\t\t\t\t\t\t\t(?:                     # Optional sub part.\n\t\t\t\t\t\t\t\t\t\\s*                 # Optional white space character between name and opening bracket.\n\t\t\t\t\t\t\t\t\t\\(                  # Opening bracket for the sub part.\n\t\t\t\t\t\t\t\t\t\t\\s*             # Optional white space character after opening bracket.\n\t\t\t\t\t\t\t\t\t\t(?P<sub_part>\n\t\t\t\t\t\t\t\t\t\t\t\\d+         # 2) Number of indexed characters.\n\t\t\t\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\t\t\t\t\\s*             # Optional white space character before closing bracket.\n\t\t\t\t\t\t\t\t\t\\)                  # Closing bracket for the sub part.\n\t\t\t\t\t\t\t\t)?\n\t\t\t\t\t\t\t/x'),
						var_index_column_shadow.clone(),
						var_index_column_matches.clone(),
					])
					var_index_column_shadow = rt.new_string('`' +
						(var_index_column_matches.array_get(rt.new_string('column_name'))).str() + '`')
					var_index_columns_without_subparts.array_set(var_id_shadow,
						var_index_column_shadow.clone())
					if var_index_column_matches.array_isset(rt.new_string('sub_part')) {
						var_index_column_shadow = rt.concat(var_index_column_shadow, rt.new_string(
							'(' +
							(var_index_column_matches.array_get(rt.new_string('sub_part'))).str() + ')'))
					}
				}
				var_indices.array_push(
					'${var_index_type.to_string()} ${var_index_name.to_string()} (' + (rt.call_function('implode', [rt.new_string(','), rt.new_string(var_index_columns.str()).clone()])).str() +
					')')
				var_indices_without_subparts.array_push(
					'${var_index_type.to_string()} ${var_index_name.to_string()} (' + (rt.call_function('implode', [rt.new_string(','), var_index_columns_without_subparts.clone()])).str() +
					')')
				var_index_column = rt.new_null()
				var_index_column_matches = rt.new_null()
				var_index_matches = rt.new_null()
				var_index_type = rt.new_null()
				var_index_name = rt.new_null()
				var_index_columns = ''
				var_index_columns_without_subparts = rt.new_null()
			}
			if var_validfield {
				var_cfields.array_set(var_fieldname_lowercased, var_fld_shadow)
			}
		}
		mut iter_44 := var_tablefields.iterator()
		for {
			item_44 := iter_44.next() or { break }
			mut var_tablefield_shadow := item_44.val
			var_tablefield_field_lowercased =
				rt.get_property(var_tablefield_shadow, 'Field').to_string().to_lower()
			var_tablefield_type_lowercased =
				rt.get_property(var_tablefield_shadow, 'Type').to_string().to_lower()
			var_tablefield_type_without_parentheses = rt.call_function('preg_replace', [
				rt.new_string('/' + '(.+)' + '\\(\\d*\\)' + '(.*)' + '/'),
				rt.new_string('$1$2'),
				rt.new_string(var_tablefield_type_lowercased.str()).clone(),
			])
			var_tablefield_type_base = rt.call_function('strtok', [
				var_tablefield_type_without_parentheses.clone(),
				rt.new_string(' ')])
			if rt.is_true(rt.new_bool(var_cfields.clone().array_isset(rt.new_string(var_tablefield_field_lowercased.str()).clone()))) {
				rt.call_function('preg_match', [
					rt.new_string('|`?' + (rt.get_property(var_tablefield_shadow, 'Field')).str() +
						'`? ([^ ]*( unsigned)?)|i'),
					var_cfields.array_get(rt.new_string(var_tablefield_field_lowercased.str())),
					rt.create_array_from_list(var_matches),
				])
				var_fieldtype = var_matches[1]
				var_fieldtype_lowercased = var_fieldtype.clone().to_string().to_lower()
				var_fieldtype_without_parentheses = rt.call_function('preg_replace', [
					rt.new_string('/' + '(.+)' + '\\(\\d*\\)' + '(.*)' + '/'),
					rt.new_string('$1$2'),
					rt.new_string(var_fieldtype_lowercased.str()).clone(),
				])
				var_fieldtype_base = rt.call_function('strtok', [
					var_fieldtype_without_parentheses.clone(),
					rt.new_string(' ')])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_tablefield_shadow,
					'Type'), rt.new_string(var_fieldtype_lowercased.str())))))
				{
					var_do_change = true
					if rt.is_true(rt.call_function('in_array', [rt.new_string(var_fieldtype_lowercased.str()).clone(), rt.create_array_from_list(var_text_fields), rt.new_bool(true)]))
						&& rt.is_true(rt.call_function('in_array', [rt.new_string(var_tablefield_type_lowercased.str()).clone(), rt.create_array_from_list(var_text_fields), rt.new_bool(true)])) {
						if rt.is_true(rt.less(rt.call_function('array_search', [
							rt.new_string(var_fieldtype_lowercased.str()).clone(),
							rt.create_array_from_list(var_text_fields),
							rt.new_bool(true),
						]), rt.call_function('array_search', [
							rt.new_string(var_tablefield_type_lowercased.str()).clone(),
							rt.create_array_from_list(var_text_fields),
							rt.new_bool(true)])))
						{
							var_do_change = false
						}
					}
					if rt.is_true(rt.call_function('in_array', [rt.new_string(var_fieldtype_lowercased.str()).clone(), rt.create_array_from_list(var_blob_fields), rt.new_bool(true)]))
						&& rt.is_true(rt.call_function('in_array', [rt.new_string(var_tablefield_type_lowercased.str()).clone(), rt.create_array_from_list(var_blob_fields), rt.new_bool(true)])) {
						if rt.is_true(rt.less(rt.call_function('array_search', [
							rt.new_string(var_fieldtype_lowercased.str()).clone(),
							rt.create_array_from_list(var_blob_fields),
							rt.new_bool(true),
						]), rt.call_function('array_search', [
							rt.new_string(var_tablefield_type_lowercased.str()).clone(),
							rt.create_array_from_list(var_blob_fields),
							rt.new_bool(true)])))
						{
							var_do_change = false
						}
					}
					if rt.is_true(rt.call_function('in_array', [var_fieldtype_base.clone(), rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
						&& rt.is_true(rt.call_function('in_array', [var_tablefield_type_base.clone(), rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
						&& rt.is_true(rt.identical(var_fieldtype_without_parentheses, var_tablefield_type_without_parentheses)) {
						if rt.is_true(rt.call_function('version_compare', [var_db_version.clone(), rt.new_string('8.0.17'), rt.new_string('>=')]))
							&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_db_server_info.clone(), rt.new_string('MariaDB')]))))) {
							var_do_change = false
						}
					}
					if var_do_change {
						var_cqueries.array_push(
							rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '), var_table_shadow), rt.new_string(' CHANGE COLUMN `')), rt.get_property(var_tablefield_shadow, 'Field')), rt.new_string('` ')) +(var_cfields.array_get(rt.new_string(var_tablefield_field_lowercased.str()))).str())
						var_for_update.array_set(var_table_shadow.str() + '.' +
							(rt.get_property(var_tablefield_shadow, 'Field')).str(), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Changed type of '),
							var_table_shadow), rt.new_string('.')), rt.get_property(var_tablefield_shadow,
							'Field')), rt.new_string(' from ')), rt.get_property(var_tablefield_shadow,
							'Type')), rt.new_string(' to ')), var_fieldtype))
					}
				}
				if rt.is_true(rt.call_function('preg_match', [
					rt.new_string("| DEFAULT '(.*?)'|i"),
					var_cfields.array_get(rt.new_string(var_tablefield_field_lowercased.str())),
					rt.create_array_from_list(var_matches),
				]))
				{
					var_default_value = var_matches[1]
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_tablefield_shadow,
						'Default'), var_default_value))))
					{
						var_cqueries.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '),
							var_table_shadow), rt.new_string(' ALTER COLUMN `')), rt.get_property(var_tablefield_shadow,
							'Field')), rt.new_string("` SET DEFAULT '")), var_default_value),
							rt.new_string("'")))
						var_for_update.array_set(var_table_shadow.str() + '.' +
							(rt.get_property(var_tablefield_shadow, 'Field')).str(), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Changed default value of '),
							var_table_shadow), rt.new_string('.')), rt.get_property(var_tablefield_shadow,
							'Field')), rt.new_string(' from ')), rt.get_property(var_tablefield_shadow,
							'Default')), rt.new_string(' to ')), var_default_value))
					}
				}
				var_cfields.array_unset(rt.new_string(var_tablefield_field_lowercased.str()))
			} else {
			}
		}
		mut iter_45 := var_cfields.iterator()
		for {
			item_45 := iter_45.next() or { break }
			mut var_fielddef_shadow := item_45.val
			mut var_fieldname_shadow := item_45.key
			var_cqueries.array_push('ALTER TABLE ${var_table.to_string()} ADD COLUMN ${var_fielddef.to_string()}')
			var_for_update.array_set(var_table_shadow.str() + '.' + var_fieldname_shadow,

				'Added column ' + var_table_shadow.str() + '.' + var_fieldname_shadow)
		}
		var_tableindices = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string('SHOW INDEX FROM ${var_table.to_string()};'),
		])
		if rt.is_true(var_tableindices) {
			var_index_ary = rt.new_array()
			mut iter_46 := var_tableindices.iterator()
			for {
				item_46 := iter_46.next() or { break }
				mut var_tableindex_shadow := item_46.val
				var_keyname =
					rt.get_property(var_tableindex_shadow, 'Key_name').to_string().to_lower()
				var_index_ary.array_get_mut(var_keyname).array_get_mut('columns').array_push(rt.create_array([
					rt.ArrayItem{ key: 'fieldname', val: rt.get_property(var_tableindex_shadow,
						'Column_name') },
					rt.ArrayItem{ key: 'subpart', val: rt.get_property(var_tableindex_shadow,
						'Sub_part') },
				]))
				var_index_ary.array_get_mut(var_keyname).array_set('unique', if rt.is_true(rt.identical(rt.new_string('0'), (rt.get_property(var_tableindex_shadow,
					'Non_unique')).str()))
				{
					true
				} else {
					false
				})
				var_index_ary.array_get_mut(var_keyname).array_set('index_type', rt.get_property(var_tableindex_shadow,
					'Index_type'))
			}
			mut iter_47 := var_index_ary.iterator()
			for {
				item_47 := iter_47.next() or { break }
				mut var_index_data_shadow := item_47.val
				mut var_index_name_shadow := item_47.key
				var_index_string = ''
				if rt.is_true(rt.identical(rt.new_string('primary'), var_index_name_shadow)) {
					var_index_string = var_index_string + 'PRIMARY '
				} else if rt.is_true(var_index_data_shadow['unique']) {
					var_index_string = var_index_string + 'UNIQUE '
				}
				if rt.is_true(rt.identical(rt.new_string('FULLTEXT'),
					rt.new_string(var_index_data_shadow['index_type'].to_string().to_upper())))
				{
					var_index_string = var_index_string + 'FULLTEXT '
				}
				if rt.is_true(rt.identical(rt.new_string('SPATIAL'),
					rt.new_string(var_index_data_shadow['index_type'].to_string().to_upper())))
				{
					var_index_string = var_index_string + 'SPATIAL '
				}
				var_index_string = var_index_string + 'KEY '
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('primary'),
					var_index_name_shadow))))
				{
					var_index_string = var_index_string + '`' + var_index_name_shadow.str() + '`'
				}
				var_index_columns = ''
				mut iter_48 := var_index_data_shadow['columns'].iterator()
				for {
					item_48 := iter_48.next() or { break }
					mut var_column_data_shadow := item_48.val
					if rt.is_true(rt.new_bool('' != var_index_columns)) {
						var_index_columns = var_index_columns + ','
					}
					var_index_columns = var_index_columns + '`' +
						(var_column_data_shadow['fieldname']).str() + '`'
				}
				var_index_string = var_index_string + ' (${var_index_columns})'
				var_aindex = rt.call_function('array_search', [
					rt.new_string(var_index_string.str()).clone(),
					var_indices_without_subparts.clone(), rt.new_bool(true)])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_aindex)))) {
					var_indices_without_subparts.array_unset(var_aindex)
					var_indices.array_unset(var_aindex)
				}
			}
		}
		mut iter_49 := rt.cast_array(var_indices).iterator()
		for {
			item_49 := iter_49.next() or { break }
			mut var_index_shadow := item_49.val
			var_cqueries.array_push('ALTER TABLE ${var_table.to_string()} ADD ${var_index.to_string()}')
			var_for_update.array_push('Added index ' + var_table_shadow.str() + ' ' +
				var_index_shadow.str())
		}
		var_cqueries.array_unset(var_table_shadow)
		var_for_update.array_unset(var_table_shadow)
	}
	var_allqueries = rt.call_function('array_merge', [var_cqueries.clone(),
		var_iqueries.clone()])
	if var_execute {
		mut iter_50 := var_allqueries.iterator()
		for {
			item_50 := iter_50.next() or { break }
			mut var_query_shadow := item_50.val
			rt.call_method(var_wpdb, 'query', [var_query_shadow.clone()])
		}
	}
	return var_for_update.clone()
}

fn make_db_current(tables string) {
	mut var_tables := tables
	mut var_alterations := rt.new_null()
	mut var_alteration := rt.new_null()
	var_alterations = dbdelta(tables, false)
	print('<ol>\n')
	mut iter_51 := var_alterations.iterator()
	for {
		item_51 := iter_51.next() or { break }
		mut var_alteration_shadow := item_51.val
		print('<li>${var_alteration.to_string()}</li>\n')
	}
	print('</ol>\n')
}

fn make_db_current_silent(tables string) {
	mut var_tables := tables
	dbdelta(tables, false)
}

fn make_site_theme_from_oldschool(var_theme_name rt.PhpVal, var_template rt.PhpVal) bool {
	mut var_home_path := rt.new_null()
	mut var_site_dir := rt.new_null()
	mut var_default_dir := rt.new_null()
	mut var_files := map[string]rt.PhpVal{}
	mut var_newfile := rt.new_null()
	mut var_oldfile := rt.new_null()
	mut var_oldpath := rt.new_null()
	mut var_index := rt.new_null()
	mut var_lines := rt.new_null()
	mut var_f := rt.new_null()
	mut var_line := rt.new_null()
	mut var_header := rt.new_null()
	mut var_stylelines := rt.new_null()
	var_home_path = rt.call_function('get_home_path', []rt.PhpVal{})
	var_site_dir = rt.new_string(
		(rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/${var_template.to_string()}')
	var_default_dir = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/' +
		(rt.get_constant('WP_DEFAULT_THEME')).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		rt.new_string('${var_home_path.to_string()}/index.php'),
	])))))
	{
		return false
	}
	var_files = {
		'index.php':             'index.php'
		'wp-layout.css':         'style.css'
		'wp-comments.php':       'comments.php'
		'wp-comments-popup.php': 'comments-popup.php'
	}
	for var_oldfile_shadow, var_newfile_shadow in var_files {
		if rt.is_true(rt.identical(rt.new_string('index.php'),
			rt.new_string(var_oldfile_shadow.str())))
		{
			var_oldpath = var_home_path.clone()
		} else {
			var_oldpath = rt.get_constant('ABSPATH')
		}
		if rt.is_true(rt.identical(rt.new_string('index.php'),
			rt.new_string(var_oldfile_shadow.str())))
		{
			var_index = rt.call_function('implode', [rt.new_string(''),
				rt.call_function('file', [
					rt.new_string('${var_oldpath.to_string()}/${var_oldfile.to_string()}'),
				])])
			if rt.is_true(rt.call_function('str_contains', [var_index.clone(),
				rt.new_string('WP_USE_THEMES')]))
			{
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [
					rt.new_string('${var_default_dir.to_string()}/${var_oldfile.to_string()}'),
					rt.new_string('${var_site_dir.to_string()}/${var_newfile.to_string()}'),
				])))))
				{
					return false
				}
				continue
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [
			rt.new_string('${var_oldpath.to_string()}/${var_oldfile.to_string()}'),
			rt.new_string('${var_site_dir.to_string()}/${var_newfile.to_string()}'),
		])))))
		{
			return false
		}
		rt.call_function('chmod', [
			rt.new_string('${var_site_dir.to_string()}/${var_newfile.to_string()}'),
			rt.new_int(511),
		])
		var_lines = rt.call_function('explode', [rt.new_string('\n'),
			rt.call_function('implode', [rt.new_string(''),
				rt.call_function('file', [
					rt.new_string('${var_site_dir.to_string()}/${var_newfile.to_string()}'),
				])])])
		if rt.is_true(var_lines) {
			var_f = rt.call_function('fopen', [
				rt.new_string('${var_site_dir.to_string()}/${var_newfile.to_string()}'),
				rt.new_string('w'),
			])
			mut iter_52 := var_lines.iterator()
			for {
				item_52 := iter_52.next() or { break }
				mut var_line_shadow := item_52.val
				if rt.is_true(rt.call_function('preg_match', [
					rt.new_string('/require.*wp-blog-header/'),
					var_line_shadow.clone(),
				]))
				{
					var_line_shadow = rt.new_string('//' + var_line_shadow.str())
				}
				var_line_shadow = rt.call_function('str_replace', [
					rt.new_string("<?php echo __get_option('siteurl'); ?>/wp-layout.css"),
					rt.new_string("<?php bloginfo('stylesheet_url'); ?>"),
					var_line_shadow.clone(),
				])
				var_line_shadow = rt.call_function('str_replace', [
					rt.new_string("<?php include(ABSPATH . 'wp-comments.php'); ?>"),
					rt.new_string('<?php comments_template(); ?>'),
					var_line_shadow.clone(),
				])
				rt.call_function('fwrite',
					[var_f.clone(), rt.new_string('${var_line.to_string()}\n')])
			}
			rt.call_function('fclose', [var_f.clone()])
		}
	}
	var_header = rt.new_string('/*\n' + 'Theme Name: ${var_theme_name.to_string()}\n' +
		'Theme URI: ' +
		(__get_option('siteurl')).str() + '\n' + 'Description: A theme automatically created by the update.\n' + 'Version: 1.0\n' + 'Author: Moi\n' + '*/\n')
	var_stylelines = rt.call_function('file_get_contents', [
		rt.new_string('${var_site_dir.to_string()}/style.css'),
	])
	if rt.is_true(var_stylelines) {
		var_f = rt.call_function('fopen', [
			rt.new_string('${var_site_dir.to_string()}/style.css'),
			rt.new_string('w'),
		])
		rt.call_function('fwrite', [var_f.clone(), var_header.clone()])
		rt.call_function('fwrite', [var_f.clone(), var_stylelines.clone()])
		rt.call_function('fclose', [var_f.clone()])
	}
	return true
}

fn make_site_theme_from_default(var_theme_name rt.PhpVal, var_template rt.PhpVal) bool {
	mut var_site_dir := rt.new_null()
	mut var_default_dir := rt.new_null()
	mut var_theme_dir := rt.new_null()
	mut var_theme_file := rt.new_null()
	mut var_stylelines := rt.new_null()
	mut var_f := rt.new_null()
	mut var_headers := map[string]rt.PhpVal{}
	mut var_line := rt.new_null()
	mut var_value := rt.new_null()
	mut var_header := rt.new_null()
	mut var_images_dir := rt.new_null()
	mut var_image := rt.new_null()
	var_site_dir = rt.new_string(
		(rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/${var_template.to_string()}')
	var_default_dir = rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/' +
		(rt.get_constant('WP_DEFAULT_THEME')).str())
	var_theme_dir = rt.call_function('opendir', [var_default_dir.clone()])
	if rt.is_true(var_theme_dir) {
		var_theme_file = rt.call_function('readdir', [var_theme_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_theme_file, rt.new_bool(false))))) {
			if rt.is_true(rt.call_function('is_dir', [
				rt.new_string('${var_default_dir.to_string()}/${var_theme_file.to_string()}'),
			]))
			{
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [
				rt.new_string('${var_default_dir.to_string()}/${var_theme_file.to_string()}'),
				rt.new_string('${var_site_dir.to_string()}/${var_theme_file.to_string()}'),
			])))))
			{
				return false
			}
			rt.call_function('chmod', [
				rt.new_string('${var_site_dir.to_string()}/${var_theme_file.to_string()}'),
				rt.new_int(511),
			])
		}
		rt.call_function('closedir', [var_theme_dir.clone()])
	}
	var_stylelines = rt.call_function('explode', [rt.new_string('\n'),
		rt.call_function('implode', [rt.new_string(''),
			rt.call_function('file', [
				rt.new_string('${var_site_dir.to_string()}/style.css'),
			])])])
	if rt.is_true(var_stylelines) {
		var_f = rt.call_function('fopen', [
			rt.new_string('${var_site_dir.to_string()}/style.css'),
			rt.new_string('w'),
		])
		var_headers = {
			'Theme Name:':  var_theme_name
			'Theme URI:':   __get_option('url')
			'Description:': rt.new_string('Your theme.')
			'Version:':     rt.new_string('1')
			'Author:':      rt.new_string('You')
		}
		mut iter_53 := var_stylelines.iterator()
		for {
			item_53 := iter_53.next() or { break }
			mut var_line_shadow := item_53.val
			for var_header_shadow, var_value_shadow in var_headers {
				if rt.is_true(rt.call_function('str_contains', [
					var_line_shadow.clone(), rt.new_string(var_header_shadow.str()).clone()]))
				{
					var_line_shadow = rt.new_string(
						(rt.new_string(var_header_shadow.str())).str() + ' ' +
						var_value_shadow.str())
					break
				}
			}
			rt.call_function('fwrite', [var_f.clone(), rt.new_string(var_line_shadow.str() + '\n')])
		}
		rt.call_function('fclose', [var_f.clone()])
	}
	rt.call_function('umask', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('mkdir', [
		rt.new_string('${var_site_dir.to_string()}/images'),
		rt.new_int(511),
	])))))
	{
		return false
	}
	var_images_dir = rt.call_function('opendir', [
		rt.new_string('${var_default_dir.to_string()}/images'),
	])
	if rt.is_true(var_images_dir) {
		var_image = rt.call_function('readdir', [var_images_dir.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_image, rt.new_bool(false))))) {
			if rt.is_true(rt.call_function('is_dir', [
				rt.new_string('${var_default_dir.to_string()}/images/${var_image.to_string()}'),
			]))
			{
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [
				rt.new_string('${var_default_dir.to_string()}/images/${var_image.to_string()}'),
				rt.new_string('${var_site_dir.to_string()}/images/${var_image.to_string()}'),
			])))))
			{
				return false
			}
			rt.call_function('chmod', [
				rt.new_string('${var_site_dir.to_string()}/images/${var_image.to_string()}'),
				rt.new_int(511),
			])
		}
		rt.call_function('closedir', [var_images_dir.clone()])
	}
	return false
}

fn make_site_theme() bool {
	mut var_theme_name := rt.new_null()
	mut var_template := rt.new_null()
	mut var_site_dir := rt.new_null()
	mut var_current_template := rt.new_null()
	var_theme_name = __get_option('blogname')
	var_template = rt.call_function('sanitize_title', [var_theme_name.clone()])
	var_site_dir = rt.new_string(
		(rt.get_constant('WP_CONTENT_DIR')).str() + '/themes/${var_template.to_string()}')
	if rt.is_true(rt.call_function('is_dir', [var_site_dir.clone()])) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [
		rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/themes'),
	])))))
	{
		return false
	}
	rt.call_function('umask', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('mkdir', [
		var_site_dir.clone(), rt.new_int(511)])))))
	{
		return false
	}
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-layout.css'),
	]))
	{
		if !(make_site_theme_from_oldschool(var_theme_name.clone(), var_template.clone())) {
			return false
		}
	} else {
		if !(make_site_theme_from_default(var_theme_name.clone(), var_template.clone())) {
			return false
		}
	}
	var_current_template = __get_option('template')
	if rt.is_true(rt.identical(rt.get_constant('WP_DEFAULT_THEME'), var_current_template)) {
		rt.call_function('update_option', [rt.new_string('template'),
			var_template.clone()])
		rt.call_function('update_option', [rt.new_string('stylesheet'),
			var_template.clone()])
	}
	return var_template.to_bool()
}

fn translate_level_to_role(var_level rt.PhpVal) string {
	mut switch_val_3 := var_level
	if rt.is_true(rt.equal(switch_val_3, rt.new_int(10)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(9)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(8))) {
		return 'administrator'
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(7)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(6)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(5))) {
		return 'editor'
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(4)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(3)))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_int(2))) {
		return 'author'
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_int(1))) {
		return 'contributor'
	} else {
		return 'subscriber'
	}
	return ''
}

fn wp_check_mysql_version() {
	mut var_wpdb := rt.new_null()
	mut var_result := rt.new_null()
	var_result = rt.call_method(var_wpdb, 'check_database_version', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_function('wp_die', [var_result.clone()])
	}
}

fn maybe_disable_automattic_widgets() {
	mut var_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	var_plugins = __get_option('active_plugins')
	mut iter_54 := rt.cast_array(var_plugins).iterator()
	for {
		item_54 := iter_54.next() or { break }
		mut var_plugin_shadow := item_54.val
		if rt.is_true(rt.identical(rt.new_string('widgets.php'), rt.call_function('basename', [
			var_plugin_shadow.clone(),
		])))
		{
			rt.call_function('array_splice', [var_plugins.clone(),
				rt.call_function('array_search', [var_plugin_shadow.clone(),
					var_plugins.clone(), rt.new_bool(true)]),
				rt.new_int(1)])
			rt.call_function('update_option', [rt.new_string('active_plugins'),
				var_plugins.clone()])
			break
		}
	}
}

fn maybe_disable_link_manager() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.greater_equal(var_wp_current_db_version, rt.new_int(22006)))
		&& rt.is_true(rt.call_function('get_option', [rt.new_string('link_manager_enabled')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' LIMIT 1'))]))))) {
		rt.call_function('update_option', [rt.new_string('link_manager_enabled'),
			rt.new_int(0)])
	}
}

fn pre_schema_upgrade() {
	mut var_wp_current_db_version := rt.new_null()
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(11557))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE o1 FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' AS o1 JOIN ')), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' AS o2 USING (`option_name`) WHERE o2.option_id > o1.option_id')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' DROP PRIMARY KEY, ADD PRIMARY KEY(option_id)')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' DROP INDEX option_name')),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(60497)))
		&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& wp_should_upgrade_global_tables() {
		if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(25179))) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'signups')),
					rt.new_string(' ADD signup_id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'signups')), rt.new_string(' DROP INDEX domain')),
			])
		}
		if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(25448))) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'blogs')),
					rt.new_string(" CHANGE COLUMN archived archived varchar(1) NOT NULL default '0'")),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'blogs')),
					rt.new_string(' CHANGE COLUMN archived archived tinyint(2) NOT NULL default 0')),
			])
		}
		if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(60497))) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'blogs')),
					rt.new_string(' MODIFY blog_id bigint(20) unsigned NOT NULL auto_increment')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'blogs')),
					rt.new_string(' MODIFY site_id bigint(20) unsigned NOT NULL default 0')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'blogmeta')),
					rt.new_string(' MODIFY blog_id bigint(20) unsigned NOT NULL default 0')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'registration_log')),
					rt.new_string(' MODIFY ID bigint(20) unsigned NOT NULL auto_increment')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'registration_log')),
					rt.new_string(' MODIFY blog_id bigint(20) unsigned NOT NULL default 0')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '),
					rt.get_property(var_wpdb, 'site')),
					rt.new_string(' MODIFY id bigint(20) unsigned NOT NULL auto_increment')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'sitemeta')),
					rt.new_string(' MODIFY meta_id bigint(20) unsigned NOT NULL auto_increment')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'sitemeta')),
					rt.new_string(' MODIFY site_id bigint(20) unsigned NOT NULL default 0')),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'signups')),
					rt.new_string(' MODIFY signup_id bigint(20) unsigned NOT NULL auto_increment')),
			])
		}
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(31351))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& wp_should_upgrade_global_tables() {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'usermeta')),
					rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
			])
		}
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'terms')),
				rt.new_string(' DROP INDEX slug, ADD INDEX slug(slug(191))')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'terms')),
				rt.new_string(' DROP INDEX name, ADD INDEX name(name(191))')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
				'commentmeta')),
				rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '),
				rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(' DROP INDEX post_name, ADD INDEX post_name(post_name(191))')),
		])
	}
	if rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(34978))) {
		if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string("SHOW TABLES LIKE '"), rt.get_property(var_wpdb, 'termmeta')), rt.new_string("'"))]))
			&& rt.is_true(rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(" WHERE Column_name = 'meta_key'"))])) {
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb,
					'termmeta')),
					rt.new_string(' DROP INDEX meta_key, ADD INDEX meta_key(meta_key(191))')),
			])
			rt.new_bool(maybe_convert_table_to_utf8mb4(rt.get_property(var_wpdb, 'termmeta')))
		}
	}
}

fn wp_should_upgrade_global_tables() bool {
	mut var_should_upgrade := false
	if rt.is_true(rt.call_function('defined', [
		rt.new_string('DO_NOT_UPGRADE_GLOBAL_TABLES'),
	]))
	{
		return false
	}
	var_should_upgrade = true
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_network', []rt.PhpVal{}))))) {
		var_should_upgrade = false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		var_should_upgrade = false
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('wp_should_upgrade_global_tables'),
		rt.new_bool(var_should_upgrade).clone(),
	])).to_bool()
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_Privacy_Policy_Content {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_privacy_policy_content(_args ...rt.PhpVal) &Class_WP_Privacy_Policy_Content {
	mut obj := &Class_WP_Privacy_Policy_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Privacy_Policy_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Privacy_Policy_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/install.php'),
	]))
	{
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/install.php', '3')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/schema.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_install'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_install_defaults'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_new_blog_notification'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_upgrade'),
	])))))
	{
	}
}
