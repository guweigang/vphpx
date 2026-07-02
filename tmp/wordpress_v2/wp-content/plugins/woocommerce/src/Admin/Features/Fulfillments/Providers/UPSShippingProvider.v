import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider {
	rt.PhpObjectBase
pub mut:
		international_shipping_countries rt.PhpVal = rt.new_array()
		domestic_shipping_countries rt.PhpVal = rt.new_array()
		domestic_but_international_tracking rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_key() string {
	return 'ups'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_name() string {
	return 'UPS'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_icon() string {
	return (rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/images/shipping_providers/ups.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_tracking_url(tracking_number string) string {
	mut tracking_number_mutated := tracking_number
	return 'https://www.ups.com/track?tracknum=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return this.international_shipping_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return this.international_shipping_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) can_ship_from_to(shipping_from string, shipping_to string) bool {
	if rt.is_true(rt.identical(rt.new_string(shipping_from), rt.new_string(shipping_to))) {
		return rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.domestic_shipping_countries, rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.domestic_but_international_tracking, rt.new_bool(true)]))
	} else {
		return rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.international_shipping_countries, rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to), this.international_shipping_countries, rt.new_bool(true)]))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if tracking_number_mutated == '' || shipping_from == '' || shipping_to == '' || !(this.can_ship_from_to(shipping_from, shipping_to)) {
		return rt.new_null()
	}
	tracking_number_mutated = tracking_number_mutated.to_upper()
	mut var_is_domestic_shipping := rt.identical(rt.new_string(shipping_from), rt.new_string(shipping_to))
	closure_2_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_1 := iife_temp_1.validate_ups_1z_check_digit(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_1) { 100 } else { 95 })
		}
	closure_4_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_3 := iife_temp_3.validate_mod10_check_digit(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_3) { 90 } else { 80 })
		}
	closure_5_fn := fn [var_shipping_from] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }]), rt.new_bool(true)])) { 85 } else { 70 })
		}
	closure_6_fn := fn [var_shipping_from] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.domestic_but_international_tracking, rt.new_bool(true)])) { 80 } else { 65 })
		}
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: '/^1Z[0-9A-Z]{16}$/', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: '/^\\d{12}$/', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: '/^\\d{10}$/', val: 75 }, rt.ArrayItem{ key: '/^\\d{9}$/', val: 70 }, rt.ArrayItem{ key: '/^[THV]\\d{10}$/', val: 85 }, rt.ArrayItem{ key: '/^J\\d{10}$/', val: 80 }, rt.ArrayItem{ key: '/^MI\\d{6}[A-Z0-9]{6,22}$/', val: 80 }, rt.ArrayItem{ key: '/^9\\d{21,33}$/', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: '/^\\d{22}$/', val: 60 }])
	mut var_match := rt.new_bool(false)
	mut var_ambiguity_score := rt.new_int(0)
	mut iter_1 := var_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_score := item_1.val
		mut var_pattern := item_1.key
		if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(), rt.new_string(tracking_number_mutated).clone()])) {
			var_match = rt.new_bool(true)
			var_ambiguity_score = if rt.call_function('is_callable', [var_score.clone()]) { rt.call_callable(var_score, []rt.PhpVal{}) } else { var_score }
			break
		}
	}
	if rt.is_true(var_match) && rt.is_true(var_is_domestic_shipping) && rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.domestic_but_international_tracking, rt.new_bool(true)])) {
		var_ambiguity_score = rt.add(var_ambiguity_score, rt.new_int(5))
	}
	return if rt.is_true(var_match) { rt.create_array([rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) }, rt.ArrayItem{ key: 'ambiguity_score', val: var_ambiguity_score }]) } else { rt.new_null() }
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_upsshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		international_shipping_countries: rt.new_array()
		domestic_shipping_countries: rt.new_array()
		domestic_but_international_tracking: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_key' {
			return rt.new_string(this.get_key())
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_icon' {
			return rt.new_string(this.get_icon())
		}
		'get_tracking_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_tracking_url(dispatch_arg_0))
		}
		'get_shipping_from_countries' {
			return this.get_shipping_from_countries()
		}
		'get_shipping_to_countries' {
			return this.get_shipping_to_countries()
		}
		'can_ship_from_to' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.can_ship_from_to(dispatch_arg_0, dispatch_arg_1))
		}
		'try_parse_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.try_parse_tracking_number(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'international_shipping_countries' { return this.international_shipping_countries }
		'domestic_shipping_countries' { return this.domestic_shipping_countries }
		'domestic_but_international_tracking' { return this.domestic_but_international_tracking }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_UPSShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'international_shipping_countries' { this.international_shipping_countries = val; return true }
		'domestic_shipping_countries' { this.domestic_shipping_countries = val; return true }
		'domestic_but_international_tracking' { this.domestic_but_international_tracking = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
