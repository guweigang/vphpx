import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider {
	rt.PhpObjectBase
pub mut:
		supported_countries rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_key() string {
	return 'fedex'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_name() string {
	return 'FedEx'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_icon() string {
	return (rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/images/shipping_providers/fedex.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_tracking_url(tracking_number string) string {
	mut tracking_number_mutated := tracking_number
	return 'https://www.fedex.com/fedextrack/?tracknumbers=' + (rt.call_function('rawurlencode', [rt.new_string(tracking_number_mutated).dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_shipping_from_countries() rt.PhpVal {
	return this.supported_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) get_shipping_to_countries() rt.PhpVal {
	return this.supported_countries
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) can_ship_from_to(shipping_from string, shipping_to string) bool {
	return rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), this.supported_countries, rt.new_bool(true)])) && rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_to), this.supported_countries, rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	mut tracking_number_mutated := tracking_number
	if tracking_number_mutated == '' || !(this.can_ship_from_to(shipping_from, shipping_to)) {
		return rt.new_null()
	}
	tracking_number_mutated = rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(''), rt.new_string(tracking_number_mutated).dup()]).to_string().to_upper()
	mut var_is_north_america := rt.call_function('in_array', [rt.new_string(shipping_from), rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }]), rt.new_bool(true)])
	mut var_is_us_domestic := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_from))) && rt.is_true(rt.identical(rt.new_string('US'), rt.new_string(shipping_to)))))
	closure_4_fn := fn [var_shipping_from] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_tracking_number, var_is_north_america] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_tracking_number, var_is_north_america] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_tracking_number, var_is_north_america, var_is_us_domestic] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.validate_fedex_check_digit(arg_0) }(rt.new_string(tracking_number_mutated))) {
		return rt.new_int(if rt.is_true(rt.new_bool(rt.is_true(var_is_north_america) || rt.is_true(var_is_us_domestic))) { 98 } else { 85 })
		// unsupported statement: Stmt_Nop
	}
	return rt.new_int(if rt.is_true(var_is_north_america) { if rt.is_true(var_is_us_domestic) { 98 } else { 85 } } else { 70 })
	// unsupported statement: Stmt_Nop
	return rt.new_null()
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.validate_fedex_check_digit(arg_0) }(rt.new_string(tracking_number_mutated))) {
		return rt.new_int(if rt.is_true(var_is_north_america) { 96 } else { 80 })
		// unsupported statement: Stmt_Nop
	}
	return rt.new_int(if rt.is_true(var_is_north_america) { 80 } else { 65 })
	// unsupported statement: Stmt_Nop
	return rt.new_null()
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.validate_fedex_check_digit(arg_0) }(rt.new_string(tracking_number_mutated))) {
		return rt.new_int(if rt.is_true(var_is_north_america) { 95 } else { 78 })
		// unsupported statement: Stmt_Nop
	}
	return rt.new_int(if rt.is_true(var_is_north_america) { 78 } else { 60 })
	// unsupported statement: Stmt_Nop
	return rt.new_null()
	}
	return rt.new_int(if rt.is_true(rt.call_function('in_array', [rt.new_string(shipping_from), rt.create_array([rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'FR' }, rt.ArrayItem{ key: none, val: 'IT' }, rt.ArrayItem{ key: none, val: 'ES' }, rt.ArrayItem{ key: none, val: 'NL' }]), rt.new_bool(true)])) { 93 } else { 75 })
	}
	mut var_patterns := rt.create_array([rt.ArrayItem{ key: '/^DT\\d{12}$/', val: if rt.is_true(var_is_north_america) { 90 } else { 0 } }, rt.ArrayItem{ key: '/^0[01]\\d{13,23}$/', val: 98 }, rt.ArrayItem{ key: '/^023\\d{17}$/', val: 97 }, rt.ArrayItem{ key: '/^58\\d{17,19}$/', val: 96 }, rt.ArrayItem{ key: '/^\\d{12}$/', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: '/^\\d{15}$/', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: '/^\\d{14}$/', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: '/^\\d{34}$/', val: 90 }, rt.ArrayItem{ key: '/^96\\d{18,20}$/', val: if rt.is_true(var_is_north_america) { 95 } else { 60 } }, rt.ArrayItem{ key: '/^7\\d{11,20}$/', val: if rt.is_true(var_is_north_america) { 90 } else { 75 } }, rt.ArrayItem{ key: '/^97\\d{13,23}$/', val: 93 }, rt.ArrayItem{ key: '/^3\\d{10,14}$/', val: 92 }, rt.ArrayItem{ key: '/^8\\d{8,14}$/', val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: '/^NFO\\d{10,15}$/', val: 92 }, rt.ArrayItem{ key: '/^SD\\d{10,15}$/', val: 90 }, rt.ArrayItem{ key: '/^\\d{20}$/', val: 70 }, rt.ArrayItem{ key: '/^\\d{22}$/', val: 65 }])
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
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_fedexshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		supported_countries: rt.new_array()
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'supported_countries' { return this.supported_countries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_FedExShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'supported_countries' { this.supported_countries = val; return true }
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



pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_providers_fedexshippingprovider_php() {
	// unsupported statement: Stmt_Declare
}
