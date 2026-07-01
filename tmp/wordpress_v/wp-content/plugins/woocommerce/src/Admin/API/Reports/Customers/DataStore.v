import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_customer_lookup')
		cache_key rt.PhpVal = rt.new_string('customers')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('customers')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) assign_report_columns()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.get_db_table_name() }()
	mut var_orders_count := rt.new_string(rt.new_string('SUM( CASE WHEN parent_id = 0 THEN 1 ELSE 0 END )'))
	mut var_total_spend := rt.new_string(rt.new_string('SUM( total_sales )'))
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'id', val: "${var_table_name.to_string()}.customer_id as id" }, rt.ArrayItem{ key: 'user_id', val: 'user_id' }, rt.ArrayItem{ key: 'username', val: 'username' }, rt.ArrayItem{ key: 'name', val: 'CONCAT_WS( \' \', first_name, last_name ) as name' }, rt.ArrayItem{ key: 'first_name', val: 'first_name' }, rt.ArrayItem{ key: 'last_name', val: 'last_name' }, rt.ArrayItem{ key: 'email', val: 'email' }, rt.ArrayItem{ key: 'country', val: 'country' }, rt.ArrayItem{ key: 'city', val: 'city' }, rt.ArrayItem{ key: 'state', val: 'state' }, rt.ArrayItem{ key: 'postcode', val: 'postcode' }, rt.ArrayItem{ key: 'date_registered', val: 'date_registered' }, rt.ArrayItem{ key: 'date_last_active', val: 'IF( date_last_active <= \'0000-00-00 00:00:00\', NULL, date_last_active ) AS date_last_active' }, rt.ArrayItem{ key: 'date_last_order', val: rt.concat(rt.concat(rt.new_string('MAX( '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.date_created ) as date_last_order')) }, rt.ArrayItem{ key: 'orders_count', val: "${var_orders_count.to_string()} as orders_count" }, rt.ArrayItem{ key: 'total_spend', val: "${var_total_spend.to_string()} as total_spend" }, rt.ArrayItem{ key: 'avg_order_value', val: "CASE WHEN ${var_orders_count.to_string()} = 0 THEN NULL ELSE ${var_total_spend.to_string()} / ${var_orders_count.to_string()} END AS avg_order_value" }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_new_customer'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_customer'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('profile_update'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('added_user_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_registered_customer_via_last_active' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('updated_user_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_registered_customer_via_last_active' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_user'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_customer_by_user_id' }])])
	rt.call_function('add_action', [rt.new_string('remove_user_from_blog'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_customer_by_user_id' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_privacy_remove_order_personal_data'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'anonymize_customer' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_analytics_delete_order_stats'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]), rt.new_int(15), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_created_customer'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'merge_guest_customer_on_delayed_account_creation' }]), rt.new_int(5), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.merge_guest_customer_on_delayed_account_creation(var_customer_id rt.PhpVal, var_new_customer_data rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	if rt.is_true(rt.new_bool(!rt.is_true(var_new_customer_data.array_get('source')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_email := if !(var_new_customer_data.array_get('user_email')).is_null() { var_new_customer_data.array_get('user_email') } else { rt.new_string('') }
	if !rt.is_true(var_email) {
		return rt.new_null()
	}
	mut var_guest_customer_id := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_guest_id_by_email(var_email.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_guest_customer_id)))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'update', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.get_db_table_name() }(), rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_customer_id_mutated }]), rt.create_array([rt.ArrayItem{ key: 'customer_id', val: var_guest_customer_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_on_order_delete(var_order_id rt.PhpVal, var_customer_id rt.PhpVal)  {
	mut var_customer_id_mutated := var_customer_id
	var_customer_id_mutated = rt.call_function('absint', [var_customer_id_mutated.dup()])
	if rt.is_true(rt.identical(rt.new_int(0), var_customer_id_mutated)) {
		return rt.new_null()
	}
	mut var_order_count := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_order_count(var_customer_id_mutated.dup())
	if rt.is_true(rt.identical(rt.new_int(0), var_order_count)) {
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer(var_customer_id_mutated.dup())
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_order_customer(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_format := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.is_order(arg_0, arg_1) }(var_post_id.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order' }, rt.ArrayItem{ key: none, val: 'shop_order_refund' }])))))) {
		return // unsupported expression: Expr_UnaryMinus
	}
	mut var_order := rt.call_function('wc_get_order', [var_post_id.dup()])
	mut var_customer_id := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(var_order.dup())
	if rt.is_true(rt.identical(rt.new_bool(false), var_customer_id)) {
		return // unsupported expression: Expr_UnaryMinus
	}
	mut var_last_order := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_last_order(var_customer_id.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_last_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return // unsupported expression: Expr_UnaryMinus
	}
	// unsupported assign target: Expr_List
	mut var_result := rt.call_method(var_wpdb, 'update', [fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.get_db_table_name() }(), var_data.dup(), rt.create_array([rt.ArrayItem{ key: 'customer_id', val: var_customer_id }]), var_format.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_update_customer'), var_customer_id.dup()])
	return rt.identical(rt.new_int(1), var_result)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_order_by_sql_params(var_query_args rt.PhpVal)  {
	mut var_order_by_clause := this.normalize_order_by_clause(if !(var_query_args.array_get('orderby')).is_null() { var_query_args.array_get('orderby') } else { rt.new_string('date_registered') }, (if !(var_query_args.array_get('order')).is_null() { var_query_args.array_get('order') } else { rt.new_string('desc') }).str())
	this.clear_sql_clause(rt.new_string('order_by'))
	this.add_sql_clause(rt.new_string('order_by'), var_order_by_clause.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) normalize_order_by_clause(var_order_by rt.PhpVal, order string) rt.PhpVal {
	mut var_order_by_mutated := var_order_by
	mut order_mutated := order
	var_order_by_mutated = rt.call_function('esc_sql', [var_order_by_mutated.dup()])
	order_mutated = if rt.is_true(rt.identical(rt.new_string(order_mutated.to_lower()), rt.new_string('asc'))) { 'ASC' } else { 'DESC' }
	mut var_order_by_clause := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_string('location'), var_order_by_mutated)) {
		var_order_by_clause = rt.new_string(rt.new_string("state ${var_order.to_string()}, country ${var_order.to_string()}"))
	} else {
		var_order_by_clause = rt.new_string(rt.new_string("${var_order_by.to_string()} ${var_order.to_string()}"))
	}
	return var_order_by_clause.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_time_period_sql_params(var_query_args rt.PhpVal, var_table_name rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_table_name_mutated := var_table_name
	// unsupported statement: Stmt_Global
	this.clear_sql_clause(rt.create_array([rt.ArrayItem{ key: none, val: 'where' }, rt.ArrayItem{ key: none, val: 'where_time' }, rt.ArrayItem{ key: none, val: 'having' }]))
	mut var_date_param_mapping := rt.create_array([rt.ArrayItem{ key: 'registered', val: rt.create_array([rt.ArrayItem{ key: 'clause', val: 'where' }, rt.ArrayItem{ key: 'column', val: (var_table_name_mutated).str() + '.date_registered' }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'clause', val: 'where' }, rt.ArrayItem{ key: 'column', val: (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_stats.date_created' }]) }, rt.ArrayItem{ key: 'last_active', val: rt.create_array([rt.ArrayItem{ key: 'clause', val: 'where' }, rt.ArrayItem{ key: 'column', val: (var_table_name_mutated).str() + '.date_last_active' }]) }, rt.ArrayItem{ key: 'last_order', val: rt.create_array([rt.ArrayItem{ key: 'clause', val: 'having' }, rt.ArrayItem{ key: 'column', val: rt.concat(rt.concat(rt.new_string('MAX( '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.date_created )')) }]) }])
	mut var_match_operator := this.get_match_operator(var_query_args.dup())
	mut var_where_time_clauses := rt.new_array()
	mut var_having_time_clauses := rt.new_array()
	{
		mut iter_1 := var_date_param_mapping.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param_info := item_1.val
			mut var_query_param := item_1.key
			mut var_subclauses := rt.new_array()
			mut var_before_arg := rt.new_string((var_query_param).str() + '_before')
			mut var_after_arg := rt.new_string((var_query_param).str() + '_after')
			mut var_column_name := var_param_info.array_get('column')
			if !(!rt.is_true(var_query_args.array_get(var_before_arg))) {
				mut var_datetime := create_automattic_woocommerce_admin_api_reports_customers_datetime(var_query_args.array_get(var_before_arg))
				mut var_datetime_str := var_datetime.format(// unsupported expression: Expr_StaticPropertyFetch)
				var_subclauses.array_push("${var_column_name.to_string()} <= '${var_datetime_str.to_string()}'")
			}
			if !(!rt.is_true(var_query_args.array_get(var_after_arg))) {
				var_datetime = create_automattic_woocommerce_admin_api_reports_customers_datetime(var_query_args.array_get(var_after_arg))
				var_datetime_str = var_datetime.format(// unsupported expression: Expr_StaticPropertyFetch)
				var_subclauses.array_push("${var_column_name.to_string()} >= '${var_datetime_str.to_string()}'")
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_subclauses) && rt.is_true(rt.identical(rt.new_string('where'), var_param_info.array_get('clause'))))) {
				var_where_time_clauses.array_push('(' + (rt.call_function('implode', [rt.new_string(' AND '), var_subclauses.dup()])).str() + ')')
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_subclauses) && rt.is_true(rt.identical(rt.new_string('having'), var_param_info.array_get('clause'))))) {
				var_having_time_clauses.array_push('(' + (rt.call_function('implode', [rt.new_string(' AND '), var_subclauses.dup()])).str() + ')')
			}
		}
	}
	if rt.is_true(var_where_time_clauses) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where_time'), 'AND ' + (rt.call_function('implode', [rt.new_string(" ${var_match_operator.to_string()} "), var_where_time_clauses.dup()])).str()])
	}
	if rt.is_true(var_having_time_clauses) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('having'), 'AND ' + (rt.call_function('implode', [rt.new_string(" ${var_match_operator.to_string()} "), var_having_time_clauses.dup()])).str()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_customer_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}; return temp.get_db_table_name() }()
	mut var_order_stats_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_stats')
	this.add_time_period_sql_params(var_query_args.dup(), var_customer_lookup_table.dup())
	this.get_limit_sql_params(var_query_args.dup())
	this.add_order_by_sql_params(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'), rt.new_string("LEFT JOIN ${var_order_stats_table_name.to_string()} ON ${var_customer_lookup_table.to_string()}.customer_id = ${var_order_stats_table_name.to_string()}.customer_id")])
	mut var_match_operator := this.get_match_operator(var_query_args.dup())
	mut var_where_clauses := rt.new_array()
	mut var_having_clauses := rt.new_array()
	mut var_exact_match_params := rt.create_array([rt.ArrayItem{ key: 'name', val: "CONCAT_WS( ' ', ${var_customer_lookup_table.to_string()}.first_name, ${var_customer_lookup_table.to_string()}.last_name )" }, rt.ArrayItem{ key: 'username', val: "${var_customer_lookup_table.to_string()}.username" }, rt.ArrayItem{ key: 'email', val: "${var_customer_lookup_table.to_string()}.email" }, rt.ArrayItem{ key: 'country', val: "${var_customer_lookup_table.to_string()}.country" }])
	{
		mut iter_1 := var_exact_match_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_expression := item_1.val
			mut var_exact_match_param := item_1.key
			if !(!rt.is_true(var_query_args.array_get((var_exact_match_param).str() + '_includes'))) {
				mut var_exact_match_arguments := var_query_args.array_get((var_exact_match_param).str() + '_includes')
				mut var_exact_match_arguments_escaped := rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('explode', [rt.new_string(','), var_exact_match_arguments.dup()])])
				mut var_included := rt.call_function('implode', [rt.new_string('\',\''), var_exact_match_arguments_escaped.dup()])
				var_where_clauses.array_push("${var_column_expression.to_string()} IN ('${var_included.to_string()}')")
			}
			if !(!rt.is_true(var_query_args.array_get((var_exact_match_param).str() + '_excludes'))) {
				var_exact_match_arguments = var_query_args.array_get((var_exact_match_param).str() + '_excludes')
				var_exact_match_arguments_escaped = rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('explode', [rt.new_string(','), var_exact_match_arguments.dup()])])
				mut var_excluded := rt.call_function('implode', [rt.new_string('\',\''), var_exact_match_arguments_escaped.dup()])
				var_where_clauses.array_push("${var_column_expression.to_string()} NOT IN ('${var_excluded.to_string()}')")
			}
		}
	}
	mut var_search_params := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'username' }, rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'all' }])
	if !(!rt.is_true(var_query_args.array_get('search'))) {
		mut var_name_like := rt.new_string()
		if rt.is_true() {
		} else if rt.is_true() {
		} else {
		}
		
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) get_default_query_vars() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(var_order rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_or_create_customer_from_order(var_order rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_format := rt.new_null()
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(var_order rt.PhpVal, var_customer_user rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_customer_user_mutated := var_customer_user
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_guest_id_by_email(var_email rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_email_mutated := var_email
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_email(var_email rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_email_mutated := var_email
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_user_id(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_last_order(var_customer_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_oldest_orders(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_order_count(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer(var_user_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer_via_last_active(var_meta_id rt.PhpVal, var_user_id rt.PhpVal, var_meta_key rt.PhpVal)  {
	mut var_user_id_mutated := var_user_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.is_valid_customer(var_user_id rt.PhpVal) bool {
	mut var_user_id_mutated := var_user_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer(var_customer_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer_by_user_id(var_user_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.anonymize_customer(var_order rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) build_location_filter_clause(var_locations_string rt.PhpVal, is_include bool) string {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) initialize_queries()  {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_customer_lookup')
		cache_key: rt.new_string('customers')
		column_types: rt.new_array()
		context: rt.new_string('customers')
	}
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

fn create_automattic_woocommerce_admin_api_reports_customers_datetime() &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.init()
			return rt.new_null()
		}
		'merge_guest_customer_on_delayed_account_creation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.merge_guest_customer_on_delayed_account_creation(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_on_order_delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'sync_order_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_order_customer(dispatch_arg_0)
		}
		'add_order_by_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_order_by_sql_params(dispatch_arg_0)
			return rt.new_null()
		}
		'normalize_order_by_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.normalize_order_by_clause(dispatch_arg_0, dispatch_arg_1)
		}
		'add_time_period_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_time_period_sql_params(dispatch_arg_0, dispatch_arg_1)
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
		'get_existing_customer_id_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(dispatch_arg_0))
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'get_or_create_customer_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_or_create_customer_from_order(dispatch_arg_0))
		}
		'get_customer_order_data_and_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(dispatch_arg_0, dispatch_arg_1)
		}
		'get_guest_id_by_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_guest_id_by_email(dispatch_arg_0)
		}
		'get_customer_id_by_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_email(dispatch_arg_0))
		}
		'get_customer_id_by_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_user_id(dispatch_arg_0)
		}
		'get_last_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_last_order(dispatch_arg_0))
		}
		'get_oldest_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_oldest_orders(dispatch_arg_0)
		}
		'get_order_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_order_count(dispatch_arg_0)
		}
		'update_registered_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer(dispatch_arg_0))
		}
		'update_registered_customer_via_last_active' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer_via_last_active(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'is_valid_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.is_valid_customer(dispatch_arg_0))
		}
		'delete_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_customer_by_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer_by_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'anonymize_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.anonymize_customer(dispatch_arg_0)
			return rt.new_null()
		}
		'build_location_filter_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.build_location_filter_clause(dispatch_arg_0, dispatch_arg_1))
		}
		'initialize_queries' {
			this.initialize_queries()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_customers_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
