import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_additional_content := rt.new_null()
	mut var_pos_store_email := rt.new_null()
	mut var_pos_store_phone_number := rt.new_null()
	mut var_pos_store_address := rt.new_null()
	mut var_pos_store_name := rt.new_null()
	mut var_pos_refund_returns_policy := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	rt.call_function('do_action', [rt.new_string('woocommerce_pos_email_header'),
		var_email_heading.clone(), var_email.clone()])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}))) {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Hi %s,'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [
				rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}),
			]),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Hi there,'),
				rt.new_string('woocommerce')]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Here’s a reminder of what you’ve bought:'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_details'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_meta'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'),
		var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
		var_email.clone()])
	if rt.is_true(var_additional_content) {
		print(if rt.is_true(var_email_improvements_enabled) {
			'<table border="0" cellpadding="0" cellspacing="0" width="100%" role="presentation"><tr><td class="email-additional-content">'
		} else {
			''
		})
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_additional_content.clone()]),
			]),
		]))
		print(if rt.is_true(var_email_improvements_enabled) { '</td></tr></table>' } else { '' })
	}
	if !(!rt.is_true(var_pos_store_email)) || !(!rt.is_true(var_pos_store_phone_number))
		|| !(!rt.is_true(var_pos_store_address)) {
		print('<div class="pos-store-information">')
		if !(!rt.is_true(var_pos_store_name)) {
			print('<h2>' + (rt.call_function('esc_html', [var_pos_store_name.clone()])).str() +
				'</h2>')
		}
		if !(!rt.is_true(var_pos_store_email)) {
			print('<p>' + (rt.call_function('esc_html', [var_pos_store_email.clone()])).str() +
				'</p>')
		}
		if !(!rt.is_true(var_pos_store_phone_number)) {
			print('<p>' +
				(rt.call_function('esc_html', [var_pos_store_phone_number.clone()])).str() + '</p>')
		}
		if !(!rt.is_true(var_pos_store_address)) {
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('wpautop', [
					rt.call_function('wptexturize', [var_pos_store_address.clone()]),
				]),
			]))
		}
		print('</div>')
	}
	if !(!rt.is_true(var_pos_refund_returns_policy)) {
		print('<div class="refund-returns-policy">')
		print('<h2>' +
			(rt.call_function('esc_html__', [rt.new_string('Refund & Returns Policy'), rt.new_string('woocommerce')])).str() +
			'</h2>')
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_pos_refund_returns_policy.clone()]),
			]),
		]))
		print('</div>')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_pos_email_footer'),
		var_email.clone()])
}
