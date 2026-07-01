import rt

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
pub mut:
		scheduled_date rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_NullSchedule) construct(mut var_date Class_?DateTime)  {
	this.scheduled_date = rt.new_null()
}

fn (mut this Class_ActionScheduler_NullSchedule) magic_sleep() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_ActionScheduler_NullSchedule) magic_wakeup()  {
	this.scheduled_date = rt.new_null()
}

struct Class_ActionScheduler_SimpleSchedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_nullschedule(arg_0 rt.PhpVal) &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		scheduled_date: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_simpleschedule() &Class_ActionScheduler_SimpleSchedule {
	mut obj := &Class_ActionScheduler_SimpleSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_NullSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__sleep' {
			return this.magic_sleep()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_NullSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'scheduled_date' { return this.scheduled_date }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_NullSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'scheduled_date' { this.scheduled_date = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_SimpleSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_schedules_actionscheduler_nullschedule_php() {
}
