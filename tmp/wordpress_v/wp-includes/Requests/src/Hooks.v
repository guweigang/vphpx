import rt

struct Class_WpOrg_Requests_Hooks {
	rt.PhpObjectBase
pub mut:
	hooks rt.PhpVal = rt.new_array()
}

fn (mut this Class_WpOrg_Requests_Hooks) register(var_hook rt.PhpVal, var_callback rt.PhpVal, priority i64) {
	if rt.is_true(rt.identical(rt.new_bool(var_hook.dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(1), rt.new_string('$hook'), rt.new_string('string'), rt.call_function('gettype', [
			var_hook.dup(),
		])))
	}
	if rt.is_true(rt.identical(rt.call_function('is_callable', [
		var_callback.dup()]), rt.new_bool(false)))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(2), rt.new_string('$callback'), rt.new_string('callable'), rt.call_function('gettype', [
			var_callback.dup(),
		])))
	}
	if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WpOrg_Requests_Utility_InputValidator{}
		return temp.is_numeric_array_key(arg_0)
	}(rt.new_int(priority)), rt.new_bool(false)))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(3), rt.new_string('$priority'), rt.new_string('integer'), rt.call_function('gettype', [
			rt.new_int(priority),
		])))
	}
	if !(this.hooks.array_isset(var_hook)) {
		this.hooks.array_set(var_hook, rt.create_array([
			rt.ArrayItem{ key: priority, val: rt.new_array() },
		]))
	} else if !(this.hooks.array_get(var_hook).array_isset(rt.new_int(priority))) {
		this.hooks.array_get_mut(var_hook).array_set(priority, rt.new_array())
	}
	this.hooks.array_get_mut(var_hook).array_get_mut(priority).array_push(var_callback.dup())
}

fn (mut this Class_WpOrg_Requests_Hooks) dispatch(var_hook rt.PhpVal, var_parameters rt.PhpVal) bool {
	mut var_parameters_mutated := var_parameters
	if rt.is_true(rt.identical(rt.new_bool(var_hook.dup().is_string()), rt.new_bool(false))) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(1), rt.new_string('$hook'), rt.new_string('string'), rt.call_function('gettype', [
			var_hook.dup(),
		])))
	}
	if rt.is_true(rt.identical(rt.new_bool(var_parameters_mutated.dup().is_array()),
		rt.new_bool(false)))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(2), rt.new_string('$parameters'), rt.new_string('array'), rt.call_function('gettype', [
			var_parameters_mutated.dup(),
		])))
	}
	if !rt.is_true(this.hooks.array_get(var_hook)) {
		return false
	}
	if !(!rt.is_true(var_parameters_mutated)) {
		var_parameters_mutated = rt.call_function('array_values', [
			var_parameters_mutated.dup()])
	}
	rt.call_function('ksort', [this.hooks.array_get(var_hook)])
	{
		mut iter_1 := this.hooks.array_get(var_hook).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_hooked := item_1.val
			mut var_priority := item_1.key
			{
				mut iter_2 := var_hooked.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_callback := item_2.val
					rt.call_callable(var_callback, [var_parameters_mutated.dup()])
				}
			}
		}
	}
	return true
}

fn (mut this Class_WpOrg_Requests_Hooks) magic_wakeup() {
	rt.throw_exception(rt.new_object('WpOrg_Requests_LogicException', []string{}, create_wporg_requests_logicexception(
		@STRUCT + ' should never be unserialized')))
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_LogicException {
	rt.PhpObjectBase
}

fn create_wporg_requests_hooks() &Class_WpOrg_Requests_Hooks {
	mut obj := &Class_WpOrg_Requests_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
		hooks:         rt.new_array()
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator() &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_logicexception() &Class_WpOrg_Requests_LogicException {
	mut obj := &Class_WpOrg_Requests_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.register(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'dispatch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.dispatch(dispatch_arg_0, dispatch_arg_1))
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hooks' { return this.hooks }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hooks' {
			this.hooks = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_includes_requests_src_hooks_php() {
}
