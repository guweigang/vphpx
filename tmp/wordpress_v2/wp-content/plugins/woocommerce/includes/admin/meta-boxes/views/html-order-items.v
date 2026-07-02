import rt

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_wpdb := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_render_refunds := rt.new_bool((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_order_should_render_refunds'),
		rt.new_bool(
			rt.is_true(rt.less(rt.new_int(0), rt.sub(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}))))
			|| rt.is_true(rt.less(rt.new_int(0), rt.call_function('absint', [rt.sub(rt.call_method(var_order, 'get_item_count', []rt.PhpVal{}), rt.call_method(var_order, 'get_item_count_refunded', []rt.PhpVal{}))])))),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		var_order.clone(),
	])).to_bool())
	mut var_payment_gateway := rt.call_function('wc_get_payment_gateway_by_order', [
		var_order.clone(),
	])
	mut var_line_items := rt.call_method(var_order, 'get_items', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_order_item_types'),
			rt.new_string('line_item'),
		]),
	])
	mut var_discounts := rt.call_method(var_order, 'get_items', [
		rt.new_string('discount'),
	])
	mut var_line_items_fee := rt.call_method(var_order, 'get_items', [
		rt.new_string('fee'),
	])
	mut var_line_items_shipping := rt.call_method(var_order, 'get_items', [
		rt.new_string('shipping'),
	])
	mut var_cogs_is_enabled := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{})
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut var_order_taxes := rt.call_method(var_order, 'get_taxes', []rt.PhpVal{})
		mut iife_temp_0 := Class_WC_Tax{}
		mut iife_result_0 := iife_temp_0.get_tax_classes()
		mut var_tax_classes := iife_result_0
		mut var_classes_options := rt.call_function('wc_get_product_tax_class_options',
			[]rt.PhpVal{})
		mut var_show_tax_columns := rt.new_bool(var_order_taxes.clone().array_count() == 1)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Item'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_headers'),
		var_order.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cost'),
			rt.new_string('woocommerce')])
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
		mut iter_1 := var_order_taxes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_item := item_1.val
			mut var_tax_id := item_1.key
			mut var_tax_class := rt.call_function('wc_get_tax_class_by_tax_id', [
				var_tax_item.array_get(rt.new_string('rate_id')),
			])
			mut var_tax_class_name := if var_classes_options.array_isset(var_tax_class) { var_classes_options.array_get(var_tax_class) } else { rt.call_function('__', [
					rt.new_string('Tax'),
					rt.new_string('woocommerce'),
				]) }
			mut var_column_label := if !(!rt.is_true(var_tax_item.array_get(rt.new_string('label')))) { var_tax_item.array_get(rt.new_string('label')) } else { rt.call_function('__', [
					rt.new_string('Tax'),
					rt.new_string('woocommerce'),
				]) }
			mut var_column_tip := rt.call_function('sprintf', [
				rt.call_function('esc_html__', [rt.new_string('%1$s (%2$s)'),
					rt.new_string('woocommerce')]),
				var_tax_item.array_get(rt.new_string('name')),
				var_tax_class_name.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_tip.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_label.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_tax_item.array_get(rt.new_string('rate_id')),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_id.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_line_items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		mut var_item_id := item_2.key
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_order_item_' +
				(rt.call_method(var_item, 'get_type', []rt.PhpVal{})).str() + '_html'),
			var_item_id.clone(),
			var_item.clone(),
			var_order.clone(),
		])
		rt.include_file(@DIR + '/html-order-item.php', '1')
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_item_' +
				(rt.call_method(var_item, 'get_type', []rt.PhpVal{})).str() + '_html'),
			var_item_id.clone(),
			var_item.clone(),
			var_order.clone(),
		])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_items_after_line_items'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := var_line_items_fee.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		mut var_item_id := item_3.key
		rt.include_file(@DIR + '/html-order-fee.php', '1')
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_items_after_fees'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_shipping_methods := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}))
	{
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping',
			[]rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{})
	} else {
		rt.new_array()
	}
	mut iter_4 := var_line_items_shipping.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_item := item_4.val
		mut var_item_id := item_4.key
		rt.include_file(@DIR + '/html-order-shipping.php', '1')
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_items_after_shipping'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_refunds := rt.call_method(var_order, 'get_refunds', []rt.PhpVal{})
	if rt.is_true(var_refunds) {
		mut iter_5 := var_refunds.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_refund := item_5.val
			rt.include_file(@DIR + '/html-order-refund.php', '1')
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_admin_order_items_after_refunds'),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_coupons := rt.call_method(var_order, 'get_items', [
		rt.new_string('coupon')])
	if rt.is_true(var_coupons) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Coupon(s)'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_6 := var_coupons.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_item := item_6.val
			mut var_item_id := item_6.key
			mut var_coupon_info := rt.call_method(var_item, 'get_meta', [
				rt.new_string('coupon_info'),
			])
			if rt.is_true(var_coupon_info) {
				var_coupon_info = rt.call_function('json_decode', [
					var_coupon_info.clone(), rt.new_bool(true)])
				mut var_post_id := var_coupon_info.array_get(rt.new_int(0))
			} else {
				var_post_id = rt.call_method(var_wpdb, 'get_var', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
							'posts')),
							rt.new_string(" WHERE LOWER(post_title) = LOWER(%s) AND post_type = 'shop_coupon' AND post_status = 'publish' AND post_date < %s LIMIT 1;")),
						rt.call_function('wc_sanitize_coupon_code', [
							rt.call_method(var_item, 'get_code', []rt.PhpVal{}),
						]),
						rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
							'format', [
							rt.new_string('Y-m-d H:i:s'),
						]),
					]),
				])
			}
			mut var_class := if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
				'code editable'
			} else {
				'code'
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_class.str()).clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_post_id) {
				// unsupported statement: Stmt_InlineHTML
				mut var_post_url := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_admin_order_item_coupon_url'),
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'post', val: var_post_id },
							rt.ArrayItem{ key: 'action', val: 'edit' }]),
						rt.call_function('admin_url', [rt.new_string('post.php')]),
					]),
					var_item.clone(),
					var_order.clone(),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [var_post_url.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('wc_price', [
						rt.call_method(var_item, 'get_discount', []rt.PhpVal{}),
						rt.create_array([
							rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order,
								'get_currency', []rt.PhpVal{}) },
						]),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_method(var_item, 'get_code', []rt.PhpVal{}),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_function('wc_price', [
						rt.call_method(var_item, 'get_discount', []rt.PhpVal{}),
						rt.create_array([
							rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order,
								'get_currency', []rt.PhpVal{}) },
						]),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_method(var_item, 'get_code', []rt.PhpVal{}),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.call_method(var_item, 'get_code', []rt.PhpVal{}),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Items Subtotal:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_price', [
		rt.call_method(var_order, 'get_subtotal', []rt.PhpVal{}),
		rt.create_array([
			rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
				[]rt.PhpVal{}) },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_order, 'get_total_discount',
		[]rt.PhpVal{})))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Discount:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(rt.call_function('abs', [
		rt.call_method(var_order, 'get_total_fees', []rt.PhpVal{}),
	]), rt.new_int(0)))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Fees:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_total_fees', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_totals_after_discount'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Shipping:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_totals_after_shipping'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_7 := rt.call_method(var_order, 'get_tax_totals', []rt.PhpVal{}).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_tax_total := item_7.val
			mut var_code := item_7.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_tax_total, 'label'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_price', [
				rt.call_function('wc_round_tax_total', [
					rt.get_property(var_tax_total, 'amount'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
						[]rt.PhpVal{}) },
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_totals_after_tax'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order Total'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_price', [
		rt.call_method(var_order, 'get_total', []rt.PhpVal{}),
		rt.create_array([
			rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
				[]rt.PhpVal{}) },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_order, 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
	}, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
	}]), rt.new_bool(true)]))
		&& !(!rt.is_true(rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}))) {
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{})) {
			'label'
		} else {
			'label label-highlight'
		})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Paid'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_total', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{})) {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s via %2$s'),
						rt.new_string('woocommerce')]),
					rt.call_method(rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
						'date_i18n', [rt.call_function('get_option', [
						rt.new_string('date_format'),
					])]),
					rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}),
				]),
			]))
		} else {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_method(rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
					'date_i18n', [
					rt.call_function('get_option', [rt.new_string('date_format')]),
				]),
			]))
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Refunded'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_admin_order_totals_after_refunded'),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Net Payment'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.sub(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.call_method(var_order,
				'get_total_refunded', []rt.PhpVal{})),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cost Total'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_order, 'get_cogs_total_value_html', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_totals_after_total'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add item(s)'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Apply coupon'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('__', [
				rt.new_string('To edit this order change the status back to "Pending payment"'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('This order is no longer editable.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_render_refunds) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Refund'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_item_add_action_buttons'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Recalculate'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add product(s)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add fee'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add tax'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_item_add_line_buttons'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Save'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_render_refunds) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_manage_stock'),
		])))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Restock refunded items'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_restock_refunded_items'),
					rt.new_bool(true),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Amount already refunded'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Total available to refund'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_price', [
			rt.sub(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.call_method(var_order,
				'get_total_refunded', []rt.PhpVal{})),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency',
					[]rt.PhpVal{}) },
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('__', [
				rt.new_string('Refund the line items above. This will show the total amount to be refunded'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Refund amount'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
			print('readonly')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('__', [
				rt.new_string('Note: the refund reason will be visible by the customer.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Reason for refund (optional):'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_refund_amount := rt.new_string('<span class="wc-order-refund-amount">' +
			(rt.call_function('wc_price', [rt.new_int(0), rt.create_array([rt.ArrayItem{
			key: 'currency'
			val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
		}])])).str() +
			'</span>')
		mut var_gateway_name := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
			var_payment_gateway))))
		{
			if !(!rt.is_true(rt.get_property(var_payment_gateway, 'method_title'))) {
				rt.get_property(var_payment_gateway, 'method_title')
			} else {
				rt.call_method(var_payment_gateway, 'get_title', []rt.PhpVal{})
			}
		} else {
			rt.call_function('__', [rt.new_string('Payment gateway'),
				rt.new_string('woocommerce')])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_payment_gateway))))
			&& rt.is_true(rt.call_method(var_payment_gateway, 'can_refund_order', [var_order.clone()])) {
			print('<button type="button" class="button button-primary do-api-refund">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Refund %1$s via %2$s'), rt.new_string('woocommerce')]), rt.call_function('wp_kses_post', [var_refund_amount.clone()]), rt.call_function('esc_html', [var_gateway_name.clone()])])).str() +
				'</button>')
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [
			rt.new_string('You will need to manually issue a refund through your payment gateway after using this.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Refund %s manually'),
				rt.new_string('woocommerce')]),
			rt.call_function('wp_kses_post', [var_refund_amount.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Quantity'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_row := rt.new_string(
		'\n\t\t\t\t\t\t\t\t\t<td><select class="wc-product-search" name="item_id" data-allow_clear="true" data-display_stock="true" data-exclude_type="variable" data-placeholder="' +
		(rt.call_function('esc_attr__', [rt.new_string('Search for a product&hellip;'), rt.new_string('woocommerce')])).str() +
		'"></select></td>\n\t\t\t\t\t\t\t\t\t<td><input type="number" step="1" min="0" max="9999" autocomplete="off" name="item_qty" placeholder="1" size="4" class="quantity" /></td>')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_row.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_row)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add tax'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Rate name'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Tax class'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Rate code'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Rate %'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_rates := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('woocommerce_tax_rates ORDER BY tax_rate_name LIMIT 100')),
	])
	mut iter_8 := var_rates.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_rate := item_8.val
		mut iife_temp_1 := Class_WC_Tax{}
		mut iife_result_1 := iife_temp_1.get_rate_label(var_rate.clone())
		mut iife_temp_2 := Class_WC_Tax{}
		mut iife_result_2 := iife_temp_2.get_rate_label(var_rate.clone())
		mut iife_temp_3 := Class_WC_Tax{}
		mut iife_result_3 := iife_temp_3.get_rate_code(var_rate.clone())
		mut iife_temp_4 := Class_WC_Tax{}
		mut iife_result_4 := iife_temp_4.get_rate_code(var_rate.clone())
		mut iife_temp_5 := Class_WC_Tax{}
		mut iife_result_5 := iife_temp_5.get_rate_percent(var_rate.clone())
		mut iife_temp_6 := Class_WC_Tax{}
		mut iife_result_6 := iife_temp_6.get_rate_percent(var_rate.clone())
		print(
			'\n\t\t\t\t\t\t\t\t\t<tr>\n\t\t\t\t\t\t\t\t\t\t<td><input type="radio" id="add_order_tax_' +
			(rt.call_function('absint', [rt.get_property(var_rate, 'tax_rate_id')])).str() +
			'" name="add_order_tax" value="' +
			(rt.call_function('absint', [rt.get_property(var_rate, 'tax_rate_id')])).str() +
			'" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><label for="add_order_tax_' +
			(rt.call_function('absint', [rt.get_property(var_rate, 'tax_rate_id')])).str() + '">' +
			(rt.call_function('esc_html', [iife_result_1])).str() +
			'</label></td>\n\t\t\t\t\t\t\t\t\t\t<td>' +
			(if var_classes_options.array_isset(rt.get_property(var_rate, 'tax_rate_class')) { rt.call_function('esc_html', [var_classes_options.array_get(rt.get_property(var_rate, 'tax_rate_class'))]) } else { rt.new_string('-') }).str() +
			'</td>\n\t\t\t\t\t\t\t\t\t\t<td>' +
			(rt.call_function('esc_html', [iife_result_3])).str() +
			'</td>\n\t\t\t\t\t\t\t\t\t\t<td>' +
			(rt.call_function('esc_html', [iife_result_5])).str() +
			'</td>\n\t\t\t\t\t\t\t\t\t</tr>\n\t\t\t\t\t\t\t\t')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(rt.call_function('absint', [
		rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(tax_rate_id) FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_tax_rates;')),
		]),
	]), rt.new_int(100)))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Or, enter tax rate ID:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Optional'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
