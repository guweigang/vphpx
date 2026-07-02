import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema.identifier() string {
	return 'cart-shipping-rate'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('cart-shipping-rate')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'package_id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The ID of the package the shipping rates belong to.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'integer' },
				rt.ArrayItem{ key: none, val: 'string' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Name of the package.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'destination', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Shipping destination address.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'address_1', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('First line of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'address_2', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Second line of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'city', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('City of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'state', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code, or name, for the state, province, or district of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'postcode', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Zip or Postcode of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'country', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('ISO code for the country of the address being shipped to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of cart items the returned shipping rates apply to.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Unique identifier for the item within the cart.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Name of the item.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'quantity', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Quantity of the item in the current package.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'number' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping_rates', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of shipping rates.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: this.get_rate_properties() },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_rate_properties() rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: 'rate_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('ID of the shipping rate.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Name of the shipping rate, e.g. Express shipping.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of the shipping rate, e.g. Dispatched via USPS.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'delivery_time', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Delivery time estimate text, e.g. 3-5 business days.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'price', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Price of this shipping rate using the smallest unit of the currency.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'taxes', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Taxes applied to this shipping rate using the smallest unit of the currency.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'method_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('ID of the shipping method that provided the rate.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'instance_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Instance ID of the shipping method that provided the rate.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'meta_data', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Meta data attached to the shipping rate.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'key', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Meta key.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'value', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Meta value.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'context', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'view' },
								rt.ArrayItem{ key: none, val: 'edit' },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'selected', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('True if this is the rate currently selected by the customer for the cart.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]),
		this.get_store_currency_properties(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_item_response(var_package rt.PhpVal) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'package_id', val: var_package.array_get(rt.new_string('package_id')) },
		rt.ArrayItem{ key: 'name', val: var_package.array_get(rt.new_string('package_name')) },
		rt.ArrayItem{
			key: 'destination'
			val: this.prepare_package_destination_response(var_package.clone())
		},
		rt.ArrayItem{ key: 'items', val: this.prepare_package_items_response(var_package.clone()) },
		rt.ArrayItem{
			key: 'shipping_rates'
			val: this.prepare_package_shipping_rates_response(var_package.clone())
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) prepare_package_destination_response(var_package rt.PhpVal) rt.PhpVal {
	mut var_address := if var_package.array_get(rt.new_string('destination')).array_isset(rt.new_string('address_1')) {
		var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('address_1'))
	} else {
		var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('address'))
	}
	return mut rt.array_to_object(this.prepare_html_response(rt.create_array([
		rt.ArrayItem{ key: 'address_1', val: var_address },
		rt.ArrayItem{
			key: 'address_2'
			val: var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('address_2'))
		},
		rt.ArrayItem{
			key: 'city'
			val: var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('city'))
		},
		rt.ArrayItem{
			key: 'state'
			val: var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('state'))
		},
		rt.ArrayItem{
			key: 'postcode'
			val: var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('postcode'))
		},
		rt.ArrayItem{
			key: 'country'
			val: var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country'))
		},
	])))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) prepare_package_items_response(var_package rt.PhpVal) rt.PhpVal {
	mut var_items := rt.new_array()
	mut iter_1 := var_package.array_get(rt.new_string('contents')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_values := item_1.val
		var_items.array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: var_values.array_get(rt.new_string('key')) },
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_values.array_get(rt.new_string('data')),
				'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'quantity', val: var_values.array_get(rt.new_string('quantity')) },
		]))
	}
	return var_items.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) prepare_package_shipping_rates_response(var_package rt.PhpVal) rt.PhpVal {
	mut var_rates := var_package.array_get(rt.new_string('rates'))
	mut var_selected_rates := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'session'), 'get', [rt.new_string('chosen_shipping_methods'),
		rt.new_array()])
	mut var_selected_rate := if var_selected_rates.array_isset(var_package.array_get(rt.new_string('package_id'))) {
		var_selected_rates.array_get(var_package.array_get(rt.new_string('package_id')))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_selected_rate)
		&& !(!rt.is_true(var_package.array_get(rt.new_string('rates')))) {
		var_selected_rate = rt.call_function('wc_get_chosen_shipping_method_for_package', [
			var_package.array_get(rt.new_string('package_id')),
			var_package.clone(),
		])
	}
	mut var_response := rt.new_array()
	mut iter_2 := var_package.array_get(rt.new_string('rates')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rate := item_2.val
		var_response.array_push(this.get_rate_response(var_rate.clone(), var_selected_rate.str()))
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_rate_response(var_rate rt.PhpVal, selected_rate string) rt.PhpVal {
	mut selected_rate_mutated := selected_rate
	return this.prepare_currency_response(rt.create_array([
		rt.ArrayItem{ key: 'rate_id', val: this.get_rate_prop(var_rate.clone(), rt.new_string('id')) },
		rt.ArrayItem{ key: 'name', val: this.prepare_html_response(this.get_rate_prop(var_rate.clone(),
			rt.new_string('label'))) },
		rt.ArrayItem{ key: 'description', val: this.prepare_html_response(this.get_rate_prop(var_rate.clone(),
			rt.new_string('description'))) },
		rt.ArrayItem{ key: 'delivery_time', val: this.prepare_html_response(this.get_rate_prop(var_rate.clone(),
			rt.new_string('delivery_time'))) },
		rt.ArrayItem{ key: 'price', val: this.prepare_money_response(this.get_rate_prop(var_rate.clone(),
			rt.new_string('cost')), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'taxes', val: this.prepare_money_response(rt.call_function('array_sum', [
			rt.cast_array(this.get_rate_prop(var_rate.clone(), rt.new_string('taxes'))),
		]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'instance_id', val: this.get_rate_prop(var_rate.clone(),
			rt.new_string('instance_id')) },
		rt.ArrayItem{ key: 'method_id', val: this.get_rate_prop(var_rate.clone(),
			rt.new_string('method_id')) },
		rt.ArrayItem{ key: 'meta_data', val: this.get_rate_meta_data(var_rate.clone()) },
		rt.ArrayItem{ key: 'selected', val: rt.identical(rt.new_string(selected_rate_mutated), this.get_rate_prop(var_rate.clone(),
			rt.new_string('id'))) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_rate_prop(var_rate rt.PhpVal, var_prop rt.PhpVal) rt.PhpVal {
	mut var_getter := rt.new_string('get_' + var_prop.str())
	return if rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_rate },
			rt.ArrayItem{ key: none, val: var_getter }]),
	])
	{ rt.call_method(var_rate, var_getter, []rt.PhpVal{}) } else { rt.new_string('') }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) get_rate_meta_data(var_rate rt.PhpVal) rt.PhpVal {
	mut var_meta_data := rt.call_method(var_rate, 'get_meta_data', []rt.PhpVal{})
	closure_1_fn := fn [var_meta_data] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_return := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_key := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_return.array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: var_key },
			rt.ArrayItem{ key: 'value', val: var_meta_data.array_get(var_key) }]))
		return var_return.clone()
	}
	return rt.call_function('array_reduce', [rt.func_array_keys(var_meta_data.clone()),
		rt.new_closure(closure_1_fn), rt.new_array()])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_cartshippingrateschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('cart-shipping-rate')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_rate_properties' {
			return this.get_rate_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'prepare_package_destination_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_package_destination_response(dispatch_arg_0)
		}
		'prepare_package_items_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_package_items_response(dispatch_arg_0)
		}
		'prepare_package_shipping_rates_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_package_shipping_rates_response(dispatch_arg_0)
		}
		'get_rate_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_rate_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_rate_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_rate_prop(dispatch_arg_0, dispatch_arg_1)
		}
		'get_rate_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rate_meta_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_CartShippingRateSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
