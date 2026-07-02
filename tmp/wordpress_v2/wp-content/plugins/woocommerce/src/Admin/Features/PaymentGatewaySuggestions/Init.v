import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.recommended_payment_plugins_dismiss_option() string {
	return 'woocommerce_setting_payments_recommendations_hidden'
}
struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController{}
	mut iife_result_0 := iife_temp_0.init()
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_default_country'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init', ['Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine'], &this) }, rt.ArrayItem{ key: none, val: 'delete_specs_transient' }])])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_suggestions(mut var_specs Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_?array) rt.PhpVal {
	mut var_specs_mutated := var_specs
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	var_specs_mutated = if var_specs_mutated.is_array() { var_specs_mutated } else { Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_specs() }
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_1 := iife_temp_1.evaluate_specs(rt.new_object('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_?array', []string{}, var_specs_mutated))
	mut var_results := iife_result_1
	mut var_specs_to_return := var_results.array_get(rt.new_string('suggestions'))
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_2 := iife_temp_2.get_all()
	var_specs_to_save = iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_3 := iife_temp_3.evaluate_specs(var_specs_to_save.clone())
	var_specs_to_return = iife_result_3.array_get(rt.new_string('suggestions'))
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
	var_specs_to_save = var_specs_mutated
	}
	if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init{}
	mut iife_result_4 := iife_temp_4.log_errors(var_results.array_get(rt.new_string('errors')))
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}
		mut iife_result_5 := iife_temp_5.get_instance()
		rt.call_method(iife_result_5, 'set_specs_transient', [rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_specs_to_return.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_cached_or_default_suggestions() rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_6 := iife_temp_6.get_all()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}
	mut iife_result_7 := iife_temp_7.get_instance()
	mut var_specs := if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) { iife_result_6 } else { rt.call_method(iife_result_7, 'get_cached_specs', []rt.PhpVal{}) }
	if !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_8 := iife_temp_8.get_all()
	var_specs = iife_result_8
	}
	var_specs = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), var_specs.clone()])
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{}
	mut iife_result_9 := iife_temp_9.evaluate_specs(var_specs.clone())
	mut var_results := iife_result_9
	return var_results.array_get(rt.new_string('suggestions'))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.delete_specs_transient() {
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}
	mut iife_result_10 := iife_temp_10.get_instance()
	rt.call_method(iife_result_10, 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
		mut iife_result_11 := iife_temp_11.get_all()
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), iife_result_11])
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller{}
	mut iife_result_12 := iife_temp_12.get_instance()
	mut var_specs := rt.call_method(iife_result_12, 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_specs)) || !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
		mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
		mut iife_result_13 := iife_temp_13.get_all()
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), iife_result_13])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_payment_gateway_suggestion_specs'), var_specs.clone()])
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

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewayscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController{
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

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewaysuggestionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaySuggestionsDataSourcePoller {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
