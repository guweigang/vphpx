import rt

pub fn Class_ActionScheduler_RecurringActionScheduler.run_scheduled_recurring_actions_hook() string {
	return 'action_scheduler_run_recurring_actions_schedule_hook'
}

struct Class_ActionScheduler_RecurringActionScheduler {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) init() {
	rt.call_function('add_action', [
		rt.new_string(Class_ActionScheduler_RecurringActionScheduler.run_scheduled_recurring_actions_hook()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_RecurringActionScheduler',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run_recurring_scheduler_hook' },
		]),
	])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('DOING_AJAX'))))) {
		rt.call_function('add_action', [rt.new_string('action_scheduler_init'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_RecurringActionScheduler',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'schedule_recurring_scheduler_hook' },
			])])
	}
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) schedule_recurring_scheduler_hook() {
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_cache_get', [
		rt.new_string('as_is_ensure_recurring_actions_scheduled'),
	])))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('as_has_scheduled_action', [
			rt.new_string(Class_ActionScheduler_RecurringActionScheduler.run_scheduled_recurring_actions_hook()),
		])))))
		{
			rt.call_function('as_schedule_recurring_action', [
				rt.call_function('time', []rt.PhpVal{}),
				rt.get_constant('DAY_IN_SECONDS'),
				rt.new_string(Class_ActionScheduler_RecurringActionScheduler.run_scheduled_recurring_actions_hook()),
				rt.new_array(),
				rt.new_string('ActionScheduler'),
				rt.new_bool(true),
				rt.new_int(20),
			])
		}
		rt.call_function('wp_cache_set', [
			rt.new_string('as_is_ensure_recurring_actions_scheduled'),
			rt.new_bool(true),
			rt.get_constant('HOUR_IN_SECONDS'),
		])
	}
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) run_recurring_scheduler_hook() {
	rt.call_function('do_action', [
		rt.new_string('action_scheduler_ensure_recurring_actions'),
	])
}

fn create_actionscheduler_recurringactionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler_RecurringActionScheduler {
	mut obj := &Class_ActionScheduler_RecurringActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'schedule_recurring_scheduler_hook' {
			this.schedule_recurring_scheduler_hook()
			return rt.new_null()
		}
		'run_recurring_scheduler_hook' {
			this.run_recurring_scheduler_hook()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_RecurringActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_RecurringActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
