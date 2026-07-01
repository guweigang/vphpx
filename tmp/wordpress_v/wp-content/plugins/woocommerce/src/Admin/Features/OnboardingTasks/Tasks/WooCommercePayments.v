import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments {
	rt.PhpObjectBase
pub mut:
		is_complete_result bool
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_id() string {
	return 'woocommerce-payments'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_title() rt.PhpVal {
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Get paid with %s'), rt.new_string('woocommerce')]), rt.new_string('WooPayments')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_badge() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_woopayments_onboarding_task_badge'), rt.new_string('')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('You\'re only one step away from getting paid. Verify your business details to start managing transactions with WooPayments.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_additional_data() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_woopayments_onboarding_task_additional_data'), rt.new_null()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('2 minutes'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_action_label() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Finish setup'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) is_complete() bool {
	if rt.is_true(rt.identical(rt.new_null(), this.is_complete_result)) {
		this.is_complete_result = rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.has_other_ecommerce_gateways()) || rt.is_true(rt.new_bool(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_connected()) && rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_account_partially_onboarded()))))))
	}
	return this.is_complete_result
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) can_view() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_supported()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_requested() bool {
	mut var_profiler_data := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	mut var_product_types := if var_profiler_data.array_isset(rt.new_string('product_types')) { var_profiler_data.array_get('product_types') } else { rt.new_array() }
	mut var_business_extensions := if var_profiler_data.array_isset(rt.new_string('business_extensions')) { var_profiler_data.array_get('business_extensions') } else { rt.new_array() }
	mut var_subscriptions_and_us := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('subscriptions'), var_product_types.dup(), rt.new_bool(true)])) && rt.is_true(rt.identical(rt.new_string('US'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})))))
	return rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_business_extensions.dup(), rt.new_bool(true)])) || rt.is_true(var_subscriptions_and_us)
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_installed() rt.PhpVal {
	mut var_installed_plugins := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installed_plugin_slugs() }()
	return rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_installed_plugins.dup(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_wcpay_active() rt.PhpVal {
	return rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_connected() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_wcpay_active())))) {
		return false
	}
	mut var_wc_payments_gateway := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_gateway()
	if rt.is_true(rt.new_bool(rt.is_true(var_wc_payments_gateway) && rt.is_true(rt.call_function('method_exists', [var_wc_payments_gateway.dup(), rt.new_string('is_connected')])))) {
		return (rt.call_method(var_wc_payments_gateway, 'is_connected', []rt.PhpVal{})).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_account_partially_onboarded() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_wcpay_active())))) {
		return false
	}
	mut var_wc_payments_gateway := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_gateway()
	if rt.is_true(rt.new_bool(rt.is_true(var_wc_payments_gateway) && rt.is_true(rt.call_function('method_exists', [var_wc_payments_gateway.dup(), rt.new_string('is_account_partially_onboarded')])))) {
		return (rt.call_method(var_wc_payments_gateway, 'is_account_partially_onboarded', []rt.PhpVal{})).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_suggestion() rt.PhpVal {
	mut var_suggestions := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init{}; return temp.get_suggestions(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }())
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_suggestion := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_suggestion, 'plugins')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_suggestion, 'plugins').is_array()))))))) {
		return rt.new_bool(false)
	}
	return rt.call_function('in_array', [rt.new_string('woocommerce-payments'), rt.get_property(var_suggestion, 'plugins'), rt.new_bool(true)])
	}
	mut var_wcpay_suggestions := rt.call_function('array_filter', [var_suggestions.dup(), rt.new_closure(closure_1_fn)])
	if !rt.is_true(var_wcpay_suggestions) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_wcpay_suggestions.dup()])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_supported() bool {
	return !(!rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_suggestion()))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_gateway() rt.PhpVal {
	mut var_payment_gateways := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	if var_payment_gateways.array_isset(rt.new_string('woocommerce_payments')) {
		return var_payment_gateways.array_get('woocommerce_payments')
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.has_other_ecommerce_gateways() bool {
	mut var_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_gateway, 'id'), rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Gateway_BACS.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Cheque.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() }]), rt.new_bool(true)])))))
	}
	mut var_enabled_gateways := rt.call_function('array_filter', [var_gateways.dup(), rt.new_closure(closure_2_fn)])
	return !(!rt.is_true(var_enabled_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) get_action_url() rt.PhpVal {
	if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_supported()) {
		if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_wcpay_active()) {
			return rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'wcpay-connect', val: '1' }, rt.ArrayItem{ key: 'from', val: 'WCADMIN_PAYMENT_TASK' }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [rt.new_string('wcpay-connect')]) }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
		}
		if rt.is_true(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage{}; return temp.instance() }(), 'has_incentive', []rt.PhpVal{})) {
			return rt.call_function('add_query_arg', [rt.new_string('from'), rt.new_string('WCADMIN_PAYMENT_TASK'), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/wc-pay-welcome-page')])])
		}
		return rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'task', val: this.get_id() }, rt.ArrayItem{ key: 'id', val: rt.get_property(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_suggestion(), 'id') }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin')])])
	}
	return rt.call_function('add_query_arg', [rt.new_string('task'), this.get_id(), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin')])])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_woocommercepayments() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments{
		PhpObjectBase: rt.PhpObjectBase{}
		is_complete_result: false
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_init() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init{
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

fn create_automattic_woocommerce_internal_admin_wcpaywelcomepage() &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_badge' {
			return this.get_badge()
		}
		'get_content' {
			return this.get_content()
		}
		'get_additional_data' {
			return this.get_additional_data()
		}
		'get_time' {
			return this.get_time()
		}
		'get_action_label' {
			return this.get_action_label()
		}
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'can_view' {
			return this.can_view()
		}
		'is_requested' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_requested())
		}
		'is_installed' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_installed()
		}
		'is_wcpay_active' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_wcpay_active()
		}
		'is_connected' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_connected())
		}
		'is_account_partially_onboarded' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_account_partially_onboarded())
		}
		'get_suggestion' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_suggestion()
		}
		'is_supported' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.is_supported())
		}
		'get_gateway' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.get_gateway()
		}
		'has_other_ecommerce_gateways' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments.has_other_ecommerce_gateways())
		}
		'get_action_url' {
			return this.get_action_url()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_complete_result' { return rt.new_bool(this.is_complete_result) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_WooCommercePayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_complete_result' { this.is_complete_result = (val).to_bool(); return true }
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


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WcPayWelcomePage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_woocommercepayments_php() {
}
