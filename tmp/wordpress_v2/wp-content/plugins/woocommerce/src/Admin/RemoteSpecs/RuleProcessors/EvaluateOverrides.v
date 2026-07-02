import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) evaluate(mut var_spec Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array, mut var_context Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array) rt.PhpVal {
	mut var_rule_evaluator := create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator(create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessorforcontext(var_context))
	mut iter_1 := var_spec.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_spec_item := item_1.val
		if !(rt.get_property(var_spec_item, 'overrides')).is_null() && rt.get_property(var_spec_item, 'overrides').is_array() {
			mut iter_2 := rt.get_property(var_spec_item, 'overrides').iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_override := item_2.val
				if !(!(rt.get_property(var_override, 'rules')).is_null()) || !(rt.get_property(var_override, 'rules').is_array()) || !(!(rt.get_property(var_override, 'field')).is_null()) || !(!(rt.get_property(var_override, 'value')).is_null()) {
					continue
				}
				if rt.is_true(var_rule_evaluator.evaluate(rt.get_property(var_override, 'rules'))) {
					if !(rt.get_property(var_spec_item, '{"nodeType":"Expr_PropertyFetch","line":31,"var":{"nodeType":"Expr_Variable","line":31,"name":"override"},"name":"field"}')).is_null() {
						rt.set_property(var_spec_item, '{"nodeType":"Expr_PropertyFetch","line":32,"var":{"nodeType":"Expr_Variable","line":32,"name":"override"},"name":"field"}', rt.get_property(var_override, 'value'))
					} else {
						this.set_value_with_dot_notation(var_spec_item.clone(), rt.get_property(var_override, 'field'), rt.get_property(var_override, 'value'))
					}
				}
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array', []string{}, var_spec)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) set_value_with_dot_notation(var_data rt.PhpVal, var_path rt.PhpVal, var_new_value rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_keys := rt.call_function('explode', [rt.new_string('.'), var_path.clone()])
	mut var_last_key := rt.call_function('array_pop', [var_keys.clone()])
	mut iter_3 := var_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		if rt.is_true(rt.new_bool(var_key.clone().is_long() || var_key.clone().is_double())) {
			var_key = rt.new_int((var_key).to_i64())
			if !(var_data_mutated.array_isset(var_key)) || !(var_data_mutated.array_get(var_key).is_object()) {
				var_data_mutated.array_set(var_key, create_automattic_woocommerce_admin_remotespecs_ruleprocessors_stdclass())
			}
			var_data_mutated = var_data_mutated.array_get(var_key)
		} else {
			if !(!(rt.get_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":68,"name":"key"}')).is_null()) || (!(rt.get_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":68,"name":"key"}').is_array()) && !(rt.get_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":68,"name":"key"}').is_object())) {
				rt.set_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":69,"name":"key"}', create_automattic_woocommerce_admin_remotespecs_ruleprocessors_stdclass())
			}
			var_data_mutated = rt.get_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":71,"name":"key"}')
		}
	}
	if rt.is_true(rt.new_bool(var_last_key.clone().is_long() || var_last_key.clone().is_double())) {
		var_data_mutated.array_set(rt.new_int((var_last_key).to_i64()), var_new_value.clone())
	} else {
		rt.set_property(var_data_mutated, '{"nodeType":"Expr_Variable","line":79,"name":"last_key"}', var_new_value.clone())
	}
	return var_data_mutated.clone()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluateoverrides(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides{
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

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessorforcontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.evaluate(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'set_value_with_dot_notation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.set_value_with_dot_notation(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
