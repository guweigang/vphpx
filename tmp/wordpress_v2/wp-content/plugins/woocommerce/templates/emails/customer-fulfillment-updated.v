import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_customer_note := rt.new_null()
	mut var_order := rt.new_null()
	mut var_fulfillment := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.clone(), var_email.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Some details of your shipment have recently been updated. This may include tracking information, item contents, or delivery status.'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Here’s the latest info we have:'),
		rt.new_string('woocommerce'),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_customer_note_text := if rt.is_true(rt.call_function('is_scalar', [if !var_customer_note.is_null() {
		var_customer_note
	} else {
		rt.new_null()
	}]))
	{ var_customer_note.str().trim_space()
	 } else { ''
	 }
	if rt.is_true(rt.new_bool('' != var_customer_note_text)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [
			rt.new_string('Note from the store:'),
			rt.new_string('woocommerce'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize',
					[rt.new_string(var_customer_note_text.str()).clone()]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_fulfillment_details'),
		var_order.clone(),
		var_fulfillment.clone(),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_fulfillment_meta'),
		var_order.clone(), var_fulfillment.clone(), var_sent_to_admin.clone(),
		var_plain_text.clone(), var_email.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	if rt.is_true(var_additional_content) {
		print('<table border="0" cellpadding="0" cellspacing="0" width="100%" role="presentation"><tr><td class="email-additional-content">')
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_additional_content.clone()]),
			]),
		]))
		print('</td></tr></table>')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.clone()])
}
