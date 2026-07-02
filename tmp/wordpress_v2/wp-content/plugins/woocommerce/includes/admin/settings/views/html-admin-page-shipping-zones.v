import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_method_count := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping zones'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=shipping&zone_id=new'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add zone'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string("A shipping zone consists of the region(s) you'd like to ship to and the shipping method(s) offered. A shopper can only be matched to one zone, and we'll use their shipping address to show them the methods available in their area."),
		rt.new_string('woocommerce'),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_0 := iife_temp_0.is_checkout_block_default()
	if rt.is_true(iife_result_0) {
		print(' ' +(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string("To offer local pickup, configure your pickup locations in the <a href='%s'>local pickup settings</a>."), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping&section=pickup_location')])])])])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Drag and drop to re-order your custom zones. This is the order in which they will be matched against the customer address.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Zone name'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Region(s)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping method(s)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Rest of the world'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('An optional zone you can use to set the shipping method(s) available to any regions that have not been listed above.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_worldwide := create_wc_shipping_zone(rt.new_int(0))
	mut var_methods := var_worldwide.get_shipping_methods()
	rt.call_function('uasort', [var_methods.clone(),
		rt.new_string('wc_shipping_zone_method_order_uasort_comparison')])
	if !(!rt.is_true(var_methods)) {
		mut iter_1 := var_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			mut var_class_name := if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method,
				'enabled')))
			{
				'method_enabled'
			} else {
				'method_disabled'
			}
			print('<li class="wc-shipping-zone-method ' +
				(rt.call_function('esc_attr', [rt.new_string(var_class_name.str()).clone()])).str() +
				'" data-id="' +
				(rt.call_function('esc_attr', [rt.get_property(var_method, 'instance_id')])).str() +
				'">' +
				(rt.call_function('esc_html', [rt.call_method(var_method, 'get_title', []rt.PhpVal{})])).str() +
				'</li>')
		}
	} else {
		print('<li>' +
			(rt.call_function('esc_html__', [rt.new_string('No shipping methods offered to this zone.'), rt.new_string('woocommerce')])).str() +
			'</li>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_int(0), var_method_count)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('A shipping zone is a geographic region where a certain set of shipping methods and rates apply.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('For example:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('US domestic zone = All US states = Flat rate shipping'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Europe zone = Any country in Europe = Flat rate shipping'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Add as many zones as you need &ndash; customers will only see the methods available for their address.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=shipping&zone_id=new'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Add shipping zone'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delete'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping method'),
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
	mut iter_2 := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
		[]rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method, 'supports', [
			rt.new_string('shipping-zones'),
		])))))
		{
			continue
		}
		print('<option data-description="' +
			(rt.call_function('esc_attr', [rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_method(var_method, 'get_method_description', []rt.PhpVal{})])])])).str() +
			'" value="' +
			(rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() + '">' +
			(rt.call_function('esc_html', [rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})])).str() +
			'</li>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add shipping method'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
