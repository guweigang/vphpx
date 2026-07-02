import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.prefix() string {
	return 'woocommerce_admin_settings_payments__woopayments__'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_details(mut var_gateway Class_WC_Payment_Gateway, order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_details := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_details(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_gateway), rt.new_int(order), rt.new_string(country_code_mutated))
	mut var_has_test_account := rt.new_bool(this.has_test_account())
	mut var_has_sandbox_account := rt.new_bool(this.has_sandbox_account())
	var_details.array_get_mut('onboarding').array_set('type',
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native())
	var_details.array_get_mut('onboarding').array_get_mut('state').array_set('test_drive_account',
		var_has_test_account.clone())
	var_details.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [
		var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')),
		this.get_wpcom_connection_state(),
	]))
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('WCPAY_VERSION_NUMBER'))
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WCPAY_VERSION_NUMBER'))
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WCPAY_VERSION_NUMBER'))
	if rt.is_true(iife_result_0)
		&& rt.is_true(rt.call_function('version_compare', [iife_result_1, Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version(), rt.new_string('<')])) {
		return var_details.clone()
	}
	var_details.array_get_mut('onboarding').array_set('type',
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_3 := iife_temp_3.wc_payments_settings_url(rt.new_string('/woopayments/onboarding'), rt.create_array([
		rt.ArrayItem{
			key: 'from'
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_settings()
		},
	]))
	var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('onboard', rt.create_array([
		rt.ArrayItem{ key: 'href', val: iife_result_3 },
	]))
	mut var_rest_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_has_test_account) || rt.is_true(var_has_sandbox_account) {
		var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('disable_test_account', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_method(var_rest_controller, 'get_rest_url_path', [
					rt.new_string('onboarding/test_account/disable'),
				]),
			]) },
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('reset', rt.create_array([
		rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
			rt.call_method(var_rest_controller, 'get_rest_url_path', [
				rt.new_string('onboarding/reset'),
			]),
		]) },
	]))
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
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_4 := iife_temp_4.wc_get_logger()
		rt.call_method(iife_result_4, 'error', [
			rt.new_string('Failed to get the WooPayments REST controller instance: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
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
	if !(country_code_mutated == '') {
		mut var_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.class(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(!var_rest_controller.is_null()) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException',
				[]string{},
				create_automattic_woocommerce_internal_admin_settings_paymentsproviders_runtimeexception(rt.new_string('WooPayments REST controller not available'))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		mut var_onboarding_details := rt.call_method(var_service, 'get_onboarding_details', [
			rt.new_string(country_code_mutated).clone(),
			rt.call_method(var_rest_controller, 'get_rest_url_path', [
				rt.new_string('onboarding'),
			]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(!rt.is_true(var_onboarding_details.array_get(rt.new_string('state'))))
			&& var_onboarding_details.array_get(rt.new_string('state')).is_array() {
			var_details.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [
				var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')),
				var_onboarding_details.array_get(rt.new_string('state')),
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(!rt.is_true(var_onboarding_details.array_get(rt.new_string('messages'))))
			&& var_onboarding_details.array_get(rt.new_string('messages')).is_array() {
			if !(var_details.array_get(rt.new_string('onboarding')).array_isset(rt.new_string('messages')))
				|| !(var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('messages')).is_array()) {
				var_details.array_get_mut('onboarding').array_set('messages', rt.new_array())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			var_details.array_get_mut('onboarding').array_set('messages', rt.call_function('array_merge', [
				var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('messages')),
				var_onboarding_details.array_get(rt.new_string('messages')),
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(!rt.is_true(var_onboarding_details.array_get(rt.new_string('steps'))))
			&& var_onboarding_details.array_get(rt.new_string('steps')).is_array() {
			var_details.array_get_mut('onboarding').array_set('steps',
				var_onboarding_details.array_get(rt.new_string('steps')))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !(!rt.is_true(var_onboarding_details.array_get(rt.new_string('context'))))
			&& var_onboarding_details.array_get(rt.new_string('context')).is_array() {
			if !(var_details.array_get(rt.new_string('onboarding')).array_isset(rt.new_string('context')))
				|| !(var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('context')).is_array()) {
				var_details.array_get_mut('onboarding').array_set('context', rt.new_array())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			var_details.array_get_mut('onboarding').array_set('context', rt.call_function('array_merge', [
				var_details.array_get(rt.new_string('onboarding')).array_get(rt.new_string('context')),
				var_onboarding_details.array_get(rt.new_string('context')),
			]))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
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
			var_e = var_e_2.clone()
			mut iife_temp_5 :=
				Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
			mut iife_result_5 := iife_temp_5.wc_get_logger()
			rt.call_method(iife_result_5, 'error', [
				rt.new_string('Failed to get the WooPayments service instance: ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
				rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
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
	}
	return var_details.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
	var_extension_suggestion_mutated = this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.enhance_extension_suggestion(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array',
		[]string{}, var_extension_suggestion_mutated))
	if !(!rt.is_true(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))))
		&& var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_isset(rt.new_string('status'))
		&& rt.is_true(rt.call_function('in_array', [var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('status')), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed()
	}, rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active()
	}]), rt.new_bool(true)])) {
		mut var_plugin_data := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [
			Class_Automattic_WooCommerce_Admin_PluginsHelper.class(),
			rt.new_string('get_plugin_data'),
			rt.new_string(
				(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))).str() + '.php'),
		])
		if rt.is_true(var_plugin_data)
			&& !(!rt.is_true(var_plugin_data.array_get(rt.new_string('Version'))))
			&& rt.is_true(rt.call_function('version_compare', [var_plugin_data.array_get(rt.new_string('Version')), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version(), rt.new_string('>=')])) {
			var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type',
				Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
		}
	} else {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type',
			Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
	}
	if !(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_isset(rt.new_string('state')))
		|| !(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')).is_array()) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('state',
			rt.new_array())
	}
	var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [
		var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')),
		this.get_wpcom_connection_state(),
	]))
	if !rt.is_true(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_get(rt.new_string('_links')))
		|| !(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_get(rt.new_string('_links')).is_array()) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('_links',
			rt.new_array())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')).array_get(rt.new_string('wpcom_has_working_connection')))))) {
		mut var_rest_controller := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController.class(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_get_mut('_links').array_set('preload', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_method(var_rest_controller, 'get_rest_url_path', [
					rt.new_string('onboarding/preload'),
				]),
			]) },
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		unsafe {
			goto end_label_3
		}
		catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Throwable') {
			mut var_e := var_e_3.clone()
			mut iife_temp_6 :=
				Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
			mut iife_result_6 := iife_temp_6.wc_get_logger()
			rt.call_method(iife_result_6, 'error', [
				rt.new_string('Failed to get the WooPayments REST controller instance: ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
				rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
			])
			unsafe {
				goto end_label_3
			}
		} else {
			rt.throw_exception(var_e_3)
			unsafe {
				goto end_label_3
			}
		}

		end_label_3:
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array',
		[]string{}, var_extension_suggestion_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) needs_setup(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_account_connected(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))))))
	{
		return true
	}
	if this.has_test_account() {
		return false
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.needs_setup(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'),
			rt.new_string('mode')])
		if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.clone(), rt.new_string('is_test')]))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_woopayments_mode
		}, rt.ArrayItem{ key: none, val: 'is_test' }])])) {
			return (rt.call_method(var_woopayments_mode, 'is_test', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'),
			rt.new_string('mode')])
		if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.clone(), rt.new_string('is_dev')]))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_woopayments_mode
		}, rt.ArrayItem{ key: none, val: 'is_dev' }])])) {
			return (rt.call_method(var_woopayments_mode, 'is_dev', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_dev_mode(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_onboarding_supported(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) bool {
	mut country_code_mutated := country_code
	mut var_is_onboarding_supported := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_onboarding_supported(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway), rt.new_string(country_code_mutated))
	if !(var_is_onboarding_supported.clone().is_null()) {
		return var_is_onboarding_supported.to_bool()
	}
	if country_code_mutated == '' {
		return true
	}
	country_code_mutated = country_code_mutated.to_upper()
	mut var_supported_country_codes := this.get_supported_country_codes()
	if rt.is_true(rt.new_bool(var_supported_country_codes.clone().is_null())) {
		return true
	}
	return (rt.call_function('in_array', [rt.new_string(country_code_mutated).clone(),
		var_supported_country_codes.clone(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_onboarding_not_supported_message(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) string {
	mut country_code_mutated := country_code
	mut var_message := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_onboarding_not_supported_message(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway), rt.new_string(country_code_mutated))
	if !(var_message.clone().is_null()) {
		return var_message.str()
	}
	return (rt.call_function('sprintf', [
		rt.call_function('esc_html__', [
			rt.new_string('%s is not supported in the selected business location.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('WooPayments'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'),
			rt.new_string('mode')])
		if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.clone(), rt.new_string('is_test_mode_onboarding')]))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_woopayments_mode
		}, rt.ArrayItem{ key: none, val: 'is_test_mode_onboarding' }])])) {
			return (rt.call_method(var_woopayments_mode, 'is_test_mode_onboarding', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway',
		[]string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_onboarding_url(mut var_payment_gateway Class_WC_Payment_Gateway, return_url string) string {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments_Account')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments_Account::get_connect_url')])) {
		mut var_connect_url := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments_Account'),
			rt.new_string('get_connect_url')])
	} else {
		var_connect_url = this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_onboarding_url(rt.new_object('WC_Payment_Gateway',
			[]string{}, var_payment_gateway), rt.new_string(return_url))
	}
	mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_7 :=
		iife_temp_7.is_defined(rt.new_string('WC_Payments_Onboarding_Service::FROM_WCADMIN_PAYMENTS_SETTINGS'))
	mut iife_temp_8 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_8 :=
		iife_temp_8.get_constant(rt.new_string('WC_Payments_Onboarding_Service::FROM_WCADMIN_PAYMENTS_SETTINGS'))
	mut iife_temp_9 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_9 :=
		iife_temp_9.is_defined(rt.new_string('WC_Payments_Onboarding_Service::SOURCE_WCADMIN_SETTINGS_PAGE'))
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 :=
		iife_temp_10.get_constant(rt.new_string('WC_Payments_Onboarding_Service::SOURCE_WCADMIN_SETTINGS_PAGE'))
	mut var_params := rt.create_array([
		rt.ArrayItem{
			key: 'from'
			val: if rt.is_true(iife_result_7) {
				iife_result_8.str()
			} else {
				'WCADMIN_PAYMENT_SETTINGS'
			}
		},
		rt.ArrayItem{
			key: 'source'
			val: if rt.is_true(iife_result_9) {
				iife_result_10.str()
			} else {
				'wcadmin-settings-page'
			}
		},
		rt.ArrayItem{ key: 'redirect_to_settings_page', val: 'true' },
	])
	if rt.is_true(this.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{},
		var_payment_gateway)))
	{
		return (rt.call_function('add_query_arg', [var_params.clone(),
			var_connect_url.clone()])).str()
	}
	mut var_live_onboarding := rt.new_bool(false)
	if rt.is_true(rt.call_function('filter_var', [
		rt.call_function('get_option', [rt.new_string('woocommerce_coming_soon')]),
		rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
	]))
	{
		mut var_onboarding_profile := rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
			rt.new_array(),
		])
		if var_onboarding_profile.array_isset(rt.new_string('business_choice'))
			&& rt.is_true(rt.identical(rt.new_string('im_already_selling'), var_onboarding_profile.array_get(rt.new_string('business_choice'))))
			&& var_onboarding_profile.array_isset(rt.new_string('selling_online_answer'))
			&& rt.is_true(rt.identical(rt.new_string('yes_im_selling_online'), var_onboarding_profile.array_get(rt.new_string('selling_online_answer'))))
			|| rt.is_true(rt.identical(rt.new_string('im_selling_both_online_and_offline'), var_onboarding_profile.array_get(rt.new_string('selling_online_answer')))) {
			var_live_onboarding = rt.new_bool(true)
		}
		mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}
		mut iife_result_11 := iife_temp_11.is_wc_admin_active_for(rt.mul(rt.new_int(90),
			rt.get_constant('DAY_IN_SECONDS')))
	} else if rt.is_true(iife_result_11) && this.has_enabled_other_ecommerce_gateways()
		&& this.has_orders() {
		var_live_onboarding = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_live_onboarding)))) {
		var_params.array_set('test_drive', 'true')
		var_params.array_set('auto_start_test_drive_onboarding', 'true')
	}
	return (rt.call_function('add_query_arg', [var_params.clone(),
		var_connect_url.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_orders() bool {
	mut var_store_has_orders_transient_name := rt.new_string(
		(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.prefix()).str() + 'store_has_orders')
	mut var_has_orders := rt.call_function('get_transient', [
		var_store_has_orders_transient_name.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_has_orders)))) {
		return (rt.call_function('wc_string_to_bool', [var_has_orders.clone()])).to_bool()
	}
	var_has_orders = rt.new_bool(false)
	mut var_expiration := rt.mul(rt.new_int(6), rt.get_constant('HOUR_IN_SECONDS'))
	mut var_latest_order := rt.call_function('wc_get_orders', [
		rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded()
				},
			]) },
			rt.ArrayItem{ key: 'limit', val: 1 },
			rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
		]),
	])
	if !(!rt.is_true(var_latest_order)) {
		var_latest_order = rt.call_function('reset', [var_latest_order.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_latest_order, 'WC_Abstract_Order')))
			&& rt.is_true(rt.greater_equal(rt.call_function('strtotime', [rt.new_string((rt.call_method(var_latest_order, 'get_date_created', []rt.PhpVal{})).str())]), rt.call_function('strtotime', [rt.new_string('-90 days')]))) {
			var_has_orders = rt.new_bool(true)
			var_expiration = rt.sub(rt.add(rt.call_function('strtotime', [
				rt.new_string((rt.call_method(var_latest_order, 'get_date_created', []rt.PhpVal{})).str()),
			]), rt.mul(rt.new_int(90), rt.get_constant('DAY_IN_SECONDS'))), rt.call_function('time',
				[]rt.PhpVal{}))
		}
	}
	rt.call_function('set_transient', [var_store_has_orders_transient_name.clone(),
		rt.new_string((if rt.is_true(var_has_orders) { 'yes' } else { 'no' }).str()),
		var_expiration.clone()])
	return var_has_orders.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_enabled_other_ecommerce_gateways() bool {
	mut var_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
			rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_gateway, 'id'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'woocommerce_payments'
		}, rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods()
		}]), rt.new_bool(true)])))))
	}
	mut var_other_ecommerce_gateways := rt.call_function('array_filter', [
		var_gateways.clone(), rt.new_closure(closure_13_fn)])
	return !(!rt.is_true(var_other_ecommerce_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_test_account() bool {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('function_exists'), rt.new_string('wcpay_get_container')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments_Account')])) {
		mut var_woopayments_container := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_function', [rt.new_string('wcpay_get_container')])
		mut var_account_service := rt.call_method(var_woopayments_container, 'get', [
			rt.new_string('WC_Payments_Account'),
		])
		if !(!rt.is_true(var_account_service))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_account_service.clone(), rt.new_string('get_account_status_data')]))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_account_service
		}, rt.ArrayItem{ key: none, val: 'get_account_status_data' }])])) {
			mut var_account_status := rt.call_method(var_account_service,
				'get_account_status_data', []rt.PhpVal{})
			return !(!rt.is_true(var_account_status.array_get(rt.new_string('testDrive'))))
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_sandbox_account() bool {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('function_exists'), rt.new_string('wcpay_get_container')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments_Account')])) {
		mut var_woopayments_container := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_function', [rt.new_string('wcpay_get_container')])
		mut var_account_service := rt.call_method(var_woopayments_container, 'get', [
			rt.new_string('WC_Payments_Account'),
		])
		if !(!rt.is_true(var_account_service))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_account_service.clone(), rt.new_string('get_account_status_data')]))
			&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{
			key: none
			val: var_account_service
		}, rt.ArrayItem{ key: none, val: 'get_account_status_data' }])])) {
			mut var_account_status := rt.call_method(var_account_service,
				'get_account_status_data', []rt.PhpVal{})
			return !rt.is_true(var_account_status.array_get(rt.new_string('isLive')))
				&& !rt.is_true(var_account_status.array_get(rt.new_string('testDrive')))
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_supported_country_codes() rt.PhpVal {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments_Utils')]))
		&& rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments_Utils::supported_countries')])) {
		mut var_supported_country_codes := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
			'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
		], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments_Utils'),
			rt.new_string('supported_countries')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if rt.is_true(rt.new_bool(var_supported_country_codes.clone().is_array())) {
			return rt.call_function('array_unique', [
				rt.call_function('array_map', [rt.new_string('strtoupper'),
					rt.func_array_keys(var_supported_country_codes.clone())]),
			])
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Throwable') {
		mut var_e := var_e_4.clone()
		mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_13 := iife_temp_13.wc_get_logger()
		rt.call_method(iife_result_13, 'error', [
			rt.new_string('Failed to get the WooPayments supported country codes list: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
		])
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_wpcom_connection_state() rt.PhpVal {
	mut var_wpcom_connection_manager := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', [
		'Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
	], &this), 'proxy'), 'get_instance_of', [
		Class_Automattic_Jetpack_Connection_Manager.class(),
		rt.new_string('woocommerce'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Throwable') {
		mut var_e := var_e_5.clone()
		mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_14 := iife_temp_14.wc_get_logger()
		rt.call_method(iife_result_14, 'error', [
			rt.new_string('Failed to get the WPCOM/Jetpack Connection Manager instance: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
		])
		return rt.create_array([
			rt.ArrayItem{ key: 'wpcom_has_working_connection', val: false },
			rt.ArrayItem{ key: 'wpcom_is_store_connected', val: false },
			rt.ArrayItem{ key: 'wpcom_has_connected_owner', val: false },
			rt.ArrayItem{ key: 'wpcom_is_connection_owner', val: false },
		])
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	mut var_is_connected := rt.call_method(var_wpcom_connection_manager, 'is_connected',
		[]rt.PhpVal{})
	mut var_has_connected_owner := rt.call_method(var_wpcom_connection_manager,
		'has_connected_owner', []rt.PhpVal{})
	return rt.create_array([
		rt.ArrayItem{ key: 'wpcom_has_working_connection', val: rt.is_true(var_is_connected)
			&& rt.is_true(var_has_connected_owner) },
		rt.ArrayItem{ key: 'wpcom_is_store_connected', val: var_is_connected },
		rt.ArrayItem{ key: 'wpcom_has_connected_owner', val: var_has_connected_owner },
		rt.ArrayItem{
			key: 'wpcom_is_connection_owner'
			val: rt.is_true(var_has_connected_owner)
				&& rt.is_true(rt.call_method(var_wpcom_connection_manager, 'is_connection_owner', []rt.PhpVal{}))
		},
	])
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enhance_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.enhance_extension_suggestion(mut dispatch_arg_0)
		}
		'needs_setup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.needs_setup(mut dispatch_arg_0))
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
		'is_onboarding_supported' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_onboarding_supported(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_onboarding_not_supported_message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_onboarding_not_supported_message(mut dispatch_arg_0,
				dispatch_arg_1))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'get_onboarding_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_onboarding_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		'has_orders' {
			return rt.new_bool(this.has_orders())
		}
		'has_enabled_other_ecommerce_gateways' {
			return rt.new_bool(this.has_enabled_other_ecommerce_gateways())
		}
		'has_test_account' {
			return rt.new_bool(this.has_test_account())
		}
		'has_sandbox_account' {
			return rt.new_bool(this.has_sandbox_account())
		}
		'get_supported_country_codes' {
			return this.get_supported_country_codes()
		}
		'get_wpcom_connection_state' {
			return this.get_wpcom_connection_state()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
