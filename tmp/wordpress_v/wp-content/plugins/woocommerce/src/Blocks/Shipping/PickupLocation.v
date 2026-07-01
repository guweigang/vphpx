import rt

struct Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation {
	rt.PhpObjectBase
pub mut:
	pickup_locations rt.PhpVal = rt.new_array()
	cost             rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) construct() {
	this.Class_WC_Shipping_Method.construct()
	this.dispatch_set_prop('id', rt.new_string('pickup_location'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Local pickup'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [
		rt.new_string('Allow customers to choose a local pickup location during checkout.'),
		rt.new_string('woocommerce'),
	]))
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) init() {
	this.dispatch_set_prop('enabled', this.get_option(rt.new_string('enabled')))
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title'), rt.call_function('__', [
		rt.new_string('Pickup'),
		rt.new_string('woocommerce'),
	])))
	this.dispatch_set_prop('tax_status', this.get_option(rt.new_string('tax_status')))
	this.cost = this.get_option(rt.new_string('cost'))
	this.dispatch_set_prop('supports', rt.create_array([
		rt.ArrayItem{ key: none, val: 'settings' },
		rt.ArrayItem{ key: none, val: 'local-pickup' },
	]))
	this.pickup_locations = rt.call_function('get_option', [
			rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', ['WC_Shipping_Method'], &this), 'id') +
			'_pickup_locations',
		rt.new_array(),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_attribute_label'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'translate_meta_data' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) has_valid_pickup_location(var_address rt.PhpVal) bool {
	mut var_address_fields := rt.call_function('wp_parse_args', [
		rt.cast_array(var_address),
		rt.create_array([rt.ArrayItem{ key: 'city', val: '' },
			rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'state', val: '' },
			rt.ArrayItem{ key: 'country', val: '' }]),
	])
	if !rt.is_true(var_address_fields.array_get('country')) {
		return false
	}
	if !(!rt.is_true(var_address_fields.array_get('city')))
		&& !(!rt.is_true(var_address_fields.array_get('postcode')))
		&& !(!rt.is_true(var_address_fields.array_get('state'))) {
		return true
	}
	mut var_country_address_fields := rt.call_method(rt.get_property(rt.call_function('wc',
		[]rt.PhpVal{}), 'countries'), 'get_address_fields', [
		var_address_fields.array_get('country'), rt.new_string('shipping_')])
	{
		mut iter_1 := var_country_address_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_field_name := item_1.key
			mut var_key := rt.call_function('str_replace', [rt.new_string('shipping_'),
				rt.new_string(''), var_field_name.dup()])
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(var_address_fields.array_isset(var_key)
				&& rt.is_true(rt.identical(rt.new_bool(true), var_field.array_get('required')))))
				&& !rt.is_true(var_address_fields.array_get(var_key))))
			{
				return false
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) calculate_shipping(var_package rt.PhpVal) {
	if rt.is_true(this.pickup_locations) {
		{
			mut iter_1 := this.pickup_locations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_location := item_1.val
				mut var_index := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_location.array_get('enabled'))))) {
					continue
				}
				this.add_rate(rt.create_array([
					rt.ArrayItem{ key: 'id', val:
						rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', ['WC_Shipping_Method'], &this), 'id') +
						':' + var_index.str() },
					rt.ArrayItem{ key: 'label', val: rt.call_function('wp_kses_post', [
							(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', ['WC_Shipping_Method'], &this), 'title')).str() +
							' (' + (var_location.array_get('name')).str() + ')',
					]) },
					rt.ArrayItem{ key: 'package', val: var_package },
					rt.ArrayItem{ key: 'cost', val: this.cost },
					rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
						rt.ArrayItem{ key: 'pickup_location', val: rt.call_function('wp_kses_post', [
							var_location.array_get('name'),
						]) },
						rt.ArrayItem{
							key: 'pickup_address'
							val: if this.has_valid_pickup_location(var_location.array_get('address')) { rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [
									var_location.array_get('address'),
									rt.new_string(', '),
								]) } else { rt.new_string('') }
						},
						rt.ArrayItem{ key: 'pickup_details', val: rt.call_function('wp_kses_post', [
							var_location.array_get('details'),
						]) },
					]) },
				]))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) is_available(var_package rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		'woocommerce_shipping_' +
			rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', ['WC_Shipping_Method'], &this), 'id') +
			'_is_available',
		rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', [
			'WC_Shipping_Method',
		], &this), 'enabled')),
		var_package.dup(),
		rt.new_object('Automattic_WooCommerce_Blocks_Shipping_PickupLocation', [
			'WC_Shipping_Method',
		], &this),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) translate_meta_data(var_label rt.PhpVal, var_name rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_product) {
		return var_label.dup()
	}
	mut switch_val_1 := var_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('pickup_location'))) {
		return rt.call_function('__', [rt.new_string('Pickup location'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pickup_address'))) {
		return rt.call_function('__', [rt.new_string('Pickup address'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pickup_details'))) {
		return rt.call_function('__', [rt.new_string('Pickup details'),
			rt.new_string('woocommerce')])
	}
	return var_label.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) admin_options() {
	// unsupported statement: Stmt_Global
	mut var_hide_save_button := rt.new_bool(rt.new_bool(true))
	rt.call_function('wp_enqueue_script', [
		rt.new_string('wc-shipping-method-pickup-location'),
	])
	print('<h2>' +
		(rt.call_function('esc_html__', [rt.new_string('Local pickup'), rt.new_string('woocommerce')])).str() +
		'</h2>')
	print('<div class="wrap"><div id="wc-shipping-method-pickup-location-settings-container"></div></div>')
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_shipping_pickuplocation() &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation{
		PhpObjectBase:    rt.PhpObjectBase{}
		pickup_locations: rt.new_array()
		cost:             rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_method() &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'has_valid_pickup_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_valid_pickup_location(dispatch_arg_0))
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_available(dispatch_arg_0)
		}
		'translate_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.translate_meta_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'pickup_locations' { return this.pickup_locations }
		'cost' { return this.cost }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'pickup_locations' {
			this.pickup_locations = val
			return true
		}
		'cost' {
			this.cost = val
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_shipping_pickuplocation_php() {
}
