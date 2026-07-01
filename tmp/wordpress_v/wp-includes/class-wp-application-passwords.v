import rt

pub fn Class_WP_Application_Passwords.usermeta_key_application_passwords() string {
	return '_application_passwords'
}
pub fn Class_WP_Application_Passwords.option_key_in_use() string {
	return 'using_application_passwords'
}
pub fn Class_WP_Application_Passwords.pw_length() i64 {
	return 24
}
struct Class_WP_Application_Passwords {
	rt.PhpObjectBase
}

fn Class_WP_Application_Passwords.is_in_use() rt.PhpVal {
	mut var_network_id := rt.call_function('get_main_network_id', []rt.PhpVal{})
	return // unsupported expression: Expr_Cast_Bool
}

fn Class_WP_Application_Passwords.create_new_application_password(var_user_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(!rt.is_true(var_args_mutated.array_get('name'))) {
		var_args_mutated.array_set('name', rt.call_function('sanitize_text_field', [var_args_mutated.array_get('name')]))
	}
	if !rt.is_true(var_args_mutated.array_get('name')) {
		return create_wp_error(rt.new_string('application_password_empty_name'), rt.call_function('__', [rt.new_string('An application name is required to create an application password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_new_password := rt.call_function('wp_generate_password', [Class_static.pw_length(), rt.new_bool(false)])
	mut var_hashed_password := Class_WP_Application_Passwords.hash_password((var_new_password).str())
	mut var_new_item := { 'uuid': rt.call_function('wp_generate_uuid4', []rt.PhpVal{}), 'app_id': if !rt.is_true(var_args_mutated.array_get('app_id')) { rt.new_string('') } else { var_args_mutated.array_get('app_id') }, 'name': var_args_mutated.array_get('name'), 'password': var_hashed_password, 'created': rt.call_function('time', []rt.PhpVal{}), 'last_used': rt.new_null(), 'last_ip': rt.new_null() }
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	var_passwords.array_push(var_new_item.dup())
	mut var_saved := Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), var_passwords.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
		return create_wp_error(rt.new_string('db_error'), rt.call_function('__', [rt.new_string('Could not save application password.')]))
	}
	mut var_network_id := rt.call_function('get_main_network_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_network_option', [var_network_id.dup(), Class_WP_Application_Passwords.option_key_in_use()]))))) {
		rt.call_function('update_network_option', [var_network_id.dup(), Class_WP_Application_Passwords.option_key_in_use(), rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('wp_create_application_password'), var_user_id.dup(), var_new_item.dup(), var_new_password.dup(), var_args_mutated.dup()])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_new_password }, rt.ArrayItem{ key: none, val: var_new_item }])
}

fn Class_WP_Application_Passwords.get_user_application_passwords(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_passwords := rt.call_function('get_user_meta', [var_user_id.dup(), Class_static.usermeta_key_application_passwords(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_passwords.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_save := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_password := item_1.val
			mut var_i := item_1.key
			if !(var_password.array_isset(rt.new_string('uuid'))) {
				var_passwords.array_get_mut(var_i).array_set('uuid', rt.call_function('wp_generate_uuid4', []rt.PhpVal{}))
				var_save = rt.new_bool(rt.new_bool(true))
			}
		}
	}
	if rt.is_true(var_save) {
		Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), var_passwords.dup())
	}
	return var_passwords.dup()
}

fn Class_WP_Application_Passwords.get_user_application_password(var_user_id rt.PhpVal, var_uuid rt.PhpVal) rt.PhpVal {
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_password := item_1.val
			if rt.is_true(rt.identical(var_password.array_get('uuid'), var_uuid)) {
				return var_password.dup()
			}
		}
	}
	return rt.new_null()
}

fn Class_WP_Application_Passwords.application_name_exists_for_user(var_user_id rt.PhpVal, var_name rt.PhpVal) bool {
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_password := item_1.val
			if rt.is_true(rt.identical(rt.new_string(var_password.array_get('name').to_string().to_lower()), rt.new_string(var_name.dup().to_string().to_lower()))) {
				return true
			}
		}
	}
	return false
}

fn Class_WP_Application_Passwords.update_application_password(var_user_id rt.PhpVal, var_uuid rt.PhpVal, var_update rt.PhpVal) bool {
	mut var_update_mutated := var_update
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			if !(!rt.is_true(var_update_mutated.array_get('name'))) {
				var_update_mutated.array_set('name', rt.call_function('sanitize_text_field', [var_update_mutated.array_get('name')]))
			}
			mut var_save := rt.new_bool(rt.new_bool(false))
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_update_mutated.array_get('name'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_item.array_set('name', var_update_mutated.array_get('name'))
				var_save = rt.new_bool(rt.new_bool(true))
			}
			if rt.is_true(var_save) {
				mut var_saved := Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), var_passwords.dup())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
					return (create_wp_error(rt.new_string('db_error'), rt.call_function('__', [rt.new_string('Could not save application password.')]))).to_bool()
				}
			}
			rt.call_function('do_action', [rt.new_string('wp_update_application_password'), var_user_id.dup(), var_item.dup(), var_update_mutated.dup()])
			return true
		}
	}
	return (create_wp_error(rt.new_string('application_password_not_found'), rt.call_function('__', [rt.new_string('Could not find an application password with that id.')]))).to_bool()
}

fn Class_WP_Application_Passwords.record_application_password_usage(var_user_id rt.PhpVal, var_uuid rt.PhpVal) bool {
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_password := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			if rt.is_true(rt.greater(rt.add(var_password.array_get('last_used'), rt.get_constant('DAY_IN_SECONDS')), rt.call_function('time', []rt.PhpVal{}))) {
				return true
			}
			var_password.array_set('last_used', rt.call_function('time', []rt.PhpVal{}))
			var_password.array_set('last_ip', rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR'))
			mut var_saved := Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), var_passwords.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
				return (create_wp_error(rt.new_string('db_error'), rt.call_function('__', [rt.new_string('Could not save application password.')]))).to_bool()
			}
			return true
		}
	}
	return (create_wp_error(rt.new_string('application_password_not_found'), rt.call_function('__', [rt.new_string('Could not find an application password with that id.')]))).to_bool()
}

fn Class_WP_Application_Passwords.delete_application_password(var_user_id rt.PhpVal, var_uuid rt.PhpVal) bool {
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	{
		mut iter_1 := var_passwords.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(var_item.array_get('uuid'), var_uuid)) {
				var_passwords.array_unset(var_key)
				mut var_saved := Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), var_passwords.dup())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
					return (create_wp_error(rt.new_string('db_error'), rt.call_function('__', [rt.new_string('Could not delete application password.')]))).to_bool()
				}
				rt.call_function('do_action', [rt.new_string('wp_delete_application_password'), var_user_id.dup(), var_item.dup()])
				return true
			}
		}
	}
	return (create_wp_error(rt.new_string('application_password_not_found'), rt.call_function('__', [rt.new_string('Could not find an application password with that id.')]))).to_bool()
}

fn Class_WP_Application_Passwords.delete_all_application_passwords(var_user_id rt.PhpVal) i64 {
	mut var_passwords := Class_WP_Application_Passwords.get_user_application_passwords(var_user_id.dup())
	if rt.is_true(var_passwords) {
		mut var_saved := Class_WP_Application_Passwords.set_user_application_passwords(var_user_id.dup(), rt.new_array())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_saved)))) {
			return (create_wp_error(rt.new_string('db_error'), rt.call_function('__', [rt.new_string('Could not delete application passwords.')]))).to_i64()
		}
		{
			mut iter_1 := var_passwords.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				rt.call_function('do_action', [rt.new_string('wp_delete_application_password'), var_user_id.dup(), var_item.dup()])
			}
		}
		return var_passwords.dup().array_count()
	}
	return 0
}

fn Class_WP_Application_Passwords.set_user_application_passwords(var_user_id rt.PhpVal, var_passwords rt.PhpVal) rt.PhpVal {
	mut var_passwords_mutated := var_passwords
	return rt.call_function('update_user_meta', [var_user_id.dup(), Class_static.usermeta_key_application_passwords(), var_passwords_mutated.dup()])
}

fn Class_WP_Application_Passwords.chunk_password(var_raw_password rt.PhpVal) string {
	mut var_raw_password_mutated := var_raw_password
	var_raw_password_mutated = rt.call_function('preg_replace', [rt.new_string('/[^a-z\\d]/i'), rt.new_string(''), var_raw_password_mutated.dup()])
	return rt.call_function('chunk_split', [var_raw_password_mutated.dup(), rt.new_int(4), rt.new_string(' ')]).to_string().trim_space()
}

fn Class_WP_Application_Passwords.hash_password(password string) string {
	mut password_mutated := password
	return (rt.call_function('wp_fast_hash', [rt.new_string(password_mutated).dup()])).str()
}

fn Class_WP_Application_Passwords.check_password(password string, hash string) bool {
	mut password_mutated := password
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(hash), rt.new_string('$generic$')]))))) {
		return (rt.call_function('wp_check_password', [rt.new_string(password_mutated).dup(), rt.new_string(hash)])).to_bool()
	}
	return (rt.call_function('wp_verify_fast_hash', [rt.new_string(password_mutated).dup(), rt.new_string(hash)])).to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_application_passwords() &Class_WP_Application_Passwords {
	mut obj := &Class_WP_Application_Passwords{
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

fn (mut this Class_WP_Application_Passwords) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_in_use' {
			return Class_WP_Application_Passwords.is_in_use()
		}
		'create_new_application_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Application_Passwords.create_new_application_password(dispatch_arg_0, dispatch_arg_1)
		}
		'get_user_application_passwords' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Application_Passwords.get_user_application_passwords(dispatch_arg_0)
		}
		'get_user_application_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Application_Passwords.get_user_application_password(dispatch_arg_0, dispatch_arg_1)
		}
		'application_name_exists_for_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Application_Passwords.application_name_exists_for_user(dispatch_arg_0, dispatch_arg_1))
		}
		'update_application_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Application_Passwords.update_application_password(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'record_application_password_usage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Application_Passwords.record_application_password_usage(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_application_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Application_Passwords.delete_application_password(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_all_application_passwords' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_WP_Application_Passwords.delete_all_application_passwords(dispatch_arg_0))
		}
		'set_user_application_passwords' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Application_Passwords.set_user_application_passwords(dispatch_arg_0, dispatch_arg_1)
		}
		'chunk_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Application_Passwords.chunk_password(dispatch_arg_0))
		}
		'hash_password' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_Application_Passwords.hash_password(dispatch_arg_0))
		}
		'check_password' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_Application_Passwords.check_password(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_Application_Passwords) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Application_Passwords) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_class_wp_application_passwords_php() {
}
