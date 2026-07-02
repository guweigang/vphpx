import rt

struct Class_ActionScheduler_SimpleSchedule {
	rt.PhpObjectBase
pub mut:
	timestamp rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_SimpleSchedule) calculate_next(mut var_after Class_DateTime) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_SimpleSchedule) is_recurring() bool {
	return false
}

fn (mut this Class_ActionScheduler_SimpleSchedule) magic_sleep() rt.PhpVal {
	mut var_sleep_params := this.Class_ActionScheduler_Abstract_Schedule.magic_sleep()
	this.timestamp = rt.get_property(rt.new_object('ActionScheduler_SimpleSchedule', [
		'ActionScheduler_Abstract_Schedule',
	], &this), 'scheduled_timestamp')
	return rt.call_function('array_merge', [var_sleep_params.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'timestamp' }])])
}

fn (mut this Class_ActionScheduler_SimpleSchedule) magic_wakeup() {
	if rt.get_property(rt.new_object('ActionScheduler_SimpleSchedule', ['ActionScheduler_Abstract_Schedule'], &this), 'scheduled_timestamp').is_null()
		&& !(this.timestamp.is_null()) {
		this.dispatch_set_prop('scheduled_timestamp', this.timestamp)
		this.timestamp = rt.new_null()
	}
	this.Class_ActionScheduler_Abstract_Schedule.magic_wakeup()
}

struct Class_ActionScheduler_Abstract_Schedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_simpleschedule(_args ...rt.PhpVal) &Class_ActionScheduler_SimpleSchedule {
	mut obj := &Class_ActionScheduler_SimpleSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		timestamp:     rt.new_null()
	}
	return obj
}

fn create_actionscheduler_abstract_schedule(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_Schedule {
	mut obj := &Class_ActionScheduler_Abstract_Schedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.calculate_next(mut dispatch_arg_0)
		}
		'is_recurring' {
			return rt.new_bool(this.is_recurring())
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

fn (this &Class_ActionScheduler_SimpleSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'timestamp' { return this.timestamp }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'timestamp' {
			this.timestamp = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
