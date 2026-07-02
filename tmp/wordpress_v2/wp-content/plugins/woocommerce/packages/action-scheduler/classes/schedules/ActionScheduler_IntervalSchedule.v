import rt

struct Class_ActionScheduler_IntervalSchedule {
	rt.PhpObjectBase
pub mut:
	start_timestamp     rt.PhpVal = rt.new_null()
	interval_in_seconds rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_IntervalSchedule) calculate_next(mut var_after Class_DateTime) rt.PhpVal {
	var_after.modify(rt.new_string('+' + rt.new_int((this.get_recurrence()).to_i64()).str() +
		' seconds'))
	return rt.new_object('DateTime', []string{}, var_after)
}

fn (mut this Class_ActionScheduler_IntervalSchedule) interval_in_seconds() i64 {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.0.0'),
		rt.new_string('(int)ActionScheduler_Abstract_RecurringSchedule::get_recurrence()')])
	return rt.new_int((this.get_recurrence()).to_i64())
}

fn (mut this Class_ActionScheduler_IntervalSchedule) magic_sleep() rt.PhpVal {
	mut var_sleep_params := this.Class_ActionScheduler_Abstract_RecurringSchedule.magic_sleep()
	this.start_timestamp = rt.get_property(rt.new_object('ActionScheduler_IntervalSchedule', [
		'ActionScheduler_Abstract_RecurringSchedule',
		'ActionScheduler_Schedule',
	], &this), 'scheduled_timestamp')
	this.interval_in_seconds = rt.get_property(rt.new_object('ActionScheduler_IntervalSchedule', [
		'ActionScheduler_Abstract_RecurringSchedule',
		'ActionScheduler_Schedule',
	], &this), 'recurrence')
	return rt.call_function('array_merge', [var_sleep_params.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'start_timestamp' },
			rt.ArrayItem{ key: none, val: 'interval_in_seconds' }])])
}

fn (mut this Class_ActionScheduler_IntervalSchedule) magic_wakeup() {
	if rt.get_property(rt.new_object('ActionScheduler_IntervalSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'scheduled_timestamp').is_null()
		&& !(this.start_timestamp.is_null()) {
		this.dispatch_set_prop('scheduled_timestamp', this.start_timestamp)
		this.start_timestamp = rt.new_null()
	}
	if rt.get_property(rt.new_object('ActionScheduler_IntervalSchedule', ['ActionScheduler_Abstract_RecurringSchedule', 'ActionScheduler_Schedule'], &this), 'recurrence').is_null()
		&& !(this.interval_in_seconds.is_null()) {
		this.dispatch_set_prop('recurrence', this.interval_in_seconds)
		this.interval_in_seconds = rt.new_null()
	}
	this.Class_ActionScheduler_Abstract_RecurringSchedule.magic_wakeup()
}

struct Class_ActionScheduler_Abstract_RecurringSchedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_intervalschedule(_args ...rt.PhpVal) &Class_ActionScheduler_IntervalSchedule {
	mut obj := &Class_ActionScheduler_IntervalSchedule{
		PhpObjectBase:       rt.PhpObjectBase{}
		start_timestamp:     rt.new_null()
		interval_in_seconds: rt.new_null()
	}
	return obj
}

fn create_actionscheduler_abstract_recurringschedule(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_RecurringSchedule {
	mut obj := &Class_ActionScheduler_Abstract_RecurringSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_IntervalSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.calculate_next(mut dispatch_arg_0)
		}
		'interval_in_seconds' {
			return rt.new_int(this.interval_in_seconds())
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

fn (this &Class_ActionScheduler_IntervalSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'start_timestamp' { return this.start_timestamp }
		'interval_in_seconds' { return this.interval_in_seconds }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_IntervalSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'start_timestamp' {
			this.start_timestamp = val
			return true
		}
		'interval_in_seconds' {
			this.interval_in_seconds = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
