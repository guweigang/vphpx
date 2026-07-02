import rt

const global_const_wp_installing = true

fn do_activate_header() {
	rt.call_function('do_action', [rt.new_string('activate_wp_head')])
}

fn wpmu_activate_stylesheet() {
	// unsupported statement: Stmt_InlineHTML
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_activate_path := rt.new_null()
	mut var_wp_query := rt.new_null()
	rt.include_file(@DIR + '/wp-load.php', '3')
	rt.include_file(@DIR + '/wp-blog-header.php', '3')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('wp_registration_url', []rt.PhpVal{}),
		])
		exit(0)
	}
	mut var_valid_error_codes := ['already_active', 'blog_taken']
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string('?'),
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])
	var_activate_path = list_tmp_1.array_get(0)
	mut var_activate_cookie := rt.new_string('wp-activate-' + (rt.get_constant('COOKIEHASH')).str())
	mut var_key := rt.new_string('')
	mut var_result := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('key'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('key'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(rt.new_string('key')), rt.get_superglobal('_POST').array_get(rt.new_string('key')))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('A key value mismatch has been detected. Please follow the link provided in your activation email.'),
			]),
			rt.call_function('__', [
				rt.new_string('An error occurred during the activation'),
			]),
			rt.new_int(400),
		])
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('key')))) {
		var_key = rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_GET').array_get(rt.new_string('key')),
		])
	} else if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('key')))) {
		var_key = rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_POST').array_get(rt.new_string('key')),
		])
	}
	if rt.is_true(var_key) {
		mut var_redirect_url := rt.call_function('remove_query_arg', [
			rt.new_string('key'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('remove_query_arg', [
			rt.new_bool(false),
		]), var_redirect_url))))
		{
			rt.call_function('setcookie', [var_activate_cookie.clone(),
				var_key.clone(), rt.new_int(0), var_activate_path.clone(),
				rt.get_constant('COOKIE_DOMAIN'), rt.call_function('is_ssl', []rt.PhpVal{}),
				rt.new_bool(true)])
			rt.call_function('wp_safe_redirect', [var_redirect_url.clone()])
			exit(0)
		} else {
			var_result = rt.call_function('wpmu_activate_signup', [
				var_key.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_result))
		&& rt.get_superglobal('_COOKIE').array_isset(var_activate_cookie) {
		var_key = rt.get_superglobal('_COOKIE').array_get(var_activate_cookie)
		var_result = rt.call_function('wpmu_activate_signup', [
			var_key.clone()])
		rt.call_function('setcookie', [var_activate_cookie.clone(),
			rt.new_string(' '),
			rt.sub(rt.call_function('time', []rt.PhpVal{}),
				rt.get_constant('YEAR_IN_SECONDS')),
			var_activate_path.clone(), rt.get_constant('COOKIE_DOMAIN'),
			rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
	}
	if rt.is_true(rt.identical(rt.new_null(), var_result))
		|| (rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))
		&& rt.is_true(rt.identical(rt.new_string('invalid_key'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})))) {
		rt.call_function('status_header', [rt.new_int(404)])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut var_error_code := rt.call_method(var_result, 'get_error_code', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_error_code.clone(), rt.create_array_from_list(var_valid_error_codes),
			rt.new_bool(true)])))))
		{
			rt.call_function('status_header', [rt.new_int(400)])
		}
	}
	rt.call_function('nocache_headers', []rt.PhpVal{})
	rt.set_property(var_wp_query, 'is_404', rt.new_bool(false))
	rt.call_function('do_action', [rt.new_string('activate_header')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('do_activate_header')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wpmu_activate_stylesheet')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_strict_cross_origin_referrer')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_sensitive_page')])
	rt.call_function('get_header', [rt.new_string('wp-activate')])
	mut var_blog_details := rt.call_function('get_site', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_key)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Activation Key Required')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('network_site_url', [
				rt.new_string((rt.get_property(var_blog_details, 'path')).str() + 'wp-activate.php'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Activation Key:')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Activate')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))
			&& rt.is_true(rt.call_function('in_array', [rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}), rt.create_array_from_list(var_valid_error_codes), rt.new_bool(true)])) {
			mut var_signup := rt.call_method(var_result, 'get_error_data', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Your account is now active!')])
			// unsupported statement: Stmt_InlineHTML
			print('<p class="lead-in">')
			if rt.is_true(rt.identical(rt.new_string(''),
				(rt.get_property(var_signup, 'domain')).str() +
				(rt.get_property(var_signup, 'path')).str()))
			{
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('Your account has been activated. You may now <a href="%1$s">log in</a> to the site using your chosen username of &#8220;%2$s&#8221;. Please check your email inbox at %3$s for your password and login instructions. If you do not receive an email, please check your junk or spam folder. If you still do not receive an email within an hour, you can <a href="%4$s">reset your password</a>.'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('network_site_url', [
							rt.new_string((rt.get_property(var_blog_details, 'path')).str() +
								'wp-login.php'),
							rt.new_string('login'),
						]),
					]),
					rt.call_function('esc_html', [
						rt.get_property(var_signup, 'user_login'),
					]),
					rt.call_function('esc_html', [
						rt.get_property(var_signup, 'user_email'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wp_lostpassword_url', []rt.PhpVal{}),
					]),
				])
			} else {
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('Your site at %1$s is active. You may now log in to your site using your chosen username of &#8220;%2$s&#8221;. Please check your email inbox at %3$s for your password and login instructions. If you do not receive an email, please check your junk or spam folder. If you still do not receive an email within an hour, you can <a href="%4$s">reset your password</a>.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="http://%1$s">%1$s</a>'),
						rt.call_function('esc_url', [
							rt.new_string((rt.get_property(var_signup, 'domain')).str() +
								(rt.get_property(var_blog_details, 'path')).str()),
						]),
					]),
					rt.call_function('esc_html', [
						rt.get_property(var_signup, 'user_login'),
					]),
					rt.call_function('esc_html', [
						rt.get_property(var_signup, 'user_email'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wp_lostpassword_url', []rt.PhpVal{}),
					]),
				])
			}
			print('</p>')
		} else if rt.is_true(rt.identical(rt.new_null(), var_result))
			|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('An error occurred during the activation'),
			])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			mut var_url := if var_result.array_isset(rt.new_string('blog_id')) { rt.call_function('esc_url', [
					rt.call_function('get_home_url', [
						rt.new_int((var_result.array_get(rt.new_string('blog_id'))).to_i64()),
					]),
				]) } else { rt.new_string('') }
			mut var_user := rt.call_function('get_userdata', [
				rt.new_int((var_result.array_get(rt.new_string('user_id'))).to_i64()),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Your account is now active!')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Username:')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_user, 'user_login'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Password:')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_result.array_get(rt.new_string('password')),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_url)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('network_home_url', [rt.new_string(''), rt.new_string('http')]), var_url)))) {
				rt.call_function('switch_to_blog', [
					rt.new_int((var_result.array_get(rt.new_string('blog_id'))).to_i64()),
				])
				mut var_login_url := rt.call_function('wp_login_url', []rt.PhpVal{})
				rt.call_function('restore_current_blog', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('Your account is now activated. <a href="%1$s">View your site</a> or <a href="%2$s">Log in</a>'),
					]),
					rt.call_function('esc_url', [
						var_url.clone(),
					]),
					rt.call_function('esc_url', [
						var_login_url.clone(),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.call_function('__', [
						rt.new_string('Your account is now activated. <a href="%1$s">Log in</a> or go back to the <a href="%2$s">homepage</a>.'),
					]),
					rt.call_function('esc_url', [
						rt.call_function('network_site_url', [
							rt.new_string((rt.get_property(var_blog_details, 'path')).str() +
								'wp-login.php'),
							rt.new_string('login'),
						]),
					]),
					rt.call_function('esc_url', [
						rt.call_function('network_home_url', [
							rt.get_property(var_blog_details, 'path'),
						]),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('get_footer', [rt.new_string('wp-activate')])
}
