import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.init() {
	rt.call_function('add_filter', [
		rt.new_string('pre_option_woocommerce_task_list_complete'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [
		rt.new_string('pre_option_woocommerce_task_list_hidden'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [
		rt.new_string('pre_option_woocommerce_extended_task_list_hidden'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [
		rt.new_string('pre_update_option_woocommerce_task_list_complete'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('pre_update_option_woocommerce_task_list_hidden'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('pre_update_option_woocommerce_extended_task_list_hidden'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_deprecated_options' }]),
		rt.new_int(10),
		rt.new_int(3),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.get_deprecated_options(var_pre_option rt.PhpVal, var_option rt.PhpVal) string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_INSTALLING')]))
		&& rt.is_true(rt.identical(rt.get_constant('WC_INSTALLING'), rt.new_bool(true))) {
		return var_pre_option.str()
	}
	mut switch_val_1 := var_option
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_task_list_complete'))) {
		mut var_completed := rt.call_function('get_option', [
			rt.new_string('woocommerce_task_list_completed_lists'),
			rt.new_array(),
		])
		return if var_completed.clone().is_array()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('setup'), var_completed.clone(), rt.new_bool(true)])) {
			'yes'
		} else {
			'no'
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_task_list_hidden'))) {
		mut var_hidden := rt.call_function('get_option', [
			rt.new_string('woocommerce_task_list_hidden_lists'),
			rt.new_array(),
		])
		return if var_hidden.clone().is_array()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('setup'), var_hidden.clone(), rt.new_bool(true)])) {
			'yes'
		} else {
			'no'
		}
	} else if rt.is_true(rt.equal(switch_val_1,
		rt.new_string('woocommerce_extended_task_list_hidden')))
	{
		var_hidden = rt.call_function('get_option', [
			rt.new_string('woocommerce_task_list_hidden_lists'),
			rt.new_array(),
		])
		return if var_hidden.clone().is_array()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('extended'), var_hidden.clone(), rt.new_bool(true)])) {
			'yes'
		} else {
			'no'
		}
	} else {
		return var_pre_option.str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.update_deprecated_options(var_value rt.PhpVal, var_old_value rt.PhpVal, var_option rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_option
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce_task_list_complete'))) {
		mut var_completed := rt.call_function('get_option', [
			rt.new_string('woocommerce_task_list_completed_lists'),
			rt.new_array(),
		])
		if rt.is_true(rt.new_bool(var_completed.clone().is_array())) {
			if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					rt.new_string('setup'),
					var_completed.clone(),
					rt.new_bool(true),
				])))))
				{
					var_completed.array_push('setup')
					rt.call_function('update_option', [
						rt.new_string('woocommerce_task_list_completed_lists'),
						var_completed.clone(),
						rt.new_bool(true),
					])
				}
			} else {
				var_completed = rt.call_function('array_diff', [
					var_completed.clone(), rt.create_array([
						rt.ArrayItem{ key: none, val: 'setup' },
					])])
				rt.call_function('update_option', [
					rt.new_string('woocommerce_task_list_completed_lists'),
					rt.call_function('array_values', [var_completed.clone()]),
					rt.new_bool(true),
				])
			}
			rt.call_function('delete_option', [
				rt.new_string('woocommerce_task_list_complete'),
			])
		}
		return var_old_value.clone()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce_task_list_hidden'))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
		mut iife_result_0 := iife_temp_0.get_list(rt.new_string('setup'))
		mut var_task_list := iife_result_0
		if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
			return var_value.clone()
		}
		mut var_update := if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
			rt.call_method(var_task_list, 'hide', []rt.PhpVal{})
		} else {
			rt.call_method(var_task_list, 'unhide', []rt.PhpVal{})
		}
		rt.call_function('delete_option', [rt.new_string('woocommerce_task_list_hidden')])
		return var_old_value.clone()
	} else if rt.is_true(rt.equal(switch_val_2,
		rt.new_string('woocommerce_extended_task_list_hidden')))
	{
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
		mut iife_result_1 := iife_temp_1.get_list(rt.new_string('extended'))
		var_task_list = iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
			return var_value.clone()
		}
		var_update = if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
			rt.call_method(var_task_list, 'hide', []rt.PhpVal{})
		} else {
			rt.call_method(var_task_list, 'unhide', []rt.PhpVal{})
		}
		rt.call_function('delete_option', [
			rt.new_string('woocommerce_extended_task_list_hidden'),
		])
		return var_old_value.clone()
	} else {
		return var_value.clone()
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedoptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.init()
			return rt.new_null()
		}
		'get_deprecated_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.get_deprecated_options(dispatch_arg_0,
				dispatch_arg_1))
		}
		'update_deprecated_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions.update_deprecated_options(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
