import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_download_dir_sync_complete_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'), rt.new_string('download_directories_sync_complete')]), rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_settings_screen_link := rt.new_string('<a href="' + (rt.call_function('esc_url', [rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('admin.php?page=wc-settings&tab=products&section=download_urls')])])).str() + '">')
	mut var_documentation_link := '<a href="https://woocommerce.com/document/approved-download-directories">'
	mut var_closing_link := '</a>'
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('The %1$sApproved Product Download Directories list%2$s has been updated. To protect your site, please review the list and make any changes that might be required. For more information, please refer to %3$sthis guide%2$s.'), rt.new_string('woocommerce')]), var_settings_screen_link.dup(), rt.new_string(var_closing_link).dup(), rt.new_string(var_documentation_link).dup()])
	// unsupported statement: Stmt_InlineHTML
}
