import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	mut var_status := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note_status(arg_0) }(rt.get_property(var_rule, 'note_name'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status)))) {
		return false
	}
	return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation{}; return temp.compare(arg_0, arg_1, arg_2) }(var_status.dup(), rt.get_property(var_rule, 'status'), rt.get_property(var_rule, 'operation'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'note_name')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'status')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'operation')).is_null()) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ComparisonOperation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_notestatusruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
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

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_notestatusruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
