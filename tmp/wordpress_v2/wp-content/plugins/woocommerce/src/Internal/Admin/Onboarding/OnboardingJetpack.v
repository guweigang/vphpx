import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_onboarding_onboardingjetpack() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_static',
			[]string{}, create_automattic_woocommerce_internal_admin_onboarding_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_plugins_pre_activate'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'activate_and_install_jetpack_ahead_of_wcpay' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_admin_plugins_pre_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'activate_and_install_jetpack_ahead_of_wcpay' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('jetpack_site_registered'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_woocommerce_setup_jetpack_opted_in' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) set_woocommerce_setup_jetpack_opted_in() {
	rt.call_function('update_option', [
		rt.new_string('woocommerce_setup_jetpack_opted_in'),
		rt.new_bool(true),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) activate_and_install_jetpack_ahead_of_wcpay(var_plugins rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	if rt.is_true(rt.call_function('in_array', [rt.new_string('jetpack'), var_plugins_mutated.clone(), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-payments'), var_plugins_mutated.clone(), rt.new_bool(true)])) {
		rt.call_function('array_unshift', [var_plugins_mutated.clone(),
			rt.new_string('jetpack')])
		var_plugins_mutated = rt.call_function('array_unique', [
			var_plugins_mutated.clone()])
	}
	return var_plugins_mutated.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingjetpack(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack{
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingJetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
