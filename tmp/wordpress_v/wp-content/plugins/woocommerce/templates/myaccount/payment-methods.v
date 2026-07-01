import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_payment_methods_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_saved_methods := rt.call_function('wc_get_customer_saved_methods_list', [rt.call_function('get_current_user_id', []rt.PhpVal{})])
	mut var_has_methods := // unsupported expression: Expr_Cast_Bool
	mut var_types := rt.call_function('wc_get_account_payment_methods_types', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_before_account_payment_methods'), var_has_methods.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_methods) {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := rt.call_function('wc_get_account_payment_methods_columns', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_column_name := item_1.val
				mut var_column_id := item_1.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_column_id.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_column_name.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_saved_methods.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_methods := item_1.val
				mut var_type := item_1.key
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_2 := var_methods.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_method := item_2.val
						// unsupported statement: Stmt_InlineHTML
						print(if !(!rt.is_true(var_method.array_get('is_default'))) { ' default-payment-method' } else { '' })
						// unsupported statement: Stmt_InlineHTML
						{
							mut iter_3 := rt.call_function('wc_get_account_payment_methods_columns', []rt.PhpVal{}).iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_column_name := item_3.val
								mut var_column_id := item_3.key
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [var_column_id.dup()]))
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [var_column_id.dup()]))
								// unsupported statement: Stmt_InlineHTML
								rt.echo_val(rt.call_function('esc_attr', [var_column_name.dup()]))
								// unsupported statement: Stmt_InlineHTML
								if rt.is_true(rt.call_function('has_action', ['woocommerce_account_payment_methods_column_' + (var_column_id).str()])) {
									rt.call_function('do_action', ['woocommerce_account_payment_methods_column_' + (var_column_id).str(), var_method.dup()])
								} else if rt.is_true(rt.identical(rt.new_string('method'), var_column_id)) {
									if !(!rt.is_true(var_method.array_get('method').array_get('last4'))) {
										rt.echo_val(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s ending in %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('wc_get_credit_card_type_label', [var_method.array_get('method').array_get('brand')])]), rt.call_function('esc_html', [var_method.array_get('method').array_get('last4')])]))
									} else {
										rt.echo_val(rt.call_function('esc_html', [rt.call_function('wc_get_credit_card_type_label', [var_method.array_get('method').array_get('brand')])]))
									}
								} else if rt.is_true(rt.identical(rt.new_string('expires'), var_column_id)) {
									rt.echo_val(rt.call_function('esc_html', [var_method.array_get('expires')]))
								} else if rt.is_true(rt.identical(rt.new_string('actions'), var_column_id)) {
									{
										mut iter_4 := var_method.array_get('actions').iterator()
										for {
											item_4 := iter_4.next() or { break }
											mut var_action := item_4.val
											mut var_key := item_4.key
											print('<a href="' + (rt.call_function('esc_url', [var_action.array_get('url')])).str() + '" class="button ' + (rt.call_function('sanitize_html_class', [var_key.dup()])).str() + '">' + (rt.call_function('esc_html', [var_action.array_get('name')])).str() + '</a>&nbsp;')
										}
									}
								}
								// unsupported statement: Stmt_InlineHTML
							}
						}
						// unsupported statement: Stmt_InlineHTML
					}
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_print_notice', [rt.call_function('esc_html__', [rt.new_string('No saved methods found.'), rt.new_string('woocommerce')]), rt.new_string('notice')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_account_payment_methods'), var_has_methods.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('wc_get_endpoint_url', [rt.new_string('add-payment-method')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add payment method'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
}
