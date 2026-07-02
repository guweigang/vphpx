import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key    rt.PhpVal = rt.new_string('customers')
	column_types rt.PhpVal = rt.new_array()
	context      rt.PhpVal = rt.new_string('customers')
}

fn init_static_automattic_woocommerce_admin_api_reports_customers_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore',
		'table_name', rt.new_string('wc_customer_lookup'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) assign_report_columns() {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	mut var_orders_count := rt.new_string('SUM( CASE WHEN parent_id = 0 THEN 1 ELSE 0 END )')
	mut var_total_spend := rt.new_string('SUM( total_sales )')
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'id', val: '${var_table_name.to_string()}.customer_id as id' },
		rt.ArrayItem{ key: 'user_id', val: 'user_id' },
		rt.ArrayItem{ key: 'username', val: 'username' },
		rt.ArrayItem{ key: 'name', val: "CONCAT_WS( ' ', first_name, last_name ) as name" },
		rt.ArrayItem{ key: 'first_name', val: 'first_name' },
		rt.ArrayItem{ key: 'last_name', val: 'last_name' },
		rt.ArrayItem{ key: 'email', val: 'email' },
		rt.ArrayItem{ key: 'country', val: 'country' },
		rt.ArrayItem{ key: 'city', val: 'city' },
		rt.ArrayItem{ key: 'state', val: 'state' },
		rt.ArrayItem{ key: 'postcode', val: 'postcode' },
		rt.ArrayItem{ key: 'date_registered', val: 'date_registered' },
		rt.ArrayItem{
			key: 'date_last_active'
			val: "IF( date_last_active <= '0000-00-00 00:00:00', NULL, date_last_active ) AS date_last_active"
		},
		rt.ArrayItem{ key: 'date_last_order', val: rt.concat(rt.concat(rt.new_string('MAX( '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats.date_created ) as date_last_order')) },
		rt.ArrayItem{ key: 'orders_count', val: '${var_orders_count.to_string()} as orders_count' },
		rt.ArrayItem{ key: 'total_spend', val: '${var_total_spend.to_string()} as total_spend' },
		rt.ArrayItem{
			key: 'avg_order_value'
			val: 'CASE WHEN ${var_orders_count.to_string()} = 0 THEN NULL ELSE ${var_total_spend.to_string()} / ${var_orders_count.to_string()} END AS avg_order_value'
		},
	]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.init() {
	rt.call_function('add_action', [rt.new_string('woocommerce_new_customer'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_customer'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('profile_update'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_registered_customer' }])])
	rt.call_function('add_action', [rt.new_string('added_user_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_registered_customer_via_last_active' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('updated_user_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_registered_customer_via_last_active' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_user'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_customer_by_user_id' }])])
	rt.call_function('add_action', [rt.new_string('remove_user_from_blog'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_customer_by_user_id' }])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_privacy_remove_order_personal_data'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'anonymize_customer' }]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_analytics_delete_order_stats'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'sync_on_order_delete' }]),
		rt.new_int(15),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_created_customer'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'merge_guest_customer_on_delayed_account_creation' }]),
		rt.new_int(5), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.merge_guest_customer_on_delayed_account_creation(var_customer_id rt.PhpVal, var_new_customer_data rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	if !rt.is_true(var_new_customer_data.array_get(rt.new_string('source')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('delayed-account-creation'), var_new_customer_data.array_get(rt.new_string('source')))))) {
		return
	}
	mut var_email := if !(var_new_customer_data.array_get(rt.new_string('user_email'))).is_null() {
		var_new_customer_data.array_get(rt.new_string('user_email'))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_email) {
		return
	}
	mut var_guest_customer_id :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_guest_id_by_email(var_email.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_guest_customer_id)))) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	rt.call_method(var_wpdb, 'update', [iife_result_1,
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_customer_id_mutated }]),
		rt.create_array([rt.ArrayItem{ key: 'customer_id', val: var_guest_customer_id }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_on_order_delete(var_order_id rt.PhpVal, var_customer_id rt.PhpVal) {
	mut var_customer_id_mutated := var_customer_id
	var_customer_id_mutated = rt.call_function('absint', [var_customer_id_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_int(0), var_customer_id_mutated)) {
		return
	}
	mut var_order_count :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_order_count(var_customer_id_mutated.clone())
	if rt.is_true(rt.identical(rt.new_int(0), var_order_count)) {
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer(var_customer_id_mutated.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_order_customer(var_post_id rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_format := rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.is_order(var_post_id.clone(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'shop_order' },
		rt.ArrayItem{ key: none, val: 'shop_order_refund' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return -1
	}
	mut var_order := rt.call_function('wc_get_order', [var_post_id.clone()])
	mut var_customer_id :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(var_order.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_customer_id)) {
		return -1
	}
	mut var_last_order :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_last_order(var_customer_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_order))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.call_method(var_last_order, 'get_id', []rt.PhpVal{}))))) {
		return -1
	}
	mut list_tmp_1 :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(var_order.clone())
	var_data = list_tmp_1.array_get(0)
	var_format = list_tmp_1.array_get(1)
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_3 := iife_temp_3.get_db_table_name()
	mut var_result := rt.call_method(var_wpdb, 'update', [iife_result_3, var_data.clone(),
		rt.create_array([rt.ArrayItem{ key: 'customer_id', val: var_customer_id }]),
		var_format.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_analytics_update_customer'),
		var_customer_id.clone(),
	])
	return (rt.identical(rt.new_int(1), var_result)).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_order_by_sql_params(var_query_args rt.PhpVal) {
	mut var_order_by_clause := this.normalize_order_by_clause(if !(var_query_args.array_get(rt.new_string('orderby'))).is_null() {
		var_query_args.array_get(rt.new_string('orderby'))
	} else {
		rt.new_string('date_registered')
	}, (if !(var_query_args.array_get(rt.new_string('order'))).is_null() {
		var_query_args.array_get(rt.new_string('order'))
	} else {
		rt.new_string('desc')
	}).str())
	this.clear_sql_clause(rt.new_string('order_by'))
	this.add_sql_clause(rt.new_string('order_by'), var_order_by_clause.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) normalize_order_by_clause(var_order_by rt.PhpVal, order string) rt.PhpVal {
	mut var_order_by_mutated := var_order_by
	mut order_mutated := order
	var_order_by_mutated = rt.call_function('esc_sql', [var_order_by_mutated.clone()])
	order_mutated = if rt.is_true(rt.identical(rt.new_string(order_mutated.to_lower()),
		rt.new_string('asc')))
	{
		'ASC'
	} else {
		'DESC'
	}
	mut var_order_by_clause := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('location'), var_order_by_mutated)) {
		var_order_by_clause =
			rt.new_string('state ${var_order.to_string()}, country ${var_order.to_string()}')
	} else {
		var_order_by_clause = rt.new_string('${var_order_by.to_string()} ${var_order.to_string()}')
	}
	return var_order_by_clause.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_time_period_sql_params(var_query_args rt.PhpVal, var_table_name rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_table_name_mutated := var_table_name
	this.clear_sql_clause(rt.create_array([rt.ArrayItem{ key: none, val: 'where' },
		rt.ArrayItem{ key: none, val: 'where_time' }, rt.ArrayItem{ key: none, val: 'having' }]))
	mut var_date_param_mapping := rt.create_array([
		rt.ArrayItem{ key: 'registered', val: rt.create_array([
			rt.ArrayItem{ key: 'clause', val: 'where' },
			rt.ArrayItem{ key: 'column', val: var_table_name_mutated.str() + '.date_registered' },
		]) },
		rt.ArrayItem{ key: 'order', val: rt.create_array([
			rt.ArrayItem{ key: 'clause', val: 'where' },
			rt.ArrayItem{ key: 'column', val: (rt.get_property(var_wpdb, 'prefix')).str() +
				'wc_order_stats.date_created' },
		]) },
		rt.ArrayItem{ key: 'last_active', val: rt.create_array([
			rt.ArrayItem{ key: 'clause', val: 'where' },
			rt.ArrayItem{ key: 'column', val: var_table_name_mutated.str() + '.date_last_active' },
		]) },
		rt.ArrayItem{ key: 'last_order', val: rt.create_array([
			rt.ArrayItem{ key: 'clause', val: 'having' },
			rt.ArrayItem{ key: 'column', val: rt.concat(rt.concat(rt.new_string('MAX( '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats.date_created )')) },
		]) },
	])
	mut var_match_operator := this.get_match_operator(var_query_args.clone())
	mut var_where_time_clauses := rt.new_array()
	mut var_having_time_clauses := rt.new_array()
	mut iter_1 := var_date_param_mapping.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param_info := item_1.val
		mut var_query_param := item_1.key
		mut var_subclauses := rt.new_array()
		mut var_before_arg := rt.new_string(var_query_param.str() + '_before')
		mut var_after_arg := rt.new_string(var_query_param.str() + '_after')
		mut var_column_name := var_param_info.array_get(rt.new_string('column'))
		if !(!rt.is_true(var_query_args.array_get(var_before_arg))) {
			mut var_datetime :=
				create_automattic_woocommerce_admin_api_reports_customers_datetime(var_query_args.array_get(var_before_arg))
			mut var_datetime_str := var_datetime.format(rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
				'sql_datetime_format'))
			var_subclauses.array_push("${var_column_name.to_string()} <= '${var_datetime_str.to_string()}'")
		}
		if !(!rt.is_true(var_query_args.array_get(var_after_arg))) {
			var_datetime =
				create_automattic_woocommerce_admin_api_reports_customers_datetime(var_query_args.array_get(var_after_arg))
			var_datetime_str = var_datetime.format(rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
				'sql_datetime_format'))
			var_subclauses.array_push("${var_column_name.to_string()} >= '${var_datetime_str.to_string()}'")
		}
		if rt.is_true(var_subclauses)
			&& rt.is_true(rt.identical(rt.new_string('where'), var_param_info.array_get(rt.new_string('clause')))) {
			var_where_time_clauses.array_push('(' +
				(rt.call_function('implode', [rt.new_string(' AND '), var_subclauses.clone()])).str() +
				')')
		}
		if rt.is_true(var_subclauses)
			&& rt.is_true(rt.identical(rt.new_string('having'), var_param_info.array_get(rt.new_string('clause')))) {
			var_having_time_clauses.array_push('(' +
				(rt.call_function('implode', [rt.new_string(' AND '), var_subclauses.clone()])).str() +
				')')
		}
	}
	if rt.is_true(var_where_time_clauses) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where_time'),
			rt.new_string('AND ' +(rt.call_function('implode', [rt.new_string(' ${var_match_operator.to_string()} '), var_where_time_clauses.clone()])).str())])
	}
	if rt.is_true(var_having_time_clauses) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('having'),
			rt.new_string('AND ' +(rt.call_function('implode', [rt.new_string(' ${var_match_operator.to_string()} '), var_having_time_clauses.clone()])).str())])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_4 := iife_temp_4.get_db_table_name()
	mut var_customer_lookup_table := iife_result_4
	mut var_order_stats_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_stats')
	this.add_time_period_sql_params(var_query_args.clone(), var_customer_lookup_table.clone())
	this.get_limit_sql_params(var_query_args.clone())
	this.add_order_by_sql_params(var_query_args.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'),
		rt.new_string('LEFT JOIN ${var_order_stats_table_name.to_string()} ON ${var_customer_lookup_table.to_string()}.customer_id = ${var_order_stats_table_name.to_string()}.customer_id')])
	mut var_match_operator := this.get_match_operator(var_query_args.clone())
	mut var_where_clauses := rt.new_array()
	mut var_having_clauses := rt.new_array()
	mut var_exact_match_params := rt.create_array([
		rt.ArrayItem{
			key: 'name'
			val: "CONCAT_WS( ' ', ${var_customer_lookup_table.to_string()}.first_name, ${var_customer_lookup_table.to_string()}.last_name )"
		},
		rt.ArrayItem{ key: 'username', val: '${var_customer_lookup_table.to_string()}.username' },
		rt.ArrayItem{ key: 'email', val: '${var_customer_lookup_table.to_string()}.email' },
		rt.ArrayItem{ key: 'country', val: '${var_customer_lookup_table.to_string()}.country' },
	])
	mut iter_2 := var_exact_match_params.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_column_expression := item_2.val
		mut var_exact_match_param := item_2.key
		if !(!rt.is_true(var_query_args.array_get(rt.new_string(var_exact_match_param.str() +
			'_includes')))) {
			mut var_exact_match_arguments := var_query_args.array_get(rt.new_string(
				var_exact_match_param.str() + '_includes'))
			mut var_exact_match_arguments_escaped := rt.call_function('array_map', [
				rt.new_string('esc_sql'),
				rt.call_function('explode', [rt.new_string(','),
					var_exact_match_arguments.clone()]),
			])
			mut var_included := rt.call_function('implode', [
				rt.new_string("','"), var_exact_match_arguments_escaped.clone()])
			var_where_clauses.array_push("${var_column_expression.to_string()} IN ('${var_included.to_string()}')")
		}
		if !(!rt.is_true(var_query_args.array_get(rt.new_string(var_exact_match_param.str() +
			'_excludes')))) {
			var_exact_match_arguments = var_query_args.array_get(rt.new_string(
				var_exact_match_param.str() + '_excludes'))
			var_exact_match_arguments_escaped = rt.call_function('array_map', [
				rt.new_string('esc_sql'),
				rt.call_function('explode', [rt.new_string(','),
					var_exact_match_arguments.clone()]),
			])
			mut var_excluded := rt.call_function('implode', [
				rt.new_string("','"), var_exact_match_arguments_escaped.clone()])
			var_where_clauses.array_push("${var_column_expression.to_string()} NOT IN ('${var_excluded.to_string()}')")
		}
	}
	mut var_search_params := rt.create_array([rt.ArrayItem{ key: none, val: 'name' },
		rt.ArrayItem{ key: none, val: 'username' }, rt.ArrayItem{ key: none, val: 'email' },
		rt.ArrayItem{ key: none, val: 'all' }])
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('search')))) {
		mut var_name_like := rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_query_args.array_get(rt.new_string('search'))])).str() +
			'%')
		if !rt.is_true(var_query_args.array_get(rt.new_string('searchby')))
			|| rt.is_true(rt.identical(rt.new_string('name'), var_query_args.array_get(rt.new_string('searchby'))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_query_args.array_get(rt.new_string('searchby')), var_search_params.clone(), rt.new_bool(true)]))))) {
			mut var_searchby := rt.new_string("CONCAT_WS( ' ', first_name, last_name )")
		} else if rt.is_true(rt.identical(rt.new_string('all'),
			var_query_args.array_get(rt.new_string('searchby'))))
		{
			var_searchby = rt.new_string("CONCAT_WS( ' ', first_name, last_name, username, email )")
		} else {
			var_searchby = var_query_args.array_get(rt.new_string('searchby'))
		}
		var_where_clauses.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('${var_searchby.to_string()} LIKE %s'),
			var_name_like.clone(),
		]))
	}
	mut var_filter_empty_params := rt.create_array([
		rt.ArrayItem{ key: none, val: 'email' },
		rt.ArrayItem{ key: none, val: 'name' },
		rt.ArrayItem{ key: none, val: 'country' },
		rt.ArrayItem{ key: none, val: 'city' },
		rt.ArrayItem{ key: none, val: 'state' },
		rt.ArrayItem{ key: none, val: 'postcode' },
	])
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('filter_empty')))) {
		mut var_fields_to_filter_by := rt.call_function('array_intersect', [
			var_query_args.array_get(rt.new_string('filter_empty')),
			var_filter_empty_params.clone(),
		])
		if rt.is_true(rt.call_function('in_array', [rt.new_string('name'),
			var_fields_to_filter_by.clone(), rt.new_bool(true)]))
		{
			var_fields_to_filter_by = rt.call_function('array_diff', [
				var_fields_to_filter_by.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'name' },
				])])
			var_fields_to_filter_by.array_push("CONCAT_WS( ' ', first_name, last_name )")
		}
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		mut var_fields_with_not_condition := rt.call_function('array_map', [
			rt.new_closure(closure_6_fn),
			var_fields_to_filter_by.clone(),
		])
		var_where_clauses.array_push('(' +
			(rt.call_function('implode', [rt.new_string(' AND '), var_fields_with_not_condition.clone()])).str() +
			')')
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('customers')))) {
		mut var_included_customers := this.get_filtered_ids(var_query_args.clone(),
			rt.new_string('customers'))
		var_where_clauses.array_push('${var_customer_lookup_table.to_string()}.customer_id IN (${var_included_customers.to_string()})')
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('customers_exclude')))) {
		mut var_excluded_customers := this.get_filtered_ids(var_query_args.clone(),
			rt.new_string('customers_exclude'))
		var_where_clauses.array_push('${var_customer_lookup_table.to_string()}.customer_id NOT IN (${var_excluded_customers.to_string()})')
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('users')))) {
		mut var_included_users := this.get_filtered_ids(var_query_args.clone(),
			rt.new_string('users'))
		var_where_clauses.array_push('${var_customer_lookup_table.to_string()}.user_id IN (${var_included_users.to_string()})')
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('location_includes')))) {
		mut var_location_clause :=
			rt.new_string(this.build_location_filter_clause(var_query_args.array_get(rt.new_string('location_includes')), true))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_location_clause)))) {
			var_where_clauses.array_push(var_location_clause.clone())
		}
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('location_excludes')))) {
		var_location_clause = rt.new_string(this.build_location_filter_clause(var_query_args.array_get(rt.new_string('location_excludes')),
			false))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_location_clause)))) {
			var_where_clauses.array_push(var_location_clause.clone())
		}
	}
	if !(!rt.is_true(var_query_args.array_get(rt.new_string('user_type'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_query_args.array_get(rt.new_string('user_type')))))) {
		mut var_user_type := var_query_args.array_get(rt.new_string('user_type'))
		var_where_clauses.array_push('${var_customer_lookup_table.to_string()}.user_id IS ' +
			if rt.is_true(rt.identical(rt.new_string('registered'), var_user_type)) { 'NOT NULL' } else { 'NULL' })
	}
	mut var_numeric_params := rt.create_array([
		rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
			rt.ArrayItem{ key: 'column', val: 'COUNT( order_id )' },
			rt.ArrayItem{ key: 'format', val: '%d' },
		]) },
		rt.ArrayItem{ key: 'total_spend', val: rt.create_array([
			rt.ArrayItem{ key: 'column', val: 'SUM( total_sales )' },
			rt.ArrayItem{ key: 'format', val: '%f' },
		]) },
		rt.ArrayItem{ key: 'avg_order_value', val: rt.create_array([
			rt.ArrayItem{ key: 'column', val: '( SUM( total_sales ) / COUNT( order_id ) )' },
			rt.ArrayItem{ key: 'format', val: '%f' },
		]) },
	])
	mut iter_3 := var_numeric_params.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_param_info := item_3.val
		mut var_numeric_param := item_3.key
		mut var_subclauses := rt.new_array()
		mut var_min_param := rt.new_string(var_numeric_param.str() + '_min')
		mut var_max_param := rt.new_string(var_numeric_param.str() + '_max')
		mut var_or_equal := rt.new_string((if var_query_args.array_isset(var_min_param)
			&& var_query_args.array_isset(var_max_param) {
			'='
		} else {
			''
		}).str())
		if var_query_args.array_isset(var_min_param) {
			var_subclauses.array_push(rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(var_param_info.array_get(rt.new_string('column')),
					rt.new_string(' >')), var_or_equal), rt.new_string(' ')),
					var_param_info.array_get(rt.new_string('format'))),
				var_query_args.array_get(var_min_param),
			]))
		}
		if var_query_args.array_isset(var_max_param) {
			var_subclauses.array_push(rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(var_param_info.array_get(rt.new_string('column')),
					rt.new_string(' <')), var_or_equal), rt.new_string(' ')),
					var_param_info.array_get(rt.new_string('format'))),
				var_query_args.array_get(var_max_param),
			]))
		}
		if rt.is_true(var_subclauses) {
			var_having_clauses.array_push('(' +
				(rt.call_function('implode', [rt.new_string(' AND '), var_subclauses.clone()])).str() +
				')')
		}
	}
	if rt.is_true(var_where_clauses) {
		mut var_preceding_match := rt.new_string((if !rt.is_true(this.get_sql_clause(rt.new_string('where_time'))) {
			' AND '
		} else {
			' ${var_match_operator.to_string()} '
		}).str())
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
			rt.new_string(var_preceding_match.str() +(rt.call_function('implode', [rt.new_string(' ${var_match_operator.to_string()} '), var_where_clauses.clone()])).str())])
	}
	mut var_order_status_filter := this.get_status_subquery(var_query_args.clone())
	if rt.is_true(var_order_status_filter) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('left_join'),
			rt.new_string('AND ( ${var_order_status_filter.to_string()} )')])
	}
	if rt.is_true(var_having_clauses) {
		var_preceding_match = rt.new_string((if !rt.is_true(this.get_sql_clause(rt.new_string('having'))) {
			' AND '
		} else {
			' ${var_match_operator.to_string()} '
		}).str())
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('having'),
			rt.new_string(var_preceding_match.str() +(rt.call_function('implode', [rt.new_string(' ${var_match_operator.to_string()} '), var_having_clauses.clone()])).str())])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'date_registered')
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_7 := iife_temp_7.default_before()
	var_defaults.array_set('order_before', iife_result_7)
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_8 := iife_temp_8.default_after()
	var_defaults.array_set('order_after', iife_result_8)
	return var_defaults.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(var_order rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return false
	}
	mut var_user_id := rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_int(0), var_user_id)) {
		mut var_customer_id := rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT customer_id FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('wc_order_stats WHERE order_id = %d')),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
			]),
		])
		if rt.is_true(var_customer_id) {
			return var_customer_id.to_bool()
		}
		mut var_email := rt.call_method(var_order_mutated, 'get_billing_email', [
			rt.new_string('edit'),
		])
		if rt.is_true(var_email) {
			return (Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_email(var_email.clone())).to_bool()
		} else {
			return false
		}
	} else {
		return (Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_user_id(var_user_id.clone())).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	mut var_selections := this.selected_columns(var_query_args.clone())
	mut var_sql_query_params := this.add_sql_query_params(var_query_args.clone())
	mut var_count_query := rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM (\n\t\t\t\t'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
		rt.new_string('\n\t\t\t) as tt\n\t\t\t'))).str())
	mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		var_count_query.clone(),
	])).to_i64())
	mut var_params := this.get_limit_params(var_query_args.clone())
	mut var_total_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
	])).to_i64())
	if rt.is_true(rt.less(var_query_args.array_get(rt.new_string('page')), rt.new_int(1)))
		|| rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('page')), var_total_pages)) {
		return var_data.clone()
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	mut var_order_by := this.get_sql_clause(rt.new_string('order_by'))
	mut var_aggregated_fields := rt.create_array([
		rt.ArrayItem{ key: none, val: 'orders_count' },
		rt.ArrayItem{ key: none, val: 'total_spend' },
		rt.ArrayItem{ key: none, val: 'avg_order_value' },
	])
	mut var_has_aggregated_field := rt.new_bool(false)
	mut iter_4 := var_aggregated_fields.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_field := item_4.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_order_by.clone(),
			var_field.clone(),
		])))))
		{
			var_has_aggregated_field = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(var_has_aggregated_field) {
		mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
		mut iife_result_9 := iife_temp_9.get_db_table_name()
		mut var_customer_lookup_table := iife_result_9
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
			rt.new_string(var_order_by.str() +
				', ${var_customer_lookup_table.to_string()}.customer_id')])
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
			var_order_by.clone()])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	mut var_customer_data := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_customer_data)) {
		return var_data.clone()
	}
	var_customer_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'cast_numbers' },
		]),
		var_customer_data.clone(),
	])
	var_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_customer_data },
		rt.ArrayItem{ key: 'total', val: var_db_records_count },
		rt.ArrayItem{ key: 'pages', val: var_total_pages },
		rt.ArrayItem{
			key: 'page_no'
			val: rt.new_int((var_query_args.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_or_create_customer_from_order(var_order rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.new_null()
	mut var_format := rt.new_null()
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order_mutated.clone(), rt.new_string('WC_Order')])))))
	{
		return false
	}
	mut var_returning_customer_id :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_existing_customer_id_from_order(var_order_mutated.clone())
	if rt.is_true(var_returning_customer_id) {
		return var_returning_customer_id.to_bool()
	}
	mut list_tmp_2 :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(var_order_mutated.clone())
	var_data = list_tmp_2.array_get(0)
	var_format = list_tmp_2.array_get(1)
	mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_10 := iife_temp_10.get_db_table_name()
	mut var_result := rt.call_method(var_wpdb, 'insert', [iife_result_10, var_data.clone(),
		var_format.clone()])
	mut var_customer_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_new_customer'),
		var_customer_id.clone()])
	return (if rt.is_true(var_result) {
		var_customer_id
	} else {
		rt.new_bool(false)
	}).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(var_order rt.PhpVal, var_customer_user rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_customer_user_mutated := var_customer_user
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'first_name', val: rt.call_method(var_order_mutated,
			'get_customer_first_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'last_name', val: rt.call_method(var_order_mutated,
			'get_customer_last_name', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'email', val: rt.call_method(var_order_mutated, 'get_billing_email', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'city', val: rt.call_method(var_order_mutated, 'get_billing_city', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'state', val: rt.call_method(var_order_mutated, 'get_billing_state', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'postcode', val: rt.call_method(var_order_mutated,
			'get_billing_postcode', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'country', val: rt.call_method(var_order_mutated, 'get_billing_country', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'date_last_active', val: rt.call_function('gmdate', [
			rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', [
				rt.new_string('edit'),
			]), 'getTimestamp', []rt.PhpVal{}),
		]) },
	])
	mut var_format := rt.create_array([rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_order_mutated,
		'get_user_id', []rt.PhpVal{})))))
	{
		mut var_user_id := rt.call_method(var_order_mutated, 'get_user_id', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_customer_user_mutated.clone().is_null())) {
			var_customer_user_mutated =
				create_automattic_woocommerce_admin_api_reports_customers_wc_customer(var_user_id.clone())
		}
		var_data.array_set('email', var_customer_user_mutated.get_email(rt.new_string('edit')))
		var_data.array_set('user_id', var_user_id.clone())
		var_data.array_set('username',
			var_customer_user_mutated.get_username(rt.new_string('edit')))
		var_data.array_set('date_registered', if rt.is_true(var_customer_user_mutated.get_date_created(rt.new_string('edit'))) { rt.call_method(var_customer_user_mutated.get_date_created(rt.new_string('edit')), 'date', [
				rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval', 'sql_datetime_format'),
			]) } else { rt.new_null() })
		var_format.array_push('%d')
		var_format.array_push('%s')
		var_format.array_push('%s')
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_data },
		rt.ArrayItem{ key: none, val: var_format }])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_guest_id_by_email(var_email rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_email_mutated := var_email
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_11 := iife_temp_11.get_db_table_name()
	mut var_table_name := iife_result_11
	mut var_customer_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT customer_id FROM ${var_table_name.to_string()} WHERE email = %s AND user_id IS NULL LIMIT 1'),
			var_email_mutated.clone(),
		]),
	])
	return if rt.is_true(var_customer_id) {
		rt.new_int(var_customer_id.to_i64())
	} else {
		rt.new_bool(false)
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_email(var_email rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_email_mutated := var_email
	if !rt.is_true(var_email_mutated)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [var_email_mutated.clone()]))))) {
		return false
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_12 := iife_temp_12.get_db_table_name()
	mut var_table_name := iife_result_12
	mut var_customer_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT customer_id FROM ${var_table_name.to_string()} WHERE email = %s ORDER BY user_id IS NOT NULL DESC LIMIT 1'),
			var_email_mutated.clone(),
		]),
	])
	return (if rt.is_true(var_customer_id) {
		rt.new_int(var_customer_id.to_i64())
	} else {
		rt.new_bool(false)
	}).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_user_id(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
	mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_13 := iife_temp_13.get_db_table_name()
	mut var_table_name := iife_result_13
	mut var_customer_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT customer_id FROM ${var_table_name.to_string()} WHERE user_id = %d LIMIT 1'),
			var_user_id_mutated.clone(),
		]),
	])
	return if rt.is_true(var_customer_id) {
		rt.new_int(var_customer_id.to_i64())
	} else {
		rt.new_bool(false)
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_last_order(var_customer_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	mut var_orders_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_stats')
	mut var_last_order := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT order_id, date_created_gmt FROM ${var_orders_table.to_string()}\n\t\t\t\tWHERE customer_id = %d\n\t\t\t\tORDER BY date_created_gmt DESC, order_id DESC LIMIT 1'),
			var_customer_id_mutated.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_order)))) {
		return false
	}
	return (rt.call_function('wc_get_order', [
		rt.call_function('absint', [var_last_order.clone()]),
	])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_oldest_orders(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	mut var_orders_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_stats')
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_14 := iife_temp_14.get_excluded_report_order_statuses()
	mut var_excluded_statuses := rt.call_function('array_map', [
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'normalize_order_status' }]),
		iife_result_14,
	])
	mut var_excluded_statuses_condition := rt.new_string('')
	if !(!rt.is_true(var_excluded_statuses)) {
		mut var_excluded_statuses_str := rt.call_function('implode', [
			rt.new_string("','"),
			var_excluded_statuses.clone(),
		])
		var_excluded_statuses_condition =
			rt.new_string("AND status NOT IN ('${var_excluded_statuses_str.to_string()}')")
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT order_id, date_created FROM ${var_orders_table.to_string()} WHERE customer_id = %d ${var_excluded_statuses_condition.to_string()} ORDER BY date_created, order_id ASC LIMIT 2'),
			var_customer_id_mutated.clone(),
		]),
	])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_order_count(var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	var_customer_id_mutated = rt.call_function('absint', [var_customer_id_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_int(0), var_customer_id_mutated)) {
		return rt.new_null()
	}
	mut var_result := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT( order_id ) FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats WHERE customer_id = %d')),
			var_customer_id_mutated.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
		return rt.new_null()
	}
	return rt.new_int(var_result.to_i64())
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer(var_user_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
	mut var_customer :=
		create_automattic_woocommerce_admin_api_reports_customers_wc_customer(var_user_id_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.is_valid_customer(var_user_id_mutated.clone()))))) {
		return false
	}
	mut var_first_name := var_customer.get_first_name()
	mut var_last_name := var_customer.get_last_name()
	if !rt.is_true(var_first_name) {
		var_first_name = var_customer.get_billing_first_name()
	}
	if !rt.is_true(var_last_name) {
		var_last_name = var_customer.get_billing_last_name()
	}
	mut var_last_active := var_customer.get_meta(rt.new_string('wc_last_active'),
		rt.new_bool(true), rt.new_string('edit'))
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: var_user_id_mutated },
		rt.ArrayItem{ key: 'username', val: var_customer.get_username(rt.new_string('edit')) },
		rt.ArrayItem{ key: 'first_name', val: var_first_name },
		rt.ArrayItem{ key: 'last_name', val: var_last_name },
		rt.ArrayItem{ key: 'email', val: var_customer.get_email(rt.new_string('edit')) },
		rt.ArrayItem{ key: 'city', val: var_customer.get_billing_city(rt.new_string('edit')) },
		rt.ArrayItem{ key: 'state', val: var_customer.get_billing_state(rt.new_string('edit')) },
		rt.ArrayItem{ key: 'postcode', val: var_customer.get_billing_postcode(rt.new_string('edit')) },
		rt.ArrayItem{ key: 'country', val: var_customer.get_billing_country(rt.new_string('edit')) },
		rt.ArrayItem{
			key: 'date_registered'
			val: if rt.is_true(var_customer.get_date_created(rt.new_string('edit'))) { rt.call_method(var_customer.get_date_created(rt.new_string('edit')), 'date', [
					rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval', 'sql_datetime_format'),
				]) } else { rt.new_null() }
		},
		rt.ArrayItem{
			key: 'date_last_active'
			val: if rt.is_true(var_last_active) { rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					var_last_active.clone(),
				]) } else { rt.new_null() }
		},
	])
	mut var_format := rt.create_array([rt.ArrayItem{ key: none, val: '%d' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' },
		rt.ArrayItem{ key: none, val: '%s' }])
	mut var_customer_id :=
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_id_by_user_id(var_user_id_mutated.clone())
	if rt.is_true(var_customer_id) {
		var_data.array_set('customer_id', var_customer_id.clone())
		var_format.array_push('%d')
	}
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_15 := iife_temp_15.get_db_table_name()
	mut var_results := rt.call_method(var_wpdb, 'replace', [iife_result_15, var_data.clone(),
		var_format.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_analytics_update_customer'),
		var_customer_id.clone(),
	])
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
	mut iife_result_16 := iife_temp_16.invalidate()
	return var_results.to_bool()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer_via_last_active(var_meta_id rt.PhpVal, var_user_id rt.PhpVal, var_meta_key rt.PhpVal) {
	mut var_user_id_mutated := var_user_id
	if rt.is_true(rt.identical(rt.new_string('wc_last_active'), var_meta_key)) {
		Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer(var_user_id_mutated.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.is_valid_customer(var_user_id rt.PhpVal) bool {
	mut var_user_id_mutated := var_user_id
	mut var_user :=
		create_automattic_woocommerce_admin_api_reports_customers_wp_user(var_user_id_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_user_id_mutated.to_i64()), rt.get_property(var_user,
		'ID')))))
	{
		return false
	}
	mut var_customer_roles := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_analytics_customer_roles'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }]),
	]))
	if !rt.is_true(rt.get_property(var_user, 'roles'))
		|| !rt.is_true(rt.call_function('array_intersect', [rt.get_property(var_user, 'roles'), var_customer_roles.clone()])) {
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer(var_customer_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_customer_id_mutated := var_customer_id
	var_customer_id_mutated = rt.new_int(var_customer_id_mutated.to_i64())
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_17 := iife_temp_17.get_db_table_name()
	mut var_num_deleted := rt.call_method(var_wpdb, 'delete', [iife_result_17,
		rt.create_array([
			rt.ArrayItem{ key: 'customer_id', val: var_customer_id_mutated },
		])])
	if rt.is_true(var_num_deleted) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_analytics_delete_customer'),
			var_customer_id_mutated.clone(),
		])
		mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
		mut iife_result_18 := iife_temp_18.invalidate()
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.delete_customer_by_user_id(var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_user_id_mutated := var_user_id
	if rt.new_int(var_user_id_mutated.to_i64()) < 1
		|| rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_uninitialize_site')])) {
		return
	}
	var_user_id_mutated = rt.new_int(var_user_id_mutated.to_i64())
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_19 := iife_temp_19.get_db_table_name()
	mut var_num_deleted := rt.call_method(var_wpdb, 'delete', [iife_result_19,
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id_mutated }])])
	if rt.is_true(var_num_deleted) {
		mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
		mut iife_result_20 := iife_temp_20.invalidate()
	}
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.anonymize_customer(var_order rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	if !(var_order_mutated.clone().is_object()) {
		var_order_mutated = rt.call_function('wc_get_order', [
			rt.call_function('absint', [var_order_mutated.clone()]),
		])
	}
	mut var_customer_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT customer_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_order_stats WHERE order_id = %d')),
			rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer_id)))) {
		return
	}
	mut var_deleted_text := rt.call_function('__', [rt.new_string('[deleted]'),
		rt.new_string('woocommerce')])
	mut var_updated := rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string("wc_customer_lookup\n\t\t\t\t\tSET\n\t\t\t\t\t\tuser_id = NULL,\n\t\t\t\t\t\tusername = %s,\n\t\t\t\t\t\tfirst_name = %s,\n\t\t\t\t\t\tlast_name = %s,\n\t\t\t\t\t\temail = %s,\n\t\t\t\t\t\tcountry = '',\n\t\t\t\t\t\tpostcode = %s,\n\t\t\t\t\t\tcity = %s,\n\t\t\t\t\t\tstate = %s\n\t\t\t\t\tWHERE\n\t\t\t\t\t\tcustomer_id = %d")),
			rt.create_array([rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: 'deleted@site.invalid' },
				rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: var_deleted_text },
				rt.ArrayItem{ key: none, val: var_customer_id }]),
		]),
	])
	if rt.is_true(var_updated) {
		mut iife_temp_21 := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}
		mut iife_result_21 := iife_temp_21.invalidate()
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) build_location_filter_clause(var_locations_string rt.PhpVal, is_include bool) string {
	mut iife_temp_22 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_22 := iife_temp_22.get_db_table_name()
	mut var_customer_lookup_table := iife_result_22
	mut var_locations_array := rt.call_function('explode', [rt.new_string(','),
		var_locations_string.clone()])
	mut var_country_state_pairs := rt.new_array()
	mut var_countries := rt.new_array()
	mut iter_5 := var_locations_array.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_location := item_5.val
		var_location = rt.new_string(var_location.clone().to_string().trim_space())
		if !rt.is_true(var_location) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_location.clone(),
			rt.new_string(':'),
		])))))
		{
			mut var_parts := rt.call_function('explode', [rt.new_string(':'),
				var_location.clone()])
			if 2 == var_parts.clone().array_count() {
				var_country_state_pairs.array_push(rt.create_array([
					rt.ArrayItem{ key: 'country', val: rt.call_function('esc_sql', [
						var_parts.array_get(rt.new_int(0)),
					]) },
					rt.ArrayItem{ key: 'state', val: rt.call_function('esc_sql', [
						var_parts.array_get(rt.new_int(1)),
					]) },
				]))
			}
		} else {
			var_countries.array_push(rt.call_function('esc_sql', [
				var_location.clone()]))
		}
	}
	mut var_conditions := rt.new_array()
	if !(!rt.is_true(var_country_state_pairs)) {
		mut var_pair_conditions := rt.new_array()
		mut iter_6 := var_country_state_pairs.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_pair := item_6.val
			if var_is_include {
				var_pair_conditions.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('),
					var_customer_lookup_table), rt.new_string(".country = '")),
					var_pair.array_get(rt.new_string('country'))), rt.new_string("' AND ")),
					var_customer_lookup_table), rt.new_string(".state = '")),
					var_pair.array_get(rt.new_string('state'))), rt.new_string("')")))
			} else {
				var_pair_conditions.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('),
					var_customer_lookup_table), rt.new_string(".country != '")),
					var_pair.array_get(rt.new_string('country'))), rt.new_string("' OR ")),
					var_customer_lookup_table), rt.new_string(".state != '")),
					var_pair.array_get(rt.new_string('state'))), rt.new_string("')")))
			}
		}
		mut var_pair_connector :=
			rt.new_string((if var_is_include { ' OR ' } else { ' AND ' }).str())
		var_conditions.array_push('(' +
			(rt.call_function('implode', [var_pair_connector.clone(), var_pair_conditions.clone()])).str() +
			')')
	}
	if !(!rt.is_true(var_countries)) {
		mut var_operator := rt.new_string((if var_is_include { 'IN' } else { 'NOT IN' }).str())
		var_conditions.array_push(
			"${var_customer_lookup_table.to_string()}.country ${var_operator.to_string()} ('" + (rt.call_function('implode', [rt.new_string("','"), var_countries.clone()])).str() +
			"')")
	}
	if !rt.is_true(var_conditions) {
		return ''
	}
	mut var_connector := rt.new_string((if var_is_include { ' OR ' } else { ' AND ' }).str())
	return '(' +
		(rt.call_function('implode', [var_connector.clone(), var_conditions.clone()])).str() + ')'
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) initialize_queries() {
	this.clear_all_clauses()
	mut iife_temp_23 := Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{}
	mut iife_result_23 := iife_temp_23.get_db_table_name()
	mut var_table_name := iife_result_23
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'),
		var_table_name.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string('${var_table_name.to_string()}.customer_id')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.new_string('${var_table_name.to_string()}.customer_id')])
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

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_customers_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_key:     rt.new_string('customers')
		column_types:  rt.new_array()
		context:       rt.new_string('customers')
	}
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

fn create_automattic_woocommerce_admin_api_reports_customers_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime{
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

fn create_automattic_woocommerce_admin_api_reports_customers_wc_customer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer{
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

fn create_automattic_woocommerce_admin_api_reports_customers_wp_user(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User{
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
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.merge_guest_customer_on_delayed_account_creation(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'sync_on_order_delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_on_order_delete(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'sync_order_customer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.sync_order_customer(dispatch_arg_0))
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
			return Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.get_customer_order_data_and_format(dispatch_arg_0,
				dispatch_arg_1)
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
			Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore.update_registered_customer_via_last_active(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Customers_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
