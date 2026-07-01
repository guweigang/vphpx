import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments {
	rt.PhpObjectBase
pub mut:
		is_complete_result rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_id() string {
	return 'payments'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Set up payments'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Choose payment providers and enable payment methods at checkout.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('5 minutes'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_complete() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.is_complete_result)) {
		if this.is_woopayments_active() {
			this.is_complete_result = rt.new_bool(this.is_woopayments_onboarded() && !(this.has_woopayments_test_account()))
		} else {
			this.is_complete_result = Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments.has_gateways()
		}
	}
	return this.is_complete_result
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) can_view() bool {
	return true
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments.has_gateways() bool {
	mut var_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled'))).to_bool()
	}
	mut var_enabled_gateways := rt.call_function('array_filter', [var_gateways.dup(), rt.new_closure(closure_1_fn)])
	return !(!rt.is_true(var_enabled_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_in_progress() bool {
	if rt.is_true(this.is_complete()) {
		return false
	}
	return this.has_woopayments_live_account_in_progress() || this.has_woopayments_test_account()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) in_progress_label() rt.PhpVal {
	if this.has_woopayments_live_account_in_progress() {
		return rt.call_function('esc_html__', [rt.new_string('Action needed'), rt.new_string('woocommerce')])
	}
	return rt.call_function('esc_html__', [rt.new_string('Test account'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_action_url() rt.PhpVal {
	return rt.call_function('admin_url', ['admin.php?page=wc-settings&tab=checkout&from=' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_task()).str()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_additional_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'wooPaymentsIsActive', val: this.is_woopayments_active() }, rt.ArrayItem{ key: 'wooPaymentsIsInstalled', val: this.is_woopayments_installed() }, rt.ArrayItem{ key: 'wooPaymentsSettingsCountryIsSupported', val: this.is_woopayments_supported_country(this.get_payments_settings_country()) }, rt.ArrayItem{ key: 'wooPaymentsIsOnboarded', val: this.is_woopayments_onboarded() }, rt.ArrayItem{ key: 'wooPaymentsHasTestAccount', val: this.has_woopayments_test_account() }, rt.ArrayItem{ key: 'wooPaymentsHasOtherProvidersEnabled', val: this.has_providers_enabled_other_than_woopayments() }, rt.ArrayItem{ key: 'wooPaymentsHasOtherProvidersNeedSetup', val: this.has_providers_needing_setup_other_than_woopayments() }, rt.ArrayItem{ key: 'wooPaymentsHasOnlineGatewaysEnabled', val: this.has_online_gateways() }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_woopayments_active() bool {
	return (rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_woopayments_installed() bool {
	if this.is_woopayments_active() {
		return true
	}
	mut var_woopayments_suggestion := this.get_woopayments_suggestion()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woopayments_suggestion)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_woopayments_suggestion.array_get('plugin').array_get('status'))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed(), var_woopayments_suggestion.array_get('plugin').array_get('status'))))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_woopayments_onboarded() bool {
	if !(this.is_woopayments_active()) {
		return false
	}
	mut var_woopayments_provider := this.get_woopayments_provider()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woopayments_provider)))) {
		return false
	}
	if !(!rt.is_true(var_woopayments_provider.array_get('onboarding').array_get('state').array_get('completed'))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) has_woopayments_live_account_in_progress() bool {
	if this.is_woopayments_onboarded() {
		return false
	}
	mut var_woopayments_provider := this.get_woopayments_provider()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woopayments_provider)))) {
		return false
	}
	if this.has_woopayments_test_account() {
		return false
	}
	if !(!rt.is_true(var_woopayments_provider.array_get('onboarding').array_get('state').array_get('started'))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) has_woopayments_test_account() bool {
	if !(this.is_woopayments_onboarded()) {
		return false
	}
	mut var_woopayments_provider := this.get_woopayments_provider()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woopayments_provider)))) {
		return false
	}
	if !(!rt.is_true(var_woopayments_provider.array_get('onboarding').array_get('state').array_get('test_drive_account'))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) is_woopayments_supported_country(country_code string) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments_Utils')])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: '\\WC_Payments_Utils' }, rt.ArrayItem{ key: none, val: 'supported_countries' }])])))) {
		mut var_supported_countries := rt.func_array_keys(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils{}; return temp.supported_countries() }())
		return (rt.call_function('in_array', [rt.new_string(country_code), var_supported_countries.dup(), rt.new_bool(true)])).to_bool()
	}
	var_supported_countries = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_wcpay_countries() }()
	return (rt.call_function('in_array', [rt.new_string(country_code), var_supported_countries.dup(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) has_providers_enabled_other_than_woopayments() bool {
	mut var_providers := this.get_payments_providers()
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_provider.array_get('state').array_get('enabled'))) && !(!rt.is_true(var_provider.array_get('id'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) has_providers_needing_setup_other_than_woopayments() bool {
	mut var_providers := this.get_payments_providers()
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_provider.array_get('state').array_get('needs_setup'))) && !(!rt.is_true(var_provider.array_get('id'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) has_online_gateways() bool {
	mut var_providers := this.get_payments_providers()
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_provider.array_get('state').array_get('enabled'))) && !(!rt.is_true(var_provider.array_get('id'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_provider.array_get('id'), rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Gateway_BACS.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Cheque.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() }]), rt.new_bool(true)]))))))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_payments_settings_country() string {
	mut var_settings_payments_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.class()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return (rt.call_method(var_settings_payments_service, 'get_country', []rt.PhpVal{})).str()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Throwable') {
		mut var_e := var_e_1.dup()
		return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})).str()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_payments_providers() rt.PhpVal {
	mut var_settings_payments_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.class()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.call_method(var_settings_payments_service, 'get_payment_providers', [rt.call_method(var_settings_payments_service, 'get_country', []rt.PhpVal{}), rt.new_bool(false), rt.new_bool(true)])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Throwable') {
		mut var_e := var_e_2.dup()
		return rt.new_array()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_payments_extension_suggestions() rt.PhpVal {
	mut var_settings_payments_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.class()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return rt.call_method(var_settings_payments_service, 'get_payment_extension_suggestions', [rt.call_method(var_settings_payments_service, 'get_country', []rt.PhpVal{})])
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Throwable') {
		mut var_e := var_e_3.dup()
		return rt.new_array()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_woopayments_provider() rt.PhpVal {
	mut var_providers := this.get_payments_providers()
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_provider.array_get('id'))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id(), var_provider.array_get('id'))))) {
				return var_provider.dup()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) get_woopayments_suggestion() rt.PhpVal {
	mut var_providers := this.get_payments_providers()
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_provider.array_get('_type'))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_suggestion(), var_provider.array_get('_type'))))) && !(!rt.is_true(var_provider.array_get('_suggestion_id'))))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(), var_provider.array_get('_suggestion_id'))))) {
				return var_provider.dup()
			}
		}
	}
	mut var_suggestions := this.get_payments_extension_suggestions()
	{
		mut iter_1 := var_suggestions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_suggestion := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_suggestion.array_get('id'))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(), var_suggestion.array_get('id'))))) {
				return var_suggestion.dup()
			}
		}
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_payments() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
		is_complete_result: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_wc_payments_utils() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'has_gateways' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments.has_gateways())
		}
		'is_in_progress' {
			return rt.new_bool(this.is_in_progress())
		}
		'in_progress_label' {
			return this.in_progress_label()
		}
		'get_action_url' {
			return this.get_action_url()
		}
		'get_additional_data' {
			return this.get_additional_data()
		}
		'is_woopayments_active' {
			return rt.new_bool(this.is_woopayments_active())
		}
		'is_woopayments_installed' {
			return rt.new_bool(this.is_woopayments_installed())
		}
		'is_woopayments_onboarded' {
			return rt.new_bool(this.is_woopayments_onboarded())
		}
		'has_woopayments_live_account_in_progress' {
			return rt.new_bool(this.has_woopayments_live_account_in_progress())
		}
		'has_woopayments_test_account' {
			return rt.new_bool(this.has_woopayments_test_account())
		}
		'is_woopayments_supported_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_woopayments_supported_country(dispatch_arg_0))
		}
		'has_providers_enabled_other_than_woopayments' {
			return rt.new_bool(this.has_providers_enabled_other_than_woopayments())
		}
		'has_providers_needing_setup_other_than_woopayments' {
			return rt.new_bool(this.has_providers_needing_setup_other_than_woopayments())
		}
		'has_online_gateways' {
			return rt.new_bool(this.has_online_gateways())
		}
		'get_payments_settings_country' {
			return rt.new_string(this.get_payments_settings_country())
		}
		'get_payments_providers' {
			return this.get_payments_providers()
		}
		'get_payments_extension_suggestions' {
			return this.get_payments_extension_suggestions()
		}
		'get_woopayments_provider' {
			return this.get_woopayments_provider()
		}
		'get_woopayments_suggestion' {
			return this.get_woopayments_suggestion()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_complete_result' { return this.is_complete_result }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_complete_result' { this.is_complete_result = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WC_Payments_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_payments_php() {
	// unsupported statement: Stmt_Declare
}
