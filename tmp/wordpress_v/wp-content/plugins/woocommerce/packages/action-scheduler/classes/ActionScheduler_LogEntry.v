import rt

struct Class_ActionScheduler_LogEntry {
	rt.PhpObjectBase
pub mut:
		action_id rt.PhpVal = rt.new_string('')
		message rt.PhpVal = rt.new_string('')
		date rt.PhpVal = rt.new_null()
}

fn (mut this Class_ActionScheduler_LogEntry) construct(var_action_id rt.PhpVal, var_message rt.PhpVal, var_date rt.PhpVal)  {
	mut var_date_mutated := var_date
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_date_mutated.dup(), rt.new_string('DateTime')]))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('The third parameter must be a valid DateTime instance, or null.'), rt.new_string('2.0.0')])
		var_date_mutated = rt.new_null()
	}
	this.action_id = var_action_id.dup()
	this.message = var_message.dup()
	this.date = if rt.is_true(var_date_mutated) { var_date_mutated } else { create_datetime() }
}

fn (mut this Class_ActionScheduler_LogEntry) get_date() rt.PhpVal {
	return this.date
}

fn (mut this Class_ActionScheduler_LogEntry) get_action_id() rt.PhpVal {
	return this.action_id
}

fn (mut this Class_ActionScheduler_LogEntry) get_message() rt.PhpVal {
	return this.message
}

struct Class_Datetime {
	rt.PhpObjectBase
}

fn create_actionscheduler_logentry(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_ActionScheduler_LogEntry {
	mut obj := &Class_ActionScheduler_LogEntry{
		PhpObjectBase: rt.PhpObjectBase{}
		action_id: rt.new_string('')
		message: rt.new_string('')
		date: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_datetime() &Class_Datetime {
	mut obj := &Class_Datetime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_LogEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_date' {
			return this.get_date()
		}
		'get_action_id' {
			return this.get_action_id()
		}
		'get_message' {
			return this.get_message()
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_LogEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'action_id' { return this.action_id }
		'message' { return this.message }
		'date' { return this.date }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_LogEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'action_id' { this.action_id = val; return true }
		'message' { this.message = val; return true }
		'date' { this.date = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Datetime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Datetime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Datetime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_logentry_php() {
}
