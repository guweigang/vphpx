import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_email_customer_details_php() {
	mut var_fields := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if !(!rt.is_true(var_fields)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Customer details'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_fields.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [var_field.array_get('label')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [var_field.array_get('value')]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
