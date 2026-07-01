import rt

struct Class_Automattic_WooCommerce_Admin_Features_Onboarding {
	rt.PhpObjectBase
pub mut:
	facade_over_classname rt.PhpVal = rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\Onboarding')
	deprecated_in_version rt.PhpVal = rt.new_string('6.3.0')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Onboarding) construct() {
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_industries() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_allowed_industries'),
		rt.new_string('6.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\OnboardingIndustries::get_allowed_industries()')])
	return fn () rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{}
		return temp.get_allowed_industries()
	}()
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_product_types() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('get_allowed_product_types'),
		rt.new_string('6.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Admin\\OnboardingProducts::get_allowed_product_types()'),
	])
	return fn () rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts{}
		return temp.get_allowed_product_types()
	}()
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_themes() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_themes'),
		rt.new_string('6.3')])
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_theme_data(var_theme rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_theme_data'),
		rt.new_string('6.3')])
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_themes() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_allowed_themes'),
		rt.new_string('6.3')])
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_product_data(var_product_types rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_product_data'),
		rt.new_string('6.3')])
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboarding() &Class_Automattic_WooCommerce_Admin_Features_Onboarding {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Onboarding{
		PhpObjectBase:         rt.PhpObjectBase{}
		facade_over_classname: rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\Onboarding')
		deprecated_in_version: rt.new_string('6.3.0')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade() &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_automattic_woocommerce_internal_admin_onboarding_onboardingindustries() &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_automattic_woocommerce_internal_admin_onboarding_onboardingproducts() &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Onboarding) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_allowed_industries' {
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_industries()
		}
		'get_allowed_product_types' {
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_product_types()
		}
		'get_themes' {
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_themes()
		}
		'get_theme_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_theme_data(dispatch_arg_0)
		}
		'get_allowed_themes' {
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_allowed_themes()
		}
		'get_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Onboarding.get_product_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Onboarding) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'facade_over_classname' { return this.facade_over_classname }
		'deprecated_in_version' { return this.deprecated_in_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Onboarding) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'facade_over_classname' {
			this.facade_over_classname = val
			return true
		}
		'deprecated_in_version' {
			this.deprecated_in_version = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboarding_php() {
}
