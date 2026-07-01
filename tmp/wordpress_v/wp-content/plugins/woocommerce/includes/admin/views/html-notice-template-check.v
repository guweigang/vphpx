import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_notice_template_check_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('template_files')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('<strong>Your theme (%s) contains outdated copies of some WooCommerce template files.</strong> These files may need updating to ensure they are compatible with the current version of WooCommerce. Suggestions to fix this:'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_html', [
			var_theme.array_get('Name'),
		]),
	])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Update your theme to the latest version. If no update is available contact your theme author asking about compatibility with the current WooCommerce version.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('If you copied over a template file to change something, then you will need to copy the new version of the template and apply your changes again.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more about templates'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-status#status-table-templates'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View affected templates'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
