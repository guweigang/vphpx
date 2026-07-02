import rt

struct Class_ActionScheduler_Action {
	rt.PhpObjectBase
pub mut:
		hook rt.PhpVal = rt.new_string('')
		args rt.PhpVal = rt.new_array()
		schedule rt.PhpVal = rt.new_null()
		group rt.PhpVal = rt.new_string('')
		priority rt.PhpVal = rt.new_int(10)
}

fn (mut this Class_ActionScheduler_Action) construct(var_hook rt.PhpVal, mut var_args Class_array, mut var_schedule Class_?ActionScheduler_Schedule, group string) {
	mut var_hook_mutated := var_hook
	mut var_schedule_mutated := var_schedule
	var_schedule_mutated = if !rt.is_true(var_schedule_mutated) { create_actionscheduler_nullschedule() } else { var_schedule_mutated }
	this.set_hook(var_hook_mutated.clone())
	this.set_schedule(mut var_schedule_mutated)
	this.set_args(mut var_args)
	this.set_group(rt.new_string(group))
}

fn (mut this Class_ActionScheduler_Action) execute() {
	mut var_hook := this.get_hook()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [var_hook.clone()]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Scheduled action for %1$s will not be executed as no callbacks are registered.'), rt.new_string('woocommerce')]), var_hook.clone()]))))
	}
	rt.call_function('do_action_ref_array', [var_hook.clone(), rt.call_function('array_values', [this.get_args()])])
}

fn (mut this Class_ActionScheduler_Action) set_hook(var_hook rt.PhpVal) {
	mut var_hook_mutated := var_hook
	this.hook = var_hook_mutated.clone()
}

fn (mut this Class_ActionScheduler_Action) get_hook() rt.PhpVal {
	return this.hook
}

fn (mut this Class_ActionScheduler_Action) set_schedule(mut var_schedule Class_ActionScheduler_Schedule) {
	mut var_schedule_mutated := var_schedule
	this.schedule = var_schedule_mutated
}

fn (mut this Class_ActionScheduler_Action) get_schedule() rt.PhpVal {
	return this.schedule
}

fn (mut this Class_ActionScheduler_Action) set_args(mut var_args Class_array) {
	this.args = var_args
}

fn (mut this Class_ActionScheduler_Action) get_args() rt.PhpVal {
	return this.args
}

fn (mut this Class_ActionScheduler_Action) set_group(var_group rt.PhpVal) {
	this.group = var_group.clone()
}

fn (mut this Class_ActionScheduler_Action) get_group() rt.PhpVal {
	return this.group
}

fn (mut this Class_ActionScheduler_Action) is_finished() bool {
	return false
}

fn (mut this Class_ActionScheduler_Action) set_priority(var_priority rt.PhpVal) {
	mut var_priority_mutated := var_priority
	if rt.is_true(rt.less(var_priority_mutated, rt.new_int(0))) {
	var_priority_mutated = rt.new_int(0)
	} else if rt.is_true(rt.greater(var_priority_mutated, rt.new_int(255))) {
	var_priority_mutated = rt.new_int(255)
	}
	this.priority = rt.new_int((var_priority_mutated).to_i64())
}

fn (mut this Class_ActionScheduler_Action) get_priority() rt.PhpVal {
	return this.priority
}

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_actionscheduler_action(arg_0 rt.PhpVal, arg_1 rt.PhpVal, group string, arg_3 rt.PhpVal) &Class_ActionScheduler_Action {
	mut obj := &Class_ActionScheduler_Action{
		PhpObjectBase: rt.PhpObjectBase{}
		hook: rt.new_string('')
		args: rt.new_array()
		schedule: rt.new_null()
		group: rt.new_string('')
		priority: rt.new_int(10)
	}
	obj.construct(arg_0, arg_1, group, arg_3)
	return obj
}

fn create_actionscheduler_nullschedule(_args ...rt.PhpVal) &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_ActionScheduler_Action) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_Schedule](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'set_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_hook(dispatch_arg_0)
			return rt.new_null()
		}
		'get_hook' {
			return this.get_hook()
		}
		'set_schedule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Schedule](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_schedule(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_schedule' {
			return this.get_schedule()
		}
		'set_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_args(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_args' {
			return this.get_args()
		}
		'set_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_group(dispatch_arg_0)
			return rt.new_null()
		}
		'get_group' {
			return this.get_group()
		}
		'is_finished' {
			return rt.new_bool(this.is_finished())
		}
		'set_priority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_priority(dispatch_arg_0)
			return rt.new_null()
		}
		'get_priority' {
			return this.get_priority()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Action) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hook' { return this.hook }
		'args' { return this.args }
		'schedule' { return this.schedule }
		'group' { return this.group }
		'priority' { return this.priority }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Action) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hook' { this.hook = val; return true }
		'args' { this.args = val; return true }
		'schedule' { this.schedule = val; return true }
		'group' { this.group = val; return true }
		'priority' { this.priority = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_NullSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
