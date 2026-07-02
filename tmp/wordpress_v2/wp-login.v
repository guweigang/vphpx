import rt

fn login_header(var_title_arg rt.PhpVal, message string, var_wp_error_arg rt.PhpVal) {
	mut var_message := message
	mut var_title := var_title_arg
	mut var_wp_error := var_wp_error_arg
	mut var_error := rt.new_null()
	mut var_interim_login := rt.new_null()
	mut var_action := rt.new_null()
	mut var_shake_error_codes := rt.new_null()
	mut var_login_title := rt.new_null()
	mut var_login_header_url := rt.new_null()
	mut var_login_header_title := rt.new_null()
	mut var_login_header_text := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_error_list := []rt.PhpVal{}
	mut var_messages := rt.new_null()
	mut var_code := rt.new_null()
	mut var_severity := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_item := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_title)) {
		var_title = rt.call_function('__', [rt.new_string('Log In')])
	}
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_sensitive_page')])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_strict_cross_origin_referrer')])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_login_viewport_meta')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_wp_error,
	])))))
	{
		var_wp_error = create_wp_error()
	}
	var_shake_error_codes = rt.create_array([
		rt.ArrayItem{ key: none, val: 'empty_password' },
		rt.ArrayItem{ key: none, val: 'empty_email' },
		rt.ArrayItem{ key: none, val: 'invalid_email' },
		rt.ArrayItem{ key: none, val: 'invalidcombo' },
		rt.ArrayItem{ key: none, val: 'empty_username' },
		rt.ArrayItem{ key: none, val: 'invalid_username' },
		rt.ArrayItem{ key: none, val: 'incorrect_password' },
		rt.ArrayItem{ key: none, val: 'retrieve_password_email_failure' },
	])
	var_shake_error_codes = rt.call_function('apply_filters', [
		rt.new_string('shake_error_codes'),
		var_shake_error_codes.clone(),
	])
	if rt.is_true(var_shake_error_codes) && rt.is_true(var_wp_error.has_errors())
		&& rt.is_true(rt.call_function('in_array', [var_wp_error.get_error_code(), var_shake_error_codes.clone(), rt.new_bool(true)])) {
		rt.call_function('add_action', [rt.new_string('login_footer'),
			rt.new_string('wp_shake_js'), rt.new_int(12)])
	}
	var_login_title = rt.call_function('get_bloginfo', [rt.new_string('name'),
		rt.new_string('display')])
	var_login_title = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s &lsaquo; %2$s &#8212; WordPress')]),
		var_title.clone(),
		var_login_title.clone(),
	])
	if rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
		var_login_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Recovery Mode &#8212; %s')]),
			var_login_title.clone(),
		])
	}
	var_login_title = rt.call_function('apply_filters', [rt.new_string('login_title'),
		var_login_title.clone(), var_title.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_login_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_enqueue_style', [rt.new_string('login')])
	if rt.is_true(rt.identical(rt.new_string('loggedout'), var_wp_error.get_error_code())) {
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_print_inline_script_tag', [
			rt.call_function('wp_remove_surrounding_empty_script_tags', [
				rt.call_function('ob_get_clean', []rt.PhpVal{}),
			]),
		])
	}
	rt.call_function('do_action', [rt.new_string('login_enqueue_scripts')])
	rt.call_function('do_action', [rt.new_string('login_head')])
	var_login_header_url = rt.call_function('__', [
		rt.new_string('https://wordpress.org/'),
	])
	var_login_header_url = rt.call_function('apply_filters', [
		rt.new_string('login_headerurl'),
		var_login_header_url.clone(),
	])
	var_login_header_title = rt.new_string('')
	var_login_header_title = rt.call_function('apply_filters_deprecated', [
		rt.new_string('login_headertitle'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_login_header_title }]),
		rt.new_string('5.2.0'),
		rt.new_string('login_headertext'),
		rt.call_function('__', [
			rt.new_string('Usage of the title attribute on the login logo is not recommended for accessibility reasons. Use the link text instead.'),
		]),
	])
	var_login_header_text = if !rt.is_true(var_login_header_title) { rt.call_function('__', [
			rt.new_string('Powered by WordPress'),
		]) } else { var_login_header_title }
	var_login_header_text = rt.call_function('apply_filters', [
		rt.new_string('login_headertext'),
		var_login_header_text.clone(),
	])
	var_classes = rt.create_array([
		rt.ArrayItem{ key: none, val: 'login-action-' + var_action.str() },
		rt.ArrayItem{ key: none, val: 'wp-core-ui' },
		rt.ArrayItem{ key: none, val: 'admin-color-modern' },
	])
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_classes.array_push('rtl')
	}
	if rt.is_true(var_interim_login) {
		var_classes.array_push('interim-login')
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('success'), var_interim_login)) {
			var_classes.array_push('interim-login-success')
		}
	}
	var_classes.array_push('locale-' +(rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_locale', []rt.PhpVal{})]).to_string().to_lower())])).str())
	var_classes = rt.call_function('apply_filters', [rt.new_string('login_body_class'),
		var_classes.clone(), var_action.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_classes.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [
		rt.new_string("document.body.className = document.body.className.replace('no-js','js');"),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('login_header')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('confirm_admin_email'), var_action))))
		&& !(!rt.is_true(var_title)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_login_header_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_login_header_text)
	// unsupported statement: Stmt_InlineHTML
	var_message = (rt.call_function('apply_filters', [rt.new_string('login_message'),
		rt.new_string(var_message.str())])).str()
	if !(var_message == '') {
		print(var_message + '\n')
	}
	if !(!rt.is_true(var_error)) {
		var_wp_error.add(rt.new_string('error'), var_error.clone())
		var_error = rt.new_null()
	}
	if rt.is_true(var_wp_error.has_errors()) {
		var_error_list = []rt.PhpVal{}
		var_messages = rt.new_string('')
		mut iter_1 := var_wp_error.get_error_codes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_code_shadow := item_1.val
			var_severity = var_wp_error.get_error_data(var_code_shadow.clone())
			mut iter_2 := var_wp_error.get_error_messages(var_code_shadow.clone()).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_error_message_shadow := item_2.val
				if rt.is_true(rt.identical(rt.new_string('message'), var_severity)) {
					var_messages = rt.concat(var_messages, rt.new_string('<p>' +
						var_error_message_shadow.str() + '</p>'))
				} else {
					var_error_list << var_error_message_shadow.clone()
				}
			}
		}
		if !(!rt.is_true(var_error_list)) {
			var_errors = rt.new_string('')
			if var_error_list.len > 1 {
				var_errors = rt.concat(var_errors, rt.new_string('<ul class="login-error-list">'))
				for var_item_shadow in var_error_list {
					var_errors = rt.concat(var_errors, rt.new_string('<li>' +
						var_item_shadow.str() + '</li>'))
				}
				var_errors = rt.concat(var_errors, rt.new_string('</ul>'))
			} else {
				var_errors = rt.concat(var_errors, rt.new_string('<p>' +
					(var_error_list[0]).str() + '</p>'))
			}
			var_errors = rt.call_function('apply_filters', [
				rt.new_string('login_errors'),
				var_errors.clone(),
			])
			rt.call_function('wp_admin_notice', [var_errors.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
					rt.ArrayItem{ key: 'id', val: 'login_error' },
					rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
		if !(!rt.is_true(var_messages)) {
			var_messages = rt.call_function('apply_filters', [
				rt.new_string('login_messages'),
				var_messages.clone(),
			])
			rt.call_function('wp_admin_notice', [var_messages.clone(),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
					rt.ArrayItem{ key: 'id', val: 'login-message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'message' },
					]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
	}
}

fn login_footer(input_id string) {
	mut var_input_id := input_id
	mut var_interim_login := rt.new_null()
	mut var_html_link := rt.new_null()
	mut var_languages := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_interim_login)))) {
		// unsupported statement: Stmt_InlineHTML
		var_html_link = rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('home_url', [rt.new_string('/')]),
			]),
			rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('&larr; Go to %s'),
					rt.new_string('site')]),
				rt.call_function('get_bloginfo', [rt.new_string('title'),
					rt.new_string('display')]),
			]),
		])
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('login_site_html_link'),
			var_html_link.clone(),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_privacy_policy_link', [
			rt.new_string('<div class="privacy-policy-page-link">'),
			rt.new_string('</div>'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_interim_login))))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('login_display_language_dropdown'), rt.new_bool(true)])) {
		var_languages = rt.call_function('get_available_languages', []rt.PhpVal{})
		if !(!rt.is_true(var_languages)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Language')])
			// unsupported statement: Stmt_InlineHTML
			var_args = {
				'id':                          rt.new_string('language-switcher-locales')
				'name':                        rt.new_string('wp_lang')
				'selected':                    rt.call_function('determine_locale', []rt.PhpVal{})
				'show_available_translations': rt.new_bool(false)
				'explicit_option_en_us':       rt.new_bool(true)
				'languages':                   var_languages
			}
			rt.call_function('wp_dropdown_languages', [
				rt.call_function('apply_filters', [
					rt.new_string('login_language_dropdown_args'),
					rt.create_array_from_native_map(var_args),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_interim_login) {
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect_to'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to')))))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('sanitize_url', [
					rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_GET').array_get(rt.new_string('action')))))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.get_superglobal('_GET').array_get(rt.new_string('action')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Change')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(input_id == '') {
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		print(var_input_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_print_inline_script_tag', [
			rt.call_function('wp_remove_surrounding_empty_script_tags', [
				rt.call_function('ob_get_clean', []rt.PhpVal{}),
			]),
		])
	}
	rt.call_function('do_action', [rt.new_string('login_footer')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_shake_js() {
	rt.call_function('wp_print_inline_script_tag', [
		rt.new_string("document.querySelector('form').classList.add('shake');"),
	])
}

fn wp_login_viewport_meta() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_PasswordHash {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_passwordhash(_args ...rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
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

fn (mut this Class_PasswordHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PasswordHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PasswordHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_rp_path := rt.new_null()
	mut var_rp_login := rt.new_null()
	mut var_rp_key := rt.new_null()
	mut var_error := rt.new_null()
	rt.include_file(@DIR + '/wp-load.php', '3')
	if rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('str_starts_with', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			rt.new_string('http'),
		]))
		{
			rt.call_function('wp_safe_redirect', [
				rt.call_function('set_url_scheme', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					rt.new_string('https'),
				]),
			])
			exit(0)
		} else {
			rt.call_function('wp_safe_redirect', [
				rt.new_string('https://' +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
			])
			exit(0)
		}
	}
	mut var_action := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')).is_string() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))
	} else {
		rt.new_string('login')
	}
	mut var_errors := create_wp_error()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) {
		var_action = rt.new_string('resetpass')
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('checkemail')) {
		var_action = rt.new_string('checkemail')
	}
	mut var_default_actions := [rt.new_string('confirm_admin_email'),
		rt.new_string('postpass'), rt.new_string('logout'), rt.new_string('lostpassword'),
		rt.new_string('retrievepassword'), rt.new_string('resetpass'),
		rt.new_string('rp'), rt.new_string('register'), rt.new_string('checkemail'),
		rt.new_string('confirmaction'), rt.new_string('login'),
		Class_WP_Recovery_Mode_Link_Service.login_action_entered()]
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action.clone(), rt.create_array_from_list(var_default_actions), rt.new_bool(true)])))))
		&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_filter', [rt.new_string('login_form_' + var_action.str())]))) {
		var_action = rt.new_string('login')
	}
	rt.call_function('nocache_headers', []rt.PhpVal{})
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('get_bloginfo', [rt.new_string('html_type')])).str() + '; charset=' +
			(rt.call_function('get_bloginfo', [rt.new_string('charset')])).str()),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('RELOCATE')]))
		&& rt.is_true(rt.get_constant('RELOCATE')) {
		if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PATH_INFO'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO')), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')))))) {
			rt.get_superglobal('_SERVER').array_set('PHP_SELF', rt.call_function('str_replace', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('PATH_INFO')),
				rt.new_string(''),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
			]))
		}
		mut var_url := rt.call_function('dirname', [
			rt.call_function('set_url_scheme', [
				rt.new_string('http://' +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF'))).str()),
			]),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('siteurl'),
		]), var_url))))
		{
			rt.call_function('update_option', [rt.new_string('siteurl'),
				var_url.clone()])
		}
	}
	mut var_secure := (rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
		rt.call_function('wp_login_url', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_SCHEME'),
	]))).to_bool()
	rt.call_function('setcookie', [rt.get_constant('TEST_COOKIE'),
		rt.new_string('WP Cookie check'), rt.new_int(0), rt.get_constant('COOKIEPATH'),
		rt.get_constant('COOKIE_DOMAIN'), rt.new_bool(var_secure).clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('SITECOOKIEPATH'),
		rt.get_constant('COOKIEPATH')))))
	{
		rt.call_function('setcookie', [rt.get_constant('TEST_COOKIE'),
			rt.new_string('WP Cookie check'), rt.new_int(0), rt.get_constant('SITECOOKIEPATH'),
			rt.get_constant('COOKIE_DOMAIN'), rt.new_bool(var_secure).clone(),
			rt.new_bool(true)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('wp_lang')) {
		rt.call_function('setcookie', [rt.new_string('wp_lang'),
			rt.call_function('sanitize_text_field', [
				rt.get_superglobal('_GET').array_get(rt.new_string('wp_lang')),
			]),
			rt.new_int(0), rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN'),
			rt.new_bool(var_secure).clone(), rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('login_init')])
	rt.call_function('do_action', [rt.new_string('login_form_${var_action.to_string()}')])
	mut var_http_post := (rt.identical(rt.new_string('POST'),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))).to_bool()
	mut var_interim_login :=
		rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('interim-login')))
	mut var_login_link_separator := rt.call_function('apply_filters', [
		rt.new_string('login_link_separator'),
		rt.new_string(' | '),
	])
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('confirm_admin_email'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			rt.call_function('wp_safe_redirect', [
				rt.call_function('wp_login_url', []rt.PhpVal{}),
			])
			exit(0)
		}
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')))) {
			mut var_redirect_to :=
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
		} else {
			var_redirect_to = rt.call_function('admin_url', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('manage_options'),
		]))
		{
			mut var_admin_email := rt.call_function('get_option', [
				rt.new_string('admin_email'),
			])
		} else {
			rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
			exit(0)
		}
		mut var_remind_interval := rt.new_int((rt.call_function('apply_filters', [
			rt.new_string('admin_email_remind_interval'),
			rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS')),
		])).to_i64())
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('remind_me_later')))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
				rt.get_superglobal('_GET').array_get(rt.new_string('remind_me_later')),
				rt.new_string('remind_me_later_nonce'),
			])))))
			{
				rt.call_function('wp_safe_redirect', [
					rt.call_function('wp_login_url', []rt.PhpVal{}),
				])
				exit(0)
			}
			if rt.is_true(rt.greater(var_remind_interval, rt.new_int(0))) {
				rt.call_function('update_option', [rt.new_string('admin_email_lifespan'),
					rt.add(rt.call_function('time', []rt.PhpVal{}), var_remind_interval)])
			}
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('admin_email_remind_later'),
				rt.new_int(1),
				var_redirect_to.clone(),
			])
			rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
			exit(0)
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('correct-admin-email')))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_admin_referer', [
				rt.new_string('confirm_admin_email'),
				rt.new_string('confirm_admin_email_nonce'),
			])))))
			{
				rt.call_function('wp_safe_redirect', [
					rt.call_function('wp_login_url', []rt.PhpVal{}),
				])
				exit(0)
			}
			mut var_admin_email_check_interval := rt.new_int((rt.call_function('apply_filters', [
				rt.new_string('admin_email_check_interval'),
				rt.mul(rt.new_int(6), rt.get_constant('MONTH_IN_SECONDS')),
			])).to_i64())
			if rt.is_true(rt.greater(var_admin_email_check_interval, rt.new_int(0))) {
				rt.call_function('update_option', [rt.new_string('admin_email_lifespan'),
					rt.add(rt.call_function('time', []rt.PhpVal{}), var_admin_email_check_interval)])
			}
			rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
			exit(0)
		}
		login_header(rt.call_function('__', [
			rt.new_string('Confirm your administration email'),
		]), '', var_errors.clone())
		rt.call_function('do_action', [rt.new_string('admin_email_confirm'),
			var_errors.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('site_url', [
				rt.new_string('wp-login.php?action=confirm_admin_email'),
				rt.new_string('login_post'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('admin_email_confirm_form')])
		rt.call_function('wp_nonce_field', [rt.new_string('confirm_admin_email'),
			rt.new_string('confirm_admin_email_nonce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_redirect_to.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Administration email verification')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Please verify that the <strong>administration email</strong> for this website is still correct.'),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_admin_email_help_url := rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/settings-general-screen/#email-address'),
		])
		mut var_accessibility_text := rt.call_function('sprintf', [
			rt.new_string('<span class="screen-reader-text"> %s</span>'),
			rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
		])
		rt.call_function('printf', [
			rt.new_string('<a href="%s" target="_blank">%s%s</a>'),
			rt.call_function('esc_url', [var_admin_email_help_url.clone()]),
			rt.call_function('__', [rt.new_string('Why is this important?')]),
			var_accessibility_text.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Current administration email: %s')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [var_admin_email.clone()])).str() + '</strong>'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('This email may be different from your personal email address.'),
		])
		// unsupported statement: Stmt_InlineHTML
		mut var_change_link := rt.call_function('admin_url', [
			rt.new_string('options-general.php'),
		])
		var_change_link = rt.call_function('add_query_arg', [
			rt.new_string('highlight'), rt.new_string('confirm_admin_email'),
			var_change_link.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_change_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Update')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('The email is correct')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.greater(var_remind_interval, rt.new_int(0))) {
			// unsupported statement: Stmt_InlineHTML
			mut var_remind_me_link := rt.call_function('wp_login_url', [
				var_redirect_to.clone()])
			var_remind_me_link = rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'action', val: 'confirm_admin_email' },
					rt.ArrayItem{ key: 'remind_me_later', val: rt.call_function('wp_create_nonce', [
						rt.new_string('remind_me_later_nonce'),
					]) },
				]),
				var_remind_me_link.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_remind_me_link.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Remind me later')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		login_footer('')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('postpass'))) {
		var_redirect_to = if !(rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to'))
		} else {
			rt.call_function('wp_get_referer', []rt.PhpVal{})
		}
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('post_password')))
			|| !(rt.get_superglobal('_POST').array_get(rt.new_string('post_password')).is_string()) {
			rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
			exit(0)
		}
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-phpass.php',
			'4')
		mut var_hasher := create_passwordhash(rt.new_int(8), rt.new_bool(true))
		mut var_expire := rt.call_function('apply_filters', [
			rt.new_string('post_password_expires'),
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(10),
				rt.get_constant('DAY_IN_SECONDS'))),
		])
		if rt.is_true(var_redirect_to) {
			var_secure = (rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
				var_redirect_to.clone(),
				rt.get_constant('PHP_URL_SCHEME'),
			]))).to_bool()
		} else {
			var_secure = false
		}
		rt.call_function('setcookie', [
			rt.new_string('wp-postpass_' + (rt.get_constant('COOKIEHASH')).str()),
			var_hasher.hashpassword(rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('post_password')),
			])),
			var_expire.clone(),
			rt.get_constant('COOKIEPATH'),
			rt.get_constant('COOKIE_DOMAIN'),
			rt.new_bool(var_secure).clone(),
		])
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('logout'))) {
		rt.call_function('check_admin_referer', [rt.new_string('log-out')])
		mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
		rt.call_function('wp_logout', []rt.PhpVal{})
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))))
			&& rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')).is_string() {
			var_redirect_to = rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
			mut var_requested_redirect_to := var_redirect_to.clone()
		} else {
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'loggedout', val: 'true' },
					rt.ArrayItem{ key: 'wp_lang', val: rt.call_function('get_user_locale', [
						var_user.clone(),
					]) }]),
				rt.call_function('wp_login_url', []rt.PhpVal{}),
			])
			var_requested_redirect_to = rt.new_string('')
		}
		var_redirect_to = rt.call_function('apply_filters', [
			rt.new_string('logout_redirect'),
			var_redirect_to.clone(),
			var_requested_redirect_to.clone(),
			var_user.clone(),
		])
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('lostpassword')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('retrievepassword'))) {
		if var_http_post {
			var_errors = rt.call_function('retrieve_password', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_errors.clone(),
			])))))
			{
				var_redirect_to = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')))) {
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
				} else {
					rt.new_string('wp-login.php?checkemail=confirm')
				}
				rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
				exit(0)
			}
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('error')) {
			if rt.is_true(rt.identical(rt.new_string('invalidkey'),
				rt.get_superglobal('_GET').array_get(rt.new_string('error'))))
			{
				rt.call_method(var_errors, 'add', [rt.new_string('invalidkey'),
					rt.call_function('__', [
						rt.new_string('<strong>Error:</strong> Your password reset link appears to be invalid. Please request a new link below.'),
					])])
			} else if rt.is_true(rt.identical(rt.new_string('expiredkey'),
				rt.get_superglobal('_GET').array_get(rt.new_string('error'))))
			{
				rt.call_method(var_errors, 'add', [rt.new_string('expiredkey'),
					rt.call_function('__', [
						rt.new_string('<strong>Error:</strong> Your password reset link has expired. Please request a new link below.'),
					])])
			}
		}
		mut var_lostpassword_redirect := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')))) {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
		} else {
			rt.new_string('')
		}
		var_redirect_to = rt.call_function('apply_filters', [
			rt.new_string('lostpassword_redirect'),
			var_lostpassword_redirect.clone(),
		])
		rt.call_function('do_action', [rt.new_string('lost_password'),
			var_errors.clone()])
		login_header(rt.call_function('__', [rt.new_string('Lost Password')]), rt.call_function('wp_get_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Please enter your username or email address. You will receive an email message with instructions on how to reset your password.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'message' },
				]) },
			]),
		]), var_errors.clone())
		mut var_user_login := rt.new_string('')
		if rt.get_superglobal('_POST').array_isset(rt.new_string('user_login'))
			&& rt.get_superglobal('_POST').array_get(rt.new_string('user_login')).is_string() {
			var_user_login = rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('user_login')),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('network_site_url', [
				rt.new_string('wp-login.php?action=lostpassword'),
				rt.new_string('login_post'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username or Email Address')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_login.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('lostpassword_form')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_redirect_to.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Get New Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wp_login_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Log in')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_option', [
			rt.new_string('users_can_register'),
		]))
		{
			mut var_registration_url := rt.call_function('sprintf', [
				rt.new_string('<a class="wp-login-register" href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('wp_registration_url', []rt.PhpVal{}),
				]),
				rt.call_function('__', [
					rt.new_string('Register'),
				]),
			])
			rt.echo_val(rt.call_function('esc_html', [var_login_link_separator.clone()]))
			rt.echo_val(rt.call_function('apply_filters', [rt.new_string('register'),
				var_registration_url.clone()]))
		}
		// unsupported statement: Stmt_InlineHTML
		login_footer('user_login')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resetpass')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('rp'))) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('?'),
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])])
		var_rp_path = list_tmp_1.array_get(0)
		mut var_rp_cookie := rt.new_string('wp-resetpass-' + (rt.get_constant('COOKIEHASH')).str())
		if rt.get_superglobal('_GET').array_isset(rt.new_string('key'))
			&& rt.get_superglobal('_GET').array_isset(rt.new_string('login')) {
			mut var_value := rt.call_function('sprintf', [rt.new_string('%s:%s'),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('login'))]),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('key'))])])
			rt.call_function('setcookie', [var_rp_cookie.clone(),
				var_value.clone(), rt.new_int(0), var_rp_path.clone(),
				rt.get_constant('COOKIE_DOMAIN'), rt.call_function('is_ssl', []rt.PhpVal{}),
				rt.new_bool(true)])
			rt.call_function('wp_safe_redirect', [
				rt.call_function('remove_query_arg', [
					rt.create_array([rt.ArrayItem{ key: none, val: 'key' },
						rt.ArrayItem{ key: none, val: 'login' }]),
				]),
			])
			exit(0)
		}
		if rt.get_superglobal('_COOKIE').array_isset(var_rp_cookie)
			&& rt.is_true(rt.less(rt.new_int(0), rt.call_function('strpos', [rt.get_superglobal('_COOKIE').array_get(var_rp_cookie), rt.new_string(':')]))) {
			mut list_tmp_2 := rt.call_function('explode', [rt.new_string(':'),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_COOKIE').array_get(var_rp_cookie)]),
				rt.new_int(2)])
			var_rp_login = list_tmp_2.array_get(0)
			var_rp_key = list_tmp_2.array_get(1)
			var_user = rt.call_function('check_password_reset_key', [
				var_rp_key.clone(), var_rp_login.clone()])
			if rt.get_superglobal('_POST').array_isset(rt.new_string('pass1'))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_rp_key.clone(), rt.get_superglobal('_POST').array_get(rt.new_string('rp_key'))]))))) {
				var_user = rt.new_bool(false)
			}
		} else {
			var_user = rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
			rt.call_function('setcookie', [var_rp_cookie.clone(),
				rt.new_string(' '),
				rt.sub(rt.call_function('time', []rt.PhpVal{}),
					rt.get_constant('YEAR_IN_SECONDS')),
				var_rp_path.clone(), rt.get_constant('COOKIE_DOMAIN'),
				rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
			if rt.is_true(var_user)
				&& rt.is_true(rt.identical(rt.call_method(var_user, 'get_error_code', []rt.PhpVal{}), rt.new_string('expired_key'))) {
				rt.call_function('wp_redirect', [
					rt.call_function('site_url', [
						rt.new_string('wp-login.php?action=lostpassword&error=expiredkey'),
					]),
				])
			} else {
				rt.call_function('wp_redirect', [
					rt.call_function('site_url', [
						rt.new_string('wp-login.php?action=lostpassword&error=invalidkey'),
					]),
				])
			}
			exit(0)
		}
		var_errors = create_wp_error()
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('pass1')))) {
			rt.get_superglobal('_POST').array_set('pass1',
				rt.get_superglobal('_POST').array_get(rt.new_string('pass1')).to_string().trim_space())
			if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('pass1'))) {
				rt.call_method(var_errors, 'add', [
					rt.new_string('password_reset_empty_space'),
					rt.call_function('__', [
						rt.new_string('The password cannot be a space or all spaces.'),
					]),
				])
			}
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('pass1'))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(rt.get_superglobal('_POST').array_get(rt.new_string('pass2')).to_string().trim_space()), rt.get_superglobal('_POST').array_get(rt.new_string('pass1')))))) {
			rt.call_method(var_errors, 'add', [rt.new_string('password_reset_mismatch'),
				rt.call_function('__', [
					rt.new_string('<strong>Error:</strong> The passwords do not match.'),
				])])
		}
		rt.call_function('do_action', [rt.new_string('validate_password_reset'),
			var_errors.clone(), var_user.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})))))
			&& rt.get_superglobal('_POST').array_isset(rt.new_string('pass1'))
			&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('pass1')))) {
			rt.call_function('reset_password', [var_user.clone(),
				rt.get_superglobal('_POST').array_get(rt.new_string('pass1'))])
			login_header(rt.call_function('__', [rt.new_string('Password Reset')]), rt.call_function('wp_get_admin_notice', [
				rt.new_string(
					(rt.call_function('__', [rt.new_string('Your password has been reset.')])).str() +
					' <a href="' +
					(rt.call_function('esc_url', [rt.call_function('wp_login_url', []rt.PhpVal{})])).str() +
					'">' + (rt.call_function('__', [rt.new_string('Log in')])).str() + '</a>'),
				rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'info' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'message' },
						rt.ArrayItem{ key: none, val: 'reset-pass' },
					]) },
				]),
			]), rt.new_null())
			login_footer('')
			exit(0)
		}
		rt.call_function('wp_enqueue_script', [rt.new_string('utils')])
		rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
		login_header(rt.call_function('__', [rt.new_string('Reset Password')]), rt.call_function('wp_get_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Enter your new password below or generate one.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'message' },
					rt.ArrayItem{ key: none, val: 'reset-pass' },
				]) },
			]),
		]), var_errors.clone())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('network_site_url', [
				rt.new_string('wp-login.php?action=resetpass'),
				rt.new_string('login_post'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_rp_login.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('New password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wp_generate_password', [rt.new_int(16)]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Hide password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Strength indicator')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Confirm use of weak password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Confirm new password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_get_password_hint', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('resetpass_form'),
			var_user.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_rp_key.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Generate Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save Password')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wp_login_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Log in')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('get_option', [
			rt.new_string('users_can_register'),
		]))
		{
			var_registration_url = rt.call_function('sprintf', [
				rt.new_string('<a class="wp-login-register" href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('wp_registration_url', []rt.PhpVal{}),
				]),
				rt.call_function('__', [
					rt.new_string('Register'),
				]),
			])
			rt.echo_val(rt.call_function('esc_html', [var_login_link_separator.clone()]))
			rt.echo_val(rt.call_function('apply_filters', [rt.new_string('register'),
				var_registration_url.clone()]))
		}
		// unsupported statement: Stmt_InlineHTML
		login_footer('pass1')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('register'))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('wp_redirect', [
				rt.call_function('apply_filters', [rt.new_string('wp_signup_location'),
					rt.call_function('network_site_url', [rt.new_string('wp-signup.php')])]),
			])
			exit(0)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
			rt.new_string('users_can_register'),
		])))))
		{
			rt.call_function('wp_redirect', [
				rt.call_function('site_url', [
					rt.new_string('wp-login.php?registration=disabled'),
				]),
			])
			exit(0)
		}
		var_user_login = rt.new_string('')
		mut var_user_email := rt.new_string('')
		if var_http_post {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('user_login'))
				&& rt.get_superglobal('_POST').array_get(rt.new_string('user_login')).is_string() {
				var_user_login = rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('user_login')),
				])
			}
			if rt.get_superglobal('_POST').array_isset(rt.new_string('user_email'))
				&& rt.get_superglobal('_POST').array_get(rt.new_string('user_email')).is_string() {
				var_user_email = rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('user_email')),
				])
			}
			var_errors = rt.call_function('register_new_user', [
				var_user_login.clone(), var_user_email.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_errors.clone(),
			])))))
			{
				var_redirect_to = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to')))) {
					rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to'))
				} else {
					rt.new_string('wp-login.php?checkemail=registered')
				}
				rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
				exit(0)
			}
		}
		mut var_registration_redirect := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')))) {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
		} else {
			rt.new_string('')
		}
		var_redirect_to = rt.call_function('apply_filters', [
			rt.new_string('registration_redirect'),
			var_registration_redirect.clone(),
			var_errors.clone(),
		])
		login_header(rt.call_function('__', [rt.new_string('Registration Form')]), rt.call_function('wp_get_admin_notice', [
			rt.call_function('__', [rt.new_string('Register For This Site')]),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'message' },
					rt.ArrayItem{ key: none, val: 'register' },
				]) }]),
		]), var_errors.clone())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('site_url', [rt.new_string('wp-login.php?action=register'),
				rt.new_string('login_post')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_login.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Email')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_email.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('register_form')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Registration confirmation will be emailed to you.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_redirect_to.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Register')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wp_login_url', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Log in')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_login_link_separator.clone()]))
		mut var_html_link := rt.call_function('sprintf', [
			rt.new_string('<a class="wp-login-lost-password" href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_lostpassword_url', []rt.PhpVal{}),
			]),
			rt.call_function('__', [
				rt.new_string('Lost your password?'),
			]),
		])
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('lost_password_html_link'),
			var_html_link.clone(),
		]))
		// unsupported statement: Stmt_InlineHTML
		login_footer('user_login')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkemail'))) {
		var_redirect_to = rt.call_function('admin_url', []rt.PhpVal{})
		var_errors = create_wp_error()
		if rt.is_true(rt.identical(rt.new_string('confirm'),
			rt.get_superglobal('_GET').array_get(rt.new_string('checkemail'))))
		{
			rt.call_method(var_errors, 'add', [rt.new_string('confirm'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Check your email for the confirmation link, then visit the <a href="%s">login page</a>.'),
					]),
					rt.call_function('wp_login_url', []rt.PhpVal{}),
				]),
				rt.new_string('message')])
		} else if rt.is_true(rt.identical(rt.new_string('registered'),
			rt.get_superglobal('_GET').array_get(rt.new_string('checkemail'))))
		{
			rt.call_method(var_errors, 'add', [rt.new_string('registered'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Registration complete. Please check your email, then visit the <a href="%s">login page</a>.'),
					]),
					rt.call_function('wp_login_url', []rt.PhpVal{}),
				]),
				rt.new_string('message')])
		}
		var_errors = rt.call_function('apply_filters', [rt.new_string('wp_login_errors'),
			var_errors.clone(), var_redirect_to.clone()])
		login_header(rt.call_function('__', [rt.new_string('Check your email')]), '',
			var_errors.clone())
		login_footer('')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('confirmaction'))) {
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('request_id'))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Missing request ID.')]),
			])
		}
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('confirm_key'))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Missing confirm key.')]),
			])
		}
		mut var_request_id :=
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('request_id'))).to_i64())
		mut var_key := rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('confirm_key'))]),
		])
		mut var_result := rt.call_function('wp_validate_user_request_key', [
			var_request_id.clone(), var_key.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			rt.call_function('wp_die', [var_result.clone()])
		}
		rt.call_function('do_action', [rt.new_string('user_request_action_confirmed'),
			var_request_id.clone()])
		mut var_message := rt.call_function('_wp_privacy_account_request_confirmed_message', [
			var_request_id.clone(),
		])
		login_header(rt.call_function('__', [rt.new_string('User action confirmed.')]),
			var_message.clone(), rt.new_null())
		login_footer('')
		exit(0)
	} else {
		mut var_secure_cookie := rt.new_string('')
		mut var_customize_login :=
			rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize-login')))
		if rt.is_true(var_customize_login) {
			rt.call_function('wp_enqueue_script', [rt.new_string('customize-base')])
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('log'))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{}))))) {
			mut var_user_name := rt.call_function('sanitize_user', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('log'))]),
			])
			var_user = rt.call_function('get_user_by', [rt.new_string('login'),
				var_user_name.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_user))))
				&& rt.is_true(rt.call_function('strpos', [var_user_name.clone(), rt.new_string('@')])) {
				var_user = rt.call_function('get_user_by', [rt.new_string('email'),
					var_user_name.clone()])
			}
			if rt.is_true(var_user) {
				if rt.is_true(rt.call_function('get_user_option', [
					rt.new_string('use_ssl'),
					rt.get_property(var_user, 'ID'),
				]))
				{
					var_secure_cookie = rt.new_bool(true)
					rt.call_function('force_ssl_admin', [rt.new_bool(true)])
				}
			}
		}
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('redirect_to'))
			&& rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')).is_string() {
			var_redirect_to = rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
			if rt.is_true(var_secure_cookie)
				&& rt.is_true(rt.call_function('str_contains', [var_redirect_to.clone(), rt.new_string('wp-admin')])) {
				var_redirect_to = rt.call_function('preg_replace', [
					rt.new_string('|^http://|'),
					rt.new_string('https://'),
					var_redirect_to.clone(),
				])
			}
		} else {
			var_redirect_to = rt.call_function('admin_url', []rt.PhpVal{})
		}
		mut var_reauth := !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('reauth'))))
		var_user = rt.call_function('wp_signon', [[]rt.PhpVal{},
			var_secure_cookie.clone()])
		if !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('LOGGED_IN_COOKIE'))) {
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
				var_user = create_wp_error(rt.new_string('test_cookie'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('<strong>Error:</strong> Cookies are blocked due to unexpected output. For help, please see <a href="%1$s">this documentation</a> or try the <a href="%2$s">support forums</a>.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/cookies/'),
					]),
					rt.call_function('__', [
						rt.new_string('https://wordpress.org/support/forums/'),
					]),
				]))
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('testcookie'))
				&& !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('TEST_COOKIE'))) {
				var_user = create_wp_error(rt.new_string('test_cookie'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('<strong>Error:</strong> Cookies are blocked or not supported by your browser. You must <a href="%s">enable cookies</a> to use WordPress.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/cookies/#enable-cookies-in-your-browser'),
					]),
				]))
			}
		}
		var_requested_redirect_to = if
			rt.get_superglobal('_REQUEST').array_isset(rt.new_string('redirect_to'))
			&& rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to')).is_string() {
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('redirect_to'))
		} else {
			rt.new_string('')
		}
		var_redirect_to = rt.call_function('apply_filters', [
			rt.new_string('login_redirect'),
			var_redirect_to.clone(),
			var_requested_redirect_to.clone(),
			var_user.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])))))
			&& !var_reauth {
			if rt.is_true(var_interim_login) {
				var_message = rt.new_string('<p class="message">' +
					(rt.call_function('__', [rt.new_string('You have logged in successfully.')])).str() +
					'</p>')
				var_interim_login = rt.new_string('success')
				login_header(rt.new_string(''), var_message.clone(), rt.new_null())
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('do_action', [rt.new_string('login_footer')])
				if rt.is_true(var_customize_login) {
					rt.call_function('ob_start', []rt.PhpVal{})
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('wp_customize_url', []rt.PhpVal{}))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wp_print_inline_script_tag', [
						rt.call_function('wp_remove_surrounding_empty_script_tags', [
							rt.call_function('ob_get_clean', []rt.PhpVal{}),
						]),
					])
				}
				// unsupported statement: Stmt_InlineHTML
				exit(0)
			}
			if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))
				&& rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))
				&& rt.is_true(rt.call_method(var_user, 'has_cap', [rt.new_string('manage_options')])) {
				mut var_admin_email_lifespan := rt.new_int((rt.call_function('get_option', [
					rt.new_string('admin_email_lifespan'),
				])).to_i64())
				var_admin_email_check_interval = rt.new_int((rt.call_function('apply_filters', [
					rt.new_string('admin_email_check_interval'),
					rt.mul(rt.new_int(6), rt.get_constant('MONTH_IN_SECONDS')),
				])).to_i64())
				if rt.is_true(rt.greater(var_admin_email_check_interval, rt.new_int(0)))
					&& rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), var_admin_email_lifespan)) {
					var_redirect_to = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'action', val: 'confirm_admin_email' },
							rt.ArrayItem{ key: 'wp_lang', val: rt.call_function('get_user_locale', [
								var_user.clone(),
							]) },
						]),
						rt.call_function('wp_login_url', [
							var_redirect_to.clone(),
						]),
					])
				}
			}
			if !rt.is_true(var_redirect_to)
				|| rt.is_true(rt.identical(rt.new_string('wp-admin/'), var_redirect_to))
				|| rt.is_true(rt.identical(rt.call_function('admin_url', []rt.PhpVal{}), var_redirect_to)) {
				if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_active_blog_for_user', [rt.get_property(var_user, 'ID')])))))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_user, 'ID')]))))) {
					var_redirect_to = rt.call_function('user_admin_url', []rt.PhpVal{})
				} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'has_cap', [rt.new_string('read')]))))) {
					var_redirect_to = rt.call_function('get_dashboard_url', [
						rt.get_property(var_user, 'ID'),
					])
				} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'has_cap', [
					rt.new_string('edit_posts'),
				])))))
				{
					var_redirect_to = if rt.is_true(rt.call_method(var_user, 'has_cap', [
						rt.new_string('read'),
					]))
					{
						rt.call_function('admin_url', [rt.new_string('profile.php')])
					} else {
						rt.call_function('home_url', []rt.PhpVal{})
					}
				}
				rt.call_function('wp_redirect', [var_redirect_to.clone()])
				exit(0)
			}
			rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
			exit(0)
		}
		var_errors = var_user.clone()
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('loggedout'))))
			|| var_reauth {
			var_errors = create_wp_error()
		}
		if !rt.is_true(rt.get_superglobal('_POST')) && rt.is_true(rt.identical(rt.call_method(var_errors, 'get_error_codes', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
			key: none
			val: 'empty_username'
		}, rt.ArrayItem{ key: none, val: 'empty_password' }]))) {
			var_errors = create_wp_error(rt.new_string(''), rt.new_string(''))
		}
		if rt.is_true(var_interim_login) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_errors, 'has_errors',
				[]rt.PhpVal{})))))
			{
				rt.call_method(var_errors, 'add', [rt.new_string('expired'),
					rt.call_function('__', [
						rt.new_string('Your session has expired. Please log in to continue where you left off.'),
					]),
					rt.new_string('message')])
			}
		} else {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('loggedout'))
				&& rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('loggedout'))) {
				rt.call_method(var_errors, 'add', [rt.new_string('loggedout'),
					rt.call_function('__', [rt.new_string('You are now logged out.')]),
					rt.new_string('message')])
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('registration'))
				&& rt.is_true(rt.identical(rt.new_string('disabled'), rt.get_superglobal('_GET').array_get(rt.new_string('registration')))) {
				rt.call_method(var_errors, 'add', [rt.new_string('registerdisabled'),
					rt.call_function('__', [
						rt.new_string('<strong>Error:</strong> User registration is currently not allowed.'),
					])])
			} else if rt.is_true(rt.call_function('str_contains', [
				var_redirect_to.clone(), rt.new_string('about.php?updated')]))
			{
				rt.call_method(var_errors, 'add', [rt.new_string('updated'),
					rt.call_function('__', [
						rt.new_string('<strong>You have successfully updated WordPress!</strong> Please log back in to see what&#8217;s new.'),
					]),
					rt.new_string('message')])
			} else if rt.is_true(rt.identical(Class_WP_Recovery_Mode_Link_Service.login_action_entered(),
				var_action))
			{
				rt.call_method(var_errors, 'add', [rt.new_string('enter_recovery_mode'),
					rt.call_function('__', [
						rt.new_string('Recovery Mode Initialized. Please log in to continue.'),
					]),
					rt.new_string('message')])
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('redirect_to'))
				&& rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to')).is_string()
				&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to')), rt.new_string('wp-admin/authorize-application.php')])) {
				mut var_query_component := rt.call_function('wp_parse_url', [
					rt.get_superglobal('_GET').array_get(rt.new_string('redirect_to')),
					rt.get_constant('PHP_URL_QUERY'),
				])
				mut var_query := []rt.PhpVal{}
				if rt.is_true(var_query_component) {
					rt.call_function('parse_str', [var_query_component.clone(),
						var_query.clone()])
				}
				if !(!rt.is_true(var_query.array_get(rt.new_string('app_name')))) {
					var_message = rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Please log in to %1$s to authorize %2$s to connect to your account.'),
						]),
						rt.call_function('get_bloginfo', [
							rt.new_string('name'),
							rt.new_string('display'),
						]),
						rt.new_string('<strong>' +
							(rt.call_function('esc_html', [var_query.array_get(rt.new_string('app_name'))])).str() +
							'</strong>'),
					])
				} else {
					var_message = rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Please log in to %s to proceed with authorization.'),
						]),
						rt.call_function('get_bloginfo', [
							rt.new_string('name'),
							rt.new_string('display'),
						]),
					])
				}
				rt.call_method(var_errors, 'add', [
					rt.new_string('authorize_application'),
					var_message.clone(),
					rt.new_string('message'),
				])
			}
		}
		var_errors = rt.call_function('apply_filters', [rt.new_string('wp_login_errors'),
			var_errors.clone(), var_redirect_to.clone()])
		if var_reauth {
			rt.call_function('wp_clear_auth_cookie', []rt.PhpVal{})
		}
		var_rp_cookie = rt.new_string('wp-resetpass-' + (rt.get_constant('COOKIEHASH')).str())
		if rt.get_superglobal('_COOKIE').array_isset(var_rp_cookie)
			&& rt.get_superglobal('_COOKIE').array_get(var_rp_cookie).is_string() {
			var_user_login = rt.call_function('sanitize_user', [
				rt.call_function('strtok', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_COOKIE').array_get(var_rp_cookie)]),
					rt.new_string(':'),
				]),
			])
			mut list_tmp_3 := rt.call_function('explode', [rt.new_string('?'),
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				])])
			var_rp_path = list_tmp_3.array_get(0)
			rt.call_function('setcookie', [var_rp_cookie.clone(),
				rt.new_string(' '),
				rt.sub(rt.call_function('time', []rt.PhpVal{}),
					rt.get_constant('YEAR_IN_SECONDS')),
				var_rp_path.clone(), rt.get_constant('COOKIE_DOMAIN'),
				rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
		}
		login_header(rt.call_function('__', [rt.new_string('Log In')]), '', var_errors.clone())
		if rt.get_superglobal('_POST').array_isset(rt.new_string('log')) {
			var_user_login = if rt.is_true(rt.identical(rt.new_string('incorrect_password'), rt.call_method(var_errors, 'get_error_code', []rt.PhpVal{}))) || rt.is_true(rt.identical(rt.new_string('empty_password'), rt.call_method(var_errors, 'get_error_code', []rt.PhpVal{}))) { rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('log')),
				]) } else { rt.new_string('') }
		}
		mut var_rememberme := !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('rememberme'))))
		mut var_aria_describedby := ''
		mut var_has_errors := rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})
		if rt.is_true(var_has_errors) {
			var_aria_describedby = ' aria-describedby="login_error"'
		}
		if rt.is_true(var_has_errors)
			&& rt.is_true(rt.identical(rt.new_string('message'), rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{}))) {
			var_aria_describedby = ' aria-describedby="login-message"'
		}
		rt.call_function('wp_enqueue_script', [rt.new_string('user-profile')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('site_url', [rt.new_string('wp-login.php'),
				rt.new_string('login_post')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Username or Email Address')])
		// unsupported statement: Stmt_InlineHTML
		print(var_aria_describedby)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_login.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Password')])
		// unsupported statement: Stmt_InlineHTML
		print(var_aria_describedby)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Show password')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('login_form')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [rt.new_bool(var_rememberme).clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Remember Me')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Log In')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_interim_login) {
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_redirect_to.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		if rt.is_true(var_customize_login) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_interim_login)))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('get_option', [
				rt.new_string('users_can_register'),
			]))
			{
				var_registration_url = rt.call_function('sprintf', [
					rt.new_string('<a class="wp-login-register" href="%s">%s</a>'),
					rt.call_function('esc_url', [
						rt.call_function('wp_registration_url', []rt.PhpVal{}),
					]),
					rt.call_function('__', [
						rt.new_string('Register'),
					]),
				])
				rt.echo_val(rt.call_function('apply_filters', [
					rt.new_string('register'), var_registration_url.clone()]))
				rt.echo_val(rt.call_function('esc_html', [var_login_link_separator.clone()]))
			}
			var_html_link = rt.call_function('sprintf', [
				rt.new_string('<a class="wp-login-lost-password" href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('wp_lostpassword_url', []rt.PhpVal{}),
				]),
				rt.call_function('__', [
					rt.new_string('Lost your password?'),
				]),
			])
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('lost_password_html_link'),
				var_html_link.clone(),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_login_script := 'function wp_attempt_focus() {'
		var_login_script = var_login_script + 'setTimeout( function() {'
		var_login_script = var_login_script + 'try {'
		if rt.is_true(var_user_login) {
			var_login_script = var_login_script +
				'd = document.getElementById( "user_pass" ); d.value = "";'
		} else {
			var_login_script = var_login_script + 'd = document.getElementById( "user_login" );'
			if rt.is_true(rt.identical(rt.call_method(var_errors, 'get_error_code', []rt.PhpVal{}),
				rt.new_string('invalid_username')))
			{
				var_login_script = var_login_script + 'd.value = "";'
			}
		}
		var_login_script = var_login_script + 'd.focus(); d.select();'
		var_login_script = var_login_script + '} catch( er ) {}'
		var_login_script = var_login_script + '}, 200);'
		var_login_script = var_login_script + '}\n'
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_login_autofocus'), rt.new_bool(true)]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
			var_login_script = var_login_script + 'wp_attempt_focus();\n'
		}
		var_login_script = var_login_script + "if ( typeof wpOnload === 'function' ) { wpOnload() }"
		rt.call_function('wp_print_inline_script_tag',
			[rt.new_string(var_login_script.str()).clone()])
		if rt.is_true(var_interim_login) {
			rt.call_function('ob_start', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_print_inline_script_tag', [
				rt.call_function('wp_remove_surrounding_empty_script_tags', [
					rt.call_function('ob_get_clean', []rt.PhpVal{}),
				]),
			])
		}
		login_footer('')
	}
}
