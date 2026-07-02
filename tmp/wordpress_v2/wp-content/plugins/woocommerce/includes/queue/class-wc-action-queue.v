import rt

struct Class_WC_Action_Queue {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Action_Queue) add(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	return this.schedule_single(rt.call_function('time', []rt.PhpVal{}), var_hook.clone(),
		var_args.clone(), group)
}

fn (mut this Class_WC_Action_Queue) schedule_single(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	return rt.call_function('as_schedule_single_action', [var_timestamp.clone(),
		var_hook.clone(), var_args.clone(), rt.new_string(group)])
}

fn (mut this Class_WC_Action_Queue) schedule_recurring(var_timestamp rt.PhpVal, var_interval_in_seconds rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	return rt.call_function('as_schedule_recurring_action', [
		var_timestamp.clone(), var_interval_in_seconds.clone(),
		var_hook.clone(), var_args.clone(), rt.new_string(group)])
}

fn (mut this Class_WC_Action_Queue) schedule_cron(var_timestamp rt.PhpVal, var_cron_schedule rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	return rt.call_function('as_schedule_cron_action', [var_timestamp.clone(),
		var_cron_schedule.clone(), var_hook.clone(), var_args.clone(),
		rt.new_string(group)])
}

fn (mut this Class_WC_Action_Queue) cancel(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	rt.call_function('as_unschedule_action', [var_hook.clone(),
		var_args.clone(), rt.new_string(group)])
}

fn (mut this Class_WC_Action_Queue) cancel_all(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	rt.call_function('as_unschedule_all_actions', [var_hook.clone(),
		var_args.clone(), rt.new_string(group)])
}

fn (mut this Class_WC_Action_Queue) get_next(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_next_timestamp := rt.call_function('as_next_scheduled_action', [
		var_hook.clone(), var_args.clone(), rt.new_string(group)])
	if rt.is_true(rt.new_bool(var_next_timestamp.clone().is_long()
		|| var_next_timestamp.clone().is_double()))
	{
		return create_wc_datetime(rt.new_string('@${var_next_timestamp.to_string()}'),
			create_datetimezone(rt.new_string('UTC')))
	}
	return rt.new_null()
}

fn (mut this Class_WC_Action_Queue) search(var_args rt.PhpVal, var_return_format rt.PhpVal) rt.PhpVal {
	return rt.call_function('as_get_scheduled_actions', [var_args.clone(),
		var_return_format.clone()])
}

struct Class_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_wc_action_queue(_args ...rt.PhpVal) &Class_WC_Action_Queue {
	mut obj := &Class_WC_Action_Queue{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_datetime(_args ...rt.PhpVal) &Class_WC_DateTime {
	mut obj := &Class_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Action_Queue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'schedule_single' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.schedule_single(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'schedule_recurring' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.schedule_recurring(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'schedule_cron' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.schedule_cron(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'cancel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.cancel(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'cancel_all' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.cancel_all(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_next' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_next(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'search' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.search(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Action_Queue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Action_Queue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
