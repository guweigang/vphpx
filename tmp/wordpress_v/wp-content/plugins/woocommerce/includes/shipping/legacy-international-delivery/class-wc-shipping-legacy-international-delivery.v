import rt

struct Class_WC_Shipping_Legacy_International_Delivery {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) construct() {
	this.dispatch_set_prop('id', rt.new_string('legacy_international_delivery'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('International flat rate (legacy)'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', '<strong>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This method is deprecated in 2.6.0 and will be removed in future versions - we recommend disabling it and instead setting up a new rate within your <a href="%s">Shipping zones</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])).str() +
		'</strong>')
	this.init()
	rt.call_function('add_action', [
		'woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'id'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_International_Delivery', [
				'WC_Shipping_Legacy_Flat_Rate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) get_option_key() string {
	return
		(rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'plugin_id')).str() +
		'international_delivery_settings'
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) init_form_fields() {
	this.Class_WC_Shipping_Legacy_Flat_Rate.init_form_fields()
	rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', [
		'WC_Shipping_Legacy_Flat_Rate',
	], &this), 'form_fields').array_set('availability', rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Availability'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'select' },
		rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
		rt.ArrayItem{ key: 'description', val: '' },
		rt.ArrayItem{ key: 'default', val: 'including' },
		rt.ArrayItem{ key: 'options', val: rt.create_array([
			rt.ArrayItem{ key: 'including', val: rt.call_function('__', [
				rt.new_string('Selected countries'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'excluding', val: rt.call_function('__', [
				rt.new_string('Excluding selected countries'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) is_available(var_package rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', [
		'WC_Shipping_Legacy_Flat_Rate',
	], &this), 'enabled')))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('including'), rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', [
		'WC_Shipping_Legacy_Flat_Rate',
	], &this), 'availability')))
	{
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'countries').is_array()))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_package.array_get('destination').array_get('country'), rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'countries'), rt.new_bool(true)])))))))
		{
			return false
		}
	} else {
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'countries').is_array()))
			&& rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_package.array_get('destination').array_get('country'), rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'countries'), rt.new_bool(true)]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_package.array_get('destination').array_get('country')))))))))
		{
			return false
		}
	}
	return (rt.call_function('apply_filters', [
		'woocommerce_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_International_Delivery', ['WC_Shipping_Legacy_Flat_Rate'], &this), 'id') +
			'_is_available',
		rt.new_bool(true),
		var_package.dup(),
		rt.new_object('WC_Shipping_Legacy_International_Delivery', [
			'WC_Shipping_Legacy_Flat_Rate',
		], &this),
	])).to_bool()
}

struct Class_WC_Shipping_Legacy_Flat_Rate {
	rt.PhpObjectBase
}

fn create_wc_shipping_legacy_international_delivery() &Class_WC_Shipping_Legacy_International_Delivery {
	mut obj := &Class_WC_Shipping_Legacy_International_Delivery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_legacy_flat_rate() &Class_WC_Shipping_Legacy_Flat_Rate {
	mut obj := &Class_WC_Shipping_Legacy_Flat_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_option_key' {
			return rt.new_string(this.get_option_key())
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_available(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Legacy_International_Delivery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Legacy_Flat_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_shipping_legacy_international_delivery_class_wc_shipping_legacy_international_delivery_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
