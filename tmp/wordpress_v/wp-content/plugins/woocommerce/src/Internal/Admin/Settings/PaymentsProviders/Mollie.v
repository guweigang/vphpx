import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) get_settings_url(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	if rt.is_true(rt.identical(rt.new_string('mollie_stand_in'), rt.get_property(var_payment_gateway, 'id'))) {
		return this.get_custom_settings_url('')
	}
	return this.get_custom_settings_url('mollie_payment_methods')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_sandbox_mode := rt.new_bool(this.is_mollie_in_sandbox_mode(mut var_payment_gateway))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.identical(rt.new_bool(true), var_sandbox_mode)) {
		return !(!rt.is_true(rt.call_function('get_option', [rt.new_string('mollie-payments-for-woocommerce_test_api_key'), rt.new_string('')])))
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_sandbox_mode)) {
		return !(!rt.is_true(rt.call_function('get_option', [rt.new_string('mollie-payments-for-woocommerce_live_api_key'), rt.new_string('')])))
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_mollie_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_mollie_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_mollie_in_sandbox_mode(mut var_payment_gateway)).is_null() { this.is_mollie_in_sandbox_mode(mut var_payment_gateway) } else { this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)) }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) is_gateway_registered(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) bool {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.call_function('str_starts_with', [rt.get_property(var_gateway, 'id'), rt.new_string('mollie_wc_gateway_')])).to_bool()
	}
	mut var_mollie_gateways := rt.call_function('array_filter', [var_payment_gateways, rt.new_closure(closure_1_fn)])
	return !(!rt.is_true(var_mollie_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) get_pseudo_gateway(mut var_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	return create_automattic_woocommerce_internal_admin_settings_paymentsproviders_pseudowcpaymentgateway(rt.new_string('mollie_stand_in'), rt.create_array([rt.ArrayItem{ key: 'method_title', val: var_suggestion.array_get('title') }, rt.ArrayItem{ key: 'method_description', val: var_suggestion.array_get('description') }, rt.ArrayItem{ key: 'enabled', val: false }, rt.ArrayItem{ key: 'needs_setup', val: true }, rt.ArrayItem{ key: 'test_mode', val: false }, rt.ArrayItem{ key: 'dev_mode', val: false }, rt.ArrayItem{ key: 'account_connected', val: false }, rt.ArrayItem{ key: 'onboarding_started', val: false }, rt.ArrayItem{ key: 'onboarding_completed', val: false }, rt.ArrayItem{ key: 'settings_url', val: this.get_custom_settings_url('') }, rt.ArrayItem{ key: 'plugin_slug', val: var_suggestion.array_get('plugin').array_get('slug') }, rt.ArrayItem{ key: 'plugin_file', val: var_suggestion.array_get('plugin').array_get('file') }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) get_custom_settings_url(section string) string {
	mut var_settings_url := rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=mollie_settings')])
	if !(section == '') {
		var_settings_url = rt.call_function('add_query_arg', [rt.new_string('section'), rt.new_string(section), var_settings_url.dup()])
	}
	return (var_settings_url).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) is_mollie_in_sandbox_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (rt.call_function('filter_var', [rt.call_function('get_option', [rt.new_string('mollie-payments-for-woocommerce_test_mode_enabled'), rt.new_string('yes')]), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).to_bool()
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

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_mollie() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie{
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_pseudowcpaymentgateway() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_settings_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_settings_url(mut dispatch_arg_0))
		}
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_in_test_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'is_gateway_registered' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_gateway_registered(mut dispatch_arg_0))
		}
		'get_pseudo_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_pseudo_gateway(mut dispatch_arg_0)
		}
		'get_custom_settings_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_custom_settings_url(dispatch_arg_0))
		}
		'is_mollie_in_sandbox_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_mollie_in_sandbox_mode(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Mollie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PseudoWCPaymentGateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_mollie_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
