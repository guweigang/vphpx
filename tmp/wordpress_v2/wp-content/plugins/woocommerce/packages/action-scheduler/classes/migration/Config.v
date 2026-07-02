import rt

struct Class_Action_Scheduler_Migration_Config {
	rt.PhpObjectBase
pub mut:
	source_store       rt.PhpVal = rt.new_null()
	source_logger      rt.PhpVal = rt.new_null()
	destination_store  rt.PhpVal = rt.new_null()
	destination_logger rt.PhpVal = rt.new_null()
	progress_bar       rt.PhpVal = rt.new_null()
	dry_run            rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Action_Scheduler_Migration_Config) construct() {
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_source_store() rt.PhpVal {
	if !rt.is_true(this.source_store) {
		rt.throw_exception(rt.new_object('Action_Scheduler_Migration_RuntimeException', []string{}, create_action_scheduler_migration_runtimeexception(rt.call_function('__', [
			rt.new_string('Source store must be configured before running a migration'),
			rt.new_string('woocommerce'),
		]))))
	}
	return this.source_store
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_source_store(mut var_store Class_ActionScheduler_Store) {
	this.source_store = var_store
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_source_logger() rt.PhpVal {
	if !rt.is_true(this.source_logger) {
		rt.throw_exception(rt.new_object('Action_Scheduler_Migration_RuntimeException', []string{}, create_action_scheduler_migration_runtimeexception(rt.call_function('__', [
			rt.new_string('Source logger must be configured before running a migration'),
			rt.new_string('woocommerce'),
		]))))
	}
	return this.source_logger
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_source_logger(mut var_logger Class_ActionScheduler_Logger) {
	this.source_logger = var_logger
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_destination_store() rt.PhpVal {
	if !rt.is_true(this.destination_store) {
		rt.throw_exception(rt.new_object('Action_Scheduler_Migration_RuntimeException', []string{}, create_action_scheduler_migration_runtimeexception(rt.call_function('__', [
			rt.new_string('Destination store must be configured before running a migration'),
			rt.new_string('woocommerce'),
		]))))
	}
	return this.destination_store
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_destination_store(mut var_store Class_ActionScheduler_Store) {
	this.destination_store = var_store
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_destination_logger() rt.PhpVal {
	if !rt.is_true(this.destination_logger) {
		rt.throw_exception(rt.new_object('Action_Scheduler_Migration_RuntimeException', []string{}, create_action_scheduler_migration_runtimeexception(rt.call_function('__', [
			rt.new_string('Destination logger must be configured before running a migration'),
			rt.new_string('woocommerce'),
		]))))
	}
	return this.destination_logger
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_destination_logger(mut var_logger Class_ActionScheduler_Logger) {
	this.destination_logger = var_logger
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_dry_run() rt.PhpVal {
	return this.dry_run
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_dry_run(var_dry_run rt.PhpVal) {
	this.dry_run = var_dry_run.to_bool()
}

fn (mut this Class_Action_Scheduler_Migration_Config) get_progress_bar() rt.PhpVal {
	return this.progress_bar
}

fn (mut this Class_Action_Scheduler_Migration_Config) set_progress_bar(mut var_progress_bar Class_Action_Scheduler_WP_CLI_ProgressBar) {
	this.progress_bar = var_progress_bar
}

struct Class_Action_Scheduler_Migration_RuntimeException {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_config() &Class_Action_Scheduler_Migration_Config {
	mut obj := &Class_Action_Scheduler_Migration_Config{
		PhpObjectBase:      rt.PhpObjectBase{}
		source_store:       rt.new_null()
		source_logger:      rt.new_null()
		destination_store:  rt.new_null()
		destination_logger: rt.new_null()
		progress_bar:       rt.new_null()
		dry_run:            rt.new_bool(false)
	}
	obj.construct()
	return obj
}

fn create_action_scheduler_migration_runtimeexception(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_RuntimeException {
	mut obj := &Class_Action_Scheduler_Migration_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_source_store' {
			return this.get_source_store()
		}
		'set_source_store' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_source_store(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_source_logger' {
			return this.get_source_logger()
		}
		'set_source_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Logger](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_source_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_destination_store' {
			return this.get_destination_store()
		}
		'set_destination_store' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Store](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_destination_store(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_destination_logger' {
			return this.get_destination_logger()
		}
		'set_destination_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ActionScheduler_Logger](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_destination_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_dry_run' {
			return this.get_dry_run()
		}
		'set_dry_run' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_dry_run(dispatch_arg_0)
			return rt.new_null()
		}
		'get_progress_bar' {
			return this.get_progress_bar()
		}
		'set_progress_bar' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_WP_CLI_ProgressBar](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_progress_bar(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_Migration_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source_store' { return this.source_store }
		'source_logger' { return this.source_logger }
		'destination_store' { return this.destination_store }
		'destination_logger' { return this.destination_logger }
		'progress_bar' { return this.progress_bar }
		'dry_run' { return this.dry_run }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source_store' {
			this.source_store = val
			return true
		}
		'source_logger' {
			this.source_logger = val
			return true
		}
		'destination_store' {
			this.destination_store = val
			return true
		}
		'destination_logger' {
			this.destination_logger = val
			return true
		}
		'progress_bar' {
			this.progress_bar = val
			return true
		}
		'dry_run' {
			this.dry_run = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Action_Scheduler_Migration_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
