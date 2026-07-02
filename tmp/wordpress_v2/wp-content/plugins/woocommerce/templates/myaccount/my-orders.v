import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order_count := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_my_orders_columns := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_my_account_my_orders_columns'),
		rt.create_array([
			rt.ArrayItem{ key: 'order-number', val: rt.call_function('esc_html__', [
				rt.new_string('Order'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order-date', val: rt.call_function('esc_html__', [
				rt.new_string('Date'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order-status', val: rt.call_function('esc_html__', [
				rt.new_string('Status'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order-total', val: rt.call_function('esc_html__', [
				rt.new_string('Total'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'order-actions', val: '&nbsp;' },
		]),
	])
	mut var_customer_orders := rt.call_function('get_posts', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_my_orders_query'),
			rt.create_array([rt.ArrayItem{ key: 'numberposts', val: var_order_count },
				rt.ArrayItem{ key: 'meta_key', val: '_customer_user' },
				rt.ArrayItem{ key: 'meta_value', val: rt.call_function('get_current_user_id',
					[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_type', val: rt.call_function('wc_get_order_types', [
					rt.new_string('view-orders'),
				]) }, rt.ArrayItem{ key: 'post_status', val: rt.func_array_keys(rt.call_function('wc_get_order_statuses',
					[]rt.PhpVal{})) }]),
		]),
	])
	if rt.is_true(var_customer_orders) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_my_orders_title'),
			rt.call_function('esc_html__', [rt.new_string('Recent orders'),
				rt.new_string('woocommerce')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_my_orders_columns.iterator()
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
		mut iter_2 := var_customer_orders.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_customer_order := item_2.val
			mut var_order := rt.call_function('wc_get_order', [
				var_customer_order.clone()])
			mut var_item_count := rt.call_method(var_order, 'get_item_count', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			mut iter_3 := var_my_orders_columns.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_column_name := item_3.val
				mut var_column_id := item_3.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_name.clone()]))
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
				} else if rt.is_true(rt.identical(rt.new_string('order-number'), var_column_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_url', [
						rt.call_method(var_order, 'get_view_order_url', []rt.PhpVal{}),
					]))
					// unsupported statement: Stmt_InlineHTML
					print(
						(rt.call_function('_x', [rt.new_string('#'), rt.new_string('hash before order number'), rt.new_string('woocommerce')])).str() +
						(rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str())
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
					rt.call_function('printf', [
						rt.call_function('_n', [rt.new_string('%1$s for %2$s item'),
							rt.new_string('%1$s for %2$s items'),
							var_item_count.clone(), rt.new_string('woocommerce')]),
						rt.call_method(var_order, 'get_formatted_order_total', []rt.PhpVal{}),
						var_item_count.clone(),
					])
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
							print('<a href="' +
								(rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))])).str() +
								'" class="button ' +
								(rt.call_function('sanitize_html_class', [var_key.clone()])).str() +
								'">' +
								(rt.call_function('esc_html', [var_action.array_get(rt.new_string('name'))])).str() +
								'</a>')
						}
					}
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
