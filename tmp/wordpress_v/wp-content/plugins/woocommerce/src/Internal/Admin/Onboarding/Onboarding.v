import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding.init() {
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{}
		return temp.instance()
	}(), 'init', []rt.PhpVal{})
	fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{}
		return temp.init()
	}()
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{}
		return temp.instance()
	}(), 'init', []rt.PhpVal{})
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{}
		return temp.instance()
	}(), 'init', []rt.PhpVal{})
	fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{}
		return temp.init()
	}()
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard{}
		return temp.instance()
	}(), 'init', []rt.PhpVal{})
	rt.call_method(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync{}
		return temp.instance()
	}(), 'init', []rt.PhpVal{})
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

fn create_automattic_woocommerce_internal_admin_onboarding_onboarding() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Onboarding{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardinghelper() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingjetpack() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingmailchimp() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingMailchimp{
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

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsetupwizard() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSetupWizard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingsync() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingSync {
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

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_onboarding_onboarding_php() {
}
