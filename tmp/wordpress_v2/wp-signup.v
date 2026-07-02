import rt

fn do_signup_header() {
	rt.call_function('do_action', [rt.new_string('signup_header')])
}

fn wpmu_signup_stylesheet() {
	// unsupported statement: Stmt_InlineHTML
}

fn show_blog_form(blogname string, blog_title string, errors string) {
	mut var_blogname := blogname
	mut var_blog_title := blog_title
	mut var_errors := errors
	mut var_current_network := rt.new_null()
	mut var_errmsg_blogname := rt.new_null()
	mut var_errmsg_blogname_aria := ''
	mut var_site_domain := rt.new_null()
	mut var_site := rt.new_null()
	mut var_errmsg_blog_title := rt.new_null()
	mut var_errmsg_blog_title_aria := ''
	mut var_languages := rt.new_null()
	mut var_lang := rt.new_null()
	mut var_blog_public_on_checked := ''
	mut var_blog_public_off_checked := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(var_errors.str()),
	])))))
	{
		var_errors = (create_wp_error()).str()
	}
	var_current_network = rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
		print('<label for="blogname">' +
			(rt.call_function('__', [rt.new_string('Site Name (subdirectory only):')])).str() +
			'</label>')
	} else {
		print('<label for="blogname">' +
			(rt.call_function('__', [rt.new_string('Site Domain (subdomain only):')])).str() +
			'</label>')
	}
	var_errmsg_blogname = rt.call_method(rt.new_string(var_errors.str()), 'get_error_message', [
		rt.new_string('blogname'),
	])
	var_errmsg_blogname_aria = ''
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
		var_site_domain = rt.call_function('preg_replace', [rt.new_string('|^www\\.|'),
			rt.new_string(''), rt.get_property(var_current_network, 'domain')])
		print(
			'<div class="wp-signup-blogname"><input name="blogname" type="text" id="blogname" value="' +
			(rt.call_function('esc_attr', [rt.new_string(blogname)])).str() +
			'" maxlength="60" autocomplete="off" required="required" aria-describedby="' +
			var_errmsg_blogname_aria +
			'suffix-address" /><span class="suffix_address" id="suffix-address">.' +
			(rt.call_function('esc_html', [var_site_domain.clone()])).str() + '</span></div>')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install',
			[]rt.PhpVal{})))))
		{
			var_site = rt.new_string((rt.get_property(var_current_network, 'domain')).str() +
				(rt.get_property(var_current_network, 'path')).str() +
				(rt.call_function('__', [rt.new_string('sitename')])).str())
		} else {
			var_site = rt.new_string((rt.call_function('__', [rt.new_string('domain')])).str() +
				'.' + var_site_domain.str() + (rt.get_property(var_current_network, 'path')).str())
		}
		rt.call_function('printf', [rt.new_string('<p>(<strong>%s</strong>) %s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Your address will be %s.')]),
				var_site.clone(),
			]),
			rt.call_function('__', [
				rt.new_string('Must be at least 4 characters, letters and numbers only. It cannot be changed, so choose carefully!'),
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Title:')])
	// unsupported statement: Stmt_InlineHTML
	var_errmsg_blog_title = rt.call_method(rt.new_string(var_errors.str()), 'get_error_message', [
		rt.new_string('blog_title'),
	])
	var_errmsg_blog_title_aria = ''
	if rt.is_true(var_errmsg_blog_title) {
		var_errmsg_blog_title_aria = ' aria-describedby="wp-signup-blog-title-error"'
		print('<p class="error" id="wp-signup-blog-title-error">' + var_errmsg_blog_title.str() +
			'</p>')
	}
	print('<input name="blog_title" type="text" id="blog_title" value="' +
		(rt.call_function('esc_attr', [rt.new_string(blog_title)])).str() +
		'" required="required" autocomplete="off"' + var_errmsg_blog_title_aria + ' />')
	// unsupported statement: Stmt_InlineHTML
	var_languages = signup_get_available_languages()
	if !(!rt.is_true(var_languages)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Site Language:')])
		// unsupported statement: Stmt_InlineHTML
		var_lang = rt.call_function('get_site_option', [rt.new_string('WPLANG')])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('WPLANG')) {
			var_lang = rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG'))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_lang.clone(), var_languages.clone(), rt.new_bool(true)])))))
		{
			var_lang = rt.new_string('')
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
	var_blog_public_on_checked = ''
	var_blog_public_off_checked = ''
	if rt.get_superglobal('_POST').array_isset(rt.new_string('blog_public'))
		&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_superglobal('_POST').array_get(rt.new_string('blog_public')))) {
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
		rt.new_string(var_errors.str())])
}

fn validate_blog_form() rt.PhpVal {
	mut var_user := rt.new_null()
	var_user = rt.new_string('')
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	}
	return rt.call_function('wpmu_validate_blog_signup', [
		rt.get_superglobal('_POST').array_get(rt.new_string('blogname')),
		rt.get_superglobal('_POST').array_get(rt.new_string('blog_title')),
		var_user.clone(),
	])
}

fn show_user_form(user_name string, user_email string, errors string) {
	mut var_user_name := user_name
	mut var_user_email := user_email
	mut var_errors := errors
	mut var_errmsg_username := rt.new_null()
	mut var_errmsg_username_aria := ''
	mut var_errmsg_email := rt.new_null()
	mut var_errmsg_email_aria := ''
	mut var_errmsg_generic := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(var_errors.str()),
	])))))
	{
		var_errors = (create_wp_error()).str()
	}
	print('<label for="user_name">' + (rt.call_function('__', [rt.new_string('Username:')])).str() +
		'</label>')
	var_errmsg_username = rt.call_method(rt.new_string(var_errors.str()), 'get_error_message', [
		rt.new_string('user_name'),
	])
	var_errmsg_username_aria = ''
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
	var_errmsg_email = rt.call_method(rt.new_string(var_errors.str()), 'get_error_message', [
		rt.new_string('user_email'),
	])
	var_errmsg_email_aria = ''
	if rt.is_true(var_errmsg_email) {
		var_errmsg_email_aria = 'wp-signup-email-error '
		print('<p class="error" id="wp-signup-email-error">' + var_errmsg_email.str() + '</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(user_email)]))
	// unsupported statement: Stmt_InlineHTML
	print(var_errmsg_email_aria)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Your registration email is sent to this address. (Double-check your email address before continuing.)'),
	])
	// unsupported statement: Stmt_InlineHTML
	var_errmsg_generic = rt.call_method(rt.new_string(var_errors.str()), 'get_error_message', [
		rt.new_string('generic'),
	])
	if rt.is_true(var_errmsg_generic) {
		print('<p class="error" id="wp-signup-generic-error">' + var_errmsg_generic.str() + '</p>')
	}
	rt.call_function('do_action', [rt.new_string('signup_extra_fields'),
		rt.new_string(var_errors.str())])
}

fn validate_user_form() rt.PhpVal {
	return rt.call_function('wpmu_validate_user_signup', [
		rt.get_superglobal('_POST').array_get(rt.new_string('user_name')),
		rt.get_superglobal('_POST').array_get(rt.new_string('user_email')),
	])
}

fn signup_another_blog(blogname string, blog_title string, errors string) {
	mut var_blogname := blogname
	mut var_blog_title := blog_title
	mut var_errors := errors
	mut var_current_user := rt.new_null()
	mut var_signup_defaults := map[string]rt.PhpVal{}
	mut var_filtered_results := rt.new_null()
	mut var_blogs := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_home_url := rt.new_null()
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(var_errors.str()),
	])))))
	{
		var_errors = (create_wp_error()).str()
	}
	var_signup_defaults = {
		'blogname':   rt.new_string(var_blogname.str())
		'blog_title': rt.new_string(var_blog_title.str())
		'errors':     rt.new_string(var_errors.str())
	}
	var_filtered_results = rt.call_function('apply_filters', [
		rt.new_string('signup_another_blog_init'),
		rt.create_array_from_native_map(var_signup_defaults),
	])
	var_blogname = (var_filtered_results.array_get(rt.new_string('blogname'))).str()
	var_blog_title = (var_filtered_results.array_get(rt.new_string('blog_title'))).str()
	var_errors = (var_filtered_results.array_get(rt.new_string('errors'))).str()
	print('<h2>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Get <em>another</em> %s site in seconds')]), rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')])).str() +
		'</h2>')
	if rt.is_true(rt.call_method(rt.new_string(var_errors.str()), 'has_errors', []rt.PhpVal{})) {
		print('<p>' +
			(rt.call_function('__', [rt.new_string('There was a problem, please correct the form below and try again.')])).str() +
			'</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Welcome back, %s. By filling out the form below, you can <strong>add another site to your account</strong>. There is no limit to the number of sites you can have, so create to your heart&#8217;s content, but write responsibly!'),
		]),
		rt.get_property(var_current_user, 'display_name'),
	])
	// unsupported statement: Stmt_InlineHTML
	var_blogs = rt.call_function('get_blogs_of_user', [
		rt.get_property(var_current_user, 'ID'),
	])
	if !(!rt.is_true(var_blogs)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Sites you are already a member of:')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_blogs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_blog_shadow := item_1.val
			var_home_url = rt.call_function('get_home_url', [
				rt.get_property(var_blog_shadow, 'userblog_id'),
			])
			print('<li><a href="' + (rt.call_function('esc_url', [var_home_url.clone()])).str() +
				'">' + var_home_url.str() + '</a></li>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you are not going to use a great site domain, leave it for a new user. Now have at it!'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_hidden_fields'),
		rt.new_string('create-another-site')])
	// unsupported statement: Stmt_InlineHTML
	show_blog_form(var_blogname, var_blog_title, var_errors)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Create Site')])
	// unsupported statement: Stmt_InlineHTML
}

fn validate_another_blog_signup() bool {
	mut var_current_user := rt.new_null()
	mut var_result := rt.new_null()
	mut var_domain := rt.new_null()
	mut var_path := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_blog_title := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_public := rt.new_null()
	mut var_blog_meta_defaults := map[string]rt.PhpVal{}
	mut var_languages := rt.new_null()
	mut var_language := rt.new_null()
	mut var_meta_defaults := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_blog_id := rt.new_null()
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		exit(0)
	}
	var_result = validate_blog_form()
	var_domain = var_result.array_get(rt.new_string('domain'))
	var_path = var_result.array_get(rt.new_string('path'))
	var_blogname = var_result.array_get(rt.new_string('blogname'))
	var_blog_title = var_result.array_get(rt.new_string('blog_title'))
	var_errors = var_result.array_get(rt.new_string('errors'))
	if rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})) {
		signup_another_blog(var_blogname.clone(), var_blog_title.clone(), var_errors.clone())
		return false
	}
	var_public =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('blog_public'))).to_i64())
	var_blog_meta_defaults = {
		'lang_id': rt.new_int(1)
		'public':  var_public
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')))) {
		var_languages = signup_get_available_languages()
		if rt.is_true(rt.call_function('in_array', [
			rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')),
			var_languages.clone(),
			rt.new_bool(true),
		]))
		{
			var_language = rt.call_function('wp_unslash', [
				rt.call_function('sanitize_text_field', [
					rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')),
				]),
			])
			if rt.is_true(var_language) {
				var_blog_meta_defaults['WPLANG'] = var_language.clone()
			}
		}
	}
	var_meta_defaults = rt.call_function('apply_filters_deprecated', [
		rt.new_string('signup_create_blog_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_blog_meta_defaults }]),
		rt.new_string('3.0.0'),
		rt.new_string('add_signup_meta'),
	])
	var_meta = rt.call_function('apply_filters', [rt.new_string('add_signup_meta'),
		var_meta_defaults.clone()])
	var_blog_id = rt.call_function('wpmu_create_blog', [var_domain.clone(),
		var_path.clone(), var_blog_title.clone(), rt.get_property(var_current_user, 'ID'),
		var_meta.clone(), rt.call_function('get_current_network_id', []rt.PhpVal{})])
	if rt.is_true(rt.call_function('is_wp_error', [var_blog_id.clone()])) {
		return false
	}
	confirm_another_blog_signup(var_domain.clone(), var_path.clone(), var_blog_title.clone(), rt.get_property(var_current_user,
		'user_login'), rt.get_property(var_current_user, 'user_email'), var_meta.clone(),
		var_blog_id.clone())
	return true
}

fn confirm_another_blog_signup(var_domain rt.PhpVal, var_path rt.PhpVal, var_blog_title rt.PhpVal, var_user_name rt.PhpVal, user_email string, var_meta rt.PhpVal, blog_id i64) {
	mut var_user_email := user_email
	mut var_blog_id := blog_id
	mut var_home_url := rt.new_null()
	mut var_login_url := rt.new_null()
	mut var_site := rt.new_null()
	if var_blog_id != 0 {
		rt.call_function('switch_to_blog', [rt.new_int(blog_id)])
		var_home_url = rt.call_function('home_url', [rt.new_string('/')])
		var_login_url = rt.call_function('wp_login_url', []rt.PhpVal{})
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	} else {
		var_home_url = rt.new_string('http://' + var_domain.str() + var_path.str())
		var_login_url =
			rt.new_string('http://' + var_domain.str() + var_path.str() + 'wp-login.php')
	}
	var_site = rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'),
		rt.call_function('esc_url', [var_home_url.clone()]), var_blog_title.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('The site %s is yours.')]),
		var_site.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('%1$s is your new site. <a href="%2$s">Log in</a> as &#8220;%3$s&#8221; using your existing password.'),
		]),
		rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [var_home_url.clone()]),
			rt.call_function('untrailingslashit',
				[rt.new_string(var_domain.str() + var_path.str())]),
		]),
		rt.call_function('esc_url', [
			var_login_url.clone(),
		]),
		var_user_name.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_finished')])
}

fn signup_user(user_name string, user_email string, errors string) {
	mut var_user_name := user_name
	mut var_user_email := user_email
	mut var_errors := errors
	mut var_active_signup := rt.new_null()
	mut var_signup_for := rt.new_null()
	mut var_signup_user_defaults := map[string]rt.PhpVal{}
	mut var_filtered_results := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(var_errors.str()),
	])))))
	{
		var_errors = (create_wp_error()).str()
	}
	var_signup_for = if rt.get_superglobal('_POST').array_isset(rt.new_string('signup_for')) { rt.call_function('esc_html', [
			rt.get_superglobal('_POST').array_get(rt.new_string('signup_for')),
		]) } else { rt.new_string('blog') }
	var_signup_user_defaults = {
		'user_name':  rt.new_string(var_user_name.str())
		'user_email': rt.new_string(var_user_email.str())
		'errors':     rt.new_string(var_errors.str())
	}
	var_filtered_results = rt.call_function('apply_filters', [
		rt.new_string('signup_user_init'),
		rt.create_array_from_native_map(var_signup_user_defaults),
	])
	var_user_name = (var_filtered_results.array_get(rt.new_string('user_name'))).str()
	var_user_email = (var_filtered_results.array_get(rt.new_string('user_email'))).str()
	var_errors = (var_filtered_results.array_get(rt.new_string('errors'))).str()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Get your own %s account in seconds')]),
		rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_hidden_fields'),
		rt.new_string('validate-user')])
	// unsupported statement: Stmt_InlineHTML
	show_user_form(var_user_name, var_user_email, var_errors)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup)) {
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_string('user'), var_active_signup)) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Create a site or only a username:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_signup_for.clone(), rt.new_string('blog')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Gimme a site!')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_signup_for.clone(), rt.new_string('user')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Just a username, please.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Next')])
	// unsupported statement: Stmt_InlineHTML
}

fn validate_user_signup() bool {
	mut var_result := rt.new_null()
	mut var_user_name := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_errors := rt.new_null()
	var_result = validate_user_form()
	var_user_name = var_result.array_get(rt.new_string('user_name'))
	var_user_email = var_result.array_get(rt.new_string('user_email'))
	var_errors = var_result.array_get(rt.new_string('errors'))
	if rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})) {
		signup_user(var_user_name.clone(), var_user_email.clone(), var_errors.clone())
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('blog'),
		rt.get_superglobal('_POST').array_get(rt.new_string('signup_for'))))
	{
		signup_blog(var_user_name.clone(), var_user_email.clone(), '', '', '')
		return false
	}
	rt.call_function('wpmu_signup_user', [var_user_name.clone(),
		var_user_email.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('add_signup_meta'),
			rt.new_array(),
		])])
	confirm_user_signup(var_user_name.clone(), var_user_email.clone())
	return true
}

fn confirm_user_signup(var_user_name rt.PhpVal, var_user_email rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%s is your new username')]),
		var_user_name.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('But, before you can start using your new username, <strong>you must activate it</strong>.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Check your inbox at %s and click on the given link.'),
		]),
		rt.new_string('<strong>' + var_user_email.str() + '</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you do not activate your username within two days, you will have to sign up again.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_finished')])
}

fn signup_blog(user_name string, user_email string, blogname string, blog_title string, errors string) {
	mut var_user_name := user_name
	mut var_user_email := user_email
	mut var_blogname := blogname
	mut var_blog_title := blog_title
	mut var_errors := errors
	mut var_signup_blog_defaults := map[string]rt.PhpVal{}
	mut var_filtered_results := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.new_string(var_errors.str()),
	])))))
	{
		var_errors = (create_wp_error()).str()
	}
	var_signup_blog_defaults = {
		'user_name':  rt.new_string(var_user_name.str())
		'user_email': rt.new_string(var_user_email.str())
		'blogname':   rt.new_string(var_blogname.str())
		'blog_title': rt.new_string(var_blog_title.str())
		'errors':     rt.new_string(var_errors.str())
	}
	var_filtered_results = rt.call_function('apply_filters', [
		rt.new_string('signup_blog_init'),
		rt.create_array_from_native_map(var_signup_blog_defaults),
	])
	var_user_name = (var_filtered_results.array_get(rt.new_string('user_name'))).str()
	var_user_email = (var_filtered_results.array_get(rt.new_string('user_email'))).str()
	var_blogname = (var_filtered_results.array_get(rt.new_string('blogname'))).str()
	var_blog_title = (var_filtered_results.array_get(rt.new_string('blog_title'))).str()
	var_errors = (var_filtered_results.array_get(rt.new_string('errors'))).str()
	if var_blogname == '' {
		var_blogname = var_user_name
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_user_name.str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_user_email.str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_hidden_fields'),
		rt.new_string('validate-site')])
	// unsupported statement: Stmt_InlineHTML
	show_blog_form(var_blogname, var_blog_title, var_errors)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Sign up')])
	// unsupported statement: Stmt_InlineHTML
}

fn validate_blog_signup() bool {
	mut var_user_result := rt.new_null()
	mut var_user_name := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_user_errors := rt.new_null()
	mut var_result := rt.new_null()
	mut var_domain := rt.new_null()
	mut var_path := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_blog_title := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_public := rt.new_null()
	mut var_signup_meta := map[string]rt.PhpVal{}
	mut var_languages := rt.new_null()
	mut var_language := rt.new_null()
	mut var_meta := rt.new_null()
	var_user_result = rt.call_function('wpmu_validate_user_signup', [
		rt.get_superglobal('_POST').array_get(rt.new_string('user_name')),
		rt.get_superglobal('_POST').array_get(rt.new_string('user_email')),
	])
	var_user_name = var_user_result.array_get(rt.new_string('user_name'))
	var_user_email = var_user_result.array_get(rt.new_string('user_email'))
	var_user_errors = var_user_result.array_get(rt.new_string('errors'))
	if rt.is_true(rt.call_method(var_user_errors, 'has_errors', []rt.PhpVal{})) {
		signup_user(var_user_name.clone(), var_user_email.clone(), var_user_errors.clone())
		return false
	}
	var_result = rt.call_function('wpmu_validate_blog_signup', [
		rt.get_superglobal('_POST').array_get(rt.new_string('blogname')),
		rt.get_superglobal('_POST').array_get(rt.new_string('blog_title')),
	])
	var_domain = var_result.array_get(rt.new_string('domain'))
	var_path = var_result.array_get(rt.new_string('path'))
	var_blogname = var_result.array_get(rt.new_string('blogname'))
	var_blog_title = var_result.array_get(rt.new_string('blog_title'))
	var_errors = var_result.array_get(rt.new_string('errors'))
	if rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})) {
		signup_blog(var_user_name.clone(), var_user_email.clone(), var_blogname.clone(),
			var_blog_title.clone(), var_errors.clone())
		return false
	}
	var_public =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('blog_public'))).to_i64())
	var_signup_meta = {
		'lang_id': rt.new_int(1)
		'public':  var_public
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')))) {
		var_languages = signup_get_available_languages()
		if rt.is_true(rt.call_function('in_array', [
			rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')),
			var_languages.clone(),
			rt.new_bool(true),
		]))
		{
			var_language = rt.call_function('wp_unslash', [
				rt.call_function('sanitize_text_field', [
					rt.get_superglobal('_POST').array_get(rt.new_string('WPLANG')),
				]),
			])
			if rt.is_true(var_language) {
				var_signup_meta['WPLANG'] = var_language.clone()
			}
		}
	}
	var_meta = rt.call_function('apply_filters', [rt.new_string('add_signup_meta'),
		rt.create_array_from_native_map(var_signup_meta)])
	rt.call_function('wpmu_signup_blog', [var_domain.clone(),
		var_path.clone(), var_blog_title.clone(), var_user_name.clone(),
		var_user_email.clone(), var_meta.clone()])
	confirm_blog_signup(var_domain.clone(), var_path.clone(), var_blog_title.clone(),
		var_user_name.clone(), var_user_email.clone(), var_meta.clone())
	return true
}

fn confirm_blog_signup(var_domain rt.PhpVal, var_path rt.PhpVal, var_blog_title rt.PhpVal, user_name string, user_email string, var_meta rt.PhpVal) {
	mut var_user_name := user_name
	mut var_user_email := user_email
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Congratulations! Your new site, %s, is almost ready.'),
		]),
		rt.new_string("<a href='http://${var_domain.to_string()}${var_path.to_string()}'>${var_blog_title.to_string()}</a>"),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('But, before you can start using your site, <strong>you must activate it</strong>.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Check your inbox at %s and click on the given link.'),
		]),
		rt.new_string('<strong>' + var_user_email + '</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you do not activate your site within two days, you will have to sign up again.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Still waiting for your email?')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('If you have not received your email yet, there are a number of things you can do:'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Wait a little longer. Sometimes delivery of email can be delayed by processes outside of our control.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Check the junk or spam folder of your email client. Sometime emails wind up there by mistake.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Have you entered your email correctly? You have entered %s, if it&#8217;s incorrect, you will not receive your email.'),
		]),
		rt.new_string(var_user_email.str()),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('signup_finished')])
}

fn signup_get_available_languages() rt.PhpVal {
	mut var_languages := rt.new_null()
	var_languages = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('signup_get_available_languages'),
		rt.call_function('get_available_languages', []rt.PhpVal{}),
	]))
	return rt.call_function('array_intersect_assoc', [var_languages.clone(),
		rt.call_function('get_available_languages', []rt.PhpVal{})])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
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
	if rt.call_function('get_site_option', [rt.new_string('illegal_names')]).is_array()
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('new'))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('new')), rt.call_function('get_site_option', [rt.new_string('illegal_names')]), rt.new_bool(true)])) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_home_url', []rt.PhpVal{}),
		])
		exit(0)
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('do_signup_header')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('wp_registration_url', []rt.PhpVal{}),
		])
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_site_url', [rt.new_string('wp-signup.php')]),
		])
		exit(0)
	}
	rt.set_property(var_wp_query, 'is_404', rt.new_bool(false))
	rt.call_function('do_action', [rt.new_string('before_signup_header')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wpmu_signup_stylesheet')])
	rt.call_function('get_header', [rt.new_string('wp-signup')])
	rt.call_function('do_action', [rt.new_string('before_signup_form')])
	// unsupported statement: Stmt_InlineHTML
	mut var_active_signup := rt.call_function('get_site_option', [
		rt.new_string('registration'),
		rt.new_string('none'),
	])
	var_active_signup = rt.call_function('apply_filters', [
		rt.new_string('wpmu_active_signup'),
		var_active_signup.clone(),
	])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network')])) {
		print('<div class="mu_alert">')
		rt.call_function('_e', [rt.new_string('Greetings Network Administrator!')])
		print(' ')
		mut switch_val_1 := var_active_signup
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('none'))) {
			rt.call_function('_e', [
				rt.new_string('The network currently disallows registrations.'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog'))) {
			rt.call_function('_e', [
				rt.new_string('The network currently allows site registrations.'),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('user'))) {
			rt.call_function('_e', [
				rt.new_string('The network currently allows user registrations.'),
			])
		} else {
			rt.call_function('_e', [
				rt.new_string('The network currently allows both site and user registrations.'),
			])
		}
		print(' ')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('To change or disable registration go to your <a href="%s">Options page</a>.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('network_admin_url', [rt.new_string('settings.php')]),
			]),
		])
		print('</div>')
	}
	mut var_newblogname := if rt.get_superglobal('_GET').array_isset(rt.new_string('new')) { rt.new_string(rt.call_function('preg_replace', [
			rt.new_string('/^-|-$|[^-a-zA-Z0-9]/'),
			rt.new_string(''),
			rt.get_superglobal('_GET').array_get(rt.new_string('new')),
		]).to_string().to_lower()) } else { rt.new_null() }
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('none'), var_active_signup)) {
		rt.call_function('_e', [rt.new_string('Registration has been disabled.')])
	} else if rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		mut var_login_url := rt.call_function('wp_login_url', [
			rt.call_function('network_site_url', [rt.new_string('wp-signup.php')]),
		])
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('You must first <a href="%s">log in</a>, and then you can create a new site.'),
			]),
			var_login_url.clone(),
		])
	} else {
		mut var_stage := if !(rt.get_superglobal('_POST').array_get(rt.new_string('stage'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('stage'))
		} else {
			rt.new_string('default')
		}
		mut switch_val_2 := var_stage
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('validate-user-signup'))) {
			if (rt.is_true(rt.identical(rt.new_string('all'), var_active_signup))|| (rt.is_true(rt.identical(rt.new_string('blog'), rt.get_superglobal('_POST').array_get(rt.new_string('signup_for'))))
				&& rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup))))|| (rt.is_true(rt.identical(rt.new_string('user'), rt.get_superglobal('_POST').array_get(rt.new_string('signup_for'))))
				&& rt.is_true(rt.identical(rt.new_string('user'), var_active_signup))) {
				rt.new_bool(validate_user_signup())
			} else {
				rt.call_function('_e', [
					rt.new_string('User registration has been disabled.'),
				])
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('validate-blog-signup'))) {
			if rt.is_true(rt.identical(rt.new_string('all'), var_active_signup))
				|| rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup)) {
				rt.new_bool(validate_blog_signup())
			} else {
				rt.call_function('_e', [
					rt.new_string('Site registration has been disabled.'),
				])
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('gimmeanotherblog'))) {
			rt.new_bool(validate_another_blog_signup())
		} else {
			mut var_user_email := if !(rt.get_superglobal('_POST').array_get(rt.new_string('user_email'))).is_null() {
				rt.get_superglobal('_POST').array_get(rt.new_string('user_email'))
			} else {
				rt.new_string('')
			}
			rt.call_function('do_action', [rt.new_string('preprocess_signup_form')])
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
				&& rt.is_true(rt.identical(rt.new_string('all'), var_active_signup))
				|| rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup)) {
				signup_another_blog(var_newblogname.clone(), '', '')
			} else if
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
				&& rt.is_true(rt.identical(rt.new_string('all'), var_active_signup))
				|| rt.is_true(rt.identical(rt.new_string('user'), var_active_signup)) {
				signup_user(var_newblogname.clone(), var_user_email.clone(), '')
			} else if
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
				&& rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup)) {
				rt.call_function('_e', [
					rt.new_string('Sorry, new registrations are not allowed at this time.'),
				])
			} else {
				rt.call_function('_e', [
					rt.new_string('You are logged in already. No need to register again!'),
				])
			}
			if rt.is_true(var_newblogname) {
				mut var_newblog := rt.call_function('get_blogaddress_by_name', [
					var_newblogname.clone(),
				])
				if rt.is_true(rt.identical(rt.new_string('blog'), var_active_signup))
					|| rt.is_true(rt.identical(rt.new_string('all'), var_active_signup)) {
					rt.call_function('printf', [
						rt.new_string('<p>' +
							(rt.call_function('__', [rt.new_string('The site you were looking for, %s, does not exist, but you can create it now!')])).str() +
							'</p>'),
						rt.new_string('<strong>' + var_newblog.str() + '</strong>'),
					])
				} else {
					rt.call_function('printf', [
						rt.new_string('<p>' +
							(rt.call_function('__', [rt.new_string('The site you were looking for, %s, does not exist.')])).str() +
							'</p>'),
						rt.new_string('<strong>' + var_newblog.str() + '</strong>'),
					])
				}
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('after_signup_form')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('get_footer', [rt.new_string('wp-signup')])
}
