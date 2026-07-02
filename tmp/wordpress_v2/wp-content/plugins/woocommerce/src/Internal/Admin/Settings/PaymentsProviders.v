import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_gateway() string {
	return 'gateway'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm() string {
	return 'offline_pm'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pms_group() string {
	return 'offline_pms_group'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_suggestion() string {
	return 'suggestion'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Gateway_BACS.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Cheque.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() }])
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_not_installed() string {
	return 'not_installed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed() string {
	return 'installed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active() string {
	return 'active'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_wporg() string {
	return 'wporg'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_mu_plugin() string {
	return 'mu_plugin'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_theme() string {
	return 'theme'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_type_unknown() string {
	return 'unknown'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.providers_order_option() string {
	return 'woocommerce_gateway_order'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.suggestion_ordering_prefix() string {
	return '_wc_pes_'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group() string {
	return '_wc_offline_payment_methods_group'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_express_checkout() string {
	return 'express_checkout'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_bnpl() string {
	return 'bnpl'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_crypto() string {
	return 'crypto'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_psp() string {
	return 'psp'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_support() string {
	return 'support'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_docs() string {
	return 'documentation'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_about() string {
	return 'about'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_terms() string {
	return 'terms'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_pricing() string {
	return 'pricing'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders {
	rt.PhpObjectBase
pub mut:
		payment_gateways_providers_class_map rt.PhpVal = rt.new_array()
		payment_extension_suggestions_providers_class_map rt.PhpVal = rt.new_array()
		instances rt.PhpVal = rt.new_array()
		payment_gateways_memo rt.PhpVal = rt.new_array()
		payment_gateways_for_display_memo rt.PhpVal = rt.new_array()
		extension_suggestions rt.PhpVal = rt.new_null()
		proxy rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) init(mut var_payment_extension_suggestions Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions, mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	this.extension_suggestions = var_payment_extension_suggestions
	this.proxy = var_proxy
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateways(for_display bool, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	if var_for_display {
		if this.payment_gateways_for_display_memo.array_isset(rt.new_string(country_code_mutated)) {
			return this.payment_gateways_for_display_memo.array_get(rt.new_string(country_code_mutated))
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_admin_field_payment_gateways')])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		mut var_payment_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
		var_payment_gateways = this.handle_non_standard_registration_for_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways))
		var_payment_gateways = this.remove_shell_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways), country_code_mutated)
		this.payment_gateways_for_display_memo.array_set(country_code_mutated, var_payment_gateways.clone())
		return var_payment_gateways.clone()
	}
	if this.payment_gateways_memo.array_isset(rt.new_string(country_code_mutated)) {
		return this.payment_gateways_memo.array_get(rt.new_string(country_code_mutated))
	}
	var_payment_gateways = rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	var_payment_gateways = this.handle_non_standard_registration_for_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways))
	this.payment_gateways_memo.array_set(country_code_mutated, var_payment_gateways.clone())
	return var_payment_gateways.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) remove_shell_payment_gateways(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array, country_code string) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	mut var_grouped_payment_gateways := this.group_gateways_by_extension(mut var_payment_gateways_mutated, country_code_mutated)
	closure_1_fn := fn [var_grouped_payment_gateways, var_country_code] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if this.is_shell_payment_gateway(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway)) {
			mut var_gateway_details := this.get_payment_gateway_details(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway), 0, country_code_mutated)
			if !rt.is_true(var_gateway_details) || !(var_gateway_details.array_isset(rt.new_string('plugin'))) || !rt.is_true(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))) {
				return rt.new_bool(true)
			}
			if !rt.is_true(var_grouped_payment_gateways.array_get(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')))) || var_grouped_payment_gateways.array_get(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))).array_count() <= 1 {
				return rt.new_bool(true)
			}
			mut iter_1 := var_grouped_payment_gateways.array_get(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extension_gateway := item_1.val
				if !(this.is_shell_payment_gateway(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_extension_gateway))) {
					return rt.new_bool(false)
				}
			}
		}
		return rt.new_bool(true)
		}
	return rt.call_function('array_filter', [var_payment_gateways_mutated, rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_provider_instance(gateway_id string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(gateway_id)) {
		return this.instances.array_get(rt.new_string(gateway_id))
	}
	mut var_provider_class := rt.new_null()
	if this.payment_gateways_providers_class_map.array_isset(rt.new_string(gateway_id)) {
	var_provider_class = this.payment_gateways_providers_class_map.array_get(rt.new_string(gateway_id))
	} else {
		mut iter_2 := this.payment_gateways_providers_class_map.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_mapped_class := item_2.val
			mut var_gateway_id_pattern := item_2.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_gateway_id_pattern.clone(), rt.new_string('*')]))))) {
				var_gateway_id_pattern = rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('.*'), var_gateway_id_pattern.clone()])
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^' + (var_gateway_id_pattern).str() + '$/'), rt.new_string(gateway_id)])) {
					var_provider_class = var_mapped_class
					break
				}
			}
		}
	}
	if !(var_provider_class.clone().is_null()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_provider_class.clone(), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.class()]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The provider class for gateway ID "%s" must extend the PaymentGateway class.'), rt.new_string('woocommerce')]), rt.new_string(gateway_id)]), rt.new_string('10.4.0')])
	var_provider_class = rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_provider_class.clone().is_null())) {
		if !(this.instances.array_isset(rt.new_string('generic'))) {
			this.instances.array_set('generic', create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(this.proxy))
		}
		return this.instances.array_get(rt.new_string('generic'))
	}
	this.instances.array_set(gateway_id, rt.create_object_dynamically(var_provider_class, [this.proxy]))
	return this.instances.array_get(rt.new_string(gateway_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_extension_suggestion_provider_instance(pes_id string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(pes_id)) {
		return this.instances.array_get(rt.new_string(pes_id))
	}
	mut var_provider_class := rt.new_null()
	if this.payment_extension_suggestions_providers_class_map.array_isset(rt.new_string(pes_id)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [this.payment_extension_suggestions_providers_class_map.array_get(rt.new_string(pes_id)), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.class()]))))) {
			rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The provider class for payment extension suggestion ID "%s" must extend the PaymentGateway class.'), rt.new_string('woocommerce')]), rt.new_string(pes_id)]), rt.new_string('10.4.0')])
		} else {
		var_provider_class = this.payment_extension_suggestions_providers_class_map.array_get(rt.new_string(pes_id))
		}
	}
	if rt.is_true(rt.new_bool(var_provider_class.clone().is_null())) {
		if !(this.instances.array_isset(rt.new_string('generic'))) {
			this.instances.array_set('generic', create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(this.proxy))
		}
		return this.instances.array_get(rt.new_string('generic'))
	}
	this.instances.array_set(pes_id, rt.create_object_dynamically(var_provider_class, [this.proxy]))
	return this.instances.array_get(rt.new_string(pes_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_details(mut var_payment_gateway Class_WC_Payment_Gateway, payment_gateway_order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	return this.enhance_payment_gateway_details(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](this.get_payment_gateway_base_details(mut var_payment_gateway, payment_gateway_order, country_code_mutated)), mut var_payment_gateway, country_code_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_base_details(mut var_payment_gateway Class_WC_Payment_Gateway, payment_gateway_order i64, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	mut var_provider := this.get_payment_gateway_provider_instance((rt.get_property(var_payment_gateway, 'id')).str())
	return rt.call_method(var_provider, 'get_details', [var_payment_gateway, rt.new_int(payment_gateway_order), rt.new_string(country_code_mutated).clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_plugin_slug(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_provider := this.get_payment_gateway_provider_instance((rt.get_property(var_payment_gateway, 'id')).str())
	return (rt.call_method(var_provider, 'get_plugin_slug', [var_payment_gateway])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_plugin_file(mut var_payment_gateway Class_WC_Payment_Gateway, plugin_slug string) string {
	mut plugin_slug_mutated := plugin_slug
	mut var_provider := this.get_payment_gateway_provider_instance((rt.get_property(var_payment_gateway, 'id')).str())
	return (rt.call_method(var_provider, 'get_plugin_file', [var_payment_gateway, rt.new_string(plugin_slug_mutated).clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_offline_payment_methods_gateways() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(this.is_offline_payment_method((rt.get_property(var_gateway, 'id')).str()))
		}
	return rt.call_function('array_filter', [this.get_payment_gateways(false, ''), rt.new_closure(closure_2_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_offline_payment_method(id string) bool {
	mut id_mutated := id
	return (rt.call_function('in_array', [rt.new_string(id_mutated).clone(), Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_offline_group_last(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
	if !(var_order_map_mutated.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group())) {
		return false
	}
	mut var_offline_group_order := var_order_map_mutated.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group())
	mut iter_3 := var_order_map_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_order := item_3.val
		mut var_id := item_3.key
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group(), var_id)) {
			continue
		}
		if this.is_offline_payment_method((var_id).str()) {
			continue
		}
		if this.is_suggestion_order_map_id((var_id).str()) {
			continue
		}
		if rt.is_true(rt.greater(var_order, var_offline_group_order)) {
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) order_map_add_gateway(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, id string) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	mut id_mutated := id
	if this.is_offline_group_last(mut var_order_map_mutated) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_2 := iife_temp_2.order_map_add_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), rt.new_string(id_mutated), var_order_map_mutated.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group()))
		return iife_result_2
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_3 := iife_temp_3.order_map_add_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), rt.new_string(id_mutated), if !rt.is_true(var_order_map_mutated) { rt.new_int(0) } else { rt.add(rt.call_function('max', [var_order_map_mutated]), rt.new_int(1)) })
	return iife_result_3
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_shell_payment_gateway(mut var_gateway Class_WC_Payment_Gateway) bool {
	return !rt.is_true(var_gateway.get_method_title()) && !rt.is_true(var_gateway.get_method_description()) || rt.is_true(rt.identical(rt.new_string('WooPayments'), var_gateway.get_method_title())) && rt.is_true(rt.call_function('str_starts_with', [rt.get_property(var_gateway, 'id'), rt.new_string((Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id()).str() + '_')]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestions(location string, context string) rt.PhpVal {
	mut location_mutated := location
	location_mutated = location_mutated.to_upper()
	mut var_preferred_psp := rt.new_null()
	mut var_preferred_apm := rt.new_null()
	mut var_preferred_offline_psp := rt.new_null()
	mut var_other := rt.new_array()
	mut var_extensions := rt.call_method(this.extension_suggestions, 'get_country_extensions', [rt.new_string(location_mutated).clone(), rt.new_string(context)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
		}
	rt.call_function('usort', [var_extensions.clone(), rt.new_closure(closure_5_fn)])
	mut var_has_enabled_ecommerce_gateways := rt.new_bool(this.has_enabled_ecommerce_gateways())
	mut var_active_extensions := rt.new_array()
	mut iter_4 := var_extensions.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_extension := item_4.val
		var_extension = this.enhance_extension_suggestion(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_extension))
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active(), var_extension.array_get(rt.new_string('plugin')).array_get(rt.new_string('status')))) {
			var_active_extensions.array_push(var_extension.array_get(rt.new_string('id')))
			continue
		}
		mut var_is_preferred := rt.call_function('in_array', [Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.tag_preferred(), var_extension.array_get(rt.new_string('tags')), rt.new_bool(true)])
		mut var_is_hidden := rt.new_bool(this.is_payment_extension_suggestion_hidden(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_extension)))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_hidden)))) && rt.is_true(var_is_preferred) {
			if !rt.is_true(var_preferred_offline_psp) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_psp(), var_extension.array_get(rt.new_string('_type')))) && rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.tag_preferred_offline(), var_extension.array_get(rt.new_string('tags')), rt.new_bool(true)])) {
				var_preferred_offline_psp = var_extension.clone()
				continue
			}
			if !rt.is_true(var_preferred_psp) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_psp(), var_extension.array_get(rt.new_string('_type')))) {
				var_preferred_psp = var_extension.clone()
				continue
			}
			if !rt.is_true(var_preferred_apm) && rt.is_true(rt.call_function('in_array', [var_extension.array_get(rt.new_string('_type')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_apm() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_express_checkout() }]), rt.new_bool(true)])) {
				var_preferred_apm = var_extension.clone()
				continue
			}
		}
		if rt.is_true(var_is_hidden) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_apm(), var_extension.array_get(rt.new_string('_type')))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_full_stack(), var_extension.array_get(rt.new_string('id')))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_has_enabled_ecommerce_gateways)))) && rt.is_true(rt.call_function('in_array', [var_extension.array_get(rt.new_string('_type')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_express_checkout() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_bnpl() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_crypto() }]), rt.new_bool(true)])) {
			continue
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_bnpl(), var_extension.array_get(rt.new_string('_type')))) && rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.stripe(), var_active_extensions.clone(), rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.woopayments(), var_active_extensions.clone(), rt.new_bool(true)])) && !(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.affirm(), var_extension.array_get(rt.new_string('id')))) && rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(location_mutated)))) {
			continue
		}
		mut var_extension_slug := var_extension.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
		closure_6_fn := fn [var_extension_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_suggestion := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.identical(var_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_extension_slug)
			}
		mut var_extension_exists := rt.call_function('array_filter', [var_other.clone(), rt.new_closure(closure_6_fn)])
		if !(!rt.is_true(var_extension_exists)) {
			continue
		}
		var_other.array_push(var_extension.clone())
	}
	closure_7_fn := fn [var_preferred_psp, var_preferred_apm] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_suggestion := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(var_preferred_psp) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_preferred_psp.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))))) && !rt.is_true(var_preferred_apm) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_preferred_apm.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))))))
		}
	closure_8_fn := fn [var_preferred_psp, var_preferred_apm] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_suggestion := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(var_preferred_psp) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_preferred_psp.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))))) && !rt.is_true(var_preferred_apm) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_preferred_apm.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))))))
		}
	var_other = rt.call_function('array_values', [rt.call_function('array_filter', [var_other.clone(), rt.new_closure(closure_7_fn)])])
	if !(!rt.is_true(var_preferred_psp)) {
		var_preferred_psp.array_get_mut('tags').array_push(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.tag_recommended())
	}
	return rt.create_array([rt.ArrayItem{ key: 'preferred', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: var_preferred_psp }, rt.ArrayItem{ key: none, val: var_preferred_apm }, rt.ArrayItem{ key: none, val: var_preferred_offline_psp }])])]) }, rt.ArrayItem{ key: 'other', val: var_other }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_by_id(id string) rt.PhpVal {
	mut id_mutated := id
	mut var_suggestion := rt.call_method(this.extension_suggestions, 'get_by_id', [rt.new_string(id_mutated).clone()])
	if !(var_suggestion.clone().is_null()) {
	var_suggestion = this.enhance_extension_suggestion(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_suggestion))
	}
	return var_suggestion.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_by_plugin_slug(slug string, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	mut var_suggestion := rt.call_method(this.extension_suggestions, 'get_by_plugin_slug', [rt.new_string(slug), rt.new_string(country_code_mutated).clone(), Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.suggestions_context()])
	if !(var_suggestion.clone().is_null()) {
	var_suggestion = this.enhance_extension_suggestion(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_suggestion))
	}
	return var_suggestion.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) attach_extension_suggestion(id string) bool {
	mut id_mutated := id
	if this.is_suggestion_order_map_id(id_mutated) {
	id_mutated = this.get_suggestion_id_from_order_map_id(id_mutated)
	}
	mut var_suggestion := this.get_extension_suggestion_by_id(id_mutated)
	if rt.is_true(rt.new_bool(var_suggestion.clone().is_null())) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Invalid suggestion ID.'), rt.new_string('woocommerce')]))))
	}
	mut var_payments_nox_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), rt.new_array()])
	if !rt.is_true(var_payments_nox_profile) {
	var_payments_nox_profile = rt.new_array()
	} else {
	var_payments_nox_profile = rt.call_function('maybe_unserialize', [var_payments_nox_profile.clone()])
	}
	if !(!rt.is_true(var_payments_nox_profile.array_get(rt.new_string('suggestions')).array_get(rt.new_string(id_mutated)).array_get(rt.new_string('attached')).array_get(rt.new_string('timestamp')))) {
		return true
	}
	if !rt.is_true(var_payments_nox_profile.array_get(rt.new_string('suggestions'))) {
		var_payments_nox_profile.array_set('suggestions', rt.new_array())
	}
	if !rt.is_true(var_payments_nox_profile.array_get(rt.new_string('suggestions')).array_get(rt.new_string(id_mutated))) {
		var_payments_nox_profile.array_get_mut('suggestions').array_set(id_mutated, rt.new_array())
	}
	if !rt.is_true(var_payments_nox_profile.array_get(rt.new_string('suggestions')).array_get(rt.new_string(id_mutated)).array_get(rt.new_string('attached'))) {
		var_payments_nox_profile.array_get_mut('suggestions').array_get_mut(id_mutated).array_set('attached', rt.new_array())
	}
	var_payments_nox_profile.array_get_mut('suggestions').array_get_mut(id_mutated).array_get_mut('attached').array_set('timestamp', rt.call_function('time', []rt.PhpVal{}))
	mut var_result := rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), var_payments_nox_profile.clone(), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		return false
	}
	mut switch_val_1 := rt.new_string(id_mutated)
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_full_stack())) || rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_wallet())) {
		rt.call_function('update_option', [rt.new_string('woocommerce_paypal_branded'), rt.new_string('payments_settings'), rt.new_bool(false)])
	} else {
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) hide_extension_suggestion(id string) bool {
	mut id_mutated := id
	if this.is_suggestion_order_map_id(id_mutated) {
	id_mutated = this.get_suggestion_id_from_order_map_id(id_mutated)
	}
	mut var_suggestion := this.get_extension_suggestion_by_id(id_mutated)
	if rt.is_true(rt.new_bool(var_suggestion.clone().is_null())) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Invalid suggestion ID.'), rt.new_string('woocommerce')]))))
	}
	mut var_user_payments_nox_profile := rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), rt.new_bool(true)])
	if !rt.is_true(var_user_payments_nox_profile) {
	var_user_payments_nox_profile = rt.new_array()
	} else {
	var_user_payments_nox_profile = rt.call_function('maybe_unserialize', [var_user_payments_nox_profile.clone()])
	}
	if !rt.is_true(var_user_payments_nox_profile.array_get(rt.new_string('hidden_suggestions'))) {
		var_user_payments_nox_profile.array_set('hidden_suggestions', rt.new_array())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).clone(), rt.call_function('array_column', [var_user_payments_nox_profile.array_get(rt.new_string('hidden_suggestions')), rt.new_string('id')]), rt.new_bool(true)])) {
		return true
	}
	var_user_payments_nox_profile.array_get_mut('hidden_suggestions').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: id_mutated }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('time', []rt.PhpVal{}) }]))
	mut var_result := rt.call_function('update_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), var_user_payments_nox_profile.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	var_categories.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_express_checkout() }, rt.ArrayItem{ key: '_priority', val: 10 }, rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Wallets & Express checkouts'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Allow shoppers to fast-track the checkout process with express options like Apple Pay and Google Pay.'), rt.new_string('woocommerce')]) }]))
	var_categories.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_bnpl() }, rt.ArrayItem{ key: '_priority', val: 20 }, rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Buy Now, Pay Later'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Offer flexible payment options to your shoppers.'), rt.new_string('woocommerce')]) }]))
	var_categories.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_crypto() }, rt.ArrayItem{ key: '_priority', val: 30 }, rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Crypto Payments'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Offer cryptocurrency payment options to your shoppers.'), rt.new_string('woocommerce')]) }]))
	var_categories.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_psp() }, rt.ArrayItem{ key: '_priority', val: 40 }, rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Payment Providers'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [rt.new_string('Give your shoppers additional ways to pay.'), rt.new_string('woocommerce')]) }]))
	return var_categories.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_order_map() rt.PhpVal {
	return this.enhance_order_map(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.providers_order_option(), rt.new_array()])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) save_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
	return (rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.providers_order_option(), var_order_map_mutated])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) update_payment_providers_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
	mut var_existing_order_map := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.providers_order_option(), rt.new_array()])
	mut var_new_order_map := this.payment_providers_order_map_apply_mappings(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_existing_order_map), mut var_order_map_mutated)
	var_new_order_map = this.enhance_order_map(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_new_order_map))
	return this.save_order_map(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_new_order_map))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_gateway := rt.new_null()
	mut var_order_map_mutated := var_order_map
	mut var_payment_gateways := this.get_payment_gateways(false, '')
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_gateway, 'id')
		}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_gateway, 'id')
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_gateway, 'id')
		}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_gateway, 'id')
		}
	var_payment_gateways = rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_closure(closure_9_fn), var_payment_gateways.clone()]), var_payment_gateways.clone()])
	mut var_payment_gateways_order_map := rt.call_function('array_flip', [rt.func_array_keys(var_payment_gateways.clone())])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_13 := iife_temp_13.normalize_plugin_slug(rt.new_string(this.get_payment_gateway_plugin_slug(mut var_gateway)))
		return rt.call_method(this.extension_suggestions, 'get_by_plugin_slug', [iife_result_13])
		}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_15 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_15 := iife_temp_15.normalize_plugin_slug(rt.new_string(this.get_payment_gateway_plugin_slug(mut var_gateway)))
		return rt.call_method(this.extension_suggestions, 'get_by_plugin_slug', [iife_result_15])
		}
	mut var_payment_gateways_to_suggestions_map := rt.call_function('array_map', [rt.new_closure(closure_14_fn), var_payment_gateways.clone()])
	if !rt.is_true(var_order_map_mutated) {
	var_order_map_mutated = var_payment_gateways_order_map.clone()
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_16 := iife_temp_16.order_map_normalize(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated))
	var_order_map_mutated = iife_result_16
	mut var_handled_suggestion_ids := rt.new_array()
	mut var_suggestion_order_map_id_to_offset_map := rt.new_array()
	mut iter_5 := var_payment_gateways_order_map.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_order := item_5.val
		mut var_id := item_5.key
		if var_order_map_mutated.array_isset(var_id) {
			continue
		}
		if !(!rt.is_true(var_payment_gateways_to_suggestions_map.array_get(var_id))) {
			mut var_suggestion_id := var_payment_gateways_to_suggestions_map.array_get(var_id).array_get(rt.new_string('id'))
			mut var_suggestion_order_map_id := rt.new_string(this.get_suggestion_order_map_id((var_suggestion_id).str()))
			if var_order_map_mutated.array_isset(var_suggestion_order_map_id) {
				if !(var_suggestion_order_map_id_to_offset_map.array_isset(var_suggestion_order_map_id)) {
					var_suggestion_order_map_id_to_offset_map.array_set(var_suggestion_order_map_id, 0)
				}
				var_suggestion_order_map_id_to_offset_map.array_get(var_suggestion_order_map_id) = rt.add(var_suggestion_order_map_id_to_offset_map.array_get(var_suggestion_order_map_id), rt.new_int(1))
				mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
				mut iife_result_17 := iife_temp_17.order_map_place_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), var_id.clone(), rt.add(var_order_map_mutated.array_get(var_suggestion_order_map_id), var_suggestion_order_map_id_to_offset_map.array_get(var_suggestion_order_map_id)))
				var_order_map_mutated = iife_result_17
				var_handled_suggestion_ids.array_push(var_suggestion_id.clone())
				continue
			}
		}
	var_order_map_mutated = this.order_map_add_gateway(mut var_order_map_mutated, (var_id).str())
	}
	var_handled_suggestion_ids = rt.call_function('array_unique', [var_handled_suggestion_ids.clone()])
	mut iter_6 := rt.func_array_keys(var_order_map_mutated).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_id := item_6.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_payment_gateways_to_suggestions_map.clone().array_isset(var_id.clone())))))) || !rt.is_true(var_payment_gateways_to_suggestions_map.array_get(var_id)) {
			continue
		}
		mut var_suggestion := var_payment_gateways_to_suggestions_map.array_get(var_id)
		if rt.is_true(rt.call_function('in_array', [var_suggestion.array_get(rt.new_string('id')), var_handled_suggestion_ids.clone(), rt.new_bool(true)])) {
			continue
		}
		mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_18 := iife_temp_18.order_map_place_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), rt.new_string(this.get_suggestion_order_map_id((var_suggestion.array_get(rt.new_string('id'))).str())), var_order_map_mutated.array_get(var_id))
		var_order_map_mutated = iife_result_18
		var_handled_suggestion_ids.array_push(var_suggestion.array_get(rt.new_string('id')))
	}
	mut var_offline_methods := rt.call_function('array_filter', [var_order_map_mutated, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'is_offline_payment_method' }]), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	if !(!rt.is_true(var_offline_methods)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_order_map_mutated.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group())))))) {
		mut var_last_offline_method_order := rt.call_function('max', [var_offline_methods.clone()])
		mut iife_temp_19 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_19 := iife_temp_19.order_map_place_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group(), var_last_offline_method_order.clone())
		var_order_map_mutated = iife_result_19
		}
		mut var_target_order := rt.add(var_order_map_mutated.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group()), rt.new_int(1))
		rt.call_function('asort', [var_offline_methods.clone()])
		mut iter_7 := var_offline_methods.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_order := item_7.val
			mut var_offline_method := item_7.key
			mut iife_temp_20 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
			mut iife_result_20 := iife_temp_20.order_map_place_at_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated), var_offline_method.clone(), var_target_order.clone())
			var_order_map_mutated = iife_result_20
			rt.pre_inc(var_target_order)
		}
	}
	mut iife_temp_21 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_21 := iife_temp_21.order_map_normalize(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated))
	return iife_result_21
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_suggestion_order_map_id(suggestion_id string) string {
	mut suggestion_id_mutated := suggestion_id
	return (Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.suggestion_ordering_prefix()).str() + suggestion_id_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_suggestion_order_map_id(id string) bool {
	mut id_mutated := id
	return (rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.new_string(id_mutated).clone(), Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.suggestion_ordering_prefix()]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_suggestion_id_from_order_map_id(order_map_id string) string {
	return (rt.call_function('str_replace', [Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.suggestion_ordering_prefix(), rt.new_string(''), rt.new_string(order_map_id)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) reset_memo() {
	this.payment_gateways_memo = rt.new_array()
	this.payment_gateways_for_display_memo = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) handle_non_standard_registration_for_payment_gateways(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
	var_payment_gateways_mutated = this.maybe_add_pseudo_mollie_gateway(mut var_payment_gateways_mutated)
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_payment_gateways_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) maybe_add_pseudo_mollie_gateway(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
	mut var_mollie_provider := this.get_payment_gateway_provider_instance('mollie')
	if rt.is_true(rt.call_method(var_mollie_provider, 'is_gateway_registered', [var_payment_gateways_mutated])) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_payment_gateways_mutated)
	}
	mut var_mollie_suggestion := this.get_extension_suggestion_by_id((Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.mollie()).str())
	if !rt.is_true(var_mollie_suggestion) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_payment_gateways_mutated)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active(), var_mollie_suggestion.array_get(rt.new_string('plugin')).array_get(rt.new_string('status')))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_payment_gateways_mutated)
	}
	var_payment_gateways_mutated.array_push(rt.call_method(var_mollie_provider, 'get_pseudo_gateway', [var_mollie_suggestion.clone()]))
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_payment_gateways_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_payment_gateway_details(mut var_gateway_details Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut var_gateway_details_mutated := var_gateway_details
	mut country_code_mutated := country_code
	var_gateway_details_mutated.array_set('_type', if this.is_offline_payment_method((rt.get_property(var_payment_gateway, 'id')).str()) { Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm() } else { Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_gateway() })
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(), var_gateway_details_mutated.array_get(rt.new_string('_type')))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_gateway_details_mutated)
	}
	mut var_plugin_slug := var_gateway_details_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
	mut iife_temp_22 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_22 := iife_temp_22.normalize_plugin_slug(var_plugin_slug.clone())
	mut var_normalized_plugin_slug := iife_result_22
	mut var_suggestion := this.get_extension_suggestion_by_plugin_slug((var_normalized_plugin_slug).str(), country_code_mutated)
	if !(var_suggestion.clone().is_null()) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_suggestion.array_get(rt.new_string('id')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_full_stack() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_wallet() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.mollie() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.monei() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.antom() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.mercado_pago() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.amazon_pay() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.square() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.payoneer() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.airwallex() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.coinbase() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.authorize_net() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.bolt() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.depay() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.elavon() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.fortispay() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_zettle() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.rapyd() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.paypal_braintree() }]), rt.new_bool(true)]))))) {
			if !(!rt.is_true(var_suggestion.array_get(rt.new_string('title')))) {
				var_gateway_details_mutated.array_set('title', var_suggestion.array_get(rt.new_string('title')))
			}
			if !(!rt.is_true(var_suggestion.array_get(rt.new_string('description')))) {
				var_gateway_details_mutated.array_set('description', var_suggestion.array_get(rt.new_string('description')))
			}
		}
		if !(!rt.is_true(var_suggestion.array_get(rt.new_string('icon')))) {
			var_gateway_details_mutated.array_set('icon', var_suggestion.array_get(rt.new_string('icon')))
		}
		if !(!rt.is_true(var_suggestion.array_get(rt.new_string('image')))) {
			var_gateway_details_mutated.array_set('image', var_suggestion.array_get(rt.new_string('image')))
		}
		if !rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('links'))) && !(!rt.is_true(var_suggestion.array_get(rt.new_string('links')))) {
			var_gateway_details_mutated.array_set('links', var_suggestion.array_get(rt.new_string('links')))
		}
		if !rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('tags'))) && !(!rt.is_true(var_suggestion.array_get(rt.new_string('tags')))) {
			var_gateway_details_mutated.array_set('tags', var_suggestion.array_get(rt.new_string('tags')))
		}
		if !rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('plugin'))) && !(!rt.is_true(var_suggestion.array_get(rt.new_string('plugin')))) {
			var_gateway_details_mutated.array_set('plugin', var_suggestion.array_get(rt.new_string('plugin')))
		}
		if !rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('_incentive'))) && !(!rt.is_true(var_suggestion.array_get(rt.new_string('_incentive')))) {
			var_gateway_details_mutated.array_set('_incentive', var_suggestion.array_get(rt.new_string('_incentive')))
		}
		var_gateway_details_mutated.array_set('_suggestion_id', var_suggestion.array_get(rt.new_string('id')))
	}
	mut var_plugin_data := rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('get_plugin_data'), var_plugin_slug.clone()])
	if !(!rt.is_true(var_plugin_data)) {
		if !rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('links'))) {
			if var_plugin_data.clone().is_array() && !(!rt.is_true(var_plugin_data.array_get(rt.new_string('PluginURI')))) {
				var_gateway_details_mutated.array_set('links', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: '_type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_about() }, rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [var_plugin_data.array_get(rt.new_string('PluginURI'))]) }]) }]))
			} else if !(!rt.is_true(var_gateway_details_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('_type')))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.plugin_type_wporg(), var_gateway_details_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('_type')))) {
				var_gateway_details_mutated.array_set('links', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: '_type', val: Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.link_type_about() }, rt.ArrayItem{ key: 'url', val: 'https://wordpress.org/plugins/' + (var_normalized_plugin_slug).str() }]) }]))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_gateway_details_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) has_enabled_ecommerce_gateways() bool {
	mut var_gateways := this.get_payment_gateways(false, '')
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled'))) && !(this.is_offline_payment_method((rt.get_property(var_gateway, 'id')).str()))
		}
	mut var_enabled_gateways := rt.call_function('array_filter', [var_gateways.clone(), rt.new_closure(closure_24_fn)])
	return !(!rt.is_true(var_enabled_gateways))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
	mut switch_val_2 := var_extension_suggestion_mutated.array_get(rt.new_string('_type'))
	if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_psp())) {
		var_extension_suggestion_mutated.array_set('category', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_psp())
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_express_checkout())) {
		var_extension_suggestion_mutated.array_set('category', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_express_checkout())
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_bnpl())) {
		var_extension_suggestion_mutated.array_set('category', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_bnpl())
	} else if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions.type_crypto())) {
		var_extension_suggestion_mutated.array_set('category', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.category_crypto())
	} else {
		var_extension_suggestion_mutated.array_set('category', '')
	}
	var_extension_suggestion_mutated.array_get_mut('plugin').array_set('status', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_not_installed())
	var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', '')
	if !(!rt.is_true(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))) {
		mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_24 := iife_temp_24.generate_testing_plugin_slugs(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), rt.new_bool(true))
		mut var_plugin_slug_variations := iife_result_24
		mut var_found := rt.new_bool(false)
		mut iter_8 := var_plugin_slug_variations.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_plugin_slug := item_8.val
			if rt.is_true(rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('is_plugin_active'), var_plugin_slug.clone()])) {
				var_found = rt.new_bool(true)
				var_extension_suggestion_mutated.array_get_mut('plugin').array_set('status', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active())
				var_extension_suggestion_mutated.array_get_mut('plugin').array_set('slug', var_plugin_slug.clone())
				var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('get_plugin_path_from_slug'), var_plugin_slug.clone()]))
				if !(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')).is_string()) {
					var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', '')
					break
				}
				mut iife_temp_25 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
				mut iife_result_25 := iife_temp_25.trim_php_file_extension(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')))
				var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', iife_result_25)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			mut iter_9 := var_plugin_slug_variations.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_plugin_slug := item_9.val
				if rt.is_true(rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('is_plugin_installed'), var_plugin_slug.clone()])) {
					var_extension_suggestion_mutated.array_get_mut('plugin').array_set('status', Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_installed())
					var_extension_suggestion_mutated.array_get_mut('plugin').array_set('slug', var_plugin_slug.clone())
					var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', rt.call_method(this.proxy, 'call_static', [Class_Automattic_WooCommerce_Admin_PluginsHelper.class(), rt.new_string('get_plugin_path_from_slug'), var_plugin_slug.clone()]))
					if !(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')).is_string()) {
						var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', '')
						break
					}
					mut iife_temp_26 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
					mut iife_result_26 := iife_temp_26.trim_php_file_extension(var_extension_suggestion_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')))
					var_extension_suggestion_mutated.array_get_mut('plugin').array_set('file', iife_result_26)
					break
				}
			}
		}
	}
	mut var_gateway_provider := this.get_payment_extension_suggestion_provider_instance((var_extension_suggestion_mutated.array_get(rt.new_string('id'))).str())
	var_extension_suggestion_mutated = rt.call_method(var_gateway_provider, 'enhance_extension_suggestion', [var_extension_suggestion_mutated])
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_extension_suggestion_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_payment_extension_suggestion_hidden(mut var_extension Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_extension_mutated := var_extension
	mut var_user_payments_nox_profile := rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(), rt.new_bool(true)])
	if !rt.is_true(var_user_payments_nox_profile) {
		return false
	}
	var_user_payments_nox_profile = rt.call_function('maybe_unserialize', [var_user_payments_nox_profile.clone()])
	if !rt.is_true(var_user_payments_nox_profile.array_get(rt.new_string('hidden_suggestions'))) {
		return false
	}
	return (rt.call_function('in_array', [var_extension_mutated.array_get(rt.new_string('id')), rt.call_function('array_column', [var_user_payments_nox_profile.array_get(rt.new_string('hidden_suggestions')), rt.new_string('id')]), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) payment_providers_order_map_apply_mappings(mut var_base_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_new_mappings Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_gateway := rt.new_null()
	mut var_new_mappings_mutated := var_new_mappings
	var_new_mappings_mutated = rt.call_function('array_filter', [var_new_mappings_mutated, rt.new_string('is_int')])
	if !rt.is_true(var_new_mappings_mutated) {
	var_new_mappings_mutated = rt.new_array()
	}
	if !rt.is_true(var_base_map) || (var_base_map.array_count() == var_new_mappings_mutated.array_count() && !rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(var_base_map), rt.func_array_keys(var_new_mappings_mutated)]))) {
	mut var_new_order_map := var_new_mappings_mutated
	} else {
		mut var_offline_pms := this.get_offline_payment_methods_gateways()
		closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_gateway, 'id')
			}
		closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_gateway, 'id')
			}
		closure_30_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_gateway, 'id')
			}
		closure_31_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_gateway := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_gateway, 'id')
			}
		var_offline_pms = rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_closure(closure_28_fn), var_offline_pms.clone()]), var_offline_pms.clone()])
		if var_base_map.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group()) && var_new_mappings_mutated.array_count() == var_offline_pms.clone().array_count() && !rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(var_new_mappings_mutated), rt.func_array_keys(var_offline_pms.clone())])) {
		mut iife_temp_31 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_31 := iife_temp_31.order_map_change_min_order(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_new_mappings_mutated), rt.add(var_base_map.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group()), rt.new_int(1)))
		var_new_mappings_mutated = iife_result_31
		}
	mut iife_temp_32 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_32 := iife_temp_32.order_map_apply_mappings(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_base_map), rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_new_mappings_mutated))
	var_new_order_map = iife_result_32
	}
	mut iife_temp_33 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_33 := iife_temp_33.order_map_normalize(var_new_order_map.clone())
	return iife_result_33
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) group_gateways_by_extension(mut var_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array, country_code string) rt.PhpVal {
	mut var_gateways_mutated := var_gateways
	mut country_code_mutated := country_code
	mut var_grouped := rt.create_array([rt.ArrayItem{ key: 'unknown_extension', val: rt.new_array() }])
	mut iter_10 := var_gateways_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_gateway := item_10.val
		mut var_gateway_details := this.get_payment_gateway_details(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway), 0, country_code_mutated)
		if !rt.is_true(var_gateway_details) || !(var_gateway_details.array_isset(rt.new_string('plugin'))) || !rt.is_true(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))) {
			var_grouped.array_get_mut('unknown_extension').array_push(var_gateway.clone())
			continue
		}
		if !rt.is_true(var_grouped.array_get(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')))) {
			var_grouped.array_set(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file')), rt.new_array())
		}
		var_grouped.array_get_mut(var_gateway_details.array_get(rt.new_string('plugin')).array_get(rt.new_string('file'))).array_push(var_gateway.clone())
	}
	return var_grouped.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders{
		PhpObjectBase: rt.PhpObjectBase{}
		payment_gateways_providers_class_map: rt.new_array()
		payment_extension_suggestions_providers_class_map: rt.new_array()
		instances: rt.new_array()
		payment_gateways_memo: rt.new_array()
		payment_gateways_for_display_memo: rt.new_array()
		extension_suggestions: rt.new_null()
		proxy: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_payment_gateways' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_payment_gateways(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_shell_payment_gateways' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.remove_shell_payment_gateways(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_payment_gateway_provider_instance' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_payment_gateway_provider_instance(dispatch_arg_0)
		}
		'get_payment_extension_suggestion_provider_instance' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_payment_extension_suggestion_provider_instance(dispatch_arg_0)
		}
		'get_payment_gateway_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_payment_gateway_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_payment_gateway_base_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_payment_gateway_base_details(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_payment_gateway_plugin_slug' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_payment_gateway_plugin_slug(mut dispatch_arg_0))
		}
		'get_payment_gateway_plugin_file' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_payment_gateway_plugin_file(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_offline_payment_methods_gateways' {
			return this.get_offline_payment_methods_gateways()
		}
		'is_offline_payment_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_offline_payment_method(dispatch_arg_0))
		}
		'is_offline_group_last' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_offline_group_last(mut dispatch_arg_0))
		}
		'order_map_add_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.order_map_add_gateway(mut dispatch_arg_0, dispatch_arg_1)
		}
		'is_shell_payment_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_shell_payment_gateway(mut dispatch_arg_0))
		}
		'get_extension_suggestions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_extension_suggestions(dispatch_arg_0, dispatch_arg_1)
		}
		'get_extension_suggestion_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_extension_suggestion_by_id(dispatch_arg_0)
		}
		'get_extension_suggestion_by_plugin_slug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_extension_suggestion_by_plugin_slug(dispatch_arg_0, dispatch_arg_1)
		}
		'attach_extension_suggestion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.attach_extension_suggestion(dispatch_arg_0))
		}
		'hide_extension_suggestion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hide_extension_suggestion(dispatch_arg_0))
		}
		'get_extension_suggestion_categories' {
			return this.get_extension_suggestion_categories()
		}
		'get_order_map' {
			return this.get_order_map()
		}
		'save_order_map' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.save_order_map(mut dispatch_arg_0))
		}
		'update_payment_providers_order_map' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.update_payment_providers_order_map(mut dispatch_arg_0))
		}
		'enhance_order_map' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.enhance_order_map(mut dispatch_arg_0)
		}
		'get_suggestion_order_map_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_suggestion_order_map_id(dispatch_arg_0))
		}
		'is_suggestion_order_map_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_suggestion_order_map_id(dispatch_arg_0))
		}
		'get_suggestion_id_from_order_map_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_suggestion_id_from_order_map_id(dispatch_arg_0))
		}
		'reset_memo' {
			this.reset_memo()
			return rt.new_null()
		}
		'handle_non_standard_registration_for_payment_gateways' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.handle_non_standard_registration_for_payment_gateways(mut dispatch_arg_0)
		}
		'maybe_add_pseudo_mollie_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.maybe_add_pseudo_mollie_gateway(mut dispatch_arg_0)
		}
		'enhance_payment_gateway_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.enhance_payment_gateway_details(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'has_enabled_ecommerce_gateways' {
			return rt.new_bool(this.has_enabled_ecommerce_gateways())
		}
		'enhance_extension_suggestion' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.enhance_extension_suggestion(mut dispatch_arg_0)
		}
		'is_payment_extension_suggestion_hidden' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_payment_extension_suggestion_hidden(mut dispatch_arg_0))
		}
		'payment_providers_order_map_apply_mappings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.payment_providers_order_map_apply_mappings(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'group_gateways_by_extension' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.group_gateways_by_extension(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'payment_gateways_providers_class_map' { return this.payment_gateways_providers_class_map }
		'payment_extension_suggestions_providers_class_map' { return this.payment_extension_suggestions_providers_class_map }
		'instances' { return this.instances }
		'payment_gateways_memo' { return this.payment_gateways_memo }
		'payment_gateways_for_display_memo' { return this.payment_gateways_for_display_memo }
		'extension_suggestions' { return this.extension_suggestions }
		'proxy' { return this.proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'payment_gateways_providers_class_map' { this.payment_gateways_providers_class_map = val; return true }
		'payment_extension_suggestions_providers_class_map' { this.payment_extension_suggestions_providers_class_map = val; return true }
		'instances' { this.instances = val; return true }
		'payment_gateways_memo' { this.payment_gateways_memo = val; return true }
		'payment_gateways_for_display_memo' { this.payment_gateways_for_display_memo = val; return true }
		'extension_suggestions' { this.extension_suggestions = val; return true }
		'proxy' { this.proxy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_settings_paymentsproviders()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Settings_Utils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_settings_utils()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_Utils', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
