import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor {
	rt.PhpObjectBase
pub mut:
		date_time_provider rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) construct(var_date_time_provider rt.PhpVal)  {
	this.date_time_provider = if rt.is_true(rt.identical(rt.new_null(), var_date_time_provider)) { create_automattic_woocommerce_admin_datetimeprovider_currentdatetimeprovider() } else { var_date_time_provider }
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) rt.PhpVal {
	return rt.greater_equal(rt.call_method(this.date_time_provider, 'get_now', []rt.PhpVal{}), create_automattic_woocommerce_admin_remotespecs_ruleprocessors_datetime(rt.get_property(var_rule, 'publish_after')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'publish_after')).is_null()) {
		return false
	}
	create_automattic_woocommerce_admin_remotespecs_ruleprocessors_datetime(rt.get_property(var_rule, 'publish_after'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_Throwable') {
		mut var_e := var_e_1.dup()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return true
}

struct Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_publishaftertimeruleprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		date_time_provider: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_datetimeprovider_currentdatetimeprovider() &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_datetime() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.process(dispatch_arg_0, dispatch_arg_1)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'date_time_provider' { return this.date_time_provider }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'date_time_provider' { this.date_time_provider = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTimeProvider_CurrentDateTimeProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_publishaftertimeruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
