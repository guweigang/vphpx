import rt

pub fn init_wp_content_plugins_woocommerce_src_internal_receiptrendering_templates_order_receipt_php() {
	mut var_data := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_option', [rt.new_string('blog_charset')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('css'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('texts').array_get('receipt_title'))
	// unsupported statement: Stmt_InlineHTML
	print(var_data.array_get('texts').array_get('amount_paid_section_title').to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('formatted_amount'))
	// unsupported statement: Stmt_InlineHTML
	print(var_data.array_get('texts').array_get('date_paid_section_title').to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('formatted_date'))
	// unsupported statement: Stmt_InlineHTML
	print(var_data.array_get('texts').array_get('payment_status_section_title').to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data.array_get('texts').array_get('payment_status'))
	// unsupported statement: Stmt_InlineHTML
	if var_data.array_isset(rt.new_string('payment_method')) {
		// unsupported statement: Stmt_InlineHTML
		print(var_data.array_get('texts').array_get('payment_method_section_title').to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_data.array_get('show_payment_method_title')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_data.array_get('payment_method'))
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_data.array_get('payment_info').array_get('card_last4')) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_data.array_get('payment_info').array_get('card_last4'))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_data.array_get('texts').array_get('summary_section_title').to_string().to_upper())
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_data.array_get('formatted_line_items').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_formatted_line_item := item_1.val
			rt.echo_val(var_formatted_line_item)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_data.array_get('notes'))) {
		// unsupported statement: Stmt_InlineHTML
		print(var_data.array_get('texts').array_get('order_notes_section_title').to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_data.array_get('notes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_note := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_note.dup()]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	if !(!rt.is_true(var_data.array_get('payment_info').array_get('app_name')))
		|| !(!rt.is_true(var_data.array_get('payment_info').array_get('aid')))
		|| !(!rt.is_true(var_data.array_get('payment_info').array_get('account_type'))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_data.array_get('payment_info').array_get('app_name')) {
			print(
				(var_data.array_get('texts').array_get('app_name')).str() + ': ' + (var_data.array_get('payment_info').array_get('app_name')).str() + '<br/>')
		}
		if rt.is_true(var_data.array_get('payment_info').array_get('aid')) {
			print(
				(var_data.array_get('texts').array_get('aid')).str() + ': ' + (var_data.array_get('payment_info').array_get('aid')).str() + '<br/>')
		}
		if rt.is_true(var_data.array_get('payment_info').array_get('account_type')) {
			print((var_data.array_get('texts').array_get('account_type')).str() + ': ' +
				(var_data.array_get('payment_info').array_get('account_type')).str())
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
