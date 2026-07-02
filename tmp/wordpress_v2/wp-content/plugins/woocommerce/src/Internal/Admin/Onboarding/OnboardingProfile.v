import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option() string {
	return 'woocommerce_onboarding_profile'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.progress_option() string {
	return 'woocommerce_onboarding_profile_progress'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.init() {
	rt.call_function('add_action', [
		rt.new_string('update_option_' +(Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option()).str()),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'trigger_complete' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.trigger_complete(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if var_old_value.array_isset(rt.new_string('completed'))
		&& rt.is_true(var_old_value.array_get(rt.new_string('completed'))) {
		return
	}
	if !(var_value.array_isset(rt.new_string('completed')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_value.array_get(rt.new_string('completed')))))) {
		return
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_onboarding_profile_completed'),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.needs_completion() bool {
	mut var_onboarding_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	])
	mut var_is_completed := rt.new_bool(var_onboarding_data.array_isset(rt.new_string('completed'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_onboarding_data.array_get(rt.new_string('completed')))))
	mut var_is_skipped := rt.new_bool(var_onboarding_data.array_isset(rt.new_string('skipped'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_onboarding_data.array_get(rt.new_string('skipped')))))
	return rt.is_true(rt.new_bool(!(rt.is_true(var_is_completed))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_skipped))))
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingprofile(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.init()
			return rt.new_null()
		}
		'trigger_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.trigger_complete(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'needs_completion' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.needs_completion())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
