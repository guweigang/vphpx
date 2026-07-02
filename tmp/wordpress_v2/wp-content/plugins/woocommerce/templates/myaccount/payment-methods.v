import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_saved_methods := rt.call_function('wc_get_customer_saved_methods_list', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	mut var_has_methods := rt.new_bool(var_saved_methods.to_bool())
	mut var_types := rt.call_function('wc_get_account_payment_methods_types', []rt.PhpVal{})
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_account_payment_methods'),
		var_has_methods.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_methods) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 :=
			rt.call_function('wc_get_account_payment_methods_columns', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_column_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_column_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_saved_methods.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_methods := item_2.val
			mut var_type := item_2.key
			// unsupported statement: Stmt_InlineHTML
			mut iter_3 := var_methods.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_method := item_3.val
				// unsupported statement: Stmt_InlineHTML
				print(if !(!rt.is_true(var_method.array_get(rt.new_string('is_default')))) {
					' default-payment-method'
				} else {
					''
				})
				// unsupported statement: Stmt_InlineHTML
				mut iter_4 := rt.call_function('wc_get_account_payment_methods_columns',
					[]rt.PhpVal{}).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_column_name := item_4.val
					mut var_column_id := item_4.key
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_id.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_id.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_column_name.clone()]))
					// unsupported statement: Stmt_InlineHTML
					if rt.is_true(rt.call_function('has_action', [
						rt.new_string('woocommerce_account_payment_methods_column_' +
							var_column_id.str()),
					]))
					{
						rt.call_function('do_action', [
							rt.new_string('woocommerce_account_payment_methods_column_' +
								var_column_id.str()),
							var_method.clone(),
						])
					} else if rt.is_true(rt.identical(rt.new_string('method'), var_column_id)) {
						if !(!rt.is_true(var_method.array_get(rt.new_string('method')).array_get(rt.new_string('last4')))) {
							rt.echo_val(rt.call_function('sprintf', [
								rt.call_function('esc_html__', [
									rt.new_string('%1$s ending in %2$s'),
									rt.new_string('woocommerce'),
								]),
								rt.call_function('esc_html', [
									rt.call_function('wc_get_credit_card_type_label', [
										var_method.array_get(rt.new_string('method')).array_get(rt.new_string('brand')),
									]),
								]),
								rt.call_function('esc_html', [
									var_method.array_get(rt.new_string('method')).array_get(rt.new_string('last4')),
								]),
							]))
						} else {
							rt.echo_val(rt.call_function('esc_html', [
								rt.call_function('wc_get_credit_card_type_label', [
									var_method.array_get(rt.new_string('method')).array_get(rt.new_string('brand')),
								]),
							]))
						}
					} else if rt.is_true(rt.identical(rt.new_string('expires'), var_column_id)) {
						rt.echo_val(rt.call_function('esc_html', [
							var_method.array_get(rt.new_string('expires')),
						]))
					} else if rt.is_true(rt.identical(rt.new_string('actions'), var_column_id)) {
						mut iter_5 := var_method.array_get(rt.new_string('actions')).iterator()
						for {
							item_5 := iter_5.next() or { break }
							mut var_action := item_5.val
							mut var_key := item_5.key
							print('<a href="' +
								(rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))])).str() +
								'" class="button ' +
								(rt.call_function('sanitize_html_class', [var_key.clone()])).str() +
								'">' +
								(rt.call_function('esc_html', [var_action.array_get(rt.new_string('name'))])).str() +
								'</a>&nbsp;')
						}
					}
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_print_notice', [
			rt.call_function('esc_html__', [rt.new_string('No saved methods found.'),
				rt.new_string('woocommerce')]),
			rt.new_string('notice'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_account_payment_methods'),
		var_has_methods.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{}))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wc_get_endpoint_url', [rt.new_string('add-payment-method')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add payment method'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
}
