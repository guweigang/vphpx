import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider {
	rt.PhpObjectBase
pub mut:
		domestic_countries rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_key() string {
	return 'usps'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_name() string {
	return 'USPS'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_icon() string {
	return (rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/images/shipping_providers/usps.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_tracking_url(tracking_number string) string {
	mut tracking_number_mutated := tracking_number
	return 'https://tools.usps.com/go/TrackConfirmAction?tLabels=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'US' }])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return rt.call_function('array_merge', [this.domestic_countries, rt.call_function('explode', [rt.new_string(' '), rt.new_string('AD AE AF AG AI AL AM AO AR AT AU AW AZ BA BB BD BE BF BG BH BI BJ BM BN BO BR BS BT BW BY BZ CA CD CF CG CH CI CL CM CN CO CR CU CV CY CZ DE DJ DK DM DO DZ EC EE EG ER ES ET FI FJ FR GA GB GD GE GH GI GM GN GQ GR GT GW GY HK HN HR HT HU ID IE IL IN IQ IR IS IT JM JO JP KE KG KH KI KM KN KP KR KW KZ LA LB LC LK LR LS LT LU LV LY MA MC MD ME MG MK ML MM MN MO MR MT MU MV MW MX MY MZ NA NE NG NI NL NO NP NZ OM PA PE PG PH PK PL PT PY QA RO RS RU RW SA SB SC SD SE SG SI SK SL SM SN SO SR ST SV SY SZ TD TG TH TJ TL TM TN TO TR TT TV TW TZ UA UG UK UY UZ VC VE VN VU WS YE ZA ZM ZW')])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) can_ship_from_to(shipping_from string, shipping_to string) bool {
	return rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.get_shipping_from_countries(), rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to), this.get_shipping_to_countries(), rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if tracking_number_mutated == '' || !(this.can_ship_from_to(shipping_from, shipping_to)) {
		return rt.new_null()
	}
	tracking_number_mutated = rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(''), rt.new_string(tracking_number_mutated).clone()]).to_string().to_upper()
	mut var_is_domestic := rt.call_function('in_array', [rt.new_string(shipping_to), this.domestic_countries, rt.new_bool(true)])
	closure_2_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_1 := iife_temp_1.validate_mod10_check_digit(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_1) { 100 } else { 95 })
		}
	closure_4_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_3 := iife_temp_3.check_s10_upu_format(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_3) { 98 } else { 90 })
		}
	closure_6_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_5 := iife_temp_5.validate_mod10_check_digit(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_5) { 90 } else { 80 })
		}
	closure_8_fn := fn [var_tracking_number] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_7 := iife_temp_7.validate_mod10_check_digit(rt.new_string(tracking_number_mutated))
		return rt.new_int(if rt.is_true(iife_result_7) { 88 } else { 80 })
		}
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: '/^(94|93|92|95|96|94|94|94|94)\\d{18,22}$/', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: '/^[A-Z]{2}\\d{9}[A-Z]{2}$/', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: '/^82\\d{8,9}$/', val: 95 }, rt.ArrayItem{ key: '/^420\\d{23,31}$/', val: 90 }, rt.ArrayItem{ key: '/^\\d{20,22}$/', val: 80 }, rt.ArrayItem{ key: '/^9\\d{21,33}$/', val: 75 }, rt.ArrayItem{ key: '/^91\\d{18,20}$/', val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: '/^030[67]\\d{16,20}$/', val: rt.new_closure(closure_8_fn) }])
	mut iter_1 := var_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_score := item_1.val
		mut var_pattern := item_1.key
		if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(), rt.new_string(tracking_number_mutated).clone()])) {
			mut var_ambiguity_score := if rt.call_function('is_callable', [var_score.clone()]) { rt.call_callable(var_score, []rt.PhpVal{}) } else { var_score }
			return rt.create_array([rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) }, rt.ArrayItem{ key: 'ambiguity_score', val: var_ambiguity_score }])
		}
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[A-Z]{2}\\d{9}US$/'), rt.new_string(tracking_number_mutated).clone()])) {
		return rt.create_array([rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) }, rt.ArrayItem{ key: 'ambiguity_score', val: 80 }])
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\d{20,34}$/'), rt.new_string(tracking_number_mutated).clone()])) {
		return rt.create_array([rt.ArrayItem{ key: 'url', val: this.get_tracking_url(tracking_number_mutated) }, rt.ArrayItem{ key: 'ambiguity_score', val: 60 }])
	}
	return rt.new_null()
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_uspsshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		domestic_countries: rt.new_array()
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'domestic_countries' { return this.domestic_countries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_USPSShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'domestic_countries' { this.domestic_countries = val; return true }
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
