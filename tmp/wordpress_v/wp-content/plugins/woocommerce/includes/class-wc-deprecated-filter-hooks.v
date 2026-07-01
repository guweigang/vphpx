import rt

struct Class_WC_Deprecated_Filter_Hooks {
	rt.PhpObjectBase
pub mut:
		deprecated_hooks rt.PhpVal = rt.new_array()
		deprecated_version rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) hook_in(var_hook_name rt.PhpVal)  {
	rt.call_function('add_filter', [var_hook_name.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Deprecated_Filter_Hooks', ['WC_Deprecated_Hooks'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_handle_deprecated_hook' }]), // unsupported expression: Expr_UnaryMinus, rt.new_int(8)])
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) handle_deprecated_hook(var_new_hook rt.PhpVal, var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal, var_return_value rt.PhpVal) rt.PhpVal {
	mut var_return_value_mutated := var_return_value
	if rt.is_true(rt.call_function('has_filter', [var_old_hook.dup()])) {
		this.display_notice(var_old_hook.dup(), var_new_hook.dup())
		var_return_value_mutated = this.trigger_hook(var_old_hook.dup(), var_new_callback_args.dup())
	}
	return var_return_value_mutated.dup()
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) trigger_hook(var_old_hook rt.PhpVal, var_new_callback_args rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters_ref_array', [var_old_hook.dup(), var_new_callback_args.dup()])
}

struct Class_WC_Deprecated_Hooks {
	rt.PhpObjectBase
}

fn create_wc_deprecated_filter_hooks() &Class_WC_Deprecated_Filter_Hooks {
	mut obj := &Class_WC_Deprecated_Filter_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
		deprecated_hooks: rt.new_array()
		deprecated_version: rt.new_array()
	}
	return obj
}

fn create_wc_deprecated_hooks() &Class_WC_Deprecated_Hooks {
	mut obj := &Class_WC_Deprecated_Hooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hook_in' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.hook_in(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_deprecated_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.handle_deprecated_hook(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'trigger_hook' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.trigger_hook(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Deprecated_Filter_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deprecated_hooks' { return this.deprecated_hooks }
		'deprecated_version' { return this.deprecated_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Deprecated_Filter_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deprecated_hooks' { this.deprecated_hooks = val; return true }
		'deprecated_version' { this.deprecated_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Deprecated_Hooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Deprecated_Hooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Deprecated_Hooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_deprecated_filter_hooks_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
