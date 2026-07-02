import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing {
	rt.PhpObjectBase
pub mut:
	is_complete_result rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) construct(var_task_list rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.clone())
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing', [
				'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			], &this) },
			rt.ArrayItem{ key: none, val: 'on_activated_plugin' },
		]),
		rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) on_activated_plugin(var_plugin rt.PhpVal) {
	mut var_plugin_basename := rt.call_function('basename', [
		rt.call_function('plugin_basename', [var_plugin.clone()]),
		rt.new_string('.php'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) get_id() string {
	return 'marketing'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Grow your business'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) get_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Add recommended marketing tools to reach new customers and grow your business'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('2 minutes'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) can_view() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('remote-free-extensions'))
	return iife_result_0
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing.get_plugins() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('9.3.0')])
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing.has_installed_extensions() bool {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('9.3.0')])
	return false
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_marketing(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing{
		PhpObjectBase:      rt.PhpObjectBase{}
		is_complete_result: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'on_activated_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_activated_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return this.get_content()
		}
		'get_time' {
			return this.get_time()
		}
		'can_view' {
			return this.can_view()
		}
		'get_plugins' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing.get_plugins()
		}
		'has_installed_extensions' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing.has_installed_extensions())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_complete_result' { return this.is_complete_result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Marketing) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_complete_result' {
			this.is_complete_result = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
