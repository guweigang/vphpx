import rt

struct Class_Action_Scheduler_WP_CLI_Action_Cancel_Command {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) execute() {
	mut var_hook := rt.new_string(rt.new_string(''))
	mut var_group := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Cancel_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('group'),
		rt.new_string(''),
	])
	mut var_callback_args := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Cancel_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('args'),
		rt.new_null(),
	])
	mut var_all := rt.call_function('get_flag_value', [
		rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Cancel_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'assoc_args'),
		rt.new_string('all'),
		rt.new_bool(false),
	])
	if !(!rt.is_true(rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Cancel_Command', [
		'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
	], &this), 'args').array_get(0))) {
		var_hook = rt.get_property(rt.new_object('Action_Scheduler_WP_CLI_Action_Cancel_Command', [
			'Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command',
		], &this), 'args').array_get(0)
	}
	if !(!rt.is_true(var_callback_args)) {
		var_callback_args = rt.call_function('json_decode', [
			var_callback_args.dup(), rt.new_bool(true)])
	}
	if rt.is_true(var_all) {
		this.cancel_all(var_hook.dup(), var_callback_args.dup(), var_group.dup())
		return rt.new_null()
	}
	this.cancel_single(var_hook.dup(), var_callback_args.dup(), var_group.dup())
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) cancel_single(var_hook rt.PhpVal, var_callback_args rt.PhpVal, var_group rt.PhpVal) {
	mut var_hook_mutated := var_hook
	mut var_callback_args_mutated := var_callback_args
	mut var_group_mutated := var_group
	if !rt.is_true(var_hook_mutated) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
			return temp.error(arg_0)
		}(rt.call_function('__', [
			rt.new_string('Please specify hook of action to cancel.'),
			rt.new_string('woocommerce'),
		]))
	}
	mut var_result := rt.call_function('as_unschedule_action', [
		var_hook_mutated.dup(), var_callback_args_mutated.dup(),
		var_group_mutated.dup()])
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
		this.print_error(mut var_e, rt.new_bool(false))
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
	if rt.is_true(rt.identical(rt.new_null(), var_result)) {
		var_e = create_action_scheduler_wp_cli_action_exception(rt.call_function('__', [
			rt.new_string('Unable to cancel scheduled action: check the logs.'),
			rt.new_string('woocommerce'),
		]))
		this.print_error(mut var_e, rt.new_bool(false))
	}
	this.print_success(rt.new_bool(false))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) cancel_all(var_hook rt.PhpVal, var_callback_args rt.PhpVal, var_group rt.PhpVal) {
	mut var_multiple := rt.new_null()
	mut var_hook_mutated := var_hook
	mut var_callback_args_mutated := var_callback_args
	mut var_group_mutated := var_group
	if !rt.is_true(var_hook_mutated) && !rt.is_true(var_group_mutated) {
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
			return temp.error(arg_0)
		}(rt.call_function('__', [
			rt.new_string('Please specify hook and/or group of actions to cancel.'),
			rt.new_string('woocommerce'),
		]))
	}
	mut var_result := rt.call_function('as_unschedule_all_actions', [
		var_hook_mutated.dup(), var_callback_args_mutated.dup(),
		var_group_mutated.dup()])
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
		this.print_error(mut var_e, var_multiple.dup())
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
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.success(arg_0)
	}(rt.call_function('__', [
		rt.new_string('Request to cancel scheduled actions completed.'),
		rt.new_string('woocommerce'),
	]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) print_success() {
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.success(arg_0)
	}(rt.call_function('__', [rt.new_string('Scheduled action cancelled.'),
		rt.new_string('woocommerce')]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) print_error(mut var_e Class_Action_Scheduler_WP_CLI_Action_Exception, var_multiple rt.PhpVal) {
	mut var_e_mutated := var_e
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
		return temp.error(arg_0)
	}(rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('There was an error cancelling the %1$s: %2$s'),
			rt.new_string('woocommerce'),
		]),
		if rt.is_true(var_multiple) { rt.call_function('__', [
				rt.new_string('scheduled actions'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_function('__', [
				rt.new_string('scheduled action'),
				rt.new_string('woocommerce'),
			]) },
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

fn create_action_scheduler_wp_cli_action_cancel_command() &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command{
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

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'cancel_single' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.cancel_single(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'cancel_all' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.cancel_all(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'print_success' {
			this.print_success()
			return rt.new_null()
		}
		'print_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.print_error(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Cancel_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_action_cancel_command_php() {
}
