import rt

struct Class_ActionScheduler_Abstract_Schedule {
	rt.PhpObjectBase
pub mut:
	scheduled_date      rt.PhpVal = rt.new_null()
	scheduled_timestamp rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) construct(mut var_date Class_DateTime) {
	this.scheduled_date = var_date.dup()
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) is_recurring() {
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) calculate_next(mut var_after Class_DateTime) {
	mut var_after_mutated := var_after
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) get_next(mut var_after Class_DateTime) rt.PhpVal {
	mut var_after_mutated := var_after
	var_after_mutated = if rt.is_true(rt.greater(var_after_mutated, this.scheduled_date)) {
		var_after_mutated = this.calculate_next(mut var_after_mutated)
		return rt.new_object('DateTime', []string{}, var_after_mutated)
	}
	return
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) get_date() rt.PhpVal {
	return this.scheduled_date
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) magic_sleep() rt.PhpVal {
	this.scheduled_timestamp = rt.call_method(this.scheduled_date, 'getTimestamp', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: none, val: 'scheduled_timestamp' }])
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) magic_wakeup() {
	this.scheduled_date = rt.call_function('as_get_datetime_object', [
		this.scheduled_timestamp,
	])
	this.scheduled_timestamp = rt.new_null()
}

struct Class_ActionScheduler_Schedule_Deprecated {
	rt.PhpObjectBase
}

fn create_actionscheduler_abstract_schedule(arg_0 rt.PhpVal) &Class_ActionScheduler_Abstract_Schedule {
	mut obj := &Class_ActionScheduler_Abstract_Schedule{
		PhpObjectBase:       rt.PhpObjectBase{}
		scheduled_date:      rt.new_null()
		scheduled_timestamp: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_schedule_deprecated() &Class_ActionScheduler_Schedule_Deprecated {
	mut obj := &Class_ActionScheduler_Schedule_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_recurring' {
			this.is_recurring()
			return rt.new_null()
		}
		'calculate_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.calculate_next(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_next(mut dispatch_arg_0)
		}
		'get_date' {
			return this.get_date()
		}
		'__sleep' {
			return this.magic_sleep()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Abstract_Schedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'scheduled_date' { return this.scheduled_date }
		'scheduled_timestamp' { return this.scheduled_timestamp }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Abstract_Schedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'scheduled_date' {
			this.scheduled_date = val
			return true
		}
		'scheduled_timestamp' {
			this.scheduled_timestamp = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ActionScheduler_Schedule_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Schedule_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Schedule_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_abstract_schedule_php() {
}
