import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	mut var_fulfillment := rt.new_null()
	mut var_customer_note := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if !(!var_order.is_null() && !var_fulfillment.is_null()) {
		return rt.new_null()
	}
	mut var_customer_note_text := if rt.is_true(rt.call_function('is_scalar', [if !var_customer_note.is_null() {
		var_customer_note
	} else {
		rt.new_null()
	}]))
	{ var_customer_note.str().trim_space()
	 } else { ''
	 }
	if rt.is_true(rt.new_bool('' != var_customer_note_text)) {
		print('<p><strong>' +
			(rt.call_function('esc_html__', [rt.new_string('Note from the store:'), rt.new_string('woocommerce')])).str() +
			'</strong></p>')
		print('<blockquote>' +
			(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [rt.new_string(var_customer_note_text.str()).clone()])])])).str() +
			'</blockquote>')
	}
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
}
