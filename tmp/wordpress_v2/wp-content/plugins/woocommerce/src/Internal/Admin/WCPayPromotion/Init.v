import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.possibly_register_pre_install_wc_pay_promotion_gateway(var_gateways rt.PhpVal) rt.PhpVal {
	mut var_gateways_mutated := var_gateways
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion{}
	mut iife_result_0 := iife_temp_0.is_dismissed()
	if rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.can_show_promotion())
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		var_gateways_mutated.array_push('Automattic\\WooCommerce\\Internal\\Admin\\WCPayPromotion\\WCPaymentGatewayPreInstallWCPayPromotion')
	}
	return var_gateways_mutated.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.can_show_promotion() bool {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])) {
		return false
	}
	mut var_wc_pay_spec :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_pay_spec)))) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.set_gateway_top_of_list(var_ordering rt.PhpVal) rt.PhpVal {
	mut var_ordering_mutated := var_ordering
	var_ordering_mutated = rt.cast_array(var_ordering_mutated)
	mut var_id :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.gateway_id()
	if !(var_ordering_mutated.array_isset(var_id))
		|| !(var_ordering_mutated.array_get(var_id).is_long()
		|| var_ordering_mutated.array_get(var_id).is_double()) {
		mut var_is_empty := rt.new_bool(!rt.is_true(var_ordering_mutated)
			|| var_ordering_mutated.clone().array_count() == 1
			&& rt.is_true(rt.call_function('in_array', [var_ordering_mutated.array_get(rt.new_int(0)), rt.create_array([rt.ArrayItem{
			key: none
			val: false
		}, rt.ArrayItem{ key: none, val: '' }])])))
		var_ordering_mutated.array_set(var_id, if rt.is_true(var_is_empty) { rt.new_int(0) } else { rt.sub(rt.call_function('min', [
				rt.call_function('array_map', [rt.new_string('intval'),
					var_ordering_mutated.clone()]),
			]), rt.new_int(1)) })
	}
	return var_ordering_mutated.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec(fetch_from_remote bool) rt.PhpVal {
	mut var_promotions := if var_fetch_from_remote {
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_promotions()
	} else {
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_cached_or_default_promotions()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_promotion := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.get_property(var_promotion, 'plugins')).is_null()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), rt.get_property(var_promotion, 'plugins'), rt.new_bool(true)])))
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_promotion := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.get_property(var_promotion, 'plugins')).is_null()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), rt.get_property(var_promotion, 'plugins'), rt.new_bool(true)])))
	}
	mut var_wc_pay_promotion_spec := rt.call_function('array_values', [
		rt.call_function('array_filter', [var_promotions.clone(),
			rt.new_closure(closure_2_fn)]),
	])
	return rt.call_function('current', [var_wc_pay_promotion_spec.clone()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_promotions() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_specs()
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_3 := iife_temp_3.evaluate_specs(var_specs.clone(), rt.create_array([
		rt.ArrayItem{ key: 'source', val: 'wc-wcpay-promotions' },
	]))
	mut var_results := iife_result_3
	mut var_specs_to_return := var_results.array_get(rt.new_string('suggestions'))
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}
		mut iife_result_4 := iife_temp_4.get_all()
		var_specs_to_save = iife_result_4
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
		mut iife_result_5 := iife_temp_5.evaluate_specs(var_specs_to_save.clone())
		var_specs_to_return = iife_result_5.array_get(rt.new_string('suggestions'))
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
		var_specs_to_save = var_specs.clone()
	}
	if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{}
		mut iife_result_6 := iife_temp_6.log_errors(var_results.array_get(rt.new_string('errors')))
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_7 :=
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}
		mut iife_result_7 := iife_temp_7.get_instance()
		rt.call_method(iife_result_7, 'set_specs_transient', [
			rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]),
			rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS')),
		])
	}
	return var_specs_to_return.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_cached_or_default_promotions() rt.PhpVal {
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}
	mut iife_result_8 := iife_temp_8.get_all()
	mut iife_temp_9 :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}
	mut iife_result_9 := iife_temp_9.get_instance()
	mut var_specs := if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	])))
	{ iife_result_8 } else { rt.call_method(iife_result_9, 'get_cached_specs', []rt.PhpVal{}) }
	if !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
		mut iife_temp_10 :=
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}
		mut iife_result_10 := iife_temp_10.get_all()
		var_specs = iife_result_10
	}
	mut iife_temp_11 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_11 := iife_temp_11.evaluate_specs(var_specs.clone(), rt.create_array([
		rt.ArrayItem{ key: 'source', val: 'wc-wcpay-promotions' },
	]))
	mut var_results := iife_result_11
	return var_results.array_get(rt.new_string('suggestions'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.is_woopay_eligible() bool {
	mut var_wcpay_promotion :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec(false)
	return rt.is_true(var_wcpay_promotion)
		&& rt.is_true(rt.identical(rt.new_string('woocommerce_payments:woopay'), rt.get_property(var_wcpay_promotion, 'id')))
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.delete_specs_transient() {
	mut iife_temp_12 :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}
	mut iife_result_12 := iife_temp_12.get_instance()
	rt.call_method(iife_result_12, 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	]), rt.new_string('no')))
	{
		mut iife_temp_13 :=
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}
		mut iife_result_13 := iife_temp_13.get_all()
		return iife_result_13
	}
	mut iife_temp_14 :=
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}
	mut iife_result_14 := iife_temp_14.get_instance()
	mut var_specs := rt.call_method(iife_result_14, 'get_specs_from_data_sources', []rt.PhpVal{})
	if !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
		mut iife_temp_15 :=
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}
		mut iife_result_15 := iife_temp_15.get_all()
		var_specs = iife_result_15
	}
	return var_specs.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.load_payment_method_promotions() {
	mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_16 := iife_temp_16.register_style(rt.new_string('payment-method-promotions'),
		rt.new_string('style'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-components' },
	]))
	mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_17 := iife_temp_17.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('payment-method-promotions'), rt.new_bool(true))
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{
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

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaymentgatewaypreinstallwcpaypromotion(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion{
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

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_defaultpromotions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'possibly_register_pre_install_wc_pay_promotion_gateway' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.possibly_register_pre_install_wc_pay_promotion_gateway(dispatch_arg_0)
		}
		'can_show_promotion' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.can_show_promotion())
		}
		'set_gateway_top_of_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.set_gateway_top_of_list(dispatch_arg_0)
		}
		'get_wc_pay_promotion_spec' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec(dispatch_arg_0)
		}
		'get_promotions' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_promotions()
		}
		'get_cached_or_default_promotions' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_cached_or_default_promotions()
		}
		'is_woopay_eligible' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.is_woopay_eligible())
		}
		'delete_specs_transient' {
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.delete_specs_transient()
			return rt.new_null()
		}
		'get_specs' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_specs()
		}
		'load_payment_method_promotions' {
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.load_payment_method_promotions()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
