import rt

struct Class_ActionScheduler_Abstract_QueueRunner {
	rt.PhpObjectBase
pub mut:
		cleaner rt.PhpVal = rt.new_null()
		monitor rt.PhpVal = rt.new_null()
		store rt.PhpVal = rt.new_null()
		created_time rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) construct(mut var_store Class_?ActionScheduler_Store, mut var_monitor Class_?ActionScheduler_FatalErrorMonitor, mut var_cleaner Class_?ActionScheduler_QueueCleaner)  {
	this.created_time = rt.call_function('microtime', [rt.new_bool(true)])
	this.store = if rt.is_true(var_store) { var_store } else { fn () rt.PhpVal { mut temp := Class_ActionScheduler_Store{}; return temp.instance() }() }
	this.monitor = if rt.is_true(var_monitor) { var_monitor } else { create_actionscheduler_fatalerrormonitor(this.store) }
	this.cleaner = if rt.is_true(var_cleaner) { var_cleaner } else { create_actionscheduler_queuecleaner(this.store) }
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) process_action(var_action_id rt.PhpVal, context string)  {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_type := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_message := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(var_message.dup())))
	return rt.new_null()
	}
	mut var_type := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_message := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(var_message.dup())))
	return rt.new_null()
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn), rt.bitwise_or(rt.get_constant('E_USER_ERROR'), rt.get_constant('E_RECOVERABLE_ERROR'))])
	mut var_valid_action := rt.new_bool(rt.new_bool(true))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_before_execute'), var_action_id.dup(), rt.new_string(context)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_valid_action = rt.new_bool(rt.new_bool(false))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_function('do_action', [rt.new_string('action_scheduler_execution_ignored'), var_action_id.dup(), rt.new_string(context)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_begin_execute'), var_action_id.dup(), rt.new_string(context)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_action := rt.call_method(this.store, 'fetch_action', [var_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(this.store, 'log_execution', [var_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_action, 'execute', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler_after_execute'), var_action_id.dup(), var_action.dup(), rt.new_string(context)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(this.store, 'mark_complete', [var_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e, 'getCode', []rt.PhpVal{}), var_e.dup())))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		this.handle_action_error(var_action_id.dup(), var_e.dup(), rt.new_string(context), var_valid_action.dup())
		unsafe { goto finally_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto finally_label_1 }
	}

finally_label_1:
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	if rt.has_exception() { return }

end_label_1:
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_action).is_null() && rt.is_true(rt.call_function('is_a', [var_action.dup(), rt.new_string('ActionScheduler_Action')])))) && rt.is_true(rt.call_method(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{}), 'is_recurring', []rt.PhpVal{})))) {
		this.schedule_next_instance(mut rt.cast_object_ptr[Class_ActionScheduler_Action](var_action), var_action_id.dup())
	}
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) handle_action_error(var_action_id rt.PhpVal, var_e rt.PhpVal, var_context rt.PhpVal, var_valid_action rt.PhpVal)  {
	mut var_valid_action_mutated := var_valid_action
	if rt.is_true(var_valid_action_mutated) {
		rt.call_method(this.store, 'mark_failure', [var_action_id.dup()])
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_execution'), var_action_id.dup(), var_e.dup(), var_context.dup()])
	} else {
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_validation'), var_action_id.dup(), var_e.dup(), var_context.dup()])
	}
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) schedule_next_instance(mut var_action Class_ActionScheduler_Action, var_action_id rt.PhpVal)  {
	mut var_action_mutated := var_action
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_ActionScheduler_Store.status_failed(), rt.call_method(this.store, 'get_status', [var_action_id.dup()]))) && this.recurring_action_is_consistently_failing(mut var_action_mutated, var_action_id.dup()))) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler_Logger{}; return temp.instance() }(), 'log', [var_action_id.dup(), rt.call_function('__', [rt.new_string('This action appears to be consistently failing. A new instance will not be scheduled.'), rt.new_string('woocommerce')])])
		return rt.new_null()
	}
	rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.factory() }(), 'repeat', [var_action_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.dup()
		rt.call_function('do_action', [rt.new_string('action_scheduler_failed_to_schedule_next_instance'), var_action_id.dup(), var_e.dup(), var_action_mutated.dup()])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) recurring_action_is_consistently_failing(mut var_action Class_ActionScheduler_Action, var_action_id rt.PhpVal) bool {
	mut var_action_mutated := var_action
	mut var_consistent_failure_threshold := // unsupported expression: Expr_Cast_Int
	mut var_query_args := { 'hook': rt.call_method(var_action_mutated, 'get_hook', []rt.PhpVal{}), 'status': Class_ActionScheduler_Store.status_failed(), 'date': rt.call_method(rt.call_function('date_create', [rt.new_string('now'), rt.call_function('timezone_open', [rt.new_string('UTC')])]), 'format', [rt.new_string('Y-m-d H:i:s')]), 'date_compare': rt.new_string('<'), 'per_page': rt.new_int(1), 'offset': var_consistent_failure_threshold - 1 }
	mut var_first_failing_action_id := rt.call_method(this.store, 'query_actions', [var_query_args.dup()])
	if !rt.is_true(var_first_failing_action_id) {
		return false
	}
	var_query_args.delete('status')
	mut var_first_action_id_with_the_same_hook := rt.call_method(this.store, 'query_actions', [var_query_args.dup()])
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) run_cleanup()  {
	rt.call_method(this.cleaner, 'clean', [rt.mul(rt.new_int(10), this.get_time_limit())])
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) get_allowed_concurrent_batches() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_queue_runner_concurrent_batches'), rt.new_int(1)])
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) has_maximum_concurrent_batches() rt.PhpVal {
	return rt.greater_equal(rt.call_method(this.store, 'get_claim_count', []rt.PhpVal{}), this.get_allowed_concurrent_batches())
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) get_time_limit() rt.PhpVal {
	mut var_time_limit := rt.new_int(rt.new_int(30))
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('action_scheduler_maximum_execution_time')])) {
		rt.call_function('_deprecated_function', [rt.new_string('action_scheduler_maximum_execution_time'), rt.new_string('2.1.1'), rt.new_string('action_scheduler_queue_runner_time_limit')])
		var_time_limit = rt.call_function('apply_filters', [rt.new_string('action_scheduler_maximum_execution_time'), var_time_limit.dup()])
	}
	return rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('action_scheduler_queue_runner_time_limit'), var_time_limit.dup()])])
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) get_execution_time() rt.PhpVal {
	mut var_execution_time := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), this.created_time)
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('getrusage')])) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('action_scheduler_use_cpu_execution_time'), rt.call_function('defined', [rt.new_string('PANTHEON_ENVIRONMENT')])])))) {
		mut var_resource_usages := rt.call_function('getrusage', []rt.PhpVal{})
		if var_resource_usages.array_isset(rt.new_string('ru_stime.tv_usec')) && var_resource_usages.array_isset(rt.new_string('ru_stime.tv_usec')) {
			var_execution_time = rt.add(var_resource_usages.array_get('ru_stime.tv_sec'), rt.div(var_resource_usages.array_get('ru_stime.tv_usec'), rt.new_int(1000000)))
		}
	}
	return var_execution_time.dup()
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) time_likely_to_be_exceeded(var_processed_actions rt.PhpVal) rt.PhpVal {
	mut var_execution_time := this.get_execution_time()
	mut var_max_execution_time := this.get_time_limit()
	if rt.is_true(rt.identical(rt.new_int(0), var_processed_actions)) {
		return rt.greater_equal(var_execution_time, var_max_execution_time)
	}
	mut var_time_per_action := rt.div(var_execution_time, var_processed_actions)
	mut var_estimated_time := rt.add(var_execution_time, rt.mul(var_time_per_action, rt.new_int(3)))
	mut var_likely_to_be_exceeded := rt.greater(var_estimated_time, var_max_execution_time)
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_maximum_execution_time_likely_to_be_exceeded'), var_likely_to_be_exceeded.dup(), rt.new_object('ActionScheduler_Abstract_QueueRunner', ['ActionScheduler_Abstract_QueueRunner_Deprecated'], &this), var_processed_actions.dup(), var_execution_time.dup(), var_max_execution_time.dup()])
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) get_memory_limit() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		mut var_memory_limit := rt.call_function('ini_get', [rt.new_string('memory_limit')])
	} else {
		var_memory_limit = rt.new_string(rt.new_string('128M'))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_memory_limit)))) || rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_memory_limit)))) || rt.is_true(rt.identical(rt.new_string('-1'), var_memory_limit)))) {
		var_memory_limit = rt.new_string(rt.new_string('32G'))
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler_Compatibility{}; return temp.convert_hr_to_bytes(arg_0) }(var_memory_limit.dup())
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) memory_exceeded() rt.PhpVal {
	mut var_memory_limit := rt.new_float(this.get_memory_limit() * 0.9)
	mut var_current_memory := rt.call_function('memory_get_usage', [rt.new_bool(true)])
	mut var_memory_exceeded := rt.greater_equal(var_current_memory, var_memory_limit)
	return rt.call_function('apply_filters', [rt.new_string('action_scheduler_memory_exceeded'), var_memory_exceeded.dup(), rt.new_object('ActionScheduler_Abstract_QueueRunner', ['ActionScheduler_Abstract_QueueRunner_Deprecated'], &this)])
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) batch_limits_exceeded(var_processed_actions rt.PhpVal) bool {
	return rt.is_true(this.memory_exceeded()) || rt.is_true(this.time_likely_to_be_exceeded(var_processed_actions.dup()))
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) run(context string)  {
}

struct Class_ActionScheduler_Abstract_QueueRunner_Deprecated {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Store {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_FatalErrorMonitor {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_QueueCleaner {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_ActionScheduler_Logger {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Compatibility {
	rt.PhpObjectBase
}

fn create_actionscheduler_abstract_queuerunner(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_Abstract_QueueRunner {
	mut obj := &Class_ActionScheduler_Abstract_QueueRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		cleaner: rt.new_null()
		monitor: rt.new_null()
		store: rt.new_null()
		created_time: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_actionscheduler_abstract_queuerunner_deprecated() &Class_ActionScheduler_Abstract_QueueRunner_Deprecated {
	mut obj := &Class_ActionScheduler_Abstract_QueueRunner_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_store() &Class_ActionScheduler_Store {
	mut obj := &Class_ActionScheduler_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_fatalerrormonitor() &Class_ActionScheduler_FatalErrorMonitor {
	mut obj := &Class_ActionScheduler_FatalErrorMonitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_queuecleaner() &Class_ActionScheduler_QueueCleaner {
	mut obj := &Class_ActionScheduler_QueueCleaner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_actionscheduler_logger() &Class_ActionScheduler_Logger {
	mut obj := &Class_ActionScheduler_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_compatibility() &Class_ActionScheduler_Compatibility {
	mut obj := &Class_ActionScheduler_Compatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?ActionScheduler_FatalErrorMonitor](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?ActionScheduler_QueueCleaner](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'process_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.process_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_action_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.handle_action_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'schedule_next_instance' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.schedule_next_instance(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'recurring_action_is_consistently_failing' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Action](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.recurring_action_is_consistently_failing(mut dispatch_arg_0, dispatch_arg_1))
		}
		'run_cleanup' {
			this.run_cleanup()
			return rt.new_null()
		}
		'get_allowed_concurrent_batches' {
			return this.get_allowed_concurrent_batches()
		}
		'has_maximum_concurrent_batches' {
			return this.has_maximum_concurrent_batches()
		}
		'get_time_limit' {
			return this.get_time_limit()
		}
		'get_execution_time' {
			return this.get_execution_time()
		}
		'time_likely_to_be_exceeded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.time_likely_to_be_exceeded(dispatch_arg_0)
		}
		'get_memory_limit' {
			return this.get_memory_limit()
		}
		'memory_exceeded' {
			return this.memory_exceeded()
		}
		'batch_limits_exceeded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_limits_exceeded(dispatch_arg_0))
		}
		'run' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.run(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Abstract_QueueRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cleaner' { return this.cleaner }
		'monitor' { return this.monitor }
		'store' { return this.store }
		'created_time' { return this.created_time }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cleaner' { this.cleaner = val; return true }
		'monitor' { this.monitor = val; return true }
		'store' { this.store = val; return true }
		'created_time' { this.created_time = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ActionScheduler_FatalErrorMonitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_FatalErrorMonitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_FatalErrorMonitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_ActionScheduler_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Compatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Compatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Compatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_abstract_queuerunner_php() {
}
