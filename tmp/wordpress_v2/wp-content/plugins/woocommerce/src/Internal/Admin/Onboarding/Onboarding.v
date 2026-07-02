import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding.init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{}
	mut iife_result_0 := iife_temp_0.instance()
	rt.call_method(iife_result_0, 'init', []rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{}
	mut iife_result_1 := iife_temp_1.init()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{}
	mut iife_result_2 := iife_temp_2.instance()
	rt.call_method(iife_result_2, 'init', []rt.PhpVal{})
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{}
	mut iife_result_3 := iife_temp_3.instance()
	rt.call_method(iife_result_3, 'init', []rt.PhpVal{})
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}
	mut iife_result_4 := iife_temp_4.init()
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard{}
	mut iife_result_5 := iife_temp_5.instance()
	rt.call_method(iife_result_5, 'init', []rt.PhpVal{})
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync{}
	mut iife_result_6 := iife_temp_6.instance()
	rt.call_method(iife_result_6, 'init', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboarding(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardinghelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingjetpack(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingmailchimp(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingprofile(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsetupwizard(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsync(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding.init()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
