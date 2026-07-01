import rt

struct Class_ActionScheduler_NullLogEntry {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_NullLogEntry) construct(action_id string, message string) {
	// unsupported statement: Stmt_Nop
}

struct Class_ActionScheduler_LogEntry {
	rt.PhpObjectBase
}

fn create_actionscheduler_nulllogentry(action_id string, message string) &Class_ActionScheduler_NullLogEntry {
	mut obj := &Class_ActionScheduler_NullLogEntry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(action_id, message)
	return obj
}

fn create_actionscheduler_logentry() &Class_ActionScheduler_LogEntry {
	mut obj := &Class_ActionScheduler_LogEntry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_NullLogEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_NullLogEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_NullLogEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_LogEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_LogEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_LogEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_nulllogentry_php() {
}
