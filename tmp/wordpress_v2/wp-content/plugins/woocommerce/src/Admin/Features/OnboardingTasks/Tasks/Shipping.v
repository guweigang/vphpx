import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.zone_count_transient_name() string {
	return 'woocommerce_shipping_task_zone_count_transient'
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) construct(var_task_list rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.clone())
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_shipping_zones_save_changes'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_zone_count_transient' }]),
		rt.new_int(9),
	])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_shipping_zone_methods_save_changes'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_zone_count_transient' }]),
		rt.new_int(9),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_shipping_zone_method_added'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_zone_count_transient' }]),
		rt.new_int(9),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_after_shipping_zone_object_save'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_zone_count_transient' }]),
		rt.new_int(9),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) get_id() string {
	return 'shipping'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Select your shipping options'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) get_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string("Set your store location and where you'll ship to."),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('1 minute'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) is_complete() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_shipping_zones()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) can_view() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('shipping-smart-defaults'))
	if rt.is_true(iife_result_0) {
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_admin_created_default_shipping_zones'),
		])))
		{
			return false
		}
		if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.is_selling_digital_type_only()) {
			return false
		}
		mut var_default_store_country := rt.call_function('wc_format_country_state_string', [
			rt.call_function('get_option', [rt.new_string('woocommerce_default_country'),
				rt.new_string('')]),
		]).array_get(rt.new_string('country'))
		mut var_store_country := rt.new_string('')
		if !(!rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_store_address'), rt.new_string('')])))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('US'), var_default_store_country)))) {
			var_store_country = var_default_store_country.clone()
		}
		if !rt.is_true(var_store_country) {
			return true
		}
		return (rt.call_function('in_array', [var_store_country.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'NZ' }, rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'HK' }, rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'MX' }, rt.ArrayItem{ key: none, val: 'CO' },
				rt.ArrayItem{ key: none, val: 'CL' }, rt.ArrayItem{ key: none, val: 'AR' },
				rt.ArrayItem{ key: none, val: 'PE' }, rt.ArrayItem{ key: none, val: 'BR' },
				rt.ArrayItem{ key: none, val: 'UY' }, rt.ArrayItem{ key: none, val: 'GT' },
				rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' }, rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'PT' }]),
			rt.new_bool(true)])).to_bool()
	}
	return (Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_physical_products()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) get_action_url() rt.PhpVal {
	return if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_shipping_zones()) { rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=shipping'),
		]) } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_shipping_zones() bool {
	mut var_zone_count := rt.call_function('get_transient', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.zone_count_transient_name(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_zone_count)))) {
		return rt.new_bool(rt.new_int(var_zone_count.to_i64()) > 0)
	}
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('shipping-zone'))
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('shipping-zone'))
	var_zone_count =
		rt.new_int(rt.call_method(iife_result_1, 'get_zones', []rt.PhpVal{}).array_count())
	rt.call_function('set_transient', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.zone_count_transient_name(),
		var_zone_count.clone(),
	])
	return (rt.greater(var_zone_count, rt.new_int(0))).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_physical_products() rt.PhpVal {
	mut var_profiler_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	])
	mut var_product_types := if var_profiler_data.array_isset(rt.new_string('product_types')) {
		var_profiler_data.array_get(rt.new_string('product_types'))
	} else {
		rt.new_array()
	}
	return rt.call_function('in_array', [rt.new_string('physical'),
		var_product_types.clone(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.delete_zone_count_transient() {
	rt.call_function('delete_transient', [
		Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.zone_count_transient_name(),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.is_selling_digital_type_only() rt.PhpVal {
	mut var_profiler_data := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(),
		rt.new_array(),
	])
	mut var_product_types := if var_profiler_data.array_isset(rt.new_string('product_types')) {
		var_profiler_data.array_get(rt.new_string('product_types'))
	} else {
		rt.new_array()
	}
	return rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'downloads' }]),
		var_product_types)
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_shipping(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return this.get_content()
		}
		'get_time' {
			return this.get_time()
		}
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return rt.new_bool(this.can_view())
		}
		'get_action_url' {
			return this.get_action_url()
		}
		'has_shipping_zones' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_shipping_zones())
		}
		'has_physical_products' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.has_physical_products()
		}
		'delete_zone_count_transient' {
			Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.delete_zone_count_transient()
			return rt.new_null()
		}
		'is_selling_digital_type_only' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping.is_selling_digital_type_only()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
