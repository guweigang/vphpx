import rt

pub fn init_wp_content_plugins_woocommerce_templates_myaccount_dashboard_php() {
	mut var_current_user := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	mut var_allowed_html := {
		'a': {
			'href': map[string]rt.PhpVal{}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('wp_kses', [
			rt.call_function('__', [
				rt.new_string('Hello %1$s (not %1$s? <a href="%2$s">Log out</a>)'),
				rt.new_string('woocommerce'),
			]),
			var_allowed_html.dup(),
		]),
		'<strong>' +
			(rt.call_function('esc_html', [rt.get_property(var_current_user, 'display_name')])).str() +
			'</strong>',
		rt.call_function('esc_url', [
			rt.call_function('wc_logout_url', []rt.PhpVal{}),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_dashboard_desc := rt.call_function('__', [
		rt.new_string('From your account dashboard you can view your <a href="%1$s">recent orders</a>, manage your <a href="%2$s">billing address</a>, and <a href="%3$s">edit your password and account details</a>.'),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		var_dashboard_desc = rt.call_function('__', [
			rt.new_string('From your account dashboard you can view your <a href="%1$s">recent orders</a>, manage your <a href="%2$s">shipping and billing addresses</a>, and <a href="%3$s">edit your password and account details</a>.'),
			rt.new_string('woocommerce'),
		])
	}
	rt.call_function('printf', [
		rt.call_function('wp_kses', [var_dashboard_desc.dup(),
			var_allowed_html.dup()]),
		rt.call_function('esc_url', [rt.call_function('wc_get_endpoint_url', [
			rt.new_string('orders'),
		])]),
		rt.call_function('esc_url', [
			rt.call_function('wc_get_endpoint_url', [
				rt.new_string('edit-address'),
			]),
		]),
		rt.call_function('esc_url', [
			rt.call_function('wc_get_endpoint_url', [
				rt.new_string('edit-account'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_account_dashboard')])
	rt.call_function('do_action', [rt.new_string('woocommerce_before_my_account')])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_my_account')])
	// unsupported statement: Stmt_Nop
}
