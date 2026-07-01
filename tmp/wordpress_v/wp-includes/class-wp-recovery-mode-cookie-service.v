import rt
import crypto.sha1

struct Class_WP_Recovery_Mode_Cookie_Service {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) is_cookie_set() bool {
	return !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('RECOVERY_MODE_COOKIE'))))
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) set_cookie()  {
	mut var_value := this.generate_cookie()
	mut var_length := rt.call_function('apply_filters', [rt.new_string('recovery_mode_cookie_length'), rt.get_constant('WEEK_IN_SECONDS')])
	mut var_expire := rt.add(rt.call_function('time', []rt.PhpVal{}), var_length)
	rt.call_function('setcookie', [rt.get_constant('RECOVERY_MODE_COOKIE'), var_value.dup(), var_expire.dup(), rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN'), rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('setcookie', [rt.get_constant('RECOVERY_MODE_COOKIE'), var_value.dup(), var_expire.dup(), rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN'), rt.call_function('is_ssl', []rt.PhpVal{}), rt.new_bool(true)])
	}
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) clear_cookie()  {
	rt.call_function('setcookie', [rt.get_constant('RECOVERY_MODE_COOKIE'), rt.new_string(' '), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')), rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('RECOVERY_MODE_COOKIE'), rt.new_string(' '), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')), rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) validate_cookie(cookie string) bool {
	mut var_created_at := rt.new_null()
	mut var_random := rt.new_null()
	mut var_signature := rt.new_null()
	mut cookie_mutated := cookie
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(cookie_mutated))))) {
		if !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('RECOVERY_MODE_COOKIE'))) {
			return (create_wp_error(rt.new_string('no_cookie'), rt.call_function('__', [rt.new_string('No cookie present.')]))).to_bool()
		}
		cookie_mutated = (rt.get_superglobal('_COOKIE').array_get(rt.get_constant('RECOVERY_MODE_COOKIE'))).str()
	}
	mut var_parts := this.parse_cookie(rt.new_string(cookie_mutated))
	if rt.is_true(rt.call_function('is_wp_error', [var_parts.dup()])) {
		return (var_parts).to_bool()
	}
	// unsupported assign target: Expr_List
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_digit', [var_created_at.dup()]))))) {
		return (create_wp_error(rt.new_string('invalid_created_at'), rt.call_function('__', [rt.new_string('Invalid cookie format.')]))).to_bool()
	}
	mut var_length := rt.call_function('apply_filters', [rt.new_string('recovery_mode_cookie_length'), rt.get_constant('WEEK_IN_SECONDS')])
	if rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.add(var_created_at, var_length))) {
		return (create_wp_error(rt.new_string('expired'), rt.call_function('__', [rt.new_string('Cookie expired.')]))).to_bool()
	}
	mut var_to_sign := rt.call_function('sprintf', [rt.new_string('recovery_mode|%s|%s'), var_created_at.dup(), var_random.dup()])
	mut var_hashed := this.recovery_mode_hash(var_to_sign.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_signature.dup(), var_hashed.dup()]))))) {
		return (create_wp_error(rt.new_string('signature_mismatch'), rt.call_function('__', [rt.new_string('Invalid cookie.')]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) get_session_id_from_cookie(cookie string) string {
	mut var_random := rt.new_null()
	mut cookie_mutated := cookie
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(cookie_mutated))))) {
		if !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.get_constant('RECOVERY_MODE_COOKIE'))) {
			return (create_wp_error(rt.new_string('no_cookie'), rt.call_function('__', [rt.new_string('No cookie present.')]))).str()
		}
		cookie_mutated = (rt.get_superglobal('_COOKIE').array_get(rt.get_constant('RECOVERY_MODE_COOKIE'))).str()
	}
	mut var_parts := this.parse_cookie(rt.new_string(cookie_mutated))
	if rt.is_true(rt.call_function('is_wp_error', [var_parts.dup()])) {
		return (var_parts).str()
	}
	// unsupported assign target: Expr_List
	return sha1.hexhash(var_random.dup().to_string())
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) parse_cookie(var_cookie rt.PhpVal) rt.PhpVal {
	mut var_cookie_mutated := var_cookie
	var_cookie_mutated = rt.call_function('base64_decode', [var_cookie_mutated.dup()])
	mut var_parts := rt.call_function('explode', [rt.new_string('|'), var_cookie_mutated.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(rt.new_string('invalid_format'), rt.call_function('__', [rt.new_string('Invalid cookie format.')]))
	}
	return var_parts.dup()
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) generate_cookie() rt.PhpVal {
	mut var_to_sign := rt.call_function('sprintf', [rt.new_string('recovery_mode|%s|%s'), rt.call_function('time', []rt.PhpVal{}), rt.call_function('wp_generate_password', [rt.new_int(20), rt.new_bool(false)])])
	mut var_signed := this.recovery_mode_hash(var_to_sign.dup())
	return rt.call_function('base64_encode', [rt.call_function('sprintf', [rt.new_string('%s|%s'), var_to_sign.dup(), var_signed.dup()])])
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) recovery_mode_hash(var_data rt.PhpVal) rt.PhpVal {
	mut var_default_keys := rt.call_function('array_unique', [rt.create_array([rt.ArrayItem{ key: none, val: 'put your unique phrase here' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('put your unique phrase here')]) }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('AUTH_KEY')]))))) || rt.is_true(rt.call_function('in_array', [rt.get_constant('AUTH_KEY'), var_default_keys.dup(), rt.new_bool(true)])))) {
		mut var_auth_key := rt.call_function('get_site_option', [rt.new_string('recovery_mode_auth_key')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_auth_key)))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_generate_password')]))))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php', '4')
			}
			var_auth_key = rt.call_function('wp_generate_password', [rt.new_int(64), rt.new_bool(true), rt.new_bool(true)])
			rt.call_function('update_site_option', [rt.new_string('recovery_mode_auth_key'), var_auth_key.dup()])
		}
	} else {
		var_auth_key = rt.get_constant('AUTH_KEY')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('AUTH_SALT')]))))) || rt.is_true(rt.call_function('in_array', [rt.get_constant('AUTH_SALT'), var_default_keys.dup(), rt.new_bool(true)])))) || rt.is_true(rt.identical(rt.get_constant('AUTH_SALT'), var_auth_key)))) {
		mut var_auth_salt := rt.call_function('get_site_option', [rt.new_string('recovery_mode_auth_salt')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_auth_salt)))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_generate_password')]))))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php', '4')
			}
			var_auth_salt = rt.call_function('wp_generate_password', [rt.new_int(64), rt.new_bool(true), rt.new_bool(true)])
			rt.call_function('update_site_option', [rt.new_string('recovery_mode_auth_salt'), var_auth_salt.dup()])
		}
	} else {
		var_auth_salt = rt.get_constant('AUTH_SALT')
	}
	mut var_secret := rt.new_string(rt.concat(var_auth_key, var_auth_salt))
	return rt.call_function('hash_hmac', [rt.new_string('sha1'), var_data.dup(), var_secret.dup()])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_recovery_mode_cookie_service() &Class_WP_Recovery_Mode_Cookie_Service {
	mut obj := &Class_WP_Recovery_Mode_Cookie_Service{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_cookie_set' {
			return rt.new_bool(this.is_cookie_set())
		}
		'set_cookie' {
			this.set_cookie()
			return rt.new_null()
		}
		'clear_cookie' {
			this.clear_cookie()
			return rt.new_null()
		}
		'validate_cookie' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.validate_cookie(dispatch_arg_0))
		}
		'get_session_id_from_cookie' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_session_id_from_cookie(dispatch_arg_0))
		}
		'parse_cookie' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_cookie(dispatch_arg_0)
		}
		'generate_cookie' {
			return this.generate_cookie()
		}
		'recovery_mode_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.recovery_mode_hash(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Recovery_Mode_Cookie_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_includes_class_wp_recovery_mode_cookie_service_php() {
}
