import rt

struct Class_ActionScheduler_Lock {
	rt.PhpObjectBase
}

fn init_static_actionscheduler_lock() {
	rt.init_static_prop('ActionScheduler_Lock', 'locker', rt.new_null())
	rt.init_static_prop('ActionScheduler_Lock', 'lock_duration',
		rt.get_constant('MINUTE_IN_SECONDS'))
}

fn (mut this Class_ActionScheduler_Lock) is_locked(var_lock_type rt.PhpVal) rt.PhpVal {
	return rt.greater_equal(this.get_expiration(var_lock_type.clone()), rt.call_function('time',
		[]rt.PhpVal{}))
}

fn (mut this Class_ActionScheduler_Lock) set(var_lock_type rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Lock) get_expiration(var_lock_type rt.PhpVal) {
}

fn (mut this Class_ActionScheduler_Lock) get_duration(var_lock_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('action_scheduler_lock_duration'),
		rt.get_static_prop('ActionScheduler_Lock', 'lock_duration'),
		var_lock_type.clone(),
	])
}

fn Class_ActionScheduler_Lock.instance() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_Lock', 'locker')) {
		mut var_class := rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_lock_class'),
			rt.new_string('ActionScheduler_OptionLock'),
		])
		rt.set_static_prop('ActionScheduler_Lock', 'locker', rt.new_object('', []string{}, rt.create_object_dynamically(var_class,
			[]rt.PhpVal{})))
	}
	return rt.get_static_prop('ActionScheduler_Lock', 'locker')
}

fn create_actionscheduler_lock(_args ...rt.PhpVal) &Class_ActionScheduler_Lock {
	mut obj := &Class_ActionScheduler_Lock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Lock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_locked' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_locked(dispatch_arg_0)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set(dispatch_arg_0)
			return rt.new_null()
		}
		'get_expiration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_expiration(dispatch_arg_0)
			return rt.new_null()
		}
		'get_duration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_duration(dispatch_arg_0)
		}
		'instance' {
			return Class_ActionScheduler_Lock.instance()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Lock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Lock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('ActionScheduler_Lock', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_lock()
		return rt.new_object('ActionScheduler_Lock', []string{}, obj)
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
