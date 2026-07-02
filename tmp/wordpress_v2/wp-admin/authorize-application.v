import rt

struct Class_WP_Application_Passwords {
	rt.PhpObjectBase
}

fn create_wp_application_passwords(_args ...rt.PhpVal) &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Application_Passwords) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Application_Passwords) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Application_Passwords) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_error := rt.new_null()
	mut var_new_password := ''
	if rt.get_superglobal('_POST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('authorize_application_password'), rt.get_superglobal('_POST').array_get(rt.new_string('action')))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('authorize_application_password'),
		])
		mut var_success_url := rt.get_superglobal('_POST').array_get(rt.new_string('success_url'))
		mut var_reject_url := rt.get_superglobal('_POST').array_get(rt.new_string('reject_url'))
		mut var_app_name := rt.get_superglobal('_POST').array_get(rt.new_string('app_name'))
		mut var_app_id := rt.get_superglobal('_POST').array_get(rt.new_string('app_id'))
		mut var_redirect := rt.new_string('')
		if rt.get_superglobal('_POST').array_isset(rt.new_string('reject')) {
			if rt.is_true(var_reject_url) {
				var_redirect = var_reject_url.clone()
			} else {
				var_redirect = rt.call_function('admin_url', []rt.PhpVal{})
			}
		} else if rt.get_superglobal('_POST').array_isset(rt.new_string('approve')) {
			mut iife_temp_0 := Class_WP_Application_Passwords{}
			mut iife_result_0 := iife_temp_0.create_new_application_password(rt.call_function('get_current_user_id',
				[]rt.PhpVal{}), rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_app_name },
				rt.ArrayItem{ key: 'app_id', val: var_app_id },
			]))
			mut var_created := iife_result_0
			if rt.is_true(rt.call_function('is_wp_error', [var_created.clone()])) {
				var_error = var_created.clone()
			} else {
				mut list_tmp_1 := var_created
				var_new_password = list_tmp_1.array_get(0)
				if rt.is_true(var_success_url) {
					var_redirect = rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{ key: 'site_url', val: rt.call_function('urlencode', [
								rt.call_function('site_url', []rt.PhpVal{}),
							]) },
							rt.ArrayItem{ key: 'user_login', val: rt.call_function('urlencode', [
								rt.get_property(rt.call_function('wp_get_current_user',
									[]rt.PhpVal{}), 'user_login'),
							]) },
							rt.ArrayItem{ key: 'password', val: rt.call_function('urlencode', [
								rt.new_string(var_new_password.str()).clone(),
							]) },
						]),
						var_success_url.clone(),
					])
				}
			}
		}
		if rt.is_true(var_redirect) {
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		}
	}
	mut var_title := rt.call_function('__', [rt.new_string('Authorize Application')])
	var_app_name = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('app_name')))) {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('app_name'))
	} else {
		rt.new_string('')
	}
	var_app_id = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('app_id')))) {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('app_id'))
	} else {
		rt.new_string('')
	}
	var_success_url = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('success_url')))) {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('success_url'))
	} else {
		rt.new_null()
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('reject_url')))) {
		var_reject_url = rt.get_superglobal('_REQUEST').array_get(rt.new_string('reject_url'))
	} else if rt.is_true(var_success_url) {
		var_reject_url = rt.call_function('add_query_arg', [rt.new_string('success'),
			rt.new_string('false'), var_success_url.clone()])
	} else {
		var_reject_url = rt.new_null()
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_request := rt.call_function('compact', [rt.new_string('app_name'),
		rt.new_string('app_id'), rt.new_string('success_url'),
		rt.new_string('reject_url')])
	mut var_is_valid := rt.call_function('wp_is_authorize_application_password_request_valid', [
		var_request.clone(),
		var_user.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.clone()])) {
		rt.call_function('wp_die', [
			rt.new_string(
				(rt.call_function('__', [rt.new_string('The Authorize Application request is not allowed.')])).str() +
				' ' +(rt.call_function('implode', [rt.new_string(' '), rt.call_method(var_is_valid, 'get_error_messages', []rt.PhpVal{})])).str()),
			rt.call_function('__', [
				rt.new_string('Cannot Authorize Application'),
			]),
		])
	}
	if rt.is_true(rt.call_function('wp_is_site_protected_by_basic_auth', [
		rt.new_string('front'),
	]))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Your website appears to use Basic Authentication, which is not currently compatible with application passwords.'),
			]),
			rt.call_function('__', [
				rt.new_string('Cannot Authorize Application'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'response', val: 501 },
				rt.ArrayItem{ key: 'link_text', val: rt.call_function('__', [
					rt.new_string('Go Back'),
				]) },
				rt.ArrayItem{
					key: 'link_url'
					val: if rt.is_true(var_reject_url) { rt.call_function('add_query_arg', [
							rt.new_string('error'),
							rt.new_string('disabled'),
							var_reject_url.clone(),
						]) } else { rt.call_function('admin_url', []rt.PhpVal{}) }
				},
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_application_passwords_available_for_user', [
		var_user.clone(),
	])))))
	{
		if rt.is_true(rt.call_function('wp_is_application_passwords_available', []rt.PhpVal{})) {
			mut var_message := rt.call_function('__', [
				rt.new_string('Application passwords are not available for your account. Please contact the site administrator for assistance.'),
			])
		} else {
			var_message = rt.call_function('__', [
				rt.new_string('Application passwords are not available.'),
			])
		}
		rt.call_function('wp_die', [var_message.clone(),
			rt.call_function('__', [rt.new_string('Cannot Authorize Application')]),
			rt.create_array([rt.ArrayItem{ key: 'response', val: 501 },
				rt.ArrayItem{ key: 'link_text', val: rt.call_function('__', [
					rt.new_string('Go Back'),
				]) }, rt.ArrayItem{
					key: 'link_url'
					val: if rt.is_true(var_reject_url) { rt.call_function('add_query_arg', [
							rt.new_string('error'),
							rt.new_string('disabled'),
							var_reject_url.clone(),
						]) } else { rt.call_function('admin_url', []rt.PhpVal{}) }
				}])])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('auth-app')])
	rt.call_function('wp_localize_script', [rt.new_string('auth-app'),
		rt.new_string('authApp'),
		rt.create_array([
			rt.ArrayItem{ key: 'site_url', val: rt.call_function('site_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'user_login', val: rt.get_property(var_user, 'user_login') },
			rt.ArrayItem{ key: 'success', val: var_success_url },
			rt.ArrayItem{
				key: 'reject'
				val: if rt.is_true(var_reject_url) {
					var_reject_url
				} else {
					rt.call_function('admin_url', []rt.PhpVal{})
				}
			},
		])])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_wp_error', [var_error.clone()])) {
		rt.call_function('wp_admin_notice', [
			rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' }]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('An application would like to connect to your account.'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_app_name) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Would you like to give the application identifying itself as %s access to your account? You should only do this if you trust the application in question.'),
			]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [var_app_name.clone()])).str() + '</strong>'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Would you like to give this application access to your account? You should only do this if you trust the application in question.'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_blogs := rt.call_function('get_blogs_of_user', [
			rt.get_property(var_user, 'ID'),
			rt.new_bool(true),
		])
		mut var_blogs_count := var_blogs.clone().array_count()
		if var_blogs_count > 1 {
			// unsupported statement: Stmt_InlineHTML
			var_message = rt.call_function('_n', [
				rt.new_string('This will grant access to <a href="%1$s">the %2$s site in this installation that you have permissions on</a>.'),
				rt.new_string('This will grant access to <a href="%1$s">all %2$s sites in this installation that you have permissions on</a>.'),
				rt.new_int(var_blogs_count).clone(),
			])
			if rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{})) {
				var_message = rt.call_function('_n', [
					rt.new_string('This will grant access to <a href="%1$s">the %2$s site on the network as you have Super Admin rights</a>.'),
					rt.new_string('This will grant access to <a href="%1$s">all %2$s sites on the network as you have Super Admin rights</a>.'),
					rt.new_int(var_blogs_count).clone(),
				])
			}
			rt.call_function('printf', [var_message.clone(),
				rt.call_function('admin_url', [rt.new_string('my-sites.php')]),
				rt.call_function('number_format_i18n', [rt.new_int(var_blogs_count).clone()])])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if var_new_password.len > 0 && var_new_password != '0' {
		mut iife_temp_1 := Class_WP_Application_Passwords{}
		mut iife_result_1 := iife_temp_1.chunk_password(rt.new_string(var_new_password.str()))
		mut iife_temp_2 := Class_WP_Application_Passwords{}
		mut iife_result_2 := iife_temp_2.chunk_password(rt.new_string(var_new_password.str()))
		var_message = rt.new_string(
			'<p class="application-password-display">\n\t\t\t\t<label for="new-application-password-value">' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your new password for %s is:')]), rt.new_string('<strong>' + (rt.call_function('esc_html', [var_app_name.clone()])).str() +
			'</strong>')])).str() +
			'\n\t\t\t\t</label>\n\t\t\t\t<input id="new-application-password-value" type="text" class="code" readonly="readonly" value="' +
			(rt.call_function('esc_attr', [iife_result_1])).str() + '" />\n\t\t\t</p>\n\t\t\t<p>' +
			(rt.call_function('__', [rt.new_string('Be sure to save this in a safe location. You will not be able to retrieve it.')])).str() +
			'</p>')
		mut var_args := {
			'type':               rt.new_string('success')
			'additional_classes': map[string]rt.PhpVal{}
			'paragraph_wrap':     rt.new_bool(false)
		}
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array_from_native_map(var_args)])
		rt.call_function('do_action', [
			rt.new_string('wp_authorize_application_password_form_approved_no_js'),
			rt.new_string(var_new_password.str()).clone(),
			var_request.clone(),
			var_user.clone(),
		])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('authorize-application.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [
			rt.new_string('authorize_application_password'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_app_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_success_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_reject_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('New Application Password Name')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_app_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('wp_authorize_application_password_form'),
			var_request.clone(),
			var_user.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Yes, I approve of this connection')]),
			rt.new_string('primary'),
			rt.new_string('approve'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: 'aria-describedby', val: 'description-approve' }]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_success_url) {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('You will be sent to %s')]),
				rt.new_string('<strong><code>' +
					(rt.call_function('esc_html', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
					key: 'site_url'
					val: rt.call_function('site_url', []rt.PhpVal{})
				}, rt.ArrayItem{ key: 'user_login', val: rt.get_property(var_user, 'user_login') }, rt.ArrayItem{
					key: 'password'
					val: '[------]'
				}]), var_success_url.clone()])])).str() +
					'</code></strong>'),
			])
		} else {
			rt.call_function('_e', [
				rt.new_string('You will be given a password to manually enter into the application in question.'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [
				rt.new_string('No, I do not approve of this connection'),
			]),
			rt.new_string('secondary'),
			rt.new_string('reject'),
			rt.new_bool(false),
			rt.create_array([
				rt.ArrayItem{ key: 'aria-describedby', val: 'description-reject' },
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_reject_url) {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('You will be sent to %s')]),
				rt.new_string('<strong><code>' +
					(rt.call_function('esc_html', [var_reject_url.clone()])).str() +
					'</code></strong>'),
			])
		} else {
			rt.call_function('_e', [
				rt.new_string('You will be returned to the WordPress Dashboard, and no changes will be made.'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
