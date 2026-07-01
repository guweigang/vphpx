import rt



pub fn init_wp_content_plugins_woocommerce_templates_auth_form_grant_access_php() {
	mut var_app_name := rt.new_null()
	mut var_scope := rt.new_null()
	mut var_permissions := rt.new_null()
	mut var_callback_url := rt.new_null()
	mut var_user := rt.new_null()
	mut var_logout_url := rt.new_null()
	mut var_granted_url := rt.new_null()
	mut var_return_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_auth_page_header')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%s would like to connect to your store'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_app_name.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('This will give "%1$s" %2$s access which will allow it to:'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('esc_html', [var_app_name.dup()])).str() + '</strong>', '<strong>' + (rt.call_function('esc_html', [var_scope.dup()])).str() + '</strong>'])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_permissions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_permission := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_permission.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Approving will share credentials with %s. Do not proceed if this looks suspicious in any way.'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('esc_html', [rt.call_function('wp_parse_url', [var_callback_url.dup(), rt.get_constant('PHP_URL_HOST')])])).str() + '</strong>'])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_avatar', [rt.get_property(var_user, 'ID'), rt.new_int(70)]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Logged in as %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_logout_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Logout'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_granted_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Approve'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_return_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Deny'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_auth_page_footer')])
}
