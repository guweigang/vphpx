import rt

struct Class_ActionScheduler_InvalidActionException {
	rt.PhpObjectBase
}

fn Class_ActionScheduler_InvalidActionException.from_schedule(var_action_id rt.PhpVal, var_schedule rt.PhpVal) rt.PhpVal {
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Action [%1$s] has an invalid schedule: %2$s'),
			rt.new_string('woocommerce'),
		]),
		var_action_id.dup(),
		rt.call_function('var_export', [
			var_schedule.dup(),
			rt.new_bool(true),
		]),
	])
	return create_static(var_message.dup())
}

fn Class_ActionScheduler_InvalidActionException.from_decoding_args(var_action_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Action [%1$s] has invalid arguments. It cannot be JSON decoded to an array. $args = %2$s'),
			rt.new_string('woocommerce'),
		]),
		var_action_id.dup(),
		rt.call_function('var_export', [
			var_args.dup(),
			rt.new_bool(true),
		]),
	])
	return create_static(var_message.dup())
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_static {
	rt.PhpObjectBase
}

fn create_actionscheduler_invalidactionexception() &Class_ActionScheduler_InvalidActionException {
	mut obj := &Class_ActionScheduler_InvalidActionException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_static() &Class_static {
	mut obj := &Class_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_InvalidActionException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ActionScheduler_InvalidActionException.from_schedule(dispatch_arg_0,
				dispatch_arg_1)
		}
		'from_decoding_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ActionScheduler_InvalidActionException.from_decoding_args(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_InvalidActionException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_InvalidActionException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_invalidactionexception_php() {
}
