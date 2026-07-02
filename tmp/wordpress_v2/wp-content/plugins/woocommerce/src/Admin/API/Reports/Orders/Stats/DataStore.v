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
	cache_key    rt.PhpVal = rt.new_string('orders_stats')
	column_types rt.PhpVal = rt.new_array()
	context      rt.PhpVal = rt.new_string('orders_stats')
}

fn init_static_automattic_woocommerce_admin_api_reports_orders_stats_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore',
		'table_name', rt.new_string('wc_order_stats'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) construct() {
	this.dispatch_set_prop('date_column_name', rt.call_function('get_option', [
		rt.new_string('woocommerce_date_type'),
		rt.new_string('date_paid'),
	]))
	this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.construct()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) assign_report_columns() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	mut var_refunds :=
		rt.new_string('ABS( SUM( CASE WHEN ${var_table_name.to_string()}.net_total < 0 THEN ${var_table_name.to_string()}.net_total + ${var_table_name.to_string()}.tax_total + ${var_table_name.to_string()}.shipping_total ELSE 0 END ) )')
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.uses_new_full_refund_data()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		var_refunds =
			rt.new_string('ABS( SUM( CASE WHEN ${var_table_name.to_string()}.net_total < 0 THEN ${var_table_name.to_string()}.net_total ELSE 0 END ) )')
	}
	mut var_gross_sale_sum :=
		rt.new_string('${var_table_name.to_string()}.total_sales - ${var_table_name.to_string()}.tax_total - ${var_table_name.to_string()}.shipping_total')
	mut var_gross_sales :=
		rt.new_string('SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_gross_sale_sum.to_string()} ELSE 0 END ) + COALESCE( SUM(discount_amount), 0 ) as gross_sales')
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{
			key: 'orders_count'
			val: 'SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) as orders_count'
		},
		rt.ArrayItem{
			key: 'num_items_sold'
			val: 'SUM(${var_table_name.to_string()}.num_items_sold) as num_items_sold'
		},
		rt.ArrayItem{ key: 'gross_sales', val: var_gross_sales },
		rt.ArrayItem{
			key: 'total_sales'
			val: 'SUM(${var_table_name.to_string()}.total_sales) AS total_sales'
		},
		rt.ArrayItem{ key: 'coupons', val: 'COALESCE( SUM(discount_amount), 0 ) AS coupons' },
		rt.ArrayItem{ key: 'coupons_count', val: 'COALESCE( coupons_count, 0 ) as coupons_count' },
		rt.ArrayItem{ key: 'refunds', val: '${var_refunds.to_string()} AS refunds' },
		rt.ArrayItem{ key: 'taxes', val: 'SUM(${var_table_name.to_string()}.tax_total) AS taxes' },
		rt.ArrayItem{
			key: 'shipping'
			val: 'SUM(${var_table_name.to_string()}.shipping_total) AS shipping'
		},
		rt.ArrayItem{
			key: 'net_revenue'
			val: 'SUM(${var_table_name.to_string()}.net_total) AS net_revenue'
		},
		rt.ArrayItem{
			key: 'avg_items_per_order'
			val: 'SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_table_name.to_string()}.num_items_sold ELSE 0 END ) / SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) AS avg_items_per_order'
		},
		rt.ArrayItem{
			key: 'avg_order_value'
			val: 'SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN ${var_table_name.to_string()}.net_total ELSE 0 END ) / SUM( CASE WHEN ${var_table_name.to_string()}.parent_id = 0 THEN 1 ELSE 0 END ) AS avg_order_value'
		},
		rt.ArrayItem{
			key: 'total_customers'
			val: 'COUNT( DISTINCT( ${var_table_name.to_string()}.customer_id ) ) as total_customers'
		},
	]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.init() {
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_order' }])])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_order' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) orders_stats_sql_filter(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_from_clause := rt.new_string('')
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_2 := iife_temp_2.get_db_table_name()
	mut var_orders_stats_table := iife_result_2
	mut var_product_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_product_lookup')
	mut var_coupon_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_coupon_lookup')
	mut var_tax_rate_lookup := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_tax_lookup')
	mut var_operator := this.get_match_operator(var_query_args.clone())
	mut var_where_filters := rt.new_array()
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_product_lookup.clone(), rt.new_string('product_id'),
		rt.new_string('IN'), this.get_included_products(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_product_lookup.clone(), rt.new_string('product_id'),
		rt.new_string('NOT IN'), this.get_excluded_products(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_product_lookup.clone(), rt.new_string('variation_id'),
		rt.new_string('IN'), this.get_included_variations(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_product_lookup.clone(), rt.new_string('variation_id'),
		rt.new_string('NOT IN'), this.get_excluded_variations(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_coupon_lookup.clone(), rt.new_string('coupon_id'),
		rt.new_string('IN'), this.get_included_coupons(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_coupon_lookup.clone(), rt.new_string('coupon_id'),
		rt.new_string('NOT IN'), this.get_excluded_coupons(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_tax_rate_lookup.clone(), rt.new_string('tax_rate_id'),
		rt.new_string('IN'), rt.call_function('implode', [rt.new_string(','),
		var_query_args.array_get(rt.new_string('tax_rate_includes'))])))
	var_where_filters.array_push(this.get_object_where_filter(var_orders_stats_table.clone(),
		rt.new_string('order_id'), var_tax_rate_lookup.clone(), rt.new_string('tax_rate_id'),
		rt.new_string('NOT IN'), rt.call_function('implode', [
		rt.new_string(','), var_query_args.array_get(rt.new_string('tax_rate_excludes'))])))
	mut var_attribute_subqueries := this.get_attribute_subqueries(var_query_args.clone())
	if rt.is_true(var_attribute_subqueries.array_get(rt.new_string('join')))
		&& rt.is_true(var_attribute_subqueries.array_get(rt.new_string('where'))) {
		mut var_attribute_subquery := create_automattic_woocommerce_admin_api_reports_sqlquery()
		var_attribute_subquery.add_sql_clause(rt.new_string('select'),
			rt.new_string('${var_orders_stats_table.to_string()}.order_id'))
		var_attribute_subquery.add_sql_clause(rt.new_string('from'), var_orders_stats_table.clone())
		var_attribute_subquery.add_sql_clause(rt.new_string('join'),
			rt.new_string('JOIN ${var_product_lookup.to_string()} ON ${var_orders_stats_table.to_string()}.order_id = ${var_product_lookup.to_string()}.order_id'))
		mut iter_1 := var_attribute_subqueries.array_get(rt.new_string('join')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute_join := item_1.val
			var_attribute_subquery.add_sql_clause(rt.new_string('join'), var_attribute_join.clone())
		}
		var_attribute_subquery.add_sql_clause(rt.new_string('where'), rt.new_string(
			'AND (' + (rt.call_function('implode', [rt.new_string(' ${var_operator.to_string()} '), var_attribute_subqueries.array_get(rt.new_string('where'))])).str() +
			')'))
		var_where_filters.array_push(
			'${var_orders_stats_table.to_string()}.order_id IN (' + (var_attribute_subquery.get_query_statement()).str() + ')')
	}
	var_where_filters.array_push(this.get_customer_subquery(var_query_args.clone()))
	mut var_refund_subquery := this.get_refund_subquery(var_query_args.clone())
	var_from_clause = rt.concat(var_from_clause,
		var_refund_subquery.array_get(rt.new_string('from_clause')))
	if rt.is_true(var_refund_subquery.array_get(rt.new_string('where_clause'))) {
		var_where_filters.array_push(var_refund_subquery.array_get(rt.new_string('where_clause')))
	}
	var_where_filters = rt.call_function('array_filter', [var_where_filters.clone()])
	mut var_where_subclause := rt.call_function('implode', [
		rt.new_string(' ${var_operator.to_string()} '),
		var_where_filters.clone(),
	])
	mut var_order_status_filter := this.get_status_subquery(var_query_args.clone(),
		var_operator.clone())
	if rt.is_true(var_order_status_filter) {
		if !rt.is_true(var_query_args.array_get(rt.new_string('status_is')))
			&& !rt.is_true(var_query_args.array_get(rt.new_string('status_is_not'))) {
			var_operator = rt.new_string('AND')
		}
		var_where_subclause = rt.call_function('implode', [
			rt.new_string(' ${var_operator.to_string()} '),
			rt.call_function('array_filter', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_where_subclause },
					rt.ArrayItem{ key: none, val: var_order_status_filter }]),
			]),
		])
	}
	if rt.is_true(var_where_subclause) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ( ${var_where_subclause.to_string()} )')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'add_sql_clause', [rt.new_string('join'),
			var_from_clause.clone()])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string('AND ( ${var_where_subclause.to_string()} )')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('join'),
			var_from_clause.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars(),
		rt.create_array([rt.ArrayItem{ key: 'interval', val: 'week' },
			rt.ArrayItem{ key: 'segmentby', val: '' }, rt.ArrayItem{ key: 'match', val: 'all' },
			rt.ArrayItem{ key: 'status_is', val: rt.new_array() },
			rt.ArrayItem{ key: 'status_is_not', val: rt.new_array() },
			rt.ArrayItem{ key: 'product_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'product_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'coupon_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'coupon_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'tax_rate_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'tax_rate_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'customer_type', val: '' }, rt.ArrayItem{
				key: 'category_includes'
				val: rt.new_array()
			}])])
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_noncached_stats_data(var_query_args rt.PhpVal, var_params rt.PhpVal, var_data rt.PhpVal, var_expected_interval_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_params_mutated := var_params
	mut var_data_mutated := var_data
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_3 := iife_temp_3.get_db_table_name()
	mut var_table_name := iife_result_3
	if var_query_args.array_isset(rt.new_string('date_type')) {
		this.dispatch_set_prop('date_column_name',
			var_query_args.array_get(rt.new_string('date_type')))
	}
	this.initialize_queries()
	mut var_selections := this.selected_columns(var_query_args.clone())
	this.add_time_period_sql_params(var_query_args.clone(), var_table_name.clone())
	this.add_intervals_sql_params(var_query_args.clone(), var_table_name.clone())
	this.add_order_by_sql_params(var_query_args.clone())
	mut var_where_time := this.get_sql_clause(rt.new_string('where_time'))
	var_params_mutated = this.get_limit_sql_params(var_query_args.clone())
	mut var_coupon_join := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN (\n\t\t\t\t\tSELECT\n\t\t\t\t\t\torder_id,\n\t\t\t\t\t\tSUM(discount_amount) AS discount_amount,\n\t\t\t\t\t\tCOUNT(DISTINCT coupon_id) AS coupons_count\n\t\t\t\t\tFROM\n\t\t\t\t\t\t'), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('wc_order_coupon_lookup\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\torder_id\n\t\t\t\t\t) order_coupon_lookup\n\t\t\t\t\tON order_coupon_lookup.order_id = ')), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('wc_order_stats.order_id'))).str())
	this.orders_stats_sql_filter(var_query_args.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('left_join'),
		var_coupon_join.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where_time'),
		var_where_time.clone()])
	mut var_totals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_totals)) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_orders_stats_wp_error(rt.new_string('woocommerce_analytics_revenue_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching revenue data failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	mut var_totals_query := rt.create_array([
		rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_sql_clause', [
			rt.new_string('join'),
		]) },
		rt.ArrayItem{ key: 'where_time_clause', val: var_where_time },
		rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_sql_clause', [
			rt.new_string('where'),
		]) },
	])
	mut var_intervals_query := rt.create_array([
		rt.ArrayItem{ key: 'select_clause', val: this.get_sql_clause(rt.new_string('select')) },
		rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('join'),
		]) },
		rt.ArrayItem{ key: 'where_time_clause', val: var_where_time },
		rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('where'),
		]) },
		rt.ArrayItem{ key: 'limit', val: this.get_sql_clause(rt.new_string('limit')) },
	])
	mut var_unique_products := this.get_unique_product_count(var_totals_query.array_get(rt.new_string('from_clause')),
		var_totals_query.array_get(rt.new_string('where_time_clause')),
		var_totals_query.array_get(rt.new_string('where_clause')))
	var_totals.array_get_mut(0).array_set('products', var_unique_products.clone())
	mut var_segmenter := create_automattic_woocommerce_admin_api_reports_orders_stats_segmenter(var_query_args.clone(), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'report_columns'))
	mut var_unique_coupons := this.get_unique_coupon_count(var_totals_query.array_get(rt.new_string('from_clause')),
		var_totals_query.array_get(rt.new_string('where_time_clause')),
		var_totals_query.array_get(rt.new_string('where_clause')))
	var_totals.array_get_mut(0).array_set('coupons_count', var_unique_coupons.clone())
	var_totals.array_get_mut(0).array_set('segments', var_segmenter.get_totals_segments(var_totals_query.clone(),
		var_table_name.clone()))
	var_totals = rt.array_to_object(this.cast_numbers(var_totals.array_get(rt.new_int(0))))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string((this.get_sql_clause(rt.new_string('select'))).str() + ' AS time_interval')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('left_join'),
		var_coupon_join.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('where_time'),
		var_where_time.clone()])
	mut var_db_intervals := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
	])
	mut var_db_interval_count := rt.new_int(var_db_intervals.clone().array_count())
	this.update_intervals_sql_params(var_query_args.clone(), var_db_interval_count.clone(),
		var_expected_interval_count.clone(), var_table_name.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('order_by'),
		this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(', MAX('), var_table_name),
			rt.new_string('.')), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'date_column_name')), rt.new_string(') AS datetime_anchor'))])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_selections)))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
			rt.new_string(', ' + var_selections.str())])
	}
	mut var_intervals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_intervals)) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_orders_stats_wp_error(rt.new_string('woocommerce_analytics_revenue_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching revenue data failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	if var_intervals.array_isset(rt.new_int(0)) {
		var_unique_coupons = this.get_unique_coupon_count(var_intervals_query.array_get(rt.new_string('from_clause')),
			var_intervals_query.array_get(rt.new_string('where_time_clause')),
			var_intervals_query.array_get(rt.new_string('where_clause')), rt.new_bool(true))
		var_intervals.array_get_mut(0).array_set('coupons_count', var_unique_coupons.clone())
	}
	rt.set_property(var_data_mutated, 'totals', var_totals.clone())
	rt.set_property(var_data_mutated, 'intervals', var_intervals.clone())
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_4 := iife_temp_4.intervals_missing(var_expected_interval_count.clone(),
		var_db_interval_count.clone(), var_params_mutated.array_get(rt.new_string('per_page')),
		var_query_args.array_get(rt.new_string('page')),
		var_query_args.array_get(rt.new_string('order')),
		var_query_args.array_get(rt.new_string('orderby')),
		rt.new_int(var_intervals.clone().array_count()))
	if rt.is_true(iife_result_4) {
		this.fill_in_missing_intervals(var_db_intervals.clone(),
			var_query_args.array_get(rt.new_string('adj_after')),
			var_query_args.array_get(rt.new_string('adj_before')),
			var_query_args.array_get(rt.new_string('interval')), var_data_mutated.clone())
		this.sort_intervals(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('orderby')),
			var_query_args.array_get(rt.new_string('order')))
		this.remove_extra_records(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('page')),
			var_params_mutated.array_get(rt.new_string('per_page')), var_db_interval_count.clone(),
			var_expected_interval_count.clone(),
			var_query_args.array_get(rt.new_string('orderby')),
			var_query_args.array_get(rt.new_string('order')))
	} else {
		this.update_interval_boundary_dates(var_query_args.array_get(rt.new_string('after')),
			var_query_args.array_get(rt.new_string('before')),
			var_query_args.array_get(rt.new_string('interval')), rt.get_property(var_data_mutated,
			'intervals'))
	}
	var_segmenter.add_intervals_segments(var_data_mutated.clone(), var_intervals_query.clone(),
		var_table_name.clone())
	return var_data_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_unique_product_count(var_from_clause rt.PhpVal, var_where_time_clause rt.PhpVal, var_where_clause rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_from_clause_mutated := var_from_clause
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_5 := iife_temp_5.get_db_table_name()
	mut var_table_name := iife_result_5
	return rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\tCOUNT( DISTINCT '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('wc_order_product_lookup.product_id )\n\t\t\t\tFROM\n\t\t\t\t\t')), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_product_lookup JOIN ')), var_table_name),
			rt.new_string(' ON ')), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('wc_order_product_lookup.order_id = ')), var_table_name),
			rt.new_string('.order_id\n\t\t\t\t\t')), var_from_clause_mutated),
			rt.new_string('\n\t\t\t\tWHERE\n\t\t\t\t\t1=1\n\t\t\t\t\t')), var_where_time_clause),
			rt.new_string('\n\t\t\t\t\t')), var_where_clause),
	])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) get_unique_coupon_count(var_from_clause rt.PhpVal, var_where_time_clause rt.PhpVal, var_where_clause rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_from_clause_mutated := var_from_clause
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_6 := iife_temp_6.get_db_table_name()
	mut var_table_name := iife_result_6
	return rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\tCOUNT(DISTINCT coupon_id)\n\t\t\t\tFROM\n\t\t\t\t\t'), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_coupon_lookup JOIN ')), var_table_name),
			rt.new_string(' ON ')), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('wc_order_coupon_lookup.order_id = ')), var_table_name),
			rt.new_string('.order_id\n\t\t\t\t\t')), var_from_clause_mutated),
			rt.new_string('\n\t\t\t\tWHERE\n\t\t\t\t\t1=1\n\t\t\t\t\t')), var_where_time_clause),
			rt.new_string('\n\t\t\t\t\t')), var_where_clause),
	])
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.sync_order(var_post_id rt.PhpVal) i64 {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_7 := iife_temp_7.is_order(var_post_id.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'shop_order' },
		rt.ArrayItem{ key: none, val: 'shop_order_refund' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7)))) {
		return -1
	}
	mut var_order := rt.call_function('wc_get_order', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return -1
	}
	return (Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.update(var_order.clone())).to_i64()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.update(var_order rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_8 := iife_temp_8.get_db_table_name()
	mut var_table_name := iife_result_8
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}))))) {
		return rt.new_int(-1)
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{}
	mut iife_result_9 := iife_temp_9.is_test_order(var_order_mutated.clone())
	if rt.is_true(iife_result_9) {
		return rt.new_int(-1)
	}
	mut var_format := rt.create_array([rt.ArrayItem{ key: none, val: '%d' },
		rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' },
		rt.ArrayItem{ key: none, val: '%f' }, rt.ArrayItem{ key: none, val: '%f' },
		rt.ArrayItem{ key: none, val: '%f' }, rt.ArrayItem{ key: none, val: '%f' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%d' },
		rt.ArrayItem{ key: none, val: '%d' }])
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_10 := iife_temp_10.normalize_order_status(rt.call_method(var_order_mutated,
		'get_status', []rt.PhpVal{}))
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_order_mutated, 'get_parent_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'date_created', val: rt.call_method(rt.call_method(var_order_mutated,
			'get_date_created', []rt.PhpVal{}), 'date', [rt.new_string('Y-m-d H:i:s')]) },
		rt.ArrayItem{
			key: 'date_paid'
			val: if rt.is_true(rt.call_method(var_order_mutated, 'get_date_paid', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order_mutated, 'get_date_paid', []rt.PhpVal{}), 'date', [
					rt.new_string('Y-m-d H:i:s')]) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'date_completed'
			val: if rt.is_true(rt.call_method(var_order_mutated, 'get_date_completed', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order_mutated, 'get_date_completed', []rt.PhpVal{}), 'date', [
					rt.new_string('Y-m-d H:i:s')]) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'date_created_gmt'
			val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}),
					'getTimestamp', []rt.PhpVal{})])
		},
		rt.ArrayItem{
			key: 'num_items_sold'
			val: Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_num_items_sold(var_order_mutated.clone())
		},
		rt.ArrayItem{ key: 'total_sales', val: rt.call_method(var_order_mutated, 'get_total',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'tax_total', val: rt.call_method(var_order_mutated, 'get_total_tax',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'shipping_total', val: rt.call_method(var_order_mutated,
			'get_shipping_total', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'net_total'
			val: Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(var_order_mutated.clone())
		},
		rt.ArrayItem{ key: 'status', val: iife_result_10 },
		rt.ArrayItem{ key: 'customer_id', val: rt.call_method(var_order_mutated,
			'get_report_customer_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'returning_customer', val: rt.call_method(var_order_mutated,
			'is_returning_customer', []rt.PhpVal{}) },
	])
	mut var_order_fulfillment_status := rt.new_string('')
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_11 := iife_temp_11.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_11)
		&& rt.is_true(rt.identical(rt.new_bool(true), Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column()))
		&& rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		mut iife_temp_12 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_12 := iife_temp_12.get_order_fulfillment_status(var_order_mutated.clone())
		var_order_fulfillment_status = iife_result_12
		var_data.array_set('fulfillment_status', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no_fulfillments'),
			var_order_fulfillment_status))))
		{
			var_order_fulfillment_status
		} else {
			rt.new_null()
		})
		var_format.array_push('%s')
	}
	var_data = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_update_order_stats_data'),
		var_data.clone(),
		var_order_mutated.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('shop_order_refund'), rt.call_method(var_order_mutated,
		'get_type', []rt.PhpVal{})))
	{
		mut var_parent_order := rt.call_function('wc_get_order', [
			rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{}),
		])
		if rt.is_true(var_parent_order) {
			var_data.array_set('parent_id', rt.call_method(var_parent_order, 'get_id',
				[]rt.PhpVal{}))
			mut iife_temp_13 :=
				Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
			mut iife_result_13 := iife_temp_13.normalize_order_status(rt.call_method(var_parent_order,
				'get_status', []rt.PhpVal{}))
			var_data.array_set('status', iife_result_13)
			mut var_refund_type := rt.call_method(var_order_mutated, 'get_meta', [
				rt.new_string('_refund_type'),
			])
			mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			mut iife_result_14 := iife_temp_14.uses_new_full_refund_data()
			mut var_uses_new_full_refund_data := iife_result_14
			if rt.is_true(rt.identical(rt.new_string('full'), var_refund_type))
				&& rt.is_true(var_uses_new_full_refund_data) {
				var_data.array_set('num_items_sold', rt.mul(-1,
					Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_num_items_sold(var_parent_order.clone())))
				var_data.array_set('tax_total', rt.mul(-1, rt.call_method(var_parent_order,
					'get_total_tax', []rt.PhpVal{})))
				var_data.array_set('net_total', rt.mul(-1,
					Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(var_parent_order.clone())))
				var_data.array_set('shipping_total', rt.mul(-1, rt.call_method(var_parent_order,
					'get_shipping_total', []rt.PhpVal{})))
			}
		}
		var_data.array_set('date_completed', var_data.array_get(rt.new_string('date_created')))
		var_data.array_set('date_paid', var_data.array_get(rt.new_string('date_created')))
	}
	mut var_result := rt.call_method(var_wpdb, 'replace', [var_table_name.clone(),
		var_data.clone(), var_format.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_analytics_update_order_stats'),
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])
	return rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_result))
		|| rt.is_true(rt.identical(rt.new_int(2), var_result)))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.delete_order(var_post_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_id := rt.new_int(var_post_id.to_i64())
	mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_15 := iife_temp_15.is_order(var_post_id.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'shop_order' },
		rt.ArrayItem{ key: none, val: 'shop_order_refund' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) {
		return
	}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_16 := iife_temp_16.get_existing_customer_id_from_order(var_order.clone())
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_17 := iife_temp_17.get_existing_customer_id_from_order(var_order.clone())
	mut var_customer_id := rt.call_function('absint', [iife_result_16])
	mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_18 := iife_temp_18.get_db_table_name()
	rt.call_method(var_wpdb, 'delete', [iife_result_18,
		rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_analytics_delete_order_stats'),
		var_order_id.clone(),
		var_customer_id.clone(),
	])
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_19 := iife_temp_19.invalidate()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_num_items_sold(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_num_items := rt.new_int(0)
	mut var_line_items := rt.call_method(var_order_mutated, 'get_items', [
		Class_Automattic_WooCommerce_Enums_OrderItemType.line_item(),
	])
	mut iter_2 := var_line_items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_line_item := item_2.val
		var_num_items = rt.add(var_num_items, rt.call_method(var_line_item, 'get_quantity',
			[]rt.PhpVal{}))
	}
	return var_num_items.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(var_order rt.PhpVal) f64 {
	mut var_order_mutated := var_order
	mut var_net_total := rt.new_float(
		rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}).to_f64() -
		rt.call_method(var_order_mutated, 'get_total_tax', []rt.PhpVal{}).to_f64() -
		rt.call_method(var_order_mutated, 'get_shipping_total', []rt.PhpVal{}).to_f64())
	return rt.new_float(var_net_total.to_f64())
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column() bool {
	mut var_wpdb := rt.new_null()
	mut var_column_status := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.option_order_stats_table_has_column_order_fulfillment_status(),
	])
	if !(!rt.is_true(var_column_status)) {
		return (rt.identical(rt.new_string('yes'), var_column_status)).to_bool()
	}
	mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_20 := iife_temp_20.get_db_table_name()
	mut var_table_name := iife_result_20
	mut var_table_exists := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
			var_table_name.clone()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table_exists)))) {
		return false
	}
	mut var_column_exists := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SHOW COLUMNS FROM `${var_table_name.to_string()}` LIKE %s'),
			rt.new_string('fulfillment_status'),
		]),
	])
	if !(!rt.is_true(var_column_exists)) {
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.option_order_stats_table_has_column_order_fulfillment_status(),
			rt.new_string('yes'),
			rt.new_bool(false),
		])
		return true
	}
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.option_order_stats_table_has_column_order_fulfillment_status(),
		rt.new_string('no'),
		rt.new_bool(false),
	])
	return false
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.is_returning_customer(var_order rt.PhpVal, var_customer_id rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_customer_id_mutated := var_customer_id
	if rt.is_true(rt.new_bool(var_customer_id_mutated.clone().is_null())) {
		mut iife_temp_21 :=
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
		mut iife_result_21 :=
			iife_temp_21.get_existing_customer_id_from_order(var_order_mutated.clone())
		var_customer_id_mutated = iife_result_21
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id_mutated)))) {
		return false
	}
	mut iife_temp_22 :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_22 := iife_temp_22.get_oldest_orders(var_customer_id_mutated.clone())
	mut var_oldest_orders := iife_result_22
	if !rt.is_true(var_oldest_orders) {
		return false
	}
	mut var_first_order := var_oldest_orders.array_get(rt.new_int(0))
	mut var_second_order := if var_oldest_orders.array_isset(rt.new_int(1)) {
		var_oldest_orders.array_get(rt.new_int(1))
	} else {
		rt.new_bool(false)
	}
	mut iife_temp_23 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_23 := iife_temp_23.get_excluded_report_order_statuses()
	mut var_excluded_statuses := iife_result_23
	if rt.is_true(rt.less(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}), rt.call_function('wc_string_to_datetime', [rt.get_property(var_first_order, 'date_created')])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}), var_excluded_statuses.clone(), rt.new_bool(true)]))))) {
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(var_customer_id_mutated.clone(), rt.call_method(var_order_mutated,
			'get_id', []rt.PhpVal{}))
		return false
	}
	mut var_is_first_order := rt.new_bool(rt.new_int((rt.call_method(var_order_mutated, 'get_id',
		[]rt.PhpVal{})).to_i64()) == rt.new_int((rt.get_property(var_first_order, 'order_id')).to_i64()))
	mut var_date_change := rt.new_bool(rt.is_true(var_second_order)
		&& rt.is_true(rt.greater(rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}), rt.call_function('wc_string_to_datetime', [rt.get_property(var_first_order, 'date_created')])))
		&& rt.is_true(rt.less(rt.call_function('wc_string_to_datetime', [rt.get_property(var_second_order, 'date_created')]), rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}))))
	mut var_status_change := rt.new_bool(rt.is_true(var_second_order)
		&& rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}), var_excluded_statuses.clone(), rt.new_bool(true)])))
	if rt.is_true(var_is_first_order) && rt.is_true(var_date_change)
		|| rt.is_true(var_status_change) {
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(var_customer_id_mutated.clone(), rt.get_property(var_second_order,
			'order_id'))
		return true
	}
	return rt.new_bool(rt.new_int((rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).to_i64()) != rt.new_int((rt.get_property(var_first_order,
		'order_id')).to_i64()))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(var_customer_id rt.PhpVal, var_order_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	mut var_order_id_mutated := var_order_id
	mut iife_temp_24 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_24 := iife_temp_24.get_db_table_name()
	mut var_orders_stats_table := iife_result_24
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('UPDATE ${var_orders_stats_table.to_string()} SET returning_customer = CASE WHEN order_id = %d THEN false ELSE true END WHERE customer_id = %d'),
			var_order_id_mutated.clone(),
			var_customer_id_mutated.clone(),
		]),
	])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.add_fulfillment_status_column() bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column()) {
		return true
	}
	mut var_result := rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('wc_order_stats\n\t\t\tADD COLUMN fulfillment_status VARCHAR(50) DEFAULT NULL,\n\t\t\tADD INDEX fulfillment_status (fulfillment_status)')),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		return (if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
			rt.get_property(var_wpdb, 'last_error')
		} else {
			rt.call_function('__', [
				rt.new_string('Unknown database error occurred while adding fulfillment_status column.'),
				rt.new_string('woocommerce'),
			])
		}).to_bool()
	}
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.option_order_stats_table_has_column_order_fulfillment_status(),
		rt.new_string('yes'),
		rt.new_bool(false),
	])
	return true
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

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_key:     rt.new_string('orders_stats')
		column_types:  rt.new_array()
		context:       rt.new_string('orders_stats')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_segmenter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
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
			return this.get_noncached_stats_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.sync_order(dispatch_arg_0))
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.update(dispatch_arg_0)
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
			return rt.new_float(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.get_net_total(dispatch_arg_0))
		}
		'has_fulfillment_status_column' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.has_fulfillment_status_column())
		}
		'is_returning_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.is_returning_customer(dispatch_arg_0,
				dispatch_arg_1))
		}
		'set_customer_first_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.set_customer_first_order(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_fulfillment_status_column' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore.add_fulfillment_status_column())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_key' {
			this.cache_key = val
			return true
		}
		'column_types' {
			this.column_types = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
