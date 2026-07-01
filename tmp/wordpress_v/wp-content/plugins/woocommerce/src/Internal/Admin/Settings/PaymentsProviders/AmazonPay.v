import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_dev_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_amazon_pay_onboarded(mut var_payment_gateway)).is_null() { this.is_amazon_pay_onboarded(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_onboarding_completed(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_amazon_pay_onboarded(mut var_payment_gateway)).is_null() { this.is_amazon_pay_onboarded(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_onboarding_completed(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_amazon_pay_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_amazon_pay_in_sandbox_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Amazon_Payments_Advanced_API')])) && rt.is_true(rt.call_function('is_callable', [rt.new_string('\\WC_Amazon_Payments_Advanced_API::get_settings')])))) {
		mut var_settings := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API{}; return temp.get_settings() }()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if var_settings.array_isset(rt.new_string('sandbox')) {
			return (rt.call_function('wc_string_to_bool', [var_settings.array_get('sandbox')])).to_bool()
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is in sandbox mode: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (rt.new_null()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) is_amazon_pay_onboarded(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Amazon_Payments_Advanced_API')])) && rt.is_true(rt.call_function('is_callable', [rt.new_string('\\WC_Amazon_Payments_Advanced_API::validate_api_settings')])))) {
		return (rt.identical(rt.new_bool(true), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API{}; return temp.validate_api_settings() }())).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is onboarded: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return (rt.new_null()).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_amazonpay() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_wc_amazon_payments_advanced_api() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy() &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_in_test_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode(mut dispatch_arg_0))
		}
		'is_in_dev_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_dev_mode(mut dispatch_arg_0))
		}
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_onboarding_completed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_onboarding_completed(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'is_amazon_pay_in_sandbox_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_amazon_pay_in_sandbox_mode(mut dispatch_arg_0))
		}
		'is_amazon_pay_onboarded' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_amazon_pay_onboarded(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_AmazonPay) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WC_Amazon_Payments_Advanced_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_amazonpay_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
