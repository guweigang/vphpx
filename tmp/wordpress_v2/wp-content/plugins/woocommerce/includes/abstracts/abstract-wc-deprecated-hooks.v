import rt

struct Class_WC_Deprecated_Hooks {
	rt.PhpObjectBase
pub mut:
	deprecated_hooks   rt.PhpVal = rt.new_array()
	deprecated_version rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Deprecated_Hooks) construct() {
	mut var_new_hooks := rt.func_array_keys(this.deprecated_hooks)
	rt.call_function('array_walk', [var_new_hooks.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Deprecated_Hooks', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hook_in' },
		])])
}

fn (mut this Class_WC_Deprecated_Hooks) hook_in(var_hook_name rt.PhpVal) {
}

fn (mut this Class_WC_Deprecated_Hooks) get_old_hooks(var_new_hook rt.PhpVal) rt.PhpVal {
	mut var_new_hook_mutated := var_new_hook
	mut var_old_hooks := if this.deprecated_hooks.array_isset(var_new_hook_mutated) {
		this.deprecated_hooks.array_get(var_new_hook_mutated)
	} else {
		rt.new_array()
	}
	var_old_hooks = if var_old_hooks.clone().is_array() { var_old_hooks } else { rt.create_array([
			rt.ArrayItem{ key: none, val: var_old_hooks },
		]) }
	return var_old_hooks.clone()
}

fn (mut this Class_WC_Deprecated_Hooks) maybe_handle_deprecated_hook() rt.PhpVal {
	mut var_new_hook := rt.call_function('current_filter', []rt.PhpVal{})
	mut var_old_hooks := this.get_old_hooks(var_new_hook.clone())
	mut var_new_callback_args := rt.call_function('func_get_args', []rt.PhpVal{})
	mut var_return_value := var_new_callback_args.array_get(rt.new_int(0))
	mut iter_1 := var_old_hooks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_old_hook := item_1.val
		var_return_value = this.handle_deprecated_hook(var_new_hook.clone(), var_old_hook.clone(),
			var_new_callback_args.clone(), var_return_value.clone())
	}
	return var_return_value.clone()
}

fn (mut this Class_WC_Deprecated_Hooks) handle_deprecated_hook(var_new_hook rt.PhpVal, var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal, var_return_value rt.PhpVal) {
	mut var_new_hook_mutated := var_new_hook
	mut var_new_callback_args_mutated := var_new_callback_args
	mut var_return_value_mutated := var_return_value
}

fn (mut this Class_WC_Deprecated_Hooks) get_deprecated_version(var_old_hook rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	return if !(!rt.is_true(this.deprecated_version.array_get(var_old_hook))) {
		this.deprecated_version.array_get(var_old_hook)
	} else {
		iife_result_0
	}
}

fn (mut this Class_WC_Deprecated_Hooks) display_notice(var_old_hook rt.PhpVal, var_new_hook rt.PhpVal) {
	mut var_new_hook_mutated := var_new_hook
	rt.call_function('wc_deprecated_hook', [
		rt.call_function('esc_html', [var_old_hook.clone()]),
		rt.call_function('esc_html', [this.get_deprecated_version(var_old_hook.clone())]),
		rt.call_function('esc_html', [var_new_hook_mutated.clone()]),
	])
}

fn (mut this Class_WC_Deprecated_Hooks) trigger_hook(var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal) {
	mut var_new_callback_args_mutated := var_new_callback_args
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_deprecated_hooks() &Class_WC_Deprecated_Hooks {
	mut obj := &Class_WC_Deprecated_Hooks{
		PhpObjectBase:      rt.PhpObjectBase{}
		deprecated_hooks:   rt.new_array()
		deprecated_version: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Deprecated_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'hook_in' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.hook_in(dispatch_arg_0)
			return rt.new_null()
		}
		'get_old_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_old_hooks(dispatch_arg_0)
		}
		'maybe_handle_deprecated_hook' {
			return this.maybe_handle_deprecated_hook()
		}
		'handle_deprecated_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.handle_deprecated_hook(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'get_deprecated_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_deprecated_version(dispatch_arg_0)
		}
		'display_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_notice(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'trigger_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger_hook(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Deprecated_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deprecated_hooks' { return this.deprecated_hooks }
		'deprecated_version' { return this.deprecated_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Deprecated_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deprecated_hooks' {
			this.deprecated_hooks = val
			return true
		}
		'deprecated_version' {
			this.deprecated_version = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
