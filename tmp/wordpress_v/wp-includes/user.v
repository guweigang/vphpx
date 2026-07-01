import rt

fn wp_signon(var_credentials rt.PhpVal, secure_cookie string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_credentials) {
		var_credentials = { 'user_login': rt.new_string(''), 'user_password': rt.new_string(''), 'remember': rt.new_bool(false) }
		if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('log'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('log').is_string())))) {
			var_credentials.array_set('user_login', rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('log')]))
		}
		if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('pwd'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('pwd').is_string())))) {
			var_credentials.array_set('user_password', rt.get_superglobal('_POST').array_get('pwd'))
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get('rememberme'))) {
			var_credentials.array_set('remember', rt.get_superglobal('_POST').array_get('rememberme'))
		}
	}
	if !(!rt.is_true(var_credentials.array_get('remember'))) {
		var_credentials.array_set('remember', true)
	} else {
		var_credentials.array_set('remember', false)
	}
	rt.call_function('do_action_ref_array', [rt.new_string('wp_authenticate'), rt.create_array([rt.ArrayItem{ key: none, val: var_credentials.array_get('user_login') }, rt.ArrayItem{ key: none, val: var_credentials.array_get('user_password') }])])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(secure_cookie))) {
		secure_cookie = (rt.call_function('is_ssl', []rt.PhpVal{})).str()
	}
	secure_cookie = (rt.call_function('apply_filters', [rt.new_string('secure_signon_cookie'), rt.new_string(secure_cookie), var_credentials.dup()])).str()
	mut var_auth_secure_cookie := rt.new_string(rt.new_string(secure_cookie)).dup()
	rt.call_function('add_filter', [rt.new_string('authenticate'), rt.new_string('wp_authenticate_cookie'), rt.new_int(30), rt.new_int(3)])
	mut var_user := rt.call_function('wp_authenticate', [var_credentials.array_get('user_login'), var_credentials.array_get('user_password')])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	rt.call_function('wp_set_auth_cookie', [rt.get_property(var_user, 'ID'), var_credentials.array_get('remember'), rt.new_string(secure_cookie)])
	if !(!rt.is_true(rt.get_property(var_user, 'user_activation_key'))) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'), rt.create_array([rt.ArrayItem{ key: 'user_activation_key', val: '' }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_user, 'ID') }])])
		rt.set_property(var_user, 'user_activation_key', rt.new_string(''))
	}
	rt.call_function('do_action', [rt.new_string('wp_login'), rt.get_property(var_user, 'user_login'), var_user.dup()])
	return var_user.dup()
}

fn wp_authenticate_username_password(var_user rt.PhpVal, var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.dup()
	}
	if !rt.is_true(var_username) || !rt.is_true(var_password) {
		if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
			return var_user.dup()
		}
		mut var_error := create_wp_error()
		if !rt.is_true(var_username) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The username field is empty.')])])
		}
		if !rt.is_true(var_password) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_password'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password field is empty.')])])
		}
		return var_error.dup()
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_username.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return create_wp_error(rt.new_string('invalid_username'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The username <strong>%s</strong> is not registered on this site. If you are unsure of your username, try your email address instead.')]), var_username.dup()]))
	}
	var_user = rt.call_function('apply_filters', [rt.new_string('wp_authenticate_user'), var_user.dup(), var_password.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_valid := rt.call_function('wp_check_password', [var_password.dup(), rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return create_wp_error(rt.new_string('incorrect_password'), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password you entered for the username %s is incorrect.')]), '<strong>' + (var_username).str() + '</strong>'])).str() + ' <a href="' + (rt.call_function('wp_lostpassword_url', []rt.PhpVal{})).str() + '">' + (rt.call_function('__', [rt.new_string('Lost your password?')])).str() + '</a>')
	}
	if rt.is_true(rt.call_function('wp_password_needs_rehash', [rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])) {
		rt.call_function('wp_set_password', [var_password.dup(), rt.get_property(var_user, 'ID')])
	}
	return var_user.dup()
}

fn wp_authenticate_email_password(var_user rt.PhpVal, var_email rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.dup()
	}
	if !rt.is_true(var_email) || !rt.is_true(var_password) {
		if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
			return var_user.dup()
		}
		mut var_error := create_wp_error()
		if !rt.is_true(var_email) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email field is empty.')])])
		}
		if !rt.is_true(var_password) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_password'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password field is empty.')])])
		}
		return var_error.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.dup()]))))) {
		return var_user.dup()
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_email.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return create_wp_error(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('Unknown email address. Check again or try your username.')]))
	}
	var_user = rt.call_function('apply_filters', [rt.new_string('wp_authenticate_user'), var_user.dup(), var_password.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	mut var_valid := rt.call_function('wp_check_password', [var_password.dup(), rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return create_wp_error(rt.new_string('incorrect_password'), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password you entered for the email address %s is incorrect.')]), '<strong>' + (var_email).str() + '</strong>'])).str() + ' <a href="' + (rt.call_function('wp_lostpassword_url', []rt.PhpVal{})).str() + '">' + (rt.call_function('__', [rt.new_string('Lost your password?')])).str() + '</a>')
	}
	if rt.is_true(rt.call_function('wp_password_needs_rehash', [rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])) {
		rt.call_function('wp_set_password', [var_password.dup(), rt.get_property(var_user, 'ID')])
	}
	return var_user.dup()
}

fn wp_authenticate_cookie(var_user rt.PhpVal, var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	mut var_auth_secure_cookie := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.dup()
	}
	if !rt.is_true(var_username) && !rt.is_true(var_password) {
		mut var_user_id := rt.call_function('wp_validate_auth_cookie', []rt.PhpVal{})
		if rt.is_true(var_user_id) {
			return create_wp_user(var_user_id.dup())
		}
		if rt.is_true(var_auth_secure_cookie) {
			mut var_auth_cookie := rt.get_constant('SECURE_AUTH_COOKIE')
		} else {
			var_auth_cookie = rt.get_constant('AUTH_COOKIE')
		}
		if !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get(var_auth_cookie))) {
			return create_wp_error(rt.new_string('expired_session'), rt.call_function('__', [rt.new_string('Please log in again.')]))
		}
		// unsupported statement: Stmt_Nop
	}
	return var_user.dup()
}

fn wp_authenticate_application_password(var_input_user rt.PhpVal, var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_input_user, 'WP_User'))) {
		return var_input_user.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.is_in_use() }())))) {
		return var_input_user.dup()
	}
	mut var_is_api_request := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')])) && rt.is_true(rt.get_constant('XMLRPC_REQUEST')))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST'))))))
	var_is_api_request = rt.call_function('apply_filters', [rt.new_string('application_password_is_api_request'), var_is_api_request.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_api_request)))) {
		return var_input_user.dup()
	}
	mut var_error := rt.new_null()
	mut var_user := rt.call_function('get_user_by', [rt.new_string('login'), var_username.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) && rt.is_true(rt.call_function('is_email', [var_username.dup()])))) {
		var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_username.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		if rt.is_true(rt.call_function('is_email', [var_username.dup()])) {
			var_error = create_wp_error(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Unknown email address. Check again or try your username.')]))
		} else {
			var_error = create_wp_error(rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Unknown username. Check again or try your email address.')]))
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_application_passwords_available())))) {
		var_error = create_wp_error(rt.new_string('application_passwords_disabled'), rt.call_function('__', [rt.new_string('Application passwords are not available.')]))
	} else if !(wp_is_application_passwords_available_for_user(var_user.dup())) {
		var_error = create_wp_error(rt.new_string('application_passwords_disabled_for_user'), rt.call_function('__', [rt.new_string('Application passwords are not available for your account. Please contact the site administrator for assistance.')]))
	}
	if rt.is_true(var_error) {
		rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.dup()])
		return var_error.dup()
	}
	var_password = rt.call_function('preg_replace', [rt.new_string('/[^a-z\\d]/i'), rt.new_string(''), var_password.dup()])
	mut var_hashed_passwords := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.get_user_application_passwords(arg_0) }(rt.get_property(var_user, 'ID'))
	{
		mut iter_1 := var_hashed_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.check_password(arg_0, arg_1) }(var_password.dup(), var_item.array_get('password')))))) {
				continue
			}
			var_error = create_wp_error()
			rt.call_function('do_action', [rt.new_string('wp_authenticate_application_password_errors'), var_error.dup(), var_user.dup(), var_item.dup(), var_password.dup()])
			if rt.is_true(rt.call_method(var_error, 'has_errors', []rt.PhpVal{})) {
				rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.dup()])
				return var_error.dup()
			}
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Application_Passwords{}; return temp.record_application_password_usage(arg_0, arg_1) }(rt.get_property(var_user, 'ID'), var_item.array_get('uuid'))
			rt.call_function('do_action', [rt.new_string('application_password_did_authenticate'), var_user.dup(), var_item.dup()])
			return var_user.dup()
		}
	}
	var_error = create_wp_error(rt.new_string('incorrect_password'), rt.call_function('__', [rt.new_string('The provided password is an invalid application password.')]))
	rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.dup()])
	return var_error.dup()
}

fn wp_validate_application_password(var_input_user rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_input_user)) {
		return var_input_user.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_application_passwords_available())))) {
		return var_input_user.dup()
	}
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW'))) {
		return var_input_user.dup()
	}
	mut var_authenticated := wp_authenticate_application_password(rt.new_null(), rt.get_superglobal('_SERVER').array_get('PHP_AUTH_USER'), rt.get_superglobal('_SERVER').array_get('PHP_AUTH_PW'))
	if rt.is_true(rt.new_bool(rt.instance_of(var_authenticated, 'WP_User'))) {
		return rt.get_property(var_authenticated, 'ID')
	}
	return var_input_user.dup()
}

fn wp_authenticate_spam_check(var_user rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		
	}
	return .dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_Application_Passwords {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_application_passwords() &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
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


fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_includes_user_php() {
}
