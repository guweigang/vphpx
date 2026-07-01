import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_update_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_update_url := rt.call_function('wp_nonce_url', [
		rt.call_function('add_query_arg', [rt.new_string('do_update_woocommerce'),
			rt.new_string('true'),
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings'),
			])]),
		rt.new_string('wc_db_update'),
		rt.new_string('wc_db_update_nonce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('WooCommerce database update required'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('WooCommerce has been updated! To keep things running smoothly, we have to update your database to the newest version.'),
		rt.new_string('woocommerce'),
	])
	rt.call_function('printf', [
		' ' +(rt.call_function('esc_html__', [rt.new_string('The database update process runs in the background and may take a little while, so please be patient. Advanced users can alternatively update via %1$sWP CLI%2$s.'), rt.new_string('woocommerce')])).str(),
		rt.new_string('<a href="https://developer.woocommerce.com/docs/wc-cli/wc-cli-examples/#upgrading-the-database-using-wp-cli">'),
		rt.new_string('</a>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_update_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update WooCommerce Database'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about updates'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
