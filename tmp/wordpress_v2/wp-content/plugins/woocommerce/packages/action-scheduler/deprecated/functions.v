import rt

fn wc_schedule_single_action(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_single_action()')])
	return rt.call_function('as_schedule_single_action', [var_timestamp.clone(),
		var_hook.clone(), var_args.clone(), rt.new_string(group)])
}

fn wc_schedule_recurring_action(var_timestamp rt.PhpVal, var_interval_in_seconds rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_recurring_action()')])
	return rt.call_function('as_schedule_recurring_action', [
		var_timestamp.clone(), var_interval_in_seconds.clone(),
		var_hook.clone(), var_args.clone(), rt.new_string(group)])
}

fn wc_schedule_cron_action(var_timestamp rt.PhpVal, var_schedule rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_cron_action()')])
	return rt.call_function('as_schedule_cron_action', [var_timestamp.clone(),
		var_schedule.clone(), var_hook.clone(), var_args.clone(),
		rt.new_string(group)])
}

fn wc_unschedule_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	mut var_group := group
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_unschedule_action()')])
	rt.call_function('as_unschedule_action', [var_hook.clone(),
		var_args.clone(), rt.new_string(group)])
}

fn wc_next_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	mut var_group := group
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_next_scheduled_action()')])
	return rt.call_function('as_next_scheduled_action', [var_hook.clone(),
		var_args.clone(), rt.new_string(group)])
}

fn wc_get_scheduled_actions(var_args rt.PhpVal, var_return_format rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_get_scheduled_actions()')])
	return rt.call_function('as_get_scheduled_actions', [var_args.clone(),
		var_return_format.clone()])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
