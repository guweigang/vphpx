import rt

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.get_suggestions(mut var_specs Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_?array) rt.PhpVal {
	mut var_specs_mutated := var_specs
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	var_specs_mutated = if var_specs_mutated.is_array() { var_specs_mutated } else { Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.get_specs() }
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_0 := iife_temp_0.evaluate_specs(rt.new_object('Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_?array', []string{}, var_specs_mutated), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-shipping-partner-suggestions' }]))
	mut var_results := iife_result_0
	mut var_specs_to_return := var_results.array_get(rt.new_string('suggestions'))
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{}
	mut iife_result_1 := iife_temp_1.get_all()
	var_specs_to_save = iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_2 := iife_temp_2.evaluate_specs(var_specs_to_save.clone(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-shipping-partner-suggestions' }]))
	var_specs_to_return = iife_result_2.array_get(rt.new_string('suggestions'))
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
	var_specs_to_save = var_specs_mutated
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller{}
		mut iife_result_3 := iife_temp_3.get_instance()
		rt.call_method(iife_result_3, 'set_specs_transient', [rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.sort_by_primary(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_array](var_specs_to_return))
}

fn Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.sort_by_primary(mut var_suggestions Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_array) rt.PhpVal {
	mut var_country := if !(rt.call_function('wc_get_base_location', []rt.PhpVal{}).array_get(rt.new_string('country'))).is_null() { rt.call_function('wc_get_base_location', []rt.PhpVal{}).array_get(rt.new_string('country')) } else { rt.new_string('') }
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_idx := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: var_idx }])
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_idx := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: var_idx }])
		}
	mut var_indexed := rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_suggestions, rt.func_array_keys(var_suggestions)])
	closure_7_fn := fn [var_country] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_a_primary := rt.new_bool(!(rt.get_property(var_a.array_get(rt.new_int(0)), 'countries_where_primary')).is_null() && rt.get_property(var_a.array_get(rt.new_int(0)), 'countries_where_primary').is_array() && rt.is_true(rt.call_function('in_array', [var_country.clone(), rt.get_property(var_a.array_get(rt.new_int(0)), 'countries_where_primary'), rt.new_bool(true)])))
		mut var_b_primary := rt.new_bool(!(rt.get_property(var_b.array_get(rt.new_int(0)), 'countries_where_primary')).is_null() && rt.get_property(var_b.array_get(rt.new_int(0)), 'countries_where_primary').is_array() && rt.is_true(rt.call_function('in_array', [var_country.clone(), rt.get_property(var_b.array_get(rt.new_int(0)), 'countries_where_primary'), rt.new_bool(true)])))
		if rt.is_true(rt.identical(var_a_primary, var_b_primary)) {
			return rt.sub(var_a.array_get(rt.new_int(1)), var_b.array_get(rt.new_int(1)))
		}
		return rt.new_int(if rt.is_true(var_a_primary) { -1 } else { 1 })
		}
	rt.call_function('usort', [var_indexed.clone(), rt.new_closure(closure_7_fn)])
	return rt.call_function('array_column', [var_indexed.clone(), rt.new_int(0)])
}

fn Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{}
		mut iife_result_7 := iife_temp_7.get_all()
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_shipping_partner_suggestions_specs'), iife_result_7])
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller{}
	mut iife_result_8 := iife_temp_8.get_instance()
	mut var_specs := rt.call_method(iife_result_8, 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_specs)) || !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{}
		mut iife_result_9 := iife_temp_9.get_all()
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_shipping_partner_suggestions_specs'), iife_result_9])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_shipping_partner_suggestions_specs'), var_specs.clone()])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_shippingpartnersuggestions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_evaluatesuggestion(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_defaultshippingpartners(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_shippingpartnersuggestionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_suggestions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.get_suggestions(mut dispatch_arg_0)
		}
		'sort_by_primary' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.sort_by_primary(mut dispatch_arg_0)
		}
		'get_specs' {
			return Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions.get_specs()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
