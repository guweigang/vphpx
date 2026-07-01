import rt

struct Class_ActionScheduler_Abstract_RecurringSchedule {
	rt.PhpObjectBase
pub mut:
		first_date rt.PhpVal = rt.new_null()
		first_timestamp rt.PhpVal = rt.new_null()
		recurrence rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) construct(mut var_date Class_DateTime, var_recurrence rt.PhpVal, mut var_first Class_?DateTime)  {
	this.Class_ActionScheduler_Abstract_Schedule.construct(rt.new_object('DateTime', []string{}, var_date))
	this.first_date = if !rt.is_true(var_first) { var_date } else { var_first }
	this.recurrence = var_recurrence.dup()
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) is_recurring() bool {
	return true
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) get_first_date() rt.PhpVal {
	return // unsupported expression: Expr_Clone
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) get_recurrence() rt.PhpVal {
	return this.recurrence
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) magic_sleep() rt.PhpVal {
	mut var_sleep_params := this.Class_ActionScheduler_Abstract_Schedule.magic_sleep()
	this.first_timestamp = rt.call_method(this.first_date, 'getTimestamp', []rt.PhpVal{})
	return rt.call_function('array_merge', [var_sleep_params.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'first_timestamp' }, rt.ArrayItem{ key: none, val: 'recurrence' }])])
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) magic_wakeup()  {
	this.Class_ActionScheduler_Abstract_Schedule.magic_wakeup()
	if rt.is_true(rt.greater(this.first_timestamp, rt.new_int(0))) {
		this.first_date = rt.call_function('as_get_datetime_object', [this.first_timestamp])
	} else {
		this.first_date = this.get_date()
	}
}

struct Class_ActionScheduler_Abstract_Schedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_abstract_recurringschedule(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_Abstract_RecurringSchedule {
	mut obj := &Class_ActionScheduler_Abstract_RecurringSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		first_date: rt.new_null()
		first_timestamp: rt.new_null()
		recurrence: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_abstract_schedule() &Class_ActionScheduler_Abstract_Schedule {
	mut obj := &Class_ActionScheduler_Abstract_Schedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'is_recurring' {
			return rt.new_bool(this.is_recurring())
		}
		'get_first_date' {
			return this.get_first_date()
		}
		'get_recurrence' {
			return this.get_recurrence()
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

fn (this &Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'first_date' { return this.first_date }
		'first_timestamp' { return this.first_timestamp }
		'recurrence' { return this.recurrence }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'first_date' { this.first_date = val; return true }
		'first_timestamp' { this.first_timestamp = val; return true }
		'recurrence' { this.recurrence = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_Schedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_Schedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_abstract_recurringschedule_php() {
}
