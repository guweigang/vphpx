import rt

struct Class_ActionScheduler_Store_Deprecated {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_Store_Deprecated) mark_failed_fetch_action(var_action_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.0.0'), rt.new_string('ActionScheduler_Store::mark_failure()')])
	rt.call_method(rt.get_static_prop('ActionScheduler_Store_Deprecated', 'store'), 'mark_failure', [
		var_action_id.clone(),
	])
}

fn Class_ActionScheduler_Store_Deprecated.hook() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.0.0')])
}

fn Class_ActionScheduler_Store_Deprecated.unhook() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.0.0')])
}

fn (mut this Class_ActionScheduler_Store_Deprecated) get_local_timezone() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('2.1.0'), rt.new_string('ActionScheduler_TimezoneHelper::set_local_timezone()')])
	mut iife_temp_0 := Class_ActionScheduler_TimezoneHelper{}
	mut iife_result_0 := iife_temp_0.get_local_timezone()
	return iife_result_0
}

struct Class_ActionScheduler_TimezoneHelper {
	rt.PhpObjectBase
}

fn create_actionscheduler_store_deprecated(_args ...rt.PhpVal) &Class_ActionScheduler_Store_Deprecated {
	mut obj := &Class_ActionScheduler_Store_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_timezonehelper(_args ...rt.PhpVal) &Class_ActionScheduler_TimezoneHelper {
	mut obj := &Class_ActionScheduler_TimezoneHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Store_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'mark_failed_fetch_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mark_failed_fetch_action(dispatch_arg_0)
			return rt.new_null()
		}
		'hook' {
			Class_ActionScheduler_Store_Deprecated.hook()
			return rt.new_null()
		}
		'unhook' {
			Class_ActionScheduler_Store_Deprecated.unhook()
			return rt.new_null()
		}
		'get_local_timezone' {
			return this.get_local_timezone()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Store_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Store_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_TimezoneHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
