import rt

struct Class_ActionScheduler_Abstract_QueueRunner_Deprecated {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner_Deprecated) get_maximum_execution_time() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.1.1'), rt.new_string('ActionScheduler_Abstract_QueueRunner::get_time_limit()')])
	mut var_maximum_execution_time := rt.new_int(30)
	if rt.is_true(rt.call_function('has_filter', [
		rt.new_string('action_scheduler_maximum_execution_time'),
	]))
	{
		rt.call_function('_deprecated_function', [
			rt.new_string('action_scheduler_maximum_execution_time'),
			rt.new_string('2.1.1'),
			rt.new_string('action_scheduler_queue_runner_time_limit'),
		])
		var_maximum_execution_time = rt.call_function('apply_filters', [
			rt.new_string('action_scheduler_maximum_execution_time'),
			var_maximum_execution_time.clone(),
		])
	}
	return rt.call_function('absint', [var_maximum_execution_time.clone()])
}

fn create_actionscheduler_abstract_queuerunner_deprecated(_args ...rt.PhpVal) &Class_ActionScheduler_Abstract_QueueRunner_Deprecated {
	mut obj := &Class_ActionScheduler_Abstract_QueueRunner_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_maximum_execution_time' {
			return this.get_maximum_execution_time()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Abstract_QueueRunner_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
