import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus.evaluate(var_spec rt.PhpVal, var_current_status rt.PhpVal, var_stored_state rt.PhpVal, var_rule_evaluator rt.PhpVal) rt.PhpVal {
	if !(!(rt.get_property(var_spec, 'rules')).is_null()) {
		return var_current_status.dup()
	}
	mut var_evaluated_result := rt.call_method(var_rule_evaluator, 'evaluate', [rt.get_property(var_spec, 'rules'), var_stored_state.dup(), rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.get_property(var_spec, 'slug') }, rt.ArrayItem{ key: 'source', val: 'remote-inbox-notifications' }])])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending(), var_current_status)) {
		return if rt.is_true(var_evaluated_result) { rt.get_property(var_spec, 'status') } else { Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending() }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.get_property(var_spec, 'type')).is_null() && rt.is_true(rt.call_function('in_array', [rt.get_property(var_spec, 'type'), rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'update' }]), rt.new_bool(true)])))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned(), var_current_status)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_evaluated_result)))))) {
		return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending()
	}
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_spec, 'allow_redisplay')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_spec, 'allow_redisplay'))))))) {
		return var_current_status.dup()
	}
	return if rt.is_true(var_evaluated_result) { Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() } else { var_current_status }
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluateandgetstatus() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus.evaluate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateAndGetStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_evaluateandgetstatus_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
