import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_plugins_pre_activate'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'activate_and_install_jetpack_ahead_of_wcpay' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_plugins_pre_install'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'activate_and_install_jetpack_ahead_of_wcpay' }])])
	rt.call_function('add_action', [rt.new_string('jetpack_site_registered'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_woocommerce_setup_jetpack_opted_in' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) set_woocommerce_setup_jetpack_opted_in()  {
	rt.call_function('update_option', [rt.new_string('woocommerce_setup_jetpack_opted_in'), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) activate_and_install_jetpack_ahead_of_wcpay(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('jetpack'), var_plugins_mutated.dup(), rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_plugins_mutated.dup(), rt.new_bool(true)])))) {
		rt.call_function('array_unshift', [var_plugins_mutated.dup(), rt.new_string('jetpack')])
		var_plugins_mutated = rt.call_function('array_unique', [var_plugins_mutated.dup()])
	}
	return var_plugins_mutated.dup()
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingjetpack() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'set_woocommerce_setup_jetpack_opted_in' {
			this.set_woocommerce_setup_jetpack_opted_in()
			return rt.new_null()
		}
		'activate_and_install_jetpack_ahead_of_wcpay' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.activate_and_install_jetpack_ahead_of_wcpay(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_onboarding_onboardingjetpack_php() {
}
