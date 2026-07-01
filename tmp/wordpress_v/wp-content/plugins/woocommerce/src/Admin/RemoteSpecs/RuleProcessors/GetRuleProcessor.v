import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor.get_processor(var_rule_type rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_rule_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugins_activated'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginsactivatedruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish_after_time'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_publishaftertimeruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish_before_time'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_publishbeforetimeruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('not'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_notruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('or'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_orruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fail'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_failruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pass'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_passruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin_version'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginversionruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stored_state'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_storedstateruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_count'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ordercountruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wcadmin_active_for'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_wcadminactiveforruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_count'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_productcountruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('onboarding_profile'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_onboardingprofileruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_ecommerce'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_isecommerceruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_woo_express'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_iswooexpressruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('base_location_country'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_baselocationcountryruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('base_location_state'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_baselocationstateruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('note_status'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_notestatusruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('option'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_optionruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wca_updated'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_woocommerceadminupdatedruleprocessor()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total_payments_value'))) {
		return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_totalpaymentsvolumeprocessor()
	}
	return create_automattic_woocommerce_admin_remotespecs_ruleprocessors_failruleprocessor()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginsactivatedruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_publishaftertimeruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_publishbeforetimeruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_notruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_orruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_failruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_passruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginversionruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_storedstateruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ordercountruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_wcadminactiveforruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_productcountruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_onboardingprofileruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_isecommerceruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_iswooexpressruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_baselocationcountryruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_baselocationstateruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_notestatusruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_optionruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_woocommerceadminupdatedruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_totalpaymentsvolumeprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_processor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor.get_processor(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishAfterTimeRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PublishBeforeTimeRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NotRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_FailRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PassRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_StoredStateRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OrderCountRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WCAdminActiveForRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_ProductCountRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OnboardingProfileRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsEcommerceRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_IsWooExpressRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationCountryRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_BaseLocationStateRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_NoteStatusRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_OptionRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_WooCommerceAdminUpdatedRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_TotalPaymentsVolumeProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_getruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
