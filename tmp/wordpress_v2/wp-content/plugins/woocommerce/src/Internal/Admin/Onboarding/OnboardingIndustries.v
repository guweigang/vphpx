import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.init() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_onboarding_preloaded_data'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'preload_data' }]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.get_allowed_industries() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_onboarding_industries'),
		rt.create_array([
			rt.ArrayItem{ key: 'fashion-apparel-accessories', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Fashion, apparel, and accessories'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'health-beauty', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Health and beauty'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'electronics-computers', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Electronics and computers'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'food-drink', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Food and drink'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'home-furniture-garden', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Home, furniture, and garden'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'cbd-other-hemp-derived-products', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('CBD and other hemp-derived products'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'education-and-learning', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Education and learning'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'sports-and-recreation', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Sports and recreation'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'arts-and-crafts', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Arts and crafts'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: false },
				rt.ArrayItem{ key: 'description_label', val: '' },
			]) },
			rt.ArrayItem{ key: 'other', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Other'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'use_description', val: true },
				rt.ArrayItem{ key: 'description_label', val: rt.call_function('__', [
					rt.new_string('Description'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.preload_data(var_settings rt.PhpVal) rt.PhpVal {
	var_settings.array_get_mut('onboarding').array_set('industries',
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.get_allowed_industries())
	return var_settings.clone()
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.init()
			return rt.new_null()
		}
		'get_allowed_industries' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.get_allowed_industries()
		}
		'preload_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries.preload_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
