import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_views_html_admin_page_shipping_zone_methods_php() {
	mut var_zone := rt.new_null()
	mut var_postcodes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_back_header', [if rt.is_true(rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{})) { rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) } else { rt.call_function('__', [rt.new_string('Add zone'), rt.new_string('woocommerce')]) }, rt.call_function('__', [rt.new_string('Return to shipping'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_before_methods_table'), var_zone.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Zone name'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Give your zone a name! E.g. Local, or Worldwide.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_zone, 'get_zone_name', [rt.new_string('edit')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Zone name'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Zone regions'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('List the regions you\'d like to include in your shipping zone. Customers will be matched against these regions.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if !rt.is_true(var_postcodes) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Limit to specific ZIP/postcodes'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('List 1 postcode per line'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [rt.call_function('implode', [rt.new_string('\n'), var_postcodes.dup()])]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Postcodes containing wildcards (e.g. CB23*) or fully numeric ranges (e.g. <code>90210...99000</code>) are also supported. Please see the shipping zones <a href="%s" target="_blank">documentation</a> for more information.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/setting-up-shipping-zones/#section-3')])
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping methods'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add the shipping methods you\'d like to make available to customers in this zone.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Description'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add shipping method'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping method'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_after_methods_table'), var_zone.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Save changes'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save changes'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('You can add multiple shipping methods within this zone. Only customers within the zone will see them.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delete'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Set up %s'), rt.new_string('woocommerce')]), rt.new_string('{{{ data.method.method_title.toLowerCase() }}}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_classes', []rt.PhpVal{}).array_count().str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping&section=classes')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping class costs'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Back'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create and save'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('STEP 2 OF 2'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create shipping method'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Close modal panel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose the shipping method you wish to add. Only shipping methods which support zones are listed.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_methods := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{})
	mut var_methods_placed_in_order := rt.new_array()
	mut var_first_methods_ids := ['free_shipping', 'flat_rate', 'local_pickup']
	for var_first_method_id in var_first_methods_ids {
		{
			mut iter_1 := var_methods.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_obj := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.get_property(var_obj, 'id'), rt.new_string(first_method_id))) {
					var_methods_placed_in_order.array_push(var_obj.dup())
					var_methods.array_unset(var_key)
					break
				}
			}
		}
	}
	var_methods_placed_in_order = rt.call_function('array_merge', [var_methods_placed_in_order.dup(), rt.call_function('array_values', [var_methods.dup()])])
	{
		mut iter_1 := var_methods_placed_in_order.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) && rt.is_true(rt.identical(, )))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				continue
			}
			print()
		}
	}
}
