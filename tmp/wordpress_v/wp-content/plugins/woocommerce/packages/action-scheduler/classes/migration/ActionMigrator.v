import rt

struct Class_Action_Scheduler_Migration_ActionMigrator {
	rt.PhpObjectBase
pub mut:
		source rt.PhpVal = rt.new_null()
		destination rt.PhpVal = rt.new_null()
		log_migrator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) construct(mut var_source_store Class_Action_Scheduler_Migration_ActionScheduler_Store, mut var_destination_store Class_Action_Scheduler_Migration_ActionScheduler_Store, mut var_log_migrator Class_Action_Scheduler_Migration_LogMigrator)  {
	this.source = var_source_store.dup()
	this.destination = var_destination_store.dup()
	this.log_migrator = var_log_migrator.dup()
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) migrate(var_source_action_id rt.PhpVal) i64 {
	mut var_action := rt.call_method(this.source, 'fetch_action', [var_source_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_status := rt.call_method(this.source, 'get_status', [var_source_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Action_Scheduler_Migration_Exception') {
		mut var_e := var_e_1.dup()
		var_action = rt.new_null()
		var_status = rt.new_string(rt.new_string(''))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_action.dup().is_null())) || !rt.is_true(var_status))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_action, 'get_schedule', []rt.PhpVal{}), 'get_date', []rt.PhpVal{}))))))) {
		rt.call_method(this.source, 'delete_action', [var_source_action_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Action_Scheduler_Migration_Exception') {
			mut var_e := var_e_2.dup()
			// unsupported statement: Stmt_Nop
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
		rt.call_function('do_action', [rt.new_string('action_scheduler/no_action_to_migrate'), var_source_action_id.dup(), this.source, this.destination])
		return 0
	}
	mut var_last_attempt_date := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(this.source, 'get_date', [var_source_action_id.dup()]) } else { rt.new_null() }
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_destination_action_id := rt.call_method(this.destination, 'save_action', [var_action.dup(), rt.new_null(), var_last_attempt_date.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Action_Scheduler_Migration_Exception') {
		mut var_e := var_e_3.dup()
		rt.call_function('do_action', [rt.new_string('action_scheduler/migrate_action_failed'), var_source_action_id.dup(), this.source, this.destination])
		return 0
		// unsupported statement: Stmt_Nop
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	mut switch_val_1 := var_status
	if rt.is_true(rt.equal(switch_val_1, Class_Action_Scheduler_Migration_ActionScheduler_Store.status_failed())) {
		rt.call_method(this.destination, 'mark_failure', [var_destination_action_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	} else if rt.is_true(rt.equal(switch_val_1, Class_Action_Scheduler_Migration_ActionScheduler_Store.status_canceled())) {
		rt.call_method(this.destination, 'cancel_action', [var_destination_action_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_method(this.log_migrator, 'migrate', [var_source_action_id.dup(), var_destination_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_method(this.source, 'delete_action', [var_source_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_test_action := rt.call_method(this.source, 'fetch_action', [var_source_action_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_test_action.dup(), rt.new_string('ActionScheduler_NullAction')]))))) {
		rt.throw_exception(rt.new_object('Action_Scheduler_Migration_RuntimeException', []string{}, create_action_scheduler_migration_runtimeexception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to remove source migrated action %s'), rt.new_string('woocommerce')]), var_source_action_id.dup()]))))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('do_action', [rt.new_string('action_scheduler/migrated_action'), var_source_action_id.dup(), var_destination_action_id.dup(), this.source, this.destination])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	return (var_destination_action_id).to_i64()
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Action_Scheduler_Migration_Exception') {
		mut var_e := var_e_4.dup()
		rt.call_method(this.source, 'mark_migrated', [var_source_action_id.dup()])
		rt.call_function('do_action', [rt.new_string('action_scheduler/migrate_action_incomplete'), var_source_action_id.dup(), var_destination_action_id.dup(), this.source, this.destination])
		rt.call_function('do_action', [rt.new_string('action_scheduler/migrated_action'), var_source_action_id.dup(), var_destination_action_id.dup(), this.source, this.destination])
		return (var_destination_action_id).to_i64()
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return i64(0)
}

struct Class_Action_Scheduler_Migration_RuntimeException {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_actionmigrator(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Action_Scheduler_Migration_ActionMigrator {
	mut obj := &Class_Action_Scheduler_Migration_ActionMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		source: rt.new_null()
		destination: rt.new_null()
		log_migrator: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_action_scheduler_migration_runtimeexception() &Class_Action_Scheduler_Migration_RuntimeException {
	mut obj := &Class_Action_Scheduler_Migration_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_ActionScheduler_Store](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_ActionScheduler_Store](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Action_Scheduler_Migration_LogMigrator](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.migrate(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_Migration_ActionMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source' { return this.source }
		'destination' { return this.destination }
		'log_migrator' { return this.log_migrator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Action_Scheduler_Migration_ActionMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source' { this.source = val; return true }
		'destination' { this.destination = val; return true }
		'log_migrator' { this.log_migrator = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_migration_actionmigrator_php() {
}
