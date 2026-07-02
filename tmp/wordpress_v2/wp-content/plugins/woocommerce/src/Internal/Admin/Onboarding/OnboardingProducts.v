import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.product_data_transient() string {
	return 'wc_onboarding_product_data'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_allowed_product_types() rt.PhpVal {
	mut var_products := rt.create_array([
		rt.ArrayItem{ key: 'physical', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Physical products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: true },
		]) },
		rt.ArrayItem{ key: 'downloads', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Downloads'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'subscriptions', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Subscriptions'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'memberships', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Memberships'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product', val: 958589 },
		]) },
		rt.ArrayItem{ key: 'bookings', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Bookings'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product', val: 390890 },
		]) },
		rt.ArrayItem{ key: 'product-bundles', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Bundles'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product', val: 18716 },
		]) },
		rt.ArrayItem{ key: 'product-add-ons', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Customizable products'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'product', val: 18618 },
		]) },
	])
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	mut var_has_cbd_industry := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('US'),
		var_base_location.array_get(rt.new_string('country'))))
	{
		mut var_profile := rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
			rt.new_array(),
		])
		if !(!rt.is_true(var_profile.array_get(rt.new_string('industry')))) {
			var_has_cbd_industry = rt.call_function('in_array', [
				rt.new_string('cbd-other-hemp-derived-products'),
				rt.call_function('array_column', [
					var_profile.array_get(rt.new_string('industry')),
					rt.new_string('slug'),
				]),
				rt.new_bool(true),
			])
		}
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('subscriptions'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('US'), var_base_location.array_get(rt.new_string('country'))))))
		|| rt.is_true(var_has_cbd_industry) {
		var_products.array_get_mut('subscriptions').array_set('product', 27147)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_onboarding_product_types'),
		var_products.clone(),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_data(var_product_types rt.PhpVal) rt.PhpVal {
	mut var_product_types_mutated := var_product_types
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_transient_value := rt.call_function('get_transient', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.product_data_transient(),
	])
	var_transient_value = if var_transient_value.clone().is_array() {
		var_transient_value
	} else {
		rt.new_array()
	}
	mut var_woocommerce_products := if !(var_transient_value.array_get(var_locale)).is_null() {
		var_transient_value.array_get(var_locale)
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_woocommerce_products)) {
		var_woocommerce_products = rt.call_function('wp_remote_get', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'locale', val: var_locale }]),
				rt.new_string('https://woocommerce.com/wp-json/wccom-extensions/1.0/search'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
					(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() +
					'; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
			]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_woocommerce_products.clone()])) {
			return var_product_types_mutated.clone()
		}
		var_transient_value.array_set(var_locale, var_woocommerce_products.clone())
		rt.call_function('set_transient', [
			Class_Automattic_WooCommerce_Internal_Admin_Onboarding_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.product_data_transient(),
			var_transient_value.clone(),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	mut var_data := rt.call_function('json_decode',
		[var_woocommerce_products.array_get(rt.new_string('body'))])
	mut var_products := rt.new_array()
	mut var_product_data := rt.new_array()
	if !var_data.is_null() && !(rt.get_property(var_data, 'products')).is_null() {
		mut iter_1 := rt.get_property(var_data, 'products').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_datum := item_1.val
			if !(rt.get_property(var_product_datum, 'id')).is_null() {
				var_products.array_set(rt.get_property(var_product_datum, 'id'),
					var_product_datum.clone())
			}
		}
	}
	mut iter_2 := var_product_types_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_type := item_2.val
		mut var_key := item_2.key
		var_product_data.array_set(var_key, var_product_types_mutated.array_get(var_key))
		if var_product_type.array_isset(rt.new_string('product'))
			&& var_products.array_isset(var_product_type.array_get(rt.new_string('product'))) {
			mut var_price := rt.call_function('html_entity_decode', [
				rt.get_property(var_products.array_get(var_product_type.array_get(rt.new_string('product'))),
					'price'),
			])
			mut var_yearly_price := rt.new_float((rt.call_function('str_replace', [
				rt.new_string('$'),
				rt.new_string(''),
				var_price.clone(),
			])).to_f64())
			var_product_data.array_get_mut(var_key).array_set('yearly_price',
				var_yearly_price.clone())
			var_product_data.array_get_mut(var_key).array_set('description', rt.get_property(var_products.array_get(var_product_type.array_get(rt.new_string('product'))),
				'excerpt'))
			var_product_data.array_get_mut(var_key).array_set('more_url', rt.get_property(var_products.array_get(var_product_type.array_get(rt.new_string('product'))),
				'link'))
			var_product_data.array_get_mut(var_key).array_set('slug', rt.call_function('preg_replace', [
				rt.new_string('~[^\\pL\\d]+~u'),
				rt.new_string('-'),
				rt.get_property(var_products.array_get(var_product_type.array_get(rt.new_string('product'))),
					'slug'),
			]).to_string().to_lower())
		}
	}
	return var_product_data.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_types_with_data() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_data(Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_allowed_product_types())
}

fn Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_relevant_products() rt.PhpVal {
	mut var_profiler_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_1 := iife_temp_1.get_installed_plugin_slugs()
	mut var_installed := iife_result_1
	mut var_product_types := if var_profiler_data.array_isset(rt.new_string('product_types')) {
		var_profiler_data.array_get(rt.new_string('product_types'))
	} else {
		rt.new_array()
	}
	mut var_product_data :=
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_types_with_data()
	mut var_purchaseable := rt.new_array()
	mut var_remaining := rt.new_array()
	mut iter_3 := var_product_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_type := item_3.val
		if !(var_product_data.array_get(var_type).array_isset(rt.new_string('slug'))) {
			continue
		}
		var_purchaseable.array_push(var_product_data.array_get(var_type))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_product_data.array_get(var_type).array_get(rt.new_string('slug')),
			var_installed.clone(),
			rt.new_bool(true),
		])))))
		{
			var_remaining.array_push(var_product_data.array_get(var_type).array_get(rt.new_string('label')))
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'purchaseable', val: var_purchaseable },
		rt.ArrayItem{ key: 'remaining', val: var_remaining }])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_allowed_product_types' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_allowed_product_types()
		}
		'get_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_data(dispatch_arg_0)
		}
		'get_product_types_with_data' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_product_types_with_data()
		}
		'get_relevant_products' {
			return Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts.get_relevant_products()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
