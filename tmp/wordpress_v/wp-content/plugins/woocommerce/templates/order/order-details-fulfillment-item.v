import rt



pub fn init_wp_content_plugins_woocommerce_templates_order_order_details_fulfillment_item_php() {
	mut var_order := rt.new_null()
	mut var_product := rt.new_null()
	mut var_quantity := rt.new_null()
	mut var_is_pending_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_show_purchase_note := rt.new_null()
	mut var_purchase_note := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_visible'), rt.new_bool(true), var_item.dup()]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_class'), rt.new_string('woocommerce-table__line-item order_item'), var_item.dup(), var_order.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	mut var_is_visible := rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{}))
	mut var_product_permalink := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_permalink'), if var_is_visible { rt.call_method(var_product, 'get_permalink', [var_item.dup()]) } else { rt.new_string('') }, var_item.dup(), var_order.dup()])
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_name'), if rt.is_true(var_product_permalink) { rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), var_product_permalink.dup(), rt.call_method(var_item, 'get_name', []rt.PhpVal{})]) } else { rt.call_method(var_item, 'get_name', []rt.PhpVal{}) }, var_item.dup(), rt.new_bool(var_is_visible).dup()])]))
	mut var_qty := var_quantity
	mut var_refunded_qty := if rt.is_true(var_is_pending_item) { rt.call_method(var_order, 'get_qty_refunded_for_item', [var_item_id.dup()]) } else { rt.new_int(0) }
	if rt.is_true(var_refunded_qty) {
		mut var_qty_display := rt.new_string('<del>' + (rt.call_function('esc_html', [var_qty.dup()])).str() + '</del> <ins>' + (rt.call_function('esc_html', [rt.sub(var_qty, rt.mul(var_refunded_qty, // unsupported expression: Expr_UnaryMinus))])).str() + '</ins>')
	} else {
		var_qty_display = rt.call_function('esc_html', [var_qty.dup()])
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_quantity_html'), ' <strong class="product-quantity">' + (rt.call_function('sprintf', [rt.new_string('&times;&nbsp;%s'), var_qty_display.dup()])).str() + '</strong>', var_item.dup()]))
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_start'), var_item_id.dup(), var_item.dup(), var_order.dup(), rt.new_bool(false)])
	rt.call_function('wc_display_item_meta', [var_item.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_order_item_meta_end'), var_item_id.dup(), var_item.dup(), var_order.dup(), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	mut var_item := // unsupported expression: Expr_Clone
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_item.dup(), rt.new_string('get_subtotal')])) && rt.is_true(rt.call_function('method_exists', [var_item.dup(), rt.new_string('set_subtotal')])))) && rt.is_true(rt.call_function('method_exists', [var_item.dup(), rt.new_string('get_quantity')])))) {
		rt.call_method(var_item, 'set_subtotal', [rt.div(rt.mul(rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{}), var_quantity), rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}))])
	}
	rt.echo_val(rt.call_method(var_order, 'get_formatted_line_subtotal', [var_item.dup()]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(var_show_purchase_note) && rt.is_true(var_purchase_note))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wpautop', [rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [var_purchase_note.dup()])])]))
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	}
}
