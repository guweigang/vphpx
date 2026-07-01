import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_maxmind_license_key_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('maxmind_license_key')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Geolocation has not been configured.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You must enter a valid license key on the <a href="%1$s">MaxMind integration settings page</a> in order to use the geolocation service. If you do not need geolocation for shipping or taxes, you should change the default customer location on the <a href="%2$s">general settings page</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=integration&section=maxmind_geolocation')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=general')])])]))
	// unsupported statement: Stmt_InlineHTML
}
