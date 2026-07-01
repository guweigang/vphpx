import rt

struct Class_ActionScheduler_Lock {
	rt.PhpObjectBase
pub mut:
		locker rt.PhpVal = rt.new_null()
		lock_duration rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_Lock) is_locked(var_lock_type rt.PhpVal) rt.PhpVal {
	return rt.greater_equal(this.get_expiration(var_lock_type.dup()), rt.call_function('time', []rt.PhpVal{}))
}

fn (mut this Class_ActionScheduler_Lock) set(var_lock_type rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_Lock) get_expiration(var_lock_type rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_Lock) get_duration(var_lock_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_lock_duration'), // unsupported expression: Expr_StaticPropertyFetch, var_lock_type.dup()])
}

fn Class_ActionScheduler_Lock.instance() rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_class := rt.call_function('apply_filters', [rt.new_string('action_scheduler_lock_class'), rt.new_string('ActionScheduler_OptionLock')])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn create_actionscheduler_lock() &Class_ActionScheduler_Lock {
	mut obj := &Class_ActionScheduler_Lock{
		PhpObjectBase: rt.PhpObjectBase{}
		locker: rt.new_null()
		lock_duration: rt.new_null()
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
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Lock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'locker' { return this.locker }
		'lock_duration' { return this.lock_duration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Lock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'locker' { this.locker = val; return true }
		'lock_duration' { this.lock_duration = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('ActionScheduler_Lock', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_lock()
		return rt.new_object('ActionScheduler_Lock', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_lock_php() {
}
