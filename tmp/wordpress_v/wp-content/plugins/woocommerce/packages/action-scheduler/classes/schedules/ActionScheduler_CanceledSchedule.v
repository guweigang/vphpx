import rt

struct Class_ActionScheduler_CanceledSchedule {
	rt.PhpObjectBase
pub mut:
	timestamp rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_CanceledSchedule) calculate_next(mut var_after Class_DateTime) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_CanceledSchedule) get_next(mut var_after Class_DateTime) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_CanceledSchedule) is_recurring() bool {
	return false
}

fn (mut this Class_ActionScheduler_CanceledSchedule) magic_wakeup() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.timestamp.is_null()))))) {
		this.dispatch_set_prop('scheduled_timestamp', this.timestamp)
		this.timestamp = rt.new_null()
	}
	this.Class_ActionScheduler_SimpleSchedule.magic_wakeup()
}

struct Class_ActionScheduler_SimpleSchedule {
	rt.PhpObjectBase
}

fn create_actionscheduler_canceledschedule() &Class_ActionScheduler_CanceledSchedule {
	mut obj := &Class_ActionScheduler_CanceledSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
		timestamp:     rt.new_null()
	}
	return obj
}

fn create_actionscheduler_simpleschedule() &Class_ActionScheduler_SimpleSchedule {
	mut obj := &Class_ActionScheduler_SimpleSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_CanceledSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'calculate_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.calculate_next(mut dispatch_arg_0)
		}
		'get_next' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_next(mut dispatch_arg_0)
		}
		'is_recurring' {
			return rt.new_bool(this.is_recurring())
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

fn (this &Class_ActionScheduler_CanceledSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'timestamp' { return this.timestamp }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_CanceledSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_SimpleSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SimpleSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_schedules_actionscheduler_canceledschedule_php() {
}
