import rt



pub fn init_wp_content_plugins_woocommerce_templates_emails_block_general_block_content_for_fulfillment_emails_php() {
	mut var_order := rt.new_null()
	mut var_fulfillment := rt.new_null()
	mut var_customer_note := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if !(!(var_order).is_null() && !(var_fulfillment).is_null()) {
		return rt.new_null()
	}
	mut var_customer_note_text := if rt.is_true(rt.call_function('is_scalar', [if !(var_customer_note).is_null() { var_customer_note } else { rt.new_null() }])) { // unsupported expression: Expr_Cast_String.to_string().trim_space() } else { '' }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		print('<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Note from the store:'), rt.new_string('woocommerce')])).str() + '</strong></p>')
		print('<blockquote>' + (rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [rt.new_string(var_customer_note_text).dup()])])])).str() + '</blockquote>')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_details'), var_order.dup(), var_fulfillment.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_meta'), var_order.dup(), var_fulfillment.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
}
