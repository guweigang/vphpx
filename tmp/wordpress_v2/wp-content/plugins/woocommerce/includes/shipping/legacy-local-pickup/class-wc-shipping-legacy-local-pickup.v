import rt

struct Class_WC_Shipping_Legacy_Local_Pickup {
	rt.PhpObjectBase
pub mut:
	codes rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) construct() {
	this.dispatch_set_prop('id', rt.new_string('legacy_local_pickup'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Local pickup (legacy)'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', '<strong>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This method is deprecated in 2.6.0 and will be removed in future versions - we recommend disabling it and instead setting up a new rate within your <a href="%s">Shipping zones</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])).str() +
		'</strong>')
	this.init()
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) process_admin_options() {
	this.Class_WC_Shipping_Method.process_admin_options()
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
		'WC_Shipping_Method',
	], &this), 'settings').array_get(rt.new_string('enabled'))))
	{
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=shipping&section=options'),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) get_option_key() string {
	return
		(rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', ['WC_Shipping_Method'], &this), 'plugin_id')).str() +
		'local_pickup_settings'
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) init() {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('enabled', this.get_option(rt.new_string('enabled')))
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.codes = this.get_option(rt.new_string('codes'))
	this.dispatch_set_prop('availability', this.get_option(rt.new_string('availability')))
	this.dispatch_set_prop('countries', this.get_option(rt.new_string('countries')))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', ['WC_Shipping_Method'], &this), 'id')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) calculate_shipping(var_package rt.PhpVal) {
	mut var_rate := {
		'id':      rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
			'WC_Shipping_Method',
		], &this), 'id')
		'label':   rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
			'WC_Shipping_Method',
		], &this), 'title')
		'package': var_package
	}
	this.add_rate(var_rate.clone())
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Once disabled, this legacy method will no longer be available.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Title'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('This controls the title which the user sees during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Local pickup'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'codes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Allowed ZIP/post codes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('What ZIP/post codes are available for local pickup?'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Separate codes with a comma. Accepts wildcards, e.g. <code>P*</code> will match a postcode of PE30. Also accepts a pattern, e.g. <code>NG1___</code> would match NG1 1AA but not NG10 1AA'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: 'e.g. 12345, 56789' },
		]) },
		rt.ArrayItem{ key: 'availability', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Method availability'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'default', val: 'all' },
			rt.ArrayItem{ key: 'class', val: 'availability wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'all', val: rt.call_function('__', [
					rt.new_string('All allowed countries'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'specific', val: rt.call_function('__', [
					rt.new_string('Specific countries'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'countries', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Specific countries'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'multiselect' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'width: 400px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'options', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'data-placeholder', val: rt.call_function('__', [
					rt.new_string('Select some countries'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
	]))
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) get_valid_postcodes() rt.PhpVal {
	mut var_codes := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.codes)))) {
		mut iter_1 := rt.call_function('explode', [rt.new_string(','), this.codes]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_code := item_1.val
			var_codes.array_push(var_code.clone().to_string().trim_space().to_upper())
		}
	}
	return var_codes.clone()
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) is_valid_postcode(var_postcode rt.PhpVal, var_country rt.PhpVal) bool {
	mut var_postcode_mutated := var_postcode
	mut var_codes := this.get_valid_postcodes()
	var_postcode_mutated = rt.new_string(this.clean(var_postcode_mutated.clone()))
	mut var_formatted_postcode := rt.call_function('wc_format_postcode', [
		var_postcode_mutated.clone(), var_country.clone()])
	if rt.is_true(rt.call_function('in_array', [var_postcode_mutated.clone(), var_codes.clone(), rt.new_bool(true)]))
		|| rt.is_true(rt.call_function('in_array', [var_formatted_postcode.clone(), var_codes.clone(), rt.new_bool(true)])) {
		return true
	}
	mut iter_2 := var_codes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_c := item_2.val
		mut var_pattern := rt.new_string('/^' +
			(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('[0-9a-zA-Z]'), rt.call_function('preg_quote', [var_c.clone()])])).str() +
			'$/i')
		if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(),
			var_postcode_mutated.clone()]))
		{
			return true
		}
	}
	mut var_wildcard_postcode := rt.new_string(var_formatted_postcode.str() + '*')
	mut var_postcode_length := rt.new_int(var_formatted_postcode.clone().to_string().len)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_postcode_length))) { break
		 }
		if rt.is_true(rt.call_function('in_array', [var_wildcard_postcode.clone(),
			var_codes.clone(), rt.new_bool(true)]))
		{
			return true
		}
		var_wildcard_postcode = rt.new_string(
			(rt.call_function('substr', [var_wildcard_postcode.clone(), rt.new_int(0), rt.new_int(-2)])).str() +
			'*')
		rt.post_inc(var_i)
	}
	return false
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) is_available(var_package rt.PhpVal) rt.PhpVal {
	mut var_is_available := rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
		'WC_Shipping_Method',
	], &this), 'enabled'))
	if rt.is_true(var_is_available) && rt.is_true(this.get_valid_postcodes()) {
		var_is_available = rt.new_bool(this.is_valid_postcode(var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('postcode')),
			var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country'))))
	}
	if rt.is_true(var_is_available) {
		if rt.is_true(rt.identical(rt.new_string('specific'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
			'WC_Shipping_Method',
		], &this), 'availability')))
		{
			mut var_ship_to_countries := rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
				'WC_Shipping_Method',
			], &this), 'countries')
		} else {
			var_ship_to_countries = rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))
		}
		if var_ship_to_countries.clone().is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country')), var_ship_to_countries.clone(), rt.new_bool(true)]))))) {
			var_is_available = rt.new_bool(false)
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Pickup', ['WC_Shipping_Method'], &this), 'id') +
			'_is_available'),
		var_is_available.clone(),
		var_package.clone(),
		rt.new_object('WC_Shipping_Legacy_Local_Pickup', [
			'WC_Shipping_Method',
		], &this),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) clean(var_code rt.PhpVal) string {
	return (rt.call_function('str_replace', [rt.new_string('-'), rt.new_string(''), rt.call_function('sanitize_title', [var_code.clone()])])).str() + if rt.is_true(rt.call_function('strstr', [var_code.clone(), rt.new_string('*')])) {
		'*'
	} else {
		''
	}
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

fn create_wc_shipping_legacy_local_pickup() &Class_WC_Shipping_Legacy_Local_Pickup {
	mut obj := &Class_WC_Shipping_Legacy_Local_Pickup{
		PhpObjectBase: rt.PhpObjectBase{}
		codes:         rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_method(_args ...rt.PhpVal) &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'process_admin_options' {
			this.process_admin_options()
			return rt.new_null()
		}
		'get_option_key' {
			return rt.new_string(this.get_option_key())
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'get_valid_postcodes' {
			return this.get_valid_postcodes()
		}
		'is_valid_postcode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_postcode(dispatch_arg_0, dispatch_arg_1))
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_available(dispatch_arg_0)
		}
		'clean' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.clean(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Legacy_Local_Pickup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'codes' { return this.codes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Legacy_Local_Pickup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'codes' {
			this.codes = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Shipping_Method) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Method) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Method) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
