import rt



pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_templates_html_admin_notification_edit_php() {
	mut var_notification := rt.new_null()
	mut var_signed_up_customers := rt.new_null()
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit Notification'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View All'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'notification_action', val: 'create' }]), Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add New'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-customer-stock-notification-edit'), rt.new_string('customer_stock_notification_edit_security')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Notification actions'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an action...'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Send'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Resend verification email'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Activate'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Activate'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Activate'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Apply'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('admin_url', [rt.call_function('sprintf', [(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() + '&notification_action=delete&notification_id=%d', rt.call_method(var_notification, 'get_id', []rt.PhpVal{})])]), rt.new_string('delete_customer_stock_notification')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Update'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Notification #%d details'), rt.new_string('woocommerce')]), rt.call_method(var_notification, 'get_id', []rt.PhpVal{})])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())) {
		mut var_notification_status := 'cancelled'
		mut var_label := rt.call_function('_x', [rt.new_string('Pending'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())) {
		var_notification_status = 'cancelled'
		var_label = rt.call_function('_x', [rt.new_string('Cancelled'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())) {
		var_notification_status = 'cancelled'
		var_label = rt.call_function('_x', [rt.new_string('Sent'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else {
		var_notification_status = 'completed'
		var_label = rt.call_function('_x', [rt.new_string('Active'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	}
	rt.call_function('printf', [rt.new_string('<mark class="order-status %s"><span>%s</span></mark>'), rt.call_function('esc_attr', [rt.call_function('sanitize_html_class', ['status-' + var_notification_status])]), rt.call_function('esc_html', [var_label.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_user_string := rt.new_string(rt.new_string('&mdash;'))
	mut var_user_id := rt.call_method(var_notification, 'get_user_id', []rt.PhpVal{})
	mut var_user := if rt.is_true(var_user_id) { rt.call_function('get_user_by', [rt.new_string('id'), var_user_id.dup()]) } else { rt.new_null() }
	if rt.is_true(rt.call_function('is_a', [var_user.dup(), rt.new_string('WP_User')])) {
		var_user_string = rt.get_property(var_user, 'display_name')
	} else if rt.is_true(rt.call_function('filter_var', [rt.call_method(var_notification, 'get_user_email', []rt.PhpVal{}), rt.get_constant('FILTER_VALIDATE_EMAIL')])) {
		var_user_string = rt.call_method(var_notification, 'get_user_email', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_user_string.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(var_user).is_null() && rt.is_true(rt.call_function('is_a', [var_user.dup(), rt.new_string('WP_User')])))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_edit_user_link', [rt.get_property(var_user, 'ID')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('View profile &rarr;'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() + '&s=' + (rt.call_function('rawurlencode', [rt.call_method(var_notification, 'get_user_email', []rt.PhpVal{})])).str()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View notifications &rarr;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_product := rt.call_method(var_notification, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')])) {
		rt.include_file(@DIR + '/html-product-data-admin.php', '1')
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Product not found.'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Waiting'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_notification, 'get_date_created', []rt.PhpVal{}))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_t_time := rt.call_function('__', [rt.new_string('&mdash;'), rt.new_string('woocommerce')])
		mut var_h_time := var_t_time.dup()
		mut var_time_diff := rt.new_int(rt.new_int(0))
	} else {
		mut var_date_created_timestamp := rt.call_method(rt.call_method(, 'get_date_created', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})
		var_t_time = rt.call_function('date_i18n', [, .dup()])
		var_time_diff = 
		if rt.is_true() {
		} else {
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}
