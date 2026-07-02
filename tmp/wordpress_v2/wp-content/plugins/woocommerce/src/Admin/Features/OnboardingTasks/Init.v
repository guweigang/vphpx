import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_onboardingtasks_init() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init', 'instance',
		rt.new_null())
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init',
			'instance', rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_self',
			[]string{}, create_automattic_woocommerce_admin_features_onboardingtasks_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) construct() {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions{}
	mut iife_result_0 := iife_temp_0.init()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_1 := iife_temp_1.init()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_settings() rt.PhpVal {
	mut var_settings := rt.new_array()
	mut var_wc_pay_is_connected := rt.new_bool(false)
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments{}
		mut iife_result_2 := iife_temp_2.get_gateway()
		mut var_wc_payments_gateway := iife_result_2
		var_wc_pay_is_connected = if rt.is_true(rt.call_function('method_exists', [
			var_wc_payments_gateway.clone(),
			rt.new_string('is_connected'),
		]))
		{
			rt.call_method(var_wc_payments_gateway, 'is_connected', []rt.PhpVal{})
		} else {
			rt.new_bool(false)
		}
	}
	return var_settings.clone()
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_init() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn create_automattic_woocommerce_admin_features_onboardingtasks_wc_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_settings' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_settings()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
