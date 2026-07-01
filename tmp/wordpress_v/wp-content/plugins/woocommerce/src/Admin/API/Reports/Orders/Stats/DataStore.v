import rt

pub fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.option_order_stats_table_has_column_order_fulfillment_status() string {
	return 'woocommerce_order_stats_has_fulfillment_column'
}
pub fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.cron_event() string {
	return 'wc_order_stats_update'
}
struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_stats')
		cache_key rt.PhpVal = rt.new_string('orders_stats')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('orders_stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) construct()  {
	this.dispatch_set_prop('date_column_name', rt.call_function('get_option', [rt.new_string('woocommerce_date_type'), rt.new_string('date_paid')]))
	this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.construct()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.get_db_table_name() }()
	mut var_refunds := rt.new_string(rt.new_string("ABS( SUM( CASE WHEN ${var_table_name.to_string()}.net_total < 0 THEN ${var_table_name.to_string()}.net_total + ${var_table_name.to_string()}.tax_total + ${var_table_name.to_string()}.shipping_total ELSE 0 END ) )"))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.uses_new_full_refund_data() }())))) {
		var_refunds = rt.new_string(rt.new_string("ABS( SUM( CASE WHEN ${var_table_name.to_string()}.net_total < 0 THEN ${var_table_name.to_string()}.net_total ELSE 0 END ) )"))
	}
	mut var_gross_sale_sum := rt.new_string(rt.new_string("${var_table_name.to_string()}.total_sales - ${var_table_name.to_string()}.tax_total - ${var_table_name.to_string()}.shipping_total"))
	mut var_gross_sales := rt.new_string(rt.new_string("SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_gross_sale_sum.to_string()} ELSE 0 END ) + COALESCE( SUM(discount_amount), 0 ) as gross_sales"))
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'orders_count', val: "SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) as orders_count" }, rt.ArrayItem{ key: 'num_items_sold', val: "SUM(${var_table_name.to_string()}.num_items_sold) as num_items_sold" }, rt.ArrayItem{ key: 'gross_sales', val: var_gross_sales }, rt.ArrayItem{ key: 'total_sales', val: "SUM(${var_table_name.to_string()}.total_sales) AS total_sales" }, rt.ArrayItem{ key: 'coupons', val: 'COALESCE( SUM(discount_amount), 0 ) AS coupons' }, rt.ArrayItem{ key: 'coupons_count', val: 'COALESCE( coupons_count, 0 ) as coupons_count' }, rt.ArrayItem{ key: 'refunds', val: "${var_refunds.to_string()} AS refunds" }, rt.ArrayItem{ key: 'taxes', val: "SUM(${var_table_name.to_string()}.tax_total) AS taxes" }, rt.ArrayItem{ key: 'shipping', val: "SUM(${var_table_name.to_string()}.shipping_total) AS shipping" }, rt.ArrayItem{ key: 'net_revenue', val: "SUM(${var_table_name.to_string()}.net_total) AS net_revenue" }, rt.ArrayItem{ key: 'avg_items_per_order', val: "SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_table_name.to_string()}.num_items_sold ELSE 0 END ) / SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) AS avg_items_per_order" }, rt.ArrayItem{ key: 'avg_order_value', val: "SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_table_name.to_string()}.net_total ELSE 0 END ) / SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) AS avg_order_value" }, rt.ArrayItem{ key: 'total_customers', val: "COUNT( DISTINCT( ${var_table_name.to_string()}.customer_id ) ) as total_customers" }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_order' }])])
	rt.call_function('add_action', [rt.new_string('delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_order' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) orders_stats_sql_filter(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_from_clause := rt.new_string(rt.new_string(''))
	mut var_orders_stats_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.get_db_table_name() }()
	mut var_product_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_coupon_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_coupon_lookup')
	mut var_tax_rate_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_tax_lookup')
	mut var_operator := this.get_match_operator(var_query_args.dup())
	mut var_where_filters := rt.new_array()
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_product_lookup.dup(), rt.new_string('product_id'), rt.new_string('IN'), this.get_included_products(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_product_lookup.dup(), rt.new_string('product_id'), rt.new_string('NOT IN'), this.get_excluded_products(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_product_lookup.dup(), rt.new_string('variation_id'), rt.new_string('IN'), this.get_included_variations(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_product_lookup.dup(), rt.new_string('variation_id'), rt.new_string('NOT IN'), this.get_excluded_variations(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_coupon_lookup.dup(), rt.new_string('coupon_id'), rt.new_string('IN'), this.get_included_coupons(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_coupon_lookup.dup(), rt.new_string('coupon_id'), rt.new_string('NOT IN'), this.get_excluded_coupons(var_query_args.dup())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_tax_rate_lookup.dup(), rt.new_string('tax_rate_id'), rt.new_string('IN'), rt.call_function('implode', [rt.new_string(','), var_query_args.array_get('tax_rate_includes')])))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.dup(), rt.new_string('order_id'), var_tax_rate_lookup.dup(), rt.new_string('tax_rate_id'), rt.new_string('NOT IN'), rt.call_function('implode', [rt.new_string(','), var_query_args.array_get('tax_rate_excludes')])))
	mut var_attribute_subqueries := this.get_attribute_subqueries(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_attribute_subqueries.array_get('join')) && rt.is_true(var_attribute_subqueries.array_get('where')))) {
		mut var_attribute_subquery := create_automattic_woocommerce_admin_api_reports_sqlquery()
		var_attribute_subquery.add_sql_clause(rt.new_string('select'), rt.new_string("${var_orders_stats_table.to_string()}.order_id"))
		var_attribute_subquery.add_sql_clause(rt.new_string('from'), var_orders_stats_table.dup())
		var_attribute_subquery.add_sql_clause(rt.new_string('join'), rt.new_string("JOIN ${var_product_lookup.to_string()} ON ${var_orders_stats_table.to_string()}.order_id = ${var_product_lookup.to_string()}.order_id"))
		{
			mut iter_1 := var_attribute_subqueries.array_get('join').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute_join := item_1.val
				var_attribute_subquery.add_sql_clause(rt.new_string('join'), var_attribute_join.dup())
			}
		}
		var_attribute_subquery.add_sql_clause(rt.new_string('where'), rt.new_string('AND (' + (rt.call_function('implode', [rt.new_string(" ${var_operator.to_string()} "), var_attribute_subqueries.array_get('where')])).str() + ')'))
		var_where_filters.array_push("${var_orders_stats_table.to_string()}.order_id IN (" + (var_attribute_subquery.get_query_statement()).str() + ')')
	}
	var_where_filters.array_push(this.get_customer_subquery(var_query_args.dup()))
	mut var_refund_subquery := this.get_refund_subquery(var_query_args.dup())
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(var_refund_subquery.array_get('where_clause')) {
		var_where_filters.array_push(var_refund_subquery.array_get('where_clause'))
	}
	var_where_filters = rt.call_function('array_filter', [var_where_filters.dup()])
	mut var_where_subclause := rt.call_function('implode', [rt.new_string(" ${var_operator.to_string()} "), var_where_filters.dup()])
	mut var_order_status_filter := this.get_status_subquery(var_query_args.dup(), var_operator.dup())
	if rt.is_true(var_order_status_filter) {
		if !rt.is_true(var_query_args.array_get('status_is')) && !rt.is_true(var_query_args.array_get('status_is_not')) {
			var_operator = rt.new_string(rt.new_string('AND'))
		}
		var_where_subclause = rt.call_function('implode', [rt.new_string(" ${var_operator.to_string()} "), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: var_where_subclause }, rt.ArrayItem{ key: none, val: var_order_status_filter }])])])
	}
	if rt.is_true(var_where_subclause) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ( ${var_where_subclause.to_string()} )")])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('join'), var_from_clause.dup()])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ( ${var_where_subclause.to_string()} )")])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('join'), var_from_clause.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars(), rt.create_array([rt.ArrayItem{ key: 'interval', val: 'week' }, rt.ArrayItem{ key: 'segmentby', val: '' }, rt.ArrayItem{ key: 'match', val: 'all' }, rt.ArrayItem{ key: 'status_is', val: rt.new_array() }, rt.ArrayItem{ key: 'status_is_not', val: rt.new_array() }, rt.ArrayItem{ key: 'product_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'product_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_rate_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_rate_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'customer_type', val: '' }, rt.ArrayItem{ key: 'category_includes', val: rt.new_array() }])])
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_noncached_stats_data(var_query_args rt.PhpVal, var_params rt.PhpVal, var_data rt.PhpVal, var_expected_interval_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_params_mutated := var_params
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}; return temp.get_db_table_name() }()
	if var_query_args.array_isset(rt.new_string('date_type')) {
		this.dispatch_set_prop('date_column_name', var_query_args.array_get('date_type'))
	}
	this.initialize_queries()
	mut var_selections := this.selected_columns(var_query_args.dup())
	this.add_time_period_sql_params(var_query_args.dup(), var_table_name.dup())
	this.add_intervals_sql_params(var_query_args.dup(), var_table_name.dup())
	this.add_order_by_sql_params(var_query_args.dup())
	mut var_where_time := this.get_sql_clause(rt.new_string('where_time'))
	var_params_mutated = this.get_limit_sql_params(var_query_args.dup())
	mut var_coupon_join := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN (\n\t\t\t\t\tSELECT\n\t\t\t\t\t\torder_id,\n\t\t\t\t\t\tSUM(discount_amount) AS discount_amount,\n\t\t\t\t\t\tCOUNT(DISTINCT coupon_id) AS coupons_count\n\t\t\t\t\tFROM\n\t\t\t\t\t\t'), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_coupon_lookup\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\torder_id\n\t\t\t\t\t) order_coupon_lookup\n\t\t\t\t\tON order_coupon_lookup.order_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.order_id')))
	this.orders_stats_sql_filter(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('select'), var_selections.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('left_join'), var_coupon_join.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where_time'), var_where_time.dup()])
	mut var_totals := rt.call_method(var_wpdb, 'get_results', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_query_statement', []rt.PhpVal{}), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_totals)) {
		return create_automattic_woocommerce_admin_api_reports_orders_stats_wp_error(rt.new_string('woocommerce_analytics_revenue_result_failed'), rt.call_function('__', [rt.new_string('Sorry, fetching revenue data failed.'), rt.new_string('woocommerce')]))
	}
	mut var_totals_query := rt.create_array([rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_sql_clause', [rt.new_string('join')]) }, rt.ArrayItem{ key: 'where_time_clause', val: var_where_time }, rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_sql_clause', [rt.new_string('where')]) }])
	mut var_intervals_query := rt.create_array([rt.ArrayItem{ key: 'select_clause', val: this.get_sql_clause(rt.new_string('select')) }, rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_sql_clause', [rt.new_string('join')]) }, rt.ArrayItem{ key: 'where_time_clause', val: var_where_time }, rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_sql_clause', [rt.new_string('where')]) }, rt.ArrayItem{ key: 'limit', val: this.get_sql_clause(rt.new_string('limit')) }])
	mut var_unique_products := this.get_unique_product_count(var_totals_query.array_get('from_clause'), var_totals_query.array_get('where_time_clause'), var_totals_query.array_get('where_clause'))
	var_totals.array_get_mut(0).array_set('products', var_unique_products.dup())
	mut var_segmenter := create_automattic_woocommerce_admin_api_reports_orders_stats_segmenter(var_query_args.dup(), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'report_columns'))
	mut var_unique_coupons := this.get_unique_coupon_count(var_totals_query.array_get('from_clause'), var_totals_query.array_get('where_time_clause'), var_totals_query.array_get('where_clause'))
	var_totals.array_get_mut(0).array_set('coupons_count', var_unique_coupons.dup())
	var_totals.array_get_mut(0).array_set('segments', var_segmenter.get_totals_segments(var_totals_query.dup(), var_table_name.dup()))
	var_totals = // unsupported expression: Expr_Cast_Object
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'), (this.get_sql_clause(rt.new_string())).str() + ' AS time_interval'])
	rt.call_method(rt.get_property(, 'interval_query'), 'add_sql_clause', [rt.new_string('left_join'), var_coupon_join.dup()])
	rt.call_method(, 'add_sql_clause', [, .dup()])
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_unique_product_count(var_from_clause rt.PhpVal, var_where_time_clause rt.PhpVal, var_where_clause rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_from_clause_mutated := var_from_clause
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_unique_coupon_count(var_from_clause rt.PhpVal, var_where_time_clause rt.PhpVal, var_where_clause rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_from_clause_mutated := var_from_clause
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.sync_order(var_post_id rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.update(var_order rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.delete_order(var_post_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_num_items_sold(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column() bool {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.is_returning_customer(var_order rt.PhpVal, var_customer_id rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_customer_id_mutated := var_customer_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(var_customer_id rt.PhpVal, var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	mut var_order_id_mutated := var_order_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.add_fulfillment_status_column() bool {
	mut var_wpdb := rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_stats')
		cache_key: rt.new_string('orders_stats')
		column_types: rt.new_array()
		context: rt.new_string('orders_stats')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery() &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_segmenter() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.init()
			return rt.new_null()
		}
		'orders_stats_sql_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.orders_stats_sql_filter(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_stats_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_noncached_stats_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_unique_product_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_unique_product_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_unique_coupon_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_unique_coupon_count(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sync_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.sync_order(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.update(dispatch_arg_0))
		}
		'delete_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.delete_order(dispatch_arg_0)
			return rt.new_null()
		}
		'get_num_items_sold' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_num_items_sold(dispatch_arg_0)
		}
		'get_net_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(dispatch_arg_0)
		}
		'has_fulfillment_status_column' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column())
		}
		'is_returning_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.is_returning_customer(dispatch_arg_0, dispatch_arg_1))
		}
		'set_customer_first_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_fulfillment_status_column' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.add_fulfillment_status_column())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'table_name' { this.table_name = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'column_types' { this.column_types = val; return true }
		'context' { this.context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_orders_stats_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
