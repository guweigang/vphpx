import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider {
	rt.PhpObjectBase
pub mut:
		major_operation_countries rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_key() string {
	return 'dhl'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_name() string {
	return 'DHL'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_icon() string {
	return (rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/images/shipping_providers/dhl.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_tracking_url(tracking_number string) string {
	mut tracking_number_mutated := tracking_number
	tracking_number_mutated = tracking_number_mutated.to_upper()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(GM|LX|RX|CN|SG|MY|HK|AU|TH|420)/'), rt.new_string(tracking_number_mutated).dup()])) {
		return 'https://webtrack.dhlglobalmail.com/?trackingnumber=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).dup()])).str()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^3S[A-Z0-9]{8,12}$/'), rt.new_string(tracking_number_mutated).dup()])) {
		return 'https://www.dhl.de/en/privatkunden/dhl-sendungsverfolgung.html?piececode=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).dup()])).str()
	}
	return 'https://www.dhl.com/en/express/tracking.html?AWB=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return this.major_operation_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) can_ship_from_to(shipping_from string, shipping_to string) bool {
	return rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.get_shipping_from_countries(), rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to), this.get_shipping_to_countries(), rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if tracking_number_mutated == '' || !(this.can_ship_from_to(shipping_from, shipping_to)) {
		return rt.new_null()
	}
	tracking_number_mutated = rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(''), rt.new_string(tracking_number_mutated).dup()]).to_string().to_upper()
	mut var_is_major_country := rt.call_function('in_array', [rt.new_string(shipping_from), this.major_operation_countries, rt.new_bool(true)])
	closure_6_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_shipping_from] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_shipping_from, var_shipping_to] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_shipping_from, var_shipping_to] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.new_int(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.validate_mod11_check_digit(arg_0) }(rt.new_string(tracking_number_mutated))) { 98 } else { 90 })
	}
	return rt.new_int(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.validate_mod11_check_digit(arg_0) }(rt.new_string(tracking_number_mutated))) { 98 } else { 90 })
	}
	return rt.new_int(if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('DE'), rt.new_string(shipping_from))) && rt.is_true(rt.identical(rt.new_string('DE'), rt.new_string(shipping_to))))) { 92 } else { 60 })
	}
	return rt.new_int(if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('DE'), rt.new_string(shipping_from))) && rt.is_true(rt.identical(rt.new_string('DE'), rt.new_string(shipping_to))))) { 92 } else { 60 })
	}
	return rt.new_int(if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }]), rt.new_bool(true)])) { 95 } else { 80 })
	}
	return rt.new_int(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.check_s10_upu_format(arg_0) }(rt.new_string(tracking_number_mutated))) { 88 } else { 75 })
	}
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: '/^\\d{10}$/', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: '/^\\d{11}$/', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: '/^JJD\\d{10}$/', val: 98 }, rt.ArrayItem{ key: '/^JVGL\\d{10}$/', val: 98 }, rt.ArrayItem{ key: '/^\\d{12}$/', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: '/^\\d{14}$/', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: '/^\\d{20}$/', val: 90 }, rt.ArrayItem{ key: '/^3S[A-Z0-9]{8,12}$/', val: 95 }, rt.ArrayItem{ key: '/^GM\\d{16,20}$/', val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: '/^(LX|RX|CN|SG|MY|HK|AU|TH)\\d{9}[A-Z]{2}$/', val: 92 }, rt.ArrayItem{ key: '/^420\\d{23,31}$/', val: 90 }, rt.ArrayItem{ key: '/^\\d{7,9}$/', val: 88 }, rt.ArrayItem{ key: '/^\\d[A-Z]{2}\\d{4,6}$/', val: 90 }, rt.ArrayItem{ key: '/^[A-Z]{3,4}\\d{4,8}$/', val: 88 }, rt.ArrayItem{ key: '/^DSD\\d{8,12}$/', val: 92 }, rt.ArrayItem{ key: '/^JD\\d{11}$/', val: 90 }, rt.ArrayItem{ key: '/^DSC\\d{10,15}$/', val: 85 }, rt.ArrayItem{ key: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: '/^\\d{22}$/', val: 70 }])
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_base_score := item_1.val
			mut var_pattern := item_1.key
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), rt.new_string(tracking_number_mutated).dup()])) {
				mut var_score := if rt.is_true(rt.call_function('is_callable', [var_base_score.dup()])) { rt.call_callable(var_base_score, []rt.PhpVal{}) } else { var_base_score }
				if rt.is_true(rt.greater(var_score, rt.new_int(0))) {
					return rt.create_array([rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) }, rt.ArrayItem{ key: 'ambiguity_score', val: var_score }])
				}
			}
		}
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_dhlshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		major_operation_countries: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'major_operation_countries' { return this.major_operation_countries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_DHLShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'major_operation_countries' { this.major_operation_countries = val; return true }
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



pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_providers_dhlshippingprovider_php() {
	// unsupported statement: Stmt_Declare
}
