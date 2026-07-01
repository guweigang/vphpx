import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_customer_fulfillment_deleted_php() {
	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_order := rt.new_null()
	mut var_fulfillment := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'), var_email_heading.dup(), var_email.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('We wanted to let you know that one of the previously fulfilled shipments from your order has been removed from our system. This may have been due to a correction or an update in our fulfillment records. Don’t worry — this won’t affect any items you’ve already received.'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_details'), var_order.dup(), var_fulfillment.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_meta'), var_order.dup(), var_fulfillment.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	if rt.is_true(var_additional_content) {
		print('<table border="0" cellpadding="0" cellspacing="0" width="100%" role="presentation"><tr><td class="email-additional-content">')
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [var_additional_content.dup()])])]))
		print('</td></tr></table>')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'), var_email.dup()])
}
