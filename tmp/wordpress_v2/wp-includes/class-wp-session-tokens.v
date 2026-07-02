import rt

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
pub mut:
	user_id rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Session_Tokens) construct(var_user_id rt.PhpVal) {
	this.user_id = var_user_id.clone()
}

fn Class_WP_Session_Tokens.get_instance(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_manager := rt.call_function('apply_filters', [
		rt.new_string('session_token_manager'),
		rt.new_string('WP_User_Meta_Session_Tokens'),
	])
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_manager, [
		var_user_id.clone(),
	]))
}

fn (mut this Class_WP_Session_Tokens) hash_token(var_token rt.PhpVal) rt.PhpVal {
	mut var_token_mutated := var_token
	return rt.call_function('hash', [rt.new_string('sha256'),
		var_token_mutated.clone()])
}

fn (mut this Class_WP_Session_Tokens) get(var_token rt.PhpVal) rt.PhpVal {
	mut var_token_mutated := var_token
	mut var_verifier := this.hash_token(var_token_mutated.clone())
	this.get_session(var_verifier.clone())
	return rt.new_null()
}

fn (mut this Class_WP_Session_Tokens) verify(var_token rt.PhpVal) bool {
	mut var_token_mutated := var_token
	mut var_verifier := this.hash_token(var_token_mutated.clone())
	return (this.get_session(var_verifier.clone())).to_bool()
}

fn (mut this Class_WP_Session_Tokens) create(var_expiration rt.PhpVal) rt.PhpVal {
	mut var_session := rt.call_function('apply_filters', [
		rt.new_string('attach_session_information'),
		rt.new_array(),
		this.user_id,
	])
	var_session.array_set('expiration', var_expiration.clone())
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')))) {
		var_session.array_set('ip',
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')))
	}
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')))) {
		var_session.array_set('ua', rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
		]))
	}
	var_session.array_set('login', rt.call_function('time', []rt.PhpVal{}))
	mut var_token := rt.call_function('wp_generate_password', [
		rt.new_int(43), rt.new_bool(false), rt.new_bool(false)])
	this.update(var_token.clone(), var_session.clone())
	return var_token.clone()
}

fn (mut this Class_WP_Session_Tokens) update(var_token rt.PhpVal, var_session rt.PhpVal) {
	mut var_token_mutated := var_token
	mut var_session_mutated := var_session
	mut var_verifier := this.hash_token(var_token_mutated.clone())
	this.update_session(var_verifier.clone(), var_session_mutated.clone())
}

fn (mut this Class_WP_Session_Tokens) destroy(var_token rt.PhpVal) {
	mut var_token_mutated := var_token
	mut var_verifier := this.hash_token(var_token_mutated.clone())
	this.update_session(var_verifier.clone(), rt.new_null())
}

fn (mut this Class_WP_Session_Tokens) destroy_others(var_token_to_keep rt.PhpVal) {
	mut var_verifier := this.hash_token(var_token_to_keep.clone())
	mut var_session := this.get_session(var_verifier.clone())
	if rt.is_true(var_session) {
		this.destroy_other_sessions(var_verifier.clone())
	} else {
		this.destroy_all_sessions()
	}
}

fn (mut this Class_WP_Session_Tokens) is_still_valid(var_session rt.PhpVal) rt.PhpVal {
	mut var_session_mutated := var_session
	return rt.greater_equal(var_session_mutated.array_get(rt.new_string('expiration')), rt.call_function('time',
		[]rt.PhpVal{}))
}

fn (mut this Class_WP_Session_Tokens) destroy_all() {
	this.destroy_all_sessions()
}

fn Class_WP_Session_Tokens.destroy_all_for_all_users() {
	mut var_manager := rt.call_function('apply_filters', [
		rt.new_string('session_token_manager'),
		rt.new_string('WP_User_Meta_Session_Tokens'),
	])
	rt.call_function('call_user_func', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_manager },
			rt.ArrayItem{ key: none, val: 'drop_sessions' }]),
	])
}

fn (mut this Class_WP_Session_Tokens) get_all() rt.PhpVal {
	return rt.call_function('array_values', [this.get_sessions()])
}

fn (mut this Class_WP_Session_Tokens) get_sessions() {
}

fn (mut this Class_WP_Session_Tokens) get_session(var_verifier rt.PhpVal) {
	mut var_verifier_mutated := var_verifier
}

fn (mut this Class_WP_Session_Tokens) update_session(var_verifier rt.PhpVal, var_session rt.PhpVal) {
	mut var_verifier_mutated := var_verifier
	mut var_session_mutated := var_session
}

fn (mut this Class_WP_Session_Tokens) destroy_other_sessions(var_verifier rt.PhpVal) {
	mut var_verifier_mutated := var_verifier
}

fn (mut this Class_WP_Session_Tokens) destroy_all_sessions() {
}

fn Class_WP_Session_Tokens.drop_sessions() {
}

fn create_wp_session_tokens(arg_0 rt.PhpVal) &Class_WP_Session_Tokens {
	mut obj := &Class_WP_Session_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
		user_id:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Session_Tokens.get_instance(dispatch_arg_0)
		}
		'hash_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hash_token(dispatch_arg_0)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.verify(dispatch_arg_0))
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'destroy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.destroy(dispatch_arg_0)
			return rt.new_null()
		}
		'destroy_others' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.destroy_others(dispatch_arg_0)
			return rt.new_null()
		}
		'is_still_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_still_valid(dispatch_arg_0)
		}
		'destroy_all' {
			this.destroy_all()
			return rt.new_null()
		}
		'destroy_all_for_all_users' {
			Class_WP_Session_Tokens.destroy_all_for_all_users()
			return rt.new_null()
		}
		'get_all' {
			return this.get_all()
		}
		'get_sessions' {
			this.get_sessions()
			return rt.new_null()
		}
		'get_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_session(dispatch_arg_0)
			return rt.new_null()
		}
		'update_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_session(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'destroy_other_sessions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.destroy_other_sessions(dispatch_arg_0)
			return rt.new_null()
		}
		'destroy_all_sessions' {
			this.destroy_all_sessions()
			return rt.new_null()
		}
		'drop_sessions' {
			Class_WP_Session_Tokens.drop_sessions()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user_id' { return this.user_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user_id' {
			this.user_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
	rt.register_class_factory('WP_Session_Tokens', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wp_session_tokens(c_arg_0)
		return rt.new_object('WP_Session_Tokens', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
