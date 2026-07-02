import rt

struct Class_Action_Scheduler_WP_CLI_Action_Generate_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) execute() {
	mut var_hook := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'args').array_get(rt.new_int(0))
	mut var_schedule_start := rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'args').array_get(rt.new_int(1))
	mut var_callback_args := rt.call_function('get_flag_value', [rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), rt.new_string('args'), rt.new_array()])
	mut var_group := rt.call_function('get_flag_value', [rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), rt.new_string('group'), rt.new_string('')])
	mut var_interval := rt.new_int((rt.call_function('get_flag_value', [rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), rt.new_string('interval'), rt.new_int(0)])).to_i64())
	mut var_count := rt.call_function('absint', [rt.call_function('get_flag_value', [rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Generate_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this), 'assoc_args'), rt.new_string('count'), rt.new_int(1)])])
	if !(!rt.is_true(var_callback_args)) {
	var_callback_args = rt.call_function('json_decode', [var_callback_args.clone(), rt.new_bool(true)])
	}
	var_schedule_start = rt.call_function('as_get_datetime_object', [var_schedule_start.clone()])
	mut var_function_args := rt.create_array([rt.ArrayItem{ key: 'start', val: rt.call_function('absint', [rt.call_method(var_schedule_start, 'format', [rt.new_string('U')])]) }, rt.ArrayItem{ key: 'interval', val: var_interval }, rt.ArrayItem{ key: 'count', val: var_count }, rt.ArrayItem{ key: 'hook', val: var_hook }, rt.ArrayItem{ key: 'callback_args', val: var_callback_args }, rt.ArrayItem{ key: 'group', val: var_group }])
	var_function_args = rt.call_function('array_values', [var_function_args.clone()])
	mut var_actions_added := this.generate(var_function_args.clone(), rt.new_null(), rt.new_null(), rt.new_null(), rt.new_null(), '')
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Action_Scheduler_WP_CLI_Action_Exception') {
		mut var_e := var_e_1.clone()
		this.print_error(mut rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](var_e))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_num_actions_added := rt.new_int(rt.cast_array(var_actions_added).array_count())
	this.print_success(var_num_actions_added.clone(), rt.new_string('single'))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) generate(var_schedule_start rt.PhpVal, var_interval rt.PhpVal, var_count rt.PhpVal, var_hook rt.PhpVal, mut var_args Class_Action_Scheduler_WP_CLI_Action_array, group string) rt.PhpVal {
	mut var_schedule_start_mutated := var_schedule_start
	mut var_interval_mutated := var_interval
	mut var_count_mutated := var_count
	mut var_hook_mutated := var_hook
	mut group_mutated := group
	mut var_actions_added := rt.new_array()
	mut var_progress_bar := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Creating %d action'), rt.new_string('Creating %d actions'), var_count_mutated.clone(), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [var_count_mutated.clone()])]), var_count_mutated.clone()])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_count_mutated))) { break }
		var_actions_added.array_push(rt.call_function('as_schedule_single_action', [rt.add(var_schedule_start_mutated, rt.mul(var_i, var_interval_mutated)), var_hook_mutated.clone(), var_args, rt.new_string(group_mutated).clone()]))
		rt.call_method(var_progress_bar, 'tick', []rt.PhpVal{})
		rt.post_inc(var_i)
	}
	rt.call_method(var_progress_bar, 'finish', []rt.PhpVal{})
	return var_actions_added.clone()
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) print_success(var_actions_added rt.PhpVal, var_action_type rt.PhpVal) {
	mut var_actions_added_mutated := var_actions_added
mut iife_temp_0 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
mut iife_result_0 := iife_temp_0.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d %2$s action scheduled.'), rt.new_string('%1$d %2$s actions scheduled.'), var_actions_added_mutated.clone(), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [var_actions_added_mutated.clone()]), var_action_type.clone()]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) print_error(mut var_e Class_Action_Scheduler_WP_CLI_Action_Exception) {
mut iife_temp_1 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
mut iife_result_1 := iife_temp_1.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was an error creating the scheduled action: %s'), rt.new_string('woocommerce')]), var_e.getmessage()]))
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_generate_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_Generate_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Generate_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_wp_cli(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'generate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_array](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return this.generate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5)
		}
		'print_success' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.print_success(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'print_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			this.print_error(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Generate_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
