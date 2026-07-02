import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_data := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_option', [rt.new_string('blog_charset')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['css'])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['texts'].array_get(rt.new_string('receipt_title')))
	// unsupported statement: Stmt_InlineHTML
	print(var_data['texts'].array_get(rt.new_string('amount_paid_section_title')).to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['formatted_amount'])
	// unsupported statement: Stmt_InlineHTML
	print(var_data['texts'].array_get(rt.new_string('date_paid_section_title')).to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['formatted_date'])
	// unsupported statement: Stmt_InlineHTML
	print(var_data['texts'].array_get(rt.new_string('payment_status_section_title')).to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['texts'].array_get(rt.new_string('payment_status')))
	// unsupported statement: Stmt_InlineHTML
	if var_data.array_isset(rt.new_string('payment_method')) {
		// unsupported statement: Stmt_InlineHTML
		print(var_data['texts'].array_get(rt.new_string('payment_method_section_title')).to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_data['show_payment_method_title']) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_data['payment_method'])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_data['payment_info'].array_get(rt.new_string('card_last4'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_data['payment_info'].array_get(rt.new_string('card_last4')))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_data['texts'].array_get(rt.new_string('summary_section_title')).to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_data['formatted_line_items'].iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_formatted_line_item := item_1.val
		rt.echo_val(var_formatted_line_item)
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_data['notes'])) {
		// unsupported statement: Stmt_InlineHTML
		print(var_data['texts'].array_get(rt.new_string('order_notes_section_title')).to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_data['notes'].iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_note := item_2.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_note.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if !(!rt.is_true(var_data['payment_info'].array_get(rt.new_string('app_name'))))
		|| !(!rt.is_true(var_data['payment_info'].array_get(rt.new_string('aid'))))
		|| !(!rt.is_true(var_data['payment_info'].array_get(rt.new_string('account_type')))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_data['payment_info'].array_get(rt.new_string('app_name'))) {
			print(
				(var_data['texts'].array_get(rt.new_string('app_name'))).str() + ': ' + (var_data['payment_info'].array_get(rt.new_string('app_name'))).str() + '<br/>')
		}
		if rt.is_true(var_data['payment_info'].array_get(rt.new_string('aid'))) {
			print(
				(var_data['texts'].array_get(rt.new_string('aid'))).str() + ': ' + (var_data['payment_info'].array_get(rt.new_string('aid'))).str() + '<br/>')
		}
		if rt.is_true(var_data['payment_info'].array_get(rt.new_string('account_type'))) {
			print((var_data['texts'].array_get(rt.new_string('account_type'))).str() + ': ' +
				(var_data['payment_info'].array_get(rt.new_string('account_type'))).str())
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
