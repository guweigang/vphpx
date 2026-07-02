import rt

struct Class_Action_Scheduler_Migration_LogMigrator {
	rt.PhpObjectBase
pub mut:
	source      rt.PhpVal = rt.new_null()
	destination rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) construct(mut var_source_logger Class_ActionScheduler_Logger, mut var_destination_logger Class_ActionScheduler_Logger) {
	this.source = var_source_logger
	this.destination = var_destination_logger
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) migrate(var_source_action_id rt.PhpVal, var_destination_action_id rt.PhpVal) {
	mut var_logs := rt.call_method(this.source, 'get_logs', [
		var_source_action_id.clone()])
	mut iter_1 := var_logs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_log := item_1.val
		if rt.is_true(rt.identical(rt.call_function('absint', [
			rt.call_method(var_log, 'get_action_id', []rt.PhpVal{}),
		]), rt.call_function('absint', [var_source_action_id.clone()])))
		{
			rt.call_method(this.destination, 'log', [var_destination_action_id.clone(),
				rt.call_method(var_log, 'get_message', []rt.PhpVal{}),
				rt.call_method(var_log, 'get_date', []rt.PhpVal{})])
		}
	}
}

fn create_action_scheduler_migration_logmigrator(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Action_Scheduler_Migration_LogMigrator {
	mut obj := &Class_Action_Scheduler_Migration_LogMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		source:        rt.new_null()
		destination:   rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Logger](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ActionScheduler_Logger](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.migrate(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_Migration_LogMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source' { return this.source }
		'destination' { return this.destination }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source' {
			this.source = val
			return true
		}
		'destination' {
			this.destination = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
