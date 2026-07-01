import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_legacy_shipping_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('legacy_shipping')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('New:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping zones'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('a group of regions that can be assigned different shipping methods and rates.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Legacy shipping methods (flat rate, international flat rate, local pickup and delivery, and free shipping) are deprecated but will continue to work as normal for now. <b><em>They will be removed in future versions of WooCommerce</em></b>. We recommend disabling these and setting up new rates within shipping zones as soon as possible.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wc_admin_settings_page', []rt.PhpVal{}))))) || !rt.is_true(rt.get_superglobal('_GET').array_get('tab')))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Setup shipping zones'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about shipping zones'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
