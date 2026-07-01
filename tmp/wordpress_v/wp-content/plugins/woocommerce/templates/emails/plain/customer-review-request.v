import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_customer_review_request_php() {
	mut var_email_heading := rt.new_null()
	mut var_order := rt.new_null()
	mut var_review_order_url := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [var_email_heading.dup()])]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	if !(!rt.is_true(rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}))) {
		print((rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Hi %s,'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{})])])).str() + '\n\n')
	} else {
		print((rt.call_function('esc_html__', [rt.new_string('Hi,'), rt.new_string('woocommerce')])).str() + '\n\n')
	}
	print((rt.call_function('esc_html__', [rt.new_string('We’d love to know what you thought of the products you ordered. Your review helps other shoppers make better decisions and helps us improve.'), rt.new_string('woocommerce')])).str() + '\n\n')
	if !(!rt.is_true(var_review_order_url)) {
		print((rt.call_function('esc_html__', [rt.new_string('Leave a review:'), rt.new_string('woocommerce')])).str() + '\n')
		print((rt.call_function('esc_url', [var_review_order_url.dup()])).str() + '\n\n')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		mut var_date_created := rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})
		rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Order #%1$s (%2$s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]), rt.call_function('esc_html', [if rt.is_true(var_date_created) { rt.call_function('wc_format_datetime', [var_date_created.dup()]) } else { rt.new_string('') }])])
		print('\n\n')
	}
	print('----------------------------------------\n\n')
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_function('wptexturize', [var_additional_content.dup()])])]))
		print('\n\n----------------------------------------\n\n')
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_email_footer_text'), rt.call_function('get_option', [rt.new_string('woocommerce_email_footer_text')])])]))
	// unsupported statement: Stmt_Nop
}
