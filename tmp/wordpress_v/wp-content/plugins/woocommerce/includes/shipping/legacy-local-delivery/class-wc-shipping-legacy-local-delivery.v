import rt

struct Class_WC_Shipping_Legacy_Local_Delivery {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_null()
	codes     rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) construct() {
	this.dispatch_set_prop('id', rt.new_string('legacy_local_delivery'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Local delivery (legacy)'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', '<strong>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This method is deprecated in 2.6.0 and will be removed in future versions - we recommend disabling it and instead setting up a new rate within your <a href="%s">Shipping zones</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])).str() +
		'</strong>')
	this.init()
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) process_admin_options() {
	this.Class_WC_Shipping_Local_Pickup.process_admin_options()
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
		'WC_Shipping_Local_Pickup',
	], &this), 'settings').array_get('enabled')))
	{
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=shipping&section=options'),
			]),
		])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) get_option_key() string {
	return
		(rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', ['WC_Shipping_Local_Pickup'], &this), 'plugin_id')).str() +
		'local_delivery_settings'
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) init() {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.prop_type = this.get_option(rt.new_string('type'))
	this.dispatch_set_prop('fee', this.get_option(rt.new_string('fee')))
	this.codes = this.get_option(rt.new_string('codes'))
	this.dispatch_set_prop('availability', this.get_option(rt.new_string('availability')))
	this.dispatch_set_prop('countries', this.get_option(rt.new_string('countries')))
	rt.call_function('add_action', [
		'woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', ['WC_Shipping_Local_Pickup'], &this), 'id'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
				'WC_Shipping_Local_Pickup',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) calculate_shipping(var_package rt.PhpVal) {
	mut var_shipping_total := rt.new_int(rt.new_int(0))
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed'))) {
		var_shipping_total = rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
			'WC_Shipping_Local_Pickup',
		], &this), 'fee')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('percent'))) {
		var_shipping_total = rt.mul(var_package.array_get('contents_cost'), rt.div(rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
			'WC_Shipping_Local_Pickup',
		], &this), 'fee'), rt.new_int(100)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		{
			mut iter_1 := var_package.array_get('contents').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_values := item_1.val
				mut var_item_id := item_1.key
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.greater(var_values.array_get('quantity'), rt.new_int(0)))
					&& rt.is_true(rt.call_method(var_values.array_get('data'), 'needs_shipping', []rt.PhpVal{}))))
				{
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	mut var_rate := {
		'id':      rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
			'WC_Shipping_Local_Pickup',
		], &this), 'id')
		'label':   rt.get_property(rt.new_object('WC_Shipping_Legacy_Local_Delivery', [
			'WC_Shipping_Local_Pickup',
		], &this), 'title')
		'cost':    var_shipping_total
		'package': var_package
	}
	this.add_rate(var_rate.dup())
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) init_form_fields() {
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
				rt.new_string('Local delivery'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Fee type'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How to calculate delivery charges'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'fixed' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'fixed', val: rt.call_function('__', [
					rt.new_string('Fixed amount'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'percent', val: rt.call_function('__', [
					rt.new_string('Percentage of cart total'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'product', val: rt.call_function('__', [
					rt.new_string('Fixed amount per product'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'fee', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Delivery fee'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'price' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('What fee do you want to charge for local delivery, disregarded if you choose free. Leave blank to disable.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_price', [
				rt.new_int(0),
			]) },
		]) },
		rt.ArrayItem{ key: 'codes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Allowed ZIP/post codes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('What ZIP/post codes are available for local delivery?'),
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
					rt.new_string('Specific Countries'),
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

struct Class_WC_Shipping_Local_Pickup {
	rt.PhpObjectBase
}

fn create_wc_shipping_legacy_local_delivery() &Class_WC_Shipping_Legacy_Local_Delivery {
	mut obj := &Class_WC_Shipping_Legacy_Local_Delivery{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_null()
		codes:         rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_local_pickup() &Class_WC_Shipping_Local_Pickup {
	mut obj := &Class_WC_Shipping_Local_Pickup{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Legacy_Local_Delivery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'codes' { return this.codes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Legacy_Local_Delivery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'codes' {
			this.codes = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Shipping_Local_Pickup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Local_Pickup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Local_Pickup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_shipping_legacy_local_delivery_class_wc_shipping_legacy_local_delivery_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
