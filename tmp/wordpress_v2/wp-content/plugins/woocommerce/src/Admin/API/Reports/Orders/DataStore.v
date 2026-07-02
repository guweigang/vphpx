import rt

pub fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.orders_statuses_all_cache_key() string {
	return 'woocommerce_analytics_orders_statuses_all'
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key    rt.PhpVal = rt.new_string('orders')
	column_types rt.PhpVal = rt.new_array()
	context      rt.PhpVal = rt.new_string('orders')
}

fn init_static_automattic_woocommerce_admin_api_reports_orders_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', 'table_name',
		rt.new_string('wc_order_stats'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) construct() {
	this.dispatch_set_prop('date_column_name', rt.call_function('get_option', [
		rt.new_string('woocommerce_date_type'),
		rt.new_string('date_paid'),
	]))
	this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.construct()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_analytics_update_order_stats'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_update_order_statuses_cache' }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) assign_report_columns() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'order_id', val: 'DISTINCT ${var_table_name.to_string()}.order_id' },
		rt.ArrayItem{ key: 'parent_id', val: '${var_table_name.to_string()}.parent_id' },
		rt.ArrayItem{ key: 'date', val: rt.concat(rt.concat(rt.concat(var_table_name,
			rt.new_string('.')), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'date_column_name')), rt.new_string(' AS date')) },
		rt.ArrayItem{ key: 'date_created', val: '${var_table_name.to_string()}.date_created' },
		rt.ArrayItem{ key: 'date_created_gmt', val: '${var_table_name.to_string()}.date_created_gmt' },
		rt.ArrayItem{
			key: 'status'
			val: "REPLACE(${var_table_name.to_string()}.status, 'wc-', '') as status"
		},
		rt.ArrayItem{ key: 'customer_id', val: '${var_table_name.to_string()}.customer_id' },
		rt.ArrayItem{ key: 'net_total', val: '${var_table_name.to_string()}.net_total' },
		rt.ArrayItem{ key: 'total_sales', val: '${var_table_name.to_string()}.total_sales' },
		rt.ArrayItem{ key: 'num_items_sold', val: '${var_table_name.to_string()}.num_items_sold' },
		rt.ArrayItem{
			key: 'customer_type'
			val: "(CASE WHEN ${var_table_name.to_string()}.returning_customer = 0 THEN 'new' ELSE 'returning' END) as customer_type"
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	mut var_order_stats_lookup_table := iife_result_1
	mut var_order_coupon_lookup_table := rt.new_string(
		(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_coupon_lookup')
	mut var_order_product_lookup_table := rt.new_string(
		(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_order_tax_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_tax_lookup')
	mut var_operator := this.get_match_operator(var_query_args.clone())
	mut var_where_subquery := rt.new_array()
	mut var_have_joined_products_table := rt.new_bool(false)
	this.add_time_period_sql_params(var_query_args.clone(), var_order_stats_lookup_table.clone())
	this.get_limit_sql_params(var_query_args.clone())
	this.add_order_by_sql_params(var_query_args.clone())
	mut var_status_subquery := this.get_status_subquery(var_query_args.clone())
	if rt.is_true(var_status_subquery) {
		if !rt.is_true(var_query_args.array_get(rt.new_string('status_is')))
			&& !rt.is_true(var_query_args.array_get(rt.new_string('status_is_not'))) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
				rt.new_string('AND ${var_status_subquery.to_string()}')])
		} else {
			var_where_subquery.array_push(var_status_subquery.clone())
		}
	}
	mut var_included_orders := this.get_included_orders(var_query_args.clone())
	if rt.is_true(var_included_orders) {
		var_where_subquery.array_push('${var_order_stats_lookup_table.to_string()}.order_id IN (${var_included_orders.to_string()})')
	}
	mut var_excluded_orders := this.get_excluded_orders(var_query_args.clone())
	if rt.is_true(var_excluded_orders) {
		var_where_subquery.array_push('${var_order_stats_lookup_table.to_string()}.order_id NOT IN (${var_excluded_orders.to_string()})')
	}
	if rt.is_true(var_query_args.array_get(rt.new_string('customer_type'))) {
		mut var_returning_customer := rt.new_int(if rt.is_true(rt.identical(rt.new_string('returning'),
			var_query_args.array_get(rt.new_string('customer_type'))))
		{
			1
		} else {
			0
		})
		var_where_subquery.array_push('${var_order_stats_lookup_table.to_string()}.returning_customer = ${var_returning_customer.to_string()}')
	}
	mut var_refund_subquery := this.get_refund_subquery(var_query_args.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'),
		var_refund_subquery.array_get(rt.new_string('from_clause'))])
	if rt.is_true(var_refund_subquery.array_get(rt.new_string('where_clause'))) {
		var_where_subquery.array_push(var_refund_subquery.array_get(rt.new_string('where_clause')))
	}
	mut var_included_coupons := this.get_included_coupons(var_query_args.clone())
	mut var_excluded_coupons := this.get_excluded_coupons(var_query_args.clone())
	if rt.is_true(var_included_coupons) || rt.is_true(var_excluded_coupons) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('LEFT JOIN ${var_order_coupon_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_coupon_lookup_table.to_string()}.order_id')])
	}
	if rt.is_true(var_included_coupons) {
		var_where_subquery.array_push('${var_order_coupon_lookup_table.to_string()}.coupon_id IN (${var_included_coupons.to_string()})')
	}
	if rt.is_true(var_excluded_coupons) {
		var_where_subquery.array_push('(${var_order_coupon_lookup_table.to_string()}.coupon_id IS NULL OR ${var_order_coupon_lookup_table.to_string()}.coupon_id NOT IN (${var_excluded_coupons.to_string()}))')
	}
	mut var_included_products := this.get_included_products(var_query_args.clone())
	mut var_excluded_products := this.get_excluded_products(var_query_args.clone())
	if rt.is_true(var_included_products) || rt.is_true(var_excluded_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('LEFT JOIN ${var_order_product_lookup_table.to_string()} product_lookup')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('ON ${var_order_stats_lookup_table.to_string()}.order_id = product_lookup.order_id')])
	}
	if rt.is_true(var_included_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('AND product_lookup.product_id IN (${var_included_products.to_string()})')])
		var_where_subquery.array_push('product_lookup.order_id IS NOT NULL')
	}
	if rt.is_true(var_excluded_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('AND product_lookup.product_id IN (${var_excluded_products.to_string()})')])
		var_where_subquery.array_push('product_lookup.order_id IS NULL')
	}
	mut var_included_variations := this.get_included_variations(var_query_args.clone())
	mut var_excluded_variations := this.get_excluded_variations(var_query_args.clone())
	if rt.is_true(var_included_variations) || rt.is_true(var_excluded_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('LEFT JOIN ${var_order_product_lookup_table.to_string()} variation_lookup')])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('ON ${var_order_stats_lookup_table.to_string()}.order_id = variation_lookup.order_id')])
	}
	if rt.is_true(var_included_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('AND variation_lookup.variation_id IN (${var_included_variations.to_string()})')])
		var_where_subquery.array_push('variation_lookup.order_id IS NOT NULL')
	}
	if rt.is_true(var_excluded_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('AND variation_lookup.variation_id IN (${var_excluded_variations.to_string()})')])
		var_where_subquery.array_push('variation_lookup.order_id IS NULL')
	}
	mut var_included_tax_rates := if !(!rt.is_true(var_query_args.array_get(rt.new_string('tax_rate_includes')))) { rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('esc_sql'),
				var_query_args.array_get(rt.new_string('tax_rate_includes'))]),
		]) } else { rt.new_bool(false) }
	mut var_excluded_tax_rates := if !(!rt.is_true(var_query_args.array_get(rt.new_string('tax_rate_excludes')))) { rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('array_map', [rt.new_string('esc_sql'),
				var_query_args.array_get(rt.new_string('tax_rate_excludes'))]),
		]) } else { rt.new_bool(false) }
	if rt.is_true(var_included_tax_rates) || rt.is_true(var_excluded_tax_rates) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('LEFT JOIN ${var_order_tax_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_tax_lookup_table.to_string()}.order_id')])
	}
	if rt.is_true(var_included_tax_rates) {
		var_where_subquery.array_push('${var_order_tax_lookup_table.to_string()}.tax_rate_id IN (${var_included_tax_rates.to_string()})')
	}
	if rt.is_true(var_excluded_tax_rates) {
		var_where_subquery.array_push('${var_order_tax_lookup_table.to_string()}.tax_rate_id NOT IN (${var_excluded_tax_rates.to_string()}) OR ${var_order_tax_lookup_table.to_string()}.tax_rate_id IS NULL')
	}
	mut var_attribute_subqueries := this.get_attribute_subqueries(var_query_args.clone())
	if rt.is_true(var_attribute_subqueries.array_get(rt.new_string('join')))
		&& rt.is_true(var_attribute_subqueries.array_get(rt.new_string('where'))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.new_string('JOIN ${var_order_product_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_product_lookup_table.to_string()}.order_id')])
		mut iter_1 := var_attribute_subqueries.array_get(rt.new_string('join')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute_join := item_1.val
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
				var_attribute_join.clone()])
		}
		var_where_subquery = rt.call_function('array_merge', [
			var_where_subquery.clone(), var_attribute_subqueries.array_get(rt.new_string('where'))])
	}
	if 0 < var_where_subquery.clone().array_count() {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string(
				'AND (' + (rt.call_function('implode', [rt.new_string(' ${var_operator.to_string()} '), var_where_subquery.clone()])).str() +
				')')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars(),
		rt.create_array([
			rt.ArrayItem{ key: 'orderby', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'date_column_name') },
			rt.ArrayItem{ key: 'product_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'product_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'coupon_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'coupon_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'tax_rate_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'tax_rate_excludes', val: rt.new_array() },
			rt.ArrayItem{ key: 'customer_type', val: rt.new_null() },
			rt.ArrayItem{ key: 'status_is', val: rt.new_array() },
			rt.ArrayItem{ key: 'extended_info', val: false },
			rt.ArrayItem{ key: 'refunds', val: rt.new_null() },
			rt.ArrayItem{ key: 'order_includes', val: rt.new_array() },
			rt.ArrayItem{ key: 'order_excludes', val: rt.new_array() },
		])])
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	mut var_selections := this.selected_columns(var_query_args.clone())
	mut var_params := this.get_limit_params(var_query_args.clone())
	this.add_sql_query_params(var_query_args.clone())
	mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT( DISTINCT tt.order_id ) FROM (\n\t\t\t\t'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
			rt.new_string('\n\t\t\t) AS tt')),
	])).to_i64())
	if rt.is_true(rt.identical(rt.new_int(0), var_params.array_get(rt.new_string('per_page')))) {
		mut var_total_pages := rt.new_int(0)
	} else {
		var_total_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
		])).to_i64())
	}
	if rt.is_true(rt.less(var_query_args.array_get(rt.new_string('page')), rt.new_int(1)))
		|| rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('page')), var_total_pages)) {
		var_data = rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.new_array() },
			rt.ArrayItem{ key: 'total', val: var_db_records_count },
			rt.ArrayItem{ key: 'pages', val: 0 },
			rt.ArrayItem{ key: 'page_no', val: 0 },
		]))
		return var_data.clone()
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
		this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	mut var_orders_data := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_orders_data)) {
		return var_data.clone()
	}
	if rt.is_true(var_query_args.array_get(rt.new_string('extended_info'))) {
		this.include_extended_info(var_orders_data.clone(), var_query_args.clone())
	}
	var_orders_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'cast_numbers' },
		]),
		var_orders_data.clone(),
	])
	var_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_orders_data },
		rt.ArrayItem{ key: 'total', val: var_db_records_count },
		rt.ArrayItem{ key: 'pages', val: var_total_pages },
		rt.ArrayItem{
			key: 'page_no'
			val: rt.new_int((var_query_args.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) normalize_order_by(var_order_by rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'date_column_name')
	}
	return var_order_by.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) include_extended_info(var_orders_data rt.PhpVal, var_query_args rt.PhpVal) {
	mut var_orders_data_mutated := var_orders_data
	mut var_mapped_orders := this.map_array_by_key(var_orders_data_mutated.clone(),
		rt.new_string('order_id'))
	mut var_related_orders := this.get_orders_with_parent_id(var_mapped_orders.clone())
	mut var_order_ids := rt.call_function('array_merge', [
		rt.func_array_keys(var_mapped_orders.clone()),
		rt.func_array_keys(var_related_orders.clone()),
	])
	mut var_products := this.get_products_by_order_ids(var_order_ids.clone())
	mut var_coupons := this.get_coupons_by_order_ids(rt.func_array_keys(var_mapped_orders.clone()))
	mut var_order_attributions :=
		this.get_order_attributions_by_order_ids(rt.func_array_keys(var_mapped_orders.clone()))
	mut var_customers := this.get_customers_by_orders(var_orders_data_mutated.clone())
	mut var_mapped_customers := this.map_array_by_key(var_customers.clone(),
		rt.new_string('customer_id'))
	mut var_mapped_data := rt.new_array()
	mut iter_2 := var_products.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product := item_2.val
		if !(var_mapped_data.array_isset(var_product.array_get(rt.new_string('order_id')))) {
			var_mapped_data.array_get_mut(var_product.array_get(rt.new_string('order_id'))).array_set('products',
				rt.new_array())
		}
		mut var_is_variation := rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'),
			var_product.array_get(rt.new_string('variation_id')))))
		mut var_product_data := rt.create_array([
			rt.ArrayItem{
				key: 'id'
				val: if rt.is_true(var_is_variation) {
					var_product.array_get(rt.new_string('variation_id'))
				} else {
					var_product.array_get(rt.new_string('product_id'))
				}
			},
			rt.ArrayItem{ key: 'name', val: var_product.array_get(rt.new_string('product_name')) },
			rt.ArrayItem{
				key: 'quantity'
				val: var_product.array_get(rt.new_string('product_quantity'))
			},
		])
		if rt.is_true(var_is_variation) {
			mut var_variation := rt.call_function('wc_get_product', [
				var_product_data.array_get(rt.new_string('id')),
			])
			mut var_separator := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_variation_title_attributes_separator'),
				rt.new_string(' - '),
				var_variation.clone(),
			])
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
				var_product_data.array_get(rt.new_string('name')),
				var_separator.clone(),
			])))
			{
				mut var_attributes := rt.call_function('wc_get_formatted_variation', [
					var_variation.clone(),
					rt.new_bool(true),
					rt.new_bool(false),
				])
				var_product_data.array_get(rt.new_string('name')) = rt.concat(var_product_data.array_get(rt.new_string('name')), rt.new_string(
					var_separator.str() + var_attributes.str()))
			}
		}
		var_mapped_data.array_get_mut(var_product.array_get(rt.new_string('order_id'))).array_get_mut('products').array_push(var_product_data.clone())
		if var_related_orders.array_isset(var_product.array_get(rt.new_string('order_id'))) {
			var_mapped_data.array_get_mut(var_related_orders.array_get(var_product.array_get(rt.new_string('order_id'))).array_get(rt.new_string('order_id'))).array_get_mut('products').array_push(var_product_data.clone())
		}
	}
	mut iter_3 := var_coupons.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_coupon := item_3.val
		if !(var_mapped_data.array_isset(var_coupon.array_get(rt.new_string('order_id')))) {
			var_mapped_data.array_get_mut(var_coupon.array_get(rt.new_string('order_id'))).array_set('coupons',
				rt.new_array())
		}
		var_mapped_data.array_get_mut(var_coupon.array_get(rt.new_string('order_id'))).array_get_mut('coupons').array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_coupon.array_get(rt.new_string('coupon_id')) },
			rt.ArrayItem{ key: 'code', val: rt.call_function('wc_format_coupon_code', [
				var_coupon.array_get(rt.new_string('coupon_code')),
			]) },
		]))
	}
	mut iter_4 := var_orders_data_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_order_data := item_4.val
		mut var_key := item_4.key
		mut var_defaults := rt.create_array([
			rt.ArrayItem{ key: 'products', val: rt.new_array() },
			rt.ArrayItem{ key: 'coupons', val: rt.new_array() },
			rt.ArrayItem{ key: 'customer', val: rt.new_array() },
			rt.ArrayItem{ key: 'attribution', val: rt.new_array() },
		])
		mut var_order_id := var_order_data.array_get(rt.new_string('order_id'))
		var_orders_data_mutated.array_get_mut(var_key).array_set('extended_info', if var_mapped_data.array_isset(var_order_id) { rt.call_function('array_merge', [
				var_defaults.clone(),
				var_mapped_data.array_get(var_order_id),
			]) } else { var_defaults })
		if rt.is_true(var_order_data.array_get(rt.new_string('customer_id')))
			&& var_mapped_customers.array_isset(var_order_data.array_get(rt.new_string('customer_id'))) {
			var_orders_data_mutated.array_get_mut(var_key).array_get_mut('extended_info').array_set('customer',
				var_mapped_customers.array_get(var_order_data.array_get(rt.new_string('customer_id'))))
		}
		mut var_source_type := if !(var_order_attributions.array_get(var_order_id).array_get(rt.new_string('_wc_order_attribution_source_type'))).is_null() {
			var_order_attributions.array_get(var_order_id).array_get(rt.new_string('_wc_order_attribution_source_type'))
		} else {
			rt.new_string('')
		}
		mut var_utm_source := if !(var_order_attributions.array_get(var_order_id).array_get(rt.new_string('_wc_order_attribution_utm_source'))).is_null() {
			var_order_attributions.array_get(var_order_id).array_get(rt.new_string('_wc_order_attribution_utm_source'))
		} else {
			rt.new_string('')
		}
		var_orders_data_mutated.array_get_mut(var_key).array_get_mut('extended_info').array_get_mut('attribution').array_set('origin', this.get_origin_label(var_source_type.clone(),
			var_utm_source.clone()))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_orders_with_parent_id(var_orders rt.PhpVal) rt.PhpVal {
	mut var_related_orders := rt.new_array()
	mut iter_5 := var_orders.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_order := item_5.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'),
			var_order.array_get(rt.new_string('parent_id'))))))
		{
			var_related_orders.array_set(var_order.array_get(rt.new_string('parent_id')),
				var_order.clone())
		}
	}
	return var_related_orders.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) map_array_by_key(var_array rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_mapped := rt.new_array()
	mut iter_6 := var_array.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		var_mapped.array_set(var_item.array_get(var_key), var_item.clone())
	}
	return var_mapped.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_products_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_order_product_lookup_table := rt.new_string(
		(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_included_order_ids := rt.call_function('implode', [
		rt.new_string(','), var_order_ids_mutated.clone()])
	mut var_products := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\torder_id,\n\t\t\t\tproduct_id,\n\t\t\t\tvariation_id,\n\t\t\t\tpost_title as product_name,\n\t\t\t\tproduct_qty as product_quantity\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string('\n\t\t\tJOIN\n\t\t\t\t')), var_order_product_lookup_table),
			rt.new_string('\n\t\t\t\tON ')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string('.ID = (\n\t\t\t\t\tCASE WHEN variation_id > 0\n\t\t\t\t\t\tTHEN variation_id\n\t\t\t\t\t\tELSE product_id\n\t\t\t\t\tEND\n\t\t\t\t)\n\t\t\tWHERE order_id IN (')),
			var_included_order_ids), rt.new_string(')\n\t\t\t\tAND product_qty > 0\n\t\t\t')),
		rt.get_constant('ARRAY_A'),
	])
	return var_products.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_customers_by_orders(var_orders rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_customer_lookup')
	mut var_customer_ids := rt.new_array()
	mut iter_7 := var_orders.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_order := item_7.val
		if rt.is_true(var_order.array_get(rt.new_string('customer_id'))) {
			var_customer_ids.array_push(var_order.array_get(rt.new_string('customer_id')).to_i64())
		}
	}
	if !rt.is_true(var_customer_ids) {
		return rt.new_array()
	}
	var_customer_ids = rt.call_function('implode', [rt.new_string(','),
		var_customer_ids.clone()])
	mut var_customers := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('SELECT * FROM ${var_customer_lookup_table.to_string()} WHERE customer_id IN (${var_customer_ids.to_string()})'),
		rt.get_constant('ARRAY_A'),
	])
	return var_customers.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_coupons_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_order_coupon_lookup_table := rt.new_string(
		(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_coupon_lookup')
	mut var_included_order_ids := rt.call_function('implode', [
		rt.new_string(','), var_order_ids_mutated.clone()])
	mut var_coupons := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT order_id, coupon_id, post_title as coupon_code\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string('\n\t\t\t\tJOIN ')), var_order_coupon_lookup_table),
			rt.new_string(' ON ')), var_order_coupon_lookup_table), rt.new_string('.coupon_id = ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID\n\t\t\t\tWHERE\n\t\t\t\t\torder_id IN (')),
			var_included_order_ids), rt.new_string(')\n\t\t\t\t')),
		rt.get_constant('ARRAY_A'),
	])
	return var_coupons.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_order_attributions_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_2 := iife_temp_2.get_meta_table_name()
	mut var_order_meta_table := iife_result_2
	mut var_included_order_ids := rt.call_function('implode', [
		rt.new_string(','),
		rt.call_function('array_map', [rt.new_string('absint'),
			var_order_ids_mutated.clone()])])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 := iife_temp_3.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_3) {
		mut var_order_attributions_meta := rt.call_method(var_wpdb, 'get_results', [
			rt.new_string("SELECT order_id, meta_key, meta_value\n\t\t\t\t\tFROM ${var_order_meta_table.to_string()}\n\t\t\t\t\tWHERE order_id IN (${var_included_order_ids.to_string()})\n\t\t\t\t\tAND meta_key IN ( '_wc_order_attribution_source_type', '_wc_order_attribution_utm_source' )\n\t\t\t\t\t"),
			rt.get_constant('ARRAY_A'),
		])
	} else {
		var_order_attributions_meta = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_id as order_id, meta_key, meta_value\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string('\n\t\t\t\t\tWHERE post_id IN (')),
				var_included_order_ids),
				rt.new_string(")\n\t\t\t\t\tAND meta_key IN ( '_wc_order_attribution_source_type', '_wc_order_attribution_utm_source' )\n\t\t\t\t\t")),
			rt.get_constant('ARRAY_A'),
		])
	}
	mut var_order_attributions := rt.new_array()
	mut iter_8 := var_order_attributions_meta.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_meta := item_8.val
		if !(var_order_attributions.array_isset(var_meta.array_get(rt.new_string('order_id')))) {
			var_order_attributions.array_set(var_meta.array_get(rt.new_string('order_id')),
				rt.new_array())
		}
		var_order_attributions.array_get_mut(var_meta.array_get(rt.new_string('order_id'))).array_set(var_meta.array_get(rt.new_string('meta_key')),
			var_meta.array_get(rt.new_string('meta_value')))
	}
	return var_order_attributions.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.get_all_statuses() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_statuses := rt.call_function('wp_cache_get', [
		Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.orders_statuses_all_cache_key(),
		rt.new_string('woocommerce_analytics'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_statuses)) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
		mut iife_result_4 := iife_temp_4.get_db_table_name()
		mut var_table_name := iife_result_4
		var_statuses = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT DISTINCT status FROM %i'),
				var_table_name.clone(),
			]),
		])
		rt.call_function('wp_cache_set', [
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.orders_statuses_all_cache_key(),
			var_statuses.clone(),
			rt.new_string('woocommerce_analytics'),
			rt.get_constant('YEAR_IN_SECONDS'),
		])
	}
	return var_statuses.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_cache(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	mut var_order := rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
	if rt.is_true(var_order) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
		mut iife_result_5 := iife_temp_5.normalize_order_status(rt.call_method(var_order,
			'get_status', []rt.PhpVal{}))
		mut var_status := iife_result_5
		mut var_statuses :=
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.get_all_statuses()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_status.clone(), var_statuses.clone(), rt.new_bool(true)])))))
		{
			var_statuses.array_push(var_status.clone())
			rt.call_function('wp_cache_set', [
				Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.orders_statuses_all_cache_key(),
				var_statuses.clone(),
				rt.new_string('woocommerce_analytics'),
				rt.get_constant('YEAR_IN_SECONDS'),
			])
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_transient(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.3.0'), rt.new_string(@STRUCT + '::maybe_update_order_statuses_cache()')])
	Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_cache(var_order_id_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) initialize_queries() {
	this.clear_all_clauses()
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_6 := iife_temp_6.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string(iife_result_6.str() + '.order_id')])
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}
	mut iife_result_7 := iife_temp_7.get_db_table_name()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), iife_result_7])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_key:     rt.new_string('orders')
		column_types:  rt.new_array()
		context:       rt.new_string('orders')
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

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.init()
			return rt.new_null()
		}
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_order_by(dispatch_arg_0)
		}
		'include_extended_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.include_extended_info(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_orders_with_parent_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_orders_with_parent_id(dispatch_arg_0)
		}
		'map_array_by_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.map_array_by_key(dispatch_arg_0, dispatch_arg_1)
		}
		'get_products_by_order_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products_by_order_ids(dispatch_arg_0)
		}
		'get_customers_by_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_customers_by_orders(dispatch_arg_0)
		}
		'get_coupons_by_order_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupons_by_order_ids(dispatch_arg_0)
		}
		'get_order_attributions_by_order_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_attributions_by_order_ids(dispatch_arg_0)
		}
		'get_all_statuses' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.get_all_statuses()
		}
		'maybe_update_order_statuses_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_update_order_statuses_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_transient(dispatch_arg_0)
			return rt.new_null()
		}
		'initialize_queries' {
			this.initialize_queries()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
