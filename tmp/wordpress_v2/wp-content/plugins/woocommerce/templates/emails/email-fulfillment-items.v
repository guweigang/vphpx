import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_items := rt.new_null()
	mut var_image_size := rt.new_null()
	mut var_order := rt.new_null()
	mut var_show_image := rt.new_null()
	mut var_show_sku := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_margin_side := if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		'left'
	} else {
		'right'
	}
	mut var_price_text_align := 'right'
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_item_id := item_1.key
		mut var_product := rt.call_method(rt.get_property(var_item, 'item'), 'get_product',
			[]rt.PhpVal{})
		mut var_sku := rt.new_string('')
		mut var_purchase_note := rt.new_string('')
		mut var_image := rt.new_string('')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_visible'),
			rt.new_bool(true),
			rt.get_property(var_item, 'item'),
		])))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
			var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
			var_purchase_note = rt.call_method(var_product, 'get_purchase_note', []rt.PhpVal{})
			var_image = rt.call_method(var_product, 'get_image', [
				var_image_size.clone()])
		}
		mut var_order_item_class := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_class'),
			rt.new_string('order_item'),
			rt.get_property(var_item, 'item'),
			var_order.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_order_item_class.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_show_image) {
			print('<td>' +
				(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_thumbnail'), var_image.clone(), rt.get_property(var_item, 'item')])])).str() +
				'</td>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_order_item_name'),
				rt.call_method(rt.get_property(var_item, 'item'), 'get_name', []rt.PhpVal{}),
				rt.get_property(var_item, 'item'),
				rt.new_bool(false),
			]),
		]))
		if rt.is_true(var_show_sku) && rt.is_true(var_sku) {
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.new_string(' (#' + var_sku.str() + ')'),
			]))
		}
		rt.call_function('do_action', [
			rt.new_string('woocommerce_order_item_meta_start'),
			var_item_id.clone(),
			rt.get_property(var_item, 'item'),
			var_order.clone(),
			var_plain_text.clone(),
		])
		mut var_item_meta := rt.call_function('wc_display_item_meta', [
			rt.get_property(var_item, 'item'),
			rt.create_array([rt.ArrayItem{ key: 'before', val: '' },
				rt.ArrayItem{ key: 'after', val: '' }, rt.ArrayItem{ key: 'separator', val: '<br>' },
				rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{
					key: 'label_before'
					val: '<span>'
				}, rt.ArrayItem{ key: 'label_after', val: ':</span> ' }]),
		])
		print('<div class="email-order-item-meta">')
		rt.echo_val(rt.call_function('wp_kses', [var_item_meta.clone(),
			rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() },
				rt.ArrayItem{ key: 'span', val: rt.new_array() },
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: true },
					rt.ArrayItem{ key: 'target', val: true },
					rt.ArrayItem{ key: 'rel', val: true },
					rt.ArrayItem{ key: 'title', val: true },
				]) }])]))
		print('</div>')
		rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_end'),
			var_item_id.clone(), rt.get_property(var_item, 'item'),
			var_order.clone(), var_plain_text.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[rt.new_string(var_price_text_align.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut var_qty := rt.get_property(var_item, 'qty')
		mut var_qty_display := rt.call_function('esc_html', [
			var_qty.clone()])
		mut var_quantity := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_order_item_quantity'),
			var_qty_display.clone(),
			rt.get_property(var_item, 'item'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_quantity)))) {
			print('&times;' + (rt.call_function('wp_kses_post', [var_quantity.clone()])).str())
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[rt.new_string(var_price_text_align.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_method(var_order, 'get_formatted_line_subtotal', [
				rt.get_property(var_item, 'item'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('wpautop', [
					rt.call_function('do_shortcode', [var_purchase_note.clone()]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
