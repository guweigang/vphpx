import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_helper_views_html_notice_woo_updater_not_activated_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('woo_updater_not_activated')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please <a href="%1$s">activate the WooCommerce.com Update Manager</a> to continue receiving the updates and streamlined support included in your WooCommerce.com subscriptions.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])])])]))
	// unsupported statement: Stmt_InlineHTML
}
