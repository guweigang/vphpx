import rt

struct Class_Action_Scheduler_Migration_DryRun_LogMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_LogMigrator) migrate(var_source_action_id rt.PhpVal, var_destination_action_id rt.PhpVal) {
	// unsupported statement: Stmt_Nop
}

struct Class_Action_Scheduler_Migration_LogMigrator {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_dryrun_logmigrator() &Class_Action_Scheduler_Migration_DryRun_LogMigrator {
	mut obj := &Class_Action_Scheduler_Migration_DryRun_LogMigrator{
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

fn (mut this Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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

fn (this &Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_DryRun_LogMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_migration_dryrun_logmigrator_php() {
}
