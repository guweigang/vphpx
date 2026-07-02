import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_calypso_bridge_is_woo_express_plan'),
	])))))
	{
		return (rt.identical(rt.new_bool(false), rt.get_property(var_rule, 'value'))).to_bool()
	}
	if !(!(rt.get_property(var_rule, 'plan')).is_null()) {
		return (rt.identical(rt.call_function('wc_calypso_bridge_is_woo_express_plan',
			[]rt.PhpVal{}), rt.get_property(var_rule, 'value'))).to_bool()
	}
	if rt.is_true(rt.call_function('wc_calypso_bridge_is_woo_express_plan', []rt.PhpVal{})) {
		mut var_fn := rt.new_string('wc_calypso_bridge_is_woo_express_' +
			(rt.get_property(var_rule, 'plan')).str() + '_plan')
		if rt.is_true(rt.call_function('function_exists', [var_fn.clone()])) {
			return (rt.identical(rt.call_callable(var_fn, []rt.PhpVal{}), rt.get_property(var_rule,
				'value'))).to_bool()
		}
		return (rt.identical(rt.new_bool(false), rt.get_property(var_rule, 'value'))).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'value')).is_null()) {
		return false
	}
	if !(rt.get_property(var_rule, 'plan')).is_null() {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_calypso_bridge_is_woo_express_plan'),
		])))))
		{
			return false
		}
	}
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_iswooexpressruleprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process(dispatch_arg_0, dispatch_arg_1))
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
