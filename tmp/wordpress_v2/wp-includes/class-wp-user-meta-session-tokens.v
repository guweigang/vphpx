import rt

struct Class_WP_User_Meta_Session_Tokens {
	rt.PhpObjectBase
}

fn (mut this Class_WP_User_Meta_Session_Tokens) get_sessions() rt.PhpVal {
	mut var_sessions := rt.call_function('get_user_meta', [
		rt.get_property(rt.new_object('WP_User_Meta_Session_Tokens', [
			'WP_Session_Tokens',
		], &this), 'user_id'),
		rt.new_string('session_tokens'),
		rt.new_bool(true),
	])
	if !(var_sessions.clone().is_array()) {
		return rt.new_array()
	}
	var_sessions = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Meta_Session_Tokens', [
				'WP_Session_Tokens',
			], &this) },
			rt.ArrayItem{ key: none, val: 'prepare_session' },
		]),
		var_sessions.clone(),
	])
	return rt.call_function('array_filter', [var_sessions.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User_Meta_Session_Tokens', [
				'WP_Session_Tokens',
			], &this) },
			rt.ArrayItem{ key: none, val: 'is_still_valid' },
		])])
}

fn (mut this Class_WP_User_Meta_Session_Tokens) prepare_session(var_session rt.PhpVal) rt.PhpVal {
	mut var_session_mutated := var_session
	if rt.is_true(rt.new_bool(var_session_mutated.clone().is_long())) {
		return rt.create_array([
			rt.ArrayItem{ key: 'expiration', val: var_session_mutated },
		])
	}
	return var_session_mutated.clone()
}

fn (mut this Class_WP_User_Meta_Session_Tokens) get_session(var_verifier rt.PhpVal) rt.PhpVal {
	mut var_sessions := this.get_sessions()
	return if !(var_sessions.array_get(var_verifier)).is_null() {
		var_sessions.array_get(var_verifier)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_User_Meta_Session_Tokens) update_session(var_verifier rt.PhpVal, var_session rt.PhpVal) {
	mut var_session_mutated := var_session
	mut var_sessions := this.get_sessions()
	if rt.is_true(var_session_mutated) {
		var_sessions.array_set(var_verifier, var_session_mutated.clone())
	} else {
		var_sessions.array_unset(var_verifier)
	}
	this.update_sessions(var_sessions.clone())
}

fn (mut this Class_WP_User_Meta_Session_Tokens) update_sessions(var_sessions rt.PhpVal) {
	mut var_sessions_mutated := var_sessions
	if rt.is_true(var_sessions_mutated) {
		rt.call_function('update_user_meta', [
			rt.get_property(rt.new_object('WP_User_Meta_Session_Tokens', [
				'WP_Session_Tokens',
			], &this), 'user_id'),
			rt.new_string('session_tokens'),
			var_sessions_mutated.clone(),
		])
	} else {
		rt.call_function('delete_user_meta', [
			rt.get_property(rt.new_object('WP_User_Meta_Session_Tokens', [
				'WP_Session_Tokens',
			], &this), 'user_id'),
			rt.new_string('session_tokens'),
		])
	}
}

fn (mut this Class_WP_User_Meta_Session_Tokens) destroy_other_sessions(var_verifier rt.PhpVal) {
	mut var_session := this.get_session(var_verifier.clone())
	this.update_sessions(rt.create_array([
		rt.ArrayItem{ key: var_verifier, val: var_session },
	]))
}

fn (mut this Class_WP_User_Meta_Session_Tokens) destroy_all_sessions() {
	this.update_sessions(rt.new_array())
}

fn Class_WP_User_Meta_Session_Tokens.drop_sessions() {
	rt.call_function('delete_metadata', [rt.new_string('user'),
		rt.new_int(0), rt.new_string('session_tokens'), rt.new_bool(false),
		rt.new_bool(true)])
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

fn create_wp_user_meta_session_tokens(_args ...rt.PhpVal) &Class_WP_User_Meta_Session_Tokens {
	mut obj := &Class_WP_User_Meta_Session_Tokens{
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

fn (mut this Class_WP_User_Meta_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_sessions' {
			return this.get_sessions()
		}
		'prepare_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_session(dispatch_arg_0)
		}
		'get_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_session(dispatch_arg_0)
		}
		'update_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_session(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_sessions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_sessions(dispatch_arg_0)
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
			Class_WP_User_Meta_Session_Tokens.drop_sessions()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_User_Meta_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Meta_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
