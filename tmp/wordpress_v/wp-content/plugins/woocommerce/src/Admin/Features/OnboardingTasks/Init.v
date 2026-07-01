import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) construct()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions{}; return temp.init() }()
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.init() }()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init.get_settings() rt.PhpVal {
	mut var_settings := rt.new_array()
	mut var_wc_pay_is_connected := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])) {
		mut var_wc_payments_gateway := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments{}; return temp.get_gateway() }()
		var_wc_pay_is_connected = if rt.is_true(rt.call_function('method_exists', [var_wc_payments_gateway.dup(), rt.new_string('is_connected')])) { rt.call_method(var_wc_payments_gateway, 'is_connected', []rt.PhpVal{}) } else { rt.new_bool(false) }
	}
	return var_settings.dup()
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
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedoptions() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_wc_payments() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_WC_Payments {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_init_php() {
}
