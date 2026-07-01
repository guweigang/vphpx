import rt

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_templates_html_admin_notification_create_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add Notification'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View All'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [
		rt.new_string('woocommerce-customer-stock-notification-create'),
		rt.new_string('customer_stock_notification_create_security'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Notification actions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Choose an action...'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Apply'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Create'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Create'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Notification details'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_user_string := rt.new_string(rt.new_string(''))
	mut var_user_id := rt.new_int(rt.new_int(0))
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('user_id'))) {
		var_user_id = rt.call_function('absint', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('user_id')]),
		])
		if rt.is_true(rt.greater(var_user_id, rt.new_int(0))) {
			mut var_user := rt.call_function('get_user_by', [
				rt.new_string('id'), rt.call_function('absint', [
					var_user_id.dup()])])
			if rt.is_true(var_user) {
				var_user_string = rt.call_function('sprintf', [
					rt.call_function('esc_html__', [
						rt.new_string('%1$s (#%2$s &ndash; %3$s)'),
						rt.new_string('woocommerce'),
					]),
					rt.get_property(var_user, 'display_name'),
					rt.call_function('absint', [
						rt.get_property(var_user, 'ID'),
					]),
					rt.get_property(var_user, 'user_email'),
				])
			}
		}
	}
	mut var_email := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('user_email')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('user_email')]),
		]) } else { rt.new_string('') }
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a customer&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(var_user_string) && rt.is_true(var_user_id))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('htmlspecialchars', [var_user_string.dup(),
				rt.get_constant('ENT_COMPAT')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('&mdash;&nbsp;or&nbsp;&mdash;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enter customer e-mail&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_email.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_product_string := rt.new_string(rt.new_string(''))
	mut var_product_id := rt.new_int(rt.new_int(0))
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('product_id'))) {
		var_product_id = rt.call_function('absint', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('product_id')]),
		])
		if rt.is_true(rt.greater(var_product_id, rt.new_int(0))) {
			mut var_product := rt.call_function('wc_get_product', [
				var_product_id.dup()])
			if rt.is_true(rt.call_function('is_a', [var_product.dup(),
				rt.new_string('WC_Product')]))
			{
				var_product_string = rt.call_function('sprintf', [
					rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s)'),
						rt.new_string('woocommerce')]),
					if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) {
						rt.call_method(var_product, 'get_name', []rt.PhpVal{})
					} else {
						rt.call_method(var_product, 'get_title', []rt.PhpVal{})
					},
					rt.call_function('absint',
						[rt.call_method(var_product, 'get_id', []rt.PhpVal{})]),
				])
			}
		}
	}
	mut var_excluded_product_types := rt.call_function('array_diff', [
		rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})),
		rt.create_array([rt.ArrayItem{ key: none, val: 'simple' },
			rt.ArrayItem{ key: none, val: 'variable' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(','), var_excluded_product_types.dup()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Select product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(var_product_string) && rt.is_true(var_product_id))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_product_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('htmlspecialchars', [var_product_string.dup(),
				rt.get_constant('ENT_COMPAT')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
