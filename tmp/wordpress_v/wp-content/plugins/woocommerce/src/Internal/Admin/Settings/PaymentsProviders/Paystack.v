import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) needs_setup(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_is_valid_for_use := rt.new_bool(rt.new_bool(true))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_valid_for_use' }])])) {
		var_is_valid_for_use = rt.call_function('wc_string_to_bool', [var_payment_gateway.is_valid_for_use()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.is_true(rt.new_bool(!(rt.is_true(var_is_valid_for_use)))) || !(this.is_account_connected(mut var_payment_gateway))
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway needs setup: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.needs_setup(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_payment_gateway, rt.new_string('public_key')])) && !(!rt.is_true(rt.get_property(var_payment_gateway, 'public_key'))))) && rt.is_true(rt.call_function('property_exists', [var_payment_gateway, rt.new_string('secret_key')])))) && !(!rt.is_true(rt.get_property(var_payment_gateway, 'secret_key')))
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway has an account connected: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (this.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paystack() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack{
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

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy() &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'needs_setup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.needs_setup(mut dispatch_arg_0))
		}
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Paystack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_paystack_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
