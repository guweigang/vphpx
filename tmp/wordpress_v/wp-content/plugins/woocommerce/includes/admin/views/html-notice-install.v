import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_install_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<strong>Welcome to WooCommerce</strong> &#8211; You&lsquo;re almost ready to start selling :)'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-setup')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Run the Setup Wizard'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('install')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Skip setup'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
