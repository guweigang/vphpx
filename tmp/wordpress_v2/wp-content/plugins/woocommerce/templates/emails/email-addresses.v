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

	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_address := rt.call_method(var_order, 'get_formatted_billing_address', []rt.PhpVal{})
	mut var_shipping := rt.call_method(var_order, 'get_formatted_shipping_address', []rt.PhpVal{})
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	mut var_email_improvements_enabled := iife_result_0
	mut var_display_section_divider := rt.new_bool((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_body_display_section_divider'),
		rt.new_bool(true),
	])).to_bool())
	if rt.is_true(var_display_section_divider) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '0' } else { '40px' })
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_email_improvements_enabled) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Billing address'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Billing address'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [if rt.is_true(var_address) { var_address } else { rt.call_function('esc_html__', [
			rt.new_string('N/A'),
			rt.new_string('woocommerce'),
		]) }]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_make_phone_clickable', [
			rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_customer_address_section'),
		rt.new_string('billing'),
		var_order.clone(),
		var_sent_to_admin.clone(),
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(var_order, 'needs_shipping_address', []rt.PhpVal{}))
		&& rt.is_true(var_shipping) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_email_improvements_enabled) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Shipping address'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Shipping address'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_shipping.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_make_phone_clickable', [
				rt.call_method(var_order, 'get_shipping_phone', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_email_customer_address_section'),
			rt.new_string('shipping'),
			var_order.clone(),
			var_sent_to_admin.clone(),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_email_improvements_enabled) { '<br>' } else { '' })
}
