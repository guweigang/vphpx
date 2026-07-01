import rt

pub fn Class_Action_Scheduler_WP_CLI_Action_Create_Command.async_opts() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'async' },
		rt.ArrayItem{ key: none, val: 0 }])
}

struct Class_Action_Scheduler_WP_CLI_Action_Create_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) execute() {
	mut var_hook := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'args').array_get(0)
	mut var_schedule_start := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'args').array_get(1)
	mut var_callback_args := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('args'),
		rt.new_array(),
	])
	mut var_group := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('group'),
		rt.new_string(''),
	])
	mut var_interval := rt.call_function('absint', [
		rt.call_function('get_flag_value', [
			rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
				'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
			], &this), 'assoc_args'),
			rt.new_string('interval'),
			rt.new_int(0),
		]),
	])
	mut var_cron := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('cron'),
		rt.new_string(''),
	])
	mut var_unique := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('unique'),
		rt.new_bool(false),
	])
	mut var_priority := rt.call_function('absint', [
		rt.call_function('get_flag_value', [
			rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Create_Command', [
				'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
			], &this), 'assoc_args'),
			rt.new_string('priority'),
			rt.new_int(10),
		]),
	])
	if !(!rt.is_true(var_callback_args)) {
		var_callback_args = rt.call_function('json_decode', [
			var_callback_args.dup(), rt.new_bool(true)])
	}
	mut var_function_args := rt.create_array([
		rt.ArrayItem{ key: 'start', val: var_schedule_start },
		rt.ArrayItem{ key: 'cron', val: var_cron },
		rt.ArrayItem{ key: 'interval', val: var_interval },
		rt.ArrayItem{ key: 'hook', val: var_hook },
		rt.ArrayItem{ key: 'callback_args', val: var_callback_args },
		rt.ArrayItem{ key: 'group', val: var_group },
		rt.ArrayItem{ key: 'unique', val: var_unique },
		rt.ArrayItem{ key: 'priority', val: var_priority },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_schedule_start.dup(), Class_Action_Scheduler_WP_CLI_Action_static.async_opts(),
		rt.new_bool(true)])))))
	{
		var_schedule_start = rt.call_function('as_get_datetime_object', [
			var_schedule_start.dup()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_function_args.array_set('start', rt.call_method(var_schedule_start, 'format', [
			rt.new_string('U'),
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Action_Scheduler_WP_CLI_Action_Exception') {
		mut var_e := var_e_1.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
			return temp.error(arg_0)
		}(var_e.getmessage())
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut var_action_type := rt.new_string(rt.new_string('single'))
	mut var_function := rt.new_string(rt.new_string('as_schedule_single_action'))
	if !(!rt.is_true(var_interval)) {
		var_action_type = rt.new_string(rt.new_string('recurring'))
		var_function = rt.new_string(rt.new_string('as_schedule_recurring_action'))
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('in_array', [var_key.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'start' },
					rt.ArrayItem{ key: none, val: 'interval' },
					rt.ArrayItem{ key: none, val: 'hook' }, rt.ArrayItem{
						key: none
						val: 'callback_args'
					}, rt.ArrayItem{ key: none, val: 'group' },
					rt.ArrayItem{ key: none, val: 'unique' },
					rt.ArrayItem{ key: none, val: 'priority' }]),
				rt.new_bool(true)])
		}
		var_function_args = rt.call_function('array_filter', [
			var_function_args.dup(), rt.new_closure(closure_1_fn),
			rt.get_constant('ARRAY_FILTER_USE_KEY')])
	} else if !(!rt.is_true(var_cron)) {
		var_action_type = rt.new_string(rt.new_string('cron'))
		var_function = rt.new_string(rt.new_string('as_schedule_cron_action'))
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('in_array', [var_key.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'start' },
					rt.ArrayItem{ key: none, val: 'cron' }, rt.ArrayItem{ key: none, val: 'hook' },
					rt.ArrayItem{ key: none, val: 'callback_args' },
					rt.ArrayItem{ key: none, val: 'group' }, rt.ArrayItem{ key: none, val: 'unique' },
					rt.ArrayItem{ key: none, val: 'priority' }]),
				rt.new_bool(true)])
		}
		var_function_args = rt.call_function('array_filter', [
			var_function_args.dup(), rt.new_closure(closure_2_fn),
			rt.get_constant('ARRAY_FILTER_USE_KEY')])
	} else if rt.is_true(rt.call_function('in_array', [var_function_args.array_get('start'),
		Class_Action_Scheduler_WP_CLI_Action_static.async_opts(),
		rt.new_bool(true)]))
	{
		var_action_type = rt.new_string(rt.new_string('async'))
		var_function = rt.new_string(rt.new_string('as_enqueue_async_action'))
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('in_array', [var_key.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'hook' },
					rt.ArrayItem{ key: none, val: 'callback_args' },
					rt.ArrayItem{ key: none, val: 'group' }, rt.ArrayItem{ key: none, val: 'unique' },
					rt.ArrayItem{ key: none, val: 'priority' }]),
				rt.new_bool(true)])
		}
		var_function_args = rt.call_function('array_filter', [
			var_function_args.dup(), rt.new_closure(closure_3_fn),
			rt.get_constant('ARRAY_FILTER_USE_KEY')])
	} else {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('in_array', [var_key.dup(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'start' },
					rt.ArrayItem{ key: none, val: 'hook' }, rt.ArrayItem{
						key: none
						val: 'callback_args'
					}, rt.ArrayItem{ key: none, val: 'group' },
					rt.ArrayItem{ key: none, val: 'unique' },
					rt.ArrayItem{ key: none, val: 'priority' }]),
				rt.new_bool(true)])
		}
		var_function_args = rt.call_function('array_filter', [
			var_function_args.dup(), rt.new_closure(closure_4_fn),
			rt.get_constant('ARRAY_FILTER_USE_KEY')])
	}
	var_function_args = rt.call_function('array_values', [var_function_args.dup()])
	mut var_action_id := rt.call_function('call_user_func_array', [
		var_function.dup(), var_function_args.dup()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Action_Scheduler_WP_CLI_Action_Exception') {
		mut var_e := var_e_2.dup()
		this.print_error(mut var_e)
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	if rt.is_true(rt.identical(rt.new_int(0), var_action_id)) {
		var_e = create_action_scheduler_wp_cli_action_exception(rt.call_function('__', [
			rt.new_string('Unable to create a scheduled action.'),
			rt.new_string('woocommerce'),
		]))
		this.print_error(mut var_e)
	}
	this.print_success(var_action_id.dup(), var_action_type.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) print_success(var_action_id rt.PhpVal, var_action_type rt.PhpVal) {
	mut var_action_id_mutated := var_action_id
	mut var_action_type_mutated := var_action_type
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.success(arg_0)
	}(rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s action (%2$d) scheduled.'),
			rt.new_string('woocommerce')]),
		rt.call_function('ucfirst', [var_action_type_mutated.dup()]),
		var_action_id_mutated.dup(),
	]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) print_error(mut var_e Class_Action_Scheduler_WP_CLI_Action_Exception) {
	mut var_e_mutated := var_e
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.error(arg_0)
	}(rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('There was an error creating the scheduled action: %s'),
			rt.new_string('woocommerce'),
		]),
		var_e_mutated.getmessage(),
	]))
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_Exception {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_create_command() &Class_Action_Scheduler_WP_CLI_Action_Create_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Create_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command() &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_wp_cli() &Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_exception() &Class_Action_Scheduler_WP_CLI_Action_Exception {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'print_success' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.print_success(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'print_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.print_error(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Create_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_action_create_command_php() {
}
