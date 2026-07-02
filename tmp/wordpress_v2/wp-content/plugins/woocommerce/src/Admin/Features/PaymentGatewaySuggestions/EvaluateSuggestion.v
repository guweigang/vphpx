import rt

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_paymentgatewaysuggestions_evaluatesuggestion() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
		'memo', rt.new_array())
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.evaluate(var_spec rt.PhpVal, var_logger_args rt.PhpVal) rt.PhpVal {
	mut var_rule_evaluator :=
		create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator()
	mut var_suggestion := if var_spec.clone().is_array() {
		rt.array_to_object(var_spec)
	} else {
		var_spec.dup()
	}
	if !(rt.get_property(var_suggestion, 'is_visible')).is_null() {
		mut var_logger_slug := if !(!rt.is_true(rt.get_property(var_suggestion, 'id'))) {
			rt.get_property(var_suggestion, 'id')
		} else {
			rt.new_string('')
		}
		if !rt.is_true(var_logger_slug) {
			var_logger_slug = if !(!rt.is_true(rt.get_property(var_suggestion, 'title'))) { rt.call_function('sanitize_title_with_dashes', [
					rt.new_string(rt.get_property(var_suggestion, 'title').to_string().trim_space()),
				]) } else { rt.new_string('anonymous-suggestion') }
		}
		mut var_is_visible := var_rule_evaluator.evaluate(rt.get_property(var_suggestion,
			'is_visible'), rt.new_null(), rt.create_array([
			rt.ArrayItem{ key: 'slug', val: var_logger_slug },
			rt.ArrayItem{
				key: 'source'
				val: if !(var_logger_args.array_get(rt.new_string('source'))).is_null() {
					var_logger_args.array_get(rt.new_string('source'))
				} else {
					rt.new_string('wc-payment-gateway-suggestions')
				}
			},
		]))
		rt.set_property(var_suggestion, 'is_visible', var_is_visible.clone())
	}
	return var_suggestion.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.evaluate_specs(var_specs rt.PhpVal, var_logger_args rt.PhpVal) rt.PhpVal {
	mut var_specs_key :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.get_memo_key(var_specs.clone())
	if rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
		'memo').array_isset(var_specs_key)
	{
		return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
			'memo').array_get(var_specs_key)
	}
	mut var_suggestions := rt.new_array()
	mut var_errors := rt.new_array()
	mut iter_1 := var_specs.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_spec := item_1.val
		mut var_suggestion := Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.evaluate(var_spec.clone(),
			var_logger_args.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_suggestion.clone(), rt.new_string('is_visible')])))))
			|| rt.is_true(rt.get_property(var_suggestion, 'is_visible')) {
			var_suggestions.array_push(var_suggestion.clone())
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
		if rt.instance_of(var_e_1,
			'Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_Throwable')
		{
			mut var_e := var_e_1.clone()
			var_errors.array_push(var_e.clone())
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
	}
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'suggestions', val: var_suggestions },
		rt.ArrayItem{ key: 'errors', val: var_errors },
	])
	if rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
		'memo').array_count() > 50 {
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.reset_memo()
	}
	rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
		'memo').array_set(var_specs_key, var_result.clone())
	return var_result.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.reset_memo() {
	rt.set_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion',
		'memo', rt.new_array())
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.get_memo_key(var_specs rt.PhpVal) string {
	mut var_data := rt.call_function('wp_json_encode', [var_specs.clone()])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('hash')]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('xxh3'), rt.call_function('hash_algos', []rt.PhpVal{}), rt.new_bool(true)])) {
		return (rt.call_function('hash', [rt.new_string('xxh3'),
			var_data.clone()])).str()
	}
	return (rt.call_function('crc32', [var_data.clone()])).str()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_evaluatesuggestion(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.evaluate(dispatch_arg_0,
				dispatch_arg_1)
		}
		'evaluate_specs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.evaluate_specs(dispatch_arg_0,
				dispatch_arg_1)
		}
		'reset_memo' {
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.reset_memo()
			return rt.new_null()
		}
		'get_memo_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion.get_memo_key(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_EvaluateSuggestion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
