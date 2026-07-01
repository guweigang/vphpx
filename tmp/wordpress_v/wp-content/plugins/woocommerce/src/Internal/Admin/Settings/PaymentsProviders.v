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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) init(mut var_payment_extension_suggestions Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions, mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.extension_suggestions = var_payment_extension_suggestions.dup()
	this.proxy = var_proxy.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateways(for_display bool, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	if var_for_display {
		if this.payment_gateways_for_display_memo.array_isset(rt.new_string(country_code_mutated)) {
			return this.payment_gateways_for_display_memo.array_get(country_code_mutated)
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_admin_field_payment_gateways')])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		mut var_payment_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
		var_payment_gateways = this.handle_non_standard_registration_for_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways))
		var_payment_gateways = this.remove_shell_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways), country_code_mutated)
		this.payment_gateways_for_display_memo.array_set(country_code_mutated, var_payment_gateways.dup())
		return var_payment_gateways.dup()
	}
	if this.payment_gateways_memo.array_isset(rt.new_string(country_code_mutated)) {
		return this.payment_gateways_memo.array_get(country_code_mutated)
	}
	var_payment_gateways = rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	var_payment_gateways = this.handle_non_standard_registration_for_payment_gateways(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_gateways))
	this.payment_gateways_memo.array_set(country_code_mutated, var_payment_gateways.dup())
	return var_payment_gateways.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) remove_shell_payment_gateways(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array, country_code string) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
	mut country_code_mutated := country_code
	country_code_mutated = country_code_mutated.to_upper()
	mut var_grouped_payment_gateways := this.group_gateways_by_extension(mut var_payment_gateways_mutated, country_code_mutated)
	closure_1_fn := fn [var_grouped_payment_gateways, var_country_code] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_gateway := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if this.is_shell_payment_gateway(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway)) {
		mut var_gateway_details := this.get_payment_gateway_details(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_gateway), 0, country_code_mutated)
		if !rt.is_true(var_gateway_details) || !(var_gateway_details.array_isset(rt.new_string('plugin'))) || !rt.is_true(var_gateway_details.array_get('plugin').array_get('file')) {
			return rt.new_bool(true)
		}
		if !rt.is_true(var_grouped_payment_gateways.array_get(var_gateway_details.array_get('plugin').array_get('file'))) || var_grouped_payment_gateways.array_get(var_gateway_details.array_get('plugin').array_get('file')).array_count() <= 1 {
			return rt.new_bool(true)
		}
		{
			mut iter_1 := var_grouped_payment_gateways.array_get(var_gateway_details.array_get('plugin').array_get('file')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_extension_gateway := item_1.val
				if !(this.is_shell_payment_gateway(mut rt.cast_object_ptr[Class_WC_Payment_Gateway](var_extension_gateway))) {
					return rt.new_bool(false)
				}
			}
		}
	}
	return rt.new_bool(true)
	}
	return rt.call_function('array_filter', [var_payment_gateways_mutated.dup(), rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_provider_instance(gateway_id string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(gateway_id)) {
		return this.instances.array_get(gateway_id)
	}
	mut var_provider_class := rt.new_null()
	if this.payment_gateways_providers_class_map.array_isset(rt.new_string(gateway_id)) {
		var_provider_class = this.payment_gateways_providers_class_map.array_get(gateway_id)
	} else {
		{
			mut iter_1 := this.payment_gateways_providers_class_map.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_mapped_class := item_1.val
				mut var_gateway_id_pattern := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_gateway_id_pattern = rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('.*'), var_gateway_id_pattern.dup()])
					if rt.is_true(rt.call_function('preg_match', ['/^' + (var_gateway_id_pattern).str() + '$/', rt.new_string(gateway_id)])) {
						var_provider_class = var_mapped_class
						break
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_provider_class.dup().is_null()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_provider_class.dup(), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.class()]))))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The provider class for gateway ID "%s" must extend the PaymentGateway class.'), rt.new_string('woocommerce')]), rt.new_string(gateway_id)]), rt.new_string('10.4.0')])
		var_provider_class = rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_provider_class.dup().is_null())) {
		if !(this.instances.array_isset(rt.new_string('generic'))) {
			this.instances.array_set('generic', create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(this.proxy))
		}
		return this.instances.array_get('generic')
	}
	this.instances.array_set(gateway_id, rt.create_object_dynamically(var_provider_class, [this.proxy]))
	return this.instances.array_get(gateway_id)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_extension_suggestion_provider_instance(pes_id string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(pes_id)) {
		return this.instances.array_get(pes_id)
	}
	mut var_provider_class := rt.new_null()
	if this.payment_extension_suggestions_providers_class_map.array_isset(rt.new_string(pes_id)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [this.payment_extension_suggestions_providers_class_map.array_get(pes_id), Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.class()]))))) {
			rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The provider class for payment extension suggestion ID "%s" must extend the PaymentGateway class.'), rt.new_string('woocommerce')]), rt.new_string(pes_id)]), rt.new_string('10.4.0')])
			// unsupported statement: Stmt_Nop
		} else {
			var_provider_class = this.payment_extension_suggestions_providers_class_map.array_get(pes_id)
		}
	}
	if rt.is_true(rt.new_bool(var_provider_class.dup().is_null())) {
		if !(this.instances.array_isset(rt.new_string('generic'))) {
			this.instances.array_set('generic', create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway(this.proxy))
		}
		return this.instances.array_get('generic')
	}
	this.instances.array_set(pes_id, rt.create_object_dynamically(var_provider_class, [this.proxy]))
	return this.instances.array_get(pes_id)
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
	return rt.call_method(var_provider, 'get_details', [var_payment_gateway, rt.new_int(payment_gateway_order), rt.new_string(country_code_mutated).dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_plugin_slug(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut var_provider := this.get_payment_gateway_provider_instance((rt.get_property(, 'id')).str())
	return (rt.call_method(var_provider, 'get_plugin_slug', [var_payment_gateway])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_payment_gateway_plugin_file(mut var_payment_gateway Class_WC_Payment_Gateway, plugin_slug string) string {
	mut plugin_slug_mutated := plugin_slug
	mut var_provider := 
	return ().str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_offline_payment_methods_gateways() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_offline_payment_method(id string) bool {
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_offline_group_last(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) order_map_add_gateway(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, id string) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_shell_payment_gateway(mut var_gateway Class_WC_Payment_Gateway) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestions(location string, context string) rt.PhpVal {
	mut location_mutated := location
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_by_id(id string) rt.PhpVal {
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_by_plugin_slug(slug string, country_code string) rt.PhpVal {
	mut country_code_mutated := country_code
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) attach_extension_suggestion(id string) bool {
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) hide_extension_suggestion(id string) bool {
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_extension_suggestion_categories() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_order_map() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) save_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) update_payment_providers_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_order_map_mutated := var_order_map
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_gateway := rt.new_null()
	mut var_order_map_mutated := var_order_map
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_suggestion_order_map_id(suggestion_id string) string {
	mut suggestion_id_mutated := suggestion_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_suggestion_order_map_id(id string) bool {
	mut id_mutated := id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) get_suggestion_id_from_order_map_id(order_map_id string) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) reset_memo()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) handle_non_standard_registration_for_payment_gateways(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) maybe_add_pseudo_mollie_gateway(mut var_payment_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_payment_gateways_mutated := var_payment_gateways
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_payment_gateway_details(mut var_gateway_details Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_payment_gateway Class_WC_Payment_Gateway, country_code string) rt.PhpVal {
	mut var_gateway_details_mutated := var_gateway_details
	mut country_code_mutated := country_code
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) has_enabled_ecommerce_gateways() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) enhance_extension_suggestion(mut var_extension_suggestion Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_extension_suggestion_mutated := var_extension_suggestion
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) is_payment_extension_suggestion_hidden(mut var_extension Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_extension_mutated := var_extension
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) payment_providers_order_map_apply_mappings(mut var_base_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_new_mappings Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_gateway := rt.new_null()
	mut var_new_mappings_mutated := var_new_mappings
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders) group_gateways_by_extension(mut var_gateways Class_Automattic_WooCommerce_Internal_Admin_Settings_array, country_code string) rt.PhpVal {
	mut var_gateways_mutated := var_gateways
	mut country_code_mutated := country_code
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders {
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

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_settings_paymentsproviders()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
