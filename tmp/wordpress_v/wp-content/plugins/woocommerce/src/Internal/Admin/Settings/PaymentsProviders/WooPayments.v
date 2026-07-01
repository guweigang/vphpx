import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.prefix() string {
	return 'woocommerce_admin_settings_payments__woopayments__'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_details(mut var_gateway Class_WC_Payment_Gateway, order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_details := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_details(rt.new_object('WC_Payment_Gateway', []string{}, var_gateway), rt.new_int(order), rt.new_string(country_code_mutated))
	mut var_has_test_account := rt.new_bool(this.has_test_account())
	mut var_has_sandbox_account := rt.new_bool(this.has_sandbox_account())
	var_details.array_get_mut('onboarding').array_set('type', Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native())
	var_details.array_get_mut('onboarding').array_get_mut('state').array_set('test_drive_account', var_has_test_account.dup())
	var_details.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [var_details.array_get('onboarding').array_get('state'), this.get_wpcom_connection_state()]))
	if rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WCPAY_VERSION_NUMBER'))) && rt.is_true(rt.call_function('version_compare', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WCPAY_VERSION_NUMBER')), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version(), rt.new_string('<')])))) {
		return var_details.dup()
	}
	var_details.array_get_mut('onboarding').array_set('type', Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
	var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('onboard', rt.create_array([rt.ArrayItem{ key: 'href', val: fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.wc_payments_settings_url(arg_0, arg_1) }(rt.new_string('/woopayments/onboarding'), rt.create_array([rt.ArrayItem{ key: 'from', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_settings() }])) }]))
	mut var_rest_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController.class()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_has_test_account) || rt.is_true(var_has_sandbox_account))) {
		var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('disable_test_account', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_method(var_rest_controller, 'get_rest_url_path', [rt.new_string('onboarding/test_account/disable')])]) }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_details.array_get_mut('onboarding').array_get_mut('_links').array_set('reset', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_method(var_rest_controller, 'get_rest_url_path', [rt.new_string('onboarding/reset')])]) }]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to get the WooPayments REST controller instance: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if !(country_code_mutated == '') {
		mut var_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.class()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if !(!(var_rest_controller).is_null()) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException', []string{}, create_automattic_woocommerce_internal_admin_settings_paymentsproviders_runtimeexception(rt.new_string('WooPayments REST controller not available'))))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		mut var_onboarding_details := rt.call_method(var_service, 'get_onboarding_details', [rt.new_string(country_code_mutated).dup(), rt.call_method(var_rest_controller, 'get_rest_url_path', [rt.new_string('onboarding')])])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_onboarding_details.array_get('state'))) && rt.is_true(rt.new_bool(var_onboarding_details.array_get('state').is_array())))) {
			var_details.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [var_details.array_get('onboarding').array_get('state'), var_onboarding_details.array_get('state')]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_onboarding_details.array_get('messages'))) && rt.is_true(rt.new_bool(var_onboarding_details.array_get('messages').is_array())))) {
			if rt.is_true(rt.new_bool(!(var_details.array_get('onboarding').array_isset(rt.new_string('messages'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_details.array_get('onboarding').array_get('messages').is_array()))))))) {
				var_details.array_get_mut('onboarding').array_set('messages', rt.new_array())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_details.array_get_mut('onboarding').array_set('messages', rt.call_function('array_merge', [var_details.array_get('onboarding').array_get('messages'), var_onboarding_details.array_get('messages')]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_onboarding_details.array_get('steps'))) && rt.is_true(rt.new_bool(var_onboarding_details.array_get('steps').is_array())))) {
			var_details.array_get_mut('onboarding').array_set('steps', var_onboarding_details.array_get('steps'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_onboarding_details.array_get('context'))) && rt.is_true(rt.new_bool(var_onboarding_details.array_get('context').is_array())))) {
			if rt.is_true(rt.new_bool(!(var_details.array_get('onboarding').array_isset(rt.new_string('context'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_details.array_get('onboarding').array_get('context').is_array()))))))) {
				var_details.array_get_mut('onboarding').array_set('context', rt.new_array())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_details.array_get_mut('onboarding').array_set('context', rt.call_function('array_merge', [var_details.array_get('onboarding').array_get('context'), var_onboarding_details.array_get('context')]))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Throwable') {
			mut var_e := var_e_2.dup()
			rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to get the WooPayments service instance: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }])])
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
	}
	return var_details.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
	var_extension_suggestion_mutated = this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.enhance_extension_suggestion(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array', []string{}, var_extension_suggestion_mutated))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_extension_suggestion_mutated.array_get('plugin').array_get('file'))) && var_extension_suggestion_mutated.array_get('plugin').array_isset(rt.new_string('status')) && rt.is_true(rt.call_function('in_array', [var_extension_suggestion_mutated.array_get('plugin').array_get('status'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active() }]), rt.new_bool(true)])))) {
		mut var_plugin_data := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('get_plugin_data'), (var_extension_suggestion_mutated.array_get('plugin').array_get('file')).str() + '.php'])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_plugin_data) && !(!rt.is_true(var_plugin_data.array_get('Version'))))) && rt.is_true(rt.call_function('version_compare', [var_plugin_data.array_get('Version'), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.extension_minimum_version(), rt.new_string('>=')])))) {
			var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type', Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
		}
	} else {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type', Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.onboarding_type_native_in_context())
	}
	if rt.is_true(rt.new_bool(!(var_extension_suggestion_mutated.array_get('onboarding').array_isset(rt.new_string('state'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_extension_suggestion_mutated.array_get('onboarding').array_get('state').is_array()))))))) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('state', rt.new_array())
	}
	var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('state', rt.call_function('array_merge', [var_extension_suggestion_mutated.array_get('onboarding').array_get('state'), this.get_wpcom_connection_state()]))
	if rt.is_true(rt.new_bool(!rt.is_true(var_extension_suggestion_mutated.array_get('onboarding').array_get('_links')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_extension_suggestion_mutated.array_get('onboarding').array_get('_links').is_array()))))))) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('_links', rt.new_array())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension_suggestion_mutated.array_get('onboarding').array_get('state').array_get('wpcom_has_working_connection'))))) {
		mut var_rest_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsRestController.class()])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_get_mut('_links').array_set('preload', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_method(var_rest_controller, 'get_rest_url_path', [rt.new_string('onboarding/preload')])]) }]))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Throwable') {
			mut var_e := var_e_3.dup()
			rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'error', ['Failed to get the WooPayments REST controller instance: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }])])
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array', []string{}, var_extension_suggestion_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) needs_setup(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway)))))) {
		return true
	}
	if this.has_test_account() {
		return false
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.needs_setup(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])))) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'), rt.new_string('mode')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.dup(), rt.new_string('is_test')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{ key: none, val: var_woopayments_mode }, rt.ArrayItem{ key: none, val: 'is_test' }])])))) {
			return (rt.call_method(var_woopayments_mode, 'is_test', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])))) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'), rt.new_string('mode')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.dup(), rt.new_string('is_dev')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{ key: none, val: var_woopayments_mode }, rt.ArrayItem{ key: none, val: 'is_dev' }])])))) {
			return (rt.call_method(var_woopayments_mode, 'is_dev', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_dev_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_onboarding_supported(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) bool {
	mut country_code_mutated := country_code
	mut var_is_onboarding_supported := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_onboarding_supported(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway), rt.new_string(country_code_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_is_onboarding_supported.dup().is_null()))))) {
		return (var_is_onboarding_supported).to_bool()
	}
	if country_code_mutated == '' {
		return true
	}
	country_code_mutated = country_code_mutated.to_upper()
	mut var_supported_country_codes := this.get_supported_country_codes()
	if rt.is_true(rt.new_bool(var_supported_country_codes.dup().is_null())) {
		return true
	}
	return (rt.call_function('in_array', [rt.new_string(country_code_mutated).dup(), var_supported_country_codes.dup(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_onboarding_not_supported_message(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) string {
	mut country_code_mutated := country_code
	mut var_message := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_onboarding_not_supported_message(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway), rt.new_string(country_code_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_message.dup().is_null()))))) {
		return (var_message).str()
	}
	return (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s is not supported in the selected business location.'), rt.new_string('woocommerce')]), rt.new_string('WooPayments')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments::mode')])))) {
		mut var_woopayments_mode := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments'), rt.new_string('mode')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('method_exists'), var_woopayments_mode.dup(), rt.new_string('is_test_mode_onboarding')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.create_array([rt.ArrayItem{ key: none, val: var_woopayments_mode }, rt.ArrayItem{ key: none, val: 'is_test_mode_onboarding' }])])))) {
			return (rt.call_method(var_woopayments_mode, 'is_test_mode_onboarding', []rt.PhpVal{})).to_bool()
		}
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_onboarding_url(mut var_payment_gateway Class_WC_Payment_Gateway, return_url string) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('class_exists'), rt.new_string('WC_Payments_Account')])) && rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_function', [rt.new_string('is_callable'), rt.new_string('WC_Payments_Account::get_connect_url')])))) {
		mut var_connect_url := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments', ['Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway'], &this), 'proxy'), 'call_static', [rt.new_string('WC_Payments_Account'), rt.new_string('get_connect_url')])
	} else {
		var_connect_url = this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_onboarding_url(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway), rt.new_string(return_url))
	}
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'from', val: if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WC_Payments_Onboarding_Service::FROM_WCADMIN_PAYMENTS_SETTINGS'))) { // unsupported expression: Expr_Cast_String } else { rt.new_string('WCADMIN_PAYMENT_SETTINGS') } }, rt.ArrayItem{ key: 'source', val: if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WC_Payments_Onboarding_Service::SOURCE_WCADMIN_SETTINGS_PAGE'))) { // unsupported expression: Expr_Cast_String } else { rt.new_string('wcadmin-settings-page') } }, rt.ArrayItem{ key: 'redirect_to_settings_page', val: 'true' }])
	if rt.is_true(this.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))) {
		return (rt.call_function('add_query_arg', [var_params.dup(), var_connect_url.dup()])).str()
	}
	mut var_live_onboarding := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('filter_var', [rt.call_function('get_option', [rt.new_string('woocommerce_coming_soon')]), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])) {
		mut var_onboarding_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_onboarding_profile.array_isset(rt.new_string('business_choice')) && rt.is_true(rt.identical(rt.new_string('im_already_selling'), var_onboarding_profile.array_get('business_choice'))))) && var_onboarding_profile.array_isset(rt.new_string('selling_online_answer')))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes_im_selling_online'), var_onboarding_profile.array_get('selling_online_answer'))) || rt.is_true(rt.identical(rt.new_string('im_selling_both_online_and_offline'), var_onboarding_profile.array_get('selling_online_answer'))))))) {
			var_live_onboarding = rt.new_bool(rt.new_bool(true))
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}; return temp.is_wc_admin_active_for(arg_0) }(rt.mul(rt.new_int(90), rt.get_constant('DAY_IN_SECONDS')))) && this.has_enabled_other_ecommerce_gateways())) && this.has_orders())) {
		var_live_onboarding = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_live_onboarding)))) {
		var_params.array_set('test_drive', 'true')
		var_params.array_set('auto_start_test_drive_onboarding', 'true')
	}
	return (rt.call_function('add_query_arg', [var_params.dup(), var_connect_url.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_orders() bool {
	mut var_store_has_orders_transient_name := rt.new_string((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments.prefix()).str() + 'store_has_orders')
	mut var_has_orders := rt.call_function('get_transient', [var_store_has_orders_transient_name.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('wc_string_to_bool', [var_has_orders.dup()])).to_bool()
	}
	var_has_orders = rt.new_bool(rt.new_bool(false))
	mut var_expiration := rt.mul(rt.new_int(6), rt.get_constant('HOUR_IN_SECONDS'))
	mut var_latest_order := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }]) }, rt.ArrayItem{ key: 'limit', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])
	if !(!rt.is_true(var_latest_order)) {
		var_latest_order = rt.call_function('reset', [.dup()])
		if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
			
		}
	}
	rt.call_function('set_transient', [.dup(), , .dup()])
	return ().to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_enabled_other_ecommerce_gateways() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_test_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) has_sandbox_account() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_supported_country_codes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) get_wpcom_connection_state() rt.PhpVal {
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_woopayments() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments{
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils() &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_runtimeexception() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper() &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enhance_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.enhance_extension_suggestion(mut dispatch_arg_0)
		}
		'needs_setup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.needs_setup(mut dispatch_arg_0))
		}
		'is_in_test_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode(mut dispatch_arg_0))
		}
		'is_in_dev_mode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_dev_mode(mut dispatch_arg_0))
		}
		'is_onboarding_supported' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_onboarding_supported(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_onboarding_not_supported_message' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_onboarding_not_supported_message(mut dispatch_arg_0, dispatch_arg_1))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'get_onboarding_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_woopayments_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
