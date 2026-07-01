import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_views_html_order_shipping_php() {
	mut var_class := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_item := rt.new_null()
	mut var_shipping_methods := rt.new_null()
	mut var_cogs_is_enabled := rt.new_null()
	mut var_order := rt.new_null()
	mut var_order_taxes := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(var_class)) { rt.call_function('esc_attr', [var_class.dup()]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if rt.is_true(rt.call_method(var_item, 'get_name', []rt.PhpVal{})) { rt.call_method(var_item, 'get_name', []rt.PhpVal{}) } else { rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]) }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Shipping name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_item, 'get_name', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Shipping method'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('N/A'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_found_method := false
	{
		mut iter_1 := var_shipping_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			mut var_is_active := (rt.identical(rt.call_method(var_item, 'get_method_id', []rt.PhpVal{}), rt.get_property(var_method, 'id'))).to_bool()
			print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_method, 'id')])).str() + '" ' + (rt.call_function('selected', [rt.new_bool(true), rt.new_bool(var_is_active).dup(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.call_method(var_method, 'get_method_title', []rt.PhpVal{})])).str() + '</option>')
			if var_is_active {
				var_found_method = true
			}
		}
	}
	if rt.is_true(rt.new_bool(!(var_found_method) && rt.is_true(rt.call_method(var_item, 'get_method_id', []rt.PhpVal{})))) {
		print('<option value="' + (rt.call_function('esc_attr', [rt.call_method(var_item, 'get_method_id', []rt.PhpVal{})])).str() + '" selected="selected">' + (rt.call_function('esc_html__', [rt.new_string('Other'), rt.new_string('woocommerce')])).str() + '</option>')
	} else {
		print('<option value="other">' + (rt.call_function('esc_html__', [rt.new_string('Other'), rt.new_string('woocommerce')])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_order_itemmeta'), var_item_id.dup(), var_item.dup(), rt.new_null()])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file(@DIR + '/html-order-item-meta.php', '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_order_itemmeta'), var_item_id.dup(), var_item.dup(), rt.new_null()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_item_values'), rt.new_null(), var_item.dup(), rt.call_function('absint', [var_item_id.dup()])])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_cogs_is_enabled) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_price', [rt.call_method(var_item, 'get_total', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])]))
	mut var_refunded := rt.mul(// unsupported expression: Expr_UnaryMinus, rt.call_method(var_order, 'get_total_refunded_for_item', [var_item_id.dup(), rt.new_string('shipping')]))
	if rt.is_true(var_refunded) {
		rt.echo_val(rt.call_function('wp_kses_post', ['<small class="refunded">' + (rt.call_function('wc_price', [var_refunded.dup(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])).str() + '</small>']))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [rt.new_int(0)])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [rt.call_method(var_item, 'get_total', []rt.PhpVal{})])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_item_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [rt.new_int(0)])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_tax_data := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_tax_data) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})))) {
		{
			mut iter_1 := var_order_taxes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_item := item_1.val
				mut var_tax_item_id := rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{})
				mut var_tax_item_total := if var_tax_data.array_get('total').array_isset(var_tax_item_id) { var_tax_data.array_get('total').array_get(var_tax_item_id) } else { rt.new_string('') }
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('wc_price', [var_tax_item_total.dup(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])]) } else { rt.new_string('&ndash;') }]))
				var_refunded = rt.mul(// unsupported expression: Expr_UnaryMinus, rt.call_method(var_order, 'get_tax_refunded_for_item', [var_item_id.dup(), var_tax_item_id.dup(), rt.new_string('shipping')]))
				if rt.is_true(var_refunded) {
					rt.echo_val(rt.call_function('wp_kses_post', ['<small class="refunded">' + (rt.call_function('wc_price', [var_refunded.dup(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])).str() + '</small>']))
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('absint', [var_item_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [rt.new_int(0)])]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if !(var_tax_item_total).is_null() { rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [var_tax_item_total.dup()])]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('absint', [var_item_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [rt.new_int(0)])]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_tax_item_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Edit shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Delete shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
