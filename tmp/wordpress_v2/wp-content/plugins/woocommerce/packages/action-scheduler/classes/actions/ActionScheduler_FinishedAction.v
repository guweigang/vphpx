import rt

struct Class_ActionScheduler_FinishedAction {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_FinishedAction) execute() {
}

fn (mut this Class_ActionScheduler_FinishedAction) is_finished() bool {
	return true
}

struct Class_ActionScheduler_Action {
	rt.PhpObjectBase
}

fn create_actionscheduler_finishedaction(_args ...rt.PhpVal) &Class_ActionScheduler_FinishedAction {
	mut obj := &Class_ActionScheduler_FinishedAction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_action(_args ...rt.PhpVal) &Class_ActionScheduler_Action {
	mut obj := &Class_ActionScheduler_Action{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_FinishedAction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			this.execute()
			return rt.new_null()
		}
		'is_finished' {
			return rt.new_bool(this.is_finished())
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_FinishedAction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_FinishedAction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_Action) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Action) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Action) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
