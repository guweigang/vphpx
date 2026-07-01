import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_no_shipping_methods_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('no_shipping_methods')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add shipping methods &amp; zones'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Shipping is currently enabled, but you have not added any shipping methods to your shipping zones.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Customers will not be able to purchase physical goods from your store until a shipping method is available.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=shipping'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Setup shipping zones'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about shipping zones'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
