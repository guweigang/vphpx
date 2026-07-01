import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor {
	rt.PhpObjectBase
pub mut:
		rule_evaluator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) construct(var_rule_evaluator rt.PhpVal)  {
	this.rule_evaluator = if rt.is_true(rt.identical(rt.new_null(), var_rule_evaluator)) { create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator() } else { var_rule_evaluator }
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	{
		mut iter_1 := rt.get_property(var_rule, 'operands').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_operand := item_1.val
			mut var_evaluated_operand := rt.call_method(this.rule_evaluator, 'evaluate', [var_operand.dup(), var_stored_state.dup()])
			if rt.is_true(var_evaluated_operand) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_rule, 'operands')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_rule, 'operands').is_array()))))))) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_orruleprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		rule_evaluator: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process(dispatch_arg_0, dispatch_arg_1))
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rule_evaluator' { return this.rule_evaluator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rule_evaluator' { this.rule_evaluator = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_orruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
