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
	mut var_partial_refund := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.clone(), var_email.clone()])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) {
		'<div class="email-introduction">'
	} else {
		''
	})
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
			rt.call_function('esc_html__', [rt.new_string('Hi,'),
				rt.new_string('woocommerce')]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		if rt.is_true(var_partial_refund) {
			print(
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your order from %s has been partially refunded.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_blogname.clone()])])).str() +
				'\n\n')
		} else {
			print(
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your order from %s has been refunded.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_blogname.clone()])])).str() +
				'\n\n')
		}
		print('</p><p>')
		print(
			(rt.call_function('esc_html__', [rt.new_string('Here’s a reminder of what you’ve ordered:'), rt.new_string('woocommerce')])).str() +
			'\n\n')
	} else if rt.is_true(var_partial_refund) {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('Your order on %s has been partially refunded. There are more details below for your reference:'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_blogname.clone(),
			]),
		])
	} else {
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('Your order on %s has been refunded. There are more details below for your reference:'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				var_blogname.clone(),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '</div>' } else { '' })
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
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.clone()])
}
