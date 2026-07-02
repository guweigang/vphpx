import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments {
	rt.PhpObjectBase
pub mut:
	is_complete_result rt.PhpVal = rt.new_null()
	can_view_result    bool
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_id() string {
	return 'payments'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Set up additional payment options'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Choose payment providers and enable payment methods at checkout.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('2 minutes'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) is_complete() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.is_complete_result)) {
		this.is_complete_result = this.has_enabled_non_psp_payment_suggestion()
	}
	return this.is_complete_result
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) can_view() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.can_view_result)))) {
		return this.can_view_result
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments{}
	mut iife_result_0 := iife_temp_0.has_gateways()
	if rt.is_true(iife_result_0) {
		this.can_view_result = true
	} else {
		this.can_view_result = false
	}
	return this.can_view_result
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_action_url() string {
	return (rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-settings&tab=checkout&other_pes_section=expanded&from=' +(Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_additional_payments_task()).str()),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) has_enabled_non_psp_payment_suggestion() bool {
	mut var_providers := this.get_payment_providers()
	mut iter_1 := var_providers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_provider := item_1.val
		if !(!rt.is_true(var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('enabled'))))
			&& !(!rt.is_true(var_provider.array_get(rt.new_string('_suggestion_category_id'))))
			&& rt.is_true(rt.call_function('in_array', [var_provider.array_get(rt.new_string('_suggestion_category_id')), rt.create_array([rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_bnpl()
		}, rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_express_checkout()
		}, rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_crypto()
		}]), rt.new_bool(true)])) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) get_payment_providers() rt.PhpVal {
	mut var_settings_payments_service := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_providers := rt.call_method(var_settings_payments_service, 'get_payment_providers', [
		rt.call_method(var_settings_payments_service, 'get_country', []rt.PhpVal{}),
		rt.new_bool(false),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Throwable')
	{
		mut var_e := var_e_1.clone()
		var_providers = rt.new_array()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return var_providers.clone()
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_additionalpayments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments{
		PhpObjectBase:      rt.PhpObjectBase{}
		is_complete_result: rt.new_null()
		can_view_result:    false
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return rt.new_bool(this.can_view())
		}
		'get_action_url' {
			return rt.new_string(this.get_action_url())
		}
		'has_enabled_non_psp_payment_suggestion' {
			return rt.new_bool(this.has_enabled_non_psp_payment_suggestion())
		}
		'get_payment_providers' {
			return this.get_payment_providers()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_complete_result' { return this.is_complete_result }
		'can_view_result' { return rt.new_bool(this.can_view_result) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_AdditionalPayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_complete_result' {
			this.is_complete_result = val
			return true
		}
		'can_view_result' {
			this.can_view_result = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
