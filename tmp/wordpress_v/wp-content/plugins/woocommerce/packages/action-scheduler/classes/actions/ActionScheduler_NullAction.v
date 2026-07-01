import rt

struct Class_ActionScheduler_NullAction {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_NullAction) construct(hook string, mut var_args Class_array, mut var_schedule Class_?ActionScheduler_Schedule)  {
	this.set_schedule(create_actionscheduler_nullschedule())
}

fn (mut this Class_ActionScheduler_NullAction) execute()  {
	// unsupported statement: Stmt_Nop
}

struct Class_ActionScheduler_Action {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_nullaction(hook string, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_NullAction {
	mut obj := &Class_ActionScheduler_NullAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(hook, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_action() &Class_ActionScheduler_Action {
	mut obj := &Class_ActionScheduler_Action{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullschedule() &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_NullAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_Schedule](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'execute' {
			this.execute()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_NullAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Action) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Action) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Action) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actions_actionscheduler_nullaction_php() {
}
