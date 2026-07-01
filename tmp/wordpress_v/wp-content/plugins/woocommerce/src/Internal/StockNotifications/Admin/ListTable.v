import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	rt.PhpObjectBase
pub mut:
		total_items rt.PhpVal = rt.new_int(0)
		total_active_items rt.PhpVal = rt.new_int(0)
		total_pending_items rt.PhpVal = rt.new_int(0)
		total_cancelled_items rt.PhpVal = rt.new_int(0)
		total_sent_items rt.PhpVal = rt.new_int(0)
		has_stock_notifications bool
		data_store rt.PhpVal = rt.new_null()
		eligibility_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) init(mut var_eligibility_service Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService)  {
	this.eligibility_service = var_eligibility_service.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) construct()  {
	this.data_store = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('stock_notification'))
	this.has_stock_notifications = rt.greater(rt.call_method(this.data_store, 'query', [rt.create_array([rt.ArrayItem{ key: 'return', val: 'count' }])]), rt.new_int(0))
	this.Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'woocommerce_stock_notification' }, rt.ArrayItem{ key: 'plural', val: 'woocommerce_stock_notifications' }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_cb(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('Select %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_id(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'edit', val: rt.call_function('sprintf', ['<a href="' + (rt.call_function('admin_url', [(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() + '&notification_action=edit&notification_id=%d'])).str() + '">%s</a>', rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}), rt.call_function('__', [rt.new_string('Edit'), rt.new_string('woocommerce')])]) }, rt.ArrayItem{ key: 'delete', val: rt.call_function('sprintf', ['<a href="' + (rt.call_function('wp_nonce_url', [rt.call_function('admin_url', [(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() + '&notification_action=delete&notification_id=%d']), rt.new_string('delete_customer_stock_notification')])).str() + '">%s</a>', rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{}), rt.call_function('__', [rt.new_string('Delete'), rt.new_string('woocommerce')])]) }])
	mut var_title := rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})
	rt.call_function('printf', [rt.new_string('<a class="row-title" href="%s" aria-label="%s">#%s</a>%s'), rt.call_function('esc_url', [rt.call_function('admin_url', [(Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_NotificationsPage.page_url()).str() + '&notification_action=edit&notification_id=' + (rt.call_method(var_notification_mutated, 'get_id', []rt.PhpVal{})).str()])]), rt.call_function('sprintf', [rt.call_function('esc_attr__', [rt.new_string('&#8220;%s&#8221; (Edit)'), rt.new_string('woocommerce')]), rt.call_function('esc_attr', [var_title.dup()])]), rt.call_function('esc_html', [var_title.dup()]), rt.call_function('wp_kses_post', [this.row_actions(var_actions.dup())])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_status(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())) {
		mut var_status := rt.new_string(rt.new_string('cancelled'))
		mut var_label := rt.call_function('_x', [rt.new_string('Pending'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())) {
		var_status = rt.new_string(rt.new_string('cancelled'))
		var_label = rt.call_function('_x', [rt.new_string('Cancelled'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.identical(rt.call_method(var_notification_mutated, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())) {
		var_status = rt.new_string(rt.new_string('cancelled'))
		var_label = rt.call_function('_x', [rt.new_string('Sent'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	} else {
		var_status = rt.new_string(rt.new_string('completed'))
		var_label = rt.call_function('_x', [rt.new_string('Active'), rt.new_string('stock notification status'), rt.new_string('woocommerce')])
	}
	rt.call_function('printf', [rt.new_string('<mark class="order-status %s"><span>%s</span></mark>'), rt.call_function('esc_attr', [rt.call_function('sanitize_html_class', ['status-' + (var_status).str()])]), rt.call_function('esc_html', [var_label.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_user(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	if rt.is_true(rt.call_method(var_notification_mutated, 'get_user_id', []rt.PhpVal{})) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('id'), rt.call_method(var_notification_mutated, 'get_user_id', []rt.PhpVal{})])
	}
	if rt.is_true(rt.new_bool(!(var_user).is_null() && rt.is_true(var_user))) {
		rt.call_function('printf', [rt.new_string('<a href="%s" target="_blank">%s</a>'), rt.call_function('esc_url', [rt.call_function('get_edit_user_link', [rt.get_property(var_user, 'ID')])]), rt.call_function('esc_html', [rt.get_property(var_user, 'display_name')])])
	} else {
		rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_notification_mutated, 'get_user_email', []rt.PhpVal{})]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_product(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')]))))) {
		print('&mdash;')
		return rt.new_null()
	}
	mut var_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
	mut var_formatted_variation_list := this.get_product_formatted_variation_list(rt.new_bool(true))
	if rt.is_true(var_formatted_variation_list) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', ['<a target="_blank" href="' + (rt.call_function('admin_url', [rt.new_string('post.php?post=%d&action=edit')])).str() + '">%s</a>', if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) { rt.call_function('absint', [rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})]) } else { rt.call_function('absint', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]) }, var_name.dup()])]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_sku(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	mut var_sku := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')])) {
		var_sku = rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	}
	if rt.is_true(var_sku) {
		rt.echo_val(rt.call_function('wp_kses_post', [var_sku.dup()]))
	} else {
		print('&mdash;')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) column_date_created_gmt(var_notification rt.PhpVal)  {
	mut var_notification_mutated := var_notification
	mut var_date_created := rt.call_method(var_notification_mutated, 'get_date_created', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_created)))) {
		mut var_t_time := rt.call_function('__', [rt.new_string('&mdash;'), rt.new_string('woocommerce')])
		mut var_h_time := var_t_time.dup()
	} else {
		var_date_created = rt.call_method(var_date_created, 'getTimestamp', []rt.PhpVal{})
		var_t_time = rt.call_function('date_i18n', [rt.call_function('_x', [rt.new_string('Y/m/d g:i:s a'), rt.new_string('list table date hover format'), rt.new_string('woocommerce')]), var_date_created.dup()])
		var_h_time = rt.call_function('date_i18n', [rt.call_function('wc_date_format', []rt.PhpVal{}), var_date_created.dup()])
	}
	print('<span title="' + (rt.call_function('esc_attr', [var_t_time.dup()])).str() + '">' + (rt.call_function('esc_html', [var_h_time.dup()])).str() + '</span>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) no_items()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('No Notifications found'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.new_array()
	var_columns.array_set('cb', '<input type="checkbox" />')
	var_columns.array_set('id', rt.call_function('_x', [rt.new_string('Notification'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('status', rt.call_function('_x', [rt.new_string('Status'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('user', rt.call_function('_x', [rt.new_string('User/Email'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('product', rt.call_function('_x', [rt.new_string('Product'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('sku', rt.call_function('_x', [rt.new_string('SKU'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	var_columns.array_set('date_created_gmt', rt.call_function('_x', [rt.new_string('Signed Up'), rt.new_string('column_name'), rt.new_string('woocommerce')]))
	return var_columns.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_sortable_columns() rt.PhpVal {
	mut var_sortable_columns := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: 'product', val: rt.create_array([rt.ArrayItem{ key: none, val: 'product_id' }, rt.ArrayItem{ key: none, val: true }]) }])
	return var_sortable_columns.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	var_actions.array_set('enable', rt.call_function('__', [rt.new_string('Activate'), rt.new_string('woocommerce')]))
	var_actions.array_set('cancel', rt.call_function('__', [rt.new_string('Cancel'), rt.new_string('woocommerce')]))
	var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')]))
	return var_actions.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) prepare_items()  {
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	var_per_page = if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) { var_per_page } else { rt.new_int(10) }
	mut var_columns := this.get_columns()
	mut var_hidden := rt.new_array()
	mut var_sortable := this.get_sortable_columns()
	this.dispatch_set_prop('_column_headers', rt.create_array([rt.ArrayItem{ key: none, val: var_columns }, rt.ArrayItem{ key: none, val: var_hidden }, rt.ArrayItem{ key: none, val: var_sortable }]))
	mut var_paged := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.call_function('max', [rt.new_int(0), rt.sub(// unsupported expression: Expr_Cast_Int, rt.new_int(1))]) } else { rt.new_int(0) }
	mut var_orderby := if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby')) && rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('orderby')]), rt.func_array_keys(this.get_sortable_columns()), rt.new_bool(true)])))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('orderby')])]) } else { rt.new_string('id') }
	mut var_order := if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) && rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('order')]), rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]), rt.new_bool(true)])))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('order')])]) } else { rt.new_string('desc') }
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'order_by', val: rt.create_array([rt.ArrayItem{ key: var_orderby, val: var_order }]) }, rt.ArrayItem{ key: 'limit', val: var_per_page }, rt.ArrayItem{ key: 'offset', val: rt.mul(var_paged, var_per_page) }])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) && !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		var_query_args.array_set('user_email', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])]))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('status'))) && rt.is_true(rt.identical(rt.new_string('active_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get('status'))))) {
		var_query_args.array_set('status', Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.active())
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('status'))) && rt.is_true(rt.identical(rt.new_string('sent_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get('status'))))) {
		var_query_args.array_set('status', Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.sent())
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('status'))) && rt.is_true(rt.identical(rt.new_string('cancelled_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get('status'))))) {
		var_query_args.array_set('status', Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.cancelled())
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('status'))) && rt.is_true(rt.identical(rt.new_string('pending_customer_stock_notifications'), rt.get_superglobal('_REQUEST').array_get('status'))))) {
		var_query_args.array_set('status', Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending())
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('m'))) {
		mut var_filter := rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('m')])])
		mut var_month := rt.call_function('substr', [// unsupported expression: Expr_Cast_String, rt.new_int(4), rt.new_int(6)])
		mut var_year := rt.call_function('substr', [// unsupported expression: Expr_Cast_String, rt.new_int(0), rt.new_int(4)])
		mut var_start_timestamp := rt.call_function('mktime', [rt.new_int(0), rt.new_int(0), rt.new_int(0), // unsupported expression: Expr_Cast_Int, rt.new_int(1), // unsupported expression: Expr_Cast_Int])
		var_query_args.array_set('start_date', rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_start_timestamp.dup()]))
		mut var_end_timestamp := rt.call_function('mktime', [, , , , , ])
		.array_set(, )
	}
	if !(!rt.is_true(.array_get())) {
		
	}
	if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) extra_tablenav(var_which rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) render_filters()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_product_dropdown()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_customer_dropdown()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_views() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) get_link(var_args rt.PhpVal, var_label rt.PhpVal, css_class string) rt.PhpVal {
	mut var_label_mutated := var_label
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) display_months_dropdown()  {
	mut var_wp_locale := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_actions()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_delete_action()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) process_bulk_action()  {
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_listtable() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable{
		PhpObjectBase: rt.PhpObjectBase{}
		total_items: rt.new_int(0)
		total_active_items: rt.new_int(0)
		total_pending_items: rt.new_int(0)
		total_cancelled_items: rt.new_int(0)
		total_sent_items: rt.new_int(0)
		has_stock_notifications: false
		data_store: rt.new_null()
		eligibility_service: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_wp_list_table() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_admin_wc_data_store() &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Admin_ListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_EligibilityService](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'total_items' { this.total_items = val; return true }
		'total_active_items' { this.total_active_items = val; return true }
		'total_pending_items' { this.total_pending_items = val; return true }
		'total_cancelled_items' { this.total_cancelled_items = val; return true }
		'total_sent_items' { this.total_sent_items = val; return true }
		'has_stock_notifications' { this.has_stock_notifications = (val).to_bool(); return true }
		'data_store' { this.data_store = val; return true }
		'eligibility_service' { this.eligibility_service = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_admin_listtable_php() {
	// unsupported statement: Stmt_Declare
}
