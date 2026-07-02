import rt

struct Class_ActionScheduler_ActionFactory {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_ActionFactory) get_stored_action(var_status rt.PhpVal, var_hook rt.PhpVal, mut var_args Class_array, mut var_schedule Class_?ActionScheduler_Schedule, group string) rt.PhpVal {
	mut var_schedule_mutated := var_schedule
	mut var_priority := rt.new_int(if rt.is_true(rt.greater_equal(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(6))) { rt.new_int((rt.call_function('func_get_arg', [rt.new_int(5)])).to_i64()) } else { 10 })
	mut switch_val_1 := var_status
	if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_Store.status_pending())) {
	mut var_action_class := rt.new_string('ActionScheduler_Action')
	} else if rt.is_true(rt.equal(switch_val_1, Class_ActionScheduler_Store.status_canceled())) {
		var_action_class = rt.new_string('ActionScheduler_CanceledAction')
		if !(var_schedule_mutated.is_null()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_schedule_mutated, rt.new_string('ActionScheduler_CanceledSchedule')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_schedule_mutated, rt.new_string('ActionScheduler_NullSchedule')]))))) {
		var_schedule_mutated = create_actionscheduler_canceledschedule(rt.call_method(var_schedule_mutated, 'get_date', []rt.PhpVal{}))
		}
	} else {
	var_action_class = rt.new_string('ActionScheduler_FinishedAction')
	}
	var_action_class = rt.call_function('apply_filters', [rt.new_string('action_scheduler_stored_action_class'), var_action_class.clone(), var_status.clone(), var_hook.clone(), var_args, var_schedule_mutated, rt.new_string(group)])
	mut var_action := rt.create_object_dynamically(var_action_class, [var_hook.clone(), var_args, var_schedule_mutated, rt.new_string(group)])
	rt.call_method(var_action, 'set_priority', [var_priority.clone()])
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_stored_action_instance'), var_action.clone(), var_hook.clone(), var_args, var_schedule_mutated, rt.new_string(group), var_priority.clone()])
}

fn (mut this Class_ActionScheduler_ActionFactory) async(var_hook rt.PhpVal, var_args rt.PhpVal, group string) rt.PhpVal {
	return this.async_unique(var_hook.clone(), var_args.clone(), group, false)
}

fn (mut this Class_ActionScheduler_ActionFactory) async_unique(var_hook rt.PhpVal, var_args rt.PhpVal, group string, unique bool) rt.PhpVal {
	mut var_schedule := create_actionscheduler_nullschedule()
	mut var_action := create_actionscheduler_action(var_hook.clone(), var_args.clone(), var_schedule.clone(), rt.new_string(group))
	return if var_unique { this.store_unique_action(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action), rt.new_bool(unique)) } else { this.store(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) }
}

fn (mut this Class_ActionScheduler_ActionFactory) single(var_hook rt.PhpVal, var_args rt.PhpVal, var_when rt.PhpVal, group string) rt.PhpVal {
	return this.single_unique(var_hook.clone(), var_args.clone(), var_when.clone(), group, false)
}

fn (mut this Class_ActionScheduler_ActionFactory) single_unique(var_hook rt.PhpVal, var_args rt.PhpVal, var_when rt.PhpVal, group string, unique bool) rt.PhpVal {
	mut var_date := rt.call_function('as_get_datetime_object', [var_when.clone()])
	mut var_schedule := create_actionscheduler_simpleschedule(var_date.clone())
	mut var_action := create_actionscheduler_action(var_hook.clone(), var_args.clone(), var_schedule.clone(), rt.new_string(group))
	return if var_unique { this.store_unique_action(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) } else { this.store(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) }
}

fn (mut this Class_ActionScheduler_ActionFactory) recurring(var_hook rt.PhpVal, var_args rt.PhpVal, var_first rt.PhpVal, var_interval rt.PhpVal, group string) rt.PhpVal {
	return this.recurring_unique(var_hook.clone(), var_args.clone(), var_first.clone(), var_interval.clone(), group, false)
}

fn (mut this Class_ActionScheduler_ActionFactory) recurring_unique(var_hook rt.PhpVal, var_args rt.PhpVal, var_first rt.PhpVal, var_interval rt.PhpVal, group string, unique bool) rt.PhpVal {
	if !rt.is_true(var_interval) {
		return this.single_unique(var_hook.clone(), var_args.clone(), var_first.clone(), group, unique)
	}
	mut var_date := rt.call_function('as_get_datetime_object', [var_first.clone()])
	mut var_schedule := create_actionscheduler_intervalschedule(var_date.clone(), var_interval.clone())
	mut var_action := create_actionscheduler_action(var_hook.clone(), var_args.clone(), var_schedule.clone(), rt.new_string(group))
	return if var_unique { this.store_unique_action(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) } else { this.store(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) }
}

fn (mut this Class_ActionScheduler_ActionFactory) cron(var_hook rt.PhpVal, var_args rt.PhpVal, var_base_timestamp rt.PhpVal, var_schedule rt.PhpVal, group string) rt.PhpVal {
	mut var_schedule_mutated := var_schedule
	return this.cron_unique(var_hook.clone(), var_args.clone(), var_base_timestamp.clone(), var_schedule_mutated.clone(), group, false)
}

fn (mut this Class_ActionScheduler_ActionFactory) cron_unique(var_hook rt.PhpVal, var_args rt.PhpVal, var_base_timestamp rt.PhpVal, var_schedule rt.PhpVal, group string, unique bool) rt.PhpVal {
	mut var_schedule_mutated := var_schedule
	if !rt.is_true(var_schedule_mutated) {
		return this.single_unique(var_hook.clone(), var_args.clone(), var_base_timestamp.clone(), group, unique)
	}
	mut var_date := rt.call_function('as_get_datetime_object', [var_base_timestamp.clone()])
	mut iife_temp_0 := Class_CronExpression{}
	mut iife_result_0 := iife_temp_0.factory(var_schedule_mutated.clone())
	mut var_cron := iife_result_0
	var_schedule_mutated = create_actionscheduler_cronschedule(var_date.clone(), var_cron.clone())
	mut var_action := create_actionscheduler_action(var_hook.clone(), var_args.clone(), var_schedule_mutated.clone(), rt.new_string(group))
	return if var_unique { this.store_unique_action(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) } else { this.store(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) }
}

fn (mut this Class_ActionScheduler_ActionFactory) repeat(var_action rt.PhpVal) rt.PhpVal {
	mut var_action_mutated := var_action
	mut var_schedule := rt.call_method(var_action_mutated, 'get_schedule', []rt.PhpVal{})
	mut var_next := rt.call_method(var_schedule, 'get_next', [rt.call_function('as_get_datetime_object', []rt.PhpVal{})])
	if var_next.clone().is_null() || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_schedule, 'is_recurring', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('Invalid action - must be a recurring action.'), rt.new_string('woocommerce')]))))
	}
	mut var_schedule_class := rt.call_function('get_class', [var_schedule.clone()])
	mut var_new_schedule := rt.create_object_dynamically(var_schedule, [var_next.clone(), rt.call_method(var_schedule, 'get_recurrence', []rt.PhpVal{}), rt.call_method(var_schedule, 'get_first_date', []rt.PhpVal{})])
	mut var_new_action := create_actionscheduler_action(rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{}), rt.call_method(var_action_mutated, 'get_args', []rt.PhpVal{}), var_new_schedule.clone(), rt.call_method(var_action_mutated, 'get_group', []rt.PhpVal{}))
	var_new_action.set_priority(rt.call_method(var_action_mutated, 'get_priority', []rt.PhpVal{}))
	return this.store(mut var_new_action)
}

fn (mut this Class_ActionScheduler_ActionFactory) create(mut var_options Class_array) i64 {
	mut var_options_mutated := var_options
	mut var_defaults := { 'type': rt.new_string('single'), 'hook': rt.new_string(''), 'arguments': map[string]rt.PhpVal{}, 'group': rt.new_string(''), 'unique': rt.new_bool(false), 'when': rt.call_function('time', []rt.PhpVal{}), 'pattern': rt.new_null(), 'priority': rt.new_int(10) }
	var_options_mutated = rt.call_function('array_merge', [rt.create_array_from_native_map(var_defaults), var_options_mutated])
	if rt.is_true(rt.identical(rt.new_string('cron'), var_options_mutated.array_get(rt.new_string('type')))) || rt.is_true(rt.identical(rt.new_string('recurring'), var_options_mutated.array_get(rt.new_string('type')))) && !rt.is_true(var_options_mutated.array_get(rt.new_string('pattern'))) {
		var_options_mutated.array_set('type', 'single')
	}
	mut switch_val_2 := var_options_mutated.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('async'))) {
	mut var_schedule := create_actionscheduler_nullschedule()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('cron'))) {
	mut var_date := rt.call_function('as_get_datetime_object', [var_options_mutated.array_get(rt.new_string('when'))])
	mut iife_temp_1 := Class_CronExpression{}
	mut iife_result_1 := iife_temp_1.factory(var_options_mutated.array_get(rt.new_string('pattern')))
	mut var_cron := iife_result_1
	var_schedule = create_actionscheduler_cronschedule(var_date.clone(), var_cron.clone())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('recurring'))) {
	var_date = rt.call_function('as_get_datetime_object', [var_options_mutated.array_get(rt.new_string('when'))])
	var_schedule = create_actionscheduler_intervalschedule(var_date.clone(), var_options_mutated.array_get(rt.new_string('pattern')))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('single'))) {
	var_date = rt.call_function('as_get_datetime_object', [var_options_mutated.array_get(rt.new_string('when'))])
	var_schedule = create_actionscheduler_simpleschedule(var_date.clone())
	} else {
		rt.call_function('error_log', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Unknown action type \''), var_options_mutated.array_get(rt.new_string('type'))), rt.new_string('\' specified when trying to create an action for \'')), var_options_mutated.array_get(rt.new_string('hook'))), rt.new_string('\'.'))])
		return 0
	}
	mut var_action := create_actionscheduler_action(var_options_mutated.array_get(rt.new_string('hook')), var_options_mutated.array_get(rt.new_string('arguments')), var_schedule.clone(), var_options_mutated.array_get(rt.new_string('group')))
	rt.call_method(var_action, 'set_priority', [var_options_mutated.array_get(rt.new_string('priority'))])
	mut var_action_id := rt.new_int(0)
	var_action_id = if rt.is_true(var_options_mutated.array_get(rt.new_string('unique'))) { this.store_unique_action(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) } else { this.store(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action)) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('error_log', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Caught exception while enqueuing action "%1$s": %2$s'), rt.new_string('woocommerce')]), var_options_mutated.array_get(rt.new_string('hook')), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (var_action_id).to_i64()
}

fn (mut this Class_ActionScheduler_ActionFactory) store(mut var_action Class_ActionScheduler_Action) rt.PhpVal {
	mut var_action_mutated := var_action
	mut iife_temp_2 := Class_ActionScheduler_Store{}
	mut iife_result_2 := iife_temp_2.instance()
	mut var_store := iife_result_2
	return rt.call_method(var_store, 'save_action', [var_action_mutated])
}

fn (mut this Class_ActionScheduler_ActionFactory) store_unique_action(mut var_action Class_ActionScheduler_Action) i64 {
	mut var_action_mutated := var_action
	mut iife_temp_3 := Class_ActionScheduler_Store{}
	mut iife_result_3 := iife_temp_3.instance()
	mut var_store := iife_result_3
	if rt.is_true(rt.call_function('method_exists', [var_store.clone(), rt.new_string('save_unique_action')])) {
		return (rt.call_method(var_store, 'save_unique_action', [var_action_mutated])).to_i64()
	} else {
		mut var_existing_action_id := rt.new_int((rt.call_method(var_store, 'find_action', [rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.call_method(var_action_mutated, 'get_args', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: Class_ActionScheduler_Store.status_pending() }, rt.ArrayItem{ key: 'group', val: rt.call_method(var_action_mutated, 'get_group', []rt.PhpVal{}) }])])).to_i64())
		if rt.is_true(rt.greater(var_existing_action_id, rt.new_int(0))) {
			return 0
		}
		return (rt.call_method(var_store, 'save_action', [var_action_mutated])).to_i64()
	}
	return i64(0)
}

struct Class_ActionScheduler_CanceledSchedule {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_NullSchedule {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Action {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_SimpleSchedule {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_IntervalSchedule {
	rt.PhpObjectBase
}

struct Class_CronExpression {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_CronSchedule {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

fn create_actionscheduler_actionfactory(_args ...rt.PhpVal) &Class_ActionScheduler_ActionFactory {
	mut obj := &Class_ActionScheduler_ActionFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_canceledschedule(_args ...rt.PhpVal) &Class_ActionScheduler_CanceledSchedule {
	mut obj := &Class_ActionScheduler_CanceledSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_nullschedule(_args ...rt.PhpVal) &Class_ActionScheduler_NullSchedule {
	mut obj := &Class_ActionScheduler_NullSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_action(_args ...rt.PhpVal) &Class_ActionScheduler_Action {
	mut obj := &Class_ActionScheduler_Action{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_simpleschedule(_args ...rt.PhpVal) &Class_ActionScheduler_SimpleSchedule {
	mut obj := &Class_ActionScheduler_SimpleSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_intervalschedule(_args ...rt.PhpVal) &Class_ActionScheduler_IntervalSchedule {
	mut obj := &Class_ActionScheduler_IntervalSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression(_args ...rt.PhpVal) &Class_CronExpression {
	mut obj := &Class_CronExpression{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_cronschedule(_args ...rt.PhpVal) &Class_ActionScheduler_CronSchedule {
	mut obj := &Class_ActionScheduler_CronSchedule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store(_args ...rt.PhpVal) &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_ActionFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_stored_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_?ActionScheduler_Schedule](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.get_stored_action(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4)
		}
		'async' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.async(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'async_unique' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.async_unique(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'single' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.single(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'single_unique' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			return this.single_unique(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'recurring' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.recurring(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'recurring_unique' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			return this.recurring_unique(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'cron' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.cron(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'cron_unique' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			return this.cron_unique(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'repeat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.repeat(dispatch_arg_0)
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.create(mut dispatch_arg_0))
		}
		'store' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.store(mut dispatch_arg_0)
		}
		'store_unique_action' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.store_unique_action(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_ActionFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_ActionFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_CanceledSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_CanceledSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_CanceledSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_NullSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_NullSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Action) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Action) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Action) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_ActionScheduler_IntervalSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_IntervalSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_IntervalSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ActionScheduler_CronSchedule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_CronSchedule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_CronSchedule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('ActionScheduler_ActionFactory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_actionfactory()
		return rt.new_object('ActionScheduler_ActionFactory', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_CanceledSchedule', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_canceledschedule()
		return rt.new_object('ActionScheduler_CanceledSchedule', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_NullSchedule', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_nullschedule()
		return rt.new_object('ActionScheduler_NullSchedule', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_Action', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_action()
		return rt.new_object('ActionScheduler_Action', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_SimpleSchedule', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_simpleschedule()
		return rt.new_object('ActionScheduler_SimpleSchedule', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_IntervalSchedule', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_intervalschedule()
		return rt.new_object('ActionScheduler_IntervalSchedule', []string{}, obj)
	})
	rt.register_class_factory('CronExpression', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_cronexpression()
		return rt.new_object('CronExpression', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_CronSchedule', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_cronschedule()
		return rt.new_object('ActionScheduler_CronSchedule', []string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
	rt.register_class_factory('ActionScheduler_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_store()
		return rt.new_object('ActionScheduler_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
