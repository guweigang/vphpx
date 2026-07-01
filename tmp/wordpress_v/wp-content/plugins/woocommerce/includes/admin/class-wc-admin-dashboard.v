import rt

struct Class_WC_Admin_Dashboard {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Dashboard) construct()  {
	if this.should_display_widget() {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))) {
			rt.call_function('add_action', [rt.new_string('wp_network_dashboard_setup'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_network_order_widget' }])])
		} else {
			rt.call_function('add_action', [rt.new_string('wp_dashboard_setup'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init' }])])
		}
	}
}

fn (mut this Class_WC_Admin_Dashboard) init()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')])) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')])))) {
		rt.call_function('wp_add_dashboard_widget', [rt.new_string('woocommerce_dashboard_recent_reviews'), rt.call_function('__', [rt.new_string('WooCommerce Recent Reviews'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'recent_reviews' }])])
	}
	rt.call_function('wp_add_dashboard_widget', [rt.new_string('woocommerce_dashboard_status'), rt.call_function('__', [rt.new_string('WooCommerce Status'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'status_widget' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})))) {
		this.register_network_order_widget()
	}
}

fn (mut this Class_WC_Admin_Dashboard) register_network_order_widget()  {
	rt.call_function('wp_add_dashboard_widget', [rt.new_string('woocommerce_network_orders'), rt.call_function('__', [rt.new_string('WooCommerce Network Orders'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'network_orders' }])])
}

fn (mut this Class_WC_Admin_Dashboard) should_display_widget() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{}))))) {
		return false
	}
	mut var_has_permission := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_woocommerce_reports')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')]))))
	mut var_task_completed_or_hidden := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_task_list_complete')]))) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_task_list_hidden')])))))
	return rt.is_true(var_task_completed_or_hidden) && rt.is_true(var_has_permission)
}

fn (mut this Class_WC_Admin_Dashboard) get_top_seller() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_hpos_enabled := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()
	mut var_orders_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_table_for_orders() }()
	mut var_orders_column_id := rt.new_string(if rt.is_true(var_hpos_enabled) { rt.new_string('id') } else { rt.new_string('ID') })
	mut var_orders_column_type := rt.new_string(if rt.is_true(var_hpos_enabled) { rt.new_string('type') } else { rt.new_string('post_type') })
	mut var_orders_column_status := rt.new_string(if rt.is_true(var_hpos_enabled) { rt.new_string('status') } else { rt.new_string('post_status') })
	mut var_orders_column_date := rt.new_string(if rt.is_true(var_hpos_enabled) { rt.new_string('date_created_gmt') } else { rt.new_string('post_date_gmt') })
	mut var_query := rt.new_array()
	var_query.array_set('fields', "SELECT SUM( order_item_meta.meta_value ) as qty, order_item_meta_2.meta_value as product_id FROM ${var_orders_table.to_string()} AS orders")
	var_query.array_set('join', rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items AS order_items ON orders.')), var_orders_column_id), rt.new_string(' = order_id ')))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	var_query.array_set('where', "WHERE orders.${var_orders_column_type.to_string()} IN ( '" + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('wc_get_order_types', [rt.new_string('order-count')])])).str() + '\' ) ')
	mut var_order_statuses := rt.call_function('apply_filters', [rt.new_string('woocommerce_reports_order_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }])])
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	var_query.array_set('groupby', 'GROUP BY product_id')
	var_query.array_set('orderby', 'ORDER BY qty DESC')
	var_query.array_set('limits', 'LIMIT 1')
	var_query = rt.call_function('apply_filters', [rt.new_string('woocommerce_dashboard_status_widget_top_seller_query'), var_query.dup()])
	mut var_sql := rt.call_function('implode', [rt.new_string(' '), var_query.dup()])
	return rt.call_method(var_wpdb, 'get_row', [var_sql.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Dashboard) status_widget()  {
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-status-widget'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/wc-status-widget' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wc-flot' }]), var_version.dup(), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-status-widget-async'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/wc-status-widget-async' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), var_version.dup(), rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('wc-status-widget-async'), rt.new_string('wc_status_widget_params'), rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]) }, rt.ArrayItem{ key: 'security', val: rt.call_function('wp_create_nonce', [rt.new_string('wc-status-widget')]) }, rt.ArrayItem{ key: 'error_message', val: rt.call_function('esc_html__', [rt.new_string('Error loading widget'), rt.new_string('woocommerce')]) }])])
	print('<div id="wc-status-widget-loading" class="wc-status-widget-loading">')
	print('<p>' + (rt.call_function('esc_html__', [rt.new_string('Loading status data...'), rt.new_string('woocommerce')])).str() + ' <span class="spinner is-active"></span></p>')
	print('</div>')
	print('<div id="wc-status-widget-content" style="display:none;"></div>')
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_content()  {
	mut var_is_wc_admin_disabled := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_disabled'), rt.new_bool(false)])) || rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('analytics'))))))))
	mut var_status_widget_reports := rt.create_array([rt.ArrayItem{ key: 'net_sales_link', val: 'admin.php?page=wc-admin&path=%2Fanalytics%2Frevenue&chart=net_revenue&orderby=net_revenue&period=month&compare=previous_period' }, rt.ArrayItem{ key: 'top_seller_link', val: 'admin.php?page=wc-admin&filter=single_product&path=%2Fanalytics%2Fproducts&products=' }, rt.ArrayItem{ key: 'lowstock_link', val: 'admin.php?page=wc-admin&type=lowstock&path=%2Fanalytics%2Fstock' }, rt.ArrayItem{ key: 'outofstock_link', val: 'admin.php?page=wc-admin&type=outofstock&path=%2Fanalytics%2Fstock' }, rt.ArrayItem{ key: 'report_data', val: rt.new_null() }, rt.ArrayItem{ key: 'get_sales_sparkline', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Dashboard', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_sales_sparkline' }]) }])
	if rt.is_true(var_is_wc_admin_disabled) {
		var_status_widget_reports = rt.call_function('apply_filters', [rt.new_string('woocommerce_dashboard_status_widget_reports'), var_status_widget_reports.dup()])
	} else {
		var_status_widget_reports.array_set('report_data', this.get_wc_admin_performance_data())
	}
	print('<ul class="wc_status_list">')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_woocommerce_reports')])) {
		mut var_report_data := var_status_widget_reports.array_get('report_data')
		mut var_get_sales_sparkline := var_status_widget_reports.array_get('get_sales_sparkline')
		mut var_net_sales_link := var_status_widget_reports.array_get('net_sales_link')
		mut var_top_seller_link := var_status_widget_reports.array_get('top_seller_link')
		mut var_days := rt.call_function('max', [rt.new_int(7), // unsupported expression: Expr_Cast_Int])
		mut var_sparkline_allowed_html := { 'span': { 'class': rt.new_array(), 'data-color': rt.new_array(), 'data-tip': rt.new_array(), 'data-barwidth': rt.new_array(), 'data-sparkline': rt.new_array() } }
		if rt.is_true(rt.new_bool(rt.is_true(var_report_data) && rt.is_true(rt.call_function('is_callable', [var_get_sales_sparkline.dup()])))) {
			mut var_sparkline := rt.call_function('call_user_func_array', [var_get_sales_sparkline.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: var_days }])])
			var_sparkline = rt.new_string(this.sales_sparkline_markup(rt.new_string('sales'), var_days.dup(), var_sparkline.array_get('total'), var_sparkline.array_get('data')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [var_net_sales_link.dup()])]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_sparkline.dup(), var_sparkline_allowed_html.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%s net sales this month'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('wc_price', [rt.get_property(var_report_data, 'net_sales')])).str() + '</strong>'])
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_top_seller := this.get_top_seller()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_top_seller) && rt.is_true(rt.get_property(var_top_seller, 'qty')))) && rt.is_true(rt.call_function('is_callable', [var_get_sales_sparkline.dup()])))) {
			var_sparkline = rt.call_function('call_user_func_array', [var_get_sales_sparkline.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_top_seller, 'product_id') }, rt.ArrayItem{ key: none, val: var_days }, rt.ArrayItem{ key: none, val: 'count' }])])
			var_sparkline = rt.new_string(this.sales_sparkline_markup(rt.new_string('count'), var_days.dup(), var_sparkline.array_get('total'), var_sparkline.array_get('data')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.concat(var_top_seller_link, rt.get_property(var_top_seller, 'product_id'))])]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses', [var_sparkline.dup(), var_sparkline_allowed_html.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%1$s top seller this month (sold %2$d)'), rt.new_string('woocommerce')]), '<strong>' + (rt.call_function('get_the_title', [rt.get_property(var_top_seller, 'product_id')])).str() + '</strong>', rt.get_property(var_top_seller, 'qty')])
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
		}
	}
	this.status_widget_order_rows()
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]), rt.new_string('yes'))) {
		this.status_widget_stock_rows(var_status_widget_reports.array_get('lowstock_link'), var_status_widget_reports.array_get('outofstock_link'))
	}
	mut var_reports := rt.call_function('apply_filters', [rt.new_string('woocommerce_after_dashboard_status_widget_parameter'), rt.new_null()])
	rt.call_function('do_action', [rt.new_string('woocommerce_after_dashboard_status_widget'), var_reports.dup()])
	print('</ul>')
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_order_rows()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		return rt.new_null()
	}
	mut var_on_hold_count := rt.new_int(rt.new_int(0))
	mut var_processing_count := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := rt.call_function('wc_get_order_types', [rt.new_string('order-count')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut var_counts := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.get_count_for_type(arg_0) }(var_type.dup())
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

fn (mut this Class_WC_Admin_Dashboard) status_widget_stock_rows(var_lowstock_link rt.PhpVal, var_outofstock_link rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Admin_Dashboard) legacy_recent_reviews()  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Admin_Dashboard) recent_reviews()  {
}

fn (mut this Class_WC_Admin_Dashboard) recent_reviews_content()  {
}

fn (mut this Class_WC_Admin_Dashboard) network_orders()  {
}

fn (mut this Class_WC_Admin_Dashboard) get_wc_admin_performance_data() rt.PhpVal {
}

fn (mut this Class_WC_Admin_Dashboard) get_sales_sparkline(id string, days i64, type string) rt.PhpVal {
	mut days_mutated := days
}

fn (mut this Class_WC_Admin_Dashboard) sales_sparkline_markup(var_type rt.PhpVal, var_days rt.PhpVal, var_total rt.PhpVal, var_sparkline_data rt.PhpVal) string {
	mut var_days_mutated := var_days
	mut var_total_mutated := var_total
	mut var_sparkline_data_mutated := var_sparkline_data
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

fn create_wc_admin_dashboard() &Class_WC_Admin_Dashboard {
	mut obj := &Class_WC_Admin_Dashboard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
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
			return rt.new_string(this.sales_sparkline_markup(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_dashboard_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Dashboard'), rt.new_bool(false)]))))) {
	}
	return 
}
