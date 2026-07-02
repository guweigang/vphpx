import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_class := rt.new_null()
	mut var_order := rt.new_null()
	mut var_order_taxes := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
	mut var_product_link := if rt.is_true(var_product) { rt.call_function('admin_url', [
			rt.new_string('post.php?post=' + (rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})).str() + '&action=edit'),
		]) } else { rt.new_string('') }
	mut var_thumbnail := if rt.is_true(var_product) { rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_order_item_thumbnail'),
			rt.call_method(var_product, 'get_image', [rt.new_string('thumbnail'),
				rt.create_array([rt.ArrayItem{ key: 'title', val: '' }]),
				rt.new_bool(false)]),
			var_item_id.clone(),
			var_item.clone(),
		]) } else { rt.new_string('') }
	mut var_row_class := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_html_order_item_class'),
		if !(!rt.is_true(var_class)) { var_class } else { rt.new_string('') },
		var_item.clone(),
		var_order.clone(),
	])
	mut var_wc_price_arg := {
		'currency': rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
	}
	mut var_is_visible := rt.is_true(var_product)
		&& rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{}))
	mut var_item_name := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_item_name'),
		rt.call_method(var_item, 'get_name', []rt.PhpVal{}),
		var_item.clone(),
		rt.new_bool(var_is_visible).clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_row_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print('<div class="wc-order-item-thumbnail">' +
		(rt.call_function('wp_kses_post', [var_thumbnail.clone()])).str() + '</div>')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_product_link) {
		'<a href="' + (rt.call_function('esc_url', [var_product_link.clone()])).str() +
			'" class="wc-order-item-name">' +
			(rt.call_function('wp_kses_post', [var_item_name.clone()])).str() + '</a>'
	} else {
		'<div class="wc-order-item-name">' +
			(rt.call_function('wp_kses_post', [var_item_name.clone()])).str() + '</div>'
	})
	if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'get_sku', []rt.PhpVal{})) {
		print('<div class="wc-order-item-sku"><strong>' +
			(rt.call_function('esc_html__', [rt.new_string('SKU:'), rt.new_string('woocommerce')])).str() +
			'</strong> ' +
			(rt.call_function('esc_html', [rt.call_method(var_product, 'get_sku', []rt.PhpVal{})])).str() +
			'</div>')
	}
	if rt.is_true(rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})) {
		print('<div class="wc-order-item-variation"><strong>' +
			(rt.call_function('esc_html__', [rt.new_string('Variation ID:'), rt.new_string('woocommerce')])).str() +
			'</strong> ')
		if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.call_function('get_post_type', [
			rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}),
		])))
		{
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}),
			]))
		} else {
			rt.call_function('printf', [
				rt.call_function('esc_html__', [rt.new_string('%s (No longer exists)'),
					rt.new_string('woocommerce')]),
				rt.call_function('esc_html', [
					rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}),
				]),
			])
		}
		print('</div>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_order_itemmeta'),
		var_item_id.clone(), var_item.clone(), var_product.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file(@DIR + '/html-order-item-meta.php', '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_order_itemmeta'),
		var_item_id.clone(), var_item.clone(), var_product.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_values'),
		var_product.clone(), var_item.clone(), rt.call_function('absint', [
			var_item_id.clone()])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_item, 'get_cogs_value', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut var_tooltip_text := rt.call_method(var_item, 'get_cogs_value_per_unit_tooltip_text',
			[]rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_tooltip_text) {
			print(" title='" + (rt.call_function('esc_attr', [var_tooltip_text.clone()])).str() +
				"'")
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_item, 'get_cogs_value_html', []rt.PhpVal{}),
		]))
		mut var_refunded_cost := rt.call_method(var_order, 'get_cogs_refunded_for_item', [
			var_item_id.clone(),
		])
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_item, 'get_cogs_refund_value_html', [
				var_refunded_cost.clone(), rt.create_array_from_native_map(var_wc_price_arg),
				var_order.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_order, 'get_item_subtotal', [var_item.clone(),
			rt.new_bool(false), rt.new_bool(true)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_price', [
		rt.call_method(var_order, 'get_item_subtotal', [var_item.clone(),
			rt.new_bool(false), rt.new_bool(true)]),
		rt.create_array_from_native_map(var_wc_price_arg),
	]))
	// unsupported statement: Stmt_InlineHTML
	print('<small class="times">&times;</small> ' +(rt.call_function('esc_html', [rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})])).str())
	mut var_refunded_qty := rt.mul(-1, rt.call_method(var_order, 'get_qty_refunded_for_item', [
		var_item_id.clone(),
	]))
	if rt.is_true(var_refunded_qty) {
		print('<small class="refunded">' +
			(rt.call_function('esc_html', [rt.mul(var_refunded_qty, -1)])).str() + '</small>')
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_step := if rt.is_true(var_product) {
		rt.call_method(var_product, 'get_purchase_quantity_step', []rt.PhpVal{})
	} else {
		rt.new_int(1)
	}
	mut var_step_edit := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_quantity_input_step_admin'),
		var_step.clone(),
		var_product.clone(),
		rt.new_string('edit'),
	])
	mut var_step_refund := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_quantity_input_step_admin'),
		var_step.clone(),
		var_product.clone(),
		rt.new_string('refund'),
	])
	mut var_min_edit := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_quantity_input_min_admin'),
		rt.new_string('0'),
		var_product.clone(),
		rt.new_string('edit'),
	])
	mut var_min_refund := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_quantity_input_min_admin'),
		rt.new_string('0'),
		var_product.clone(),
		rt.new_string('refund'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_step_edit.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_min_edit.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_step_refund.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_min_refund.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_price', [
		rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
		rt.create_array_from_native_map(var_wc_price_arg),
	]))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_item, 'get_subtotal',
		[]rt.PhpVal{}), rt.call_method(var_item, 'get_total', []rt.PhpVal{})))))
	{
		print('<span class="wc-order-item-discount">' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s discount'), rt.new_string('woocommerce')]), rt.call_function('wc_price', [rt.call_function('wc_format_decimal', [rt.sub(rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}), rt.call_method(var_item, 'get_total', []rt.PhpVal{})), rt.new_string('')]), rt.create_array_from_native_map(var_wc_price_arg)])])).str() +
			'</span>')
	}
	mut var_refunded := rt.mul(-1, rt.call_method(var_order, 'get_total_refunded_for_item', [
		var_item_id.clone(),
	]))
	if rt.is_true(var_refunded) {
		print('<small class="refunded">' +
			(rt.call_function('wc_price', [var_refunded.clone(), rt.create_array_from_native_map(var_wc_price_arg)])).str() +
			'</small>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Before discount'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [
			rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [
			rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [
			rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('After pre-tax discounts.'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [
			rt.call_method(var_item, 'get_total', []rt.PhpVal{}),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_format_localized_price', [rt.new_int(0)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_tax_data := if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(var_tax_data) {
		mut iter_1 := var_order_taxes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_item := item_1.val
			mut var_tax_item_id := rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{})
			mut var_tax_item_total := if var_tax_data.array_get(rt.new_string('total')).array_isset(var_tax_item_id) {
				var_tax_data.array_get(rt.new_string('total')).array_get(var_tax_item_id)
			} else {
				rt.new_string('')
			}
			mut var_tax_item_subtotal := if var_tax_data.array_get(rt.new_string('subtotal')).array_isset(var_tax_item_id) {
				var_tax_data.array_get(rt.new_string('subtotal')).array_get(var_tax_item_id)
			} else {
				rt.new_string('')
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
				var_tax_item_total))))
			{
				rt.echo_val(rt.call_function('wc_price', [
					rt.call_function('wc_round_tax_total', [var_tax_item_total.clone()]),
					rt.create_array_from_native_map(var_wc_price_arg),
				]))
			} else {
				print('&ndash;')
			}
			var_refunded = rt.mul(-1, rt.call_method(var_order, 'get_tax_refunded_for_item', [
				var_item_id.clone(),
				var_tax_item_id.clone(),
			]))
			if rt.is_true(var_refunded) {
				print('<small class="refunded">' +
					(rt.call_function('wc_price', [var_refunded.clone(), rt.create_array_from_native_map(var_wc_price_arg)])).str() +
					'</small>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Before discount'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					rt.new_int(0)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					var_tax_item_subtotal.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					var_tax_item_subtotal.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Total'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					rt.new_int(0)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					var_tax_item_total.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					var_tax_item_total.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_format_localized_price', [
					rt.new_int(0)]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit item'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit item'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete item'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete item'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
