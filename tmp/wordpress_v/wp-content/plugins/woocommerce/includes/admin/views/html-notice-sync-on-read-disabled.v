import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_sync_on_read_disabled_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('hpos_sync_on_read_disabled')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('HPOS order "sync on read" has been disabled'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility mode for HPOS no longer pulls order changes made to the posts database back into your orders automatically. If your site uses custom code or plugins that modify orders outside of WooCommerce, this may affect how order data is handled. <a href="%s">Learn more about this change and what to do</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://developer.woocommerce.com/2026/02/16/hpos-sync-on-read-to-be-disabled-by-default-in-woocommerce-10-7/')])]))
	// unsupported statement: Stmt_InlineHTML
}
