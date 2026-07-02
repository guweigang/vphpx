import rt

struct Class_ActionScheduler_OptionLock {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_OptionLock) set(var_lock_type rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_lock_key := this.get_key(var_lock_type.clone())
	mut var_existing_lock_value := rt.new_string(this.get_existing_lock(var_lock_type.clone()))
	mut var_new_lock_value := rt.new_string(this.new_lock_value(var_lock_type.clone()))
	if !rt.is_true(var_existing_lock_value) {
		return (rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'options'),
			rt.create_array([rt.ArrayItem{ key: 'option_name', val: var_lock_key },
				rt.ArrayItem{ key: 'option_value', val: var_new_lock_value },
				rt.ArrayItem{ key: 'autoload', val: 'no' }])])).to_bool()
	}
	if rt.is_true(rt.greater_equal(this.get_expiration_from(var_existing_lock_value.clone()), rt.call_function('time',
		[]rt.PhpVal{})))
	{
		return false
	}
	return (rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'options'),
		rt.create_array([rt.ArrayItem{ key: 'option_value', val: var_new_lock_value }]),
		rt.create_array([rt.ArrayItem{ key: 'option_name', val: var_lock_key },
			rt.ArrayItem{ key: 'option_value', val: var_existing_lock_value }])])).to_bool()
}

fn (mut this Class_ActionScheduler_OptionLock) get_expiration(var_lock_type rt.PhpVal) rt.PhpVal {
	return this.get_expiration_from(rt.new_string(this.get_existing_lock(var_lock_type.clone())))
}

fn (mut this Class_ActionScheduler_OptionLock) get_expiration_from(var_lock_value rt.PhpVal) rt.PhpVal {
	mut var_lock_string := rt.call_function('explode', [rt.new_string('|'),
		var_lock_value.clone()])
	if var_lock_string.clone().array_count() == 1
		&& var_lock_string.array_get(rt.new_int(0)).is_long()
		|| var_lock_string.array_get(rt.new_int(0)).is_double() {
		return rt.new_int((var_lock_string.array_get(rt.new_int(0))).to_i64())
	}
	if var_lock_string.clone().array_count() == 2
		&& var_lock_string.array_get(rt.new_int(1)).is_long()
		|| var_lock_string.array_get(rt.new_int(1)).is_double() {
		return rt.new_int((var_lock_string.array_get(rt.new_int(1))).to_i64())
	}
	return rt.new_bool(false)
}

fn (mut this Class_ActionScheduler_OptionLock) get_key(var_lock_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [rt.new_string('action_scheduler_lock_%s'),
		var_lock_type.clone()])
}

fn (mut this Class_ActionScheduler_OptionLock) get_existing_lock(var_lock_type rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT option_value FROM '), rt.get_property(var_wpdb,
				'options')), rt.new_string(' WHERE option_name = %s')),
			this.get_key(var_lock_type.clone()),
		]),
	])).str()
}

fn (mut this Class_ActionScheduler_OptionLock) new_lock_value(var_lock_type rt.PhpVal) string {
	return (rt.call_function('uniqid', [rt.new_string(''), rt.new_bool(true)])).str() + '|' +(rt.add(rt.call_function('time', []rt.PhpVal{}), this.get_duration(var_lock_type.clone()))).str()
}

struct Class_ActionScheduler_Lock {
	rt.PhpObjectBase
}

fn create_actionscheduler_optionlock(_args ...rt.PhpVal) &Class_ActionScheduler_OptionLock {
	mut obj := &Class_ActionScheduler_OptionLock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_lock(_args ...rt.PhpVal) &Class_ActionScheduler_Lock {
	mut obj := &Class_ActionScheduler_Lock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_OptionLock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.set(dispatch_arg_0))
		}
		'get_expiration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_expiration(dispatch_arg_0)
		}
		'get_expiration_from' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_expiration_from(dispatch_arg_0)
		}
		'get_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_key(dispatch_arg_0)
		}
		'get_existing_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_existing_lock(dispatch_arg_0))
		}
		'new_lock_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.new_lock_value(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_OptionLock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_OptionLock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_Lock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Lock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Lock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
