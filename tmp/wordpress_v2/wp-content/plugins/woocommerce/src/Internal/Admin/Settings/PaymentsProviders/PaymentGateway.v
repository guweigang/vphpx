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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) construct(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	this.proxy = var_proxy
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_details(mut var_gateway Class_WC_Payment_Gateway, order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	mut var_onboarding_supported := rt.new_bool(if !(this.is_onboarding_supported(mut var_gateway,
		country_code_mutated)).is_null() {
		this.is_onboarding_supported(mut var_gateway, country_code_mutated)
	} else {
		rt.new_bool(true)
	})
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.get_property(var_gateway, 'id') },
		rt.ArrayItem{ key: '_order', val: order },
		rt.ArrayItem{ key: 'title', val: this.get_title(mut var_gateway) },
		rt.ArrayItem{ key: 'description', val: this.get_description(mut var_gateway) },
		rt.ArrayItem{ key: 'icon', val: this.get_icon(mut var_gateway) },
		rt.ArrayItem{ key: 'supports', val: this.get_supports_list(mut var_gateway) },
		rt.ArrayItem{ key: 'links', val: this.get_provider_links(mut var_gateway,
			country_code_mutated) },
		rt.ArrayItem{ key: 'state', val: rt.create_array([
			rt.ArrayItem{ key: 'enabled', val: this.is_enabled(mut var_gateway) },
			rt.ArrayItem{ key: 'account_connected', val: this.is_account_connected(mut var_gateway) },
			rt.ArrayItem{ key: 'needs_setup', val: this.needs_setup(mut var_gateway) },
			rt.ArrayItem{ key: 'test_mode', val: this.is_in_test_mode(mut var_gateway) },
			rt.ArrayItem{ key: 'dev_mode', val: this.is_in_dev_mode(mut var_gateway) },
		]) },
		rt.ArrayItem{ key: 'management', val: rt.create_array([
			rt.ArrayItem{ key: '_links', val: rt.create_array([
				rt.ArrayItem{ key: 'settings', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: this.get_settings_url(mut var_gateway) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'onboarding', val: rt.create_array([
			rt.ArrayItem{
				key: 'type'
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_external()
			},
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'supported', val: var_onboarding_supported },
				rt.ArrayItem{ key: 'started', val: this.is_onboarding_started(mut var_gateway) },
				rt.ArrayItem{ key: 'completed', val: this.is_onboarding_completed(mut var_gateway) },
				rt.ArrayItem{
					key: 'test_mode'
					val: this.is_in_test_mode_onboarding(mut var_gateway)
				},
			]) },
			rt.ArrayItem{ key: 'messages', val: rt.create_array([
				rt.ArrayItem{
					key: 'not_supported'
					val: if rt.is_true(rt.new_bool(!(rt.is_true(var_onboarding_supported)))) {
						this.get_onboarding_not_supported_message(mut var_gateway,
							country_code_mutated)
					} else {
						rt.new_null()
					}
				},
			]) },
			rt.ArrayItem{ key: '_links', val: rt.create_array([
				rt.ArrayItem{ key: 'onboard', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: this.get_onboarding_url(mut var_gateway, '') },
				]) },
			]) },
			rt.ArrayItem{ key: 'recommended_payment_methods', val: this.get_recommended_payment_methods(mut var_gateway,
				country_code_mutated) },
		]) },
		rt.ArrayItem{ key: 'plugin', val: this.get_plugin_details(mut var_gateway) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
	if !rt.is_true(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')))
		|| !(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).is_array()) {
		var_extension_suggestion_mutated.array_set('onboarding', rt.new_array())
	}
	if !(var_extension_suggestion_mutated.array_get(rt.new_string('onboarding')).array_isset(rt.new_string('type'))) {
		var_extension_suggestion_mutated.array_get_mut('onboarding').array_set('type',
			Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.onboarding_type_external())
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array',
		[]string{}, var_extension_suggestion_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_title(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_title := var_payment_gateway.get_method_title()
	if !(var_title.clone().is_string()) || !rt.is_true(var_title) {
		var_title = var_payment_gateway.get_title()
	}
	if !(var_title.clone().is_string()) || !rt.is_true(var_title) {
		return (rt.call_function('esc_html__', [rt.new_string('Unknown'),
			rt.new_string('woocommerce')])).str()
	}
	var_title = rt.call_function('wp_strip_all_tags', [
		rt.call_function('html_entity_decode', [var_title.clone(),
			rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_SUBSTITUTE'))]),
		rt.new_bool(true),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_0 := iife_temp_0.truncate_with_words(var_title.clone(), rt.new_int(75))
	return iife_result_0.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_description(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_description := var_payment_gateway.get_method_description()
	if !(var_description.clone().is_string()) || !rt.is_true(var_description) {
		var_description = var_payment_gateway.get_description()
	}
	if !(var_description.clone().is_string()) || !rt.is_true(var_description) {
		return ''
	}
	var_description = rt.call_function('wp_strip_all_tags', [
		rt.call_function('html_entity_decode', [var_description.clone(),
			rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_SUBSTITUTE'))]),
		rt.new_bool(true),
	])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_1 := iife_temp_1.truncate_with_words(var_description.clone(), rt.new_int(130),
		rt.new_string('…'))
	return iife_result_1.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_icon(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_icon_url := if !(rt.get_property(var_payment_gateway, 'icon')).is_null() {
		rt.get_property(var_payment_gateway, 'icon')
	} else {
		rt.new_string('')
	}
	if !(var_icon_url.clone().is_string()) || !rt.is_true(var_icon_url) {
		var_icon_url = rt.new_string('')
	}
	var_icon_url = rt.new_string(var_icon_url.clone().to_string().trim_space())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [
		var_icon_url.clone(),
	])))))
	{
		return (rt.call_function('plugins_url', [
			rt.new_string('assets/images/icons/default-payments.svg'),
			rt.get_constant('WC_PLUGIN_FILE'),
		])).str()
	}
	mut iife_temp_2 := Class_WC_HTTPS{}
	mut iife_result_2 := iife_temp_2.force_https_url(var_icon_url.clone())
	return iife_result_2.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_supports_list(mut var_payment_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_supports_list := if !(rt.get_property(var_payment_gateway, 'supports')).is_null() {
		rt.get_property(var_payment_gateway, 'supports')
	} else {
		rt.new_array()
	}
	if !(var_supports_list.clone().is_array()) {
		return rt.new_array()
	}
	mut var_sanitized_list := rt.new_array()
	mut iter_1 := var_supports_list.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_support := item_1.val
		if !(var_support.clone().is_string()) {
			continue
		}
		var_sanitized_list.array_push(rt.call_function('sanitize_key', [
			var_support.clone()]))
	}
	return rt.call_function('array_values', [
		rt.call_function('array_unique', [var_sanitized_list.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_provider_links(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = rt.call_function('sanitize_text_field', [
		rt.new_string(country_code_mutated).clone()]).to_string().to_upper()
	if rt.is_true(rt.new_bool('' != country_code_mutated))
		&& rt.is_true(rt.new_bool(country_code_mutated.len != 2))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_upper', [rt.new_string(country_code_mutated).clone()]))))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_3 := iife_temp_3.wc_get_logger()
		rt.call_method(iife_result_3, 'debug', [
			rt.new_string('Received invalid country code when getting provider links. Ignoring it.'),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'country', val: country_code_mutated },
			]),
		])
		country_code_mutated = ''
	}
	mut var_provider_links := rt.new_array()
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_provider_links')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'get_provider_links' }])]) {
		var_provider_links = rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
				rt.ArrayItem{ key: none, val: 'get_provider_links' }]),
			rt.new_string(country_code_mutated).clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_accepted_types := rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_about()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_docs()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_support()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_pricing()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_terms()
			},
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_validated_links := rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(var_provider_links.clone().is_array())) {
			mut iter_2 := var_provider_links.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_link := item_2.val
				if !(var_link.clone().is_array()) {
					continue
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
				mut var_type := if var_link.array_isset(rt.new_string('_type')) && rt.is_true(rt.call_function('is_scalar', [var_link.array_get(rt.new_string('_type'))])) { rt.call_function('sanitize_key', [
						rt.new_string((var_link.array_get(rt.new_string('_type'))).str()),
					]) } else { rt.new_string('') }
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				if !rt.is_true(var_type)
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), var_accepted_types.clone(), rt.new_bool(true)]))))) {
					continue
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
				if !rt.is_true(var_link.array_get(rt.new_string('url')))
					|| !(var_link.array_get(rt.new_string('url')).is_string())
					|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_link.array_get(rt.new_string('url'))]))))) {
					continue
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
				mut var_url := rt.call_function('sanitize_url', [
					var_link.array_get(rt.new_string('url')),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				mut var_link_key := rt.new_string(var_type.str() + '|' + var_url.str())
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				if var_validated_links.array_isset(var_link_key) {
					continue
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
				var_validated_links.array_set(var_link_key, rt.create_array([
					rt.ArrayItem{ key: '_type', val: var_type },
					rt.ArrayItem{ key: 'url', val: var_url },
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
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_provider_links = rt.call_function('array_values', [
			var_validated_links.clone()])
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
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.clone()
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_4 := iife_temp_4.wc_get_logger()
		rt.call_method(iife_result_4, 'debug', [
			rt.new_string('Failed to get provider links: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		return rt.new_array()
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
	return var_provider_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_enabled(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	return (rt.call_function('wc_string_to_bool', [if !(rt.get_property(var_payment_gateway,
		'enabled')).is_null() {
		rt.get_property(var_payment_gateway, 'enabled')
	} else {
		rt.new_string('no')
	}])).to_bool()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		mut var_e := var_e_2.clone()
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_5 := iife_temp_5.wc_get_logger()
		rt.call_method(iife_result_5, 'debug', [
			rt.new_string('Failed to determine if gateway is enabled: ' +
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
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) needs_setup(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut var_needs_setup := rt.call_function('wc_string_to_bool', [
		var_payment_gateway.needs_setup()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	if rt.is_true(var_needs_setup) {
		return true
	}
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
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_6 := iife_temp_6.wc_get_logger()
		rt.call_method(iife_result_6, 'debug', [
			rt.new_string('Failed to determine if gateway needs setup: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
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
	if !(this.is_account_connected(mut var_payment_gateway)) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_test_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'is_test_mode' }]),
	]))
	{
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_test_mode()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'is_in_test_mode' }]),
	]))
	{
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_in_test_mode()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if !(rt.get_property(var_payment_gateway, 'testmode')).is_null() {
		return (rt.call_function('wc_string_to_bool', [
			rt.get_property(var_payment_gateway, 'testmode'),
		])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if !(rt.get_property(var_payment_gateway, 'test_mode')).is_null() {
		return (rt.call_function('wc_string_to_bool', [
			rt.get_property(var_payment_gateway, 'test_mode'),
		])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'get_option' }]),
	]))
	{
		mut var_test_mode := rt.call_function('filter_var', [
			var_payment_gateway.get_option(rt.new_string('test_mode'), rt.new_string('not_found')),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
			rt.get_constant('FILTER_NULL_ON_FAILURE'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if !(var_test_mode.clone().is_null()) {
			return var_test_mode.to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		var_test_mode = rt.call_function('filter_var', [
			var_payment_gateway.get_option(rt.new_string('testmode'), rt.new_string('not_found')),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
			rt.get_constant('FILTER_NULL_ON_FAILURE'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if !(var_test_mode.clone().is_null()) {
			return var_test_mode.to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut var_mode := rt.new_string((var_payment_gateway.get_option(rt.new_string('mode'),
			rt.new_string('not_found'))).str().to_lower())
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		if rt.is_true(rt.call_function('in_array', [var_mode.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'test' },
				rt.ArrayItem{ key: none, val: 'sandbox' }, rt.ArrayItem{ key: none, val: 'dev' }]),
			rt.new_bool(true)]))
		{
			return true
		} else if rt.is_true(rt.call_function('in_array', [var_mode.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'live' },
				rt.ArrayItem{ key: none, val: 'production' },
				rt.ArrayItem{ key: none, val: 'prod' }]),
			rt.new_bool(true)]))
		{
			return false
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
		mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_7 := iife_temp_7.wc_get_logger()
		rt.call_method(iife_result_7, 'debug', [
			rt.new_string('Failed to determine if gateway is in test mode: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
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
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_dev_mode(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'is_dev_mode' }]),
	]))
	{
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_dev_mode()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'is_in_dev_mode' }]),
	]))
	{
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_in_dev_mode()])).to_bool()
	}
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
		mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_8 := iife_temp_8.wc_get_logger()
		rt.call_method(iife_result_8, 'debug', [
			rt.new_string('Failed to determine if gateway is in dev mode: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
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
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_account_connected')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_account_connected' }])]) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_account_connected()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_connected')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_connected' }])]) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_connected()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Throwable') {
		mut var_e := var_e_6.clone()
		mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_9 := iife_temp_9.wc_get_logger()
		rt.call_method(iife_result_9, 'debug', [
			rt.new_string('Failed to determine if gateway account is connected: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_supported(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) bool {
	mut country_code_mutated := country_code
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_onboarding_supported')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_onboarding_supported' }])]) {
		mut var_result := rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
				rt.ArrayItem{ key: none, val: 'is_onboarding_supported' }]),
			rt.new_string(country_code_mutated).clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
			return (rt.new_null()).to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		if rt.is_true(rt.new_bool(var_result.clone().is_bool())) {
			return var_result.to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		return (rt.call_function('filter_var', [var_result.clone(),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'), rt.get_constant('FILTER_NULL_ON_FAILURE')])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Throwable') {
		mut var_e := var_e_7.clone()
		mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_10 := iife_temp_10.wc_get_logger()
		rt.call_method(iife_result_10, 'debug', [
			rt.new_string('Failed to determine if gateway supports onboarding: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'country', val: country_code_mutated },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	return (rt.new_null()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_onboarding_not_supported_message(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) string {
	mut country_code_mutated := country_code
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_onboarding_not_supported_message')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'get_onboarding_not_supported_message' }])]) {
		mut var_message := rt.call_function('call_user_func', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
				rt.ArrayItem{ key: none, val: 'get_onboarding_not_supported_message' }]),
			rt.new_string(country_code_mutated).clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
		if var_message.clone().is_string() && !(!rt.is_true(var_message)) {
			return (rt.call_function('sanitize_textarea_field', [
				rt.new_string(var_message.clone().to_string().trim_space()),
			])).str()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'Throwable') {
		mut var_e := var_e_8.clone()
		mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_11 := iife_temp_11.wc_get_logger()
		rt.call_method(iife_result_11, 'debug', [
			rt.new_string('Failed to determine the gateway onboarding not supported message: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'country', val: country_code_mutated },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_8
		}
	} else {
		rt.throw_exception(var_e_8)
		unsafe {
			goto end_label_8
		}
	}

	end_label_8:
	return (rt.new_null()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_started(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_onboarding_started')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_onboarding_started' }])]) {
		return (rt.call_function('wc_string_to_bool', [var_payment_gateway.is_onboarding_started()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	unsafe {
		goto end_label_9
	}
	catch_label_9:
	mut var_e_9 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_9, 'Throwable') {
		mut var_e := var_e_9.clone()
		mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_12 := iife_temp_12.wc_get_logger()
		rt.call_method(iife_result_12, 'debug', [
			rt.new_string('Failed to determine if gateway onboarding started: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_9
		}
	} else {
		rt.throw_exception(var_e_9)
		unsafe {
			goto end_label_9
		}
	}

	end_label_9:
	return this.is_account_connected(mut var_payment_gateway)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_onboarding_completed(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if !(this.is_onboarding_started(mut var_payment_gateway)) {
		return false
	}
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_onboarding_completed')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_onboarding_completed' }])]) {
		return (rt.call_function('wc_string_to_bool',
			[var_payment_gateway.is_onboarding_completed()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_account_partially_onboarded')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_account_partially_onboarded' }])]) {
		return !(rt.is_true(rt.call_function('wc_string_to_bool', [
			var_payment_gateway.is_account_partially_onboarded(),
		])))
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	unsafe {
		goto end_label_10
	}
	catch_label_10:
	mut var_e_10 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_10, 'Throwable') {
		mut var_e := var_e_10.clone()
		mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_13 := iife_temp_13.wc_get_logger()
		rt.call_method(iife_result_13, 'debug', [
			rt.new_string('Failed to determine if gateway onboarding is completed: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_10
		}
	} else {
		rt.throw_exception(var_e_10)
		unsafe {
			goto end_label_10
		}
	}

	end_label_10:
	return this.is_account_connected(mut var_payment_gateway)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_test_mode_onboarding')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_test_mode_onboarding' }])]) {
		return (rt.call_function('wc_string_to_bool',
			[var_payment_gateway.is_test_mode_onboarding()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('is_in_test_mode_onboarding')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'is_in_test_mode_onboarding' }])]) {
		return (rt.call_function('wc_string_to_bool',
			[var_payment_gateway.is_in_test_mode_onboarding()])).to_bool()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	unsafe {
		goto end_label_11
	}
	catch_label_11:
	mut var_e_11 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_11, 'Throwable') {
		mut var_e := var_e_11.clone()
		mut iife_temp_14 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_14 := iife_temp_14.wc_get_logger()
		rt.call_method(iife_result_14, 'debug', [
			rt.new_string('Failed to determine if gateway is in test mode onboarding: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_11
		}
	} else {
		rt.throw_exception(var_e_11)
		unsafe {
			goto end_label_11
		}
	}

	end_label_11:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_settings_url(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_settings_url')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'get_settings_url' }])]) {
		mut var_url := rt.new_string((var_payment_gateway.get_settings_url()).str().trim_space())
		if rt.has_exception() {
			unsafe {
				goto catch_label_12
			}
		}
		if !(!rt.is_true(var_url))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_valid_url', [var_url.clone()]))))) {
			var_url = rt.new_string(var_url.clone().to_string().trim_left(' \t\n\r'))
			if rt.has_exception() {
				unsafe {
					goto catch_label_12
				}
			}
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
				var_url.clone(),
				rt.new_string('wp-admin/'),
			])))
			{
				var_url = rt.call_function('substr', [var_url.clone(),
					rt.new_int('wp-admin/'.len)])
				if rt.has_exception() {
					unsafe {
						goto catch_label_12
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_12
				}
			}
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_url.clone(), rt.new_string('admin.php')])))
				|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_url.clone(), rt.new_string('/admin.php')]))) {
				var_url = rt.call_function('admin_url', [
					rt.new_string(var_url.clone().to_string().trim_left(' \t\n\r')),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_12
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_12
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_12
			}
		}
		if !(!rt.is_true(var_url))
			&& rt.is_true(rt.call_function('wc_is_valid_url', [var_url.clone()])) {
			return (rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{
						key: 'from'
						val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_settings()
					},
				]),
				var_url.clone(),
			])).str()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_12
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_12
		}
	}
	unsafe {
		goto end_label_12
	}
	catch_label_12:
	mut var_e_12 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_12, 'Throwable') {
		mut var_e := var_e_12.clone()
		mut iife_temp_15 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_15 := iife_temp_15.wc_get_logger()
		rt.call_method(iife_result_15, 'debug', [
			rt.new_string('Failed to get gateway settings URL: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_12
		}
	} else {
		rt.throw_exception(var_e_12)
		unsafe {
			goto end_label_12
		}
	}

	end_label_12:
	mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_16 := iife_temp_16.wc_payments_settings_url(rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: 'section'
			val: rt.get_property(var_payment_gateway, 'id').to_string().to_lower()
		},
		rt.ArrayItem{
			key: 'from'
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_settings()
		},
	]))
	return iife_result_16.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_onboarding_url(mut var_payment_gateway Class_WC_Payment_Gateway, return_url string) string {
	mut return_url_mutated := return_url
	if rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_connection_url')]))
		&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'get_connection_url' }])]) {
		return_url_mutated = (if !(return_url_mutated == '') { rt.new_string(return_url_mutated) } else { rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=checkout&from=' + (Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_provider_onboarding()).str()),
			]) }).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_13
			}
		}
		return (var_payment_gateway.get_connection_url(rt.new_string(return_url_mutated))).str()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_13
		}
	}
	unsafe {
		goto end_label_13
	}
	catch_label_13:
	mut var_e_13 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_13, 'Throwable') {
		mut var_e := var_e_13.clone()
		mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_17 := iife_temp_17.wc_get_logger()
		rt.call_method(iife_result_17, 'debug', [
			rt.new_string('Failed to get gateway connection URL: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		unsafe {
			goto end_label_13
		}
	} else {
		rt.throw_exception(var_e_13)
		unsafe {
			goto end_label_13
		}
	}

	end_label_13:
	return this.get_settings_url(mut var_payment_gateway)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_details(mut var_payment_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_entity_type := rt.new_string(this.get_containing_entity_type(mut var_payment_gateway))
	return rt.create_array([rt.ArrayItem{ key: '_type', val: var_entity_type },
		rt.ArrayItem{ key: 'slug', val: this.get_plugin_slug(mut var_payment_gateway) },
		rt.ArrayItem{
			key: 'file'
			val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg(),
				var_entity_type))
			{
				this.get_plugin_file(mut var_payment_gateway, '')
			} else {
				''
			}
		}, rt.ArrayItem{
			key: 'status'
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active()
		}])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_slug(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_wp_theme_directories := rt.new_null()
	if !(rt.get_property(var_payment_gateway, 'plugin_slug')).is_null() {
		return (rt.get_property(var_payment_gateway, 'plugin_slug')).str()
	}
	mut var_gateway_class_filename :=
		rt.new_string(this.get_class_filename(mut var_payment_gateway))
	if !(var_gateway_class_filename.clone().is_string()) {
		return ''
	}
	mut var_entity_type := rt.new_string(this.get_containing_entity_type(mut var_payment_gateway))
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown(),
		var_entity_type))
	{
		return ''
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_theme(),
		var_entity_type))
	{
		if rt.is_true(rt.new_bool(var_wp_theme_directories.clone().is_array())) {
			mut iter_3 := var_wp_theme_directories.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_dir := item_3.val
				if rt.is_true(rt.call_function('str_starts_with', [
					var_gateway_class_filename.clone(), var_dir.clone()]))
				{
					return this.extract_slug_from_path((rt.call_function('substr', [
						var_gateway_class_filename.clone(),
						rt.new_int(var_dir.clone().to_string().len),
					])).str())
				}
			}
		}
		return ''
	}
	mut var_gateway_class_plugins_path := rt.new_string(rt.call_function('plugin_basename', [
		var_gateway_class_filename.clone(),
	]).to_string().trim_space())
	return this.extract_slug_from_path(var_gateway_class_plugins_path.str())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_plugin_file(mut var_payment_gateway Class_WC_Payment_Gateway, plugin_slug string) string {
	mut plugin_slug_mutated := plugin_slug
	if !(rt.get_property(var_payment_gateway, 'plugin_file')).is_null() {
		mut var_plugin_file := rt.get_property(var_payment_gateway, 'plugin_file')
		if !(var_plugin_file.clone().is_string()) {
			return ''
		}
		mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_18 := iife_temp_18.trim_php_file_extension(var_plugin_file.clone())
		return iife_result_18.str()
	}
	if plugin_slug_mutated == '' {
		plugin_slug_mutated = this.get_plugin_slug(mut var_payment_gateway)
	}
	if plugin_slug_mutated == '' {
		return ''
	}
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_19 := iife_temp_19.get_plugin_path_from_slug(rt.new_string(plugin_slug_mutated))
	var_plugin_file = iife_result_19
	if !(var_plugin_file.clone().is_string()) || !rt.is_true(var_plugin_file) {
		return ''
	}
	mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_20 := iife_temp_20.trim_php_file_extension(var_plugin_file.clone())
	return iife_result_20.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_recommended_payment_methods(mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_payment_gateway, rt.new_string('get_recommended_payment_methods')])))))
		|| !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_payment_gateway
	}, rt.ArrayItem{ key: none, val: 'get_recommended_payment_methods' }])])) {
		return rt.new_array()
	}
	mut var_recommended_pms := rt.call_function('call_user_func', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_payment_gateway },
			rt.ArrayItem{ key: none, val: 'get_recommended_payment_methods' }]),
		rt.new_string(country_code_mutated).clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	if !(var_recommended_pms.clone().is_array()) {
		return rt.new_array()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_14
		}
	}
	unsafe {
		goto end_label_14
	}
	catch_label_14:
	mut var_e_14 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_14, 'Throwable') {
		mut var_e := var_e_14.clone()
		mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_21 := iife_temp_21.wc_get_logger()
		rt.call_method(iife_result_21, 'debug', [
			rt.new_string('Failed to get recommended payment methods: ' +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
				rt.ArrayItem{ key: 'country', val: country_code_mutated },
				rt.ArrayItem{ key: 'source', val: 'settings-payments' },
				rt.ArrayItem{ key: 'exception', val: var_e },
			]),
		])
		return rt.new_array()
		unsafe {
			goto end_label_14
		}
	} else {
		rt.throw_exception(var_e_14)
		unsafe {
			goto end_label_14
		}
	}

	end_label_14:
	var_recommended_pms = rt.call_function('array_filter', [var_recommended_pms.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'validate_recommended_payment_method' },
		])])
	var_recommended_pms =
		this.sort_recommended_payment_methods(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](var_recommended_pms))
	mut var_standardized_pms := rt.new_array()
	mut iter_4 := var_recommended_pms.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_recommended_pm := item_4.val
		mut var_index := item_4.key
		var_standardized_pms.array_push(this.standardize_recommended_payment_method(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](var_recommended_pm),
			var_index.to_i64()))
	}
	return var_standardized_pms.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) validate_recommended_payment_method(var_recommended_pm rt.PhpVal) bool {
	return var_recommended_pm.clone().is_array()
		&& !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('id'))))
		&& !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('title'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) sort_recommended_payment_methods(mut var_recommended_pms Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array) rt.PhpVal {
	mut var_recommended_pms_mutated := var_recommended_pms
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
	}
	rt.call_function('usort', [var_recommended_pms_mutated, rt.new_closure(closure_23_fn)])
	return rt.call_function('array_values', [var_recommended_pms_mutated])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) standardize_recommended_payment_method(mut var_recommended_pm Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array, order i64) rt.PhpVal {
	mut var_standard_details := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_function('sanitize_key', [
			var_recommended_pm.array_get(rt.new_string('id')),
		]) },
		rt.ArrayItem{ key: '_order', val: order },
		rt.ArrayItem{ key: 'enabled', val: rt.call_function('wc_string_to_bool', [
			if !(var_recommended_pm.array_get(rt.new_string('enabled'))).is_null() {
				var_recommended_pm.array_get(rt.new_string('enabled'))
			} else {
				rt.new_bool(true)
			},
		]) },
		rt.ArrayItem{ key: 'required', val: rt.call_function('wc_string_to_bool', [
			if !(var_recommended_pm.array_get(rt.new_string('required'))).is_null() {
				var_recommended_pm.array_get(rt.new_string('required'))
			} else {
				rt.new_bool(false)
			},
		]) },
		rt.ArrayItem{ key: 'title', val: rt.call_function('sanitize_text_field', [
			var_recommended_pm.array_get(rt.new_string('title')),
		]) },
		rt.ArrayItem{ key: 'description', val: '' },
		rt.ArrayItem{ key: 'icon', val: '' },
		rt.ArrayItem{
			key: 'category'
			val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.payment_method_category_primary()
		},
		rt.ArrayItem{ key: 'notice', val: rt.create_array([
			rt.ArrayItem{ key: 'badge', val: '' },
			rt.ArrayItem{ key: 'message', val: '' },
			rt.ArrayItem{ key: 'link_text', val: '' },
			rt.ArrayItem{ key: 'link_url', val: '' },
		]) },
	])
	if !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('description')))) {
		var_standard_details.array_set('description',
			(var_recommended_pm.array_get(rt.new_string('description'))).str())
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/<[^>]+>/'),
			var_standard_details.array_get(rt.new_string('description'))]))
		{
			mut var_allowed_tags := rt.call_function('wp_kses_allowed_html', [
				rt.new_string('data'),
			])
			var_allowed_tags = rt.call_function('array_merge', [
				var_allowed_tags.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'a', val: rt.create_array([
						rt.ArrayItem{ key: 'href', val: true },
						rt.ArrayItem{ key: 'target', val: true },
					]) },
				])])
			var_standard_details.array_set('description', rt.call_function('wp_kses', [
				var_standard_details.array_get(rt.new_string('description')),
				var_allowed_tags.clone(),
			]))
		}
	}
	if !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('icon'))))
		&& rt.is_true(rt.call_function('wc_is_valid_url', [var_recommended_pm.array_get(rt.new_string('icon'))])) {
		var_standard_details.array_set('icon', rt.call_function('sanitize_url', [
			var_recommended_pm.array_get(rt.new_string('icon')),
		]))
	}
	if !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('category'))))
		&& rt.is_true(rt.call_function('in_array', [var_recommended_pm.array_get(rt.new_string('category')), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.payment_method_category_primary()
	}, rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.payment_method_category_secondary()
	}]), rt.new_bool(true)])) {
		var_standard_details.array_set('category',
			var_recommended_pm.array_get(rt.new_string('category')))
	}
	if !(!rt.is_true(var_recommended_pm.array_get(rt.new_string('notice'))))
		&& var_recommended_pm.array_get(rt.new_string('notice')).is_array() {
		mut var_notice := var_recommended_pm.array_get(rt.new_string('notice'))
		if !(!rt.is_true(var_notice.array_get(rt.new_string('badge')))) {
			var_standard_details.array_get_mut('notice').array_set('badge', rt.call_function('sanitize_text_field', [
				var_notice.array_get(rt.new_string('badge')),
			]))
		}
		if !(!rt.is_true(var_notice.array_get(rt.new_string('message')))) {
			var_standard_details.array_get_mut('notice').array_set('message', rt.call_function('sanitize_text_field', [
				var_notice.array_get(rt.new_string('message')),
			]))
		}
		if !(!rt.is_true(var_notice.array_get(rt.new_string('link_text')))) {
			var_standard_details.array_get_mut('notice').array_set('link_text', rt.call_function('sanitize_text_field', [
				var_notice.array_get(rt.new_string('link_text')),
			]))
		}
		if !(!rt.is_true(var_notice.array_get(rt.new_string('link_url'))))
			&& var_notice.array_get(rt.new_string('link_url')).is_string()
			&& rt.is_true(rt.call_function('wc_is_valid_url', [var_notice.array_get(rt.new_string('link_url'))])) {
			var_standard_details.array_get_mut('notice').array_set('link_url', rt.call_function('sanitize_url', [
				var_notice.array_get(rt.new_string('link_url')),
			]))
		}
	}
	return var_standard_details.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_class_filename(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	if !(rt.get_property(var_payment_gateway, 'class_filename')).is_null()
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('wp_get_environment_type', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
		key: none
		val: 'local'
	}, rt.ArrayItem{ key: none, val: 'development' }]), rt.new_bool(true)])) {
		mut var_class_filename := rt.get_property(var_payment_gateway, 'class_filename')
	} else {
		mut var_reflector := create_automattic_woocommerce_internal_admin_settings_paymentsproviders_reflectionclass(rt.call_function('get_class', [
			var_payment_gateway,
		]))
		if rt.has_exception() {
			unsafe {
				goto catch_label_15
			}
		}
		var_class_filename = var_reflector.getfilename()
		if rt.has_exception() {
			unsafe {
				goto catch_label_15
			}
		}
		unsafe {
			goto end_label_15
		}
		catch_label_15:
		mut var_e_15 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_15, 'Throwable') {
			mut var_e := var_e_15.clone()
			mut iife_temp_23 :=
				Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
			mut iife_result_23 := iife_temp_23.wc_get_logger()
			rt.call_method(iife_result_23, 'debug', [
				rt.new_string('Failed to get gateway class filename: ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
				rt.create_array([
					rt.ArrayItem{ key: 'gateway', val: rt.get_property(var_payment_gateway, 'id') },
					rt.ArrayItem{ key: 'source', val: 'settings-payments' },
					rt.ArrayItem{ key: 'exception', val: var_e },
				]),
			])
			return (rt.new_null()).str()
			unsafe {
				goto end_label_15
			}
		} else {
			rt.throw_exception(var_e_15)
			unsafe {
				goto end_label_15
			}
		}

		end_label_15:
	}
	if !(var_class_filename.clone().is_string()) {
		return (rt.new_null()).str()
	}
	return var_class_filename.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) get_containing_entity_type(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_wp_plugin_paths := rt.new_null()
	mut var_wp_theme_directories := rt.new_null()
	if !(rt.get_property(var_payment_gateway, 'extension_type')).is_null() {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_payment_gateway, 'extension_type'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_mu_plugin()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_theme()
				},
			]),
			rt.new_bool(true),
		])))))
		{
			return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown()).str()
		}
		return (rt.get_property(var_payment_gateway, 'extension_type')).str()
	}
	mut var_gateway_class_filename :=
		rt.new_string(this.get_class_filename(mut var_payment_gateway))
	if !(var_gateway_class_filename.clone().is_string()) {
		return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown()).str()
	}
	mut var_file := rt.call_function('wp_normalize_path', [var_gateway_class_filename.clone()])
	rt.call_function('arsort', [var_wp_plugin_paths.clone()])
	mut iter_5 := var_wp_plugin_paths.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_realdir := item_5.val
		mut var_dir := item_5.key
		if rt.is_true(rt.call_function('str_starts_with', [var_file.clone(),
			var_realdir.clone()]))
		{
			var_gateway_class_filename =
				rt.new_string(var_dir.str() +(rt.call_function('substr', [var_gateway_class_filename.clone(), rt.new_int(var_realdir.clone().to_string().len)])).str())
		}
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_gateway_class_filename.clone(),
		rt.call_function('wp_normalize_path', [rt.get_constant('WP_PLUGIN_DIR')])]))
	{
		return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg()).str()
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_gateway_class_filename.clone(),
		rt.call_function('wp_normalize_path', [rt.get_constant('WPMU_PLUGIN_DIR')])]))
	{
		return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_mu_plugin()).str()
	}
	if rt.is_true(rt.new_bool(var_wp_theme_directories.clone().is_array())) {
		mut iter_6 := var_wp_theme_directories.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_dir := item_6.val
			if rt.is_true(rt.call_function('str_starts_with', [
				var_gateway_class_filename.clone(), var_dir.clone()]))
			{
				return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_theme()).str()
			}
		}
	}
	return (Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) extract_slug_from_path(path string) string {
	mut path_mutated := path
	path_mutated = path_mutated.trim_space()
	path_mutated = path_mutated.trim_space()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string(path_mutated).clone(),
		rt.get_constant('DIRECTORY_SEPARATOR'),
	])))
	{
		mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_24 := iife_temp_24.trim_php_file_extension(rt.new_string(path_mutated))
		return iife_result_24.str()
	}
	mut var_parts := rt.call_function('explode', [rt.get_constant('DIRECTORY_SEPARATOR'),
		rt.new_string(path_mutated).clone()])
	if !(var_parts.clone().is_array()) {
		return ''
	}
	return (rt.call_function('reset', [var_parts.clone()])).str()
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

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
		proxy:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_https(_args ...rt.PhpVal) &Class_WC_HTTPS {
	mut obj := &Class_WC_HTTPS{
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

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_reflectionclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
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
		'get_title' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_title(mut dispatch_arg_0))
		}
		'get_description' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_description(mut dispatch_arg_0))
		}
		'get_icon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_icon(mut dispatch_arg_0))
		}
		'get_supports_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_supports_list(mut dispatch_arg_0)
		}
		'get_provider_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_provider_links(mut dispatch_arg_0, dispatch_arg_1)
		}
		'is_enabled' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_enabled(mut dispatch_arg_0))
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
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
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
		'is_onboarding_started' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_onboarding_started(mut dispatch_arg_0))
		}
		'is_onboarding_completed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_onboarding_completed(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'get_settings_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_settings_url(mut dispatch_arg_0))
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
		'get_plugin_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_plugin_details(mut dispatch_arg_0)
		}
		'get_plugin_slug' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_plugin_slug(mut dispatch_arg_0))
		}
		'get_plugin_file' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_plugin_file(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_recommended_payment_methods' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_recommended_payment_methods(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validate_recommended_payment_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_recommended_payment_method(dispatch_arg_0))
		}
		'sort_recommended_payment_methods' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.sort_recommended_payment_methods(mut dispatch_arg_0)
		}
		'standardize_recommended_payment_method' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.standardize_recommended_payment_method(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_class_filename' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_class_filename(mut dispatch_arg_0))
		}
		'get_containing_entity_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_containing_entity_type(mut dispatch_arg_0))
		}
		'extract_slug_from_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_slug_from_path(dispatch_arg_0))
		}
		else {
			return none
		}
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
		'proxy' {
			this.proxy = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
