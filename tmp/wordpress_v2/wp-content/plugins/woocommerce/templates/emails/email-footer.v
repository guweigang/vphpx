import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	mut var_email := if !(var_email).is_null() { var_email } else { rt.new_null() }
	// unsupported statement: Stmt_InlineHTML
	mut var_email_footer_text := rt.call_function('get_option', [rt.new_string('woocommerce_email_footer_text')])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_email_preview'), rt.new_bool(false)])) {
	mut var_text_transient := rt.call_function('get_transient', [rt.new_string('woocommerce_email_footer_text')])
	var_email_footer_text = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_text_transient)))) { var_text_transient } else { var_email_footer_text }
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [rt.call_function('apply_filters', [rt.new_string('woocommerce_email_footer_text'), var_email_footer_text.clone(), var_email.clone()])])])]))
	// unsupported statement: Stmt_InlineHTML
}
