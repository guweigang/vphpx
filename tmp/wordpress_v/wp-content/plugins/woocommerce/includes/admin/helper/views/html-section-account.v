import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_section_account_php() {
	mut var_refresh_url := rt.new_null()
	mut var_auth_user_data := map[string]rt.PhpVal{}
	mut var_disconnect_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_refresh_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connected to WooCommerce.com'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_avatar', [var_auth_user_data.array_get('email'), rt.new_int(48)]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_auth_user_data.array_get('email')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('My Subscriptions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_disconnect_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Disconnect'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
