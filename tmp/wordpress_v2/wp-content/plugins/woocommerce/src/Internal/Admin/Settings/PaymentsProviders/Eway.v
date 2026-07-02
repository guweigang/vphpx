import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('customer_api'))))
		&& !(!rt.is_true(var_payment_gateway.get_option(rt.new_string('customer_password'))))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_0 := iife_temp_0.wc_get_logger()
		rt.call_method(iife_result_0, 'debug', [
			rt.new_string('Failed to determine if gateway has an account connected: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
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
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_eway_in_sandbox_mode(mut var_payment_gateway)).is_null() {
		this.is_eway_in_sandbox_mode(mut var_payment_gateway)
	} else {
		this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway',
			[]string{}, var_payment_gateway))
	}).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_eway_in_sandbox_mode(mut var_payment_gateway)).is_null() {
		this.is_eway_in_sandbox_mode(mut var_payment_gateway)
	} else {
		this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_dev_mode(rt.new_object('WC_Payment_Gateway',
			[]string{}, var_payment_gateway))
	}).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (if !(this.is_eway_in_sandbox_mode(mut var_payment_gateway)).is_null() {
		this.is_eway_in_sandbox_mode(mut var_payment_gateway)
	} else {
		this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway',
			[]string{}, var_payment_gateway))
	}).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) is_eway_in_sandbox_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_raw_option := var_payment_gateway.get_option(rt.new_string('testmode'))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_raw_option))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_raw_option)))) {
		return (rt.call_function('wc_string_to_bool', [var_raw_option.clone()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !(rt.get_property(var_payment_gateway, 'testmode')).is_null() {
		return (rt.call_function('wc_string_to_bool', [
			rt.get_property(var_payment_gateway, 'testmode'),
		])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.clone()
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_1 := iife_temp_1.wc_get_logger()
		rt.call_method(iife_result_1, 'debug', [
			rt.new_string('Failed to determine if gateway is in sandbox mode: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_eway(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_in_test_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_in_test_mode(mut dispatch_arg_0))
		}
		'is_in_dev_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_in_dev_mode(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'is_eway_in_sandbox_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_eway_in_sandbox_mode(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Eway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
