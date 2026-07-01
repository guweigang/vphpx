import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) rt.PhpVal {
	mut var_is_contains := rt.new_bool(rt.new_bool(rt.is_true(rt.get_property(var_rule, 'operation')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_value_when_default_not_provided := if rt.is_true(var_is_contains) { rt.new_array() } else { rt.new_bool(false) }
	mut var_is_default_set := rt.call_function('property_exists', [var_rule.dup(), rt.new_string('default')])
	mut var_default_value := if rt.is_true(var_is_default_set) { rt.get_property(var_rule, 'default') } else { var_value_when_default_not_provided }
	mut var_option_value := this.get_option_value(var_rule.dup(), var_default_value.dup(), var_is_contains.dup())
	if rt.is_true(rt.new_bool(!(rt.get_property(var_rule, 'transformers')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_rule, 'transformers').is_array())))) {
		var_option_value = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService{}; return temp.apply(arg_0, arg_1, arg_2, arg_3) }(var_option_value.dup(), rt.get_property(var_rule, 'transformers'), var_is_default_set.dup(), var_default_value.dup())
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{}; return temp.compare(arg_0, arg_1, arg_2) }(var_option_value.dup(), rt.get_property(var_rule, 'value'), rt.get_property(var_rule, 'operation'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) get_option_value(var_rule rt.PhpVal, var_default_value rt.PhpVal, var_is_contains rt.PhpVal) rt.PhpVal {
	mut var_default_value_mutated := var_default_value
	mut var_is_contains_mutated := var_is_contains
	mut var_option_value := rt.call_function('get_option', [rt.get_property(var_rule, 'option_name'), var_default_value_mutated.dup()])
	mut var_is_contains_valid := rt.new_bool(rt.new_bool(rt.is_true(var_is_contains_mutated) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_option_value.dup().is_array())) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_option_value.dup().is_string())) && rt.is_true(rt.new_bool(rt.get_property(var_rule, 'value').is_string()))))))))
	if rt.is_true(rt.new_bool(rt.is_true(var_is_contains_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_contains_valid)))))) {
		mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'warning', [rt.call_function('sprintf', [rt.new_string('ComparisonOperation "%s" option value "%s" is not an array, defaulting to empty array.'), rt.get_property(var_rule, 'operation'), rt.get_property(var_rule, 'option_name')]), rt.create_array([rt.ArrayItem{ key: 'option_value', val: var_option_value }, rt.ArrayItem{ key: 'rule', val: var_rule }])])
		var_option_value = rt.new_array()
	}
	return var_option_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'option_name')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'value')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'operation')).is_null()) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_rule, 'transformers')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_rule, 'transformers').is_array())))) {
		{
			mut iter_1 := rt.get_property(var_rule, 'transformers').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_transform_args := item_1.val
				mut var_transformer := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService{}; return temp.create_transformer(arg_0) }(rt.get_property(var_transform_args, 'use'))
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_transformer, 'validate', [rt.get_property(var_transform_args, 'arguments')]))))) {
					return false
				}
			}
		}
	}
	return true
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_optionruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_transformers_transformerservice() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_comparisonoperation() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process(dispatch_arg_0, dispatch_arg_1)
		}
		'get_option_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_option_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Transformers_TransformerService) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_optionruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
