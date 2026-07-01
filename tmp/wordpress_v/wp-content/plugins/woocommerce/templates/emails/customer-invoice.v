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

pub fn init_wp_content_plugins_woocommerce_templates_emails_customer_invoice_php() {
	mut var_email_heading := rt.new_null()
	mut var_email := rt.new_null()
	mut var_order := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	mut var_additional_content := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_email_improvements_enabled := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('email_improvements'))
	rt.call_function('do_action', [rt.new_string('woocommerce_email_header'),
		var_email_heading.dup(), var_email.dup()])
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
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'has_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.failed(),
		]))
		{
			rt.call_function('printf', [
				rt.call_function('wp_kses', [
					rt.call_function('__', [
						rt.new_string('Sorry, your order on %1$s was unsuccessful. Your order details are below, with a link to try your payment again: %2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'a', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.new_array() },
						]) },
					]),
				]),
				rt.call_function('esc_html', [
					rt.call_function('get_bloginfo', [
						rt.new_string('name'),
						rt.new_string('display'),
					]),
				]),
				'<a href="' +
					(rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])).str() +
					'">' +
					(rt.call_function('esc_html__', [rt.new_string('Pay for this order'), rt.new_string('woocommerce')])).str() +
					'</a>',
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('wp_kses', [
					rt.call_function('__', [
						rt.new_string('An order has been created for you on %1$s. Your order details are below, with a link to make payment when you’re ready: %2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'a', val: rt.create_array([
							rt.ArrayItem{ key: 'href', val: rt.new_array() },
						]) },
					]),
				]),
				rt.call_function('esc_html', [
					rt.call_function('get_bloginfo', [
						rt.new_string('name'),
						rt.new_string('display'),
					]),
				]),
				'<a href="' +
					(rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])).str() +
					'">' +
					(rt.call_function('esc_html__', [rt.new_string('Pay for this order'), rt.new_string('woocommerce')])).str() +
					'</a>',
			])
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('Here are the details of your order placed on %s:'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_function('wc_format_datetime', [
					rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
				]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	print(if rt.is_true(var_email_improvements_enabled) { '</div>' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_details'),
		var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(),
		var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_order_meta'),
		var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(),
		var_email.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_customer_details'),
		var_order.dup(), var_sent_to_admin.dup(), var_plain_text.dup(),
		var_email.dup()])
	if rt.is_true(var_additional_content) {
		print(if rt.is_true(var_email_improvements_enabled) {
			'<table border="0" cellpadding="0" cellspacing="0" width="100%" role="presentation"><tr><td class="email-additional-content">'
		} else {
			''
		})
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wpautop', [
				rt.call_function('wptexturize', [var_additional_content.dup()]),
			]),
		]))
		print(if rt.is_true(var_email_improvements_enabled) { '</td></tr></table>' } else { '' })
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_email_footer'),
		var_email.dup()])
}
