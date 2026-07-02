import rt

struct Class_Action_Scheduler_Migration_DryRun_ActionMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_ActionMigrator) migrate(var_source_action_id rt.PhpVal) i64 {
	rt.call_function('do_action', [
		rt.new_string('action_scheduler/migrate_action_dry_run'),
		var_source_action_id.clone(),
	])
	return 0
}

struct Class_Action_Scheduler_Migration_ActionMigrator {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_dryrun_actionmigrator(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_DryRun_ActionMigrator {
	mut obj := &Class_Action_Scheduler_Migration_DryRun_ActionMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionmigrator(_args ...rt.PhpVal) &Class_Action_Scheduler_Migration_ActionMigrator {
	mut obj := &Class_Action_Scheduler_Migration_ActionMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.migrate(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_ActionMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
