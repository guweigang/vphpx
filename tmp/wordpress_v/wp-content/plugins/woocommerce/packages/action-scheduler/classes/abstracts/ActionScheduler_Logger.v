import rt

struct Class_ActionScheduler_Logger {
	rt.PhpObjectBase
pub mut:
		logger rt.PhpVal = rt.new_null()
}

fn Class_ActionScheduler_Logger.instance() rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_class := rt.call_function('apply_filters', [rt.new_string('action_scheduler_logger_class'), rt.new_string('ActionScheduler_wpCommentLogger')])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_ActionScheduler_Logger) log(var_action_id rt.PhpVal, var_message rt.PhpVal, mut var_date Class_?DateTime)  {
	mut var_message_mutated := var_message
}

fn (mut this Class_ActionScheduler_Logger) get_entry(var_entry_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_Logger) get_logs(var_action_id rt.PhpVal)  {
}

fn (mut this Class_ActionScheduler_Logger) init()  {
	this.hook_stored_action()
	rt.call_function('add_action', [rt.new_string('action_scheduler_canceled_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_canceled_action' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_begin_execute'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_started_action' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_after_execute'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_completed_action' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_execution'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_failed_action' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_timed_out_action' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_unexpected_shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_unexpected_shutdown' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_reset_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_reset_action' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_execution_ignored'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_ignored_action' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_fetch_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_failed_fetch_action' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_failed_to_schedule_next_instance'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_failed_schedule_next_instance' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('action_scheduler_bulk_cancel_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'bulk_log_cancel_actions' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_ActionScheduler_Logger) hook_stored_action()  {
	rt.call_function('add_action', [rt.new_string('action_scheduler_stored_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_stored_action' }])])
}

fn (mut this Class_ActionScheduler_Logger) unhook_stored_action()  {
	rt.call_function('remove_action', [rt.new_string('action_scheduler_stored_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('ActionScheduler_Logger', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'log_stored_action' }])])
}

fn (mut this Class_ActionScheduler_Logger) log_stored_action(var_action_id rt.PhpVal)  {
	this.log(var_action_id.dup(), rt.call_function('__', [rt.new_string('action created'), rt.new_string('woocommerce')]), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_canceled_action(var_action_id rt.PhpVal)  {
	this.log(var_action_id.dup(), rt.call_function('__', [rt.new_string('action canceled'), rt.new_string('woocommerce')]), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_started_action(var_action_id rt.PhpVal, context string)  {
	if !(context == '') {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action started via %s'), rt.new_string('woocommerce')]), rt.new_string(context)])
	} else {
		var_message = rt.call_function('__', [rt.new_string('action started'), rt.new_string('woocommerce')])
	}
	this.log(var_action_id.dup(), var_message.dup(), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_completed_action(var_action_id rt.PhpVal, var_action rt.PhpVal, context string)  {
	if !(context == '') {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action complete via %s'), rt.new_string('woocommerce')]), rt.new_string(context)])
	} else {
		var_message = rt.call_function('__', [rt.new_string('action complete'), rt.new_string('woocommerce')])
	}
	this.log(var_action_id.dup(), var_message.dup(), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_failed_action(var_action_id rt.PhpVal, mut var_exception Class_Exception, context string)  {
	if !(context == '') {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action failed via %1$s: %2$s'), rt.new_string('woocommerce')]), rt.new_string(context), var_exception.getmessage()])
	} else {
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action failed: %s'), rt.new_string('woocommerce')]), var_exception.getmessage()])
	}
	this.log(var_action_id.dup(), var_message.dup(), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_timed_out_action(var_action_id rt.PhpVal, var_timeout rt.PhpVal)  {
	this.log(var_action_id.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action marked as failed after %s seconds. Unknown error occurred. Check server, PHP and database error logs to diagnose cause.'), rt.new_string('woocommerce')]), var_timeout.dup()]), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_unexpected_shutdown(var_action_id rt.PhpVal, var_error rt.PhpVal)  {
	if !(!rt.is_true(var_error)) {
		this.log(var_action_id.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('unexpected shutdown: PHP Fatal error %1$s in %2$s on line %3$s'), rt.new_string('woocommerce')]), var_error.array_get('message'), var_error.array_get('file'), var_error.array_get('line')]), rt.new_null())
	}
}

fn (mut this Class_ActionScheduler_Logger) log_reset_action(var_action_id rt.PhpVal)  {
	this.log(var_action_id.dup(), rt.call_function('__', [rt.new_string('action reset'), rt.new_string('woocommerce')]), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_ignored_action(var_action_id rt.PhpVal, context string)  {
	if !(context == '') {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('action ignored via %s'), rt.new_string('woocommerce')]), rt.new_string(context)])
	} else {
		var_message = rt.call_function('__', [rt.new_string('action ignored'), rt.new_string('woocommerce')])
	}
	this.log(var_action_id.dup(), var_message.dup(), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_failed_fetch_action(var_action_id rt.PhpVal, mut var_exception Class_?Exception)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_exception.is_null()))))) {
		mut var_log_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was a failure fetching this action: %s'), rt.new_string('woocommerce')]), var_exception.getmessage()])
	} else {
		var_log_message = rt.call_function('__', [rt.new_string('There was a failure fetching this action'), rt.new_string('woocommerce')])
	}
	this.log(var_action_id.dup(), var_log_message.dup(), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) log_failed_schedule_next_instance(var_action_id rt.PhpVal, mut var_exception Class_Exception)  {
	this.log(var_action_id.dup(), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('There was a failure scheduling the next instance of this action: %s'), rt.new_string('woocommerce')]), var_exception.getmessage()]), rt.new_null())
}

fn (mut this Class_ActionScheduler_Logger) bulk_log_cancel_actions(var_action_ids rt.PhpVal)  {
	if !rt.is_true(var_action_ids) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_action_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action_id := item_1.val
			this.log_canceled_action(var_action_id.dup())
		}
	}
}

fn create_actionscheduler_logger() &Class_ActionScheduler_Logger {
	mut obj := &Class_ActionScheduler_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
		logger: rt.new_null()
	}
	return obj
}

fn (mut this Class_ActionScheduler_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_ActionScheduler_Logger.instance()
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?DateTime](if args.len > 2 { args[2] } else { rt.new_null() })
			this.log(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_entry(dispatch_arg_0)
			return rt.new_null()
		}
		'get_logs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_logs(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'hook_stored_action' {
			this.hook_stored_action()
			return rt.new_null()
		}
		'unhook_stored_action' {
			this.unhook_stored_action()
			return rt.new_null()
		}
		'log_stored_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_stored_action(dispatch_arg_0)
			return rt.new_null()
		}
		'log_canceled_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_canceled_action(dispatch_arg_0)
			return rt.new_null()
		}
		'log_started_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.log_started_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log_completed_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.log_completed_action(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'log_failed_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Exception](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.log_failed_action(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'log_timed_out_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.log_timed_out_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log_unexpected_shutdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.log_unexpected_shutdown(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log_reset_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.log_reset_action(dispatch_arg_0)
			return rt.new_null()
		}
		'log_ignored_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.log_ignored_action(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log_failed_fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?Exception](if args.len > 1 { args[1] } else { rt.new_null() })
			this.log_failed_fetch_action(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'log_failed_schedule_next_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Exception](if args.len > 1 { args[1] } else { rt.new_null() })
			this.log_failed_schedule_next_instance(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'bulk_log_cancel_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_log_cancel_actions(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('ActionScheduler_Logger', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_actionscheduler_logger()
		return rt.new_object('ActionScheduler_Logger', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_logger_php() {
}
