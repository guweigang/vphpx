import rt

fn login_header(var_title rt.PhpVal, message string, var_wp_error rt.PhpVal) {
	mut var_error := rt.new_null()
	mut var_interim_login := rt.new_null()
	mut var_action := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_null(), var_title)) {
		var_title = rt.call_function('__', [rt.new_string('Log In')])
	}
	rt.call_function('add_filter', [rt.new_string('wp_robots'), rt.new_string('wp_robots_sensitive_page')])
	rt.call_function('add_action', [rt.new_string('login_head'), rt.new_string('wp_strict_cross_origin_referrer')])
	rt.call_function('add_action', [rt.new_string('login_head'), rt.new_string('wp_login_viewport_meta')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_wp_error]))))) {
		var_wp_error = create_wp_error()
	}
	mut var_shake_error_codes := rt.create_array([rt.ArrayItem{ key: none, val: 'empty_password' }, rt.ArrayItem{ key: none, val: 'empty_email' }, rt.ArrayItem{ key: none, val: 'invalid_email' }, rt.ArrayItem{ key: none, val: 'invalidcombo' }, rt.ArrayItem{ key: none, val: 'empty_username' }, rt.ArrayItem{ key: none, val: 'invalid_username' }, rt.ArrayItem{ key: none, val: 'incorrect_password' }, rt.ArrayItem{ key: none, val: 'retrieve_password_email_failure' }])
	var_shake_error_codes = rt.call_function('apply_filters', [rt.new_string('shake_error_codes'), var_shake_error_codes.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_shake_error_codes) && rt.is_true(var_wp_error.has_errors()))) && rt.is_true(rt.call_function('in_array', [var_wp_error.get_error_code(), var_shake_error_codes.dup(), rt.new_bool(true)])))) {
		rt.call_function('add_action', [rt.new_string('login_footer'), rt.new_string('wp_shake_js'), rt.new_int(12)])
	}
	mut var_login_title := rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])
	var_login_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s &lsaquo; %2$s &#8212; WordPress')]), var_title.dup(), var_login_title.dup()])
	if rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
		var_login_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Recovery Mode &#8212; %s')]), var_login_title.dup()])
	}
	var_login_title = rt.call_function('apply_filters', [rt.new_string('login_title'), var_login_title.dup(), var_title.dup()])
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
		rt.call_function('wp_print_inline_script_tag', [rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])])
	}
	rt.call_function('do_action', [rt.new_string('login_enqueue_scripts')])
	rt.call_function('do_action', [rt.new_string('login_head')])
	mut var_login_header_url := rt.call_function('__', [rt.new_string('https://wordpress.org/')])
	var_login_header_url = rt.call_function('apply_filters', [rt.new_string('login_headerurl'), var_login_header_url.dup()])
	mut var_login_header_title := rt.new_string(rt.new_string(''))
	var_login_header_title = rt.call_function('apply_filters_deprecated', [rt.new_string('login_headertitle'), rt.create_array([rt.ArrayItem{ key: none, val: var_login_header_title }]), rt.new_string('5.2.0'), rt.new_string('login_headertext'), rt.call_function('__', [rt.new_string('Usage of the title attribute on the login logo is not recommended for accessibility reasons. Use the link text instead.')])])
	mut var_login_header_text := if !rt.is_true(var_login_header_title) { rt.call_function('__', [rt.new_string('Powered by WordPress')]) } else { var_login_header_title }
	var_login_header_text = rt.call_function('apply_filters', [rt.new_string('login_headertext'), var_login_header_text.dup()])
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'login-action-' + (var_action).str() }, rt.ArrayItem{ key: none, val: 'wp-core-ui' }, rt.ArrayItem{ key: none, val: 'admin-color-modern' }])
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
	var_classes.array_push('locale-' + (rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_locale', []rt.PhpVal{})]).to_string().to_lower())])).str())
	var_classes = rt.call_function('apply_filters', [rt.new_string('login_body_class'), var_classes.dup(), var_action.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_classes.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.new_string('document.body.className = document.body.className.replace(\'no-js\',\'js\');')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('login_header')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(!rt.is_true(var_title)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_title)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_login_header_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_login_header_text)
	// unsupported statement: Stmt_InlineHTML
	message = (rt.call_function('apply_filters', [rt.new_string('login_message'), rt.new_string(message)])).str()
	if !(message == '') {
		print(message + '\n')
	}
	if !(!rt.is_true(var_error)) {
		var_wp_error.add(rt.new_string('error'), var_error.dup())
		var_error = rt.new_null()
	}
	if rt.is_true(var_wp_error.has_errors()) {
		mut var_error_list := []rt.PhpVal{}
		mut var_messages := rt.new_string(rt.new_string(''))
		{
			mut iter_1 := var_wp_error.get_error_codes().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_code := item_1.val
				mut var_severity := var_wp_error.get_error_data(var_code.dup())
				{
					mut iter_2 := var_wp_error.get_error_messages(var_code.dup()).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_error_message := item_2.val
						if rt.is_true(rt.identical(rt.new_string('message'), var_severity)) {
							// unsupported expression: Expr_AssignOp_Concat
						} else {
							var_error_list << var_error_message.dup()
						}
					}
				}
			}
		}
		if !(!rt.is_true(var_error_list)) {
			mut var_errors := rt.new_string(rt.new_string(''))
			if var_error_list.len > 1 {
				// unsupported expression: Expr_AssignOp_Concat
				for var_item in var_error_list {
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
			var_errors = rt.call_function('apply_filters', [rt.new_string('login_errors'), var_errors.dup()])
			rt.call_function('wp_admin_notice', [var_errors.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }, rt.ArrayItem{ key: 'id', val: 'login_error' }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
		if !(!rt.is_true(var_messages)) {
			var_messages = rt.call_function('apply_filters', [rt.new_string('login_messages'), var_messages.dup()])
			rt.call_function('wp_admin_notice', [var_messages.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }, rt.ArrayItem{ key: 'id', val: 'login-message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'message' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		}
	}
}

fn login_footer(input_id string) {
	mut var_interim_login := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(var_interim_login)))) {
		// unsupported statement: Stmt_InlineHTML
		mut var_html_link := rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('home_url', [rt.new_string('/')])]), rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('&larr; Go to %s'), rt.new_string('site')]), rt.call_function('get_bloginfo', [rt.new_string('title'), rt.new_string('display')])])])
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('login_site_html_link'), var_html_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_privacy_policy_link', [rt.new_string('<div class="privacy-policy-page-link">'), rt.new_string('</div>')])
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_interim_login)))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('login_display_language_dropdown'), rt.new_bool(true)])))) {
		mut var_languages := rt.call_function('get_available_languages', []rt.PhpVal{})
		if !(!rt.is_true(var_languages)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Language')])
			// unsupported statement: Stmt_InlineHTML
			
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
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

	mut var_rp_path := rt.new_null()
	mut var_rp_login := rt.new_null()
	mut var_rp_key := rt.new_null()
	mut var_error := rt.new_null()
	rt.include_file(@DIR + '/wp-load.php', '3')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))))))) {
		if rt.is_true(rt.call_function('str_starts_with', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI'), rt.new_string('http')])) {
			rt.call_function('wp_safe_redirect', [rt.call_function('set_url_scheme', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI'), rt.new_string('https')])])
			// unsupported expression: Expr_Exit
		} else {
			rt.call_function('wp_safe_redirect', ['https://' + (rt.get_superglobal('_SERVER').array_get('HTTP_HOST')).str() + (rt.get_superglobal('_SERVER').array_get('REQUEST_URI')).str()])
			// unsupported expression: Expr_Exit
		}
	}
}
