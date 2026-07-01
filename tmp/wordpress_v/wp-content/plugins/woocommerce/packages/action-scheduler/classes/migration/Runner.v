import rt

struct Class_Action_Scheduler_Migration_Runner {
	rt.PhpObjectBase
pub mut:
	source_store       rt.PhpVal = rt.new_null()
	destination_store  rt.PhpVal = rt.new_null()
	source_logger      rt.PhpVal = rt.new_null()
	destination_logger rt.PhpVal = rt.new_null()
	batch_fetcher      rt.PhpVal = rt.new_null()
	action_migrator    rt.PhpVal = rt.new_null()
	log_migrator       rt.PhpVal = rt.new_null()
	progress_bar       rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Runner) construct(mut var_config Class_Action_Scheduler_Migration_Config) {
	this.source_store = var_config.get_source_store()
	this.destination_store = var_config.get_destination_store()
	this.source_logger = var_config.get_source_logger()
	this.destination_logger = var_config.get_destination_logger()
	this.batch_fetcher = create_action_scheduler_migration_batchfetcher(this.source_store)
	if rt.is_true(var_config.get_dry_run()) {
		this.log_migrator = create_action_scheduler_migration_dryrun_logmigrator(this.source_logger,
			this.destination_logger)
		this.action_migrator = create_action_scheduler_migration_dryrun_actionmigrator(this.source_store,
			this.destination_store, this.log_migrator)
	} else {
		this.log_migrator = create_action_scheduler_migration_logmigrator(this.source_logger,
			this.destination_logger)
		this.action_migrator = create_action_scheduler_migration_actionmigrator(this.source_store,
			this.destination_store, this.log_migrator)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI'))))
	{
		this.progress_bar = var_config.get_progress_bar()
	}
}

fn (mut this Class_Action_Scheduler_Migration_Runner) run(batch_size i64) i64 {
	mut batch_size_mutated := batch_size
	mut var_batch := rt.call_method(this.batch_fetcher, 'fetch', [
		rt.new_int(batch_size_mutated).dup()])
	batch_size_mutated = var_batch.dup().array_count()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(batch_size_mutated))))) {
		return 0
	}
	if rt.is_true(this.progress_bar) {
		rt.call_method(this.progress_bar, 'set_message', [
			rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('Migrating %d action'),
					rt.new_string('Migrating %d actions'), rt.new_int(batch_size_mutated).dup(),
					rt.new_string('woocommerce')]),
				rt.new_int(batch_size_mutated).dup(),
			]),
		])
		rt.call_method(this.progress_bar, 'set_count', [rt.new_int(batch_size_mutated).dup()])
	}
	this.migrate_actions(mut rt.cast_object_ptr[Class_Action_Scheduler_Migration_array](var_batch))
	return batch_size_mutated
}

fn (mut this Class_Action_Scheduler_Migration_Runner) migrate_actions(mut var_action_ids Class_Action_Scheduler_Migration_array) {
	rt.call_function('do_action', [
		rt.new_string('action_scheduler/migration_batch_starting'),
		var_action_ids,
	])
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Action_Scheduler_Migration_ActionScheduler{}
		return temp.logger()
	}(), 'unhook_stored_action', []rt.PhpVal{})
	rt.call_method(this.destination_logger, 'unhook_stored_action', []rt.PhpVal{})
	{
		mut iter_1 := var_action_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_source_action_id := item_1.val
			mut var_destination_action_id := rt.call_method(this.action_migrator, 'migrate', [
				var_source_action_id.dup(),
			])
			if rt.is_true(var_destination_action_id) {
				rt.call_method(this.destination_logger, 'log', [
					var_destination_action_id.dup(),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Migrated action with ID %1$d in %2$s to ID %3$d in %4$s'),
							rt.new_string('woocommerce'),
						]),
						var_source_action_id.dup(),
						rt.call_function('get_class', [
							this.source_store,
						]),
						var_destination_action_id.dup(),
						rt.call_function('get_class', [
							this.destination_store,
						]),
					])])
			}
			if rt.is_true(this.progress_bar) {
				rt.call_method(this.progress_bar, 'tick', []rt.PhpVal{})
			}
		}
	}
	if rt.is_true(this.progress_bar) {
		rt.call_method(this.progress_bar, 'finish', []rt.PhpVal{})
	}
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Action_Scheduler_Migration_ActionScheduler{}
		return temp.logger()
	}(), 'hook_stored_action', []rt.PhpVal{})
	rt.call_function('do_action', [
		rt.new_string('action_scheduler/migration_batch_complete'),
		var_action_ids,
	])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Action_Scheduler_Migration_Runner) init_destination() {
	rt.call_method(this.destination_store, 'init', []rt.PhpVal{})
	rt.call_method(this.destination_logger, 'init', []rt.PhpVal{})
}

struct Class_Action_Scheduler_Migration_BatchFetcher {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_DryRun_LogMigrator {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_DryRun_ActionMigrator {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_LogMigrator {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionMigrator {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_ActionScheduler {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_runner(arg_0 rt.PhpVal) &Class_Action_Scheduler_Migration_Runner {
	mut obj := &Class_Action_Scheduler_Migration_Runner{
		PhpObjectBase:      rt.PhpObjectBase{}
		source_store:       rt.new_null()
		destination_store:  rt.new_null()
		source_logger:      rt.new_null()
		destination_logger: rt.new_null()
		batch_fetcher:      rt.new_null()
		action_migrator:    rt.new_null()
		log_migrator:       rt.new_null()
		progress_bar:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_action_scheduler_migration_batchfetcher() &Class_Action_Scheduler_Migration_BatchFetcher {
	mut obj := &Class_Action_Scheduler_Migration_BatchFetcher{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_dryrun_logmigrator() &Class_Action_Scheduler_Migration_DryRun_LogMigrator {
	mut obj := &Class_Action_Scheduler_Migration_DryRun_LogMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_dryrun_actionmigrator() &Class_Action_Scheduler_Migration_DryRun_ActionMigrator {
	mut obj := &Class_Action_Scheduler_Migration_DryRun_ActionMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_logmigrator() &Class_Action_Scheduler_Migration_LogMigrator {
	mut obj := &Class_Action_Scheduler_Migration_LogMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionmigrator() &Class_Action_Scheduler_Migration_ActionMigrator {
	mut obj := &Class_Action_Scheduler_Migration_ActionMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler() &Class_Action_Scheduler_Migration_ActionScheduler {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_Config](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.run(dispatch_arg_0))
		}
		'migrate_actions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.migrate_actions(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init_destination' {
			this.init_destination()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_Migration_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source_store' { return this.source_store }
		'destination_store' { return this.destination_store }
		'source_logger' { return this.source_logger }
		'destination_logger' { return this.destination_logger }
		'batch_fetcher' { return this.batch_fetcher }
		'action_migrator' { return this.action_migrator }
		'log_migrator' { return this.log_migrator }
		'progress_bar' { return this.progress_bar }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source_store' {
			this.source_store = val
			return true
		}
		'destination_store' {
			this.destination_store = val
			return true
		}
		'source_logger' {
			this.source_logger = val
			return true
		}
		'destination_logger' {
			this.destination_logger = val
			return true
		}
		'batch_fetcher' {
			this.batch_fetcher = val
			return true
		}
		'action_migrator' {
			this.action_migrator = val
			return true
		}
		'log_migrator' {
			this.log_migrator = val
			return true
		}
		'progress_bar' {
			this.progress_bar = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_BatchFetcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_BatchFetcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_LogMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_LogMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_migration_runner_php() {
}
