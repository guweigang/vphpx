import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_base_location.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_base_location.dup().array_isset(rt.new_string('country'))))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_base_location.dup().array_isset(rt.new_string('state'))))))))) {
		return false
	}
	mut var_onboarding_profile := rt.call_function('get_option', [rt.new_string('woocommerce_onboarding_profile'), rt.new_array()])
	mut var_is_address_default := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('US'), var_base_location.array_get('country'))) && rt.is_true(rt.identical(rt.new_string('CA'), var_base_location.array_get('state'))))) && !rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_store_address'), rt.new_string('')]))))
	mut var_is_store_country_set := rt.new_bool(rt.new_bool(var_onboarding_profile.array_isset(rt.new_string('is_store_country_set')) && rt.is_true(var_onboarding_profile.array_get('is_store_country_set'))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_address_default) && rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}; return temp.needs_completion() }()))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_store_country_set)))))) {
		return false
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{}; return temp.compare(arg_0, arg_1, arg_2) }(var_base_location.array_get('country'), rt.get_property(var_rule, 'value'), rt.get_property(var_rule, 'operation'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'value')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'operation')).is_null()) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_baselocationcountryruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingprofile() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{
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

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_baselocationcountryruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
