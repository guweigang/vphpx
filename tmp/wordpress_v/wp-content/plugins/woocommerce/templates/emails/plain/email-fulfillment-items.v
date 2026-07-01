import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_fulfillment_items_php() {
	mut var_items := rt.new_null()
	mut var_order := rt.new_null()
	mut var_show_sku := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_visible'), rt.new_bool(true), rt.get_property(var_item, 'item')])) {
				mut var_product := rt.call_method(rt.get_property(var_item, 'item'), 'get_product', []rt.PhpVal{})
				mut var_sku := rt.new_string(rt.new_string(''))
				mut var_purchase_note := rt.new_string(rt.new_string(''))
				if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
					var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
					var_purchase_note = rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
				}
				mut var_product_name := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), rt.call_method(rt.get_property(var_item, 'item'), 'get_name', []rt.PhpVal{}), rt.get_property(var_item, 'item'), rt.new_bool(false)])
				mut var_quantity := rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_item_quantity'), rt.get_property(var_item, 'qty'), rt.get_property(var_item, 'item')])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('str_pad', [rt.call_function('wp_kses_post', [var_product_name.dup()]), rt.new_int(40)])]))
				print(' ')
				print((rt.call_function('esc_html', [rt.call_function('str_pad', [rt.call_function('wp_kses', [rt.call_method(var_order, 'get_formatted_line_subtotal', [rt.get_property(var_item, 'item')]), rt.new_array()]), rt.new_int(20), rt.new_string(' '), rt.get_constant('STR_PAD_LEFT')])])).str() + '\n')
				if rt.is_true(rt.new_bool(rt.is_true(var_show_sku) && rt.is_true(var_sku))) {
					rt.echo_val(rt.call_function('esc_html', ['(#' + (var_sku).str() + ')\n']))
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note))) {
				print('\n' + (rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [var_purchase_note.dup()])])).str())
			}
		}
	}
}
