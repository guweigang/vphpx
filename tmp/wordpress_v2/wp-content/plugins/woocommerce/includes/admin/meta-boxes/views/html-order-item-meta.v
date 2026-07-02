import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_hidden_order_itemmeta := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hidden_order_itemmeta'),
		rt.create_array([rt.ArrayItem{ key: none, val: '_qty' },
			rt.ArrayItem{ key: none, val: '_tax_class' }, rt.ArrayItem{
				key: none
				val: '_product_id'
			}, rt.ArrayItem{ key: none, val: '_variation_id' },
			rt.ArrayItem{ key: none, val: '_line_subtotal' },
			rt.ArrayItem{ key: none, val: '_line_subtotal_tax' },
			rt.ArrayItem{ key: none, val: '_line_total' }, rt.ArrayItem{ key: none, val: '_line_tax' },
			rt.ArrayItem{ key: none, val: 'method_id' }, rt.ArrayItem{ key: none, val: 'cost' },
			rt.ArrayItem{ key: none, val: '_reduced_stock' },
			rt.ArrayItem{ key: none, val: '_restock_refunded_items' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_meta_data := rt.call_method(var_item, 'get_all_formatted_meta_data', [
		rt.new_string(''),
	])
	if rt.is_true(var_meta_data) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_meta_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			mut var_meta_id := item_1.key
			if rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'),
				var_hidden_order_itemmeta.clone(), rt.new_bool(true)]))
			{
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.get_property(var_meta, 'display_key'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('force_balance_tags', [
					rt.get_property(var_meta, 'display_value'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_meta_data) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_meta_data.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta := item_2.val
			mut var_meta_id := item_2.key
			if rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'key'),
				var_hidden_order_itemmeta.clone(), rt.new_bool(true)]))
			{
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_meta_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Name (required)'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_meta_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_meta, 'key')]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Value (required)'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_item_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_meta_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_textarea', [
				rt.call_function('rawurldecode', [rt.get_property(var_meta, 'value')]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add&nbsp;meta'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
