import rt

pub fn Class_Action_Scheduler_Migration_Scheduler.hook() string {
	return 'action_scheduler/migration_hook'
}
pub fn Class_Action_Scheduler_Migration_Scheduler.group() string {
	return 'action-scheduler-migration'
}
struct Class_Action_Scheduler_Migration_Scheduler {
	rt.PhpObjectBase
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) hook()  {
	rt.call_function('add_action', [Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_migration' }]), rt.new_int(10), rt.new_int(0)])
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) unhook()  {
	rt.call_function('remove_action', [Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Action_Scheduler_Migration_Scheduler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_migration' }]), rt.new_int(10)])
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) run_migration()  {
	mut var_migration_runner := this.get_migration_runner()
	mut var_count := rt.call_method(var_migration_runner, 'run', [this.get_batch_size()])
	if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
		this.mark_complete()
	} else {
		this.schedule_migration((rt.add(rt.call_function('time', []rt.PhpVal{}), this.get_schedule_interval())).to_i64())
	}
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) mark_complete()  {
	this.unschedule_migration()
	fn () rt.PhpVal { mut temp := Class_Action_Scheduler_Migration_ActionScheduler_DataController{}; return temp.mark_migration_complete() }()
	rt.call_function('do_action', [rt.new_string('action_scheduler/migration_complete')])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) is_migration_scheduled() bool {
	mut var_next := rt.call_function('as_next_scheduled_action', [Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook()])
	return !(!rt.is_true(var_next))
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) schedule_migration(when i64) rt.PhpVal {
	mut when_mutated := when
	mut var_next := rt.call_function('as_next_scheduled_action', [Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook()])
	if !(!rt.is_true(var_next)) {
		return var_next.dup()
	}
	if when_mutated == 0 {
		when_mutated = (rt.call_function('time', []rt.PhpVal{}) + rt.get_constant('MINUTE_IN_SECONDS')).to_i64()
	}
	return rt.call_function('as_schedule_single_action', [rt.new_int(when_mutated).dup(), Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook(), rt.new_array(), Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.group()])
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) unschedule_migration()  {
	rt.call_function('as_unschedule_action', [Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.hook(), rt.new_null(), Class_Action_Scheduler_Migration_Action_Scheduler_Migration_Scheduler.group()])
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) get_schedule_interval() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Int
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) get_batch_size() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Int
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) get_migration_runner() rt.PhpVal {
	mut var_config := rt.call_method(fn () rt.PhpVal { mut temp := Class_Action_Scheduler_Migration_Controller{}; return temp.instance() }(), 'get_migration_config_object', []rt.PhpVal{})
	return create_action_scheduler_migration_runner(var_config.dup())
}

struct Class_Action_Scheduler_Migration_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Controller {
	rt.PhpObjectBase
}

struct Class_Action_Scheduler_Migration_Runner {
	rt.PhpObjectBase
}

fn create_action_scheduler_migration_scheduler() &Class_Action_Scheduler_Migration_Scheduler {
	mut obj := &Class_Action_Scheduler_Migration_Scheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_actionscheduler_datacontroller() &Class_Action_Scheduler_Migration_ActionScheduler_DataController {
	mut obj := &Class_Action_Scheduler_Migration_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_controller() &Class_Action_Scheduler_Migration_Controller {
	mut obj := &Class_Action_Scheduler_Migration_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_action_scheduler_migration_runner() &Class_Action_Scheduler_Migration_Runner {
	mut obj := &Class_Action_Scheduler_Migration_Runner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hook' {
			this.hook()
			return rt.new_null()
		}
		'unhook' {
			this.unhook()
			return rt.new_null()
		}
		'run_migration' {
			this.run_migration()
			return rt.new_null()
		}
		'mark_complete' {
			this.mark_complete()
			return rt.new_null()
		}
		'is_migration_scheduled' {
			return rt.new_bool(this.is_migration_scheduled())
		}
		'schedule_migration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.schedule_migration(dispatch_arg_0)
		}
		'unschedule_migration' {
			this.unschedule_migration()
			return rt.new_null()
		}
		'get_schedule_interval' {
			return this.get_schedule_interval()
		}
		'get_batch_size' {
			return this.get_batch_size()
		}
		'get_migration_runner' {
			return this.get_migration_runner()
		}
		else { return none }
	}
}

fn (this &Class_Action_Scheduler_Migration_Scheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Scheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Action_Scheduler_Migration_Runner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Action_Scheduler_Migration_Runner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_migration_scheduler_php() {
}
