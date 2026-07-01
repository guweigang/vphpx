import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_external() string {
	return 'external'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_native() string {
	return 'native'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_native_in_context() string {
	return 'native_in_context'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.payment_method_category_primary() string {
	return 'primary'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.payment_method_category_secondary() string {
	return 'secondary'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
pub mut:
		proxy rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) construct(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.proxy = var_proxy.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_details(mut var_gateway Class_WC_Payment_Gateway, order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_onboarding_supported := rt.new_bool(if !(this.is_onboarding_supported(mut var_gateway, country_code_mutated)).is_null() { this.is_onboarding_supported(mut var_gateway, country_code_mutated) } else { rt.new_bool(true) })
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_gateway, 'id') }, rt.ArrayItem{ key: '_order', val: order }, rt.ArrayItem{ key: 'title', val: this.get_title(mut var_gateway) }, rt.ArrayItem{ key: 'description', val: this.get_description(mut var_gateway) }, rt.ArrayItem{ key: 'icon', val: this.get_icon(mut var_gateway) }, rt.ArrayItem{ key: 'supports', val: this.get_supports_list(mut var_gateway) }, rt.ArrayItem{ key: 'links', val: this.get_provider_links(mut var_gateway, country_code_mutated) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'enabled', val: this.is_enabled(mut var_gateway) }, rt.ArrayItem{ key: 'account_connected', val: this.is_account_connected(mut var_gateway) }, rt.ArrayItem{ key: 'needs_setup', val: this.needs_setup(mut var_gateway) }, rt.ArrayItem{ key: 'test_mode', val: this.is_in_test_mode(mut var_gateway) }, rt.ArrayItem{ key: 'dev_mode', val: this.is_in_dev_mode(mut var_gateway) }]) }, rt.ArrayItem{ key: 'management', val: rt.create_array([rt.ArrayItem{ key: '_links', val: rt.create_array([rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'href', val: this.get_settings_url(mut var_gateway) }]) }]) }]) }, rt.ArrayItem{ key: 'onboarding', val: rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_external() }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'supported', val: var_onboarding_supported }, rt.ArrayItem{ key: 'started', val: this.is_onboarding_started(mut var_gateway) }, rt.ArrayItem{ key: 'completed', val: this.is_onboarding_completed(mut var_gateway) }, rt.ArrayItem{ key: 'test_mode', val: this.is_in_test_mode_onboarding(mut var_gateway) }]) }, rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: 'not_supported', val: if rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_supported)))) { this.get_onboarding_not_supported_message(mut var_gateway, country_code_mutated) } else { rt.new_null() } }]) }, rt.ArrayItem{ key: '_links', val: rt.create_array([rt.ArrayItem{ key: 'onboard', val: rt.create_array([rt.ArrayItem{ key: 'href', val: this.get_onboarding_url(mut var_gateway, '') }]) }]) }, rt.ArrayItem{ key: 'recommended_payment_methods', val: this.get_recommended_payment_methods(mut var_gateway, country_code_mutated) }]) }, rt.ArrayItem{ key: 'plugin', val: this.get_plugin_details(mut var_gateway) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
	if rt.is_true(rt.new_bool(!rt.is_true(var_extension_suggestion_mutated.array_get('onboarding')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_extension_suggestion_mutated.array_get('onboarding').is_array()))))))) {
		var_extension_suggestion_mutated.array_set('onboarding', rt.new_array())
	}
	if !(var_extension_suggestion_mutated.array_get('onboarding').array_isset(rt.new_string('type'))) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type', Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_external())
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array', []string{}, var_extension_suggestion_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_title(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_title := var_payment_gateway.get_method_title()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_title.dup().is_string()))))) || !rt.is_true(var_title))) {
		var_title = var_payment_gateway.get_title()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_title.dup().is_string()))))) || !rt.is_true(var_title))) {
		return (rt.call_function('esc_html__', [rt.new_string('Unknown'), rt.new_string('woocommerce')])).str()
	}
	var_title = rt.call_function('wp_strip_all_tags', [rt.call_function('html_entity_decode', [var_title.dup(), rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_SUBSTITUTE'))]), rt.new_bool(true)])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.truncate_with_words(arg_0, arg_1) }(var_title.dup(), rt.new_int(75))).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_description(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_description := var_payment_gateway.get_method_description()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_description.dup().is_string()))))) || !rt.is_true(var_description))) {
		var_description = var_payment_gateway.get_description()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_description.dup().is_string()))))) || !rt.is_true(var_description))) {
		return ''
	}
	var_description = rt.call_function('wp_strip_all_tags', [rt.call_function('html_entity_decode', [var_description.dup(), rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_SUBSTITUTE'))]), rt.new_bool(true)])
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.truncate_with_words(arg_0, arg_1, arg_2) }(var_description.dup(), rt.new_int(130), rt.new_string('…'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_icon(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_icon_url := if !(rt.get_property(var_payment_gateway, 'icon')).is_null() { rt.get_property(var_payment_gateway, 'icon') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_icon_url.dup().is_string()))))) || !rt.is_true(var_icon_url))) {
		var_icon_url = rt.new_string(rt.new_string(''))
	}
	var_icon_url = rt.new_string(rt.new_string(var_icon_url.dup().to_string().trim_space()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_icon_url.dup()]))))) {
		return (rt.call_function('plugins_url', [rt.new_string('assets/images/icons/default-payments.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str()
	}
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_HTTPS{}; return temp.force_https_url(arg_0) }(var_icon_url.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_supports_list(mut var_payment_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_supports_list := if !(rt.get_property(var_payment_gateway, 'supports')).is_null() { rt.get_property(var_payment_gateway, 'supports') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_supports_list.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_sanitized_list := rt.new_array()
	{
		mut iter_1 := var_supports_list.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_support := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_support.dup().is_string()))))) {
				continue
			}
			var_sanitized_list.array_push(rt.call_function('sanitize_key', [var_support.dup()]))
		}
	}
	return rt.call_function('array_values', [rt.call_function('array_unique', [var_sanitized_list.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_provider_links(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = rt.call_function('sanitize_text_field', [rt.new_string(country_code_mutated).dup()]).to_string().to_upper()
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_upper', [rt.new_string(country_code_mutated).dup()]))))))))) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', [rt.new_string('Received invalid country code when getting provider links. Ignoring it.'), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'country', val: country_code_mutated }])])
		country_code_mutated = ''
	}
	mut var_provider_links := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_provider_links')])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'get_provider_links' }])])))) {
		var_provider_links = rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'get_provider_links' }]), rt.new_string(country_code_mutated).dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_accepted_types := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_about() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_docs() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_support() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_pricing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_terms() }])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_validated_links := rt.new_array()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(var_provider_links.dup().is_array())) {
			{
				mut iter_1 := var_provider_links.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_link := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link.dup().is_array()))))) {
						continue
						if rt.has_exception() { unsafe { goto catch_label_1 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					mut var_type := if rt.is_true(rt.new_bool(var_link.array_isset(rt.new_string('_type')) && rt.is_true(rt.call_function('is_scalar', [var_link.array_get('_type')])))) { rt.call_function('sanitize_key', [// unsupported expression: Expr_Cast_String]) } else { rt.new_string('') }
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					if rt.is_true(rt.new_bool(!rt.is_true(var_type) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.dup(), var_accepted_types.dup(), rt.new_bool(true)]))))))) {
						continue
						if rt.has_exception() { unsafe { goto catch_label_1 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_link.array_get('url')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link.array_get('url').is_string()))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_link.array_get('url')]))))))) {
						continue
						if rt.has_exception() { unsafe { goto catch_label_1 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					mut var_url := rt.call_function('sanitize_url', [var_link.array_get('url')])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					mut var_link_key := rt.new_string((var_type).str() + '|' + (var_url).str())
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					if var_validated_links.array_isset(var_link_key) {
						continue
						if rt.has_exception() { unsafe { goto catch_label_1 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					var_validated_links.array_set(var_link_key, rt.create_array([rt.ArrayItem{ key: '_type', val: var_type }, rt.ArrayItem{ key: 'url', val: var_url }]))
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_provider_links = rt.call_function('array_values', [var_validated_links.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to get provider links: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		return rt.new_array()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_provider_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_enabled(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (rt.call_function('wc_string_to_bool', [if !(rt.get_property(var_payment_gateway, 'enabled')).is_null() { rt.get_property(var_payment_gateway, 'enabled') } else { rt.new_string('no') }])).to_bool()
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is enabled: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) needs_setup(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_needs_setup := rt.call_function('wc_string_to_bool', [var_payment_gateway.needs_setup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(var_needs_setup) {
		return true
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Throwable') {
		mut var_e := var_e_3.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway needs setup: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	if !(this.is_account_connected(mut var_payment_gateway)) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_test_mode' }])])) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_test_mode()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_in_test_mode' }])])) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_in_test_mode()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if !(rt.get_property(var_payment_gateway, 'testmode')).is_null() {
		return (rt.call_function('wc_string_to_bool', [rt.get_property(var_payment_gateway, 'testmode')])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if !(rt.get_property(var_payment_gateway, 'test_mode')).is_null() {
		return (rt.call_function('wc_string_to_bool', [rt.get_property(var_payment_gateway, 'test_mode')])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'get_option' }])])) {
		mut var_test_mode := rt.call_function('filter_var', [var_payment_gateway.get_option(rt.new_string('test_mode'), rt.new_string('not_found')), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_test_mode.dup().is_null()))))) {
			return (var_test_mode).to_bool()
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_test_mode = rt.call_function('filter_var', [var_payment_gateway.get_option(rt.new_string('testmode'), rt.new_string('not_found')), rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_test_mode.dup().is_null()))))) {
			return (var_test_mode).to_bool()
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_mode := rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().to_lower()))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.call_function('in_array', [var_mode.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'test' }, rt.ArrayItem{ key: none, val: 'sandbox' }, rt.ArrayItem{ key: none, val: 'dev' }]), rt.new_bool(true)])) {
			return true
		} else if rt.is_true(rt.call_function('in_array', [var_mode.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'live' }, rt.ArrayItem{ key: none, val: 'production' }, rt.ArrayItem{ key: none, val: 'prod' }]), rt.new_bool(true)])) {
			return false
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Throwable') {
		mut var_e := var_e_4.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is in test mode: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_dev_mode' }])])) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_dev_mode()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_in_dev_mode' }])])) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_in_dev_mode()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Throwable') {
		mut var_e := var_e_5.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway is in dev mode: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_account_connected')])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_account_connected' }])])))) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_account_connected()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_connected')])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway }, rt.ArrayItem{ key: none, val: 'is_connected' }])])))) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_connected()])).to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Throwable') {
		mut var_e := var_e_6.dup()
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}; return temp.wc_get_logger() }(), 'debug', ['Failed to determine if gateway account is connected: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') }, rt.ArrayItem{ key: 'source', val: 'settings-payments' }, rt.ArrayItem{ key: 'exception', val: var_e }])])
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_supported(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) bool {
	mut country_code_mutated := country_code
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [, ])) && rt.is_true(rt.call_function('is_callable', [])))) {
		mut var_result := 
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		if rt.is_true() {
		}
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		if rt.is_true() {
		}
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		return ().to_bool()
	}
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	unsafe { goto end_label_7 }

catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Throwable') {
		mut var_e := var_e_7.dup()
		
		unsafe { goto end_label_7 }
	}
	else {
		rt.throw_exception(var_e_7)
		unsafe { goto end_label_7 }
	}

end_label_7:
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_onboarding_not_supported_message(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) string {
	mut country_code_mutated := country_code
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_started(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_completed(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_settings_url(mut var_payment_gateway Class_WC_Payment_Gateway) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_onboarding_url(mut var_payment_gateway Class_WC_Payment_Gateway, return_url string) string {
	mut return_url_mutated := return_url
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_details(mut var_payment_gateway Class_WC_Payment_Gateway) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_slug(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_wp_theme_directories := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_file(mut var_payment_gateway Class_WC_Payment_Gateway, plugin_slug string) string {
	mut plugin_slug_mutated := plugin_slug
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_recommended_payment_methods(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) validate_recommended_payment_method(var_recommended_pm rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) sort_recommended_payment_methods(mut var_recommended_pms Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_recommended_pms_mutated := var_recommended_pms
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) standardize_recommended_payment_method(mut var_recommended_pm Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array, order i64) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_class_filename(mut var_payment_gateway Class_WC_Payment_Gateway) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_containing_entity_type(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_wp_plugin_paths := rt.new_null()
	mut var_wp_theme_directories := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) extract_slug_from_path(path string) string {
	mut path_mutated := path
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_WC_HTTPS {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
		proxy: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils() &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_https() &Class_WC_HTTPS {
	mut obj := &Class_WC_HTTPS{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
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
		'get_title' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_title(mut dispatch_arg_0))
		}
		'get_description' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_description(mut dispatch_arg_0))
		}
		'get_icon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_icon(mut dispatch_arg_0))
		}
		'get_supports_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_supports_list(mut dispatch_arg_0)
		}
		'get_provider_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_provider_links(mut dispatch_arg_0, dispatch_arg_1)
		}
		'is_enabled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_enabled(mut dispatch_arg_0))
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
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
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
		'is_onboarding_started' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_onboarding_started(mut dispatch_arg_0))
		}
		'is_onboarding_completed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_onboarding_completed(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'get_settings_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_settings_url(mut dispatch_arg_0))
		}
		'get_onboarding_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_onboarding_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_plugin_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_plugin_details(mut dispatch_arg_0)
		}
		'get_plugin_slug' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_plugin_slug(mut dispatch_arg_0))
		}
		'get_plugin_file' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_plugin_file(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_recommended_payment_methods' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_recommended_payment_methods(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validate_recommended_payment_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_recommended_payment_method(dispatch_arg_0))
		}
		'sort_recommended_payment_methods' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sort_recommended_payment_methods(mut dispatch_arg_0)
		}
		'standardize_recommended_payment_method' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.standardize_recommended_payment_method(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_class_filename' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_class_filename(mut dispatch_arg_0))
		}
		'get_containing_entity_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_containing_entity_type(mut dispatch_arg_0))
		}
		'extract_slug_from_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_slug_from_path(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'proxy' { return this.proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'proxy' { this.proxy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_HTTPS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_HTTPS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_HTTPS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_paymentgateway_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
