import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_has_orders := rt.new_null()
	mut var_customer_orders := rt.new_null()
	mut var_wp_button_class := rt.new_null()
	mut var_current_page := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_account_orders'),
		var_has_orders.clone()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_orders) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := rt.call_function('wc_get_account_orders_columns', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_column_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := rt.get_property(var_customer_orders, 'orders').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_customer_order := item_2.val
			mut var_order := rt.call_function('wc_get_order', [
				var_customer_order.clone()])
			mut var_item_count := rt.sub(rt.call_method(var_order, 'get_item_count', []rt.PhpVal{}), rt.call_method(var_order,
				'get_item_count_refunded', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_3 :=
				rt.call_function('wc_get_account_orders_columns', []rt.PhpVal{}).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_column_name := item_3.val
				mut var_column_id := item_3.key
				mut var_is_order_number := (rt.identical(rt.new_string('order-number'),
					var_column_id)).to_bool()
				// unsupported statement: Stmt_InlineHTML
				if var_is_order_number {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_id.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_name.clone()]))
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_id.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_name.clone()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('has_action', [
					rt.new_string('woocommerce_my_account_my_orders_column_' + var_column_id.str()),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('do_action', [
						rt.new_string('woocommerce_my_account_my_orders_column_' +
							var_column_id.str()),
						var_order.clone(),
					])
					// unsupported statement: Stmt_InlineHTML
				} else if var_is_order_number {
					// unsupported statement: Stmt_InlineHTML
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						rt.call_method(var_order, 'get_view_order_url', []rt.PhpVal{}),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('View order number %s'),
								rt.new_string('woocommerce'),
							]),
							rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.new_string(
							(rt.call_function('_x', [rt.new_string('#'), rt.new_string('hash before order number'), rt.new_string('woocommerce')])).str() +
							(rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str()),
					]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.identical(rt.new_string('order-date'), var_column_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
							'date', [rt.new_string('c')]),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.call_function('wc_format_datetime', [
							rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.identical(rt.new_string('order-status'), var_column_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.call_function('wc_get_order_status_name', [
							rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.identical(rt.new_string('order-total'), var_column_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('wp_kses_post', [
						rt.call_function('sprintf', [
							rt.call_function('_n', [rt.new_string('%1$s for %2$s item'),
								rt.new_string('%1$s for %2$s items'),
								var_item_count.clone(), rt.new_string('woocommerce')]),
							rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{}),
							var_item_count.clone(),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
				} else if rt.is_true(rt.identical(rt.new_string('order-actions'), var_column_id)) {
					// unsupported statement: Stmt_InlineHTML
					mut var_actions := rt.call_function('wc_get_account_orders_actions', [
						var_order.clone(),
					])
					if !(!rt.is_true(var_actions)) {
						mut iter_4 := var_actions.iterator()
						for {
							item_4 := iter_4.next() or { break }
							mut var_action := item_4.val
							mut var_key := item_4.key
							if !rt.is_true(var_action.array_get(rt.new_string('aria-label'))) {
								mut var_action_aria_label := rt.call_function('sprintf', [
									rt.call_function('__', [
										rt.new_string('%1$s order number %2$s'),
										rt.new_string('woocommerce'),
									]),
									var_action.array_get(rt.new_string('name')),
									rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
								])
							} else {
								var_action_aria_label =
									var_action.array_get(rt.new_string('aria-label'))
							}
							print('<a href="' +
								(rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))])).str() +
								'" class="woocommerce-button' +
								(rt.call_function('esc_attr', [var_wp_button_class.clone()])).str() +
								' button ' +
								(rt.call_function('sanitize_html_class', [var_key.clone()])).str() +
								'" aria-label="' +
								(rt.call_function('esc_attr', [var_action_aria_label.clone()])).str() +
								'">' +
								(rt.call_function('esc_html', [var_action.array_get(rt.new_string('name'))])).str() +
								'</a>')
							var_action_aria_label = rt.new_null()
						}
					}
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				if var_is_order_number {
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_account_orders_pagination'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.less(rt.new_int(1), rt.get_property(var_customer_orders, 'max_num_pages'))) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_current_page)))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_wp_button_class.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					rt.call_function('wc_get_endpoint_url', [
						rt.new_string('orders'), rt.sub(var_current_page, rt.new_int(1))]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Previous'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(rt.get_property(var_customer_orders,
				'max_num_pages').to_i64()), var_current_page))))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_wp_button_class.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					rt.call_function('wc_get_endpoint_url', [
						rt.new_string('orders'), rt.add(var_current_page, rt.new_int(1))]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Next'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_print_notice', [
			rt.new_string(
				(rt.call_function('esc_html__', [rt.new_string('No order has been made yet.'), rt.new_string('woocommerce')])).str() +
				' <a class="woocommerce-Button wc-forward button' +
				(rt.call_function('esc_attr', [var_wp_button_class.clone()])).str() + '" href="' +
				(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_return_to_shop_redirect'), rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])])).str() +
				'">' +
				(rt.call_function('esc_html__', [rt.new_string('Browse products'), rt.new_string('woocommerce')])).str() +
				'</a>'),
			rt.new_string('notice'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_account_orders'),
		var_has_orders.clone()])
}
