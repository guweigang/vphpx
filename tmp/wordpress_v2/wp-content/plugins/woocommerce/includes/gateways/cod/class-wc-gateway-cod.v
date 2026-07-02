import rt

pub fn Class_WC_Gateway_COD.id() string {
	return 'cod'
}

struct Class_WC_Gateway_COD {
	rt.PhpObjectBase
pub mut:
	instructions       rt.PhpVal = rt.new_null()
	enable_for_methods rt.PhpVal = rt.new_null()
	enable_for_virtual bool
}

fn (mut this Class_WC_Gateway_COD) construct() {
	this.setup_properties()
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('description', this.get_option(rt.new_string('description')))
	this.instructions = this.get_option(rt.new_string('instructions'))
	this.enable_for_methods = this.get_option(rt.new_string('enable_for_methods'), rt.new_array())
	this.enable_for_virtual = rt.identical(this.get_option(rt.new_string('enable_for_virtual'),
		rt.new_string('yes')), rt.new_string('yes'))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_payment_gateways_' +(rt.get_property(rt.new_object('WC_Gateway_COD', ['WC_Payment_Gateway'], &this), 'id')).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_COD', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_thankyou_' +(rt.get_property(rt.new_object('WC_Gateway_COD', ['WC_Payment_Gateway'], &this), 'id')).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_COD', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'thankyou_page' },
		]),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_payment_complete_order_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_COD', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'change_payment_complete_order_status' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_before_order_table'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_COD', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_instructions' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
}

fn (mut this Class_WC_Gateway_COD) setup_properties() {
	this.dispatch_set_prop('id', Class_WC_Gateway_COD.id())
	this.dispatch_set_prop('icon', rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cod_icon'),
		rt.new_string(''),
	]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Cash on delivery'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [
		rt.new_string('Let your shoppers pay upon delivery — by cash or other methods of payment.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
}

fn (mut this Class_WC_Gateway_COD) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Enable cash on delivery'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'description', val: '' },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Title'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'safe_text' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Payment method description that the customer will see on your checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Cash on delivery'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Description'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Payment method description that the customer will see on your website.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Pay with cash upon delivery.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'instructions', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Instructions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Instructions that will be added to the thank you page.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Pay with cash upon delivery.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'enable_for_methods', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable for shipping methods'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'multiselect' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'width: 400px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('If COD is only available for certain methods, set it up here. Leave blank to enable for all methods.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: this.load_shipping_method_options() },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'data-placeholder', val: rt.call_function('__', [
					rt.new_string('Select shipping methods'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'enable_for_virtual', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Accept for virtual orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Accept COD if the order is virtual'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
		]) },
	]))
}

fn (mut this Class_WC_Gateway_COD) is_available() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Gateway_COD', [
		'WC_Payment_Gateway',
	], &this), 'enabled')))))
	{
		return false
	}
	mut var_is_virtual := rt.new_bool(true)
	mut var_shipping_methods := rt.new_array()
	if rt.is_true(rt.call_function('is_wc_endpoint_url', [rt.new_string('order-pay')])) {
		mut var_order := rt.call_function('wc_get_order', [
			rt.call_function('absint', [
				rt.call_function('get_query_var', [rt.new_string('order-pay')]),
			]),
		])
		var_shipping_methods = if rt.is_true(var_order) {
			rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})
		} else {
			rt.new_array()
		}
		var_is_virtual =
			rt.new_bool(!(rt.is_true(rt.new_int(var_shipping_methods.clone().array_count()))))
	} else if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'))
		&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})) {
		var_shipping_methods = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'cart'), 'get_shipping_methods', []rt.PhpVal{})
		var_is_virtual = rt.new_bool(false)
	}
	if !(this.enable_for_virtual) && rt.is_true(var_is_virtual) {
		return false
	}
	if !rt.is_true(this.enable_for_methods) || rt.is_true(var_is_virtual)
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_shipping_methods)))) {
		return (this.Class_WC_Payment_Gateway.is_available()).to_bool()
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_method := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(var_shipping_method)
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_method_id' }])])
			&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
			key: none
			val: var_shipping_method
		}, rt.ArrayItem{ key: none, val: 'get_instance_id' }])]) {
			(rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{})).str() + ':' +
				(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})).str()
		} else {
			rt.new_null()
		}).to_bool()
	}
	mut var_canonical_rate_ids := rt.call_function('array_unique', [
		rt.call_function('array_values', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				var_shipping_methods.clone()]),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(this.get_matching_rates(var_canonical_rate_ids.clone()).array_count()))))) {
		return false
	}
	return (this.Class_WC_Payment_Gateway.is_available()).to_bool()
}

fn (mut this Class_WC_Gateway_COD) is_accessing_settings() bool {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wc_admin_settings_page',
			[]rt.PhpVal{})))))
		{
			return false
		}
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('tab')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('checkout'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('tab')))))) {
			return false
		}
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('section')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Gateway_COD.id(), rt.get_superglobal('_REQUEST').array_get(rt.new_string('section')))))) {
			return false
		}
		return true
	}
	mut iife_temp_8 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_8 := iife_temp_8.is_true(rt.new_string('REST_REQUEST'))
	if rt.is_true(iife_result_8) {
		if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('rest_route'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('rest_route')), rt.new_string('/payment_gateways')]))))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Gateway_COD) load_shipping_method_options() rt.PhpVal {
	if !(this.is_accessing_settings()) {
		return rt.new_array()
	}
	mut iife_temp_9 := Class_WC_Data_Store{}
	mut iife_result_9 := iife_temp_9.load(rt.new_string('shipping-zone'))
	mut var_data_store := iife_result_9
	mut var_raw_zones := rt.call_method(var_data_store, 'get_zones', []rt.PhpVal{})
	mut var_zones := rt.new_array()
	mut iter_1 := var_raw_zones.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_raw_zone := item_1.val
		var_zones << create_wc_shipping_zone(var_raw_zone.clone())
	}
	var_zones << create_wc_shipping_zone(rt.new_int(0))
	mut var_options := rt.new_array()
	mut iter_2 := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
		[]rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		var_options.array_set(rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}),
			rt.new_array())
		var_options.array_get_mut(rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})).array_set(rt.get_property(var_method,
			'id'), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Any &quot;%1$s&quot; method'),
				rt.new_string('woocommerce')]),
			rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}),
		]))
		for var_zone in var_zones {
			mut var_shipping_method_instances := rt.call_method(var_zone, 'get_shipping_methods',
				[]rt.PhpVal{})
			mut iter_3 := var_shipping_method_instances.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_shipping_method_instance := item_3.val
				mut var_shipping_method_instance_id := item_3.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_shipping_method_instance,
					'id'), rt.get_property(var_method, 'id')))))
				{
					continue
				}
				mut var_option_id := rt.call_method(var_shipping_method_instance, 'get_rate_id',
					[]rt.PhpVal{})
				mut var_option_instance_title := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (#%2$s)'),
						rt.new_string('woocommerce')]),
					rt.call_method(var_shipping_method_instance, 'get_title', []rt.PhpVal{}),
					var_shipping_method_instance_id.clone(),
				])
				mut var_option_title := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s &ndash; %2$s'),
						rt.new_string('woocommerce')]),
					if rt.is_true(rt.call_method(var_zone, 'get_id', []rt.PhpVal{})) { rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) } else { rt.call_function('__', [
							rt.new_string('Other locations'),
							rt.new_string('woocommerce')]) },
					var_option_instance_title.clone(),
				])
				var_options.array_get_mut(rt.call_method(var_method, 'get_method_title',
					[]rt.PhpVal{})).array_set(var_option_id, var_option_title.clone())
			}
		}
	}
	return var_options.clone()
}

fn (mut this Class_WC_Gateway_COD) get_matching_rates(var_rate_ids rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_unique', [
		rt.call_function('array_merge', [
			rt.call_function('array_intersect', [this.enable_for_methods, var_rate_ids.clone()]),
			rt.call_function('array_intersect', [this.enable_for_methods,
				rt.call_function('array_unique', [
					rt.call_function('array_map', [
						rt.new_string('wc_get_string_before_colon'),
						var_rate_ids.clone(),
					]),
				])]),
		]),
	])
}

fn (mut this Class_WC_Gateway_COD) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.greater(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.new_int(0))) {
		mut var_process_payment_status := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cod_process_payment_order_status'),
			if rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{})) {
				Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
			} else {
				Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			var_order.clone(),
		])
		rt.call_method(var_order, 'update_status', [var_process_payment_status.clone(),
			rt.call_function('__', [rt.new_string('Payment to be made upon delivery.'),
				rt.new_string('woocommerce')])])
	} else {
		rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart',
		[]rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'result', val: 'success' },
		rt.ArrayItem{ key: 'redirect', val: this.get_return_url(var_order.clone()) }])
}

fn (mut this Class_WC_Gateway_COD) thankyou_page() {
	if rt.is_true(this.instructions) {
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [this.instructions]),
			]),
		]))
	}
}

fn (mut this Class_WC_Gateway_COD) change_payment_complete_order_status(var_status rt.PhpVal, order_id i64, order bool) rt.PhpVal {
	mut var_status_mutated := var_status
	mut order_mutated := order
	if rt.is_true(rt.new_bool(order_mutated))
		&& rt.is_true(rt.identical(Class_WC_Gateway_COD.id(), rt.call_method(rt.new_bool(order_mutated), 'get_payment_method', []rt.PhpVal{}))) {
		var_status_mutated = Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
	}
	return var_status_mutated.clone()
}

fn (mut this Class_WC_Gateway_COD) email_instructions(var_order rt.PhpVal, var_sent_to_admin rt.PhpVal, plain_text bool) {
	mut var_order_mutated := var_order
	if rt.is_true(this.instructions) && rt.is_true(rt.new_bool(!(rt.is_true(var_sent_to_admin))))
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WC_Gateway_COD', ['WC_Payment_Gateway'], &this), 'id'), rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{}))) {
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.new_string(
				(rt.call_function('wpautop', [rt.call_function('wptexturize', [this.instructions])])).str() +
				(rt.get_constant('PHP_EOL')).str()),
		]))
	}
}

fn (mut this Class_WC_Gateway_COD) get_settings_url() rt.PhpVal {
	mut var_payments_settings_page := rt.new_null()
	mut iife_temp_10 := Class_WC_Admin_Settings{}
	mut iife_result_10 := iife_temp_10.get_settings_pages()
	mut iter_4 := iife_result_10.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_settings_page := item_4.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_settings_page, 'WC_Settings_Payment_Gateways'))) {
			var_payments_settings_page = var_settings_page
			break
		}
	}
	if !rt.is_true(var_payments_settings_page) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_11 := iife_temp_11.wc_payments_settings_url(rt.new_string('/' +
			(Class_WC_Settings_Payment_Gateways.offline_section_name()).str() + '/' +(rt.get_property(rt.new_object('WC_Gateway_COD', ['WC_Payment_Gateway'], &this), 'id')).str()))
		return iife_result_11
	}
	mut var_should_use_react_settings_page := rt.call_method(var_payments_settings_page,
		'should_render_react_section', [
		Class_WC_Settings_Payment_Gateways.cod_section_name(),
	])
	mut iife_temp_12 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_12 := iife_temp_12.wc_payments_settings_url(if rt.is_true(var_should_use_react_settings_page) {
		'/' +(Class_WC_Settings_Payment_Gateways.offline_section_name()).str() + '/' +(rt.get_property(rt.new_object('WC_Gateway_COD', ['WC_Payment_Gateway'], &this), 'id')).str()
	} else {
		rt.new_null()
	}, if rt.is_true(var_should_use_react_settings_page) { rt.new_array() } else { rt.create_array([
			rt.ArrayItem{ key: 'section', val: rt.get_property(rt.new_object('WC_Gateway_COD', [
				'WC_Payment_Gateway',
			], &this), 'id') },
		]) })
	return iife_result_12
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

fn create_wc_gateway_cod() &Class_WC_Gateway_COD {
	mut obj := &Class_WC_Gateway_COD{
		PhpObjectBase:      rt.PhpObjectBase{}
		instructions:       rt.new_null()
		enable_for_methods: rt.new_null()
		enable_for_virtual: false
	}
	obj.construct()
	return obj
}

fn create_wc_payment_gateway(_args ...rt.PhpVal) &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone(_args ...rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_COD) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'setup_properties' {
			this.setup_properties()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'is_available' {
			return rt.new_bool(this.is_available())
		}
		'is_accessing_settings' {
			return rt.new_bool(this.is_accessing_settings())
		}
		'load_shipping_method_options' {
			return this.load_shipping_method_options()
		}
		'get_matching_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_matching_rates(dispatch_arg_0)
		}
		'process_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_payment(dispatch_arg_0)
		}
		'thankyou_page' {
			this.thankyou_page()
			return rt.new_null()
		}
		'change_payment_complete_order_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.change_payment_complete_order_status(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'email_instructions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_instructions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_settings_url' {
			return this.get_settings_url()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_COD) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instructions' { return this.instructions }
		'enable_for_methods' { return this.enable_for_methods }
		'enable_for_virtual' { return rt.new_bool(this.enable_for_virtual) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_COD) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instructions' {
			this.instructions = val
			return true
		}
		'enable_for_methods' {
			this.enable_for_methods = val
			return true
		}
		'enable_for_virtual' {
			this.enable_for_virtual = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
