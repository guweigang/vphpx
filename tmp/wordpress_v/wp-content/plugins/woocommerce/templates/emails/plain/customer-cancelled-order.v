import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
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




pub fn init_wp_content_plugins_woocommerce_templates_emails_plain_customer_cancelled_order_php() {
	mut var_email_heading := rt.new_null()
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_email := rt.new_null()
	mut var_additional_content := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))
	print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n')
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [var_email_heading.dup()])]))
	print('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n')
	mut var_text := rt.call_function('__', [rt.new_string('We’re sorry to let you know that your order #%1$s has been cancelled.'), rt.new_string('woocommerce')])
	if rt.is_true(var_email_improvements_enabled) {
		var_text = rt.call_function('__', [rt.new_string('We’re getting in touch to let you know that your order #%1$s has been cancelled.'), rt.new_string('woocommerce')])
	}
	print((rt.call_function('sprintf', [rt.call_function('esc_html', [var_text.dup()]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})])])).str() + '\n\n')
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_details'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	print('\n----------------------------------------\n\n')
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_meta'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'), var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(), var_email.dup()])
	print('\n\n----------------------------------------\n\n')
	if rt.is_true(var_additional_content) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_function('wptexturize', [var_additional_content.dup()])])]))
		print('\n\n----------------------------------------\n\n')
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'), var_email.dup()])
}
