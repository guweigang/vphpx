import rt

fn set_current_user(var_id rt.PhpVal, name string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.0.0'), rt.new_string('wp_set_current_user()')])
	return rt.call_function('wp_set_current_user', [var_id.dup(),
		rt.new_string(name)])
}

fn get_currentuserinfo() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.5.0'), rt.new_string('wp_get_current_user()')])
	return rt.call_function('_wp_get_current_user', []rt.PhpVal{})
}

fn get_userdatabylogin(var_user_login rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("get_user_by('login')")])
	return rt.call_function('get_user_by', [rt.new_string('login'),
		var_user_login.dup()])
}

fn get_user_by_email(var_email rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string("get_user_by('email')")])
	return rt.call_function('get_user_by', [rt.new_string('email'),
		var_email.dup()])
}

fn wp_setcookie(var_username rt.PhpVal, password string, already_md5 bool, home string, siteurl string, remember bool) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_set_auth_cookie()')])
	mut var_user := rt.call_function('get_user_by', [rt.new_string('login'),
		var_username.dup()])
	rt.call_function('wp_set_auth_cookie', [rt.get_property(var_user, 'ID'),
		rt.new_bool(remember)])
}

fn wp_clearcookie() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_clear_auth_cookie()')])
	rt.call_function('wp_clear_auth_cookie', []rt.PhpVal{})
}

fn wp_get_cookie_login() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0')])
	return false
}

fn wp_login(var_username rt.PhpVal, var_password rt.PhpVal, deprecated string) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.5.0'), rt.new_string('wp_signon()')])
	// unsupported statement: Stmt_Global
	mut var_user := rt.call_function('wp_authenticate', [var_username.dup(),
		var_password.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_user.dup()])))))
	{
		return true
	}
	mut var_error := rt.call_method(var_user, 'get_error_message', []rt.PhpVal{})
	return false
}

struct Class_wp_atom_server {
	rt.PhpObjectBase
}

fn (mut this Class_wp_atom_server) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + var_name.str(), rt.new_string('3.5.0'),
		rt.new_string('the Atom Publishing Protocol plugin')])
}

fn Class_wp_atom_server.magic_callstatic(var_name rt.PhpVal, var_arguments rt.PhpVal) {
	rt.call_function('_deprecated_function', [@STRUCT + '::' + var_name.str(), rt.new_string('3.5.0'),
		rt.new_string('the Atom Publishing Protocol plugin')])
}

fn create_wp_atom_server() &Class_wp_atom_server {
	mut obj := &Class_wp_atom_server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_wp_atom_server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_call(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__callStatic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_wp_atom_server.magic_callstatic(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_wp_atom_server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_wp_atom_server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_pluggable_deprecated_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('set_current_user'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_currentuserinfo'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_userdatabylogin'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_user_by_email'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_setcookie'),
	])))))
	{
	} else {
		rt.call_function('_deprecated_function', [rt.new_string('wp_setcookie'),
			rt.new_string('2.5.0'), rt.new_string('wp_set_auth_cookie()')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_clearcookie'),
	])))))
	{
	} else {
		rt.call_function('_deprecated_function', [rt.new_string('wp_clearcookie'),
			rt.new_string('2.5.0'), rt.new_string('wp_clear_auth_cookie()')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_cookie_login'),
	])))))
	{
	} else {
		rt.call_function('_deprecated_function', [rt.new_string('wp_get_cookie_login'),
			rt.new_string('2.5.0')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_login'),
	])))))
	{
	} else {
		rt.call_function('_deprecated_function', [rt.new_string('wp_login'),
			rt.new_string('2.5.0'), rt.new_string('wp_signon()')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('wp_atom_server'),
		rt.new_bool(false),
	])))))
	{
	}
}
