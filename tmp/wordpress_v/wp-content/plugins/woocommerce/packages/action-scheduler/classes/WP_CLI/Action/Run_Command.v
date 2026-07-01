import rt

struct Class_Action_Scheduler_WP_CLI_Action_Run_Command {
	rt.PhpObjectBase
pub mut:
		action_ids rt.PhpVal = rt.new_array()
		action_counts rt.PhpVal = rt.new_array()
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) construct(mut var_args Class_Action_Scheduler_WP_CLI_Action_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_Action_array)  {
	this.Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command.construct(rt.new_object('Action_Scheduler_WP_CLI_Action_array', []string{}, var_args), rt.new_object('Action_Scheduler_WP_CLI_Action_array', []string{}, var_assoc_args))
	this.action_ids = rt.call_function('array_map', [rt.new_string('absint'), var_args])
	this.action_counts.array_set('total', this.action_ids.array_count())
	rt.call_function('add_action', [rt.new_string('action_scheduler_execution_ignored'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Action_Run_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this) }, rt.ArrayItem{ key: none, val: 'on_action_ignored' }])])
	rt.call_function('add_action', [rt.new_string('action_scheduler_after_execute'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Action_Run_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this) }, rt.ArrayItem{ key: none, val: 'on_action_executed' }])])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_execution'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Action_Run_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this) }, rt.ArrayItem{ key: none, val: 'on_action_failed' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_validation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Action_Run_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this) }, rt.ArrayItem{ key: none, val: 'on_action_invalid' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) execute()  {
	mut var_runner := fn () rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}; return temp.runner() }()
	mut var_progress_bar := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Executing %d action'), rt.new_string('Executing %d actions'), this.action_counts.array_get('total'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [this.action_counts.array_get('total')])]), this.action_counts.array_get('total')])
	{
		mut iter_1 := this.action_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			rt.call_method(var_runner, 'process_action', [var_action_id.dup(), rt.new_string('Action Scheduler CLI')])
			rt.call_method(var_progress_bar, 'tick', []rt.PhpVal{})
		}
	}
	rt.call_method(var_progress_bar, 'finish', []rt.PhpVal{})
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'ignored' }, rt.ArrayItem{ key: none, val: 'invalid' }, rt.ArrayItem{ key: none, val: 'failed' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut var_count := this.action_counts.array_get(var_type)
			if !rt.is_true(var_count) {
				continue
			}
			mut var_format := rt.call_function('_n', [rt.new_string('%1$d action %2$s.'), rt.new_string('%1$d actions %2$s.'), var_count.dup(), rt.new_string('woocommerce')])
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('sprintf', [var_format.dup(), rt.call_function('number_format_i18n', [var_count.dup()]), var_type.dup()]))
		}
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Executed %d action.'), rt.new_string('Executed %d actions.'), this.action_counts.array_get('executed'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [this.action_counts.array_get('executed')])]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) on_action_ignored(var_action_id rt.PhpVal)  {
	mut var_action_id_mutated := var_action_id
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	var_action_id_mutated = rt.call_function('absint', [var_action_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id_mutated.dup(), this.action_ids, rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	rt.post_inc(this.action_counts.array_get('ignored'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.new_string('Action %d was ignored.'), var_action_id_mutated.dup()]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) on_action_executed(var_action_id rt.PhpVal)  {
	mut var_action_id_mutated := var_action_id
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	var_action_id_mutated = rt.call_function('absint', [var_action_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id_mutated.dup(), this.action_ids, rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	rt.post_inc(this.action_counts.array_get('executed'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.new_string('Action %d was executed.'), var_action_id_mutated.dup()]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) on_action_failed(var_action_id rt.PhpVal, mut var_e Class_Action_Scheduler_WP_CLI_Action_Exception)  {
	mut var_action_id_mutated := var_action_id
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	var_action_id_mutated = rt.call_function('absint', [var_action_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id_mutated.dup(), this.action_ids, rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	rt.post_inc(this.action_counts.array_get('failed'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.new_string('Action %d failed execution: %s'), var_action_id_mutated.dup(), var_e.getmessage()]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) on_action_invalid(var_action_id rt.PhpVal, mut var_e Class_Action_Scheduler_WP_CLI_Action_Exception)  {
	mut var_action_id_mutated := var_action_id
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	var_action_id_mutated = rt.call_function('absint', [var_action_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id_mutated.dup(), this.action_ids, rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	rt.post_inc(this.action_counts.array_get('invalid'))
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.new_string('Action %d failed validation: %s'), var_action_id_mutated.dup(), var_e.getmessage()]))
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_Action_WP_CLI {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_action_run_command(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_Run_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Run_Command{
		PhpObjectBase: rt.PhpObjectBase{}
		action_ids: rt.new_array()
		action_counts: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command() &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler() &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{
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

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'on_action_ignored' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_action_ignored(dispatch_arg_0)
			return rt.new_null()
		}
		'on_action_executed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_action_executed(dispatch_arg_0)
			return rt.new_null()
		}
		'on_action_failed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](if args.len > 1 { args[1] } else { rt.new_null() })
			this.on_action_failed(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'on_action_invalid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_Action_Exception](if args.len > 1 { args[1] } else { rt.new_null() })
			this.on_action_invalid(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'action_ids' { return this.action_ids }
		'action_counts' { return this.action_counts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Run_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'action_ids' { this.action_ids = val; return true }
		'action_counts' { this.action_counts = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_wp_cli_action_run_command_php() {
}
