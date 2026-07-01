import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) get_id() string {
	return 'store_details'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) get_title() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_bool(true), this.get_parent_option(rt.new_string('use_completed_title')))) {
		if this.is_complete() {
			return rt.call_function('__', [rt.new_string('You added store details'), rt.new_string('woocommerce')])
		}
		return rt.call_function('__', [rt.new_string('Add store details'), rt.new_string('woocommerce')])
	}
	return rt.call_function('__', [rt.new_string('Store details'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) get_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Your store address is required to set the origin country for shipping, currencies, and payment options.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('4 minutes'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) get_action_url() rt.PhpVal {
	return if !(this.is_complete()) { rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=general&tutorial=true')]) } else { rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=general')]) }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) is_complete() bool {
	mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_country_locale := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_locale', []rt.PhpVal{})
	mut var_locale := if !(var_country_locale.array_get(var_country)).is_null() { var_country_locale.array_get(var_country) } else { rt.new_array() }
	mut var_hide_postcode := if !(var_locale.array_get('postcode').array_get('hidden')).is_null() { var_locale.array_get('postcode').array_get('hidden') } else { rt.new_bool(false) }
	if rt.is_true(var_hide_postcode) {
		return rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
	}
	return rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_storedetails() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_action_url' {
			return this.get_action_url()
		}
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_StoreDetails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_storedetails_php() {
}
