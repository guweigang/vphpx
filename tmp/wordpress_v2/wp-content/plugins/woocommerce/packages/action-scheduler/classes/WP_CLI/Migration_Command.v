import rt

struct Class_Action_Scheduler_WP_CLI_Migration_Command {
	rt.PhpObjectBase
pub mut:
	total_processed rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) register() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_CLI'))))) {
		return
	}
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.add_command(rt.new_string('action-scheduler migrate'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_WP_CLI_Migration_Command', [
			'WP_CLI_Command',
		], &this) },
		rt.ArrayItem{ key: none, val: 'migrate' },
	]), rt.create_array([
		rt.ArrayItem{ key: 'shortdesc', val: 'Migrates actions to the DB tables store' },
		rt.ArrayItem{ key: 'synopsis', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'assoc' },
				rt.ArrayItem{ key: 'name', val: 'batch-size' },
				rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{ key: 'default', val: 100 },
				rt.ArrayItem{
					key: 'description'
					val: 'The number of actions to process in each batch'
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'assoc' },
				rt.ArrayItem{ key: 'name', val: 'free-memory-on' },
				rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{ key: 'default', val: 50 },
				rt.ArrayItem{
					key: 'description'
					val: 'The number of actions to process between freeing memory. 0 disables freeing memory'
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'assoc' },
				rt.ArrayItem{ key: 'name', val: 'pause' },
				rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{ key: 'default', val: 0 },
				rt.ArrayItem{
					key: 'description'
					val: 'The number of seconds to pause when freeing memory'
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'flag' },
				rt.ArrayItem{ key: 'name', val: 'dry-run' },
				rt.ArrayItem{ key: 'optional', val: true },
				rt.ArrayItem{
					key: 'description'
					val: 'Reports on the actions that would have been migrated, but does not change any data'
				},
			]) },
		]) },
	]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) migrate(var_positional_args rt.PhpVal, var_assoc_args rt.PhpVal) {
	this.init_logging()
	mut var_config := this.get_migration_config(var_assoc_args.clone())
	mut var_runner := create_action_scheduler_migration_runner(var_config.clone())
	var_runner.init_destination()
	mut var_batch_size := rt.new_int(if var_assoc_args.array_isset(rt.new_string('batch-size')) {
		rt.new_int((var_assoc_args.array_get(rt.new_string('batch-size'))).to_i64())
	} else {
		100
	})
	mut var_free_on := rt.new_int(if var_assoc_args.array_isset(rt.new_string('free-memory-on')) {
		rt.new_int((var_assoc_args.array_get(rt.new_string('free-memory-on'))).to_i64())
	} else {
		50
	})
	mut var_sleep := rt.new_int(if var_assoc_args.array_isset(rt.new_string('pause')) {
		rt.new_int((var_assoc_args.array_get(rt.new_string('pause'))).to_i64())
	} else {
		0
	})
	mut iife_temp_1 := Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController{}
	mut iife_result_1 := iife_temp_1.set_free_ticks(var_free_on.clone())
	mut iife_temp_2 := Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController{}
	mut iife_result_2 := iife_temp_2.set_sleep_time(var_sleep.clone())
	for {
		mut var_actions_processed := var_runner.run(var_batch_size.clone())
		this.total_processed = rt.add(this.total_processed, var_actions_processed)
		if !(rt.is_true(rt.greater(var_actions_processed, rt.new_int(0)))) {
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_config, 'get_dry_run', []rt.PhpVal{}))))) {
		mut var_scheduler := create_action_scheduler_migration_scheduler()
		var_scheduler.mark_complete()
	}
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.success(rt.call_function('sprintf', [
		rt.new_string('%s complete. %d actions processed.'),
		rt.new_string((if rt.is_true(rt.call_method(var_config, 'get_dry_run', []rt.PhpVal{})) {
			'Dry run'
		} else {
			'Migration'
		}).str()),
		this.total_processed,
	]))
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) get_migration_config(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'dry-run', val: false }])])
	mut iife_temp_4 := Class_Action_Scheduler_Migration_Controller{}
	mut iife_result_4 := iife_temp_4.instance()
	mut var_config := rt.call_method(iife_result_4, 'get_migration_config_object', []rt.PhpVal{})
	rt.call_method(var_config, 'set_dry_run', [
		rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(rt.new_string('dry-run'))))),
	])
	return var_config.clone()
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) init_logging() {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_action_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_6 := Class_WP_CLI{}
		mut iife_result_6 := iife_temp_6.debug(rt.call_function('sprintf', [
			rt.new_string('Dry-run: migrated action %d'),
			var_action_id.clone(),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/migrate_action_dry_run'),
		rt.new_closure(closure_7_fn),
	])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_action_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_8 := Class_WP_CLI{}
		mut iife_result_8 := iife_temp_8.debug(rt.call_function('sprintf', [
			rt.new_string('No action found to migrate for ID %d'),
			var_action_id.clone(),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/no_action_to_migrate'),
		rt.new_closure(closure_9_fn),
	])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_action_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_10 := Class_WP_CLI{}
		mut iife_result_10 := iife_temp_10.warning(rt.call_function('sprintf', [
			rt.new_string('Failed migrating action with ID %d'),
			var_action_id.clone(),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/migrate_action_failed'),
		rt.new_closure(closure_11_fn),
	])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_source_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_destination_id := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_12 := Class_WP_CLI{}
		mut iife_result_12 := iife_temp_12.warning(rt.call_function('sprintf', [
			rt.new_string('Unable to remove source action with ID %d after migrating to new ID %d'),
			var_source_id.clone(),
			var_destination_id.clone(),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/migrate_action_incomplete'),
		rt.new_closure(closure_13_fn),
		rt.new_int(10),
		rt.new_int(2),
	])
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_source_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_destination_id := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_14 := Class_WP_CLI{}
		mut iife_result_14 := iife_temp_14.debug(rt.call_function('sprintf', [
			rt.new_string('Migrated source action with ID %d to new store with ID %d'),
			var_source_id.clone(),
			var_destination_id.clone(),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('action_scheduler/migrated_action'),
		rt.new_closure(closure_15_fn), rt.new_int(10), rt.new_int(2)])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_batch := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_16 := Class_WP_CLI{}
		mut iife_result_16 := iife_temp_16.debug(rt.new_string('Beginning migration of batch: ' +
			(println(var_batch.clone().to_string())).str()))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/migration_batch_starting'),
		rt.new_closure(closure_17_fn),
	])
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_batch := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_18 := Class_WP_CLI{}
		mut iife_result_18 := iife_temp_18.log(rt.call_function('sprintf', [
			rt.new_string('Completed migration of %d actions'),
			rt.new_int(var_batch.clone().array_count()),
		]))
		return rt.new_null()
	}
	rt.call_function('add_action', [
		rt.new_string('action_scheduler/migration_batch_complete'),
		rt.new_closure(closure_19_fn),
	])
}

struct Class_WP_CLI_Command {
	rt.PhpObjectBase
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Runner {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Scheduler {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

fn create_action_scheduler_wp_cli_migration_command(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_Migration_Command {
	mut obj := &Class_Action_Scheduler_WP_CLI_Migration_Command{
		PhpObjectBase:   rt.PhpObjectBase{}
		total_processed: rt.new_int(0)
	}
	return obj
}

fn create_wp_cli_command(_args ...rt.PhpVal) &Class_WP_CLI_Command {
	mut obj := &Class_WP_CLI_Command{
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

fn create_action_scheduler_migration_runner(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_Runner {
	mut obj := &Class_Action_Scheduler_Migration_Runner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_wp_cli_actionscheduler_datacontroller(_args ...rt.PhpVal) &Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController {
	mut obj := &Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_scheduler(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_Scheduler {
	mut obj := &Class_Action_Scheduler_Migration_Scheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_controller(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_Controller {
	mut obj := &Class_Action_Scheduler_Migration_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.migrate(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_migration_config' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_migration_config(dispatch_arg_0)
		}
		'init_logging' {
			this.init_logging()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'total_processed' { return this.total_processed }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_WP_CLI_Migration_Command) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'total_processed' {
			this.total_processed = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_WP_CLI_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Scheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
