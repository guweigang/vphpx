import rt

struct Class_ActionScheduler_CanceledAction {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_CanceledAction) construct(var_hook rt.PhpVal, mut var_args Class_array, mut var_schedule Class_?ActionScheduler_Schedule, group string) {
	this.Class_ActionScheduler_FinishedAction.construct(var_hook.clone(), rt.new_object('array', []string{}, var_args), rt.new_object('?ActionScheduler_Schedule', []string{}, var_schedule), rt.new_string(group))
	if rt.is_true(rt.new_bool(var_schedule.is_null())) {
		this.set_schedule(create_actionscheduler_nullschedule())
	}
}

struct Class_ActionScheduler_FinishedAction {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_canceledaction(arg_0 rt.PhpVal, arg_1 rt.PhpVal, group string, arg_3 rt.PhpVal) &Class_ActionScheduler_CanceledAction {
	mut obj := &Class_ActionScheduler_CanceledAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, group, arg_3)
	return obj
}

fn create_actionscheduler_finishedaction(_args ...rt.PhpVal) &Class_ActionScheduler_FinishedAction {
	mut obj := &Class_ActionScheduler_FinishedAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullschedule(_args ...rt.PhpVal) &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_CanceledAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_Schedule](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_CanceledAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_CanceledAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_FinishedAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_FinishedAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_FinishedAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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



fn main() {
	defer {
		rt.shutdown()
	}

}
