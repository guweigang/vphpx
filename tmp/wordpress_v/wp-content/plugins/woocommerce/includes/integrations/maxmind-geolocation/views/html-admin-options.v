import rt



pub fn init_wp_content_plugins_woocommerce_includes_integrations_maxmind_geolocation_views_html_admin_options_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Database File Path'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Database File Path'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(rt.new_object('', []string{}, &this), 'database_service'), 'get_database_path', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('The location that the MaxMind database should be stored. By default, the integration will automatically save the database here.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
