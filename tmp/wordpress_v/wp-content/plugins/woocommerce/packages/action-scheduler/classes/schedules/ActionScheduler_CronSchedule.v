import rt

struct Class_ActionScheduler_CronSchedule {
	rt.PhpObjectBase
pub mut:
		start_timestamp rt.PhpVal = rt.new_null()
		cron rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_CronSchedule) construct(mut var_start Class_DateTime, var_recurrence rt.PhpVal, mut var_first Class_?DateTime)  {
	mut var_recurrence_mutated := var_recurrence
	mut var_first_mutated := var_first
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_recurrence_mutated.dup(), rt.new_string('CronExpression')]))))) {
		var_recurrence_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_CronExpression{}; return temp.factory(arg_0) }(var_recurrence_mutated.dup())
	}
	mut var_date := rt.call_method(var_recurrence_mutated, 'getNextRunDate', [var_start, rt.new_int(0), rt.new_bool(true)])
	var_first_mutated = if !rt.is_true(var_first_mutated) { var_start } else { var_first_mutated }
	this.Class_ActionScheduler_Abstract_RecurringSchedule.construct(var_date.dup(), var_recurrence_mutated.dup(), rt.new_object('?DateTime', []string{}, var_first_mutated))
}

fn (mut this Class_ActionScheduler_CronSchedule) calculate_next(mut var_after Class_DateTime) rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'recurrence'), 'getNextRunDate', [var_after, rt.new_int(0), rt.new_bool(false)])
}

fn (mut this Class_ActionScheduler_CronSchedule) get_recurrence() string {
	return rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'recurrence').to_string()
}

fn (mut this Class_ActionScheduler_CronSchedule) magic_sleep() rt.PhpVal {
	mut var_sleep_params := this.Class_ActionScheduler_Abstract_RecurringSchedule.magic_sleep()
	this.start_timestamp = rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'scheduled_timestamp')
	this.cron = rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'recurrence')
	return rt.call_function('array_merge', [var_sleep_params.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'start_timestamp' }, rt.ArrayItem{ key: none, val: 'cron' }])])
}

fn (mut this Class_ActionScheduler_CronSchedule) magic_wakeup()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'scheduled_timestamp').is_null())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.start_timestamp.is_null()))))))) {
		this.dispatch_set_prop('scheduled_timestamp', this.start_timestamp)
		this.start_timestamp = rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(rt.new_object('ActionScheduler_CronSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'recurrence').is_null())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.cron.is_null()))))))) {
		this.dispatch_set_prop('recurrence', this.cron)
		this.cron = rt.new_null()
	}
	this.Class_ActionScheduler_Abstract_RecurringSchedule.magic_wakeup()
}

struct Class_ActionScheduler_Abstract_RecurringSchedule {
	rt.PhpObjectBase
}

struct Class_CronExpression {
	rt.PhpObjectBase
}

fn create_actionscheduler_cronschedule(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_CronSchedule {
	mut obj := &Class_ActionScheduler_CronSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		start_timestamp: rt.new_null()
		cron: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_abstract_recurringschedule() &Class_ActionScheduler_Abstract_RecurringSchedule {
	mut obj := &Class_ActionScheduler_Abstract_RecurringSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression() &Class_CronExpression {
	mut obj := &Class_CronExpression{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_CronSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'calculate_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.calculate_next(mut dispatch_arg_0)
		}
		'get_recurrence' {
			return rt.new_string(this.get_recurrence())
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

fn (this &Class_ActionScheduler_CronSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'start_timestamp' { return this.start_timestamp }
		'cron' { return this.cron }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_CronSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'start_timestamp' { this.start_timestamp = val; return true }
		'cron' { this.cron = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_RecurringSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_CronExpression) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_schedules_actionscheduler_cronschedule_php() {
}
