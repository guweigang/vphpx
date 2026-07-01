import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.possibly_register_pre_install_wc_pay_promotion_gateway(var_gateways rt.PhpVal) rt.PhpVal {
	mut var_gateways_mutated := var_gateways
	if rt.is_true(rt.new_bool(rt.is_true(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.can_show_promotion()) && rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion{}; return temp.is_dismissed() }())))))) {
		var_gateways_mutated.array_push('Automattic\\WooCommerce\\Internal\\Admin\\WCPayPromotion\\WCPaymentGatewayPreInstallWCPayPromotion')
	}
	return var_gateways_mutated.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.can_show_promotion() bool {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])) {
		return false
	}
	mut var_wc_pay_spec := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_pay_spec)))) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.set_gateway_top_of_list(var_ordering rt.PhpVal) rt.PhpVal {
	mut var_ordering_mutated := var_ordering
	var_ordering_mutated = rt.cast_array(var_ordering_mutated)
	mut var_id := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.gateway_id()
	if rt.is_true(rt.new_bool(!(var_ordering_mutated.array_isset(var_id)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_ordering_mutated.array_get(var_id).is_long() || var_ordering_mutated.array_get(var_id).is_double()))))))) {
		mut var_is_empty := rt.new_bool(rt.new_bool(!rt.is_true(var_ordering_mutated) || rt.is_true(rt.new_bool(var_ordering_mutated.dup().array_count() == 1 && rt.is_true(rt.call_function('in_array', [var_ordering_mutated.array_get(0), rt.create_array([rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: '' }])]))))))
		var_ordering_mutated.array_set(var_id, if rt.is_true(var_is_empty) { rt.new_int(0) } else { rt.sub(rt.call_function('min', [rt.call_function('array_map', [rt.new_string('intval'), var_ordering_mutated.dup()])]), rt.new_int(1)) })
	}
	return var_ordering_mutated.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec(fetch_from_remote bool) rt.PhpVal {
	mut var_promotions := if var_fetch_from_remote { Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_promotions() } else { Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_cached_or_default_promotions() }
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_promotion := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.get_property(var_promotion, 'plugins')).is_null() && rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), rt.get_property(var_promotion, 'plugins'), rt.new_bool(true)])))
	}
	mut var_promotion := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(rt.get_property(var_promotion, 'plugins')).is_null() && rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), rt.get_property(var_promotion, 'plugins'), rt.new_bool(true)])))
	}
	mut var_wc_pay_promotion_spec := rt.call_function('array_values', [rt.call_function('array_filter', [var_promotions.dup(), rt.new_closure(closure_1_fn)])])
	return rt.call_function('current', [var_wc_pay_promotion_spec.dup()])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_promotions() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_specs()
	mut var_results := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0, arg_1) }(var_specs.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-wcpay-promotions' }]))
	mut var_specs_to_return := var_results.array_get('suggestions')
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
		var_specs_to_save = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}; return temp.get_all() }()
		var_specs_to_return = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0) }(var_specs_to_save.dup()).array_get('suggestions')
	} else if var_results.array_get('errors').array_count() > 0 {
		var_specs_to_save = var_specs.dup()
	}
	if var_results.array_get('errors').array_count() > 0 {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{}; return temp.log_errors(arg_0) }(var_results.array_get('errors'))
	}
	if rt.is_true(var_specs_to_save) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}; return temp.get_instance() }(), 'set_specs_transient', [rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_specs_to_return.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_cached_or_default_promotions() rt.PhpVal {
	mut var_specs := if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}; return temp.get_all() }() } else { rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}; return temp.get_instance() }(), 'get_cached_specs', []rt.PhpVal{}) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))) || 0 == var_specs.dup().array_count())) {
		var_specs = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}; return temp.get_all() }()
	}
	mut var_results := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0, arg_1) }(var_specs.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-wcpay-promotions' }]))
	return var_results.array_get('suggestions')
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.is_woopay_eligible() bool {
	mut var_wcpay_promotion := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_wc_pay_promotion_spec(false)
	return rt.is_true(var_wcpay_promotion) && rt.is_true(rt.identical(rt.new_string('woocommerce_payments:woopay'), rt.get_property(var_wcpay_promotion, 'id')))
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.delete_specs_transient()  {
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}; return temp.get_instance() }(), 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]), rt.new_string('no'))) {
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}; return temp.get_all() }()
	}
	mut var_specs := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{}; return temp.get_instance() }(), 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))) || 0 == var_specs.dup().array_count())) {
		var_specs = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{}; return temp.get_all() }()
	}
	return var_specs.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init.load_payment_method_promotions()  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_style(arg_0, arg_1, arg_2) }(rt.new_string('payment-method-promotions'), rt.new_string('style'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('payment-method-promotions'), rt.new_bool(true))
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

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_init() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaymentgatewaypreinstallwcpaypromotion() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_evaluatesuggestion() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_defaultpromotions() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_wcpaypromotion_init_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
