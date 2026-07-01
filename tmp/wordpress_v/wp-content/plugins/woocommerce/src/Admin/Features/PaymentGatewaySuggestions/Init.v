import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.recommended_payment_plugins_dismiss_option() string {
	return 'woocommerce_setting_payments_recommendations_hidden'
}
struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) construct()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController{}; return temp.init() }()
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_default_country'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init', ['Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine'], &this) }, rt.ArrayItem{ key: none, val: 'delete_specs_transient' }])])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_suggestions(mut var_specs Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_?array) rt.PhpVal {
	mut var_specs_mutated := var_specs
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	var_specs_mutated = if rt.is_true(rt.new_bool(var_specs_mutated.dup().is_array())) { var_specs_mutated } else { Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_specs() }
	mut var_results := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0) }(rt.new_object('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_?array', []string{}, var_specs_mutated))
	mut var_specs_to_return := var_results.array_get('suggestions')
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
		var_specs_to_save = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }()
		var_specs_to_return = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0) }(var_specs_to_save.dup()).array_get('suggestions')
	} else if var_results.array_get('errors').array_count() > 0 {
		var_specs_to_save = var_specs_mutated.dup()
	}
	if var_results.array_get('errors').array_count() > 0 {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init{}; return temp.log_errors(arg_0) }(var_results.array_get('errors'))
	}
	if rt.is_true(var_specs_to_save) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}; return temp.get_instance() }(), 'set_specs_transient', [rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_specs_to_return.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_cached_or_default_suggestions() rt.PhpVal {
	mut var_specs := if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }() } else { rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}; return temp.get_instance() }(), 'get_cached_specs', []rt.PhpVal{}) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))) || 0 == var_specs.dup().array_count())) {
		var_specs = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }()
	}
	var_specs = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), var_specs.dup()])
	mut var_results := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}; return temp.evaluate_specs(arg_0) }(var_specs.dup())
	return var_results.array_get('suggestions')
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.delete_specs_transient()  {
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}; return temp.get_instance() }(), 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }()])
	}
	mut var_specs := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}; return temp.get_instance() }(), 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_specs)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))))) || 0 == var_specs.dup().array_count())) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}; return temp.get_all() }()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), var_specs.dup()])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.should_display() bool {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.recommended_payment_plugins_dismiss_option(), rt.new_string('no')]))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_allow_payment_recommendations'), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.dismiss() rt.PhpVal {
	return rt.call_function('update_option', [Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.recommended_payment_plugins_dismiss_option(), rt.new_string('yes')])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_init() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewayscontroller() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController{
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

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewaysuggestionsdatasourcepoller() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_suggestions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_suggestions(mut dispatch_arg_0)
		}
		'get_cached_or_default_suggestions' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_cached_or_default_suggestions()
		}
		'delete_specs_transient' {
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.delete_specs_transient()
			return rt.new_null()
		}
		'get_specs' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_specs()
		}
		'should_display' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.should_display())
		}
		'dismiss' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.dismiss()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_paymentgatewaysuggestions_init_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
