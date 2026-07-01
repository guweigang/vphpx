import rt

struct Class_WC_Legacy_Customer {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Legacy_Customer) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	mut var_legacy_keys := ['id', 'country', 'state', 'postcode', 'city', 'address_1', 'address',
		'address_2', 'shipping_country', 'shipping_state', 'shipping_postcode', 'shipping_city',
		'shipping_address_1', 'shipping_address', 'shipping_address_2', 'is_vat_exempt',
		'calculated_shipping']
	var_key_mutated = this.filter_legacy_key(var_key_mutated.dup())
	return rt.call_function('in_array', [var_key_mutated.dup(),
		var_legacy_keys.dup()])
}

fn (mut this Class_WC_Legacy_Customer) magic_get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	rt.call_function('wc_doing_it_wrong', [var_key_mutated.dup(),
		rt.new_string('Customer properties should not be accessed directly.'),
		rt.new_string('3.0')])
	var_key_mutated = this.filter_legacy_key(var_key_mutated.dup())
	if rt.is_true(rt.call_function('in_array', [var_key_mutated.dup(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'country' },
			rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'postcode' },
			rt.ArrayItem{ key: none, val: 'city' }, rt.ArrayItem{ key: none, val: 'address_1' },
			rt.ArrayItem{ key: none, val: 'address' }, rt.ArrayItem{ key: none, val: 'address_2' }])]))
	{
		var_key_mutated = rt.new_string('billing_' + var_key_mutated.str())
	}
	return if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Legacy_Customer', [
				'WC_Data',
			], &this) },
			rt.ArrayItem{ key: none, val: 'get_${var_key.to_string()}' },
		]),
	]))
	{
		rt.call_method(rt.new_object('WC_Legacy_Customer', ['WC_Data'], &this),
			'get_${var_key.to_string()}', []rt.PhpVal{})
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WC_Legacy_Customer) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	rt.call_function('wc_doing_it_wrong', [var_key_mutated.dup(),
		rt.new_string('Customer properties should not be set directly.'),
		rt.new_string('3.0')])
	var_key_mutated = this.filter_legacy_key(var_key_mutated.dup())
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Legacy_Customer', [
				'WC_Data',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' },
		]),
	]))
	{
		rt.call_method(rt.new_object('WC_Legacy_Customer', ['WC_Data'], &this),
			'set_${var_key.to_string()}', [var_value.dup()])
	}
}

fn (mut this Class_WC_Legacy_Customer) filter_legacy_key(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.new_string('address'), var_key_mutated)) {
		var_key_mutated = rt.new_string(rt.new_string('address_1'))
	}
	if rt.is_true(rt.identical(rt.new_string('shipping_address'), var_key_mutated)) {
		var_key_mutated = rt.new_string(rt.new_string('shipping_address_1'))
	}
	return var_key_mutated.dup()
}

fn (mut this Class_WC_Legacy_Customer) set_location(var_country rt.PhpVal, var_state rt.PhpVal, postcode string, city string) {
	this.set_billing_location(var_country.dup(), var_state.dup(), rt.new_string(postcode),
		rt.new_string(city))
	this.set_shipping_location(var_country.dup(), var_state.dup(), rt.new_string(postcode),
		rt.new_string(city))
}

fn (mut this Class_WC_Legacy_Customer) get_default_country() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_default_country'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_customer_default_location'),
	])
	mut var_default := rt.call_function('wc_get_customer_default_location', []rt.PhpVal{})
	return var_default.array_get('country')
}

fn (mut this Class_WC_Legacy_Customer) get_default_state() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_default_state'),
		rt.new_string('3.0'),
		rt.new_string('wc_get_customer_default_location'),
	])
	mut var_default := rt.call_function('wc_get_customer_default_location', []rt.PhpVal{})
	return var_default.array_get('state')
}

fn (mut this Class_WC_Legacy_Customer) set_to_base() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_to_base'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_billing_address_to_base'),
	])
	this.set_billing_address_to_base()
}

fn (mut this Class_WC_Legacy_Customer) set_shipping_to_base() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_shipping_to_base'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_shipping_address_to_base'),
	])
	this.set_shipping_address_to_base()
}

fn (mut this Class_WC_Legacy_Customer) calculated_shipping(calculated bool) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::calculated_shipping'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_calculated_shipping'),
	])
	this.set_calculated_shipping(rt.new_bool(calculated))
}

fn (mut this Class_WC_Legacy_Customer) set_default_data() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_default_data'),
		rt.new_string('3.0'),
	])
}

fn (mut this Class_WC_Legacy_Customer) save_data() {
	this.save()
}

fn (mut this Class_WC_Legacy_Customer) is_paying_customer(user_id string) rt.PhpVal {
	mut user_id_mutated := user_id
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::is_paying_customer'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::get_is_paying_customer'),
	])
	if !(user_id_mutated == '') {
		user_id_mutated = (rt.call_function('get_current_user_id', []rt.PhpVal{})).str()
	}
	return rt.identical(rt.new_string('1'), rt.call_function('get_user_meta', [
		rt.new_string(user_id_mutated).dup(), rt.new_string('paying_customer'),
		rt.new_bool(true)]))
}

fn (mut this Class_WC_Legacy_Customer) get_address() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_address'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::get_billing_address_1'),
	])
	return this.get_billing_address_1()
}

fn (mut this Class_WC_Legacy_Customer) get_address_2() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_address_2'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::get_billing_address_2'),
	])
	return this.get_billing_address_2()
}

fn (mut this Class_WC_Legacy_Customer) get_country() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_country'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::get_billing_country'),
	])
	return this.get_billing_country()
}

fn (mut this Class_WC_Legacy_Customer) get_state() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Customer::get_state'),
		rt.new_string('3.0'), rt.new_string('WC_Customer::get_billing_state')])
	return this.get_billing_state()
}

fn (mut this Class_WC_Legacy_Customer) get_postcode() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::get_postcode'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::get_billing_postcode'),
	])
	return this.get_billing_postcode()
}

fn (mut this Class_WC_Legacy_Customer) get_city() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Customer::get_city'),
		rt.new_string('3.0'), rt.new_string('WC_Customer::get_billing_city')])
	return this.get_billing_city()
}

fn (mut this Class_WC_Legacy_Customer) set_country(var_country rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_country'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_billing_country'),
	])
	this.set_billing_country(var_country.dup())
}

fn (mut this Class_WC_Legacy_Customer) set_state(var_state rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Customer::set_state'),
		rt.new_string('3.0'), rt.new_string('WC_Customer::set_billing_state')])
	this.set_billing_state(var_state.dup())
}

fn (mut this Class_WC_Legacy_Customer) set_postcode(var_postcode rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_postcode'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_billing_postcode'),
	])
	this.set_billing_postcode(var_postcode.dup())
}

fn (mut this Class_WC_Legacy_Customer) set_city(var_city rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Customer::set_city'),
		rt.new_string('3.0'), rt.new_string('WC_Customer::set_billing_city')])
	this.set_billing_city(var_city.dup())
}

fn (mut this Class_WC_Legacy_Customer) set_address(var_address rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_address'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_billing_address'),
	])
	this.set_billing_address(var_address.dup())
}

fn (mut this Class_WC_Legacy_Customer) set_address_2(var_address rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Customer::set_address_2'),
		rt.new_string('3.0'),
		rt.new_string('WC_Customer::set_billing_address_2'),
	])
	this.set_billing_address_2(var_address.dup())
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

fn create_wc_legacy_customer() &Class_WC_Legacy_Customer {
	mut obj := &Class_WC_Legacy_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data() &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Legacy_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'filter_legacy_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_legacy_key(dispatch_arg_0)
		}
		'set_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.set_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_default_country' {
			return this.get_default_country()
		}
		'get_default_state' {
			return this.get_default_state()
		}
		'set_to_base' {
			this.set_to_base()
			return rt.new_null()
		}
		'set_shipping_to_base' {
			this.set_shipping_to_base()
			return rt.new_null()
		}
		'calculated_shipping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.calculated_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'set_default_data' {
			this.set_default_data()
			return rt.new_null()
		}
		'save_data' {
			this.save_data()
			return rt.new_null()
		}
		'is_paying_customer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_paying_customer(dispatch_arg_0)
		}
		'get_address' {
			return this.get_address()
		}
		'get_address_2' {
			return this.get_address_2()
		}
		'get_country' {
			return this.get_country()
		}
		'get_state' {
			return this.get_state()
		}
		'get_postcode' {
			return this.get_postcode()
		}
		'get_city' {
			return this.get_city()
		}
		'set_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_country(dispatch_arg_0)
			return rt.new_null()
		}
		'set_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_state(dispatch_arg_0)
			return rt.new_null()
		}
		'set_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_postcode(dispatch_arg_0)
			return rt.new_null()
		}
		'set_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_city(dispatch_arg_0)
			return rt.new_null()
		}
		'set_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_address(dispatch_arg_0)
			return rt.new_null()
		}
		'set_address_2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_address_2(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Legacy_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_includes_legacy_class_wc_legacy_customer_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
