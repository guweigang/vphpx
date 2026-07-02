import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_order_id := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_notes := rt.call_method(var_order, 'get_customer_order_notes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_details_status'),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Order #%1$s was placed on %2$s and is currently %3$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('<mark class="order-number">' +
					(rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str() + '</mark>'),
				rt.new_string('<mark class="order-date">' +
					(rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})])).str() +
					'</mark>'),
				rt.new_string('<mark class="order-status">' +
					(rt.call_function('wc_get_order_status_name', [rt.call_method(var_order, 'get_status', []rt.PhpVal{})])).str() +
					'</mark>'),
			]),
			var_order.clone(),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_notes) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Order updates'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_notes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('date_i18n', [
				rt.call_function('esc_html__', [rt.new_string('l jS \\o\\f F Y, h:ia'),
					rt.new_string('woocommerce')]),
				rt.call_function('strtotime', [rt.get_property(var_note, 'comment_date')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('wpautop', [
					rt.call_function('wptexturize', [
						rt.get_property(var_note, 'comment_content'),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_view_order'),
		var_order_id.clone()])
}
