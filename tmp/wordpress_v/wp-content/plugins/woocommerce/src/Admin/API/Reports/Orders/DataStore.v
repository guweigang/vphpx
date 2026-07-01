import rt

pub fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.orders_statuses_all_cache_key() string {
	return 'woocommerce_analytics_orders_statuses_all'
}
struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_stats')
		cache_key rt.PhpVal = rt.new_string('orders')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('orders')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) construct()  {
	this.dispatch_set_prop('date_column_name', rt.call_function('get_option', [rt.new_string('woocommerce_date_type'), rt.new_string('date_paid')]))
	this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.construct()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_analytics_update_order_stats'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_update_order_statuses_cache' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'order_id', val: "DISTINCT ${var_table_name.to_string()}.order_id" }, rt.ArrayItem{ key: 'parent_id', val: "${var_table_name.to_string()}.parent_id" }, rt.ArrayItem{ key: 'date', val: rt.concat(rt.concat(rt.concat(var_table_name, rt.new_string('.')), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'date_column_name')), rt.new_string(' AS date')) }, rt.ArrayItem{ key: 'date_created', val: "${var_table_name.to_string()}.date_created" }, rt.ArrayItem{ key: 'date_created_gmt', val: "${var_table_name.to_string()}.date_created_gmt" }, rt.ArrayItem{ key: 'status', val: "REPLACE(${var_table_name.to_string()}.status, 'wc-', '') as status" }, rt.ArrayItem{ key: 'customer_id', val: "${var_table_name.to_string()}.customer_id" }, rt.ArrayItem{ key: 'net_total', val: "${var_table_name.to_string()}.net_total" }, rt.ArrayItem{ key: 'total_sales', val: "${var_table_name.to_string()}.total_sales" }, rt.ArrayItem{ key: 'num_items_sold', val: "${var_table_name.to_string()}.num_items_sold" }, rt.ArrayItem{ key: 'customer_type', val: "(CASE WHEN ${var_table_name.to_string()}.returning_customer = 0 THEN 'new' ELSE 'returning' END) as customer_type" }]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_stats_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{}; return temp.get_db_table_name() }()
	mut var_order_coupon_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_coupon_lookup')
	mut var_order_product_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_order_tax_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_tax_lookup')
	mut var_operator := this.get_match_operator(var_query_args.dup())
	mut var_where_subquery := rt.new_array()
	mut var_have_joined_products_table := rt.new_bool(rt.new_bool(false))
	this.add_time_period_sql_params(var_query_args.dup(), var_order_stats_lookup_table.dup())
	this.get_limit_sql_params(var_query_args.dup())
	this.add_order_by_sql_params(var_query_args.dup())
	mut var_status_subquery := this.get_status_subquery(var_query_args.dup())
	if rt.is_true(var_status_subquery) {
		if !rt.is_true(var_query_args.array_get('status_is')) && !rt.is_true(var_query_args.array_get('status_is_not')) {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), rt.new_string("AND ${var_status_subquery.to_string()}")])
		} else {
			var_where_subquery.array_push(var_status_subquery.dup())
		}
	}
	mut var_included_orders := this.get_included_orders(var_query_args.dup())
	if rt.is_true(var_included_orders) {
		var_where_subquery.array_push("${var_order_stats_lookup_table.to_string()}.order_id IN (${var_included_orders.to_string()})")
	}
	mut var_excluded_orders := this.get_excluded_orders(var_query_args.dup())
	if rt.is_true(var_excluded_orders) {
		var_where_subquery.array_push("${var_order_stats_lookup_table.to_string()}.order_id NOT IN (${var_excluded_orders.to_string()})")
	}
	if rt.is_true(var_query_args.array_get('customer_type')) {
		mut var_returning_customer := rt.new_int(if rt.is_true(rt.identical(rt.new_string('returning'), var_query_args.array_get('customer_type'))) { rt.new_int(1) } else { rt.new_int(0) })
		var_where_subquery.array_push("${var_order_stats_lookup_table.to_string()}.returning_customer = ${var_returning_customer.to_string()}")
	}
	mut var_refund_subquery := this.get_refund_subquery(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'), var_refund_subquery.array_get('from_clause')])
	if rt.is_true(var_refund_subquery.array_get('where_clause')) {
		var_where_subquery.array_push(var_refund_subquery.array_get('where_clause'))
	}
	mut var_included_coupons := this.get_included_coupons(var_query_args.dup())
	mut var_excluded_coupons := this.get_excluded_coupons(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_included_coupons) || rt.is_true(var_excluded_coupons))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("LEFT JOIN ${var_order_coupon_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_coupon_lookup_table.to_string()}.order_id")])
	}
	if rt.is_true(var_included_coupons) {
		var_where_subquery.array_push("${var_order_coupon_lookup_table.to_string()}.coupon_id IN (${var_included_coupons.to_string()})")
	}
	if rt.is_true(var_excluded_coupons) {
		var_where_subquery.array_push("(${var_order_coupon_lookup_table.to_string()}.coupon_id IS NULL OR ${var_order_coupon_lookup_table.to_string()}.coupon_id NOT IN (${var_excluded_coupons.to_string()}))")
	}
	mut var_included_products := this.get_included_products(var_query_args.dup())
	mut var_excluded_products := this.get_excluded_products(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_included_products) || rt.is_true(var_excluded_products))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("LEFT JOIN ${var_order_product_lookup_table.to_string()} product_lookup")])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("ON ${var_order_stats_lookup_table.to_string()}.order_id = product_lookup.order_id")])
	}
	if rt.is_true(var_included_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("AND product_lookup.product_id IN (${var_included_products.to_string()})")])
		var_where_subquery.array_push('product_lookup.order_id IS NOT NULL')
	}
	if rt.is_true(var_excluded_products) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("AND product_lookup.product_id IN (${var_excluded_products.to_string()})")])
		var_where_subquery.array_push('product_lookup.order_id IS NULL')
	}
	mut var_included_variations := this.get_included_variations(var_query_args.dup())
	mut var_excluded_variations := this.get_excluded_variations(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_included_variations) || rt.is_true(var_excluded_variations))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("LEFT JOIN ${var_order_product_lookup_table.to_string()} variation_lookup")])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("ON ${var_order_stats_lookup_table.to_string()}.order_id = variation_lookup.order_id")])
	}
	if rt.is_true(var_included_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("AND variation_lookup.variation_id IN (${var_included_variations.to_string()})")])
		var_where_subquery.array_push('variation_lookup.order_id IS NOT NULL')
	}
	if rt.is_true(var_excluded_variations) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("AND variation_lookup.variation_id IN (${var_excluded_variations.to_string()})")])
		var_where_subquery.array_push('variation_lookup.order_id IS NULL')
	}
	mut var_included_tax_rates := if !(!rt.is_true(var_query_args.array_get('tax_rate_includes'))) { rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('esc_sql'), var_query_args.array_get('tax_rate_includes')])]) } else { rt.new_bool(false) }
	mut var_excluded_tax_rates := if !(!rt.is_true(var_query_args.array_get('tax_rate_excludes'))) { rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('esc_sql'), var_query_args.array_get('tax_rate_excludes')])]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(var_included_tax_rates) || rt.is_true(var_excluded_tax_rates))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("LEFT JOIN ${var_order_tax_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_tax_lookup_table.to_string()}.order_id")])
	}
	if rt.is_true(var_included_tax_rates) {
		var_where_subquery.array_push("${var_order_tax_lookup_table.to_string()}.tax_rate_id IN (${var_included_tax_rates.to_string()})")
	}
	if rt.is_true(var_excluded_tax_rates) {
		var_where_subquery.array_push("${var_order_tax_lookup_table.to_string()}.tax_rate_id NOT IN (${var_excluded_tax_rates.to_string()}) OR ${var_order_tax_lookup_table.to_string()}.tax_rate_id IS NULL")
	}
	mut var_attribute_subqueries := this.get_attribute_subqueries(var_query_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_attribute_subqueries.array_get('join')) && rt.is_true(var_attribute_subqueries.array_get('where')))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), rt.new_string("JOIN ${var_order_product_lookup_table.to_string()} ON ${var_order_stats_lookup_table.to_string()}.order_id = ${var_order_product_lookup_table.to_string()}.order_id")])
		{
			mut iter_1 := var_attribute_subqueries.array_get('join').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute_join := item_1.val
				rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'), var_attribute_join.dup()])
			}
		}
		var_where_subquery = rt.call_function('array_merge', [var_where_subquery.dup(), var_attribute_subqueries.array_get('where')])
	}
	if 0 < var_where_subquery.dup().array_count() {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'), 'AND (' + (rt.call_function('implode', [rt.new_string(" ${var_operator.to_string()} "), var_where_subquery.dup()])).str() + ')'])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars(), rt.create_array([rt.ArrayItem{ key: 'orderby', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'date_column_name') }, rt.ArrayItem{ key: 'product_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'product_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'coupon_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_rate_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_rate_excludes', val: rt.new_array() }, rt.ArrayItem{ key: 'customer_type', val: rt.new_null() }, rt.ArrayItem{ key: 'status_is', val: rt.new_array() }, rt.ArrayItem{ key: 'extended_info', val: false }, rt.ArrayItem{ key: 'refunds', val: rt.new_null() }, rt.ArrayItem{ key: 'order_includes', val: rt.new_array() }, rt.ArrayItem{ key: 'order_excludes', val: rt.new_array() }])])
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	this.initialize_queries()
	mut var_data := // unsupported expression: Expr_Cast_Object
	mut var_selections := this.selected_columns(var_query_args.dup())
	mut var_params := this.get_limit_params(var_query_args.dup())
	this.add_sql_query_params(var_query_args.dup())
	mut var_db_records_count := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(rt.new_int(0), var_params.array_get('per_page'))) {
		mut var_total_pages := rt.new_int(rt.new_int(0))
	} else {
		var_total_pages = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_query_args.array_get('page'), rt.new_int(1))) || rt.is_true(rt.greater(var_query_args.array_get('page'), var_total_pages)))) {
		var_data = // unsupported expression: Expr_Cast_Object
		return var_data.dup()
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'), var_selections.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'), this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'), this.get_sql_clause(rt.new_string('limit'))])
	mut var_orders_data := rt.call_method(var_wpdb, 'get_results', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_orders_data)) {
		return var_data.dup()
	}
	if rt.is_true(var_query_args.array_get('extended_info')) {
		this.include_extended_info(var_orders_data.dup(), var_query_args.dup())
	}
	var_orders_data = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this) }, rt.ArrayItem{ key: none, val: 'cast_numbers' }]), var_orders_data.dup()])
	var_data = // unsupported expression: Expr_Cast_Object
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) normalize_order_by(var_order_by rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'date_column_name')
	}
	return var_order_by.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) include_extended_info(var_orders_data rt.PhpVal, var_query_args rt.PhpVal)  {
	mut var_orders_data_mutated := var_orders_data
	mut var_mapped_orders := this.map_array_by_key(var_orders_data_mutated.dup(), rt.new_string('order_id'))
	mut var_related_orders := this.get_orders_with_parent_id(var_mapped_orders.dup())
	mut var_order_ids := rt.call_function('array_merge', [rt.func_array_keys(.dup()), rt.func_array_keys(.dup())])
	mut var_products := this.get_products_by_order_ids(.dup())
	mut var_coupons := 
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_orders_with_parent_id(var_orders rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) map_array_by_key(var_array rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_products_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_customers_by_orders(var_orders rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_coupons_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) get_order_attributions_by_order_ids(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.get_all_statuses() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_cache(var_order_id rt.PhpVal)  {
	mut var_order_id_mutated := var_order_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore.maybe_update_order_statuses_transient(var_order_id rt.PhpVal)  {
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) initialize_queries()  {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_orders_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_stats')
		cache_key: rt.new_string('orders')
		column_types: rt.new_array()
		context: rt.new_string('orders')
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_orders_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
