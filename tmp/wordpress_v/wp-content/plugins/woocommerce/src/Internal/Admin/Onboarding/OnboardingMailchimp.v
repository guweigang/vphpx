import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_onboarding_profile_data_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_profile_data_updated' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) on_profile_data_updated(var_existing_data rt.PhpVal, var_updating_data rt.PhpVal)  {
	if rt.is_true(rt.new_bool(var_existing_data.array_isset(rt.new_string('store_email')) && var_updating_data.array_isset(rt.new_string('store_email')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{}; return temp.reset() }()
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingmailchimp() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'on_profile_data_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.on_profile_data_updated(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_onboarding_onboardingmailchimp_php() {
}
