import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	rt.PhpObjectBase
pub mut:
	total_items             rt.PhpVal = rt.new_int(0)
	total_active_items      rt.PhpVal = rt.new_int(0)
	total_pending_items     rt.PhpVal = rt.new_int(0)
	total_cancelled_items   rt.PhpVal = rt.new_int(0)
	total_sent_items        rt.PhpVal = rt.new_int(0)
	has_stock_notifications bool
	data_store              rt.PhpVal = rt.new_null()
	eligibility_service     rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService) {
	this.eligibility_service = var_eligibility_service
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) construct() {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('stock_notification'))
	this.data_store = iife_result_0
	this.has_stock_notifications = rt.greater(rt.call_method(this.data_store, 'query', [
		rt.create_array([rt.ArrayItem{ key: 'return', val: 'count' }]),
	]), rt.new_int(0))
	this.Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'woocommerce_stock_notification' },
		rt.ArrayItem{ key: 'plural', val: 'woocommerce_stock_notifications' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_cb(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('Select %s'),
			rt.new_string('woocommerce')]),
		rt.call_function('esc_html', [rt.call_method(var_notification_mutated, 'get_id',
			[]rt.PhpVal{})]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [
		rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_id(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_actions := rt.create_array([
		rt.ArrayItem{ key: 'edit', val: rt.call_function('sprintf', [
			rt.new_string('<a href="' +
				(rt.call_function('admin_url', [rt.new_string((Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() +
				'&notification_action=edit&notification_id=%d')])).str() + '">%s</a>'),
			rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}),
			rt.call_function('__', [
				rt.new_string('Edit'),
				rt.new_string('woocommerce'),
			]),
		]) },
		rt.ArrayItem{ key: 'delete', val: rt.call_function('sprintf', [
			rt.new_string('<a href="' +
				(rt.call_function('wp_nonce_url', [rt.call_function('admin_url', [rt.new_string((Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() +
				'&notification_action=delete&notification_id=%d')]), rt.new_string('delete_customer_stock_notification')])).str() +
				'">%s</a>'),
			rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}),
			rt.call_function('__', [
				rt.new_string('Delete'),
				rt.new_string('woocommerce'),
			]),
		]) },
	])
	mut var_title := rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})
	rt.call_function('printf', [
		rt.new_string('<a class="row-title" href="%s" aria-label="%s">#%s</a>%s'),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string(
					(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() +
					'&notification_action=edit&notification_id=' +
					(rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})).str()),
			]),
		]),
		rt.call_function('sprintf', [
			rt.call_function('esc_attr__', [
				rt.new_string('&#8220;%s&#8221; (Edit)'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_attr', [
				var_title.clone(),
			]),
		]),
		rt.call_function('esc_html', [
			var_title.clone(),
		]),
		rt.call_function('wp_kses_post', [
			this.row_actions(var_actions.clone()),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_status(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()))
	{
		mut var_status := rt.new_string('cancelled')
		mut var_label := rt.call_function('_x', [rt.new_string('Pending'),
			rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status',
		[]rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled()))
	{
		var_status = rt.new_string('cancelled')
		var_label = rt.call_function('_x', [rt.new_string('Cancelled'),
			rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status',
		[]rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent()))
	{
		var_status = rt.new_string('cancelled')
		var_label = rt.call_function('_x', [rt.new_string('Sent'),
			rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else {
		var_status = rt.new_string('completed')
		var_label = rt.call_function('_x', [rt.new_string('Active'),
			rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	}
	rt.call_function('printf', [
		rt.new_string('<mark class="order-status %s"><span>%s</span></mark>'),
		rt.call_function('esc_attr', [
			rt.call_function('sanitize_html_class', [
				rt.new_string('status-' + var_status.str()),
			]),
		]),
		rt.call_function('esc_html', [
			var_label.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_user(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	if rt.is_true(rt.call_method(var_notification_mutated, 'get_user_id', []rt.PhpVal{})) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			rt.call_method(var_notification_mutated, 'get_user_id', []rt.PhpVal{})])
	}
	if !var_user.is_null() && rt.is_true(var_user) {
		rt.call_function('printf', [rt.new_string('<a href="%s" target="_blank">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('get_edit_user_link', [rt.get_property(var_user, 'ID')]),
			]),
			rt.call_function('esc_html', [
				rt.get_property(var_user, 'display_name'),
			])])
	} else {
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_method(var_notification_mutated, 'get_user_email', []rt.PhpVal{}),
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_product(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product.clone(), rt.new_string('WC_Product')])))))
	{
		print('&mdash;')
		return
	}
	mut var_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
	mut var_formatted_variation_list := this.get_product_formatted_variation_list(rt.new_bool(true))
	if rt.is_true(var_formatted_variation_list) {
		var_name = rt.concat(var_name, rt.new_string('<span class="description">' +
			var_formatted_variation_list.str() + '</span>'))
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('sprintf', [
			rt.new_string('<a target="_blank" href="' +
				(rt.call_function('admin_url', [rt.new_string('post.php?post=%d&action=edit')])).str() +
				'">%s</a>'),
			if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) { rt.call_function('absint', [
					rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}),
				]) } else { rt.call_function('absint', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				]) },
			var_name.clone(),
		]),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_sku(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	mut var_sku := rt.new_bool(false)
	if rt.is_true(rt.call_function('is_a', [var_product.clone(),
		rt.new_string('WC_Product')]))
	{
		var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	}
	if rt.is_true(var_sku) {
		rt.echo_val(rt.call_function('wp_kses_post', [var_sku.clone()]))
	} else {
		print('&mdash;')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_date_created_gmt(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_date_created := rt.call_method(var_notification_mutated, 'get_date_created',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_created)))) {
		mut var_t_time := rt.call_function('__', [rt.new_string('&mdash;'),
			rt.new_string('woocommerce')])
		mut var_h_time := var_t_time.clone()
	} else {
		var_date_created = rt.call_method(var_date_created, 'getTimestamp', []rt.PhpVal{})
		var_t_time = rt.call_function('date_i18n', [
			rt.call_function('_x', [rt.new_string('Y/m/d g:i:s a'),
				rt.new_string('list table date hover format'),
				rt.new_string('woocommerce')]),
			var_date_created.clone(),
		])
		var_h_time = rt.call_function('date_i18n', [
			rt.call_function('wc_date_format', []rt.PhpVal{}),
			var_date_created.clone(),
		])
	}
	print('<span title="' + (rt.call_function('esc_attr', [var_t_time.clone()])).str() + '">' +
		(rt.call_function('esc_html', [var_h_time.clone()])).str() + '</span>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) no_items() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('No Notifications found'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.new_array()
	var_columns.array_set('cb', '<input type="checkbox" />')
	var_columns.array_set('id', rt.call_function('_x', [rt.new_string('Notification'),
		rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('status', rt.call_function('_x', [rt.new_string('Status'),
		rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('user', rt.call_function('_x', [rt.new_string('User/Email'),
		rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('product', rt.call_function('_x', [
		rt.new_string('Product'), rt.new_string('column_name'),
		rt.new_string('woocommerce')]))
	var_columns.array_set('sku', rt.call_function('_x', [rt.new_string('SKU'),
		rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('date_created_gmt', rt.call_function('_x', [
		rt.new_string('Signed Up'),
		rt.new_string('column_name'),
		rt.new_string('woocommerce'),
	]))
	return var_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_sortable_columns() rt.PhpVal {
	mut var_sortable_columns := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: true },
		]) },
		rt.ArrayItem{ key: 'product', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'product_id' },
			rt.ArrayItem{ key: none, val: true },
		]) },
	])
	return var_sortable_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	var_actions.array_set('enable', rt.call_function('__', [rt.new_string('Activate'),
		rt.new_string('woocommerce')]))
	var_actions.array_set('cancel', rt.call_function('__', [rt.new_string('Cancel'),
		rt.new_string('woocommerce')]))
	var_actions.array_set('delete', rt.call_function('__', [
		rt.new_string('Delete permanently'),
		rt.new_string('woocommerce'),
	]))
	return var_actions.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) prepare_items() {
	mut var_per_page := rt.new_int((rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('stock_notifications_per_page'),
		rt.new_bool(true),
	])).to_i64())
	var_per_page = if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) {
		var_per_page
	} else {
		rt.new_int(10)
	}
	mut var_columns := this.get_columns()
	mut var_hidden := rt.new_array()
	mut var_sortable := this.get_sortable_columns()
	this.dispatch_set_prop('_column_headers', rt.create_array([
		rt.ArrayItem{ key: none, val: var_columns },
		rt.ArrayItem{ key: none, val: var_hidden },
		rt.ArrayItem{ key: none, val: var_sortable },
	]))
	mut var_paged := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.call_function('max', [
			rt.new_int(0),
			rt.new_int((rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged')),
			])).to_i64()) - 1,
		]) } else { rt.new_int(0) }
	mut var_orderby := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby')) && rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))]), rt.func_array_keys(this.get_sortable_columns()), rt.new_bool(true)])) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))]),
		]) } else { rt.new_string('id') }
	mut var_order := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) && rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))]), rt.create_array([rt.ArrayItem{
		key: none
		val: 'asc'
	}, rt.ArrayItem{ key: none, val: 'desc' }]), rt.new_bool(true)])) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))]),
		]) } else { rt.new_string('desc') }
	mut var_query_args := rt.create_array([
		rt.ArrayItem{ key: 'order_by', val: rt.create_array([
			rt.ArrayItem{ key: var_orderby, val: var_order },
		]) },
		rt.ArrayItem{ key: 'limit', val: var_per_page },
		rt.ArrayItem{ key: 'offset', val: rt.mul(var_paged, var_per_page) },
	])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) {
		var_query_args.array_set('user_email', rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('active_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		var_query_args.array_set('status',
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active())
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('sent_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		var_query_args.array_set('status',
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('cancelled_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		var_query_args.array_set('status',
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('pending_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		var_query_args.array_set('status',
			Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('m')))) {
		mut var_filter := rt.call_function('absint', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_GET').array_get(rt.new_string('m'))]),
		])
		mut var_month := rt.call_function('substr', [rt.new_string(var_filter.str()),
			rt.new_int(4), rt.new_int(6)])
		mut var_year := rt.call_function('substr', [rt.new_string(var_filter.str()),
			rt.new_int(0), rt.new_int(4)])
		mut var_start_timestamp := rt.call_function('mktime', [
			rt.new_int(0), rt.new_int(0), rt.new_int(0), rt.new_int(var_month.to_i64()),
			rt.new_int(1), rt.new_int(var_year.to_i64())])
		var_query_args.array_set('start_date', rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			var_start_timestamp.clone(),
		]))
		mut var_end_timestamp := rt.call_function('mktime', [
			rt.new_int(0), rt.new_int(0), rt.new_int(0), rt.new_int(var_month.to_i64()) + 1,
			rt.new_int(1), rt.new_int(var_year.to_i64())])
		var_query_args.array_set('end_date', rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			var_end_timestamp.clone(),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_product_filter')))) {
		var_filter = rt.call_function('absint', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_product_filter')),
			]),
		])
		mut var_product := rt.call_function('wc_get_product', [
			var_filter.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_product,
			'Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Product')))
		{
			mut var_target_ids := rt.call_method(this.eligibility_service,
				'get_target_product_ids', [var_product.clone()])
			var_query_args.array_set('product_id', var_target_ids.clone())
		} else {
			mut iife_temp_1 :=
				Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
			mut iife_result_1 := iife_temp_1.add_notice(rt.call_function('__', [
				rt.new_string('Invalid product selected.'),
				rt.new_string('woocommerce'),
			]), rt.new_string('error'))
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_customer_filter')))) {
		var_filter = rt.call_function('absint', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_customer_filter')),
			]),
		])
		var_query_args.array_set('user_id', rt.create_array([
			rt.ArrayItem{ key: none, val: var_filter },
		]))
	}
	var_query_args.array_set('return', 'objects')
	this.dispatch_set_prop('items', rt.call_method(this.data_store, 'query', [
		var_query_args.clone()]))
	var_query_args.array_set('return', 'count')
	var_query_args.array_unset(rt.new_string('limit'))
	var_query_args.array_unset(rt.new_string('offset'))
	this.total_items = rt.call_method(this.data_store, 'query', [
		var_query_args.clone()])
	var_query_args.array_set('status',
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active())
	this.total_active_items = rt.call_method(this.data_store, 'query', [
		var_query_args.clone()])
	var_query_args.array_set('status',
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())
	this.total_sent_items = rt.call_method(this.data_store, 'query', [
		var_query_args.clone()])
	var_query_args.array_set('status',
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())
	this.total_cancelled_items = rt.call_method(this.data_store, 'query', [
		var_query_args.clone()])
	var_query_args.array_set('status',
		Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())
	this.total_pending_items = rt.call_method(this.data_store, 'query', [
		var_query_args.clone()])
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: this.total_items },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
		rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [
			rt.div(this.total_items, var_per_page),
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) extra_tablenav(var_which rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('top'), var_which))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		this.render_filters()
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Filter'), rt.new_string('woocommerce')]),
			rt.new_string(''),
			rt.new_string('filter_action'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) render_filters() {
	this.display_months_dropdown()
	this.display_customer_dropdown()
	this.display_product_dropdown()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_product_dropdown() {
	mut var_product_string := rt.new_string('')
	mut var_product_id := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_product_filter')))) {
		var_product_id = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_product_filter')),
			]),
		])
		mut var_product := rt.call_function('wc_get_product', [
			rt.call_function('absint', [var_product_id.clone()]),
		])
		if rt.is_true(var_product) {
			var_product_string = rt.call_function('sprintf', [
				rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s)'),
					rt.new_string('woocommerce')]),
				if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) {
					rt.call_method(var_product, 'get_name', []rt.PhpVal{})
				} else {
					rt.call_method(var_product, 'get_title', []rt.PhpVal{})
				},
				rt.call_function('absint', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Select product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_product_string) && rt.is_true(var_product_id) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_product_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('htmlspecialchars', [var_product_string.clone(),
				rt.get_constant('ENT_COMPAT')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_customer_dropdown() {
	mut var_user_string := rt.new_string('')
	mut var_user_id := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_customer_filter')))) {
		var_user_id = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('customer_stock_notifications_customer_filter')),
			]),
		])
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'),
			rt.call_function('absint', [var_user_id.clone()])])
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
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Select customer&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_string) && rt.is_true(var_user_id) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_user_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('htmlspecialchars', [var_user_string.clone(),
				rt.get_constant('ENT_COMPAT')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_views() rt.PhpVal {
	mut var_status_links := rt.new_array()
	mut var_class := rt.new_string((if
		!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('all_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		'current'
	} else {
		''
	}).str())
	mut var_all_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'),
			rt.new_string('All <span class="count">(%s)</span>'), this.total_items,
			rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
		rt.call_function('number_format_i18n', [this.total_items]),
	])
	var_status_links.array_set('all', this.get_link(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'all_customer_stock_notifications' },
	]), var_all_inner_html.clone(), var_class.str()))
	var_class = rt.new_string((if
		!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('active_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		'current'
	} else {
		''
	}).str())
	mut var_active_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [rt.new_string('Active <span class="count">(%s)</span>'),
			rt.new_string('Active <span class="count">(%s)</span>'), this.total_active_items,
			rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
		rt.call_function('number_format_i18n', [this.total_active_items]),
	])
	var_status_links.array_set('active', this.get_link(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'active_customer_stock_notifications' },
	]), var_active_inner_html.clone(), var_class.str()))
	var_class = rt.new_string((if
		!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('sent_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		'current'
	} else {
		''
	}).str())
	mut var_sent_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [rt.new_string('Sent <span class="count">(%s)</span>'),
			rt.new_string('Sent <span class="count">(%s)</span>'), this.total_sent_items,
			rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
		rt.call_function('number_format_i18n', [this.total_sent_items]),
	])
	var_status_links.array_set('sent', this.get_link(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'sent_customer_stock_notifications' },
	]), var_sent_inner_html.clone(), var_class.str()))
	var_class = rt.new_string((if
		!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('cancelled_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		'current'
	} else {
		''
	}).str())
	mut var_cancelled_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [
			rt.new_string('Cancelled <span class="count">(%s)</span>'),
			rt.new_string('Cancelled <span class="count">(%s)</span>'),
			this.total_cancelled_items,
			rt.new_string('notifications_status'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('number_format_i18n', [
			this.total_cancelled_items,
		]),
	])
	var_status_links.array_set('cancelled', this.get_link(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'cancelled_customer_stock_notifications' },
	]), var_cancelled_inner_html.clone(), var_class.str()))
	var_class = rt.new_string((if
		!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('status'))))
		&& rt.is_true(rt.identical(rt.new_string('pending_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('status')))) {
		'current'
	} else {
		''
	}).str())
	mut var_pending_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [
			rt.new_string('Pending <span class="count">(%s)</span>'),
			rt.new_string('Pending <span class="count">(%s)</span>'),
			this.total_pending_items,
			rt.new_string('notifications_status'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('number_format_i18n', [
			this.total_pending_items,
		]),
	])
	var_status_links.array_set('pending', this.get_link(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'pending_customer_stock_notifications' },
	]), var_pending_inner_html.clone(), var_class.str()))
	return var_status_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_link(var_args rt.PhpVal, var_label rt.PhpVal, css_class string) rt.PhpVal {
	mut var_label_mutated := var_label
	mut var_url := rt.call_function('add_query_arg', [var_args.clone()])
	mut var_class_html := rt.new_string('')
	mut var_aria_current := rt.new_string('')
	if !(css_class == '') {
		var_class_html = rt.call_function('sprintf', [rt.new_string(' class="%s"'),
			rt.call_function('esc_attr', [rt.new_string(css_class)])])
		if rt.is_true(rt.identical(rt.new_string('current'), rt.new_string(css_class))) {
			var_aria_current = rt.new_string(' aria-current="page"')
		}
	}
	return rt.call_function('sprintf', [rt.new_string('<a href="%s"%s%s>%s</a>'),
		rt.call_function('esc_url', [var_url.clone()]), var_class_html.clone(),
		var_aria_current.clone(), var_label_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_months_dropdown() {
	mut var_wp_locale := rt.new_null()
	mut var_months := rt.call_method(this.data_store, 'get_distinct_dates', []rt.PhpVal{})
	if !(var_months.clone().is_array()) {
		return
	}
	mut var_month_count := rt.new_int(var_months.clone().array_count())
	if rt.is_true(rt.less(var_month_count, rt.new_int(1))) {
		return
	}
	mut var_m := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('m')) { rt.new_int((rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('m')),
		])).to_i64()) } else { 0 })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by date'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_m.clone(), rt.new_int(0)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('All dates'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_months.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arc_row := item_1.val
		if 0 == rt.new_int((rt.get_property(var_arc_row, 'year')).to_i64())
			|| 0 == rt.new_int((rt.get_property(var_arc_row, 'month')).to_i64()) {
			continue
		}
		mut var_month := rt.call_function('zeroise', [
			rt.get_property(var_arc_row, 'month'),
			rt.new_int(2),
		])
		mut var_year := rt.get_property(var_arc_row, 'year')
		rt.call_function('printf', [
			rt.new_string("<option %s value='%s'>%s</option>\n"),
			rt.call_function('selected', [var_m.clone(),
				rt.new_string(var_year.str() + var_month.str()),
				rt.new_bool(false)]),
			rt.call_function('esc_attr', [
				rt.new_string((rt.get_property(var_arc_row, 'year')).str() + var_month.str()),
			]),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('%1$s %2$d'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_wp_locale, 'get_month', [
						var_month.clone()]),
				]),
				rt.call_function('esc_html', [
					var_year.clone(),
				]),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_actions() {
	this.process_delete_action()
	this.process_bulk_action()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_delete_action() {
	mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('notification_action')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('notification_action')),
			]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('delete'), var_action)))) {
		return
	}
	mut var_notification_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('notification_id')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('notification_id')),
		]) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notification_id)))) {
		return
	}
	rt.call_function('check_admin_referer', [
		rt.new_string('delete_customer_stock_notification'),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
	mut iife_result_2 := iife_temp_2.get_notification(var_notification_id.clone())
	mut var_notification := iife_result_2
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(this.data_store, 'delete', [var_notification.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_notice_message := rt.call_function('__', [
		rt.new_string('Notification deleted.'),
		rt.new_string('woocommerce'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
	mut iife_result_3 := iife_temp_3.add_notice(var_notice_message.clone(),
		rt.new_string('success'))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_Admin_Exception') {
		mut var_e := var_e_1.clone()
		var_notice_message = rt.call_function('__', [
			rt.new_string('Notification not found.'),
			rt.new_string('woocommerce'),
		])
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
		mut iife_result_4 := iife_temp_4.add_notice(var_notice_message.clone(),
			rt.new_string('error'))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.call_function('wp_safe_redirect', [
		rt.call_function('admin_url', [
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url(),
		]),
	])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_bulk_action() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.current_action())))) {
		return
	}
	rt.call_function('check_admin_referer', [
		rt.new_string('bulk-' +(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable', ['Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table'], &this), '_args').array_get(rt.new_string('plural'))).str()),
	])
	mut var_notifications := if rt.get_superglobal('_GET').array_isset(rt.new_string('notification')) && rt.get_superglobal('_GET').array_get(rt.new_string('notification')).is_array() { rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.get_superglobal('_GET').array_get(rt.new_string('notification')),
		]) } else { rt.new_array() }
	if !rt.is_true(var_notifications) {
		return
	}
	mut var_redirect_url :=
		Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()
	if rt.is_true(rt.identical(rt.new_string('enable'), this.current_action())) {
		mut iter_2 := var_notifications.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_id := item_2.val
			mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
			mut iife_result_5 := iife_temp_5.get_notification(var_id.clone())
			mut var_notification := iife_result_5
			rt.call_method(var_notification, 'set_status', [
				Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active(),
			])
			rt.call_method(this.data_store, 'update', [var_notification.clone()])
		}
		mut var_notice_message := rt.call_function('sprintf', [
			rt.call_function('_nx', [rt.new_string('%s notification updated.'),
				rt.new_string('%s notifications updated.'),
				rt.new_int(var_notifications.clone().array_count()),
				rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
			rt.new_int(var_notifications.clone().array_count()),
		])
		mut iife_temp_6 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
		mut iife_result_6 := iife_temp_6.add_notice(var_notice_message.clone(),
			rt.new_string('success'))
	} else if rt.is_true(rt.identical(rt.new_string('cancel'), this.current_action())) {
		mut iter_3 := var_notifications.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_id := item_3.val
			mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
			mut iife_result_7 := iife_temp_7.get_notification(var_id.clone())
			mut var_notification := iife_result_7
			rt.call_method(var_notification, 'set_status', [
				Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled(),
			])
			rt.call_method(this.data_store, 'update', [var_notification.clone()])
		}
		var_notice_message = rt.call_function('sprintf', [
			rt.call_function('_nx', [rt.new_string('%s notification updated.'),
				rt.new_string('%s notifications updated.'),
				rt.new_int(var_notifications.clone().array_count()),
				rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
			rt.new_int(var_notifications.clone().array_count()),
		])
		mut iife_temp_8 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
		mut iife_result_8 := iife_temp_8.add_notice(var_notice_message.clone(),
			rt.new_string('success'))
	} else if rt.is_true(rt.identical(rt.new_string('delete'), this.current_action())) {
		mut iter_4 := var_notifications.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_id := item_4.val
			mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
			mut iife_result_9 := iife_temp_9.get_notification(var_id.clone())
			mut var_notification := iife_result_9
			rt.call_method(this.data_store, 'delete', [var_notification.clone()])
		}
		var_notice_message = rt.call_function('sprintf', [
			rt.call_function('_nx', [rt.new_string('%s notification deleted.'),
				rt.new_string('%s notifications deleted.'),
				rt.new_int(var_notifications.clone().array_count()),
				rt.new_string('notifications_status'), rt.new_string('woocommerce')]),
			rt.new_int(var_notifications.clone().array_count()),
		])
		mut iife_temp_10 :=
			Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{}
		mut iife_result_10 := iife_temp_10.add_notice(var_notice_message.clone(),
			rt.new_string('success'))
	}
	rt.call_function('wp_safe_redirect', [var_redirect_url.clone()])
	exit(0)
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_listtable() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable{
		PhpObjectBase:           rt.PhpObjectBase{}
		total_items:             rt.new_int(0)
		total_active_items:      rt.new_int(0)
		total_pending_items:     rt.new_int(0)
		total_cancelled_items:   rt.new_int(0)
		total_sent_items:        rt.new_int(0)
		has_stock_notifications: false
		data_store:              rt.new_null()
		eligibility_service:     rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_wp_list_table(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_notificationspage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_id(dispatch_arg_0)
			return rt.new_null()
		}
		'column_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_status(dispatch_arg_0)
			return rt.new_null()
		}
		'column_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_user(dispatch_arg_0)
			return rt.new_null()
		}
		'column_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_product(dispatch_arg_0)
			return rt.new_null()
		}
		'column_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_sku(dispatch_arg_0)
			return rt.new_null()
		}
		'column_date_created_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_date_created_gmt(dispatch_arg_0)
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'render_filters' {
			this.render_filters()
			return rt.new_null()
		}
		'display_product_dropdown' {
			this.display_product_dropdown()
			return rt.new_null()
		}
		'display_customer_dropdown' {
			this.display_customer_dropdown()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'get_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'display_months_dropdown' {
			this.display_months_dropdown()
			return rt.new_null()
		}
		'process_actions' {
			this.process_actions()
			return rt.new_null()
		}
		'process_delete_action' {
			this.process_delete_action()
			return rt.new_null()
		}
		'process_bulk_action' {
			this.process_bulk_action()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'total_items' { return this.total_items }
		'total_active_items' { return this.total_active_items }
		'total_pending_items' { return this.total_pending_items }
		'total_cancelled_items' { return this.total_cancelled_items }
		'total_sent_items' { return this.total_sent_items }
		'has_stock_notifications' { return rt.new_bool(this.has_stock_notifications) }
		'data_store' { return this.data_store }
		'eligibility_service' { return this.eligibility_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'total_items' {
			this.total_items = val
			return true
		}
		'total_active_items' {
			this.total_active_items = val
			return true
		}
		'total_pending_items' {
			this.total_pending_items = val
			return true
		}
		'total_cancelled_items' {
			this.total_cancelled_items = val
			return true
		}
		'total_sent_items' {
			this.total_sent_items = val
			return true
		}
		'has_stock_notifications' {
			this.has_stock_notifications = val.to_bool()
			return true
		}
		'data_store' {
			this.data_store = val
			return true
		}
		'eligibility_service' {
			this.eligibility_service = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
