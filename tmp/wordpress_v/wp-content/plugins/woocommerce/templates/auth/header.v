import rt



pub fn init_wp_content_plugins_woocommerce_templates_auth_header_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Application authentication request'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'http:' }, rt.ArrayItem{ key: none, val: 'https:' }]), rt.new_string(''), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/css/auth.css']))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/images/woo-logo.svg']))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
