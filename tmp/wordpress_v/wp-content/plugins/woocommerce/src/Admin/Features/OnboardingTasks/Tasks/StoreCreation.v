import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) get_id() string {
	return 'store_creation'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) get_title() rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('You created %s'),
			rt.new_string('woocommerce')]),
		rt.call_function('get_bloginfo', [rt.new_string('name')]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) get_content() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) get_time() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) get_action_url() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) is_complete() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) is_disabled() bool {
	return true
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_storecreation() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_time' {
			return rt.new_string(this.get_time())
		}
		'get_action_url' {
			return rt.new_string(this.get_action_url())
		}
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'is_disabled' {
			return rt.new_bool(this.is_disabled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreCreation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_storecreation_php() {
}
