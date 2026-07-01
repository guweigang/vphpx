import rt

fn wc_schedule_single_action(var_timestamp rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_single_action()')])
	return rt.call_function('as_schedule_single_action', [var_timestamp.dup(),
		var_hook.dup(), var_args.dup(), rt.new_string(group)])
}

fn wc_schedule_recurring_action(var_timestamp rt.PhpVal, var_interval_in_seconds rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_recurring_action()')])
	return rt.call_function('as_schedule_recurring_action', [
		var_timestamp.dup(), var_interval_in_seconds.dup(), var_hook.dup(),
		var_args.dup(), rt.new_string(group)])
}

fn wc_schedule_cron_action(var_timestamp rt.PhpVal, var_schedule rt.PhpVal, var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_schedule_cron_action()')])
	return rt.call_function('as_schedule_cron_action', [var_timestamp.dup(),
		var_schedule.dup(), var_hook.dup(), var_args.dup(), rt.new_string(group)])
}

fn wc_unschedule_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_unschedule_action()')])
	rt.call_function('as_unschedule_action', [var_hook.dup(),
		var_args.dup(), rt.new_string(group)])
}

fn wc_next_scheduled_action(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_next_scheduled_action()')])
	return rt.call_function('as_next_scheduled_action', [var_hook.dup(),
		var_args.dup(), rt.new_string(group)])
}

fn wc_get_scheduled_actions(var_args rt.PhpVal, var_return_format rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('as_get_scheduled_actions()')])
	return rt.call_function('as_get_scheduled_actions', [var_args.dup(),
		var_return_format.dup()])
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_deprecated_functions_php() {
}
