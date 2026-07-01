import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_email_customer_details_php() {
	mut var_fields := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	print((rt.call_function('esc_html', [rt.call_function('wc_strtoupper', [rt.call_function('esc_html__', [rt.new_string('Customer details'), rt.new_string('woocommerce')])])])).str() + '\n\n')
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			print((rt.call_function('wp_kses_post', [var_field.array_get('label')])).str() + ': ' + (rt.call_function('wp_kses_post', [var_field.array_get('value')])).str() + '\n')
		}
	}
}
