import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
pub mut:
	get_rule_processor rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) construct(var_get_rule_processor rt.PhpVal) {
	this.get_rule_processor = if rt.is_true(rt.identical(rt.new_null(), var_get_rule_processor)) {
		create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessor()
	} else {
		var_get_rule_processor
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) evaluate(var_rules rt.PhpVal, var_stored_state rt.PhpVal, var_logger_args rt.PhpVal) bool {
	mut var_rules_mutated := var_rules
	if rt.is_true(rt.new_bool(var_rules_mutated.clone().is_bool())) {
		return var_rules_mutated.to_bool()
	}
	if !(var_rules_mutated.clone().is_array()) {
		var_rules_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_rules_mutated },
		])
	}
	if 0 == var_rules_mutated.clone().array_count() {
		return false
	}
	mut var_evaluation_logger := rt.new_null()
	if rt.is_true(rt.new_int(var_logger_args.clone().array_count())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_logger_args.clone().array_isset(rt.new_string('slug'))))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException',
				[]string{},
				create_automattic_woocommerce_admin_remotespecs_ruleprocessors_invalidargumentexception(rt.new_string('Missing required field: slug in $logger_args.'))))
		}
		mut var_source := if var_logger_args.array_isset(rt.new_string('source')) {
			var_logger_args.array_get(rt.new_string('source'))
		} else {
			rt.new_null()
		}
		var_evaluation_logger = create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluationlogger(var_logger_args.array_get(rt.new_string('slug')),
			var_source.clone())
	}
	mut iter_1 := var_rules_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_rule := item_1.val
		if !(var_rule.clone().is_object()) {
			rt.new_bool(rt.is_true(var_evaluation_logger)
				&& rt.is_true(rt.call_method(var_evaluation_logger, 'add_result', [rt.new_string('rule not an object'), rt.new_bool(false)])))
			rt.new_bool(rt.is_true(var_evaluation_logger)
				&& rt.is_true(rt.call_method(var_evaluation_logger, 'log', []rt.PhpVal{})))
			return false
		}
		mut var_processor := rt.call_method(this.get_rule_processor, 'get_processor', [
			rt.get_property(var_rule, 'type'),
		])
		mut var_processor_result := rt.call_method(var_processor, 'process', [
			var_rule.clone(), var_stored_state.clone()])
		rt.new_bool(rt.is_true(var_evaluation_logger)
			&& rt.is_true(rt.call_method(var_evaluation_logger, 'add_result', [rt.get_property(var_rule, 'type'), var_processor_result.clone()])))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_processor_result)))) {
			rt.new_bool(rt.is_true(var_evaluation_logger)
				&& rt.is_true(rt.call_method(var_evaluation_logger, 'log', []rt.PhpVal{})))
			return false
		}
	}
	rt.new_bool(rt.is_true(var_evaluation_logger)
		&& rt.is_true(rt.call_method(var_evaluation_logger, 'log', []rt.PhpVal{})))
	return true
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator{
		PhpObjectBase:      rt.PhpObjectBase{}
		get_rule_processor: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluationlogger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.evaluate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'get_rule_processor' { return this.get_rule_processor }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'get_rule_processor' {
			this.get_rule_processor = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluationLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
