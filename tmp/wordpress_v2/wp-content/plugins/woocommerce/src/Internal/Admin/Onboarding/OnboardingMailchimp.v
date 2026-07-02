import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_onboarding_onboardingmailchimp() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_static',
			[]string{}, create_automattic_woocommerce_internal_admin_onboarding_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_onboarding_profile_data_updated'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_profile_data_updated' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) on_profile_data_updated(var_existing_data rt.PhpVal, var_updating_data rt.PhpVal) {
	if var_existing_data.array_isset(rt.new_string('store_email'))
		&& var_updating_data.array_isset(rt.new_string('store_email'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_existing_data.array_get(rt.new_string('store_email')), var_updating_data.array_get(rt.new_string('store_email')))))) {
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler{}
		mut iife_result_0 := iife_temp_0.reset()
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingmailchimp(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_mailchimpscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_MailchimpScheduler {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
