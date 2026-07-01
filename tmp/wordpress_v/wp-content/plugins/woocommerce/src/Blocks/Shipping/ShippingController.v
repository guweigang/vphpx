import rt

pub fn Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle() string {
	return 'wc-shipping-method-pickup-location'
}
struct Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	rt.PhpObjectBase
pub mut:
		asset_api rt.PhpVal = rt.new_null()
		asset_data_registry rt.PhpVal = rt.new_null()
		local_pickup_enabled rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry)  {
	this.asset_api = var_asset_api.dup()
	this.asset_data_registry = var_asset_data_registry.dup()
	this.local_pickup_enabled = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.is_local_pickup_enabled() }()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) init()  {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', []rt.PhpVal{})
	}
		rt.call_method(this.asset_data_registry, 'add', [rt.new_string('countryStates'), rt.new_closure(closure_1_fn)])
	}
	rt.call_method(this.asset_data_registry, 'add', [rt.new_string('shippingCostRequiresAddress'), rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_shipping_cost_requires_address'), rt.new_bool(false)]), rt.new_string('yes'))])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_settings' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hydrate_client_settings' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_load_shipping_methods'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_local_pickup' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_local_pickup_methods'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_local_pickup_method' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_hide_shipping_address'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hide_shipping_address_for_local_pickup' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_customer_taxable_address'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_taxable_address' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_shipping_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_shipping_settings' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_shipping_packages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_shipping_packages' }])])
	rt.call_function('add_filter', [rt.new_string('pre_update_option_woocommerce_pickup_location_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'flush_cache' }])])
	rt.call_function('add_filter', [rt.new_string('pre_update_option_pickup_location_pickup_locations'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'flush_cache' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_shipping_packages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_shipping_if_no_address' }]), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_shipping_to_display'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'show_local_pickup_details' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('rest_pre_serve_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Shipping_ShippingController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_local_pickup' }]), rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) show_local_pickup_details(var_return_value rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Blocks_Shipping_WC_Order')))))) {
		return var_return_value.dup()
	}
	mut var_shipping_method_ids := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.select(arg_0, arg_1, arg_2) }(rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}), rt.new_string('get_method_id'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut var_shipping_method_id := rt.call_function('current', [var_shipping_method_ids.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_return_value.dup()
	}
	mut var_shipping_method := rt.call_function('current', [rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})])
	mut var_details := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_details')])
	mut var_location := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_location')])
	mut var_address := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_address')])
	mut var_cost := rt.call_method(var_shipping_method, 'get_total', []rt.PhpVal{})
	mut var_lines := rt.new_array()
	if rt.is_true(var_location) {
		var_lines.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Collection from <strong>%s</strong>:'), rt.new_string('woocommerce')]), var_location.dup()]))
	}
	if rt.is_true(var_address) {
		var_lines.array_push(rt.call_function('nl2br', [rt.call_function('esc_html', [rt.call_function('str_replace', [rt.new_string(','), rt.new_string(', '), var_address.dup()])])]))
	}
	if rt.is_true(var_details) {
		var_lines.array_push(rt.call_function('wp_kses_post', [var_details.dup()]))
	}
	if rt.is_true(rt.greater(var_cost, rt.new_int(0))) {
		mut var_tax_display := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')])
		mut var_tax := rt.call_method(var_shipping_method, 'get_total_tax', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('excl'), var_tax_display)) {
			mut var_formatted_cost := rt.call_function('wc_price', [var_cost.dup(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Double, rt.new_int(0))) && rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{})))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else {
			var_formatted_cost = rt.call_function('wc_price', [rt.add(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Double, rt.new_int(0))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{}))))))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		var_lines.array_push('<br>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Pickup cost: %s'), rt.new_string('woocommerce')]), var_formatted_cost.dup()])).str())
	}
	if !rt.is_true(var_lines) {
		return var_return_value.dup()
	}
	return rt.call_function('implode', [rt.new_string('<br>'), var_lines.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) remove_shipping_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.is_cart_block_default() }()) {
		{
			mut iter_1 := var_settings_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_setting := item_1.val
				mut var_index := item_1.key
				if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_shipping_calc'), var_setting.array_get('id'))) {
					var_settings_mutated.array_get_mut(var_index).array_set('desc_tip', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This feature is not available when using the <a href="%s">Cart and checkout blocks</a>. Shipping will be calculated at checkout.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/woocommerce-store-editing/customizing-cart-and-checkout/')]))
					var_settings_mutated.array_get_mut(var_index).array_set('disabled', true)
					var_settings_mutated.array_get_mut(var_index).array_set('value', 'no')
					break
				}
			}
		}
	}
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_settings()  {
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_pickup_location_settings'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: 'WooCommerce Local Pickup Method Settings' }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'pickup_location_settings' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If enabled, this method will appear on the block based checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This controls the title which the user sees during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If a cost is defined, this controls if taxes are applied to that cost.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]) }]) }, rt.ArrayItem{ key: 'cost', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional cost to charge for local pickup.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }])])
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('pickup_location_pickup_locations'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: 'WooCommerce Local Pickup Locations' }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'pickup_locations' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'address', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'details', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) hydrate_client_settings()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.new_string('enqueued')]))))) {
		return rt.new_null()
	}
	mut var_locations := rt.call_function('get_option', [rt.new_string('pickup_location_pickup_locations'), rt.new_array()])
	mut var_formatted_pickup_locations := rt.new_array()
	{
		mut iter_1 := var_locations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_location := item_1.val
			var_formatted_pickup_locations.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_location.array_get('name') }, rt.ArrayItem{ key: 'address', val: var_location.array_get('address') }, rt.ArrayItem{ key: 'details', val: var_location.array_get('details') }, rt.ArrayItem{ key: 'enabled', val: rt.call_function('wc_string_to_bool', [var_location.array_get('enabled')]) }]))
		}
	}
	mut var_has_legacy_pickup := rt.new_bool(rt.new_bool(false))
	mut var_shipping_zones := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{}; return temp.get_zones(arg_0) }(rt.new_string('admin'))
	mut var_international_shipping_zone := create_automattic_woocommerce_blocks_shipping_wc_shipping_zone(rt.new_int(0))
	{
		mut iter_1 := var_shipping_zones.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_shipping_zone := item_1.val
			mut var_shipping_methods := var_shipping_zone.array_get('shipping_methods')
			{
				mut iter_2 := var_shipping_methods.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_shipping_method := item_2.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_shipping_method, 'id'))) && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_shipping_method, 'enabled'))))) {
						var_has_legacy_pickup = rt.new_bool(rt.new_bool(true))
						break
					}
				}
			}
		}
	}
	{
		mut iter_1 := var_international_shipping_zone.get_shipping_methods(rt.new_bool(true)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_shipping_method := item_1.val
			if rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_shipping_method, 'id'))) {
				var_has_legacy_pickup = rt.new_bool(rt.new_bool(true))
				break
			}
		}
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'pickupLocationSettings', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.get_local_pickup_settings() }() }, rt.ArrayItem{ key: 'pickupLocations', val: var_formatted_pickup_locations }, rt.ArrayItem{ key: 'readonlySettings', val: rt.create_array([rt.ArrayItem{ key: 'hasLegacyPickup', val: var_has_legacy_pickup }, rt.ArrayItem{ key: 'storeCountry', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'storeState', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) }]) }])
	rt.call_function('wp_add_inline_script', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.call_function('sprintf', [rt.new_string('var hydratedScreenSettings = %s;'), rt.call_function('wp_json_encode', [var_settings.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('before')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) admin_scripts()  {
	rt.call_method(this.asset_api, 'register_script', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.new_string('assets/client/blocks/wc-shipping-method-pickup-location.js'), rt.new_array(), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_local_pickup()  {
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}; return temp.is_checkout_block_default() }()) {
		mut var_wc_instance := rt.call_function('WC', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wc_instance.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wc_instance.dup(), rt.new_string('shipping')])))) && rt.is_true(rt.new_bool(rt.get_property(var_wc_instance, 'shipping').is_object())))) && rt.is_true(rt.call_function('method_exists', [rt.get_property(var_wc_instance, 'shipping'), rt.new_string('register_shipping_method')])))) {
			rt.call_method(rt.get_property(var_wc_instance, 'shipping'), 'register_shipping_method', [create_automattic_woocommerce_blocks_shipping_pickuplocation()])
		} else {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Error registering pickup location: WC()->shipping->register_shipping_method is not available'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'shipping-controller' }])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_local_pickup_method(var_methods rt.PhpVal) rt.PhpVal {
	mut var_methods_mutated := var_methods
	var_methods_mutated.array_push('pickup_location')
	return var_methods_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) hide_shipping_address_for_local_pickup(var_pickup_methods rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_pickup_methods.dup(), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.get_local_pickup_method_ids() }()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) flush_cache(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('shipping'), rt.new_bool(true))
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) filter_taxable_address(var_address rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	if rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))) {
		return var_address_mutated.dup()
	}
	mut var_chosen_method := if !(rt.call_function('current', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])])).is_null() { rt.call_function('current', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])]) } else { rt.new_string('') }
	mut var_chosen_method_id := rt.call_function('explode', [rt.new_string(':'), var_chosen_method.dup()]).array_get(0)
	mut var_chosen_method_instance := if !(rt.call_function('explode', [rt.new_string(':'), var_chosen_method.dup()]).array_get(1)).is_null() { rt.call_function('explode', [rt.new_string(':'), var_chosen_method.dup()]).array_get(1) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_chosen_method_id) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_base_tax_for_local_pickup'), rt.new_bool(true)]))))) && rt.is_true(rt.call_function('in_array', [var_chosen_method_id.dup(), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.get_local_pickup_method_ids() }(), rt.new_bool(true)])))) {
		mut var_pickup_locations := rt.call_function('get_option', [rt.new_string('pickup_location_pickup_locations'), rt.new_array()])
		mut var_pickup_location := if !(var_pickup_locations.array_get(var_chosen_method_instance)).is_null() { var_pickup_locations.array_get(var_chosen_method_instance) } else { rt.new_array() }
		if var_pickup_location.array_isset(rt.new_string('address')) && var_pickup_location.array_get('address').array_isset(rt.new_string('country')) && !(!rt.is_true(var_pickup_location.array_get('address').array_get('country'))) {
			var_address_mutated = rt.create_array([rt.ArrayItem{ key: none, val: .array_get() }, rt.ArrayItem{ key: none, val: .array_get() }, rt.ArrayItem{ key: none, val: .array_get() }, rt.ArrayItem{ key: none, val: .array_get() }])
		}
	}
	return var_address_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) filter_shipping_packages(var_packages rt.PhpVal) rt.PhpVal {
	mut var_packages_mutated := var_packages
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_package := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	}
	mut var_valid_packages := rt.call_function('array_filter', [var_packages_mutated.dup(), rt.new_closure(closure_2_fn)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_packages_mutated = 
	}
	return var_packages_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) remove_shipping_if_no_address(var_packages rt.PhpVal) rt.PhpVal {
	mut var_packages_mutated := var_packages
	if rt.is_true() {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) track_local_pickup(var_served rt.PhpVal, var_result rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.is_legacy_local_pickup_active() bool {
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_shipping_shippingcontroller(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController{
		PhpObjectBase: rt.PhpObjectBase{}
		asset_api: rt.new_null()
		asset_data_registry: rt.new_null()
		local_pickup_enabled: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils() &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils() &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_shipping_zones() &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_shipping_zone() &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_pickuplocation() &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_cache_helper() &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'show_local_pickup_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.show_local_pickup_details(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_shipping_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_shipping_settings(dispatch_arg_0)
		}
		'register_settings' {
			this.register_settings()
			return rt.new_null()
		}
		'hydrate_client_settings' {
			this.hydrate_client_settings()
			return rt.new_null()
		}
		'admin_scripts' {
			this.admin_scripts()
			return rt.new_null()
		}
		'register_local_pickup' {
			this.register_local_pickup()
			return rt.new_null()
		}
		'register_local_pickup_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_local_pickup_method(dispatch_arg_0)
		}
		'hide_shipping_address_for_local_pickup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hide_shipping_address_for_local_pickup(dispatch_arg_0)
		}
		'flush_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.flush_cache(dispatch_arg_0)
		}
		'filter_taxable_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_taxable_address(dispatch_arg_0)
		}
		'filter_shipping_packages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_shipping_packages(dispatch_arg_0)
		}
		'remove_shipping_if_no_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_shipping_if_no_address(dispatch_arg_0)
		}
		'track_local_pickup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.track_local_pickup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_legacy_local_pickup_active' {
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.is_legacy_local_pickup_active())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'asset_api' { return this.asset_api }
		'asset_data_registry' { return this.asset_data_registry }
		'local_pickup_enabled' { return this.local_pickup_enabled }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'asset_api' { this.asset_api = val; return true }
		'asset_data_registry' { this.asset_data_registry = val; return true }
		'local_pickup_enabled' { this.local_pickup_enabled = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_shipping_shippingcontroller_php() {
}
