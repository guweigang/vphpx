import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) get_id() string {
	return 'shipping-recommendation'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Get your products shipped'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) get_content() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) get_time() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) is_complete() bool {
	return
		rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_plugins_active())
		&& rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_jetpack_connected())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) can_view() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('shipping-smart-defaults'))
	return iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) get_action_url() string {
	return ''
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_plugins_active() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_1 := iife_temp_1.is_plugin_active(rt.new_string('woocommerce-shipping'))
	return iife_result_1
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_jetpack_connected() bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{}
	mut iife_result_2 := iife_temp_2.get_manager()
	mut var_jetpack_connection_manager := iife_result_2
	return
		rt.is_true(rt.call_method(var_jetpack_connection_manager, 'is_connected', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_jetpack_connection_manager, 'has_connected_owner', []rt.PhpVal{}))
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_experimentalshippingrecommendation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_jetpack_jetpackconnection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'can_view' {
			return this.can_view()
		}
		'get_action_url' {
			return rt.new_string(this.get_action_url())
		}
		'has_plugins_active' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_plugins_active()
		}
		'has_jetpack_connected' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation.has_jetpack_connected())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_ExperimentalShippingRecommendation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
