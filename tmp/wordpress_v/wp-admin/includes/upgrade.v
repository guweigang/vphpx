import rt

fn wp_install(var_blog_title rt.PhpVal, var_user_name rt.PhpVal, var_user_email rt.PhpVal, var_is_public rt.PhpVal, deprecated string, user_password string, language string) rt.PhpVal {
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.6.0')])
	}
	wp_check_mysql_version()
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	make_db_current_silent('')
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_version_check')])
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_update_plugins')])
	rt.call_function('wp_unschedule_hook', [rt.new_string('wp_update_themes')])
	rt.call_function('wp_schedule_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS')), rt.new_string('twicedaily'), rt.new_string('wp_version_check')])
	rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}) + 1.5 * rt.get_constant('HOUR_IN_SECONDS'), rt.new_string('twicedaily'), rt.new_string('wp_update_plugins')])
	rt.call_function('wp_schedule_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(2), rt.get_constant('HOUR_IN_SECONDS'))), rt.new_string('twicedaily'), rt.new_string('wp_update_themes')])
	rt.call_function('populate_options', []rt.PhpVal{})
	rt.call_function('populate_roles', []rt.PhpVal{})
	rt.call_function('update_option', [rt.new_string('blogname'), var_blog_title.dup()])
	rt.call_function('update_option', [rt.new_string('admin_email'), var_user_email.dup()])
	rt.call_function('update_option', [rt.new_string('blog_public'), var_is_public.dup()])
	rt.call_function('update_option', [rt.new_string('fresh_site'), rt.new_int(1), rt.new_bool(false)])
	if var_language.len > 0 && var_language != '0' {
		rt.call_function('update_option', [rt.new_string('WPLANG'), rt.new_string(language)])
	}
	mut var_guessurl := rt.call_function('wp_guess_url', []rt.PhpVal{})
	rt.call_function('update_option', [rt.new_string('siteurl'), var_guessurl.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_public)))) {
		rt.call_function('update_option', [rt.new_string('default_pingback_flag'), rt.new_int(0)])
	}
	mut var_user_id := rt.call_function('username_exists', [var_user_name.dup()])
	user_password = user_password.trim_space()
	mut var_email_password := false
	mut var_user_created := false
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && user_password == '')) {
		user_password = (rt.call_function('wp_generate_password', [rt.new_int(12), rt.new_bool(false)])).str()
		mut var_message := rt.call_function('__', [rt.new_string('<strong><em>Note that password</em></strong> carefully! It is a <em>random</em> password that was generated just for you.')])
		var_user_id = rt.call_function('wp_create_user', [var_user_name.dup(), rt.new_string(user_password), var_user_email.dup()])
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('default_password_nag'), rt.new_bool(true)])
		var_email_password = true
		var_user_created = true
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		var_message = rt.new_string('<em>' + (rt.call_function('__', [rt.new_string('Your chosen password.')])).str() + '</em>')
		var_user_id = rt.call_function('wp_create_user', [var_user_name.dup(), rt.new_string(user_password), var_user_email.dup()])
		var_user_created = true
	} else {
		var_message = rt.call_function('__', [rt.new_string('User already exists. Password inherited.')])
	}
	mut var_user := create_wp_user(var_user_id.dup())
	var_user.set_role(rt.new_string('administrator'))
	if var_user_created {
		rt.set_property(var_user, 'user_url', var_guessurl.dup())
		rt.call_function('wp_update_user', [var_user])
	}
	wp_install_defaults(var_user_id.dup())
	rt.new_bool(wp_install_maybe_enable_pretty_permalinks())
	rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	wp_new_blog_notification(var_blog_title.dup(), var_guessurl.dup(), var_user_id.dup(), if var_email_password { rt.new_string(user_password) } else { rt.call_function('__', [rt.new_string('The password you chose during installation.')]) })
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('wp_install'), var_user])
	return rt.create_array([rt.ArrayItem{ key: 'url', val: var_guessurl }, rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{ key: 'password', val: user_password }, rt.ArrayItem{ key: 'password_message', val: var_message }])
}

fn wp_install_defaults(var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_table_prefix := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_cat_name := rt.call_function('__', [rt.new_string('Uncategorized')])
	mut var_cat_slug := rt.call_function('sanitize_title', [rt.call_function('_x', [rt.new_string('Uncategorized'), rt.new_string('Default category slug')])])
	mut var_cat_id := 1
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'terms'), rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_cat_id }, rt.ArrayItem{ key: 'name', val: var_cat_name }, rt.ArrayItem{ key: 'slug', val: var_cat_slug }, rt.ArrayItem{ key: 'term_group', val: 0 }])])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'term_taxonomy'), rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_cat_id }, rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'parent', val: 0 }, rt.ArrayItem{ key: 'count', val: 1 }])])
	mut var_cat_tt_id := rt.get_property(var_wpdb, 'insert_id')
	mut var_now := rt.call_function('current_time', [rt.new_string('mysql')])
	mut var_now_gmt := rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)])
	mut var_first_post_guid := rt.new_string((rt.call_function('get_option', [rt.new_string('home')])).str() + '/?p=1')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_first_post := rt.call_function('get_site_option', [rt.new_string('first_post')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_first_post)))) {
			var_first_post = rt.new_string('<!-- wp:paragraph -->\n<p>' + (rt.call_function('__', [rt.new_string('Welcome to %s. This is your first post. Edit or delete it, then start writing!')])).str() + '</p>\n<!-- /wp:paragraph -->')
		}
		var_first_post = rt.call_function('sprintf', [var_first_post.dup(), rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('network_home_url', []rt.PhpVal{})]), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')])])
		var_first_post = rt.call_function('str_replace', [rt.new_string('SITE_URL'), rt.call_function('esc_url', [rt.call_function('network_home_url', []rt.PhpVal{})]), var_first_post.dup()])
		var_first_post = rt.call_function('str_replace', [rt.new_string('SITE_NAME'), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'), var_first_post.dup()])
	} else {
		var_first_post = rt.new_string('<!-- wp:paragraph -->\n<p>' + (rt.call_function('__', [rt.new_string('Welcome to WordPress. This is your first post. Edit or delete it, then start writing!')])).str() + '</p>\n<!-- /wp:paragraph -->')
	}
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id }, rt.ArrayItem{ key: 'post_date', val: var_now }, rt.ArrayItem{ key: 'post_date_gmt', val: var_now_gmt }, rt.ArrayItem{ key: 'post_content', val: var_first_post }, rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [rt.new_string('Hello world!')]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('sanitize_title', [rt.call_function('_x', [rt.new_string('hello-world'), rt.new_string('Default post slug')])]) }, rt.ArrayItem{ key: 'post_modified', val: var_now }, rt.ArrayItem{ key: 'post_modified_gmt', val: var_now_gmt }, rt.ArrayItem{ key: 'guid', val: var_first_post_guid }, rt.ArrayItem{ key: 'comment_count', val: 1 }, rt.ArrayItem{ key: 'to_ping', val: '' }, rt.ArrayItem{ key: 'pinged', val: '' }, rt.ArrayItem{ key: 'post_content_filtered', val: '' }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('update_posts_count', []rt.PhpVal{})
	}
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'term_relationships'), rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_cat_tt_id }, rt.ArrayItem{ key: 'object_id', val: 1 }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_first_comment_author := rt.call_function('get_site_option', [rt.new_string('first_comment_author')])
		mut var_first_comment_email := rt.call_function('get_site_option', [rt.new_string('first_comment_email')])
		mut var_first_comment_url := rt.call_function('get_site_option', [rt.new_string('first_comment_url'), rt.call_function('network_home_url', []rt.PhpVal{})])
		mut var_first_comment := rt.call_function('get_site_option', [rt.new_string('first_comment')])
	}
	var_first_comment_author = if !(!rt.is_true(var_first_comment_author)) { var_first_comment_author } else { rt.call_function('__', [rt.new_string('A WordPress Commenter')]) }
	var_first_comment_email = if !(!rt.is_true(var_first_comment_email)) { var_first_comment_email } else { rt.new_string('wapuu@wordpress.example') }
	var_first_comment_url = if !(!rt.is_true(var_first_comment_url)) { var_first_comment_url } else { rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org/')])]) }
	var_first_comment = if !(!rt.is_true(var_first_comment)) { var_first_comment } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href="%s">Gravatar</a>.')]), rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://gravatar.com/')])])]) }
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'comments'), rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: 1 }, rt.ArrayItem{ key: 'comment_author', val: var_first_comment_author }, rt.ArrayItem{ key: 'comment_author_email', val: var_first_comment_email }, rt.ArrayItem{ key: 'comment_author_url', val: var_first_comment_url }, rt.ArrayItem{ key: 'comment_date', val: var_now }, rt.ArrayItem{ key: 'comment_date_gmt', val: var_now_gmt }, rt.ArrayItem{ key: 'comment_content', val: var_first_comment }, rt.ArrayItem{ key: 'comment_type', val: 'comment' }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_first_page := rt.call_function('get_site_option', [rt.new_string('first_page')])
	}
	if !rt.is_true(var_first_page) {
		var_first_page = rt.new_string(rt.new_string('<!-- wp:paragraph -->\n<p>'))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_first_post_guid = rt.new_string((rt.call_function('get_option', [rt.new_string('home')])).str() + '/?page_id=2')
	rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id }, rt.ArrayItem{ key: 'post_date', val: var_now }, rt.ArrayItem{ key: 'post_date_gmt', val: var_now_gmt }, rt.ArrayItem{ key: 'post_content', val: var_first_page }, rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{ key: 'comment_status', val: 'closed' }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'post_modified', val: var_now }, rt.ArrayItem{ key: 'post_modified_gmt', val: var_now_gmt }, rt.ArrayItem{ key: 'guid', val: var_first_post_guid }, rt.ArrayItem{ key: 'post_type', val: 'page' }, rt.ArrayItem{ key: 'to_ping', val: '' }, rt.ArrayItem{ key: 'pinged', val: '' }, rt.ArrayItem{ key: 'post_content_filtered', val: '' }])])
	rt.call_method(var_wpdb, 'insert', [rt.get_property(, 'postmeta'), rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		
	} else {
	}
	if !(!rt.is_true()) {
	}
	
}

fn wp_install_maybe_enable_pretty_permalinks() bool {
	mut var_wp_rewrite := rt.new_null()
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
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




pub fn init_wp_admin_includes_upgrade_php() {
	if rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/install.php'])) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/install.php', '3')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/schema.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_install')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_install_defaults')]))))) {
	}
}
