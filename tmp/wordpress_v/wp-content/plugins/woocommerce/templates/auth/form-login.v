import rt



pub fn init_wp_content_plugins_woocommerce_templates_auth_form_login_php() {
	mut var_app_name := rt.new_null()
	mut var_return_url := rt.new_null()
	mut var_redirect_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_auth_page_header')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%s would like to connect to your store'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_app_name.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('To connect to %1$s you need to be logged in. Log in to your store below, or <a href="%2$s">cancel and return to %1$s</a>'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('wc_clean', [var_app_name.dup()])]), rt.call_function('esc_url', [var_return_url.dup()])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Username or email address'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Required'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(rt.get_superglobal('_POST').array_get('username'))) { rt.call_function('esc_attr', [rt.get_superglobal('_POST').array_get('username')]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Password'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Required'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-login'), rt.new_string('woocommerce-login-nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Login'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Login'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_redirect_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_auth_page_footer')])
}
