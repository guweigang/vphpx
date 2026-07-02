import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider {
	rt.PhpObjectBase
pub mut:
	operating_countries rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_key() string {
	return 'amazon-logistics'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_name() string {
	return 'Amazon Logistics'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_icon() string {
	return
		(rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
		'/assets/images/shipping_providers/amazon-logistics.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return this.operating_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return this.operating_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) can_ship_from_to(shipping_from string, shipping_to string) bool {
	return
		rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.operating_countries, rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to), this.operating_countries, rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) get_tracking_url(tracking_number string) string {
	mut tracking_number_mutated := tracking_number
	return 'https://www.amazon.com/progress-tracker/package/ref=ppx_yo_dt_b_track_package_o0?_=' +
		rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).clone()]).to_string().to_upper()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if tracking_number_mutated == '' || !(this.can_ship_from_to(shipping_from, shipping_to)) {
		return rt.new_null()
	}
	tracking_number_mutated = rt.call_function('preg_replace', [
		rt.new_string('/\\s+/'), rt.new_string(''), rt.new_string(tracking_number_mutated).clone()]).to_string().to_upper()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) {
			100
		} else {
			95
		}
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('CA'), rt.new_string(shipping_from))) {
			100
		} else {
			90
		}
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('MX'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'BE' }, rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'DE' }]),
			rt.new_bool(true)]))
		{ 95 } else { 80 }
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
			99
		} else {
			85
		}
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('GB'), rt.new_string(shipping_from))) {
			92
		} else {
			75
		}
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'ES' }]),
			rt.new_bool(true)]))
		{ 95 } else { 80 }
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('DE'), rt.new_string(shipping_from))) {
			95
		} else {
			75
		}
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'CN' },
				rt.ArrayItem{ key: none, val: 'HK' }]),
			rt.new_bool(true)]))
		{ 95 } else { 75 }
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('AU'), rt.new_string(shipping_from))) {
			100
		} else {
			80
		}
	}
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('IN'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('JP'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('SG'), rt.new_string(shipping_from))) {
			100
		} else {
			85
		}
	}
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) {
			98
		} else {
			80
		}
	}
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) {
			98
		} else {
			80
		}
	}
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'FR' }]),
			rt.new_bool(true)]))
		{ 95 } else { 80 }
	}
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'MX' }]),
			rt.new_bool(true)]))
		{ 90 } else { 70 }
	}
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from),
			rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'DE' }]),
			rt.new_bool(true)]))
		{ 88 } else { 75 }
	}
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) {
			90
		} else {
			75
		}
	}
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return if rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) {
			90
		} else {
			75
		}
	}
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(60)
	}
	mut var_patterns := rt.create_array([
		rt.ArrayItem{ key: '/^TBA\\d{12}$/', val: rt.new_closure(closure_1_fn) },
		rt.ArrayItem{ key: '/^TBC\\d{12}$/', val: rt.new_closure(closure_2_fn) },
		rt.ArrayItem{ key: '/^TBM\\d{12}$/', val: rt.new_closure(closure_3_fn) },
		rt.ArrayItem{ key: '/^CC\\d{12}$/', val: rt.new_closure(closure_4_fn) },
		rt.ArrayItem{ key: '/^GBA\\d{12}$/', val: rt.new_closure(closure_5_fn) },
		rt.ArrayItem{ key: '/^UK\\d{10}$/', val: rt.new_closure(closure_6_fn) },
		rt.ArrayItem{ key: '/^W[A-Z]\\d{9}GB$/', val: rt.new_closure(closure_7_fn) },
		rt.ArrayItem{ key: '/^[A-Z]{2}\\d{9}GB$/', val: rt.new_closure(closure_8_fn) },
		rt.ArrayItem{ key: '/^AM\\d{12}$/', val: rt.new_closure(closure_9_fn) },
		rt.ArrayItem{ key: '/^D\\d{13}$/', val: rt.new_closure(closure_10_fn) },
		rt.ArrayItem{ key: '/^RB\\d{12}$/', val: rt.new_closure(closure_11_fn) },
		rt.ArrayItem{ key: '/^ZZ\\d{12}$/', val: rt.new_closure(closure_12_fn) },
		rt.ArrayItem{ key: '/^ZX\\d{12}$/', val: rt.new_closure(closure_13_fn) },
		rt.ArrayItem{ key: '/^JP\\d{12}$/', val: rt.new_closure(closure_14_fn) },
		rt.ArrayItem{ key: '/^SG\\d{12}$/', val: rt.new_closure(closure_15_fn) },
		rt.ArrayItem{ key: '/^AF\\d{12}$/', val: rt.new_closure(closure_16_fn) },
		rt.ArrayItem{ key: '/^WF\\d{12}$/', val: rt.new_closure(closure_17_fn) },
		rt.ArrayItem{ key: '/^AB\\d{12}$/', val: rt.new_closure(closure_18_fn) },
		rt.ArrayItem{ key: '/^TB[A-Z]\\d{11}$/', val: rt.new_closure(closure_19_fn) },
		rt.ArrayItem{ key: '/^AZ\\d{12}$/', val: rt.new_closure(closure_20_fn) },
		rt.ArrayItem{ key: '/^AP\\d{12}$/', val: rt.new_closure(closure_21_fn) },
		rt.ArrayItem{ key: '/^SS\\d{12}$/', val: rt.new_closure(closure_22_fn) },
		rt.ArrayItem{ key: '/^[A-Z0-9]{15,20}$/', val: rt.new_closure(closure_23_fn) },
	])
	mut iter_1 := var_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_score_callback := item_1.val
		mut var_pattern := item_1.key
		if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(),
			rt.new_string(tracking_number_mutated).clone()]))
		{
			return rt.create_array([
				rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) },
				rt.ArrayItem{ key: 'ambiguity_score', val: rt.call_callable(var_score_callback,
					[]rt.PhpVal{}) },
			])
		}
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_amazonlogisticsshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider{
		PhpObjectBase:       rt.PhpObjectBase{}
		operating_countries: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_tracking_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_tracking_url(dispatch_arg_0))
		}
		'try_parse_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.try_parse_tracking_number(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'operating_countries' { return this.operating_countries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AmazonLogisticsShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'operating_countries' {
			this.operating_countries = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
