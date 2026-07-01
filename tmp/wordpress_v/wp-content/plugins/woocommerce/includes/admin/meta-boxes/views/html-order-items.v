import rt

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_order_items_php() {
	mut var_order := rt.new_null()
	mut var_wpdb := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_render_refunds := // unsupported expression: Expr_Cast_Bool
	// unsupported statement: Stmt_Global
	mut var_payment_gateway := rt.call_function('wc_get_payment_gateway_by_order', [var_order.dup()])
	mut var_line_items := rt.call_method(var_order, 'get_items', [rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_order_item_types'), rt.new_string('line_item')])])
	mut var_discounts := rt.call_method(var_order, 'get_items', [rt.new_string('discount')])
	mut var_line_items_fee := rt.call_method(var_order, 'get_items', [rt.new_string('fee')])
	mut var_line_items_shipping := rt.call_method(var_order, 'get_items', [rt.new_string('shipping')])
	mut var_cogs_is_enabled := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut var_order_taxes := rt.call_method(var_order, 'get_taxes', []rt.PhpVal{})
		mut var_tax_classes := fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_classes() }()
		mut var_classes_options := rt.call_function('wc_get_product_tax_class_options', []rt.PhpVal{})
		mut var_show_tax_columns := rt.new_bool(var_order_taxes.dup().array_count() == 1)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Item'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_headers'), var_order.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cost'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Price'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Qty'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_order_taxes)) {
		{
			mut iter_1 := var_order_taxes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_item := item_1.val
				mut var_tax_id := item_1.key
				mut var_tax_class := rt.call_function('wc_get_tax_class_by_tax_id', [var_tax_item.array_get('rate_id')])
				mut var_tax_class_name := if var_classes_options.array_isset(var_tax_class) { var_classes_options.array_get(var_tax_class) } else { rt.call_function('__', [rt.new_string('Tax'), rt.new_string('woocommerce')]) }
				mut var_column_label := if !(!rt.is_true(var_tax_item.array_get('label'))) { var_tax_item.array_get('label') } else { rt.call_function('__', [rt.new_string('Tax'), rt.new_string('woocommerce')]) }
				mut var_column_tip := rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s (%2$s)'), rt.new_string('woocommerce')]), var_tax_item.array_get('name'), var_tax_class_name.dup()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_tip.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_label.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_item.array_get('rate_id')]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_tax_id.dup()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			rt.call_function('do_action', ['woocommerce_before_order_item_' + (rt.call_method(var_item, 'get_type', []rt.PhpVal{})).str() + '_html', var_item_id.dup(), var_item.dup(), var_order.dup()])
			rt.include_file(@DIR + '/html-order-item.php', '1')
			rt.call_function('do_action', ['woocommerce_order_item_' + (rt.call_method(var_item, 'get_type', []rt.PhpVal{})).str() + '_html', var_item_id.dup(), var_item.dup(), var_order.dup()])
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_items_after_line_items'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_line_items_fee.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			rt.include_file(@DIR + '/html-order-fee.php', '1')
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_items_after_fees'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	mut var_shipping_methods := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})) { rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{}) } else { rt.new_array() }
	{
		mut iter_1 := var_line_items_shipping.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			rt.include_file(@DIR + '/html-order-shipping.php', '1')
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_items_after_shipping'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	// unsupported statement: Stmt_InlineHTML
	mut var_refunds := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{})
	if rt.is_true(var_refunds) {
		{
			mut iter_1 := var_refunds.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_refund := item_1.val
				rt.include_file(@DIR + '/html-order-refund.php', '1')
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_items_after_refunds'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_coupons := rt.call_method(var_order, 'get_items', [rt.new_string('coupon')])
	if rt.is_true(var_coupons) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Coupon(s)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_coupons.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_item_id := item_1.key
				mut var_coupon_info := rt.call_method(var_item, 'get_meta', [rt.new_string('coupon_info')])
				if rt.is_true(var_coupon_info) {
					var_coupon_info = rt.call_function('json_decode', [var_coupon_info.dup(), rt.new_bool(true)])
					mut var_post_id := var_coupon_info.array_get(0)
					// unsupported statement: Stmt_Nop
				} else {
					var_post_id = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE LOWER(post_title) = LOWER(%s) AND post_type = \'shop_coupon\' AND post_status = \'publish\' AND post_date < %s LIMIT 1;')), rt.call_function('wc_sanitize_coupon_code', [rt.call_method(var_item, 'get_code', []rt.PhpVal{})]), rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'format', [rt.new_string('Y-m-d H:i:s')])])])
					// unsupported statement: Stmt_Nop
				}
				mut var_class := if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) { 'code editable' } else { 'code' }
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_class).dup()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_post_id) {
					// unsupported statement: Stmt_InlineHTML
					mut var_post_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_order_item_coupon_url'), rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'post', val: var_post_id }, rt.ArrayItem{ key: 'action', val: 'edit' }]), rt.call_function('admin_url', [rt.new_string('post.php')])]), var_item.dup(), var_order.dup()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [var_post_url.dup()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_price', [rt.call_method(var_item, 'get_discount', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_item, 'get_code', []rt.PhpVal{})]))
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_price', [rt.call_method(, 'get_discount', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: , val:  }])])]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', []))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
