import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext {
	rt.PhpObjectBase
pub mut:
	context rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) construct(mut var_context Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array) {
	this.context = var_context
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) get_processor(var_rule_type rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_rule_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('context_plugins'))) {
		return rt.new_object('Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor',
			[]string{}, create_automattic_woocommerce_admin_remotespecs_ruleprocessors_contextpluginsruleprocessor(if !(this.context.array_get(rt.new_string('plugins'))).is_null() {
			this.context.array_get(rt.new_string('plugins'))
		} else {
			rt.new_array()
		}))
	}
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{}
	mut iife_result_0 := iife_temp_0.get_processor(var_rule_type.clone())
	return iife_result_0
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessorforcontext(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext{
		PhpObjectBase: rt.PhpObjectBase{}
		context:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_contextpluginsruleprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_processor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_processor(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessorForContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'context' {
			this.context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ContextPluginsRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
