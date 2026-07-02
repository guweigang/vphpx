import rt

pub fn Class_WP_Recovery_Mode_Link_Service.login_action_enter() string {
	return 'enter_recovery_mode'
}

pub fn Class_WP_Recovery_Mode_Link_Service.login_action_entered() string {
	return 'entered_recovery_mode'
}

struct Class_WP_Recovery_Mode_Link_Service {
	rt.PhpObjectBase
pub mut:
	key_service    rt.PhpVal = rt.new_null()
	cookie_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) construct(mut var_cookie_service Class_WP_Recovery_Mode_Cookie_Service, mut var_key_service Class_WP_Recovery_Mode_Key_Service) {
	this.cookie_service = var_cookie_service
	this.key_service = var_key_service
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) generate_url() rt.PhpVal {
	mut var_token := rt.call_method(this.key_service, 'generate_recovery_mode_token', []rt.PhpVal{})
	mut var_key := rt.call_method(this.key_service, 'generate_and_store_recovery_mode_key', [
		var_token.clone(),
	])
	return this.get_recovery_mode_begin_url(var_token.clone(), var_key.clone())
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) handle_begin_link(var_ttl rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('pagenow')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_GLOBALS.array_get(rt.new_string('pagenow')))))) {
		return
	}
	if (!(rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('rm_token'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('rm_key'))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_Recovery_Mode_Link_Service.login_action_enter(), rt.get_superglobal('_GET').array_get(rt.new_string('action')))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_generate_password'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php',
			'4')
	}
	mut var_validated := rt.call_method(this.key_service, 'validate_recovery_mode_key', [
		rt.get_superglobal('_GET').array_get(rt.new_string('rm_token')),
		rt.get_superglobal('_GET').array_get(rt.new_string('rm_key')),
		var_ttl.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_validated.clone()])) {
		rt.call_function('wp_die', [var_validated.clone(), rt.new_string('')])
	}
	rt.call_method(this.cookie_service, 'set_cookie', []rt.PhpVal{})
	mut var_url := rt.call_function('add_query_arg', [rt.new_string('action'),
		rt.new_string(Class_WP_Recovery_Mode_Link_Service.login_action_entered()),
		rt.call_function('wp_login_url', []rt.PhpVal{})])
	rt.call_function('wp_redirect', [var_url.clone()])
	exit(0)
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) get_recovery_mode_begin_url(var_token rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_token_mutated := var_token
	mut var_key_mutated := var_key
	mut var_url := rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{
				key: 'action'
				val: Class_WP_Recovery_Mode_Link_Service.login_action_enter()
			},
			rt.ArrayItem{ key: 'rm_token', val: var_token_mutated },
			rt.ArrayItem{ key: 'rm_key', val: var_key_mutated },
		]),
		rt.call_function('wp_login_url', []rt.PhpVal{}),
	])
	return rt.call_function('apply_filters', [rt.new_string('recovery_mode_begin_url'),
		var_url.clone(), var_token_mutated.clone(), var_key_mutated.clone()])
}

fn create_wp_recovery_mode_link_service(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_Recovery_Mode_Link_Service {
	mut obj := &Class_WP_Recovery_Mode_Link_Service{
		PhpObjectBase:  rt.PhpObjectBase{}
		key_service:    rt.new_null()
		cookie_service: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Recovery_Mode_Cookie_Service](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Recovery_Mode_Key_Service](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'generate_url' {
			return this.generate_url()
		}
		'handle_begin_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_begin_link(dispatch_arg_0)
			return rt.new_null()
		}
		'get_recovery_mode_begin_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_recovery_mode_begin_url(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Recovery_Mode_Link_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'key_service' { return this.key_service }
		'cookie_service' { return this.cookie_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'key_service' {
			this.key_service = val
			return true
		}
		'cookie_service' {
			this.cookie_service = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
