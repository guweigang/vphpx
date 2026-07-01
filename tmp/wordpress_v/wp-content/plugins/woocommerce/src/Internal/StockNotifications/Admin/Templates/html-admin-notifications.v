import rt

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_templates_html_admin_notifications_php() {
	mut var_table := rt.new_null()
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Stock Notifications'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'notification_action', val: 'create' }]),
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add New'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_property(var_table, 'has_stock_notifications')) {
		rt.call_method(var_table, 'views', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Search Notifications'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr__', [
			rt.new_string('Search by user e-mail'),
			rt.new_string('woocommerce'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('esc_attr', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')]),
				]),
			]) } else { rt.new_string('') })
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Search'),
			rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('page')) { rt.call_function('esc_attr', [
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('page')]),
				]),
			]) } else { rt.new_string('') })
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_table, 'display', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('No customers have signed up to receive stock notifications from you just yet.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Learn more'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
