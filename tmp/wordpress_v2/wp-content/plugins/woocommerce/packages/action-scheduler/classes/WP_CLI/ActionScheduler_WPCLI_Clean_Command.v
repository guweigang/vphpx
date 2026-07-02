import rt

struct Class_ActionScheduler_WPCLI_Clean_Command {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) clean(var_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	mut var_batch := rt.call_function('absint', [rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('batch-size'), rt.new_int(20)])])
	mut var_batches := rt.call_function('absint', [rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('batches'), rt.new_int(0)])])
	mut var_status := rt.call_function('explode', [rt.new_string(','), rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('status'), rt.new_string('')])])
	var_status = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), var_status.clone()])])
	mut var_before := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('before'), rt.new_string('')])
	mut var_sleep := rt.call_function('WP_CLI\Utils\get_flag_value', [var_assoc_args.clone(), rt.new_string('pause'), rt.new_int(0)])
	mut var_batches_completed := rt.new_int(0)
	mut var_actions_deleted := rt.new_int(0)
	mut var_unlimited := rt.identical(rt.new_int(0), var_batches)
	mut var_lifespan := rt.call_function('as_get_datetime_object', [var_before.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		var_lifespan = rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_cleaner := create_actionscheduler_queuecleaner(rt.new_null(), var_batch.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	for rt.is_true(var_unlimited) || rt.is_true(rt.less(var_batches_completed, var_batches)) {
		if rt.is_true(var_sleep) && rt.is_true(rt.greater(var_batches_completed, rt.new_int(0))) {
			rt.call_function('sleep', [var_sleep.clone()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		mut var_deleted := rt.new_int(var_cleaner.clean_actions(var_status.clone(), var_lifespan.clone(), rt.new_null(), rt.new_string('CLI')).array_count())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.less_equal(var_deleted, rt.new_int(0))) {
			break
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_actions_deleted = rt.add(var_actions_deleted, var_deleted)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.post_inc(var_batches_completed)
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		this.print_success((var_deleted).to_i64())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		this.print_error(mut rt.cast_object_ptr[Class_Exception](var_e))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	this.print_total_batches((var_batches_completed).to_i64())
	if rt.is_true(rt.greater(var_batches_completed, rt.new_int(1))) {
		this.print_success((var_actions_deleted).to_i64())
	}
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) print_total_batches(batches_processed i64) {
mut iife_temp_0 := Class_WP_CLI{}
mut iife_result_0 := iife_temp_0.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d batch processed.'), rt.new_string('%d batches processed.'), rt.new_int(batches_processed), rt.new_string('woocommerce')]), rt.new_int(batches_processed)]))
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) print_error(mut var_e Class_Exception) {
mut iife_temp_1 := Class_WP_CLI{}
mut iife_result_1 := iife_temp_1.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was an error deleting an action: %s'), rt.new_string('woocommerce')]), var_e.getmessage()]))
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) print_success(actions_deleted i64) {
	mut actions_deleted_mutated := actions_deleted
mut iife_temp_2 := Class_WP_CLI{}
mut iife_result_2 := iife_temp_2.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d action deleted.'), rt.new_string('%d actions deleted.'), rt.new_int(actions_deleted_mutated).clone(), rt.new_string('woocommerce')]), rt.new_int(actions_deleted_mutated).clone()]))
}

struct Class_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_QueueCleaner {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_actionscheduler_wpcli_clean_command(_args ...rt.PhpVal) &Class_ActionScheduler_WPCLI_Clean_Command {
	mut obj := &Class_ActionScheduler_WPCLI_Clean_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli_command(_args ...rt.PhpVal) &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_queuecleaner(_args ...rt.PhpVal) &Class_ActionScheduler_QueueCleaner {
	mut obj := &Class_ActionScheduler_QueueCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'clean' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.clean(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'print_total_batches' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.print_total_batches(dispatch_arg_0)
			return rt.new_null()
		}
		'print_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			this.print_error(mut dispatch_arg_0)
			return rt.new_null()
		}
		'print_success' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.print_success(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_WPCLI_Clean_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_WPCLI_Clean_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_QueueCleaner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_QueueCleaner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
