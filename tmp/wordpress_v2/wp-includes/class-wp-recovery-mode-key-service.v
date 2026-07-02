import rt

struct Class_WP_Recovery_Mode_Key_Service {
	rt.PhpObjectBase
pub mut:
	option_name rt.PhpVal = rt.new_string('recovery_keys')
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) generate_recovery_mode_token() rt.PhpVal {
	return rt.call_function('wp_generate_password', [rt.new_int(22),
		rt.new_bool(false)])
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) generate_and_store_recovery_mode_key(var_token rt.PhpVal) rt.PhpVal {
	mut var_key := rt.call_function('wp_generate_password', [
		rt.new_int(22), rt.new_bool(false)])
	mut var_records := this.get_keys()
	var_records.array_set(var_token, rt.create_array([
		rt.ArrayItem{ key: 'hashed_key', val: rt.call_function('wp_fast_hash', [
			var_key.clone(),
		]) },
		rt.ArrayItem{ key: 'created_at', val: rt.call_function('time', []rt.PhpVal{}) },
	]))
	this.update_keys(mut rt.cast_object_ptr[Class_array](var_records))
	rt.call_function('do_action', [rt.new_string('generate_recovery_mode_key'),
		var_token.clone(), var_key.clone()])
	return var_key.clone()
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) validate_recovery_mode_key(var_token rt.PhpVal, var_key rt.PhpVal, var_ttl rt.PhpVal) bool {
	mut var_key_mutated := var_key
	mut var_records := this.get_keys()
	if !(var_records.array_isset(var_token)) {
		return (create_wp_error(rt.new_string('token_not_found'), rt.call_function('__', [
			rt.new_string('Recovery Mode not initialized.'),
		]))).to_bool()
	}
	mut var_record := var_records.array_get(var_token)
	this.remove_key(var_token.clone())
	if !(var_record.clone().is_array())
		|| (!(var_record.array_isset(rt.new_string('hashed_key'))
		&& var_record.array_isset(rt.new_string('created_at')))) {
		return (create_wp_error(rt.new_string('invalid_recovery_key_format'), rt.call_function('__', [
			rt.new_string('Invalid recovery key format.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_fast_hash', [
		var_key_mutated.clone(),
		var_record.array_get(rt.new_string('hashed_key')),
	])))))
	{
		return (create_wp_error(rt.new_string('hash_mismatch'), rt.call_function('__', [
			rt.new_string('Invalid recovery key.'),
		]))).to_bool()
	}
	if rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.add(var_record.array_get(rt.new_string('created_at')),
		var_ttl)))
	{
		return (create_wp_error(rt.new_string('key_expired'), rt.call_function('__', [
			rt.new_string('Recovery key expired.'),
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) clean_expired_keys(var_ttl rt.PhpVal) {
	mut var_records := this.get_keys()
	mut iter_1 := var_records.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_record := item_1.val
		mut var_key := item_1.key
		if !(var_record.array_isset(rt.new_string('created_at')))
			|| rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.add(var_record.array_get(rt.new_string('created_at')), var_ttl))) {
			var_records.array_unset(var_key)
		}
	}
	this.update_keys(mut rt.cast_object_ptr[Class_array](var_records))
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) remove_key(var_token rt.PhpVal) {
	mut var_records := this.get_keys()
	if !(var_records.array_isset(var_token)) {
		return
	}
	var_records.array_unset(var_token)
	this.update_keys(mut rt.cast_object_ptr[Class_array](var_records))
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) get_keys() rt.PhpVal {
	return rt.cast_array(rt.call_function('get_option', [this.option_name, rt.new_array()]))
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) update_keys(mut var_keys Class_array) rt.PhpVal {
	return rt.call_function('update_option', [this.option_name, var_keys, rt.new_bool(false)])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_recovery_mode_key_service(_args ...rt.PhpVal) &Class_WP_Recovery_Mode_Key_Service {
	mut obj := &Class_WP_Recovery_Mode_Key_Service{
		PhpObjectBase: rt.PhpObjectBase{}
		option_name:   rt.new_string('recovery_keys')
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate_recovery_mode_token' {
			return this.generate_recovery_mode_token()
		}
		'generate_and_store_recovery_mode_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_and_store_recovery_mode_key(dispatch_arg_0)
		}
		'validate_recovery_mode_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.validate_recovery_mode_key(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'clean_expired_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clean_expired_keys(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_key(dispatch_arg_0)
			return rt.new_null()
		}
		'get_keys' {
			return this.get_keys()
		}
		'update_keys' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.update_keys(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Recovery_Mode_Key_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'option_name' { return this.option_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'option_name' {
			this.option_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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
}
