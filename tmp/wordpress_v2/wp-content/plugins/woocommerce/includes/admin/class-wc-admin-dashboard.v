import rt

struct Class_WC_Admin_Dashboard {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Dashboard) construct() {
	if this.should_display_widget() {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
			rt.call_function('add_action', [rt.new_string('wp_network_dashboard_setup'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'register_network_order_widget' },
				])])
		} else {
			rt.call_function('add_action', [rt.new_string('wp_dashboard_setup'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'init' },
				])])
		}
	}
}

fn (mut this Class_WC_Admin_Dashboard) init() {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')]))
		&& rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')])) {
		rt.call_function('wp_add_dashboard_widget', [
			rt.new_string('woocommerce_dashboard_recent_reviews'),
			rt.call_function('__', [rt.new_string('WooCommerce Recent Reviews'),
				rt.new_string('woocommerce')]),
			rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard',
				[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'recent_reviews' }]),
		])
	}
	rt.call_function('wp_add_dashboard_widget', [
		rt.new_string('woocommerce_dashboard_status'),
		rt.call_function('__', [rt.new_string('WooCommerce Status'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'status_widget' }]),
	])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
		this.register_network_order_widget()
	}
}

fn (mut this Class_WC_Admin_Dashboard) register_network_order_widget() {
	rt.call_function('wp_add_dashboard_widget', [
		rt.new_string('woocommerce_network_orders'),
		rt.call_function('__', [rt.new_string('WooCommerce Network Orders'),
			rt.new_string('woocommerce')]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'network_orders' }]),
	])
}

fn (mut this Class_WC_Admin_Dashboard) should_display_widget() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'is_wc_admin_active', []rt.PhpVal{})))))
	{
		return false
	}
	mut var_has_permission := rt.new_bool(
		rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_woocommerce_reports')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')])))
	mut var_task_completed_or_hidden := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_task_list_complete')])))
		|| rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_task_list_hidden')]))))
	return rt.is_true(var_task_completed_or_hidden) && rt.is_true(var_has_permission)
}

fn (mut this Class_WC_Admin_Dashboard) get_top_seller() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.custom_orders_table_usage_is_enabled()
	mut var_hpos_enabled := iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.get_table_for_orders()
	mut var_orders_table := iife_result_1
	mut var_orders_column_id :=
		rt.new_string((if rt.is_true(var_hpos_enabled) { 'id' } else { 'ID' }).str())
	mut var_orders_column_type := rt.new_string((if rt.is_true(var_hpos_enabled) {
		'type'
	} else {
		'post_type'
	}).str())
	mut var_orders_column_status := rt.new_string((if rt.is_true(var_hpos_enabled) {
		'status'
	} else {
		'post_status'
	}).str())
	mut var_orders_column_date := rt.new_string((if rt.is_true(var_hpos_enabled) {
		'date_created_gmt'
	} else {
		'post_date_gmt'
	}).str())
	mut var_query := rt.new_array()
	var_query.array_set('fields',
		'SELECT SUM( order_item_meta.meta_value ) as qty, order_item_meta_2.meta_value as product_id FROM ${var_orders_table.to_string()} AS orders')
	var_query.array_set('join', rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('woocommerce_order_items AS order_items ON orders.')),
		var_orders_column_id), rt.new_string(' = order_id ')))
	var_query.array_get(rt.new_string('join')) = rt.concat(var_query.array_get(rt.new_string('join')), rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('woocommerce_order_itemmeta AS order_item_meta ON order_items.order_item_id = order_item_meta.order_item_id ')))
	var_query.array_get(rt.new_string('join')) = rt.concat(var_query.array_get(rt.new_string('join')), rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('woocommerce_order_itemmeta AS order_item_meta_2 ON order_items.order_item_id = order_item_meta_2.order_item_id ')))
	var_query.array_set('where',
		"WHERE orders.${var_orders_column_type.to_string()} IN ( '" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('wc_get_order_types', [rt.new_string('order-count')])])).str() +
		"' ) ")
	mut var_order_statuses := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_reports_order_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
		]),
	])
	var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')), rt.new_string(
		"AND orders.${var_orders_column_status.to_string()} IN ( 'wc-" + (rt.call_function('implode', [rt.new_string("','wc-"), var_order_statuses.clone()])).str() +
		"' ) "))
	var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')),
		rt.new_string("AND order_item_meta.meta_key = '_qty' "))
	var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')),
		rt.new_string("AND order_item_meta_2.meta_key = '_product_id' "))
	var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')), rt.new_string(
		"AND orders.${var_orders_column_date.to_string()} >= '" +
		(rt.call_function('gmdate', [rt.new_string('Y-m-01'), rt.call_function('current_time', [rt.new_string('timestamp')])])).str() +
		"' "))
	var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')), rt.new_string(
		"AND orders.${var_orders_column_date.to_string()} <= '" +
		(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_function('current_time', [rt.new_string('timestamp')])])).str() +
		"' "))
	var_query.array_set('groupby', 'GROUP BY product_id')
	var_query.array_set('orderby', 'ORDER BY qty DESC')
	var_query.array_set('limits', 'LIMIT 1')
	var_query = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_dashboard_status_widget_top_seller_query'),
		var_query.clone(),
	])
	mut var_sql := rt.call_function('implode', [rt.new_string(' '),
		var_query.clone()])
	return rt.call_method(var_wpdb, 'get_row', [var_sql.clone()])
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Dashboard) status_widget() {
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_2) { '' } else { '.min' }).str())
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_3
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-status-widget'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-status-widget' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wc-flot' }]),
		var_version.clone(), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-status-widget-async'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-status-widget-async' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		var_version.clone(), rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('wc-status-widget-async'),
		rt.new_string('wc_status_widget_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			]) },
			rt.ArrayItem{ key: 'security', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc-status-widget'),
			]) },
			rt.ArrayItem{ key: 'error_message', val: rt.call_function('esc_html__', [
				rt.new_string('Error loading widget'),
				rt.new_string('woocommerce'),
			]) },
		])])
	print('<div id="wc-status-widget-loading" class="wc-status-widget-loading">')
	print('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('Loading status data...'), rt.new_string('woocommerce')])).str() +
		' <span class="spinner is-active"></span></p>')
	print('</div>')
	print('<div id="wc-status-widget-content" style="display:none;"></div>')
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_content() {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_4 := iife_temp_4.is_enabled(rt.new_string('analytics'))
	mut var_is_wc_admin_disabled := rt.new_bool(
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_disabled'), rt.new_bool(false)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))))
	mut var_status_widget_reports := rt.create_array([
		rt.ArrayItem{
			key: 'net_sales_link'
			val: 'admin.php?page=wc-admin&path=%2Fanalytics%2Frevenue&chart=net_revenue&orderby=net_revenue&period=month&compare=previous_period'
		},
		rt.ArrayItem{
			key: 'top_seller_link'
			val: 'admin.php?page=wc-admin&filter=single_product&path=%2Fanalytics%2Fproducts&products='
		},
		rt.ArrayItem{
			key: 'lowstock_link'
			val: 'admin.php?page=wc-admin&type=lowstock&path=%2Fanalytics%2Fstock'
		},
		rt.ArrayItem{
			key: 'outofstock_link'
			val: 'admin.php?page=wc-admin&type=outofstock&path=%2Fanalytics%2Fstock'
		},
		rt.ArrayItem{ key: 'report_data', val: rt.new_null() },
		rt.ArrayItem{ key: 'get_sales_sparkline', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_sales_sparkline' },
		]) },
	])
	if rt.is_true(var_is_wc_admin_disabled) {
		var_status_widget_reports = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_dashboard_status_widget_reports'),
			var_status_widget_reports.clone(),
		])
	} else {
		var_status_widget_reports.array_set('report_data', this.get_wc_admin_performance_data())
	}
	print('<ul class="wc_status_list">')
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_woocommerce_reports'),
	]))
	{
		mut var_report_data := var_status_widget_reports.array_get(rt.new_string('report_data'))
		mut var_get_sales_sparkline :=
			var_status_widget_reports.array_get(rt.new_string('get_sales_sparkline'))
		mut var_net_sales_link :=
			var_status_widget_reports.array_get(rt.new_string('net_sales_link'))
		mut var_top_seller_link :=
			var_status_widget_reports.array_get(rt.new_string('top_seller_link'))
		mut var_days := rt.call_function('max', [rt.new_int(7),
			rt.new_int((rt.call_function('gmdate', [rt.new_string('d'),
				rt.call_function('current_time', [rt.new_string('timestamp')])])).to_i64())])
		mut var_sparkline_allowed_html := {
			'span': {
				'class':          rt.new_array()
				'data-color':     rt.new_array()
				'data-tip':       rt.new_array()
				'data-barwidth':  rt.new_array()
				'data-sparkline': rt.new_array()
			}
		}
		if rt.is_true(var_report_data)
			&& rt.call_function('is_callable', [var_get_sales_sparkline.clone()]) {
			mut var_sparkline := rt.call_function('call_user_func_array', [
				var_get_sales_sparkline.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: '' },
					rt.ArrayItem{ key: none, val: var_days },
				])])
			var_sparkline = rt.new_string(this.sales_sparkline_markup(rt.new_string('sales'),
				var_days.clone(), var_sparkline.array_get(rt.new_string('total')),
				var_sparkline.array_get(rt.new_string('data'))))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('admin_url', [var_net_sales_link.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_sparkline.clone(),
				rt.create_array_from_native_map(var_sparkline_allowed_html)]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [rt.new_string('%s net sales this month'),
					rt.new_string('woocommerce')]),
				rt.new_string('<strong>' +
					(rt.call_function('wc_price', [rt.get_property(var_report_data, 'net_sales')])).str() +
					'</strong>'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_top_seller := this.get_top_seller()
		if rt.is_true(var_top_seller) && rt.is_true(rt.get_property(var_top_seller, 'qty'))
			&& rt.call_function('is_callable', [var_get_sales_sparkline.clone()]) {
			var_sparkline = rt.call_function('call_user_func_array', [
				var_get_sales_sparkline.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(var_top_seller, 'product_id') },
					rt.ArrayItem{ key: none, val: var_days },
					rt.ArrayItem{ key: none, val: 'count' },
				])])
			var_sparkline = rt.new_string(this.sales_sparkline_markup(rt.new_string('count'),
				var_days.clone(), var_sparkline.array_get(rt.new_string('total')),
				var_sparkline.array_get(rt.new_string('data'))))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string(var_top_seller_link.str() +
						(rt.get_property(var_top_seller, 'product_id')).str()),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_sparkline.clone(),
				rt.create_array_from_native_map(var_sparkline_allowed_html)]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [
					rt.new_string('%1$s top seller this month (sold %2$d)'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('<strong>' +
					(rt.call_function('get_the_title', [rt.get_property(var_top_seller, 'product_id')])).str() +
					'</strong>'),
				rt.get_property(var_top_seller, 'qty'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	this.status_widget_order_rows()
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	]), rt.new_string('yes')))
	{
		this.status_widget_stock_rows(var_status_widget_reports.array_get(rt.new_string('lowstock_link')),
			var_status_widget_reports.array_get(rt.new_string('outofstock_link')))
	}
	mut var_reports := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_after_dashboard_status_widget_parameter'),
		rt.new_null(),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_dashboard_status_widget'),
		var_reports.clone(),
	])
	print('</ul>')
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_order_rows() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_shop_orders'),
	])))))
	{
		return
	}
	mut var_on_hold_count := rt.new_int(0)
	mut var_processing_count := rt.new_int(0)
	mut iter_1 := rt.call_function('wc_get_order_types', [rt.new_string('order-count')]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_type := item_1.val
		mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_5 := iife_temp_5.get_count_for_type(var_type.clone())
		mut var_counts := iife_result_5
		var_on_hold_count = rt.add(var_on_hold_count,
			var_counts.array_get(Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold()))
		var_processing_count = rt.add(var_processing_count,
			var_counts.array_get(Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing()))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('edit.php?post_status=wc-processing&post_type=shop_order'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_n', [
			rt.new_string('<strong>%s order</strong> awaiting processing'),
			rt.new_string('<strong>%s orders</strong> awaiting processing'),
			var_processing_count.clone(),
			rt.new_string('woocommerce'),
		]),
		var_processing_count.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('edit.php?post_status=wc-on-hold&post_type=shop_order'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_n', [rt.new_string('<strong>%s order</strong> on-hold'),
			rt.new_string('<strong>%s orders</strong> on-hold'),
			var_on_hold_count.clone(), rt.new_string('woocommerce')]),
		var_on_hold_count.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_stock_rows(var_lowstock_link rt.PhpVal, var_outofstock_link rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('get_option', [rt.new_string('woocommerce_db_version'),
			rt.new_null()]),
		rt.new_string('3.6'),
		rt.new_string('<'),
	]))
	{
		return
	}
	mut var_stock := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_low_stock_amount'),
			]),
			rt.new_int(1),
		]),
	])
	mut var_nostock := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_no_stock_amount'),
			]),
			rt.new_int(0),
		]),
	])
	mut var_transient_name := rt.new_string('wc_low_stock_count')
	mut var_lowinstock_count := rt.call_function('get_transient', [
		var_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_lowinstock_count)) {
		var_lowinstock_count = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_status_widget_low_in_stock_count_pre_query'),
			rt.new_null(),
			var_stock.clone(),
			var_nostock.clone(),
		])
		if rt.is_true(rt.new_bool(var_lowinstock_count.clone().is_null())) {
			var_lowinstock_count = rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT( product_id )\n\t\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
						'wc_product_meta_lookup')),
						rt.new_string(' AS lookup\n\t\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
						'posts')),
						rt.new_string(" as posts ON lookup.product_id = posts.ID\n\t\t\t\t\t\t\tWHERE stock_quantity <= %d\n\t\t\t\t\t\t\tAND stock_quantity > %d\n\t\t\t\t\t\t\tAND posts.post_status = 'publish'")),
					var_stock.clone(),
					var_nostock.clone(),
				]),
			])
		}
		rt.call_function('set_transient', [var_transient_name.clone(),
			rt.new_int(var_lowinstock_count.to_i64()),
			rt.mul(rt.get_constant('DAY_IN_SECONDS'),
				rt.new_int(30))])
	}
	var_transient_name = rt.new_string('wc_outofstock_count')
	mut var_outofstock_count := rt.call_function('get_transient', [
		var_transient_name.clone()])
	mut var_lowstock_url := if rt.is_true(var_lowstock_link) { rt.call_function('admin_url', [
			var_lowstock_link.clone(),
		]) } else { rt.new_string('#') }
	mut var_outofstock_url := if rt.is_true(var_outofstock_link) { rt.call_function('admin_url', [
			var_outofstock_link.clone(),
		]) } else { rt.new_string('#') }
	if rt.is_true(rt.identical(rt.new_bool(false), var_outofstock_count)) {
		var_outofstock_count = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_status_widget_out_of_stock_count_pre_query'),
			rt.new_null(),
			var_nostock.clone(),
		])
		if rt.is_true(rt.new_bool(var_outofstock_count.clone().is_null())) {
			var_outofstock_count = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT( product_id )\n\t\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
						'wc_product_meta_lookup')),
						rt.new_string(' AS lookup\n\t\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
						'posts')),
						rt.new_string(" as posts ON lookup.product_id = posts.ID\n\t\t\t\t\t\t\tWHERE stock_quantity <= %d\n\t\t\t\t\t\t\tAND posts.post_status = 'publish'")),
					var_nostock.clone(),
				]),
			])).to_i64())
		}
		rt.call_function('set_transient', [var_transient_name.clone(),
			rt.new_int(var_outofstock_count.to_i64()),
			rt.mul(rt.get_constant('DAY_IN_SECONDS'),
				rt.new_int(30))])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_lowstock_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_n', [
			rt.new_string('<strong>%s product</strong> low in stock'),
			rt.new_string('<strong>%s products</strong> low in stock'),
			var_lowinstock_count.clone(),
			rt.new_string('woocommerce'),
		]),
		var_lowinstock_count.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_outofstock_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_n', [
			rt.new_string('<strong>%s product</strong> out of stock'),
			rt.new_string('<strong>%s products</strong> out of stock'),
			var_outofstock_count.clone(),
			rt.new_string('woocommerce'),
		]),
		var_outofstock_count.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Dashboard) legacy_recent_reviews() {
	mut var_wpdb := rt.new_null()
	mut var_query_from := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_recent_reviews_query_from'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb,
			'comments')), rt.new_string(' comments\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(" posts ON (comments.comment_post_ID = posts.ID)\n\t\t\t\tWHERE comments.comment_approved = '1'\n\t\t\t\tAND comments.comment_type = 'review'\n\t\t\t\tAND posts.post_password = ''\n\t\t\t\tAND posts.post_type = 'product'\n\t\t\t\tAND comments.comment_parent = 0\n\t\t\t\tORDER BY comments.comment_date_gmt DESC\n\t\t\t\tLIMIT 5")),
	])
	mut var_comments := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('SELECT posts.ID, posts.post_title, comments.comment_author, comments.comment_author_email, comments.comment_ID, comments.comment_content ${var_query_from.to_string()};'),
	])
	if rt.is_true(var_comments) {
		print('<ul>')
		mut iter_2 := var_comments.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_comment := item_2.val
			print('<li>')
			rt.echo_val(rt.call_function('get_avatar', [
				rt.get_property(var_comment, 'comment_author_email'),
				rt.new_string('32'),
			]))
			mut var_product_title := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_admin_dashboard_recent_reviews'),
				rt.get_property(var_comment, 'post_title'),
				var_comment.clone(),
			])
			mut var_rating := rt.new_int(rt.call_function('get_comment_meta', [
				rt.get_property(var_comment, 'comment_ID'),
				rt.new_string('rating'),
				rt.new_bool(true),
			]).to_i64())
			print('<div class="star-rating"><span style="width:' +
				(rt.call_function('esc_attr', [rt.mul(var_rating, rt.new_int(20))])).str() + '%">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s out of 5'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_rating.clone()])])).str() +
				'</span></div>')
			print('<h4 class="meta"><a href="' +
				(rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_comment, 'ID')])])).str() +
				'#comment-' +
				(rt.call_function('esc_attr', [rt.call_function('absint', [rt.get_property(var_comment, 'comment_ID')])])).str() +
				'">' + (rt.call_function('esc_html', [var_product_title.clone()])).str() + '</a> ' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('reviewed by %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(var_comment, 'comment_author')])])).str() +
				'</h4>')
			print('<blockquote>' +
				(rt.call_function('wp_kses_data', [rt.get_property(var_comment, 'comment_content')])).str() +
				'</blockquote></li>')
		}
		print('</ul>')
	} else {
		print('<p>' +
			(rt.call_function('esc_html__', [rt.new_string('There are no product reviews yet.'), rt.new_string('woocommerce')])).str() +
			'</p>')
	}
}

fn (mut this Class_WC_Admin_Dashboard) recent_reviews() {
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_6) { '' } else { '.min' }).str())
	mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_7
	rt.call_function('wp_enqueue_script', [
		rt.new_string('wc-recent-reviews-widget-async'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-recent-reviews-widget-async' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		var_version.clone(),
		rt.new_bool(true),
	])
	rt.call_function('wp_localize_script', [
		rt.new_string('wc-recent-reviews-widget-async'),
		rt.new_string('wc_recent_reviews_widget_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [
				rt.new_string('admin-ajax.php'),
			]) },
			rt.ArrayItem{ key: 'security', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc-recent-reviews-widget'),
			]) },
			rt.ArrayItem{ key: 'error_message', val: rt.call_function('esc_html__', [
				rt.new_string('Error loading widget'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	print('<div id="wc-recent-reviews-widget-loading" class="wc-recent-reviews-widget-loading">')
	print('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('Loading reviews data...'), rt.new_string('woocommerce')])).str() +
		' <span class="spinner is-active"></span></p>')
	print('</div>')
	print('<div id="wc-recent-reviews-widget-content" style="display:none;"></div>')
}

fn (mut this Class_WC_Admin_Dashboard) recent_reviews_content() {
	mut var_has_legacy_query_filter := rt.call_function('has_filter', [
		rt.new_string('woocommerce_report_recent_reviews_query_from'),
	])
	mut var_has_legacy_product_title_filter := rt.call_function('has_filter', [
		rt.new_string('woocommerce_admin_dashboard_recent_reviews'),
	])
	mut var_use_legacy_implementation := rt.new_bool(rt.is_true(var_has_legacy_query_filter)
		|| rt.is_true(var_has_legacy_product_title_filter))
	if rt.is_true(var_use_legacy_implementation) {
		if rt.is_true(var_has_legacy_query_filter) {
			rt.call_function('wc_deprecated_hook', [
				rt.new_string('woocommerce_report_recent_reviews_query_from'),
				rt.new_string('10.5.0'),
			])
		}
		if rt.is_true(var_has_legacy_product_title_filter) {
			rt.call_function('wc_deprecated_hook', [
				rt.new_string('woocommerce_admin_dashboard_recent_reviews'),
				rt.new_string('10.5.0'),
				rt.new_string('dashboard-widget-reviews.php template'),
			])
		}
		this.legacy_recent_reviews()
		return
	}
	mut var_comments := rt.call_function('get_comments', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'review' },
			rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'parent', val: 0 },
			rt.ArrayItem{ key: 'number', val: 25 }, rt.ArrayItem{
				key: 'update_comment_post_cache'
				val: true
			}]),
	])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_comment := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(
			rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_product'), rt.get_property(var_comment, 'comment_post_ID')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_password_required', [rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64())]))))))
	}
	var_comments = rt.call_function('array_filter', [var_comments.clone(),
		rt.new_closure(closure_9_fn)])
	if rt.is_true(var_comments) {
		print('<ul>')
		mut var_count_rendered := rt.new_int(0)
		mut iter_3 := var_comments.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_comment := item_3.val
			mut var_product := rt.call_function('wc_get_product', [
				rt.get_property(var_comment, 'comment_post_ID'),
			])
			if rt.is_true(var_product) {
				rt.call_function('wc_get_template', [
					rt.new_string('dashboard-widget-reviews.php'),
					rt.create_array([rt.ArrayItem{ key: 'product', val: var_product },
						rt.ArrayItem{ key: 'comment', val: var_comment }]),
				])
				if rt.is_true(rt.identical(rt.new_int(5), rt.pre_inc(var_count_rendered))) {
					break
				}
			}
		}
		print('</ul>')
	} else {
		print('<p>' +
			(rt.call_function('esc_html__', [rt.new_string('There are no product reviews yet.'), rt.new_string('woocommerce')])).str() +
			'</p>')
	}
}

fn (mut this Class_WC_Admin_Dashboard) network_orders() {
	mut iife_temp_9 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_9 := iife_temp_9.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_9) { '' } else { '.min' }).str())
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 := iife_temp_10.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_10
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-network-orders'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/network-order-widget.css'),
		rt.new_array(), var_version.clone()])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-network-orders'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/network-orders' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'underscore' }]),
		var_version.clone(), rt.new_bool(true)])
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_blogs := rt.call_function('get_blogs_of_user', [
		rt.get_property(var_user, 'ID'),
	])
	mut var_blog_ids := rt.call_function('wp_list_pluck', [var_blogs.clone(),
		rt.new_string('userblog_id')])
	rt.call_function('wp_localize_script', [rt.new_string('wc-network-orders'),
		rt.new_string('woocommerce_network_orders'),
		rt.create_array([
			rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wp_rest'),
			]) },
			rt.ArrayItem{ key: 'sites', val: rt.call_function('array_values', [
				var_blog_ids.clone(),
			]) },
			rt.ArrayItem{ key: 'order_endpoint', val: rt.call_function('get_rest_url', [
				rt.new_null(),
				rt.new_string('wc/v3/orders/network'),
			]) },
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Loading network orders'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Status'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Total'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('No orders found'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Dashboard) get_wc_admin_performance_data() rt.PhpVal {
	mut var_request := create_wp_rest_request(rt.new_string('GET'),
		rt.new_string('/wc-analytics/reports/performance-indicators'))
	mut var_start_date := rt.call_function('gmdate', [rt.new_string('Y-m-01 00:00:00'),
		rt.call_function('current_time', [rt.new_string('timestamp')])])
	mut var_end_date := rt.call_function('gmdate', [rt.new_string('Y-m-d 23:59:59'),
		rt.call_function('current_time', [rt.new_string('timestamp')])])
	var_request.set_query_params(rt.create_array([
		rt.ArrayItem{ key: 'before', val: var_end_date },
		rt.ArrayItem{ key: 'after', val: var_start_date },
		rt.ArrayItem{
			key: 'stats'
			val: 'revenue/total_sales,revenue/net_revenue,orders/orders_count,products/items_sold,variations/items_sold'
		},
	]))
	mut var_response := rt.call_function('rest_do_request', [var_request])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return mut rt.cast_object_ptr[Class_stdClass](var_response)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_method(var_response,
		'get_status', []rt.PhpVal{})))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_analytics_performance_indicators_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching performance indicators failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	mut var_report_keys := {
		'net_revenue': 'net_sales'
	}
	mut var_performance_data := create_stdclass()
	mut iter_4 := rt.call_method(var_response, 'get_data', []rt.PhpVal{}).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_indicator := item_4.val
		if var_indicator.array_isset(rt.new_string('chart'))
			&& var_indicator.array_isset(rt.new_string('value')) {
			mut var_key := if var_report_keys.array_isset(var_indicator.array_get(rt.new_string('chart'))) {
				rt.new_string((var_report_keys[var_indicator.array_get(rt.new_string('chart'))]).str())
			} else {
				var_indicator.array_get(rt.new_string('chart'))
			}
			rt.set_property(var_performance_data,
				'{"nodeType":"Expr_Variable","line":665,"name":"key"}',
				var_indicator.array_get(rt.new_string('value')))
		}
	}
	return mut var_performance_data
}

fn (mut this Class_WC_Admin_Dashboard) get_sales_sparkline(id string, days i64, type string) rt.PhpVal {
	mut days_mutated := days
	mut var_sales_endpoint := rt.new_string('/wc-analytics/reports/revenue/stats')
	mut var_start_date := rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'),
		rt.sub(rt.call_function('current_time', [rt.new_string('timestamp')]), rt.mul(days_mutated - 1,
			rt.get_constant('DAY_IN_SECONDS')))])
	mut var_end_date := rt.call_function('gmdate', [rt.new_string('Y-m-d 23:59:59'),
		rt.call_function('current_time', [rt.new_string('timestamp')])])
	mut var_meta_key := rt.new_string('net_revenue')
	mut var_params := {
		'order':    rt.new_string('asc')
		'interval': rt.new_string('day')
		'per_page': rt.new_int(100)
		'before':   var_end_date
		'after':    var_start_date
	}
	if var_id.len > 0 && var_id != '0' {
		var_sales_endpoint = rt.new_string('/wc-analytics/reports/products/stats')
		var_meta_key = rt.new_string((if rt.is_true(rt.identical(rt.new_string('sales'),
			rt.new_string(type)))
		{
			'net_revenue'
		} else {
			'items_sold'
		}).str())
		var_params['products'] = rt.new_string(id)
	}
	mut var_request := create_wp_rest_request(rt.new_string('GET'), var_sales_endpoint.clone())
	var_params['fields'] = rt.create_array([rt.ArrayItem{ key: none, val: var_meta_key }])
	var_request.set_query_params(var_params.clone())
	mut var_response := rt.call_function('rest_do_request', [var_request])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	mut var_resp_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut var_data := var_resp_data.array_get(rt.new_string('intervals'))
	mut var_sparkline_data := rt.new_array()
	mut var_total := rt.new_int(0)
	mut iter_5 := var_data.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_d := item_5.val
		var_total = rt.add(var_total, rt.get_property(var_d.array_get(rt.new_string('subtotals')),
			'{"nodeType":"Expr_Variable","line":712,"name":"meta_key"}'))
		var_sparkline_data.clone().array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: rt.mul(rt.call_function('strtotime', [
				var_d.array_get(rt.new_string('interval')),
			]), rt.new_int(1000)).to_string() },
			rt.ArrayItem{ key: none, val: rt.get_property(var_d.array_get(rt.new_string('subtotals')),
				'{"nodeType":"Expr_Variable","line":713,"name":"meta_key"}') },
		]))
	}
	return rt.create_array([rt.ArrayItem{ key: 'total', val: var_total },
		rt.ArrayItem{ key: 'data', val: var_sparkline_data }])
}

fn (mut this Class_WC_Admin_Dashboard) sales_sparkline_markup(var_type rt.PhpVal, var_days rt.PhpVal, var_total rt.PhpVal, var_sparkline_data rt.PhpVal) string {
	mut var_days_mutated := var_days
	mut var_total_mutated := var_total
	mut var_sparkline_data_mutated := var_sparkline_data
	if rt.is_true(rt.identical(rt.new_string('sales'), var_type)) {
		mut var_tooltip := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Sold %1$s worth in the last %2$d days'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('strip_tags', [
				rt.call_function('wc_price', [var_total_mutated.clone()]),
			]),
			var_days_mutated.clone(),
		])
	} else {
		var_tooltip = rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('Sold %1$d item in the last %2$d days'),
				rt.new_string('Sold %1$d items in the last %2$d days'),
				var_total_mutated.clone(),
				rt.new_string('woocommerce'),
			]),
			var_total_mutated.clone(),
			var_days_mutated.clone(),
		])
	}
	return '<span class="wc_sparkline ' +
		if rt.is_true(rt.identical(rt.new_string('sales'), var_type)) {
		'lines'
	} else {
		'bars'
	} +
		' tips" data-color="#777" data-tip="' +
		(rt.call_function('esc_attr', [var_tooltip.clone()])).str() + '" data-barwidth="' +
		60 * 60 * 16 * 1000.str() + '" data-sparkline="' +
		(rt.call_function('wc_esc_json', [rt.call_function('wp_json_encode', [var_sparkline_data_mutated.clone()])])).str() +
		'"></span>'
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wc_admin_dashboard() &Class_WC_Admin_Dashboard {
	mut obj := &Class_WC_Admin_Dashboard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Dashboard) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_network_order_widget' {
			this.register_network_order_widget()
			return rt.new_null()
		}
		'should_display_widget' {
			return rt.new_bool(this.should_display_widget())
		}
		'get_top_seller' {
			return this.get_top_seller()
		}
		'status_widget' {
			this.status_widget()
			return rt.new_null()
		}
		'status_widget_content' {
			this.status_widget_content()
			return rt.new_null()
		}
		'status_widget_order_rows' {
			this.status_widget_order_rows()
			return rt.new_null()
		}
		'status_widget_stock_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.status_widget_stock_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'legacy_recent_reviews' {
			this.legacy_recent_reviews()
			return rt.new_null()
		}
		'recent_reviews' {
			this.recent_reviews()
			return rt.new_null()
		}
		'recent_reviews_content' {
			this.recent_reviews_content()
			return rt.new_null()
		}
		'network_orders' {
			this.network_orders()
			return rt.new_null()
		}
		'get_wc_admin_performance_data' {
			return this.get_wc_admin_performance_data()
		}
		'get_sales_sparkline' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_sales_sparkline(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sales_sparkline_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this.sales_sparkline_markup(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Dashboard) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Dashboard) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Dashboard'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Admin_Dashboard', []string{}, create_wc_admin_dashboard())
}
