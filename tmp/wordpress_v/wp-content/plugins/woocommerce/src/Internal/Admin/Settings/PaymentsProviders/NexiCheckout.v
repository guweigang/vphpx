import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_sandbox := rt.new_bool(this.is_nexi_in_sandbox_mode(mut var_payment_gateway))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_null(), var_sandbox)) {
		return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return if rt.is_true(var_sandbox) { !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('dibs_test_key')))) && !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('dibs_test_checkout_key')))) } else { !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('dibs_live_key')))) && !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('dibs_checkout_key')))) }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway has an account connected: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_nexi_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_nexi_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_nexi_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_nexi_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_dev_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_nexi_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_nexi_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) is_nexi_in_sandbox_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (rt.call_function('wc_string_to_bool', [var_payment_gateway.get_option(rt.new_string('test_mode'))])).to_bool()
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is in sandbox mode: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
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

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_nexicheckout() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_in_test_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode(mut dispatch_arg_0))
		}
		'is_in_dev_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_dev_mode(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'is_nexi_in_sandbox_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_nexi_in_sandbox_mode(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_NexiCheckout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_nexicheckout_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
