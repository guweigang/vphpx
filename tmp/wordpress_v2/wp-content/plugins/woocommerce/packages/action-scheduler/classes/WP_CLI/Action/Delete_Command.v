import rt

struct Class_Action_Scheduler_WP_CLI_Action_Delete_Command {
	rt.PhpObjectBase
pub mut:
		action_ids rt.PhpVal = rt.new_array()
		action_counts rt.PhpVal = rt.new_array()
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) construct(mut var_args Class_Action_Scheduler_WP_CLI_Action_array, mut var_assoc_args Class_Action_Scheduler_WP_CLI_Action_array) {
	this.Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command.construct(rt.new_object('Action_Scheduler_WP_CLI_Action_array', []string{}, var_args), rt.new_object('Action_Scheduler_WP_CLI_Action_array', []string{}, var_assoc_args))
	this.action_ids = rt.call_function('array_map', [rt.new_string('absint'), var_args])
	this.action_counts.array_set('total', this.action_ids.array_count())
	rt.call_function('add_action', [rt.new_string('action_scheduler_deleted_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Action_Delete_Command', ['Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command'], &this) }, rt.ArrayItem{ key: none, val: 'on_action_deleted' }])])
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) execute() {
	mut iife_temp_0 := Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{}
	mut iife_result_0 := iife_temp_0.store()
	mut var_store := iife_result_0
	mut var_progress_bar := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Deleting %d action'), rt.new_string('Deleting %d actions'), this.action_counts.array_get(rt.new_string('total')), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [this.action_counts.array_get(rt.new_string('total'))])]), this.action_counts.array_get(rt.new_string('total'))])
	mut iter_1 := this.action_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action_id := item_1.val
		rt.call_method(var_store, 'delete_action', [var_action_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Action_Scheduler_WP_CLI_Action_Exception') {
			mut var_e := var_e_1.clone()
			rt.post_inc(this.action_counts.array_get(rt.new_string('failed')))
			mut iife_temp_1 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
			mut iife_result_1 := iife_temp_1.warning(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		rt.call_method(var_progress_bar, 'tick', []rt.PhpVal{})
	}
	rt.call_method(var_progress_bar, 'finish', []rt.PhpVal{})
	mut var_format := rt.new_string((rt.call_function('_n', [rt.new_string('Deleted %1$d action'), rt.new_string('Deleted %1$d actions'), this.action_counts.array_get(rt.new_string('deleted')), rt.new_string('woocommerce')])).str() + ', ')
	var_format = rt.concat(var_format, rt.call_function('_n', [rt.new_string('%2$d failure.'), rt.new_string('%2$d failures.'), this.action_counts.array_get(rt.new_string('failed')), rt.new_string('woocommerce')]))
mut iife_temp_2 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
mut iife_result_2 := iife_temp_2.success(rt.call_function('sprintf', [var_format.clone(), rt.call_function('number_format_i18n', [this.action_counts.array_get(rt.new_string('deleted'))]), rt.call_function('number_format_i18n', [this.action_counts.array_get(rt.new_string('failed'))])]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) on_action_deleted(var_action_id rt.PhpVal) {
	mut var_action_id_mutated := var_action_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('action_scheduler_deleted_action'), rt.call_function('current_action', []rt.PhpVal{}))))) {
		return
	}
	var_action_id_mutated = rt.call_function('absint', [var_action_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_action_id_mutated.clone(), this.action_ids, rt.new_bool(true)]))))) {
		return
	}
	rt.post_inc(this.action_counts.array_get(rt.new_string('deleted')))
mut iife_temp_3 := Class_Action_Scheduler_WP_CLI_Action_WP_CLI{}
mut iife_result_3 := iife_temp_3.debug(rt.call_function('sprintf', [rt.new_string('Action %d was deleted.'), var_action_id_mutated.clone()]))
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

fn create_action_scheduler_wp_cli_action_delete_command(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_Delete_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_Delete_Command{
		PhpObjectBase: rt.PhpObjectBase{}
		action_ids: rt.new_array()
		action_counts: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler_wpcli_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler_WPCLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_action_actionscheduler(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler {
	mut obj := &Class_Action_Scheduler_WP_CLI_Action_ActionScheduler{
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

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'on_action_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_action_deleted(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'action_ids' { return this.action_ids }
		'action_counts' { return this.action_counts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_WP_CLI_Action_Delete_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
