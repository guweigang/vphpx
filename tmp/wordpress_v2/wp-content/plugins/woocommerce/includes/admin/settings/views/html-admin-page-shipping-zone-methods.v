import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_shipping_shippingcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_zone := rt.new_null()
	mut var_postcodes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_back_header', [if rt.is_true(rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{})) { rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) } else { rt.call_function('__', [
			rt.new_string('Add zone'),
			rt.new_string('woocommerce'),
		]) },
		rt.call_function('__', [
			rt.new_string('Return to shipping'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=shipping'),
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_shipping_zone_before_methods_table'),
		var_zone.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_zone,
		'get_id', []rt.PhpVal{})))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Zone name'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Give your zone a name! E.g. Local, or Worldwide.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_zone, 'get_zone_name', [rt.new_string('edit')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Zone name'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Zone regions'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("List the regions you'd like to include in your shipping zone. Customers will be matched against these regions."),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		if !rt.is_true(var_postcodes) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string('Limit to specific ZIP/postcodes'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('List 1 postcode per line'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [
			rt.call_function('implode', [rt.new_string('\n'),
				var_postcodes.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Postcodes containing wildcards (e.g. CB23*) or fully numeric ranges (e.g. <code>90210...99000</code>) are also supported. Please see the shipping zones <a href="%s" target="_blank">documentation</a> for more information.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('https://woocommerce.com/document/setting-up-shipping-zones/#section-3'),
		])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping methods'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string("Add the shipping methods you'd like to make available to customers in this zone."),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Description'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add shipping method'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping method'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_shipping_zone_after_methods_table'),
		var_zone.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Save changes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save changes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('You can add multiple shipping methods within this zone. Only customers within the zone will see them.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delete'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Set up %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('{{{ data.method.method_title.toLowerCase() }}}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
		[]rt.PhpVal{}), 'get_shipping_classes', []rt.PhpVal{}).array_count().str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=shipping&section=classes'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping class costs'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Back'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create and save'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('STEP 2 OF 2'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create shipping method'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Choose the shipping method you wish to add. Only shipping methods which support zones are listed.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_methods := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{})
	mut var_methods_placed_in_order := rt.new_array()
	mut var_first_methods_ids := ['free_shipping', 'flat_rate', 'local_pickup']
	for var_first_method_id in var_first_methods_ids {
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_obj := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.get_property(var_obj, 'id'),
				rt.new_string(first_method_id)))
			{
				var_methods_placed_in_order.array_push(var_obj.clone())
				var_methods.array_unset(var_key)
				break
			}
		}
	}
	var_methods_placed_in_order = rt.call_function('array_merge', [
		var_methods_placed_in_order.clone(), rt.call_function('array_values', [
			var_methods.clone()])])
	mut iter_2 := var_methods_placed_in_order.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
		mut iife_result_0 := iife_temp_0.is_checkout_block_default()
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController{}
		mut iife_result_1 := iife_temp_1.is_legacy_local_pickup_active()
		if rt.is_true(iife_result_0) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
			&& rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_method, 'id'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [
			rt.new_string('shipping-zones'),
		])))))
		{
			continue
		}
		print('<div class="wc-shipping-zone-method-input"><input type="radio" value="' +
			(rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() + '" id="' +
			(rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() +
			'" name="add_method_id"/><label for="' +
			(rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() + '">' +
			(rt.call_function('esc_html', [rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})])).str() +
			'<span class="dashicons dashicons-yes"></span></label></div>')
	}
	print('<div class="wc-shipping-zone-method-input-help-text-container">')
	mut iter_3 := var_methods_placed_in_order.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_method := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [
			rt.new_string('shipping-zones'),
		])))))
		{
			continue
		}
		print('<div id=' +
			(rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() +
			'-description class="wc-shipping-zone-method-input-help-text"><span>' +
			(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_method(var_method, 'get_method_description', []rt.PhpVal{})])])).str() +
			'</span></div>')
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_2 := iife_temp_2.is_checkout_block_default()
	if rt.is_true(iife_result_2) {
		print('<p class="wc-shipping-legacy-local-pickup-help-text-container">')
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Shipping_ShippingController{}
		mut iife_result_3 := iife_temp_3.is_legacy_local_pickup_active()
		if rt.is_true(iife_result_3) {
			rt.call_function('printf', [
				rt.call_function('wp_kses', [
					rt.call_function('__', [
						rt.new_string('Explore a new enhanced delivery method that allows you to easily offer one or more pickup locations to your customers in the <a href="%s">Local pickup settings page</a>.'),
						rt.new_string('woocommerce'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'a', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.new_array() },
						]) },
					]),
				]),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('admin.php?page=wc-settings&tab=shipping&section=pickup_location'),
					]),
				]),
			])
		} else {
			mut var_message := rt.call_function('__', [
				rt.new_string('Local pickup: Set up pickup locations in the <a href="%s">Local pickup settings page</a>.'),
				rt.new_string('woocommerce'),
			])
			mut iife_temp_4 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
			mut iife_result_4 := iife_temp_4.is_local_pickup_enabled()
			if rt.is_true(iife_result_4) {
				var_message = rt.call_function('__', [
					rt.new_string('Local pickup: Manage existing pickup locations in the <a href="%s">Local pickup settings page</a>.'),
					rt.new_string('woocommerce'),
				])
			}
			rt.call_function('printf', [
				rt.call_function('wp_kses', [var_message.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'a', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.new_array() },
						]) },
					])]),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('admin.php?page=wc-settings&tab=shipping&section=pickup_location'),
					]),
				]),
			])
		}
		print('</p>')
	}
	print('</div>')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('STEP 1 OF 2'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
