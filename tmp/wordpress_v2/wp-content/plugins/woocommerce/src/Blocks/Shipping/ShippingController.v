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

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) {
	this.asset_api = var_asset_api
	this.asset_data_registry = var_asset_data_registry
	mut iife_temp_0 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_0 := iife_temp_0.is_local_pickup_enabled()
	this.local_pickup_enabled = iife_result_0
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) init() {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return
			}
		rt.call_method(this.asset_data_registry, 'add', [rt.new_string('countryStates'), rt.new_closure(closure_2_fn)])
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
		return var_return_value.clone()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_2 := iife_temp_2.select(rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}), rt.new_string('get_method_id'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut var_shipping_method_ids := iife_result_2
	mut var_shipping_method_id := rt.call_function('current', [var_shipping_method_ids.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('pickup_location'), var_shipping_method_id)))) {
		return var_return_value.clone()
	}
	mut var_shipping_method := rt.call_function('current', [rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})])
	mut var_details := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_details')])
	mut var_location := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_location')])
	mut var_address := rt.call_method(var_shipping_method, 'get_meta', [rt.new_string('pickup_address')])
	mut var_cost := rt.call_method(var_shipping_method, 'get_total', []rt.PhpVal{})
	mut var_lines := rt.new_array()
	if rt.is_true(var_location) {
		var_lines.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Collection from <strong>%s</strong>:'), rt.new_string('woocommerce')]), var_location.clone()]))
	}
	if rt.is_true(var_address) {
		var_lines.array_push(rt.call_function('nl2br', [rt.call_function('esc_html', [rt.call_function('str_replace', [rt.new_string(','), rt.new_string(', '), var_address.clone()])])]))
	}
	if rt.is_true(var_details) {
		var_lines.array_push(rt.call_function('wp_kses_post', [var_details.clone()]))
	}
	if rt.is_true(rt.greater(var_cost, rt.new_int(0))) {
		mut var_tax_display := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')])
		mut var_tax := rt.call_method(var_shipping_method, 'get_total_tax', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('excl'), var_tax_display)) {
			mut var_formatted_cost := rt.call_function('wc_price', [var_cost.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])
			if rt.new_float((var_tax).to_f64()) > 0 && rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{})) {
				var_formatted_cost = rt.concat(var_formatted_cost, rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display_tax_label'), rt.new_string('&nbsp;<small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() + '</small>'), var_order.clone(), var_tax_display.clone()]))
			}
		} else {
			var_formatted_cost = rt.call_function('wc_price', [rt.new_float((var_cost).to_f64()) + rt.new_float((var_tax).to_f64()), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])
			if rt.new_float((var_tax).to_f64()) > 0 && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{}))))) {
				var_formatted_cost = rt.concat(var_formatted_cost, rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display_tax_label'), rt.new_string('&nbsp;<small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() + '</small>'), var_order.clone(), var_tax_display.clone()]))
			}
		}
		var_lines.array_push('<br>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Pickup cost: %s'), rt.new_string('woocommerce')]), var_formatted_cost.clone()])).str())
	}
	if !rt.is_true(var_lines) {
		return var_return_value.clone()
	}
	return rt.call_function('implode', [rt.new_string('<br>'), var_lines.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) remove_shipping_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_3 := iife_temp_3.is_cart_block_default()
	if rt.is_true(iife_result_3) {
		mut iter_1 := var_settings_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_shipping_calc'), var_setting.array_get(rt.new_string('id')))) {
				var_settings_mutated.array_get_mut(var_index).array_set('desc_tip', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This feature is not available when using the <a href="%s">Cart and checkout blocks</a>. Shipping will be calculated at checkout.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/woocommerce-store-editing/customizing-cart-and-checkout/')]))
				var_settings_mutated.array_get_mut(var_index).array_set('disabled', true)
				var_settings_mutated.array_get_mut(var_index).array_set('value', 'no')
				break
			}
		}
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_settings() {
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_pickup_location_settings'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: 'WooCommerce Local Pickup Method Settings' }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'pickup_location_settings' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If enabled, this method will appear on the block based checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This controls the title which the user sees during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If a cost is defined, this controls if taxes are applied to that cost.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]) }]) }, rt.ArrayItem{ key: 'cost', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional cost to charge for local pickup.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }])])
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('pickup_location_pickup_locations'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: 'WooCommerce Local Pickup Locations' }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'pickup_locations' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'address', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'details', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) hydrate_client_settings() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.new_string('enqueued')]))))) {
		return
	}
	mut var_locations := rt.call_function('get_option', [rt.new_string('pickup_location_pickup_locations'), rt.new_array()])
	mut var_formatted_pickup_locations := rt.new_array()
	mut iter_2 := var_locations.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_location := item_2.val
		var_formatted_pickup_locations.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_location.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'address', val: var_location.array_get(rt.new_string('address')) }, rt.ArrayItem{ key: 'details', val: var_location.array_get(rt.new_string('details')) }, rt.ArrayItem{ key: 'enabled', val: rt.call_function('wc_string_to_bool', [var_location.array_get(rt.new_string('enabled'))]) }]))
	}
	mut var_has_legacy_pickup := rt.new_bool(false)
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{}
	mut iife_result_4 := iife_temp_4.get_zones(rt.new_string('admin'))
	mut var_shipping_zones := iife_result_4
	mut var_international_shipping_zone := create_automattic_woocommerce_blocks_shipping_wc_shipping_zone(rt.new_int(0))
	mut iter_3 := var_shipping_zones.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_shipping_zone := item_3.val
		mut var_shipping_methods := var_shipping_zone.array_get(rt.new_string('shipping_methods'))
		mut iter_4 := var_shipping_methods.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_shipping_method := item_4.val
			if rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_shipping_method, 'id'))) && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_shipping_method, 'enabled'))) {
				var_has_legacy_pickup = rt.new_bool(true)
				break
			}
		}
	}
	mut iter_5 := var_international_shipping_zone.get_shipping_methods(rt.new_bool(true)).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_shipping_method := item_5.val
		if rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_shipping_method, 'id'))) {
			var_has_legacy_pickup = rt.new_bool(true)
			break
		}
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_5 := iife_temp_5.get_local_pickup_settings()
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'pickupLocationSettings', val: iife_result_5 }, rt.ArrayItem{ key: 'pickupLocations', val: var_formatted_pickup_locations }, rt.ArrayItem{ key: 'readonlySettings', val: rt.create_array([rt.ArrayItem{ key: 'hasLegacyPickup', val: var_has_legacy_pickup }, rt.ArrayItem{ key: 'storeCountry', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'storeState', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) }]) }])
	rt.call_function('wp_add_inline_script', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.call_function('sprintf', [rt.new_string('var hydratedScreenSettings = %s;'), rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('before')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) admin_scripts() {
	rt.call_method(this.asset_api, 'register_script', [Class_Automattic_WooCommerce_Blocks_Shipping_Automattic_WooCommerce_Blocks_Shipping_ShippingController.local_pickup_admin_js_handle(), rt.new_string('assets/client/blocks/wc-shipping-method-pickup-location.js'), rt.new_array(), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_local_pickup() {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_6 := iife_temp_6.is_checkout_block_default()
	if rt.is_true(iife_result_6) {
		mut var_wc_instance := rt.call_function('WC', []rt.PhpVal{})
		if var_wc_instance.clone().is_object() && rt.is_true(rt.call_function('method_exists', [var_wc_instance.clone(), rt.new_string('shipping')])) && rt.get_property(var_wc_instance, 'shipping').is_object() && rt.is_true(rt.call_function('method_exists', [rt.get_property(var_wc_instance, 'shipping'), rt.new_string('register_shipping_method')])) {
			rt.call_method(rt.get_property(var_wc_instance, 'shipping'), 'register_shipping_method', [create_automattic_woocommerce_blocks_shipping_pickuplocation()])
		} else {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Error registering pickup location: WC()->shipping->register_shipping_method is not available'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'shipping-controller' }])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) register_local_pickup_method(var_methods rt.PhpVal) rt.PhpVal {
	mut var_methods_mutated := var_methods
	var_methods_mutated.array_push('pickup_location')
	return var_methods_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) hide_shipping_address_for_local_pickup(var_pickup_methods rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_7 := iife_temp_7.get_local_pickup_method_ids()
	return rt.call_function('array_merge', [var_pickup_methods.clone(), iife_result_7])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) flush_cache(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper{}
	mut iife_result_8 := iife_temp_8.get_transient_version(rt.new_string('shipping'), rt.new_bool(true))
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) filter_taxable_address(var_address rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
	if rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))) {
		return var_address_mutated.clone()
	}
	mut var_chosen_method := if !(rt.call_function('current', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])])).is_null() { rt.call_function('current', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods'), rt.new_array()])]) } else { rt.new_string('') }
	mut var_chosen_method_id := rt.call_function('explode', [rt.new_string(':'), var_chosen_method.clone()]).array_get(rt.new_int(0))
	mut var_chosen_method_instance := if !(rt.call_function('explode', [rt.new_string(':'), var_chosen_method.clone()]).array_get(rt.new_int(1))).is_null() { rt.call_function('explode', [rt.new_string(':'), var_chosen_method.clone()]).array_get(rt.new_int(1)) } else { rt.new_int(0) }
	mut iife_temp_9 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
	mut iife_result_9 := iife_temp_9.get_local_pickup_method_ids()
	if rt.is_true(var_chosen_method_id) && rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_base_tax_for_local_pickup'), rt.new_bool(true)]))) && rt.is_true(rt.call_function('in_array', [var_chosen_method_id.clone(), iife_result_9, rt.new_bool(true)])) {
		mut var_pickup_locations := rt.call_function('get_option', [rt.new_string('pickup_location_pickup_locations'), rt.new_array()])
		mut var_pickup_location := if !(var_pickup_locations.array_get(var_chosen_method_instance)).is_null() { var_pickup_locations.array_get(var_chosen_method_instance) } else { rt.new_array() }
		if var_pickup_location.array_isset(rt.new_string('address')) && var_pickup_location.array_get(rt.new_string('address')).array_isset(rt.new_string('country')) && !(!rt.is_true(var_pickup_location.array_get(rt.new_string('address')).array_get(rt.new_string('country')))) {
		var_address_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_pickup_locations.array_get(var_chosen_method_instance).array_get(rt.new_string('address')).array_get(rt.new_string('country')) }, rt.ArrayItem{ key: none, val: var_pickup_locations.array_get(var_chosen_method_instance).array_get(rt.new_string('address')).array_get(rt.new_string('state')) }, rt.ArrayItem{ key: none, val: var_pickup_locations.array_get(var_chosen_method_instance).array_get(rt.new_string('address')).array_get(rt.new_string('postcode')) }, rt.ArrayItem{ key: none, val: var_pickup_locations.array_get(var_chosen_method_instance).array_get(rt.new_string('address')).array_get(rt.new_string('city')) }])
		}
	}
	return var_address_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) filter_shipping_packages(var_packages rt.PhpVal) rt.PhpVal {
	mut var_packages_mutated := var_packages
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_11 := iife_temp_11.select(if !(var_package.array_get(rt.new_string('rates'))).is_null() { var_package.array_get(rt.new_string('rates')) } else { rt.new_array() }, rt.new_string('get_method_id'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
		mut var_shipping_method_ids := iife_result_11
		mut iife_temp_12 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_12 := iife_temp_12.get_local_pickup_method_ids()
		mut iife_temp_13 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_13 := iife_temp_13.get_local_pickup_method_ids()
		return rt.new_bool(!(!rt.is_true(rt.call_function('array_intersect', [iife_result_12, var_shipping_method_ids.clone()]))))
		}
	mut var_valid_packages := rt.call_function('array_filter', [var_packages_mutated.clone(), rt.new_closure(closure_14_fn)])
	if rt.is_true(rt.new_bool(var_valid_packages.clone().array_count() != var_packages_mutated.clone().array_count())) {
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_package.array_get(rt.new_string('rates')).is_array()) {
			var_package.array_set('rates', rt.new_array())
			return var_package.clone()
		}
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_rate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iife_temp_16 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
			mut iife_result_16 := iife_temp_16.get_local_pickup_method_ids()
			return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}), iife_result_16, rt.new_bool(true)]))))
			}
		var_package.array_set('rates', rt.call_function('array_filter', [var_package.array_get(rt.new_string('rates')), rt.new_closure(closure_17_fn)]))
		return var_package.clone()
		}
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_package.array_get(rt.new_string('rates')).is_array()) {
			var_package.array_set('rates', rt.new_array())
			return var_package.clone()
		}
		closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_rate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iife_temp_19 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
			mut iife_result_19 := iife_temp_19.get_local_pickup_method_ids()
			return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}), iife_result_19, rt.new_bool(true)]))))
			}
		var_package.array_set('rates', rt.call_function('array_filter', [var_package.array_get(rt.new_string('rates')), rt.new_closure(closure_20_fn)]))
		return var_package.clone()
		}
	var_packages_mutated = rt.call_function('array_map', [rt.new_closure(closure_17_fn), var_packages_mutated.clone()])
	}
	return var_packages_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) remove_shipping_if_no_address(var_packages rt.PhpVal) rt.PhpVal {
	mut var_packages_mutated := var_packages
	if rt.is_true(rt.identical(rt.new_string('shortcode'), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'cart_context'))) {
		return var_packages_mutated.clone()
	}
	mut var_shipping_cost_requires_address := rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_shipping_cost_requires_address'), rt.new_string('no')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shipping_cost_requires_address)))) {
		return var_packages_mutated.clone()
	}
	mut var_customer := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	if rt.is_true(rt.new_bool(rt.instance_of(var_customer, 'WC_Customer'))) && rt.is_true(rt.call_method(var_customer, 'has_full_shipping_address', []rt.PhpVal{})) {
		return var_packages_mutated.clone()
	}
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_rate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iife_temp_22 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
			mut iife_result_22 := iife_temp_22.get_local_pickup_method_ids()
			return rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_rate, 'WC_Shipping_Rate'))) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}), iife_result_22, rt.new_bool(true)])))
			}
		var_package.array_set('rates', rt.call_function('array_filter', [var_package.array_get(rt.new_string('rates')), rt.new_closure(closure_23_fn)]))
		return var_package.clone()
		}
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_rate := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iife_temp_25 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
			mut iife_result_25 := iife_temp_25.get_local_pickup_method_ids()
			return rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_rate, 'WC_Shipping_Rate'))) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_rate, 'get_method_id', []rt.PhpVal{}), iife_result_25, rt.new_bool(true)])))
			}
		var_package.array_set('rates', rt.call_function('array_filter', [var_package.array_get(rt.new_string('rates')), rt.new_closure(closure_26_fn)]))
		return var_package.clone()
		}
	return rt.call_function('array_map', [rt.new_closure(closure_23_fn), var_packages_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) track_local_pickup(var_served rt.PhpVal, var_result rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/wp/v2/settings'), rt.call_method(var_request, 'get_route', []rt.PhpVal{}))))) {
		return var_served.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('pickup_location_settings')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('pickup_locations')]))))) {
		return var_served.clone()
	}
	mut var_event_name := rt.new_string('local_pickup_save_changes')
	mut var_settings := rt.call_method(var_request, 'get_param', [rt.new_string('pickup_location_settings')])
	mut var_locations := rt.call_method(var_request, 'get_param', [rt.new_string('pickup_locations')])
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_location.array_get(rt.new_string('enabled'))
		}
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_location := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_location.array_get(rt.new_string('enabled'))
		}
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'local_pickup_enabled', val: if rt.is_true(rt.identical(rt.new_string('yes'), var_settings.array_get(rt.new_string('enabled')))) { true } else { false } }, rt.ArrayItem{ key: 'title', val: rt.identical(rt.call_function('__', [rt.new_string('Pickup'), rt.new_string('woocommerce')]), var_settings.array_get(rt.new_string('title'))) }, rt.ArrayItem{ key: 'price', val: if rt.is_true(rt.identical(rt.new_string(''), var_settings.array_get(rt.new_string('cost')))) { true } else { false } }, rt.ArrayItem{ key: 'cost', val: if rt.is_true(rt.identical(rt.new_string(''), var_settings.array_get(rt.new_string('cost')))) { rt.new_int(0) } else { var_settings.array_get(rt.new_string('cost')) } }, rt.ArrayItem{ key: 'taxes', val: var_settings.array_get(rt.new_string('tax_status')) }, rt.ArrayItem{ key: 'total_pickup_locations', val: var_locations.clone().array_count() }, rt.ArrayItem{ key: 'pickup_locations_enabled', val: rt.call_function('array_filter', [var_locations.clone(), rt.new_closure(closure_27_fn)]).array_count() }])
	mut iife_temp_28 := Class_WC_Tracks{}
	mut iife_result_28 := iife_temp_28.record_event(var_event_name.clone(), var_data.clone())
	return var_served.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController.is_legacy_local_pickup_active() bool {
	mut iife_temp_29 := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{}
	mut iife_result_29 := iife_temp_29.get_zone_by(rt.new_string('zone_id'), rt.new_int(0))
	mut var_rest_of_the_world := iife_result_29
	mut iife_temp_30 := Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{}
	mut iife_result_30 := iife_temp_30.get_zones()
	mut var_shipping_zones := iife_result_30
	mut var_rest_of_the_world_data := rt.call_method(var_rest_of_the_world, 'get_data', []rt.PhpVal{})
	var_rest_of_the_world_data.array_set('shipping_methods', rt.call_method(var_rest_of_the_world, 'get_shipping_methods', []rt.PhpVal{}))
	rt.call_function('array_unshift', [var_shipping_zones.clone(), var_rest_of_the_world_data.clone()])
	mut iter_6 := var_shipping_zones.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_zone := item_6.val
		mut iter_7 := var_zone.array_get(rt.new_string('shipping_methods')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_method := item_7.val
			if rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_method, 'id'))) && rt.is_true(rt.call_method(var_method, 'is_enabled', []rt.PhpVal{})) {
				return true
			}
		}
	}
	return false
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

struct Class_WC_Tracks {
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

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_shipping_zones(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_shipping_zone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_pickuplocation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_PickupLocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_wc_cache_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
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


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
