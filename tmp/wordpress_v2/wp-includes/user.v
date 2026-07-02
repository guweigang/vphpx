import rt
import crypto.md5

fn wp_signon(var_credentials_arg rt.PhpVal, secure_cookie string) rt.PhpVal {
	mut var_secure_cookie := secure_cookie
	mut var_credentials := var_credentials_arg
	mut var_wpdb := rt.new_null()
	mut var_auth_secure_cookie := rt.new_null()
	mut var_user := rt.new_null()
	if !rt.is_true(var_credentials) {
		var_credentials = { 'user_login': rt.new_string(''), 'user_password': rt.new_string(''), 'remember': rt.new_bool(false) }
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('log')))) && rt.get_superglobal('_POST').array_get(rt.new_string('log')).is_string() {
			var_credentials.array_set('user_login', rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('log'))]))
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('pwd')))) && rt.get_superglobal('_POST').array_get(rt.new_string('pwd')).is_string() {
			var_credentials.array_set('user_password', rt.get_superglobal('_POST').array_get(rt.new_string('pwd')))
		}
		if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('rememberme')))) {
			var_credentials.array_set('remember', rt.get_superglobal('_POST').array_get(rt.new_string('rememberme')))
		}
	}
	if !(!rt.is_true(var_credentials.array_get(rt.new_string('remember')))) {
		var_credentials.array_set('remember', true)
	} else {
		var_credentials.array_set('remember', false)
	}
	rt.call_function('do_action_ref_array', [rt.new_string('wp_authenticate'), rt.create_array([rt.ArrayItem{ key: none, val: var_credentials.array_get(rt.new_string('user_login')) }, rt.ArrayItem{ key: none, val: var_credentials.array_get(rt.new_string('user_password')) }])])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string((var_secure_cookie).str()))) {
	var_secure_cookie = (rt.call_function('is_ssl', []rt.PhpVal{})).str()
	}
	var_secure_cookie = (rt.call_function('apply_filters', [rt.new_string('secure_signon_cookie'), rt.new_string((var_secure_cookie).str()), rt.create_array_from_native_map(var_credentials)])).str()
	var_auth_secure_cookie = rt.new_string((var_secure_cookie).str())
	rt.call_function('add_filter', [rt.new_string('authenticate'), rt.new_string('wp_authenticate_cookie'), rt.new_int(30), rt.new_int(3)])
	var_user = rt.call_function('wp_authenticate', [var_credentials.array_get(rt.new_string('user_login')), var_credentials.array_get(rt.new_string('user_password'))])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	rt.call_function('wp_set_auth_cookie', [rt.get_property(var_user, 'ID'), var_credentials.array_get(rt.new_string('remember')), rt.new_string((var_secure_cookie).str())])
	if !(!rt.is_true(rt.get_property(var_user, 'user_activation_key'))) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'), rt.create_array([rt.ArrayItem{ key: 'user_activation_key', val: '' }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_user, 'ID') }])])
		rt.set_property(var_user, 'user_activation_key', rt.new_string(''))
	}
	rt.call_function('do_action', [rt.new_string('wp_login'), rt.get_property(var_user, 'user_login'), var_user.clone()])
	return var_user.clone()
}

fn wp_authenticate_username_password(var_user_arg rt.PhpVal, var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	mut var_user := var_user_arg
	mut var_error := rt.new_null()
	mut var_valid := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.clone()
	}
	if !rt.is_true(var_username) || !rt.is_true(var_password) {
		if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
			return var_user.clone()
		}
		var_error = create_wp_error()
		if !rt.is_true(var_username) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The username field is empty.')])])
		}
		if !rt.is_true(var_password) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_password'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password field is empty.')])])
		}
		return var_error.clone()
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_username.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_username'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The username <strong>%s</strong> is not registered on this site. If you are unsure of your username, try your email address instead.')]), var_username.clone()])))
	}
	var_user = rt.call_function('apply_filters', [rt.new_string('wp_authenticate_user'), var_user.clone(), var_password.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	var_valid = rt.call_function('wp_check_password', [var_password.clone(), rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incorrect_password'), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password you entered for the username %s is incorrect.')]), rt.new_string('<strong>' + (var_username).str() + '</strong>')])).str() + ' <a href="' + (rt.call_function('wp_lostpassword_url', []rt.PhpVal{})).str() + '">' + (rt.call_function('__', [rt.new_string('Lost your password?')])).str() + '</a>'))
	}
	if rt.is_true(rt.call_function('wp_password_needs_rehash', [rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])) {
		rt.call_function('wp_set_password', [var_password.clone(), rt.get_property(var_user, 'ID')])
	}
	return var_user.clone()
}

fn wp_authenticate_email_password(var_user_arg rt.PhpVal, var_email rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	mut var_user := var_user_arg
	mut var_error := rt.new_null()
	mut var_valid := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.clone()
	}
	if !rt.is_true(var_email) || !rt.is_true(var_password) {
		if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
			return var_user.clone()
		}
		var_error = create_wp_error()
		if !rt.is_true(var_email) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email field is empty.')])])
		}
		if !rt.is_true(var_password) {
			rt.call_method(var_error, 'add', [rt.new_string('empty_password'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password field is empty.')])])
		}
		return var_error.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email.clone()]))))) {
		return var_user.clone()
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_email.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('Unknown email address. Check again or try your username.')])))
	}
	var_user = rt.call_function('apply_filters', [rt.new_string('wp_authenticate_user'), var_user.clone(), var_password.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	var_valid = rt.call_function('wp_check_password', [var_password.clone(), rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('incorrect_password'), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The password you entered for the email address %s is incorrect.')]), rt.new_string('<strong>' + (var_email).str() + '</strong>')])).str() + ' <a href="' + (rt.call_function('wp_lostpassword_url', []rt.PhpVal{})).str() + '">' + (rt.call_function('__', [rt.new_string('Lost your password?')])).str() + '</a>'))
	}
	if rt.is_true(rt.call_function('wp_password_needs_rehash', [rt.get_property(var_user, 'user_pass'), rt.get_property(var_user, 'ID')])) {
		rt.call_function('wp_set_password', [var_password.clone(), rt.get_property(var_user, 'ID')])
	}
	return var_user.clone()
}

fn wp_authenticate_cookie(var_user rt.PhpVal, var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	mut var_auth_secure_cookie := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_auth_cookie := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		return var_user.clone()
	}
	if !rt.is_true(var_username) && !rt.is_true(var_password) {
		var_user_id = rt.call_function('wp_validate_auth_cookie', []rt.PhpVal{})
		if rt.is_true(var_user_id) {
			return rt.new_object('WP_User', []string{}, create_wp_user(var_user_id.clone()))
		}
		if rt.is_true(var_auth_secure_cookie) {
		var_auth_cookie = rt.get_constant('SECURE_AUTH_COOKIE')
		} else {
		var_auth_cookie = rt.get_constant('AUTH_COOKIE')
		}
		if !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get(var_auth_cookie))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('expired_session'), rt.call_function('__', [rt.new_string('Please log in again.')])))
		}
	}
	return var_user.clone()
}

fn wp_authenticate_application_password(var_input_user rt.PhpVal, var_username rt.PhpVal, var_password_arg rt.PhpVal) rt.PhpVal {
	mut var_password := var_password_arg
	mut var_is_api_request := rt.new_null()
	mut var_error := rt.new_null()
	mut var_user := rt.new_null()
	mut var_hashed_passwords := rt.new_null()
	mut var_item := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_input_user, 'WP_User'))) {
		return var_input_user.clone()
	}
	mut iife_temp_0 := Class_WP_Application_Passwords{}
	mut iife_result_0 := iife_temp_0.is_in_use()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return var_input_user.clone()
	}
	var_is_api_request = rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')])) && rt.is_true(rt.get_constant('XMLRPC_REQUEST')) || rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')])) && rt.is_true(rt.get_constant('REST_REQUEST')))
	var_is_api_request = rt.call_function('apply_filters', [rt.new_string('application_password_is_api_request'), var_is_api_request.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_api_request)))) {
		return var_input_user.clone()
	}
	var_error = rt.new_null()
	var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_username.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) && rt.is_true(rt.call_function('is_email', [var_username.clone()])) {
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_username.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		if rt.is_true(rt.call_function('is_email', [var_username.clone()])) {
		var_error = create_wp_error(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Unknown email address. Check again or try your username.')]))
		} else {
		var_error = create_wp_error(rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Unknown username. Check again or try your email address.')]))
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_application_passwords_available())))) {
	var_error = create_wp_error(rt.new_string('application_passwords_disabled'), rt.call_function('__', [rt.new_string('Application passwords are not available.')]))
	} else if !(wp_is_application_passwords_available_for_user(var_user.clone())) {
	var_error = create_wp_error(rt.new_string('application_passwords_disabled_for_user'), rt.call_function('__', [rt.new_string('Application passwords are not available for your account. Please contact the site administrator for assistance.')]))
	}
	if rt.is_true(var_error) {
		rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.clone()])
		return var_error.clone()
	}
	var_password = rt.call_function('preg_replace', [rt.new_string('/[^a-z\\d]/i'), rt.new_string(''), var_password.clone()])
	mut iife_temp_1 := Class_WP_Application_Passwords{}
	mut iife_result_1 := iife_temp_1.get_user_application_passwords(rt.get_property(var_user, 'ID'))
	var_hashed_passwords = iife_result_1
	mut iter_1 := var_hashed_passwords.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item_shadow := item_1.val
		mut var_key_shadow := item_1.key
		mut iife_temp_2 := Class_WP_Application_Passwords{}
		mut iife_result_2 := iife_temp_2.check_password(var_password.clone(), var_item_shadow['password'])
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
			continue
		}
		var_error = create_wp_error()
		rt.call_function('do_action', [rt.new_string('wp_authenticate_application_password_errors'), var_error.clone(), var_user.clone(), var_item_shadow.clone(), var_password.clone()])
		if rt.is_true(rt.call_method(var_error, 'has_errors', []rt.PhpVal{})) {
			rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.clone()])
			return var_error.clone()
		}
		mut iife_temp_3 := Class_WP_Application_Passwords{}
		mut iife_result_3 := iife_temp_3.record_application_password_usage(rt.get_property(var_user, 'ID'), var_item_shadow['uuid'])
		rt.call_function('do_action', [rt.new_string('application_password_did_authenticate'), var_user.clone(), var_item_shadow.clone()])
		return var_user.clone()
	}
	var_error = create_wp_error(rt.new_string('incorrect_password'), rt.call_function('__', [rt.new_string('The provided password is an invalid application password.')]))
	rt.call_function('do_action', [rt.new_string('application_password_failed_authentication'), var_error.clone()])
	return var_error.clone()
}

fn wp_validate_application_password(var_input_user rt.PhpVal) rt.PhpVal {
	mut var_authenticated := rt.new_null()
	if !(!rt.is_true(var_input_user)) {
		return var_input_user.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_application_passwords_available())))) {
		return var_input_user.clone()
	}
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER')) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW'))) {
		return var_input_user.clone()
	}
	var_authenticated = wp_authenticate_application_password(rt.new_null(), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER')), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW')))
	if rt.is_true(rt.new_bool(rt.instance_of(var_authenticated, 'WP_User'))) {
		return rt.get_property(var_authenticated, 'ID')
	}
	return var_input_user.clone()
}

fn wp_authenticate_spam_check(var_user rt.PhpVal) rt.PhpVal {
	mut var_spammed := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_spammed = rt.call_function('apply_filters', [rt.new_string('check_is_user_spammed'), rt.call_function('is_user_spammy', [var_user.clone()]), var_user.clone()])
		if rt.is_true(var_spammed) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('spammer_account'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Your account has been marked as a spammer.')])))
		}
	}
	return var_user.clone()
}

fn wp_validate_logged_in_cookie(var_user_id rt.PhpVal) bool {
	if rt.is_true(var_user_id) {
		return (var_user_id).to_bool()
	}
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) || !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('LOGGED_IN_COOKIE'))) {
		return false
	}
	return (rt.call_function('wp_validate_auth_cookie', [rt.get_superglobal('_COOKIE').array_get(rt.get_constant('LOGGED_IN_COOKIE')), rt.new_string('logged_in')])).to_bool()
}

fn count_user_posts(var_userid rt.PhpVal, post_type string, public_only bool) rt.PhpVal {
	mut var_post_type := post_type
	mut var_public_only := public_only
	mut var_wpdb := rt.new_null()
	mut var_where := rt.new_null()
	mut var_query := ''
	mut var_last_changed := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_count := rt.new_null()
	var_post_type = (rt.call_function('array_unique', [rt.cast_array(rt.new_string((var_post_type).str()))])).str()
	rt.call_function('sort', [rt.new_string((var_post_type).str())])
	var_where = rt.call_function('get_posts_by_author_sql', [rt.new_string((var_post_type).str()), rt.new_bool(true), var_userid.clone(), rt.new_bool(public_only)])
	var_query = rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_where)
	var_last_changed = rt.call_function('wp_cache_get_last_changed', [rt.new_string('posts')])
	var_cache_key = rt.new_string('count_user_posts:' + md5.hexhash(var_query))
	var_count = rt.call_function('wp_cache_get_salted', [var_cache_key.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		var_count = rt.call_method(var_wpdb, 'get_var', [rt.new_string((var_query).str()).clone()])
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), var_count.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_usernumposts'), var_count.clone(), var_userid.clone(), rt.new_string((var_post_type).str()), rt.new_bool(public_only)])
}

fn count_many_users_posts(var_users_arg rt.PhpVal, post_type string, public_only bool) rt.PhpVal {
	mut var_post_type := post_type
	mut var_public_only := public_only
	mut var_users := var_users_arg
	mut var_wpdb := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_userlist := rt.new_null()
	mut var_where := rt.new_null()
	mut var_query := ''
	mut var_cache_key := rt.new_null()
	mut var_cache_salts := []rt.PhpVal{}
	mut var_count := rt.new_null()
	mut var_result := rt.new_null()
	mut var_row := rt.new_null()
	if !rt.is_true(var_users) || !(var_users.clone().is_array()) {
		return rt.new_array()
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_count_many_users_posts'), rt.new_null(), var_users.clone(), rt.new_string((var_post_type).str()), rt.new_bool(public_only)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.clone()
	}
	var_users = rt.call_function('array_unique', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('intval'), var_users.clone()])])])
	rt.call_function('sort', [var_users.clone()])
	var_post_type = (rt.call_function('array_unique', [rt.cast_array(rt.new_string((var_post_type).str()))])).str()
	rt.call_function('sort', [rt.new_string((var_post_type).str())])
	var_userlist = rt.call_function('implode', [rt.new_string(','), var_users.clone()])
	var_where = rt.call_function('get_posts_by_author_sql', [rt.new_string((var_post_type).str()), rt.new_bool(true), rt.new_null(), rt.new_bool(public_only)])
	var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_author, COUNT(*) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_where), rt.new_string(' AND post_author IN (')), var_userlist), rt.new_string(') GROUP BY post_author'))
	var_cache_key = rt.new_string('count_many_users_posts:' + md5.hexhash(var_query))
	var_cache_salts = [rt.call_function('wp_cache_get_last_changed', [rt.new_string('posts')]), rt.call_function('wp_cache_get_last_changed', [rt.new_string('users')])]
	var_count = rt.call_function('wp_cache_get_salted', [var_cache_key.clone(), rt.new_string('post-queries'), rt.create_array_from_list(var_cache_salts)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		var_result = rt.call_method(var_wpdb, 'get_results', [rt.new_string((var_query).str()).clone(), rt.get_constant('ARRAY_N')])
		var_count = rt.call_function('array_fill_keys', [var_users.clone(), rt.new_int(0)])
		mut iter_2 := var_result.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_row_shadow := item_2.val
			var_count.array_set(var_row_shadow.array_get(rt.new_int(0)), var_row_shadow.array_get(rt.new_int(1)))
		}
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), var_count.clone(), rt.new_string('post-queries'), rt.create_array_from_list(var_cache_salts), rt.get_constant('HOUR_IN_SECONDS')])
	}
	return var_count.clone()
}

fn get_current_user_id() i64 {
	mut var_user := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_current_user')]))))) {
		return 0
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	return rt.new_int((if !(rt.get_property(var_user, 'ID')).is_null() { rt.get_property(var_user, 'ID') } else { rt.new_int(0) }).to_i64())
}

fn get_user_option(var_option rt.PhpVal, user i64, deprecated string) bool {
	mut var_user := user
	mut var_deprecated := deprecated
	mut var_wpdb := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_result := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('3.0.0')])
	}
	if var_user == 0 {
	var_user = get_current_user_id()
	}
	var_user = (rt.call_function('get_userdata', [rt.new_int(var_user)])).to_i64()
	if !(var_user != 0) {
		return false
	}
	var_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})
	if rt.is_true(rt.call_method(rt.new_int(var_user), 'has_prop', [rt.new_string((var_prefix).str() + (var_option).str())])) {
	var_result = rt.call_method(rt.new_int(var_user), 'get', [rt.new_string((var_prefix).str() + (var_option).str())])
	} else if rt.is_true(rt.call_method(rt.new_int(var_user), 'has_prop', [var_option.clone()])) {
	var_result = rt.call_method(rt.new_int(var_user), 'get', [var_option.clone()])
	} else {
	var_result = rt.new_bool(false)
	}
	return (rt.call_function('apply_filters', [rt.new_string("get_user_option_${var_option.to_string()}"), var_result.clone(), var_option.clone(), rt.new_int(var_user)])).to_bool()
}

fn update_user_option(var_user_id rt.PhpVal, var_option_name_arg rt.PhpVal, var_newvalue rt.PhpVal, is_global bool) rt.PhpVal {
	mut var_is_global := is_global
	mut var_option_name := var_option_name_arg
	mut var_wpdb := rt.new_null()
	if !(var_is_global) {
	var_option_name = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + (var_option_name).str())
	}
	return update_user_meta(var_user_id.clone(), var_option_name.clone(), var_newvalue.clone(), '')
}

fn delete_user_option(var_user_id rt.PhpVal, var_option_name_arg rt.PhpVal, is_global bool) rt.PhpVal {
	mut var_is_global := is_global
	mut var_option_name := var_option_name_arg
	mut var_wpdb := rt.new_null()
	if !(var_is_global) {
	var_option_name = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + (var_option_name).str())
	}
	return delete_user_meta(var_user_id.clone(), var_option_name.clone(), '')
}

fn get_user(var_user_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.clone()])
}

fn get_users(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_user_search := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone()])
	var_args.array_set('count_total', false)
	var_user_search = create_wp_user_query(var_args.clone())
	return rt.cast_array(var_user_search.get_results())
}

fn wp_list_users(var_args rt.PhpVal) string {
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_return := ''
	mut var_query_args := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user := rt.new_null()
	mut var_name := rt.new_null()
	mut var_row := rt.new_null()
	mut var_alt := rt.new_null()
	var_defaults = { 'orderby': rt.new_string('name'), 'order': rt.new_string('ASC'), 'number': rt.new_string(''), 'exclude_admin': rt.new_bool(true), 'show_fullname': rt.new_bool(false), 'feed': rt.new_string(''), 'feed_image': rt.new_string(''), 'feed_type': rt.new_string(''), 'echo': rt.new_bool(true), 'style': rt.new_string('list'), 'html': rt.new_bool(true), 'exclude': rt.new_string(''), 'include': rt.new_string('') }
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_return = ''
	var_query_args = rt.call_function('wp_array_slice_assoc', [var_parsed_args.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'exclude' }, rt.ArrayItem{ key: none, val: 'include' }])])
	var_query_args.array_set('fields', 'ids')
	var_query_args = rt.call_function('apply_filters', [rt.new_string('wp_list_users_args'), var_query_args.clone(), var_parsed_args.clone()])
	var_users = get_users(var_query_args.clone())
	mut iter_3 := var_users.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_user_id_shadow := item_3.val
		var_user = rt.call_function('get_userdata', [var_user_id_shadow.clone()])
		if rt.is_true(var_parsed_args.array_get(rt.new_string('exclude_admin'))) && rt.is_true(rt.identical(rt.new_string('admin'), rt.get_property(var_user, 'display_name'))) {
			continue
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('show_fullname'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user, 'first_name'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user, 'last_name'))))) {
		var_name = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('Display name based on first name and last name')]), rt.get_property(var_user, 'first_name'), rt.get_property(var_user, 'last_name')])
		} else {
		var_name = rt.get_property(var_user, 'display_name')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('html')))))) {
			var_return = var_return + (var_name).str() + ', '
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get(rt.new_string('style')))) {
			var_return = var_return + '<li>'
		}
		var_row = var_name.clone()
		if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('feed_image')))) || !(!rt.is_true(var_parsed_args.array_get(rt.new_string('feed')))) {
			var_row = rt.concat(var_row, rt.new_string(' '))
			if !rt.is_true(var_parsed_args.array_get(rt.new_string('feed_image'))) {
				var_row = rt.concat(var_row, rt.new_string('('))
			}
			var_row = rt.concat(var_row, rt.new_string('<a href="' + (rt.call_function('get_author_feed_link', [rt.get_property(var_user, 'ID'), var_parsed_args.array_get(rt.new_string('feed_type'))])).str() + '"'))
			var_alt = rt.new_string('')
			if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('feed')))) {
			var_alt = rt.new_string(' alt="' + (rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('feed'))])).str() + '"')
			var_name = var_parsed_args.array_get(rt.new_string('feed'))
			}
			var_row = rt.concat(var_row, rt.new_string('>'))
			if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('feed_image')))) {
				var_row = rt.concat(var_row, rt.new_string('<img src="' + (rt.call_function('esc_url', [var_parsed_args.array_get(rt.new_string('feed_image'))])).str() + '" style="border: none;"' + (var_alt).str() + ' />'))
			} else {
				var_row = rt.concat(var_row, var_name)
			}
			var_row = rt.concat(var_row, rt.new_string('</a>'))
			if !rt.is_true(var_parsed_args.array_get(rt.new_string('feed_image'))) {
				var_row = rt.concat(var_row, rt.new_string(')'))
			}
		}
		var_return = var_return + (var_row).str()
		var_return = var_return + if rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get(rt.new_string('style')))) { '</li>' } else { ', ' }
	}
	var_return = var_return.trim_right(' \t\n\r')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('echo')))))) {
		return var_return
	}
	print(var_return)
	return ''
}

fn get_blogs_of_user(var_user_id_arg rt.PhpVal, all bool) rt.PhpVal {
	mut var_all := all
	mut var_user_id := var_user_id_arg
	mut var_wpdb := rt.new_null()
	mut var_sites := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_site_id := rt.new_null()
	mut var_site_ids := []rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_args := rt.new_null()
	mut var__sites := rt.new_null()
	mut var_site := rt.new_null()
	var_user_id = rt.new_int((var_user_id).to_i64())
	if !rt.is_true(var_user_id) {
		return rt.new_array()
	}
	var_sites = rt.call_function('apply_filters', [rt.new_string('pre_get_blogs_of_user'), rt.new_null(), var_user_id.clone(), rt.new_bool(all)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sites)))) {
		return var_sites.clone()
	}
	var_keys = get_user_meta(var_user_id.clone(), '', false)
	if !rt.is_true(var_keys) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
		var_sites = rt.create_array([rt.ArrayItem{ key: var_site_id, val: create_stdclass() }])
		rt.set_property(var_sites.array_get(var_site_id), 'userblog_id', var_site_id.clone())
		rt.set_property(var_sites.array_get(var_site_id), 'blogname', rt.call_function('get_option', [rt.new_string('blogname')]))
		rt.set_property(var_sites.array_get(var_site_id), 'domain', rt.new_string(''))
		rt.set_property(var_sites.array_get(var_site_id), 'path', rt.new_string(''))
		rt.set_property(var_sites.array_get(var_site_id), 'site_id', rt.new_int(1))
		rt.set_property(var_sites.array_get(var_site_id), 'siteurl', rt.call_function('get_option', [rt.new_string('siteurl')]))
		rt.set_property(var_sites.array_get(var_site_id), 'archived', rt.new_int(0))
		rt.set_property(var_sites.array_get(var_site_id), 'spam', rt.new_int(0))
		rt.set_property(var_sites.array_get(var_site_id), 'deleted', rt.new_int(0))
		return var_sites.clone()
	}
	var_site_ids = rt.new_array()
	if var_keys.array_isset((rt.get_property(var_wpdb, 'base_prefix')).str() + 'capabilities') && rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')])) {
		var_site_ids << 1
		var_keys.array_unset((rt.get_property(var_wpdb, 'base_prefix')).str() + 'capabilities')
	}
	var_keys = rt.func_array_keys(var_keys.clone())
	mut iter_4 := var_keys.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key_shadow := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_key_shadow.clone(), rt.new_string('capabilities')]))))) {
			continue
		}
		if rt.is_true(rt.get_property(var_wpdb, 'base_prefix')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_key_shadow.clone(), rt.get_property(var_wpdb, 'base_prefix')]))))) {
			continue
		}
		var_site_id = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'base_prefix') }, rt.ArrayItem{ key: none, val: '_capabilities' }]), rt.new_string(''), var_key_shadow.clone()])
		if !(var_site_id.clone().is_long() || var_site_id.clone().is_double()) {
			continue
		}
		var_site_ids << rt.new_int((var_site_id).to_i64())
	}
	var_sites = rt.new_array()
	if !(!rt.is_true(var_site_ids)) {
		var_args = rt.create_array([rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'site__in', val: var_site_ids }])
		if !(var_all) {
			var_args.array_set('archived', 0)
			var_args.array_set('spam', 0)
			var_args.array_set('deleted', 0)
		}
		var__sites = rt.call_function('get_sites', [var_args.clone()])
		mut iter_5 := var__sites.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_site_shadow := item_5.val
			var_sites.array_set(rt.get_property(var_site_shadow, 'id'), rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'userblog_id', val: rt.get_property(var_site_shadow, 'id') }, rt.ArrayItem{ key: 'blogname', val: rt.get_property(var_site_shadow, 'blogname') }, rt.ArrayItem{ key: 'domain', val: rt.get_property(var_site_shadow, 'domain') }, rt.ArrayItem{ key: 'path', val: rt.get_property(var_site_shadow, 'path') }, rt.ArrayItem{ key: 'site_id', val: rt.get_property(var_site_shadow, 'network_id') }, rt.ArrayItem{ key: 'siteurl', val: rt.get_property(var_site_shadow, 'siteurl') }, rt.ArrayItem{ key: 'archived', val: rt.get_property(var_site_shadow, 'archived') }, rt.ArrayItem{ key: 'mature', val: rt.get_property(var_site_shadow, 'mature') }, rt.ArrayItem{ key: 'spam', val: rt.get_property(var_site_shadow, 'spam') }, rt.ArrayItem{ key: 'deleted', val: rt.get_property(var_site_shadow, 'deleted') }])))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_blogs_of_user'), var_sites.clone(), var_user_id.clone(), rt.new_bool(all)])
}

fn is_user_member_of_blog(user_id i64, blog_id i64) bool {
	mut var_user_id := user_id
	mut var_blog_id := blog_id
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_capabilities_key := rt.new_null()
	mut var_has_cap := rt.new_null()
	var_user_id = var_user_id
	var_blog_id = var_blog_id
	if var_user_id == 0 {
	var_user_id = get_current_user_id()
	}
	if var_user_id == 0 {
		return false
	} else {
		var_user = rt.call_function('get_userdata', [rt.new_int(var_user_id)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if var_blog_id == 0 {
	var_blog_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	var_blog = rt.call_function('get_site', [rt.new_int(var_blog_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog)))) || !(!(rt.get_property(var_blog, 'domain')).is_null()) || rt.is_true(rt.get_property(var_blog, 'archived')) || rt.is_true(rt.get_property(var_blog, 'spam')) || rt.is_true(rt.get_property(var_blog, 'deleted')) {
		return false
	}
	if 1 == var_blog_id {
	var_capabilities_key = rt.new_string((rt.get_property(var_wpdb, 'base_prefix')).str() + 'capabilities')
	} else {
	var_capabilities_key = rt.new_string((rt.get_property(var_wpdb, 'base_prefix')).str() + var_blog_id.str() + '_capabilities')
	}
	var_has_cap = get_user_meta(rt.new_int(var_user_id), var_capabilities_key.clone(), true)
	return var_has_cap.clone().is_array()
}

fn add_user_meta(var_user_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_unique := unique
	return rt.call_function('add_metadata', [rt.new_string('user'), var_user_id.clone(), var_meta_key.clone(), var_meta_value.clone(), rt.new_bool(unique)])
}

fn delete_user_meta(var_user_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string) rt.PhpVal {
	mut var_meta_value := meta_value
	return rt.call_function('delete_metadata', [rt.new_string('user'), var_user_id.clone(), var_meta_key.clone(), rt.new_string(meta_value)])
}

fn get_user_meta(var_user_id rt.PhpVal, key string, single bool) rt.PhpVal {
	mut var_key := key
	mut var_single := single
	return rt.call_function('get_metadata', [rt.new_string('user'), var_user_id.clone(), rt.new_string(key), rt.new_bool(single)])
}

fn update_user_meta(var_user_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_prev_value := prev_value
	return rt.call_function('update_metadata', [rt.new_string('user'), var_user_id.clone(), var_meta_key.clone(), var_meta_value.clone(), rt.new_string(prev_value)])
}

fn count_users(strategy string, var_site_id_arg rt.PhpVal) rt.PhpVal {
	mut var_strategy := strategy
	mut var_site_id := var_site_id_arg
	mut var_wpdb := rt.new_null()
	mut var_pre := rt.new_null()
	mut var_blog_prefix := rt.new_null()
	mut var_result := rt.new_null()
	mut var_avail_roles := rt.new_null()
	mut var_select_count := rt.new_null()
	mut var_name := rt.new_null()
	mut var_this_role := rt.new_null()
	mut var_row := rt.new_null()
	mut var_col := i64(0)
	mut var_role_counts := rt.new_null()
	mut var_count := rt.new_null()
	mut var_total_users := rt.new_null()
	mut var_users_of_blog := rt.new_null()
	mut var_caps_meta := rt.new_null()
	mut var_b_roles := rt.new_null()
	mut var_val := rt.new_null()
	mut var_b_role := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
	var_site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_count_users'), rt.new_null(), rt.new_string(strategy), var_site_id.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.clone()
	}
	var_blog_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', [var_site_id.clone()])
	var_result = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('time'), rt.new_string(strategy))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_site_id)))) {
			rt.call_function('switch_to_blog', [var_site_id.clone()])
			var_avail_roles = rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'get_names', []rt.PhpVal{})
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		} else {
		var_avail_roles = rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'get_names', []rt.PhpVal{})
		}
		var_select_count = rt.new_array()
		mut iter_6 := var_avail_roles.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_name_shadow := item_6.val
			mut var_this_role_shadow := item_6.key
			var_select_count.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('COUNT(NULLIF(`meta_value` LIKE %s, false))'), rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [rt.new_string('"' + (var_this_role_shadow).str() + '"')])).str() + '%')]))
		}
		var_select_count.array_push('COUNT(NULLIF(`meta_value` = \'a:0:{}\', false))')
		var_select_count = rt.call_function('implode', [rt.new_string(', '), var_select_count.clone()])
		var_row = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT '), var_select_count), rt.new_string(', COUNT(*)\n\t\t\tFROM ')), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'users')), rt.new_string(' ON user_id = ID\n\t\t\tWHERE meta_key = \'')), var_blog_prefix), rt.new_string('capabilities\'\n\t\t')), rt.get_constant('ARRAY_N')])
		var_col = 0
		var_role_counts = rt.new_array()
		mut iter_7 := var_avail_roles.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_name_shadow := item_7.val
			mut var_this_role_shadow := item_7.key
			var_count = rt.new_int((var_row.array_get(rt.post_inc(rt.new_int(var_col)))).to_i64())
			if rt.is_true(rt.greater(var_count, rt.new_int(0))) {
				var_role_counts.array_set(var_this_role_shadow, var_count.clone())
			}
		}
		var_role_counts.array_set('none', rt.new_int((var_row.array_get(rt.post_inc(rt.new_int(var_col)))).to_i64()))
		var_total_users = rt.new_int((var_row.array_get(rt.new_int(var_col))).to_i64())
		var_result.array_set('total_users', var_total_users.clone())
		var_result.array_get(rt.new_string('avail_roles')) = var_role_counts
	} else {
		var_avail_roles = rt.create_array([rt.ArrayItem{ key: 'none', val: 0 }])
		var_users_of_blog = rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT meta_value\n\t\t\tFROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'users')), rt.new_string(' ON user_id = ID\n\t\t\tWHERE meta_key = \'')), var_blog_prefix), rt.new_string('capabilities\'\n\t\t'))])
		mut iter_8 := var_users_of_blog.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_caps_meta_shadow := item_8.val
			var_b_roles = rt.call_function('maybe_unserialize', [var_caps_meta_shadow.clone()])
			if !(var_b_roles.clone().is_array()) {
				continue
			}
			if !rt.is_true(var_b_roles) {
				rt.pre_inc(var_avail_roles.array_get(rt.new_string('none')))
			}
			mut iter_9 := var_b_roles.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_val_shadow := item_9.val
				mut var_b_role_shadow := item_9.key
				if var_avail_roles.array_isset(var_b_role_shadow) {
					rt.pre_inc(var_avail_roles.array_get(var_b_role_shadow))
				} else {
					var_avail_roles.array_set(var_b_role_shadow, 1)
				}
			}
		}
		var_result.array_set('total_users', var_users_of_blog.clone().array_count())
		var_result.array_get(rt.new_string('avail_roles')) = var_avail_roles
	}
	return var_result.clone()
}

fn get_user_count(var_network_id rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_network_id)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to pass %s if not using multisite.')]), rt.new_string('<code>$network_id</code>')]), rt.new_string('6.0.0')])
	}
	return rt.new_int((rt.call_function('get_network_option', [var_network_id.clone(), rt.new_string('user_count'), rt.new_int(-1)])).to_i64())
}

fn wp_maybe_update_user_counts(var_network_id rt.PhpVal) bool {
	mut var_is_small_network := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_network_id)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to pass %s if not using multisite.')]), rt.new_string('<code>$network_id</code>')]), rt.new_string('6.0.0')])
	}
	var_is_small_network = !(rt.is_true(wp_is_large_user_count(var_network_id.clone())))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_live_network_counts'), rt.new_bool(var_is_small_network).clone(), rt.new_string('users')]))))) {
		return false
	}
	return (wp_update_user_counts(var_network_id.clone())).to_bool()
}

fn wp_update_user_counts(var_network_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := ''
	mut var_count := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_network_id)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to pass %s if not using multisite.')]), rt.new_string('<code>$network_id</code>')]), rt.new_string('6.0.0')])
	}
	var_query = rt.concat(rt.new_string('SELECT COUNT(ID) as c FROM '), rt.get_property(var_wpdb, 'users'))
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_query = var_query + ' WHERE spam = \'0\' AND deleted = \'0\''
	}
	var_count = rt.call_method(var_wpdb, 'get_var', [rt.new_string((var_query).str()).clone()])
	return rt.call_function('update_network_option', [var_network_id.clone(), rt.new_string('user_count'), var_count.clone()])
}

fn wp_schedule_update_user_counts() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_update_user_counts')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('twicedaily'), rt.new_string('wp_update_user_counts')])
	}
}

fn wp_is_large_user_count(var_network_id rt.PhpVal) rt.PhpVal {
	mut var_count := i64(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_network_id)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to pass %s if not using multisite.')]), rt.new_string('<code>$network_id</code>')]), rt.new_string('6.0.0')])
	}
	var_count = get_user_count(var_network_id.clone())
	return rt.call_function('apply_filters', [rt.new_string('wp_is_large_user_count'), rt.new_bool(var_count > 10000), rt.new_int(var_count).clone(), var_network_id.clone()])
}

fn setup_userdata(for_user_id i64) {
	mut var_for_user_id := for_user_id
	mut var_user := rt.new_null()
	mut var_user_ID := rt.new_null()
	mut var_user_level := rt.new_null()
	mut var_userdata := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_user_url := rt.new_null()
	mut var_user_identity := rt.new_null()
	if !(var_for_user_id != 0) {
	var_for_user_id = get_current_user_id()
	}
	var_user = rt.call_function('get_userdata', [rt.new_int(var_for_user_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		var_user_ID = rt.new_int(0)
		var_user_level = rt.new_int(0)
		var_userdata = rt.new_null()
		var_user_login = rt.new_string('')
		var_user_email = rt.new_string('')
		var_user_url = rt.new_string('')
		var_user_identity = rt.new_string('')
		return
	}
var_user_ID = rt.new_int((rt.get_property(var_user, 'ID')).to_i64())
var_user_level = rt.new_int((rt.get_property(var_user, 'user_level')).to_i64())
var_userdata = var_user.clone()
var_user_login = rt.get_property(var_user, 'user_login')
var_user_email = rt.get_property(var_user, 'user_email')
var_user_url = rt.get_property(var_user, 'user_url')
var_user_identity = rt.get_property(var_user, 'display_name')
}

fn wp_dropdown_users(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_fields := []rt.PhpVal{}
	mut var_show := rt.new_null()
	mut var_show_option_all := rt.new_null()
	mut var_show_option_none := rt.new_null()
	mut var_option_none_value := rt.new_null()
	mut var_users := rt.new_null()
	mut var_output := rt.new_null()
	mut var_name := rt.new_null()
	mut var_id := rt.new_null()
	mut var__selected := rt.new_null()
	mut var_found_selected := false
	mut var_user := rt.new_null()
	mut var_selected_user := rt.new_null()
	mut var_display := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = { 'show_option_all': rt.new_string(''), 'show_option_none': rt.new_string(''), 'hide_if_only_one_author': rt.new_string(''), 'orderby': rt.new_string('display_name'), 'order': rt.new_string('ASC'), 'include': rt.new_string(''), 'exclude': rt.new_string(''), 'multi': rt.new_int(0), 'show': rt.new_string('display_name'), 'echo': rt.new_int(1), 'selected': rt.new_int(0), 'name': rt.new_string('user'), 'class': rt.new_string(''), 'id': rt.new_string(''), 'blog_id': rt.call_function('get_current_blog_id', []rt.PhpVal{}), 'who': rt.new_string(''), 'include_selected': rt.new_bool(false), 'option_none_value': -1, 'role': rt.new_string(''), 'role__in': rt.new_array(), 'role__not_in': rt.new_array(), 'capability': rt.new_string(''), 'capability__in': rt.new_array(), 'capability__not_in': rt.new_array() }
	var_defaults['selected'] = if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) { rt.call_function('get_query_var', [rt.new_string('author')]) } else { rt.new_int(0) }
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args), rt.create_array_from_native_map(var_defaults)])
	var_query_args = rt.call_function('wp_array_slice_assoc', [var_parsed_args.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'blog_id' }, rt.ArrayItem{ key: none, val: 'include' }, rt.ArrayItem{ key: none, val: 'exclude' }, rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'who' }, rt.ArrayItem{ key: none, val: 'role' }, rt.ArrayItem{ key: none, val: 'role__in' }, rt.ArrayItem{ key: none, val: 'role__not_in' }, rt.ArrayItem{ key: none, val: 'capability' }, rt.ArrayItem{ key: none, val: 'capability__in' }, rt.ArrayItem{ key: none, val: 'capability__not_in' }])])
	var_fields = [rt.new_string('ID'), rt.new_string('user_login')]
	var_show = if !(!rt.is_true(var_parsed_args.array_get(rt.new_string('show')))) { var_parsed_args.array_get(rt.new_string('show')) } else { rt.new_string('display_name') }
	if rt.is_true(rt.identical(rt.new_string('display_name_with_login'), var_show)) {
		var_fields << rt.new_string('display_name')
	} else {
		var_fields << var_show.clone()
	}
	var_query_args.array_set('fields', var_fields.clone())
	var_show_option_all = var_parsed_args.array_get(rt.new_string('show_option_all'))
	var_show_option_none = var_parsed_args.array_get(rt.new_string('show_option_none'))
	var_option_none_value = var_parsed_args.array_get(rt.new_string('option_none_value'))
	var_query_args = rt.call_function('apply_filters', [rt.new_string('wp_dropdown_users_args'), var_query_args.clone(), var_parsed_args.clone()])
	var_users = get_users(var_query_args.clone())
	var_output = rt.new_string('')
	if !(!rt.is_true(var_users)) && !rt.is_true(var_parsed_args.array_get(rt.new_string('hide_if_only_one_author'))) || var_users.clone().array_count() > 1 {
		var_name = rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('name'))])
		if rt.is_true(var_parsed_args.array_get(rt.new_string('multi'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('id')))))) {
		var_id = rt.new_string('')
		} else {
		var_id = rt.new_string((if rt.is_true(var_parsed_args.array_get(rt.new_string('id'))) { ' id=\'' + (rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('id'))])).str() + '\'' } else { " id='${var_name.to_string()}'" }).str())
		}
		var_output = rt.new_string("<select name='${var_name.to_string()}'${var_id.to_string()} class='" + (var_parsed_args.array_get(rt.new_string('class'))).str() + '\'>\n')
		if rt.is_true(var_show_option_all) {
			var_output = rt.concat(var_output, rt.new_string("\t<option value='0'>${var_show_option_all.to_string()}</option>\n"))
		}
		if rt.is_true(var_show_option_none) {
			var__selected = rt.call_function('selected', [var_option_none_value.clone(), var_parsed_args.array_get(rt.new_string('selected')), rt.new_bool(false)])
			var_output = rt.concat(var_output, rt.new_string('\t<option value=\'' + (rt.call_function('esc_attr', [var_option_none_value.clone()])).str() + "'${var__selected.to_string()}>${var_show_option_none.to_string()}</option>\n"))
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('include_selected'))) && rt.is_true(rt.greater(var_parsed_args.array_get(rt.new_string('selected')), rt.new_int(0))) {
			var_found_selected = false
			var_parsed_args.array_set('selected', rt.new_int((var_parsed_args.array_get(rt.new_string('selected'))).to_i64()))
			mut iter_10 := rt.cast_array(var_users).iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_user_shadow := item_10.val
				rt.set_property(var_user_shadow, 'ID', rt.new_int((rt.get_property(var_user_shadow, 'ID')).to_i64()))
				if rt.is_true(rt.identical(rt.get_property(var_user_shadow, 'ID'), var_parsed_args.array_get(rt.new_string('selected')))) {
				var_found_selected = true
				}
			}
			if !(var_found_selected) {
				var_selected_user = rt.call_function('get_userdata', [var_parsed_args.array_get(rt.new_string('selected'))])
				if rt.is_true(var_selected_user) {
					var_users.array_push(var_selected_user.clone())
				}
			}
		}
		mut iter_11 := rt.cast_array(var_users).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_user_shadow := item_11.val
			if rt.is_true(rt.identical(rt.new_string('display_name_with_login'), var_show)) {
			var_display = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s (%2$s)'), rt.new_string('user dropdown')]), rt.get_property(var_user_shadow, 'display_name'), rt.get_property(var_user_shadow, 'user_login')])
			} else if !(!rt.is_true(rt.get_property(var_user_shadow, '{"nodeType":"Expr_Variable","line":1838,"name":"show"}'))) {
			var_display = rt.get_property(var_user_shadow, '{"nodeType":"Expr_Variable","line":1839,"name":"show"}')
			} else {
			var_display = rt.new_string('(' + (rt.get_property(var_user_shadow, 'user_login')).str() + ')')
			}
			var__selected = rt.call_function('selected', [rt.get_property(var_user_shadow, 'ID'), var_parsed_args.array_get(rt.new_string('selected')), rt.new_bool(false)])
			var_output = rt.concat(var_output, rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\t<option value=\''), rt.get_property(var_user_shadow, 'ID')), rt.new_string('\'')), var__selected), rt.new_string('>')) + (rt.call_function('esc_html', [var_display.clone()])).str() + '</option>\n'))
		}
		var_output = rt.concat(var_output, rt.new_string('</select>'))
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_dropdown_users'), var_output.clone()])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	}
	return var_html.clone()
}

fn sanitize_user_field(var_field rt.PhpVal, var_value_arg rt.PhpVal, var_user_id rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_int_fields := []rt.PhpVal{}
	mut var_prefixed := rt.new_null()
	var_int_fields = ['ID']
	if rt.is_true(rt.call_function('in_array', [var_field.clone(), rt.create_array_from_list(var_int_fields), rt.new_bool(true)])) {
	var_value = rt.new_int((var_value).to_i64())
	}
	if rt.is_true(rt.identical(rt.new_string('raw'), var_context)) {
		return var_value.clone()
	}
	if !(var_value.clone().is_string()) && !(var_value.clone().is_long() || var_value.clone().is_double()) {
		return var_value.clone()
	}
	var_prefixed = rt.call_function('str_contains', [var_field.clone(), rt.new_string('user_')])
	if rt.is_true(rt.identical(rt.new_string('edit'), var_context)) {
		if rt.is_true(var_prefixed) {
		var_value = rt.call_function('apply_filters', [rt.new_string("edit_${var_field.to_string()}"), var_value.clone(), var_user_id.clone()])
		} else {
		var_value = rt.call_function('apply_filters', [rt.new_string("edit_user_${var_field.to_string()}"), var_value.clone(), var_user_id.clone()])
		}
		if rt.is_true(rt.identical(rt.new_string('description'), var_field)) {
		var_value = rt.call_function('esc_html', [var_value.clone()])
		} else {
		var_value = rt.call_function('esc_attr', [var_value.clone()])
		}
	} else if rt.is_true(rt.identical(rt.new_string('db'), var_context)) {
		if rt.is_true(var_prefixed) {
		var_value = rt.call_function('apply_filters', [rt.new_string("pre_${var_field.to_string()}"), var_value.clone()])
		} else {
		var_value = rt.call_function('apply_filters', [rt.new_string("pre_user_${var_field.to_string()}"), var_value.clone()])
		}
	} else {
		if rt.is_true(var_prefixed) {
		var_value = rt.call_function('apply_filters', [rt.new_string("${var_field.to_string()}"), var_value.clone(), var_user_id.clone(), var_context.clone()])
		} else {
		var_value = rt.call_function('apply_filters', [rt.new_string("user_${var_field.to_string()}"), var_value.clone(), var_user_id.clone(), var_context.clone()])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('user_url'), var_field)) {
	var_value = rt.call_function('esc_url', [var_value.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('attribute'), var_context)) {
	var_value = rt.call_function('esc_attr', [var_value.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('js'), var_context)) {
	var_value = rt.call_function('esc_js', [var_value.clone()])
	}
	if rt.is_true(rt.call_function('in_array', [var_field.clone(), rt.create_array_from_list(var_int_fields), rt.new_bool(true)])) {
	var_value = rt.new_int((var_value).to_i64())
	}
	return var_value.clone()
}

fn update_user_caches(var_user_arg rt.PhpVal) bool {
	mut var_user := var_user_arg
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
			return false
		}
	var_user = rt.get_property(var_user, 'data')
	}
	rt.call_function('wp_cache_add', [rt.get_property(var_user, 'ID'), var_user.clone(), rt.new_string('users')])
	rt.call_function('wp_cache_add', [rt.get_property(var_user, 'user_login'), rt.get_property(var_user, 'ID'), rt.new_string('userlogins')])
	rt.call_function('wp_cache_add', [rt.get_property(var_user, 'user_nicename'), rt.get_property(var_user, 'ID'), rt.new_string('userslugs')])
	if !(!rt.is_true(rt.get_property(var_user, 'user_email'))) {
		rt.call_function('wp_cache_add', [rt.get_property(var_user, 'user_email'), rt.get_property(var_user, 'ID'), rt.new_string('useremail')])
	}
	return false
}

fn clean_user_cache(var_user_arg rt.PhpVal) {
	mut var_user := var_user_arg
	if rt.is_true(rt.new_bool(var_user.clone().is_long() || var_user.clone().is_double())) {
	var_user = create_wp_user(var_user.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('wp_cache_delete', [rt.get_property(var_user, 'ID'), rt.new_string('users')])
	rt.call_function('wp_cache_delete', [rt.get_property(var_user, 'user_login'), rt.new_string('userlogins')])
	rt.call_function('wp_cache_delete', [rt.get_property(var_user, 'user_nicename'), rt.new_string('userslugs')])
	if !(!rt.is_true(rt.get_property(var_user, 'user_email'))) {
		rt.call_function('wp_cache_delete', [rt.get_property(var_user, 'user_email'), rt.new_string('useremail')])
	}
	rt.call_function('wp_cache_delete', [rt.get_property(var_user, 'ID'), rt.new_string('user_meta')])
	wp_cache_set_users_last_changed()
	rt.call_function('do_action', [rt.new_string('clean_user_cache'), rt.get_property(var_user, 'ID'), var_user.clone()])
}

fn username_exists(var_username rt.PhpVal) rt.PhpVal {
	mut var_user := rt.new_null()
	mut var_user_id := rt.new_null()
	var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_username.clone()])
	if rt.is_true(var_user) {
	var_user_id = rt.get_property(var_user, 'ID')
	} else {
	var_user_id = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [rt.new_string('username_exists'), var_user_id.clone(), var_username.clone()])
}

fn email_exists(var_email rt.PhpVal) rt.PhpVal {
	mut var_user := rt.new_null()
	mut var_user_id := rt.new_null()
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), var_email.clone()])
	if rt.is_true(var_user) {
	var_user_id = rt.get_property(var_user, 'ID')
	} else {
	var_user_id = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [rt.new_string('email_exists'), var_user_id.clone(), var_email.clone()])
}

fn validate_username(var_username rt.PhpVal) rt.PhpVal {
	mut var_sanitized := rt.new_null()
	mut var_valid := false
	var_sanitized = rt.call_function('sanitize_user', [var_username.clone(), rt.new_bool(true)])
	var_valid = rt.is_true(rt.identical(var_sanitized, var_username)) && !(!rt.is_true(var_sanitized))
	return rt.call_function('apply_filters', [rt.new_string('validate_username'), rt.new_bool(var_valid).clone(), var_username.clone()])
}

fn wp_insert_user(var_userdata_arg rt.PhpVal) rt.PhpVal {
	mut var_userdata := var_userdata_arg
	mut var_wpdb := rt.new_null()
	mut var_userdata_obj := rt.new_null()
	mut var_key := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_update := false
	mut var_old_user_data := rt.new_null()
	mut var_user_pass := rt.new_null()
	mut var_sanitized_user_login := rt.new_null()
	mut var_pre_user_login := rt.new_null()
	mut var_user_login := ''
	mut var_illegal_logins := rt.new_null()
	mut var_user_nicename := rt.new_null()
	mut var_user_nicename_check := rt.new_null()
	mut var_suffix := i64(0)
	mut var_base_length := rt.new_null()
	mut var_alt_user_nicename := rt.new_null()
	mut var_raw_user_email := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_raw_user_url := rt.new_null()
	mut var_user_url := rt.new_null()
	mut var_user_registered := rt.new_null()
	mut var_user_activation_key := rt.new_null()
	mut var_spam := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_nickname := rt.new_null()
	mut var_first_name := rt.new_null()
	mut var_last_name := rt.new_null()
	mut var_display_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_admin_color := rt.new_null()
	mut var_compacted := rt.new_null()
	mut var_data := rt.new_null()
	mut var_user := rt.new_null()
	mut var_custom_meta := rt.new_null()
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'stdClass'))) {
	var_userdata = rt.call_function('get_object_vars', [var_userdata.clone()])
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'WP_User'))) {
	var_userdata = rt.call_method(var_userdata, 'to_array', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'Traversable'))) {
	var_userdata = rt.call_function('iterator_to_array', [var_userdata.clone()])
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'ArrayAccess'))) {
		var_userdata_obj = var_userdata.clone()
		var_userdata = rt.new_array()
		mut iter_12 := rt.create_array([rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'user_pass' }, rt.ArrayItem{ key: none, val: 'user_login' }, rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{ key: none, val: 'user_url' }, rt.ArrayItem{ key: none, val: 'user_email' }, rt.ArrayItem{ key: none, val: 'display_name' }, rt.ArrayItem{ key: none, val: 'nickname' }, rt.ArrayItem{ key: none, val: 'first_name' }, rt.ArrayItem{ key: none, val: 'last_name' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'rich_editing' }, rt.ArrayItem{ key: none, val: 'syntax_highlighting' }, rt.ArrayItem{ key: none, val: 'comment_shortcuts' }, rt.ArrayItem{ key: none, val: 'admin_color' }, rt.ArrayItem{ key: none, val: 'use_ssl' }, rt.ArrayItem{ key: none, val: 'user_registered' }, rt.ArrayItem{ key: none, val: 'user_activation_key' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'show_admin_bar_front' }, rt.ArrayItem{ key: none, val: 'role' }, rt.ArrayItem{ key: none, val: 'locale' }, rt.ArrayItem{ key: none, val: 'meta_input' }]).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_key_shadow := item_12.val
			if var_userdata_obj.array_isset(var_key_shadow) {
				var_userdata.array_set(var_key_shadow, var_userdata_obj.array_get(var_key_shadow))
			}
		}
	} else {
	var_userdata = rt.cast_array(var_userdata)
	}
	if !(!rt.is_true(var_userdata.array_get(rt.new_string('ID')))) {
		var_user_id = rt.new_int((var_userdata.array_get(rt.new_string('ID'))).to_i64())
		var_update = true
		var_old_user_data = rt.call_function('get_userdata', [var_user_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_old_user_data)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_user_id'), rt.call_function('__', [rt.new_string('Invalid user ID.')])))
		}
		rt.set_property(var_old_user_data, 'user_email', rt.call_function('wp_slash', [rt.get_property(var_old_user_data, 'user_email')]))
	var_user_pass = if !(!rt.is_true(var_userdata.array_get(rt.new_string('user_pass')))) { var_userdata.array_get(rt.new_string('user_pass')) } else { rt.get_property(var_old_user_data, 'user_pass') }
	} else {
		var_update = false
		if !rt.is_true(var_userdata.array_get(rt.new_string('user_pass'))) {
			rt.call_function('wp_trigger_error', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('The user_pass field is required when creating a new user. The user will need to reset their password before logging in.')]), rt.get_constant('E_USER_WARNING')])
			var_userdata.array_set('user_pass', '')
		}
	var_user_pass = rt.call_function('wp_hash_password', [var_userdata.array_get(rt.new_string('user_pass'))])
	}
	var_sanitized_user_login = rt.call_function('sanitize_user', [if !(var_userdata.array_get(rt.new_string('user_login'))).is_null() { var_userdata.array_get(rt.new_string('user_login')) } else { rt.new_string('') }, rt.new_bool(true)])
	var_pre_user_login = rt.call_function('apply_filters', [rt.new_string('pre_user_login'), var_sanitized_user_login.clone()])
	var_user_login = var_pre_user_login.clone().to_string().trim_space()
	if var_user_login == '' {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('empty_user_login'), rt.call_function('__', [rt.new_string('Cannot create a user with an empty login name.')])))
	} else if rt.is_true(rt.greater(rt.call_function('mb_strlen', [rt.new_string((var_user_login).str()).clone()]), rt.new_int(60))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('user_login_too_long'), rt.call_function('__', [rt.new_string('Username may not be longer than 60 characters.')])))
	}
	if !(var_update) && rt.is_true(username_exists(rt.new_string((var_user_login).str()).clone())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('existing_user_login'), rt.call_function('__', [rt.new_string('Sorry, that username already exists!')])))
	}
	var_illegal_logins = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_user_login.to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_logins.clone()]), rt.new_bool(true)])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('Sorry, that username is not allowed.')])))
	}
	if !(!rt.is_true(var_userdata.array_get(rt.new_string('user_nicename')))) {
	var_user_nicename = rt.call_function('sanitize_user', [var_userdata.array_get(rt.new_string('user_nicename')), rt.new_bool(true)])
	} else {
	var_user_nicename = rt.call_function('mb_substr', [rt.new_string((var_user_login).str()).clone(), rt.new_int(0), rt.new_int(50)])
	}
	var_user_nicename = rt.call_function('sanitize_title', [var_user_nicename.clone()])
	var_user_nicename = rt.call_function('apply_filters', [rt.new_string('pre_user_nicename'), var_user_nicename.clone()])
	if !rt.is_true(var_user_nicename) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('empty_user_nicename'), rt.call_function('__', [rt.new_string('Cannot create a user with an empty nicename.')])))
	} else if rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_user_nicename.clone()]), rt.new_int(50))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('user_nicename_too_long'), rt.call_function('__', [rt.new_string('Nicename may not be longer than 50 characters.')])))
	}
	var_user_nicename_check = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'users')), rt.new_string(' WHERE user_nicename = %s AND user_login != %s LIMIT 1')), var_user_nicename.clone(), rt.new_string((var_user_login).str()).clone()])])
	if rt.is_true(var_user_nicename_check) {
		var_suffix = 2
		for rt.is_true(var_user_nicename_check) {
			var_base_length = rt.sub(rt.new_int(49), rt.call_function('mb_strlen', [rt.new_int(var_suffix).clone()]))
			var_alt_user_nicename = rt.new_string((rt.call_function('mb_substr', [var_user_nicename.clone(), rt.new_int(0), var_base_length.clone()])).str() + "-${var_suffix.str()}")
			var_user_nicename_check = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'users')), rt.new_string(' WHERE user_nicename = %s AND user_login != %s LIMIT 1')), var_alt_user_nicename.clone(), rt.new_string((var_user_login).str()).clone()])])
			var_suffix += 1
		}
	var_user_nicename = var_alt_user_nicename.clone()
	}
	var_raw_user_email = if !rt.is_true(var_userdata.array_get(rt.new_string('user_email'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('user_email')) }
	var_user_email = rt.call_function('apply_filters', [rt.new_string('pre_user_email'), var_raw_user_email.clone()])
	if !(var_update) || (!(!rt.is_true(var_old_user_data)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [var_user_email.clone(), rt.get_property(var_old_user_data, 'user_email')])))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_IMPORTING')]))))) && rt.is_true(email_exists(var_user_email.clone())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('existing_user_email'), rt.call_function('__', [rt.new_string('Sorry, that email address is already used!')])))
	}
	var_raw_user_url = if !rt.is_true(var_userdata.array_get(rt.new_string('user_url'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('user_url')) }
	var_user_url = rt.call_function('apply_filters', [rt.new_string('pre_user_url'), var_raw_user_url.clone()])
	if rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_user_url.clone()]), rt.new_int(100))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('user_url_too_long'), rt.call_function('__', [rt.new_string('User URL may not be longer than 100 characters.')])))
	}
	var_user_registered = if !rt.is_true(var_userdata.array_get(rt.new_string('user_registered'))) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]) } else { var_userdata.array_get(rt.new_string('user_registered')) }
	var_user_activation_key = if !rt.is_true(var_userdata.array_get(rt.new_string('user_activation_key'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('user_activation_key')) }
	if !(!rt.is_true(var_userdata.array_get(rt.new_string('spam')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_spam'), rt.call_function('__', [rt.new_string('Sorry, marking a user as spam is only supported on Multisite.')])))
	}
	var_spam = if !rt.is_true(var_userdata.array_get(rt.new_string('spam'))) { rt.new_int(0) } else { (var_userdata.array_get(rt.new_string('spam'))).to_bool() }
	var_meta = rt.new_array()
	var_nickname = if !rt.is_true(var_userdata.array_get(rt.new_string('nickname'))) { rt.new_string((var_user_login).str()) } else { var_userdata.array_get(rt.new_string('nickname')) }
	var_meta.array_set('nickname', rt.call_function('apply_filters', [rt.new_string('pre_user_nickname'), var_nickname.clone()]))
	var_first_name = if !rt.is_true(var_userdata.array_get(rt.new_string('first_name'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('first_name')) }
	var_meta.array_set('first_name', rt.call_function('apply_filters', [rt.new_string('pre_user_first_name'), var_first_name.clone()]))
	var_last_name = if !rt.is_true(var_userdata.array_get(rt.new_string('last_name'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('last_name')) }
	var_meta.array_set('last_name', rt.call_function('apply_filters', [rt.new_string('pre_user_last_name'), var_last_name.clone()]))
	if !rt.is_true(var_userdata.array_get(rt.new_string('display_name'))) {
		if var_update {
		var_display_name = rt.new_string((var_user_login).str()).clone()
		} else if rt.is_true(var_meta.array_get(rt.new_string('first_name'))) && rt.is_true(var_meta.array_get(rt.new_string('last_name'))) {
		var_display_name = rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('Display name based on first name and last name')]), var_meta.array_get(rt.new_string('first_name')), var_meta.array_get(rt.new_string('last_name'))])
		} else if rt.is_true(var_meta.array_get(rt.new_string('first_name'))) {
		var_display_name = var_meta.array_get(rt.new_string('first_name'))
		} else if rt.is_true(var_meta.array_get(rt.new_string('last_name'))) {
		var_display_name = var_meta.array_get(rt.new_string('last_name'))
		} else {
		var_display_name = rt.new_string((var_user_login).str()).clone()
		}
	} else {
	var_display_name = var_userdata.array_get(rt.new_string('display_name'))
	}
	var_display_name = rt.call_function('apply_filters', [rt.new_string('pre_user_display_name'), var_display_name.clone()])
	var_description = if !rt.is_true(var_userdata.array_get(rt.new_string('description'))) { rt.new_string('') } else { var_userdata.array_get(rt.new_string('description')) }
	var_meta.array_set('description', rt.call_function('apply_filters', [rt.new_string('pre_user_description'), var_description.clone()]))
	var_meta.array_set('rich_editing', if !rt.is_true(var_userdata.array_get(rt.new_string('rich_editing'))) { rt.new_string('true') } else { var_userdata.array_get(rt.new_string('rich_editing')) })
	var_meta.array_set('syntax_highlighting', if !rt.is_true(var_userdata.array_get(rt.new_string('syntax_highlighting'))) { rt.new_string('true') } else { var_userdata.array_get(rt.new_string('syntax_highlighting')) })
	var_meta.array_set('comment_shortcuts', if !rt.is_true(var_userdata.array_get(rt.new_string('comment_shortcuts'))) || rt.is_true(rt.identical(rt.new_string('false'), var_userdata.array_get(rt.new_string('comment_shortcuts')))) { 'false' } else { 'true' })
	var_admin_color = if !rt.is_true(var_userdata.array_get(rt.new_string('admin_color'))) { rt.new_string('modern') } else { var_userdata.array_get(rt.new_string('admin_color')) }
	var_meta.array_set('admin_color', rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9 _.\\-@]|i'), rt.new_string(''), var_admin_color.clone()]))
	var_meta.array_set('use_ssl', if !rt.is_true(var_userdata.array_get(rt.new_string('use_ssl'))) { '0' } else { '1' })
	var_meta.array_set('show_admin_bar_front', if !rt.is_true(var_userdata.array_get(rt.new_string('show_admin_bar_front'))) { rt.new_string('true') } else { var_userdata.array_get(rt.new_string('show_admin_bar_front')) })
	var_meta.array_set('locale', if !(var_userdata.array_get(rt.new_string('locale'))).is_null() { var_userdata.array_get(rt.new_string('locale')) } else { rt.new_string('') })
	var_compacted = rt.call_function('compact', [rt.new_string('user_pass'), rt.new_string('user_nicename'), rt.new_string('user_email'), rt.new_string('user_url'), rt.new_string('user_registered'), rt.new_string('user_activation_key'), rt.new_string('display_name')])
	var_data = rt.call_function('wp_unslash', [var_compacted.clone()])
	if !(var_update) {
	var_data = rt.add(var_data, rt.call_function('compact', [rt.new_string('user_login')]))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
	var_data = rt.add(var_data, rt.call_function('compact', [rt.new_string('spam')]))
	}
	var_data = rt.call_function('apply_filters', [rt.new_string('wp_pre_insert_user_data'), var_data.clone(), rt.new_bool(var_update).clone(), if var_update { var_user_id } else { rt.new_null() }, var_userdata.clone()])
	if !rt.is_true(var_data) || !(var_data.clone().is_array()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('empty_data'), rt.call_function('__', [rt.new_string('Not enough data to create this user.')])))
	}
	if var_update {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_user_email, rt.get_property(var_old_user_data, 'user_email'))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_user_pass, rt.get_property(var_old_user_data, 'user_pass'))))) {
			var_data.array_set('user_activation_key', '')
		}
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'), var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_user_id }])])
	} else {
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'users'), var_data.clone()])
	var_user_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	}
	var_user = create_wp_user(var_user_id.clone())
	if !(var_update) {
		rt.call_function('do_action', [rt.new_string('wp_set_password'), var_userdata.array_get(rt.new_string('user_pass')), var_user_id.clone(), var_user.clone()])
	}
	var_meta = rt.call_function('apply_filters', [rt.new_string('insert_user_meta'), var_meta.clone(), var_user.clone(), rt.new_bool(var_update).clone(), var_userdata.clone()])
	var_custom_meta = rt.new_array()
	if rt.is_true(rt.new_bool(var_userdata.clone().array_isset(rt.new_string('meta_input')))) && var_userdata.array_get(rt.new_string('meta_input')).is_array() && !(!rt.is_true(var_userdata.array_get(rt.new_string('meta_input')))) {
	var_custom_meta = var_userdata.array_get(rt.new_string('meta_input'))
	}
	var_custom_meta = rt.call_function('apply_filters', [rt.new_string('insert_custom_user_meta'), var_custom_meta.clone(), var_user.clone(), rt.new_bool(var_update).clone(), var_userdata.clone()])
	var_meta = rt.call_function('array_merge', [var_meta.clone(), var_custom_meta.clone()])
	if var_update {
		mut iter_13 := var_meta.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_value_shadow := item_13.val
			mut var_key_shadow := item_13.key
			update_user_meta(var_user_id.clone(), var_key_shadow.clone(), var_value_shadow.clone(), '')
		}
	} else {
		mut iter_14 := var_meta.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_value_shadow := item_14.val
			mut var_key_shadow := item_14.key
			add_user_meta(var_user_id.clone(), var_key_shadow.clone(), var_value_shadow.clone(), false)
		}
	}
	mut iter_15 := wp_get_user_contact_methods(var_user.clone()).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_value_shadow := item_15.val
		mut var_key_shadow := item_15.key
		if var_userdata.array_isset(var_key_shadow) {
			update_user_meta(var_user_id.clone(), var_key_shadow.clone(), var_userdata.array_get(var_key_shadow), '')
		}
	}
	if var_userdata.array_isset(rt.new_string('role')) {
		rt.call_method(var_user, 'set_role', [var_userdata.array_get(rt.new_string('role'))])
	} else if !(var_update) {
		rt.call_method(var_user, 'set_role', [rt.call_function('get_option', [rt.new_string('default_role')])])
	}
	clean_user_cache(var_user_id.clone())
	if var_update {
		rt.call_function('do_action', [rt.new_string('profile_update'), var_user_id.clone(), var_old_user_data.clone(), var_userdata.clone()])
		if var_userdata.array_isset(rt.new_string('spam')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_userdata.array_get(rt.new_string('spam')), rt.get_property(var_old_user_data, 'spam'))))) {
			if rt.is_true(rt.identical(rt.new_string('1'), var_userdata.array_get(rt.new_string('spam')))) {
				rt.call_function('do_action', [rt.new_string('make_spam_user'), var_user_id.clone()])
			} else {
				rt.call_function('do_action', [rt.new_string('make_ham_user'), var_user_id.clone()])
			}
		}
	} else {
		rt.call_function('do_action', [rt.new_string('user_register'), var_user_id.clone(), var_userdata.clone()])
	}
	return var_user_id.clone()
}

fn wp_update_user(var_userdata_arg rt.PhpVal) rt.PhpVal {
	mut var_userdata := var_userdata_arg
	mut var_userdata_raw := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user_obj := rt.new_null()
	mut var_user := rt.new_null()
	mut var_key := rt.new_null()
	mut var_plaintext_pass := rt.new_null()
	mut var_send_password_change_email := rt.new_null()
	mut var_send_email_change_email := rt.new_null()
	mut var_blog_name := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_pass_change_text := rt.new_null()
	mut var_pass_change_email := rt.new_null()
	mut var_email_change_text := rt.new_null()
	mut var_email_change_email := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_logged_in_cookie := rt.new_null()
	mut var_default_cookie_life := rt.new_null()
	mut var_remember := false
	mut var_token := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'stdClass'))) {
	var_userdata = rt.call_function('get_object_vars', [var_userdata.clone()])
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_userdata, 'WP_User'))) {
	var_userdata = rt.call_method(var_userdata, 'to_array', []rt.PhpVal{})
	}
	var_userdata_raw = var_userdata.clone()
	var_user_id = rt.new_int((if !(var_userdata.array_get(rt.new_string('ID'))).is_null() { var_userdata.array_get(rt.new_string('ID')) } else { rt.new_int(0) }).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_user_id'), rt.call_function('__', [rt.new_string('Invalid user ID.')])))
	}
	var_user_obj = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_obj)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_user_id'), rt.call_function('__', [rt.new_string('Invalid user ID.')])))
	}
	var_user = rt.call_method(var_user_obj, 'to_array', []rt.PhpVal{})
	mut iter_16 := _get_additional_user_keys(var_user_obj.clone()).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_key_shadow := item_16.val
		var_user.array_set(var_key_shadow, get_user_meta(var_user_id.clone(), var_key_shadow.clone(), true))
	}
	var_user = rt.call_function('add_magic_quotes', [var_user.clone()])
	if !(!rt.is_true(var_userdata.array_get(rt.new_string('user_pass')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_userdata.array_get(rt.new_string('user_pass')), rt.get_property(var_user_obj, 'user_pass'))))) {
		var_plaintext_pass = var_userdata.array_get(rt.new_string('user_pass'))
		var_userdata.array_set('user_pass', rt.call_function('wp_hash_password', [var_userdata.array_get(rt.new_string('user_pass'))]))
		rt.call_function('do_action', [rt.new_string('wp_set_password'), var_plaintext_pass.clone(), var_user_id.clone(), var_user_obj.clone()])
	var_send_password_change_email = rt.call_function('apply_filters', [rt.new_string('send_password_change_email'), rt.new_bool(true), var_user.clone(), var_userdata.clone()])
	}
	if var_userdata.array_isset(rt.new_string('user_email')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_user.array_get(rt.new_string('user_email')), var_userdata.array_get(rt.new_string('user_email')))))) {
	var_send_email_change_email = rt.call_function('apply_filters', [rt.new_string('send_email_change_email'), rt.new_bool(true), var_user.clone(), var_userdata.clone()])
	}
	clean_user_cache(var_user_obj.clone())
	var_userdata = rt.call_function('array_merge', [var_user.clone(), var_userdata.clone()])
	var_user_id = wp_insert_user(var_userdata.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
		return var_user_id.clone()
	}
	var_blog_name = rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')])
	var_switched_locale = rt.new_bool(false)
	if !(!rt.is_true(var_send_password_change_email)) || !(!rt.is_true(var_send_email_change_email)) {
	var_switched_locale = rt.call_function('switch_to_user_locale', [var_user_id.clone()])
	}
	if !(!rt.is_true(var_send_password_change_email)) {
		var_pass_change_text = rt.call_function('__', [rt.new_string('Hi ###USERNAME###,\n\nThis notice confirms that your password was changed on ###SITENAME###.\n\nIf you did not change your password, please contact the Site Administrator at\n###ADMIN_EMAIL###\n\nThis email has been sent to ###EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
		var_pass_change_email = rt.create_array([rt.ArrayItem{ key: 'to', val: var_user.array_get(rt.new_string('user_email')) }, rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [rt.new_string('[%s] Password Changed')]) }, rt.ArrayItem{ key: 'message', val: var_pass_change_text }, rt.ArrayItem{ key: 'headers', val: '' }])
		var_pass_change_email = rt.call_function('apply_filters', [rt.new_string('password_change_email'), var_pass_change_email.clone(), var_user.clone(), var_userdata.clone()])
		var_pass_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###USERNAME###'), var_user.array_get(rt.new_string('user_login')), var_pass_change_email.array_get(rt.new_string('message'))]))
		var_pass_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###ADMIN_EMAIL###'), rt.call_function('get_option', [rt.new_string('admin_email')]), var_pass_change_email.array_get(rt.new_string('message'))]))
		var_pass_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###EMAIL###'), var_user.array_get(rt.new_string('user_email')), var_pass_change_email.array_get(rt.new_string('message'))]))
		var_pass_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_blog_name.clone(), var_pass_change_email.array_get(rt.new_string('message'))]))
		var_pass_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('home_url', []rt.PhpVal{}), var_pass_change_email.array_get(rt.new_string('message'))]))
		rt.call_function('wp_mail', [var_pass_change_email.array_get(rt.new_string('to')), rt.call_function('sprintf', [var_pass_change_email.array_get(rt.new_string('subject')), var_blog_name.clone()]), var_pass_change_email.array_get(rt.new_string('message')), var_pass_change_email.array_get(rt.new_string('headers'))])
	}
	if !(!rt.is_true(var_send_email_change_email)) {
		var_email_change_text = rt.call_function('__', [rt.new_string('Hi ###USERNAME###,\n\nThis notice confirms that your email address on ###SITENAME### was changed to ###NEW_EMAIL###.\n\nIf you did not change your email, please contact the Site Administrator at\n###ADMIN_EMAIL###\n\nThis email has been sent to ###EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
		var_email_change_email = rt.create_array([rt.ArrayItem{ key: 'to', val: var_user.array_get(rt.new_string('user_email')) }, rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [rt.new_string('[%s] Email Changed')]) }, rt.ArrayItem{ key: 'message', val: var_email_change_text }, rt.ArrayItem{ key: 'headers', val: '' }])
		var_email_change_email = rt.call_function('apply_filters', [rt.new_string('email_change_email'), var_email_change_email.clone(), var_user.clone(), var_userdata.clone()])
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###USERNAME###'), var_user.array_get(rt.new_string('user_login')), var_email_change_email.array_get(rt.new_string('message'))]))
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###ADMIN_EMAIL###'), rt.call_function('get_option', [rt.new_string('admin_email')]), var_email_change_email.array_get(rt.new_string('message'))]))
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###NEW_EMAIL###'), var_userdata.array_get(rt.new_string('user_email')), var_email_change_email.array_get(rt.new_string('message'))]))
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###EMAIL###'), var_user.array_get(rt.new_string('user_email')), var_email_change_email.array_get(rt.new_string('message'))]))
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_blog_name.clone(), var_email_change_email.array_get(rt.new_string('message'))]))
		var_email_change_email.array_set('message', rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('home_url', []rt.PhpVal{}), var_email_change_email.array_get(rt.new_string('message'))]))
		rt.call_function('wp_mail', [var_email_change_email.array_get(rt.new_string('to')), rt.call_function('sprintf', [var_email_change_email.array_get(rt.new_string('subject')), var_blog_name.clone()]), var_email_change_email.array_get(rt.new_string('message')), var_email_change_email.array_get(rt.new_string('headers'))])
	}
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.get_property(var_current_user, 'ID'), var_user_id)) {
		if !(var_plaintext_pass).is_null() {
			var_logged_in_cookie = rt.call_function('wp_parse_auth_cookie', [rt.new_string(''), rt.new_string('logged_in')])
			var_default_cookie_life = rt.call_function('apply_filters', [rt.new_string('auth_cookie_expiration'), rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')), var_user_id.clone(), rt.new_bool(false)])
			rt.call_function('wp_clear_auth_cookie', []rt.PhpVal{})
			var_remember = false
			var_token = rt.new_string('')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_logged_in_cookie)))) {
			var_token = var_logged_in_cookie.array_get(rt.new_string('token'))
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_logged_in_cookie)))) && rt.is_true(rt.greater(rt.sub(rt.new_int((var_logged_in_cookie.array_get(rt.new_string('expiration'))).to_i64()), rt.call_function('time', []rt.PhpVal{})), var_default_cookie_life)) {
			var_remember = true
			}
			rt.call_function('wp_set_auth_cookie', [var_user_id.clone(), rt.new_bool(var_remember).clone(), rt.new_string(''), var_token.clone()])
		}
	}
	rt.call_function('do_action', [rt.new_string('wp_update_user'), var_user_id.clone(), var_userdata.clone(), var_userdata_raw.clone()])
	return var_user_id.clone()
}

fn wp_create_user(var_username rt.PhpVal, var_password rt.PhpVal, email string) rt.PhpVal {
	mut var_email := email
	mut var_user_login := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_user_pass := rt.new_null()
	mut var_userdata := rt.new_null()
	var_user_login = rt.call_function('wp_slash', [var_username.clone()])
	var_user_email = rt.call_function('wp_slash', [rt.new_string(email)])
	var_user_pass = var_password.clone()
	var_userdata = rt.call_function('compact', [rt.new_string('user_login'), rt.new_string('user_email'), rt.new_string('user_pass')])
	return wp_insert_user(var_userdata.clone())
}

fn _get_additional_user_keys(var_user rt.PhpVal) rt.PhpVal {
	mut var_keys := rt.new_null()
	var_keys = rt.create_array([rt.ArrayItem{ key: none, val: 'first_name' }, rt.ArrayItem{ key: none, val: 'last_name' }, rt.ArrayItem{ key: none, val: 'nickname' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'rich_editing' }, rt.ArrayItem{ key: none, val: 'syntax_highlighting' }, rt.ArrayItem{ key: none, val: 'comment_shortcuts' }, rt.ArrayItem{ key: none, val: 'admin_color' }, rt.ArrayItem{ key: none, val: 'use_ssl' }, rt.ArrayItem{ key: none, val: 'show_admin_bar_front' }, rt.ArrayItem{ key: none, val: 'locale' }])
	return rt.call_function('array_merge', [var_keys.clone(), rt.func_array_keys(wp_get_user_contact_methods(var_user.clone()))])
}

fn wp_get_user_contact_methods(var_user rt.PhpVal) rt.PhpVal {
	mut var_methods := rt.new_null()
	var_methods = rt.new_array()
	return rt.call_function('apply_filters', [rt.new_string('user_contactmethods'), var_methods.clone(), var_user.clone()])
}

fn _wp_get_user_contactmethods(var_user rt.PhpVal) rt.PhpVal {
	return wp_get_user_contact_methods(var_user.clone())
}

fn wp_get_password_hint() rt.PhpVal {
	mut var_hint := rt.new_null()
	var_hint = rt.call_function('__', [rt.new_string('Hint: The password should be at least twelve characters long. To make it stronger, use upper and lower case letters, numbers, and symbols like ! " ? $ % ^ &amp; ).')])
	return rt.call_function('apply_filters', [rt.new_string('password_hint'), var_hint.clone()])
}

fn get_password_reset_key(var_user rt.PhpVal) rt.PhpVal {
	mut var_password_reset_allowed := rt.new_null()
	mut var_key := rt.new_null()
	mut var_hashed := rt.new_null()
	mut var_key_saved := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalidcombo'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> There is no account with that username or email address.')])))
	}
	rt.call_function('do_action_deprecated', [rt.new_string('retreive_password'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_user, 'user_login') }]), rt.new_string('1.5.1'), rt.new_string('retrieve_password')])
	rt.call_function('do_action', [rt.new_string('retrieve_password'), rt.get_property(var_user, 'user_login')])
	var_password_reset_allowed = rt.new_bool(wp_is_password_reset_allowed_for_user(var_user.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_password_reset_allowed)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_password_reset'), rt.call_function('__', [rt.new_string('Password reset is not allowed for this user')])))
	} else if rt.is_true(rt.call_function('is_wp_error', [var_password_reset_allowed.clone()])) {
		return var_password_reset_allowed.clone()
	}
	var_key = rt.call_function('wp_generate_password', [rt.new_int(20), rt.new_bool(false)])
	rt.call_function('do_action', [rt.new_string('retrieve_password_key'), rt.get_property(var_user, 'user_login'), var_key.clone()])
	var_hashed = rt.new_string((rt.call_function('time', []rt.PhpVal{})).str() + ':' + (rt.call_function('wp_fast_hash', [var_key.clone()])).str())
	var_key_saved = wp_update_user(rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_user, 'ID') }, rt.ArrayItem{ key: 'user_activation_key', val: var_hashed }]))
	if rt.is_true(rt.call_function('is_wp_error', [var_key_saved.clone()])) {
		return var_key_saved.clone()
	}
	return var_key.clone()
}

fn check_password_reset_key(var_key_arg rt.PhpVal, var_login rt.PhpVal) rt.PhpVal {
	mut var_key := var_key_arg
	mut var_pass_request_time := rt.new_null()
	mut var_user := rt.new_null()
	mut var_expiration_duration := rt.new_null()
	mut var_expiration_time := rt.new_null()
	mut var_pass_key := rt.new_null()
	mut var_hash_is_correct := rt.new_null()
	mut var_return := rt.new_null()
	mut var_user_id := rt.new_null()
	var_key = rt.call_function('preg_replace', [rt.new_string('/[^a-z0-9]/i'), rt.new_string(''), var_key.clone()])
	if !rt.is_true(var_key) || !(var_key.clone().is_string()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
	}
	if !rt.is_true(var_login) || !(var_login.clone().is_string()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('login'), var_login.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
	}
	var_expiration_duration = rt.call_function('apply_filters', [rt.new_string('password_reset_expiration'), rt.get_constant('DAY_IN_SECONDS')])
	if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_user, 'user_activation_key'), rt.new_string(':')])) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'), rt.get_property(var_user, 'user_activation_key'), rt.new_int(2)])
		var_pass_request_time = (list_tmp_1).array_get(0)
		var_pass_key = (list_tmp_1).array_get(1)
	var_expiration_time = rt.add(var_pass_request_time, var_expiration_duration)
	} else {
	var_pass_key = rt.get_property(var_user, 'user_activation_key')
	var_expiration_time = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pass_key)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
	}
	var_hash_is_correct = rt.call_function('wp_verify_fast_hash', [var_key.clone(), var_pass_key.clone()])
	if rt.is_true(var_hash_is_correct) && rt.is_true(var_expiration_time) && rt.is_true(rt.less(rt.call_function('time', []rt.PhpVal{}), var_expiration_time)) {
		return var_user.clone()
	} else if rt.is_true(var_hash_is_correct) && rt.is_true(var_expiration_time) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('expired_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
	}
	if rt.is_true(rt.call_function('hash_equals', [rt.get_property(var_user, 'user_activation_key'), var_key.clone()])) || (rt.is_true(var_hash_is_correct) && rt.is_true(rt.new_bool(!(rt.is_true(var_expiration_time))))) {
		var_return = create_wp_error(rt.new_string('expired_key'), rt.call_function('__', [rt.new_string('Invalid key.')]))
		var_user_id = rt.get_property(var_user, 'ID')
		return rt.call_function('apply_filters', [rt.new_string('password_reset_key_expired'), var_return.clone(), var_user_id.clone()])
	}
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('Invalid key.')])))
}

fn retrieve_password(user_login string) bool {
	mut var_user_login := user_login
	mut var_to := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_user_data := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_key := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_site_name := rt.new_null()
	mut var_message := rt.new_null()
	mut var_requester_ip := rt.new_null()
	mut var_title := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_notification_email := rt.new_null()
	mut var_subject := rt.new_null()
	var_errors = create_wp_error()
	var_user_data = rt.new_bool(false)
	if !(var_user_login.len > 0 && var_user_login != '0') && !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('user_login')))) && rt.get_superglobal('_POST').array_get(rt.new_string('user_login')).is_string() {
	var_user_login = (rt.get_superglobal('_POST').array_get(rt.new_string('user_login'))).str()
	}
	var_user_login = rt.call_function('wp_unslash', [rt.new_string((var_user_login).str())]).to_string().trim_space()
	if var_user_login == '' {
		rt.call_method(var_errors, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter a username or email address.')])])
	} else if rt.is_true(rt.call_function('strpos', [rt.new_string((var_user_login).str()), rt.new_string('@')])) {
		var_user_data = rt.call_function('get_user_by', [rt.new_string('email'), rt.new_string((var_user_login).str())])
		if !rt.is_true(var_user_data) {
		var_user_data = rt.call_function('get_user_by', [rt.new_string('login'), rt.new_string((var_user_login).str())])
		}
		if !rt.is_true(var_user_data) {
			rt.call_method(var_errors, 'add', [rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> There is no account with that username or email address.')])])
		}
	} else {
	var_user_data = rt.call_function('get_user_by', [rt.new_string('login'), rt.new_string((var_user_login).str())])
	}
	var_user_data = rt.call_function('apply_filters', [rt.new_string('lostpassword_user_data'), var_user_data.clone(), var_errors.clone()])
	rt.call_function('do_action', [rt.new_string('lostpassword_post'), var_errors.clone(), var_user_data.clone()])
	var_errors = rt.call_function('apply_filters', [rt.new_string('lostpassword_errors'), var_errors.clone(), var_user_data.clone()])
	if rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})) {
		return (var_errors).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_data)))) {
		rt.call_method(var_errors, 'add', [rt.new_string('invalidcombo'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> There is no account with that username or email address.')])])
		return (var_errors).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('send_retrieve_password_email'), rt.new_bool(true), rt.new_string((var_user_login).str()), var_user_data.clone()]))))) {
		return true
	}
	var_user_login = (rt.get_property(var_user_data, 'user_login')).str()
	var_user_email = rt.get_property(var_user_data, 'user_email')
	var_key = get_password_reset_key(var_user_data.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_key.clone()])) {
		return (var_key).to_bool()
	}
	var_locale = rt.call_function('get_user_locale', [var_user_data.clone()])
	var_switched_locale = rt.call_function('switch_to_user_locale', [rt.get_property(var_user_data, 'ID')])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
	var_site_name = rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name')
	} else {
	var_site_name = rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')])
	}
	var_message = rt.new_string((rt.call_function('__', [rt.new_string('Someone has requested a password reset for the following account:')])).str() + '\r\n\r\n')
	var_message = rt.concat(var_message, rt.new_string((rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Site Name: %s')]), var_site_name.clone()])).str() + '\r\n\r\n'))
	var_message = rt.concat(var_message, rt.new_string((rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Username: %s')]), rt.new_string((var_user_login).str())])).str() + '\r\n\r\n'))
	var_message = rt.concat(var_message, rt.new_string((rt.call_function('__', [rt.new_string('If this was a mistake, ignore this email and nothing will happen.')])).str() + '\r\n\r\n'))
	var_message = rt.concat(var_message, rt.new_string((rt.call_function('__', [rt.new_string('To reset your password, visit the following address:')])).str() + '\r\n\r\n'))
	var_message = rt.concat(var_message, rt.new_string((rt.call_function('network_site_url', [rt.new_string('wp-login.php?login=' + (rt.call_function('rawurlencode', [rt.new_string((var_user_login).str())])).str() + "&key=${var_key.to_string()}&action=rp"), rt.new_string('login')])).str() + '&wp_lang=' + (var_locale).str() + '\r\n\r\n'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		var_requester_ip = rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))
		if rt.is_true(var_requester_ip) {
			var_message = rt.concat(var_message, rt.new_string((rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This password reset request originated from the IP address %s.')]), var_requester_ip.clone()])).str() + '\r\n'))
		}
	}
	var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[%s] Password Reset')]), var_site_name.clone()])
	var_title = rt.call_function('apply_filters', [rt.new_string('retrieve_password_title'), var_title.clone(), rt.new_string((var_user_login).str()), var_user_data.clone()])
	var_message = rt.call_function('apply_filters', [rt.new_string('retrieve_password_message'), var_message.clone(), var_key.clone(), rt.new_string((var_user_login).str()), var_user_data.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_message)))) {
		return true
	}
	var_defaults = { 'to': var_user_email, 'subject': var_title, 'message': var_message, 'headers': rt.new_string('') }
	var_notification_email = rt.call_function('apply_filters', [rt.new_string('retrieve_password_notification_email'), rt.create_array_from_native_map(var_defaults), var_key.clone(), rt.new_string((var_user_login).str()), var_user_data.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(var_notification_email.clone().is_array())) {
	var_notification_email = rt.call_function('array_merge', [rt.create_array_from_native_map(var_defaults), var_notification_email.clone()])
	} else {
	var_notification_email = var_defaults.clone()
	}
	mut list_tmp_2 := rt.call_function('array_values', [var_notification_email.clone()])
	var_to = (list_tmp_2).array_get(0)
	var_subject = (list_tmp_2).array_get(1)
	var_message = (list_tmp_2).array_get(2)
	var_headers = (list_tmp_2).array_get(3)
	var_subject = rt.call_function('wp_specialchars_decode', [var_subject.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_mail', [var_to.clone(), var_subject.clone(), var_message.clone(), var_headers.clone()]))))) {
		rt.call_method(var_errors, 'add', [rt.new_string('retrieve_password_email_failure'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email could not be sent. Your site may not be correctly configured to send emails. <a href="%s">Get support for resetting your password</a>.')]), rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/article/reset-your-password/')])])])])
		return (var_errors).to_bool()
	}
	return true
}

fn reset_password(var_user rt.PhpVal, var_new_pass rt.PhpVal) {
	rt.call_function('do_action', [rt.new_string('password_reset'), var_user.clone(), var_new_pass.clone()])
	rt.call_function('wp_set_password', [var_new_pass.clone(), rt.get_property(var_user, 'ID')])
	update_user_meta(rt.get_property(var_user, 'ID'), rt.new_string('default_password_nag'), rt.new_bool(false), '')
	rt.call_function('do_action', [rt.new_string('after_password_reset'), var_user.clone(), var_new_pass.clone()])
}

fn register_new_user(var_user_login rt.PhpVal, var_user_email_arg rt.PhpVal) rt.PhpVal {
	mut var_user_email := var_user_email_arg
	mut var_errors := rt.new_null()
	mut var_sanitized_user_login := rt.new_null()
	mut var_illegal_user_logins := rt.new_null()
	mut var_user_pass := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_wp_lang := rt.new_null()
	var_errors = create_wp_error()
	var_sanitized_user_login = rt.call_function('sanitize_user', [var_user_login.clone()])
	var_user_email = rt.call_function('apply_filters', [rt.new_string('user_registration_email'), var_user_email.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), var_sanitized_user_login)) {
		rt.call_method(var_errors, 'add', [rt.new_string('empty_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter a username.')])])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(validate_username(var_user_login.clone()))))) {
		rt.call_method(var_errors, 'add', [rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is invalid because it uses illegal characters. Please enter a valid username.')])])
	var_sanitized_user_login = rt.new_string('')
	} else if rt.is_true(username_exists(var_sanitized_user_login.clone())) {
		rt.call_method(var_errors, 'add', [rt.new_string('username_exists'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is already registered. Please choose another one.')])])
	} else {
		var_illegal_user_logins = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
		if rt.is_true(rt.call_function('in_array', [rt.new_string(var_sanitized_user_login.clone().to_string().to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_user_logins.clone()]), rt.new_bool(true)])) {
			rt.call_method(var_errors, 'add', [rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Sorry, that username is not allowed.')])])
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_user_email)) {
		rt.call_method(var_errors, 'add', [rt.new_string('empty_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please type your email address.')])])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_user_email.clone()]))))) {
		rt.call_method(var_errors, 'add', [rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email address is not correct.')])])
	var_user_email = rt.new_string('')
	} else if rt.is_true(email_exists(var_user_email.clone())) {
		rt.call_method(var_errors, 'add', [rt.new_string('email_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> This email address is already registered. <a href="%s">Log in</a> with this address or choose another one.')]), rt.call_function('wp_login_url', []rt.PhpVal{})])])
	}
	rt.call_function('do_action', [rt.new_string('register_post'), var_sanitized_user_login.clone(), var_user_email.clone(), var_errors.clone()])
	var_errors = rt.call_function('apply_filters', [rt.new_string('registration_errors'), var_errors.clone(), var_sanitized_user_login.clone(), var_user_email.clone()])
	if rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{})) {
		return var_errors.clone()
	}
	var_user_pass = rt.call_function('wp_generate_password', [rt.new_int(12), rt.new_bool(false)])
	var_user_id = wp_create_user(var_sanitized_user_login.clone(), var_user_pass.clone(), var_user_email.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) || rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
		rt.call_method(var_errors, 'add', [rt.new_string('registerfail'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Error:</strong> Could not register you&hellip; please contact the <a href="mailto:%s">site admin</a>!')]), rt.call_function('get_option', [rt.new_string('admin_email')])])])
		return var_errors.clone()
	}
	update_user_meta(var_user_id.clone(), rt.new_string('default_password_nag'), rt.new_bool(true), '')
	if !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp_lang')))) {
		var_wp_lang = rt.call_function('sanitize_text_field', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp_lang'))])
		if rt.is_true(rt.call_function('in_array', [var_wp_lang.clone(), rt.call_function('get_available_languages', []rt.PhpVal{}), rt.new_bool(true)])) {
			update_user_meta(var_user_id.clone(), rt.new_string('locale'), var_wp_lang.clone(), '')
		}
	}
	rt.call_function('do_action', [rt.new_string('register_new_user'), var_user_id.clone()])
	return var_user_id.clone()
}

fn wp_send_new_user_notifications(var_user_id rt.PhpVal, notify string) {
	mut var_notify := notify
	rt.call_function('wp_new_user_notification', [var_user_id.clone(), rt.new_null(), rt.new_string(notify)])
}

fn wp_get_session_token() rt.PhpVal {
	mut var_cookie := rt.new_null()
	var_cookie = rt.call_function('wp_parse_auth_cookie', [rt.new_string(''), rt.new_string('logged_in')])
	return if !(!rt.is_true(var_cookie.array_get(rt.new_string('token')))) { var_cookie.array_get(rt.new_string('token')) } else { rt.new_string('') }
}

fn wp_get_all_sessions() rt.PhpVal {
	mut var_manager := rt.new_null()
	mut iife_temp_4 := Class_WP_Session_Tokens{}
	mut iife_result_4 := iife_temp_4.get_instance(rt.new_int(get_current_user_id()))
	var_manager = iife_result_4
	return rt.call_method(var_manager, 'get_all', []rt.PhpVal{})
}

fn wp_destroy_current_session() {
	mut var_token := rt.new_null()
	mut var_manager := rt.new_null()
	var_token = wp_get_session_token()
	if rt.is_true(var_token) {
		mut iife_temp_5 := Class_WP_Session_Tokens{}
		mut iife_result_5 := iife_temp_5.get_instance(rt.new_int(get_current_user_id()))
		var_manager = iife_result_5
		rt.call_method(var_manager, 'destroy', [var_token.clone()])
	}
}

fn wp_destroy_other_sessions() {
	mut var_token := rt.new_null()
	mut var_manager := rt.new_null()
	var_token = wp_get_session_token()
	if rt.is_true(var_token) {
		mut iife_temp_6 := Class_WP_Session_Tokens{}
		mut iife_result_6 := iife_temp_6.get_instance(rt.new_int(get_current_user_id()))
		var_manager = iife_result_6
		rt.call_method(var_manager, 'destroy_others', [var_token.clone()])
	}
}

fn wp_destroy_all_sessions() {
	mut var_manager := rt.new_null()
	mut iife_temp_7 := Class_WP_Session_Tokens{}
	mut iife_result_7 := iife_temp_7.get_instance(rt.new_int(get_current_user_id()))
	var_manager = iife_result_7
	rt.call_method(var_manager, 'destroy_all', []rt.PhpVal{})
}

fn wp_get_users_with_no_role(var_site_id_arg rt.PhpVal) rt.PhpVal {
	mut var_site_id := var_site_id_arg
	mut var_wpdb := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_role_names := rt.new_null()
	mut var_regex := rt.new_null()
	mut var_users := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
	var_site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	var_prefix = rt.call_method(var_wpdb, 'get_blog_prefix', [var_site_id.clone()])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), var_site_id)))) {
		rt.call_function('switch_to_blog', [var_site_id.clone()])
		var_role_names = rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'get_names', []rt.PhpVal{})
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	} else {
	var_role_names = rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'get_names', []rt.PhpVal{})
	}
	var_regex = rt.call_function('implode', [rt.new_string('|'), rt.func_array_keys(var_role_names.clone())])
	var_regex = rt.call_function('preg_replace', [rt.new_string('/[^a-zA-Z_\\|-]/'), rt.new_string(''), var_regex.clone()])
	var_users = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT user_id\n\t\t\tFROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\t\tWHERE meta_key = \'')), var_prefix), rt.new_string('capabilities\'\n\t\t\tAND meta_value NOT REGEXP %s')), var_regex.clone()])])
	return var_users.clone()
}

fn _wp_get_current_user() rt.PhpVal {
	mut var_cur_id := rt.new_null()
	mut var_current_user := rt.new_null()
	mut var_user_id := rt.new_null()
	if !(!rt.is_true(var_current_user)) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_current_user, 'WP_User'))) {
			return var_current_user.clone()
		}
		if var_current_user.clone().is_object() && !(rt.get_property(var_current_user, 'ID')).is_null() {
			var_cur_id = rt.get_property(var_current_user, 'ID')
			var_current_user = rt.new_null()
			rt.call_function('wp_set_current_user', [var_cur_id.clone()])
			return var_current_user.clone()
		}
		var_current_user = rt.new_null()
		rt.call_function('wp_set_current_user', [rt.new_int(0)])
		return var_current_user.clone()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('XMLRPC_REQUEST')])) && rt.is_true(rt.get_constant('XMLRPC_REQUEST')) {
		rt.call_function('wp_set_current_user', [rt.new_int(0)])
		return var_current_user.clone()
	}
	var_user_id = rt.call_function('apply_filters', [rt.new_string('determine_current_user'), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		rt.call_function('wp_set_current_user', [rt.new_int(0)])
		return var_current_user.clone()
	}
	rt.call_function('wp_set_current_user', [var_user_id.clone()])
	return var_current_user.clone()
}

fn send_confirmation_on_profile_email() bool {
	mut var_current_user := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_hash := ''
	mut var_new_user_email := map[string]rt.PhpVal{}
	mut var_sitename := rt.new_null()
	mut var_email_text := rt.new_null()
	mut var_content := rt.new_null()
	var_current_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if !(var_errors.clone().is_object()) {
	var_errors = create_wp_error()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_current_user, 'ID'), rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('user_id'))).to_i64()))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_current_user, 'user_email'), rt.get_superglobal('_POST').array_get(rt.new_string('email')))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.get_superglobal('_POST').array_get(rt.new_string('email'))]))))) {
			rt.call_method(var_errors, 'add', [rt.new_string('user_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email address is not correct.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }])])
			return false
		}
		if rt.is_true(email_exists(rt.get_superglobal('_POST').array_get(rt.new_string('email')))) {
			rt.call_method(var_errors, 'add', [rt.new_string('user_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email address is already used.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }])])
			delete_user_meta(rt.get_property(var_current_user, 'ID'), rt.new_string('_new_email'), '')
			return false
		}
		var_hash = md5.hexhash((rt.get_superglobal('_POST').array_get(rt.new_string('email'))).str() + (rt.call_function('time', []rt.PhpVal{})).str() + (rt.call_function('wp_rand', []rt.PhpVal{})).str())
		var_new_user_email = { 'hash': rt.new_string((var_hash).str()), 'newemail': rt.get_superglobal('_POST').array_get(rt.new_string('email')) }
		update_user_meta(rt.get_property(var_current_user, 'ID'), rt.new_string('_new_email'), rt.create_array_from_native_map(var_new_user_email), '')
		var_sitename = rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')])
		var_email_text = rt.call_function('__', [rt.new_string('Howdy ###USERNAME###,\n\nYou recently requested to have the email address on your account changed.\n\nIf this is correct, please click on the following link to change it:\n###ADMIN_URL###\n\nYou can safely ignore and delete this email if you do not want to\ntake this action.\n\nThis email has been sent to ###EMAIL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
		var_content = rt.call_function('apply_filters', [rt.new_string('new_user_email_content'), var_email_text.clone(), rt.create_array_from_native_map(var_new_user_email)])
		var_content = rt.call_function('str_replace', [rt.new_string('###USERNAME###'), rt.get_property(var_current_user, 'user_login'), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###ADMIN_URL###'), rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('profile.php?newuseremail=' + var_hash)])]), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###EMAIL###'), rt.get_superglobal('_POST').array_get(rt.new_string('email')), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_sitename.clone(), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('home_url', []rt.PhpVal{}), var_content.clone()])
		rt.call_function('wp_mail', [rt.get_superglobal('_POST').array_get(rt.new_string('email')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[%s] Email Change Request')]), var_sitename.clone()]), var_content.clone()])
		rt.get_superglobal('_POST').array_set('email', rt.get_property(var_current_user, 'user_email'))
	}
	return false
}

fn new_user_email_admin_notice() {
	mut var_pagenow := rt.new_null()
	mut var_email := rt.new_null()
	mut var_message := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('profile.php'), var_pagenow)) && rt.get_superglobal('_GET').array_isset(rt.new_string('updated')) {
		var_email = get_user_meta(rt.new_int(get_current_user_id()), '_new_email', true)
		if rt.is_true(var_email) {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your email address has not been updated yet. Please check your inbox at %s for a confirmation email.')]), rt.new_string('<code>' + (rt.call_function('esc_html', [var_email.array_get(rt.new_string('newemail'))])).str() + '</code>')])
			rt.call_function('wp_admin_notice', [var_message.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' }])])
		}
	}
}

fn _wp_privacy_action_request_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'export_personal_data' }, rt.ArrayItem{ key: none, val: 'remove_personal_data' }])
}

fn wp_register_user_personal_data_exporter(var_exporters rt.PhpVal) rt.PhpVal {
	var_exporters['wordpress-user'] = rt.create_array([rt.ArrayItem{ key: 'exporter_friendly_name', val: rt.call_function('__', [rt.new_string('WordPress User')]) }, rt.ArrayItem{ key: 'callback', val: 'wp_user_personal_data_exporter' }])
	return var_exporters.clone()
}

fn wp_user_personal_data_exporter(var_email_address_arg rt.PhpVal) rt.PhpVal {
	mut var_email_address := var_email_address_arg
	mut var_data_to_export := []rt.PhpVal{}
	mut var_user := rt.new_null()
	mut var_user_meta := rt.new_null()
	mut var_user_props_to_export := map[string]rt.PhpVal{}
	mut var_user_data_to_export := rt.new_null()
	mut var_name := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_reserved_names := rt.new_null()
	mut var__extra_data := rt.new_null()
	mut var_extra_data := rt.new_null()
	mut var_location := rt.new_null()
	mut var_location_props_to_export := map[string]rt.PhpVal{}
	mut var_location_data_to_export := []rt.PhpVal{}
	mut var_session_tokens := rt.new_null()
	mut var_session_tokens_props_to_export := map[string]rt.PhpVal{}
	mut var_session_token := rt.new_null()
	mut var_token_key := rt.new_null()
	mut var_session_tokens_data_to_export := []rt.PhpVal{}
	var_email_address = var_email_address.trim_space()
	var_data_to_export = rt.new_array()
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), rt.new_string((var_email_address).str()).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() }, rt.ArrayItem{ key: 'done', val: true }])
	}
	var_user_meta = get_user_meta(rt.get_property(var_user, 'ID'), '', false)
	var_user_props_to_export = { 'ID': rt.call_function('__', [rt.new_string('User ID')]), 'user_login': rt.call_function('__', [rt.new_string('User Login Name')]), 'user_nicename': rt.call_function('__', [rt.new_string('User Nice Name')]), 'user_email': rt.call_function('__', [rt.new_string('User Email')]), 'user_url': rt.call_function('__', [rt.new_string('User URL')]), 'user_registered': rt.call_function('__', [rt.new_string('User Registration Date')]), 'display_name': rt.call_function('__', [rt.new_string('User Display Name')]), 'nickname': rt.call_function('__', [rt.new_string('User Nickname')]), 'first_name': rt.call_function('__', [rt.new_string('User First Name')]), 'last_name': rt.call_function('__', [rt.new_string('User Last Name')]), 'description': rt.call_function('__', [rt.new_string('User Description')]) }
	var_user_data_to_export = rt.new_array()
	for var_key_shadow, var_name_shadow in var_user_props_to_export {
		var_value = rt.new_string('')
		mut switch_val_1 := rt.new_string((var_key_shadow).str())
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('ID'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user_login'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user_nicename'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user_email'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user_url'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('user_registered'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('display_name'))) {
		var_value = rt.get_property(rt.get_property(var_user, 'data'), '{"nodeType":"Expr_Variable","line":4063,"name":"key"}')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('nickname'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('first_name'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('last_name'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
		var_value = var_user_meta.array_get(rt.new_string((var_key_shadow).str())).array_get(rt.new_int(0))
		}
		if !(!rt.is_true(var_value)) {
			var_user_data_to_export.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_shadow }, rt.ArrayItem{ key: 'value', val: var_value }]))
		}
	}
	var_reserved_names = rt.call_function('array_values', [rt.create_array_from_native_map(var_user_props_to_export)])
	var__extra_data = rt.call_function('apply_filters', [rt.new_string('wp_privacy_additional_user_profile_data'), rt.new_array(), var_user.clone(), var_reserved_names.clone()])
	if var__extra_data.clone().is_array() && !(!rt.is_true(var__extra_data)) {
		closure_9_fn := fn [var_reserved_names] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_item['name'], var_reserved_names.clone(), rt.new_bool(true)]))))
			}
		var_extra_data = rt.call_function('array_filter', [var__extra_data.clone(), rt.new_closure(closure_9_fn)])
		if rt.is_true(rt.new_bool(var_extra_data.clone().array_count() != var__extra_data.clone().array_count())) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Filter %s returned items with reserved names.')]), rt.new_string('<code>wp_privacy_additional_user_profile_data</code>')]), rt.new_string('5.4.0')])
		}
		if !(!rt.is_true(var_extra_data)) {
		var_user_data_to_export = rt.call_function('array_merge', [var_user_data_to_export.clone(), var_extra_data.clone()])
		}
	}
	var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'user' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('User')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s profile data.')]) }, rt.ArrayItem{ key: 'item_id', val: rt.concat(rt.new_string('user-'), rt.get_property(var_user, 'ID')) }, rt.ArrayItem{ key: 'data', val: var_user_data_to_export }])
	if var_user_meta.array_isset(rt.new_string('community-events-location')) {
		var_location = rt.call_function('maybe_unserialize', [var_user_meta.array_get(rt.new_string('community-events-location')).array_get(rt.new_int(0))])
		var_location_props_to_export = { 'description': rt.call_function('__', [rt.new_string('City')]), 'country': rt.call_function('__', [rt.new_string('Country')]), 'latitude': rt.call_function('__', [rt.new_string('Latitude')]), 'longitude': rt.call_function('__', [rt.new_string('Longitude')]), 'ip': rt.call_function('__', [rt.new_string('IP')]) }
		var_location_data_to_export = rt.new_array()
		for var_key_shadow, var_name_shadow in var_location_props_to_export {
			if !(!rt.is_true(var_location.array_get(rt.new_string((var_key_shadow).str())))) {
				var_location_data_to_export << rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_shadow }, rt.ArrayItem{ key: 'value', val: var_location.array_get(rt.new_string((var_key_shadow).str())) }])
			}
		}
		var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'community-events-location' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Community Events Location')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s location data used for the Community Events in the WordPress Events and News dashboard widget.')]) }, rt.ArrayItem{ key: 'item_id', val: rt.concat(rt.new_string('community-events-location-'), rt.get_property(var_user, 'ID')) }, rt.ArrayItem{ key: 'data', val: var_location_data_to_export }])
	}
	if var_user_meta.array_isset(rt.new_string('session_tokens')) {
		var_session_tokens = rt.call_function('maybe_unserialize', [var_user_meta.array_get(rt.new_string('session_tokens')).array_get(rt.new_int(0))])
		var_session_tokens_props_to_export = { 'expiration': rt.call_function('__', [rt.new_string('Expiration')]), 'ip': rt.call_function('__', [rt.new_string('IP')]), 'ua': rt.call_function('__', [rt.new_string('User Agent')]), 'login': rt.call_function('__', [rt.new_string('Last Login')]) }
		mut iter_17 := var_session_tokens.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_session_token_shadow := item_17.val
			mut var_token_key_shadow := item_17.key
			var_session_tokens_data_to_export = rt.new_array()
			for var_key_shadow, var_name_shadow in var_session_tokens_props_to_export {
				if !(!rt.is_true(var_session_token_shadow.array_get(rt.new_string((var_key_shadow).str())))) {
					var_value = var_session_token_shadow.array_get(rt.new_string((var_key_shadow).str()))
					if rt.is_true(rt.call_function('in_array', [rt.new_string((var_key_shadow).str()).clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'expiration' }, rt.ArrayItem{ key: none, val: 'login' }]), rt.new_bool(true)])) {
					var_value = rt.call_function('date_i18n', [rt.new_string('F d, Y H:i A'), var_value.clone()])
					}
					var_session_tokens_data_to_export << rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_shadow }, rt.ArrayItem{ key: 'value', val: var_value }])
				}
			}
			var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'session-tokens' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Session Tokens')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s Session Tokens data.')]) }, rt.ArrayItem{ key: 'item_id', val: rt.concat(rt.concat(rt.concat(rt.new_string('session-tokens-'), rt.get_property(var_user, 'ID')), rt.new_string('-')), var_token_key_shadow) }, rt.ArrayItem{ key: 'data', val: var_session_tokens_data_to_export }])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: true }])
}

fn _wp_privacy_account_request_confirmed(var_request_id rt.PhpVal) {
	mut var_request := rt.new_null()
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_request, 'status'), rt.create_array([rt.ArrayItem{ key: none, val: 'request-pending' }, rt.ArrayItem{ key: none, val: 'request-failed' }]), rt.new_bool(true)]))))) {
		return
	}
	rt.call_function('update_post_meta', [var_request_id.clone(), rt.new_string('_wp_user_request_confirmed_timestamp'), rt.call_function('time', []rt.PhpVal{})])
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id }, rt.ArrayItem{ key: 'post_status', val: 'request-confirmed' }])])
}

fn _wp_privacy_send_request_confirmation_notification(var_request_id rt.PhpVal) {
	mut var_request := rt.new_null()
	mut var_already_notified := rt.new_null()
	mut var_manage_url := rt.new_null()
	mut var_action_description := rt.new_null()
	mut var_admin_email := rt.new_null()
	mut var_email_data := map[string]rt.PhpVal{}
	mut var_subject := rt.new_null()
	mut var_content := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_email_sent := rt.new_null()
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_request, 'WP_User_Request')))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('request-confirmed'), rt.get_property(var_request, 'status'))))) {
		return
	}
	var_already_notified = rt.new_bool((rt.call_function('get_post_meta', [var_request_id.clone(), rt.new_string('_wp_admin_notified'), rt.new_bool(true)])).to_bool())
	if rt.is_true(var_already_notified) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))) {
	var_manage_url = rt.call_function('admin_url', [rt.new_string('export-personal-data.php')])
	} else if rt.is_true(rt.identical(rt.new_string('remove_personal_data'), rt.get_property(var_request, 'action_name'))) {
	var_manage_url = rt.call_function('admin_url', [rt.new_string('erase-personal-data.php')])
	}
	var_action_description = wp_user_request_action_description(rt.get_property(var_request, 'action_name'))
	var_admin_email = rt.call_function('apply_filters', [rt.new_string('user_request_confirmed_email_to'), rt.call_function('get_site_option', [rt.new_string('admin_email')]), var_request.clone()])
	var_email_data = { 'request': var_request, 'user_email': rt.get_property(var_request, 'email'), 'description': var_action_description, 'manage_url': var_manage_url, 'sitename': rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')]), 'siteurl': rt.call_function('home_url', []rt.PhpVal{}), 'admin_email': var_admin_email }
	var_subject = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[%1$s] Action Confirmed: %2$s')]), var_email_data['sitename'], var_action_description.clone()])
	var_subject = rt.call_function('apply_filters', [rt.new_string('user_request_confirmed_email_subject'), var_subject.clone(), var_email_data['sitename'], rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('__', [rt.new_string('Howdy,\n\nA user data privacy request has been confirmed on ###SITENAME###:\n\nUser: ###USER_EMAIL###\nRequest: ###DESCRIPTION###\n\nYou can view and manage these data privacy requests here:\n\n###MANAGE_URL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
	var_content = rt.call_function('apply_filters_deprecated', [rt.new_string('user_confirmed_action_email_content'), rt.create_array([rt.ArrayItem{ key: none, val: var_content }, rt.ArrayItem{ key: none, val: var_email_data }]), rt.new_string('5.8.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s or %2$s')]), rt.new_string('user_request_confirmed_email_content'), rt.new_string('user_erasure_fulfillment_email_content')])])
	var_content = rt.call_function('apply_filters', [rt.new_string('user_request_confirmed_email_content'), var_content.clone(), rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_email_data['sitename'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###USER_EMAIL###'), var_email_data['user_email'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###DESCRIPTION###'), var_email_data['description'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###MANAGE_URL###'), rt.call_function('sanitize_url', [var_email_data['manage_url']]), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('sanitize_url', [var_email_data['siteurl']]), var_content.clone()])
	var_headers = rt.new_string('')
	var_headers = rt.call_function('apply_filters', [rt.new_string('user_request_confirmed_email_headers'), var_headers.clone(), var_subject.clone(), var_content.clone(), var_request_id.clone(), rt.create_array_from_native_map(var_email_data)])
	var_email_sent = rt.call_function('wp_mail', [var_email_data['admin_email'], var_subject.clone(), var_content.clone(), var_headers.clone()])
	if rt.is_true(var_email_sent) {
		rt.call_function('update_post_meta', [var_request_id.clone(), rt.new_string('_wp_admin_notified'), rt.new_bool(true)])
	}
}

fn _wp_privacy_send_erasure_fulfillment_notification(var_request_id rt.PhpVal) {
	mut var_request := rt.new_null()
	mut var_already_notified := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_user_email := rt.new_null()
	mut var_email_data := map[string]rt.PhpVal{}
	mut var_subject := rt.new_null()
	mut var_content := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_email_sent := rt.new_null()
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_request, 'WP_User_Request')))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('request-completed'), rt.get_property(var_request, 'status'))))) {
		return
	}
	var_already_notified = rt.new_bool((rt.call_function('get_post_meta', [var_request_id.clone(), rt.new_string('_wp_user_notified'), rt.new_bool(true)])).to_bool())
	if rt.is_true(var_already_notified) {
		return
	}
	if !(!rt.is_true(rt.get_property(var_request, 'user_id'))) {
	var_switched_locale = rt.call_function('switch_to_user_locale', [rt.get_property(var_request, 'user_id')])
	} else {
	var_switched_locale = rt.call_function('switch_to_locale', [rt.call_function('get_locale', []rt.PhpVal{})])
	}
	var_user_email = rt.call_function('apply_filters', [rt.new_string('user_erasure_fulfillment_email_to'), rt.get_property(var_request, 'email'), var_request.clone()])
	var_email_data = { 'request': var_request, 'message_recipient': var_user_email, 'privacy_policy_url': rt.call_function('get_privacy_policy_url', []rt.PhpVal{}), 'sitename': rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')]), 'siteurl': rt.call_function('home_url', []rt.PhpVal{}) }
	var_subject = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[%s] Erasure Request Fulfilled')]), var_email_data['sitename']])
	var_subject = rt.call_function('apply_filters_deprecated', [rt.new_string('user_erasure_complete_email_subject'), rt.create_array([rt.ArrayItem{ key: none, val: var_subject }, rt.ArrayItem{ key: none, val: var_email_data['sitename'] }, rt.ArrayItem{ key: none, val: var_email_data }]), rt.new_string('5.8.0'), rt.new_string('user_erasure_fulfillment_email_subject')])
	var_subject = rt.call_function('apply_filters', [rt.new_string('user_erasure_fulfillment_email_subject'), var_subject.clone(), var_email_data['sitename'], rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('__', [rt.new_string('Howdy,\n\nYour request to erase your personal data on ###SITENAME### has been completed.\n\nIf you have any follow-up questions or concerns, please contact the site administrator.\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
	if !(!rt.is_true(var_email_data['privacy_policy_url'])) {
	var_content = rt.call_function('__', [rt.new_string('Howdy,\n\nYour request to erase your personal data on ###SITENAME### has been completed.\n\nIf you have any follow-up questions or concerns, please contact the site administrator.\n\nFor more information, you can also read our privacy policy: ###PRIVACY_POLICY_URL###\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
	}
	var_content = rt.call_function('apply_filters_deprecated', [rt.new_string('user_confirmed_action_email_content'), rt.create_array([rt.ArrayItem{ key: none, val: var_content }, rt.ArrayItem{ key: none, val: var_email_data }]), rt.new_string('5.8.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s or %2$s')]), rt.new_string('user_erasure_fulfillment_email_content'), rt.new_string('user_request_confirmed_email_content')])])
	var_content = rt.call_function('apply_filters', [rt.new_string('user_erasure_fulfillment_email_content'), var_content.clone(), rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_email_data['sitename'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###PRIVACY_POLICY_URL###'), var_email_data['privacy_policy_url'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('sanitize_url', [var_email_data['siteurl']]), var_content.clone()])
	var_headers = rt.new_string('')
	var_headers = rt.call_function('apply_filters_deprecated', [rt.new_string('user_erasure_complete_email_headers'), rt.create_array([rt.ArrayItem{ key: none, val: var_headers }, rt.ArrayItem{ key: none, val: var_subject }, rt.ArrayItem{ key: none, val: var_content }, rt.ArrayItem{ key: none, val: var_request_id }, rt.ArrayItem{ key: none, val: var_email_data }]), rt.new_string('5.8.0'), rt.new_string('user_erasure_fulfillment_email_headers')])
	var_headers = rt.call_function('apply_filters', [rt.new_string('user_erasure_fulfillment_email_headers'), var_headers.clone(), var_subject.clone(), var_content.clone(), var_request_id.clone(), rt.create_array_from_native_map(var_email_data)])
	var_email_sent = rt.call_function('wp_mail', [var_user_email.clone(), var_subject.clone(), var_content.clone(), var_headers.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	if rt.is_true(var_email_sent) {
		rt.call_function('update_post_meta', [var_request_id.clone(), rt.new_string('_wp_user_notified'), rt.new_bool(true)])
	}
}

fn _wp_privacy_account_request_confirmed_message(var_request_id rt.PhpVal) rt.PhpVal {
	mut var_request := rt.new_null()
	mut var_message := rt.new_null()
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	var_message = rt.new_string('<p class="success">' + (rt.call_function('__', [rt.new_string('Action has been confirmed.')])).str() + '</p>')
	var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The site administrator has been notified and will fulfill your request as soon as possible.')])).str() + '</p>'))
	if rt.is_true(var_request) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_request, 'action_name'), _wp_privacy_action_request_types(), rt.new_bool(true)])) {
		if rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))) {
			var_message = rt.new_string('<p class="success">' + (rt.call_function('__', [rt.new_string('Thanks for confirming your export request.')])).str() + '</p>')
			var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The site administrator has been notified. You will receive a link to download your export via email when they fulfill your request.')])).str() + '</p>'))
		} else if rt.is_true(rt.identical(rt.new_string('remove_personal_data'), rt.get_property(var_request, 'action_name'))) {
			var_message = rt.new_string('<p class="success">' + (rt.call_function('__', [rt.new_string('Thanks for confirming your erasure request.')])).str() + '</p>')
			var_message = rt.concat(var_message, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The site administrator has been notified. You will receive an email confirmation when they erase your data.')])).str() + '</p>'))
		}
	}
	var_message = rt.call_function('apply_filters', [rt.new_string('user_request_action_confirmed_message'), var_message.clone(), var_request_id.clone()])
	return var_message.clone()
}

fn wp_create_user_request(email_address string, action_name string, var_request_data rt.PhpVal, status string) rt.PhpVal {
	mut var_email_address := email_address
	mut var_action_name := action_name
	mut var_status := status
	mut var_user := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_requests_query := rt.new_null()
	mut var_request_id := rt.new_null()
	var_email_address = (rt.call_function('sanitize_email', [rt.new_string((var_email_address).str())])).str()
	var_action_name = (rt.call_function('sanitize_key', [rt.new_string((var_action_name).str())])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.new_string((var_email_address).str())]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('Invalid email address.')])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((var_action_name).str()), _wp_privacy_action_request_types(), rt.new_bool(true)]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_action'), rt.call_function('__', [rt.new_string('Invalid action name.')])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(status), rt.create_array([rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'confirmed' }]), rt.new_bool(true)]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_status'), rt.call_function('__', [rt.new_string('Invalid request status.')])))
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('email'), rt.new_string((var_email_address).str())])
	var_user_id = if rt.is_true(var_user) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_user.clone()]))))) { rt.get_property(var_user, 'ID') } else { rt.new_int(0) }
	var_requests_query = create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'user_request' }, rt.ArrayItem{ key: 'post_name__in', val: rt.create_array([rt.ArrayItem{ key: none, val: var_action_name }]) }, rt.ArrayItem{ key: 'title', val: var_email_address }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'request-pending' }, rt.ArrayItem{ key: none, val: 'request-confirmed' }]) }, rt.ArrayItem{ key: 'fields', val: 'ids' }]))
	if rt.is_true(rt.get_property(var_requests_query, 'found_posts')) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('duplicate_request'), rt.call_function('__', [rt.new_string('An incomplete personal data request for this email address already exists.')])))
	}
	var_request_id = rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_user_id }, rt.ArrayItem{ key: 'post_name', val: var_action_name }, rt.ArrayItem{ key: 'post_title', val: var_email_address }, rt.ArrayItem{ key: 'post_content', val: rt.call_function('wp_json_encode', [var_request_data.clone()]) }, rt.ArrayItem{ key: 'post_status', val: 'request-' + status }, rt.ArrayItem{ key: 'post_type', val: 'user_request' }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }]), rt.new_bool(true)])
	return var_request_id.clone()
}

fn wp_user_request_action_description(var_action_name rt.PhpVal) rt.PhpVal {
	mut var_description := rt.new_null()
	mut switch_val_2 := var_action_name
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('export_personal_data'))) {
	var_description = rt.call_function('__', [rt.new_string('Export Personal Data')])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('remove_personal_data'))) {
	var_description = rt.call_function('__', [rt.new_string('Erase Personal Data')])
	} else {
	var_description = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Confirm the "%s" action')]), var_action_name.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('user_request_action_description'), var_description.clone(), var_action_name.clone()])
}

fn wp_send_user_request(var_request_id_arg rt.PhpVal) bool {
	mut var_request_id := var_request_id_arg
	mut var_request := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_email_data := map[string]rt.PhpVal{}
	mut var_subject := rt.new_null()
	mut var_content := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_email_sent := rt.new_null()
	var_request_id = rt.call_function('absint', [var_request_id.clone()])
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) {
		return (create_wp_error(rt.new_string('invalid_request'), rt.call_function('__', [rt.new_string('Invalid personal data request.')]))).to_bool()
	}
	if !(!rt.is_true(rt.get_property(var_request, 'user_id'))) {
	var_switched_locale = rt.call_function('switch_to_user_locale', [rt.get_property(var_request, 'user_id')])
	} else {
	var_switched_locale = rt.call_function('switch_to_locale', [rt.call_function('get_locale', []rt.PhpVal{})])
	}
	rt.set_property(var_request, 'confirm_key', wp_generate_user_request_key(var_request_id.clone()))
	var_email_data = { 'request': var_request, 'email': rt.get_property(var_request, 'email'), 'description': wp_user_request_action_description(rt.get_property(var_request, 'action_name')), 'confirm_url': rt.call_function('add_query_arg', [{ 'action': rt.new_string('confirmaction'), 'request_id': var_request_id, 'confirm_key': rt.get_property(var_request, 'confirm_key') }, rt.call_function('wp_login_url', []rt.PhpVal{})]), 'sitename': rt.call_function('wp_specialchars_decode', [rt.call_function('get_option', [rt.new_string('blogname')]), rt.get_constant('ENT_QUOTES')]), 'siteurl': rt.call_function('home_url', []rt.PhpVal{}) }
	var_subject = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[%1$s] Confirm Action: %2$s')]), var_email_data['sitename'], var_email_data['description']])
	var_subject = rt.call_function('apply_filters', [rt.new_string('user_request_action_email_subject'), var_subject.clone(), var_email_data['sitename'], rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('__', [rt.new_string('Howdy,\n\nA request has been made to perform the following action on your account:\n\n     ###DESCRIPTION###\n\nTo confirm this, please click on the following link:\n###CONFIRM_URL###\n\nYou can safely ignore and delete this email if you do not want to\ntake this action.\n\nRegards,\nAll at ###SITENAME###\n###SITEURL###')])
	var_content = rt.call_function('apply_filters', [rt.new_string('user_request_action_email_content'), var_content.clone(), rt.create_array_from_native_map(var_email_data)])
	var_content = rt.call_function('str_replace', [rt.new_string('###DESCRIPTION###'), var_email_data['description'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###CONFIRM_URL###'), rt.call_function('sanitize_url', [var_email_data['confirm_url']]), var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###EMAIL###'), var_email_data['email'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITENAME###'), var_email_data['sitename'], var_content.clone()])
	var_content = rt.call_function('str_replace', [rt.new_string('###SITEURL###'), rt.call_function('sanitize_url', [var_email_data['siteurl']]), var_content.clone()])
	var_headers = rt.new_string('')
	var_headers = rt.call_function('apply_filters', [rt.new_string('user_request_action_email_headers'), var_headers.clone(), var_subject.clone(), var_content.clone(), var_request_id.clone(), rt.create_array_from_native_map(var_email_data)])
	var_email_sent = rt.call_function('wp_mail', [var_email_data['email'], var_subject.clone(), var_content.clone(), var_headers.clone()])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_sent)))) {
		return (create_wp_error(rt.new_string('privacy_email_error'), rt.call_function('__', [rt.new_string('Unable to send personal data export confirmation email.')]))).to_bool()
	}
	return true
}

fn wp_generate_user_request_key(var_request_id rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_null()
	var_key = rt.call_function('wp_generate_password', [rt.new_int(20), rt.new_bool(false)])
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_request_id }, rt.ArrayItem{ key: 'post_status', val: 'request-pending' }, rt.ArrayItem{ key: 'post_password', val: rt.call_function('wp_fast_hash', [var_key.clone()]) }])])
	return var_key.clone()
}

fn wp_validate_user_request_key(var_request_id_arg rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_request_id := var_request_id_arg
	mut var_request := rt.new_null()
	mut var_saved_key := rt.new_null()
	mut var_key_request_time := rt.new_null()
	mut var_expiration_duration := rt.new_null()
	mut var_expiration_time := rt.new_null()
	var_request_id = rt.call_function('absint', [var_request_id.clone()])
	var_request = rt.new_bool(wp_get_user_request(var_request_id.clone()))
	var_saved_key = rt.get_property(var_request, 'confirm_key')
	var_key_request_time = rt.get_property(var_request, 'modified_timestamp')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_saved_key)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_key_request_time)))) {
		return (create_wp_error(rt.new_string('invalid_request'), rt.call_function('__', [rt.new_string('Invalid personal data request.')]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_request, 'status'), rt.create_array([rt.ArrayItem{ key: none, val: 'request-pending' }, rt.ArrayItem{ key: none, val: 'request-failed' }]), rt.new_bool(true)]))))) {
		return (create_wp_error(rt.new_string('expired_request'), rt.call_function('__', [rt.new_string('This personal data request has expired.')]))).to_bool()
	}
	if !rt.is_true(var_key) {
		return (create_wp_error(rt.new_string('missing_key'), rt.call_function('__', [rt.new_string('The confirmation key is missing from this personal data request.')]))).to_bool()
	}
	var_expiration_duration = rt.new_int((rt.call_function('apply_filters', [rt.new_string('user_request_key_expiration'), rt.get_constant('DAY_IN_SECONDS')])).to_i64())
	var_expiration_time = rt.add(var_key_request_time, var_expiration_duration)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_fast_hash', [var_key.clone(), var_saved_key.clone()]))))) {
		return (create_wp_error(rt.new_string('invalid_key'), rt.call_function('__', [rt.new_string('The confirmation key is invalid for this personal data request.')]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_expiration_time)))) || rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), var_expiration_time)) {
		return (create_wp_error(rt.new_string('expired_key'), rt.call_function('__', [rt.new_string('The confirmation key has expired for this personal data request.')]))).to_bool()
	}
	return true
}

fn wp_get_user_request(var_request_id_arg rt.PhpVal) bool {
	mut var_request_id := var_request_id_arg
	mut var_post := rt.new_null()
	var_request_id = rt.call_function('absint', [var_request_id.clone()])
	var_post = rt.call_function('get_post', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('user_request'), rt.get_property(var_post, 'post_type'))))) {
		return false
	}
	return (create_wp_user_request(var_post.clone())).to_bool()
}

fn wp_is_application_passwords_supported() bool {
	return rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_string('local'), rt.call_function('wp_get_environment_type', []rt.PhpVal{})))
}

fn wp_is_application_passwords_available() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_is_application_passwords_available'), rt.new_bool(wp_is_application_passwords_supported())])
}

fn wp_is_application_passwords_available_for_user(var_user_arg rt.PhpVal) bool {
	mut var_user := var_user_arg
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_application_passwords_available())))) {
		return false
	}
	if !(var_user.clone().is_object()) {
	var_user = rt.call_function('get_userdata', [var_user.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_is_application_passwords_available_for_user'), rt.new_bool(true), var_user.clone()])).to_bool()
}

fn wp_register_persisted_preferences_meta() {
	mut var_wpdb := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_meta_key = rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'persisted_preferences')
	rt.call_function('register_meta', [rt.new_string('user'), var_meta_key.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'single', val: true }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'persisted_preferences' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: '_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date and time the preferences were updated.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'readonly', val: false }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: true }]) }]) }])])
}

fn wp_cache_set_users_last_changed() {
	rt.call_function('wp_cache_set_last_changed', [rt.new_string('users')])
}

fn wp_is_password_reset_allowed_for_user(var_user_arg rt.PhpVal) bool {
	mut var_user := var_user_arg
	mut var_allow := false
	if !(var_user.clone().is_object()) {
	var_user = rt.call_function('get_userdata', [var_user.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	var_allow = true
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_user_spammy', [var_user.clone()])) {
	var_allow = false
	}
	return (rt.call_function('apply_filters', [rt.new_string('allow_password_reset'), rt.new_bool(var_allow).clone(), rt.get_property(var_user, 'ID')])).to_bool()
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

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_User_Request {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_application_passwords(_args ...rt.PhpVal) &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
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

fn create_wp_session_tokens(_args ...rt.PhpVal) &Class_WP_Session_Tokens {
	mut obj := &Class_WP_Session_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_request(_args ...rt.PhpVal) &Class_WP_User_Request {
	mut obj := &Class_WP_User_Request{
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


fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_User_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
