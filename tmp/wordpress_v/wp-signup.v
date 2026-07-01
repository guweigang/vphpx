import rt

fn do_signup_header() {
	rt.call_function('do_action', [rt.new_string('signup_header')])
}

fn wpmu_signup_stylesheet() {
	// unsupported statement: Stmt_InlineHTML
}

fn show_blog_form(blogname string, blog_title string, errors string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(errors),
	])))))
	{
		errors = (create_wp_error()).str()
	}
	mut var_current_network := rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		print('<label for="blogname">' +
			(rt.call_function('__', [rt.new_string('Site Name (subdirectory only):')])).str() +
			'</label>')
	} else {
		print('<label for="blogname">' +
			(rt.call_function('__', [rt.new_string('Site Domain (subdomain only):')])).str() +
			'</label>')
	}
	mut var_errmsg_blogname := rt.call_method(rt.new_string(errors), 'get_error_message', [
		rt.new_string('blogname'),
	])
	mut var_errmsg_blogname_aria := ''
	if rt.is_true(var_errmsg_blogname) {
		var_errmsg_blogname_aria = 'wp-signup-blogname-error '
		print('<p class="error" id="wp-signup-blogname-error">' + var_errmsg_blogname.str() + '</p>')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		print('<div class="wp-signup-blogname"><span class="prefix_address" id="prefix-address">' +
			(rt.get_property(var_current_network, 'domain')).str() +
			(rt.get_property(var_current_network, 'path')).str() +
			'</span><input name="blogname" type="text" id="blogname" value="' +
			(rt.call_function('esc_attr', [rt.new_string(blogname)])).str() +
			'" maxlength="60" autocomplete="off" required="required" aria-describedby="' +
			var_errmsg_blogname_aria + 'prefix-address" /></div>')
	} else {
		mut var_site_domain := rt.call_function('preg_replace', [
			rt.new_string('|^www\\.|'),
			rt.new_string(''),
			rt.get_property(var_current_network, 'domain'),
		])
		print(
			'<div class="wp-signup-blogname"><input name="blogname" type="text" id="blogname" value="' +
			(rt.call_function('esc_attr', [rt.new_string(blogname)])).str() +
			'" maxlength="60" autocomplete="off" required="required" aria-describedby="' +
			var_errmsg_blogname_aria +
			'suffix-address" /><span class="suffix_address" id="suffix-address">.' +
			(rt.call_function('esc_html', [var_site_domain.dup()])).str() + '</span></div>')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install',
			[]rt.PhpVal{})))))
		{
			mut var_site := rt.new_string((rt.get_property(var_current_network, 'domain')).str() +
				(rt.get_property(var_current_network, 'path')).str() +
				(rt.call_function('__', [rt.new_string('sitename')])).str())
		} else {
			var_site = rt.new_string((rt.call_function('__', [rt.new_string('domain')])).str() +
				'.' + var_site_domain.str() + (rt.get_property(var_current_network, 'path')).str())
		}
		rt.call_function('printf', [rt.new_string('<p>(<strong>%s</strong>) %s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Your address will be %s.')]),
				var_site.dup(),
			]),
			rt.call_function('__', [
				rt.new_string('Must be at least 4 characters, letters and numbers only. It cannot be changed, so choose carefully!'),
			])])
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title:')])
	// unsupported statement: Stmt_InlineHTML
	mut var_errmsg_blog_title := rt.call_method(rt.new_string(errors), 'get_error_message', [
		rt.new_string('blog_title'),
	])
	mut var_errmsg_blog_title_aria := ''
	if rt.is_true(var_errmsg_blog_title) {
		var_errmsg_blog_title_aria = ' aria-describedby="wp-signup-blog-title-error"'
		print('<p class="error" id="wp-signup-blog-title-error">' + var_errmsg_blog_title.str() +
			'</p>')
	}
	print('<input name="blog_title" type="text" id="blog_title" value="' +
		(rt.call_function('esc_attr', [rt.new_string(blog_title)])).str() +
		'" required="required" autocomplete="off"' + var_errmsg_blog_title_aria + ' />')
	// unsupported statement: Stmt_InlineHTML
	mut var_languages := signup_get_available_languages()
	if !(!rt.is_true(var_languages)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Language:')])
		// unsupported statement: Stmt_InlineHTML
		mut var_lang := rt.call_function('get_site_option', [
			rt.new_string('WPLANG')])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('WPLANG')) {
			var_lang = rt.get_superglobal('_POST').array_get('WPLANG')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_lang.dup(), var_languages.dup(), rt.new_bool(true)])))))
		{
			var_lang = rt.new_string(rt.new_string(''))
		}
		rt.call_function('wp_dropdown_languages', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: 'WPLANG' },
				rt.ArrayItem{ key: 'id', val: 'site-language' },
				rt.ArrayItem{ key: 'selected', val: var_lang },
				rt.ArrayItem{ key: 'languages', val: var_languages },
				rt.ArrayItem{ key: 'show_available_translations', val: false }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	mut var_blog_public_on_checked := ''
	mut var_blog_public_off_checked := ''
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('blog_public'))
		&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_superglobal('_POST').array_get('blog_public')))))
	{
		var_blog_public_off_checked = 'checked="checked"'
	} else {
		var_blog_public_on_checked = 'checked="checked"'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Privacy:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Allow search engines to index this site.')])
	// unsupported statement: Stmt_InlineHTML
	print(var_blog_public_on_checked)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Yes')])
	// unsupported statement: Stmt_InlineHTML
	print(var_blog_public_off_checked)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_blogform'),
		rt.new_string(errors)])
}

fn validate_blog_form() rt.PhpVal {
	mut var_user := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	}
	return rt.call_function('wpmu_validate_blog_signup', [rt.get_superglobal('_POST').array_get('blogname'),
		rt.get_superglobal('_POST').array_get('blog_title'), var_user.dup()])
}

fn show_user_form(user_name string, user_email string, errors string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(errors),
	])))))
	{
		errors = (create_wp_error()).str()
	}
	print('<label for="user_name">' + (rt.call_function('__', [rt.new_string('Username:')])).str() +
		'</label>')
	mut var_errmsg_username := rt.call_method(rt.new_string(errors), 'get_error_message', [
		rt.new_string('user_name'),
	])
	mut var_errmsg_username_aria := ''
	if rt.is_true(var_errmsg_username) {
		var_errmsg_username_aria = 'wp-signup-username-error '
		print('<p class="error" id="wp-signup-username-error">' + var_errmsg_username.str() + '</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(user_name)]))
	// unsupported statement: Stmt_InlineHTML
	print(var_errmsg_username_aria)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('(Must be at least 4 characters, lowercase letters and numbers only.)'),
	])
	// unsupported statement: Stmt_InlineHTML
	print('<label for="user_email">' +
		(rt.call_function('__', [rt.new_string('Email&nbsp;Address:')])).str() + '</label>')
	mut var_errmsg_email := rt.call_method(rt.new_string(errors), 'get_error_message', [
		rt.new_string('user_email'),
	])
	mut var_errmsg_email_aria := ''
	if rt.is_true(var_errmsg_email) {
		var_errmsg_email_aria = 'wp-signup-email-error '
		print('<p class="error" id="wp-signup-email-error">' + var_errmsg_email.str() + '</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(user_email)]))
	// unsupported statement: Stmt_InlineHTML
	print(var_errmsg_email_aria)
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_query := rt.new_null()
	rt.include_file(@DIR + '/wp-load.php', '3')
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_no_robots')])
	rt.include_file(@DIR + '/wp-blog-header.php', '3')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.call_function('get_site_option', [rt.new_string('illegal_names')]).is_array()))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('new'))))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get('new'), rt.call_function('get_site_option', [rt.new_string('illegal_names')]), rt.new_bool(true)]))))
	{
		rt.call_function('wp_redirect', [
			rt.call_function('network_home_url', []rt.PhpVal{}),
		])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('do_signup_header')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('wp_registration_url', []rt.PhpVal{}),
		])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_site_url', [rt.new_string('wp-signup.php')]),
		])
		// unsupported expression: Expr_Exit
	}
	rt.set_property(var_wp_query, 'is_404', rt.new_bool(false))
	rt.call_function('do_action', [rt.new_string('before_signup_header')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wpmu_signup_stylesheet')])
	rt.call_function('get_header', [rt.new_string('wp-signup')])
	rt.call_function('do_action', [rt.new_string('before_signup_form')])
	// unsupported statement: Stmt_InlineHTML
}
