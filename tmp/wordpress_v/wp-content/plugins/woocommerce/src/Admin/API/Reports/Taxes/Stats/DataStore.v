import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore {
	rt.PhpObjectBase
pub mut:
		table_name rt.PhpVal = rt.new_string('wc_order_tax_lookup')
		cache_key rt.PhpVal = rt.new_string('taxes_stats')
		column_types rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('taxes_stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) assign_report_columns()  {
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{}; return temp.get_db_table_name() }()
	this.dispatch_set_prop('report_columns', rt.create_array([rt.ArrayItem{ key: 'tax_codes', val: 'COUNT(DISTINCT tax_rate_id) as tax_codes' }, rt.ArrayItem{ key: 'total_tax', val: 'SUM(total_tax) AS total_tax' }, rt.ArrayItem{ key: 'order_tax', val: 'SUM(order_tax) as order_tax' }, rt.ArrayItem{ key: 'shipping_tax', val: 'SUM(shipping_tax) as shipping_tax' }, rt.ArrayItem{ key: 'orders_count', val: "COUNT( DISTINCT ( CASE WHEN parent_id = 0 THEN ${var_table_name.to_string()}.order_id END ) ) as orders_count" }]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) update_sql_query_params(var_query_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_tax_lookup_table := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{}; return temp.get_db_table_name() }()
	this.add_time_period_sql_params(var_query_args.dup(), var_order_tax_lookup_table.dup())
	mut var_taxes_where_clause := rt.new_string(rt.new_string(''))
	mut var_order_status_filter := this.get_status_subquery(var_query_args.dup())
	if var_query_args.array_isset(rt.new_string('taxes')) && !(!rt.is_true(var_query_args.array_get('taxes'))) {
		mut var_allowed_taxes := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{}; return temp.get_filtered_ids(arg_0, arg_1) }(var_query_args.dup(), rt.new_string('taxes'))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(var_order_status_filter) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where'), var_taxes_where_clause.dup()])
	this.add_intervals_sql_params(var_query_args.dup(), var_order_tax_lookup_table.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('where'), var_taxes_where_clause.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'), (this.get_sql_clause(rt.new_string('select'))).str() + ' AS time_interval'])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('where_time'), this.get_sql_clause(rt.new_string('where_time'))])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore.get_taxes(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_query := rt.new_string(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT\n\t\t\t\ttax_rate_id,\n\t\t\t\ttax_rate_country,\n\t\t\t\ttax_rate_state,\n\t\t\t\ttax_rate_name,\n\t\t\t\ttax_rate_priority\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates\n\t\t')))
	if !(!rt.is_true(var_args_mutated.array_get('include'))) {
		var_args_mutated.array_set('include', rt.cast_array(var_args_mutated.array_get('include')))
		mut var_tax_placeholders := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_args_mutated.array_get('include').array_count()), rt.new_string('%d')])])
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported statement: Stmt_Nop
	}
	return rt.call_method(var_wpdb, 'get_results', [var_query.dup(), rt.get_constant('ARRAY_A')])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults := this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'tax_rate_id')
	var_defaults.array_set('taxes', rt.new_array())
	return var_defaults.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) get_noncached_stats_data(var_query_args rt.PhpVal, var_params rt.PhpVal, var_data rt.PhpVal, var_expected_interval_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	// unsupported statement: Stmt_Global
	mut var_table_name := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{}; return temp.get_db_table_name() }()
	this.initialize_queries()
	mut var_selections := this.selected_columns(var_query_args.dup())
	mut var_order_stats_join := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats ON ')), var_table_name), rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats.order_id')))
	this.update_sql_query_params(var_query_args.dup())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('join'), var_order_stats_join.dup()])
	mut var_db_intervals := rt.call_method(var_wpdb, 'get_col', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{})])
	mut var_db_interval_count := rt.new_int(rt.new_int(var_db_intervals.dup().array_count()))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('select'), var_selections.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('join'), var_order_stats_join.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where_time'), this.get_sql_clause(rt.new_string('where_time'))])
	mut var_totals := rt.call_method(var_wpdb, 'get_results', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_query_statement', []rt.PhpVal{}), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_totals)) {
		return create_automattic_woocommerce_admin_api_reports_taxes_stats_wp_error(rt.new_string('woocommerce_analytics_taxes_stats_result_failed'), rt.call_function('__', [rt.new_string('Sorry, fetching revenue data failed.'), rt.new_string('woocommerce')]))
	}
	mut var_totals_query := rt.create_array([rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_sql_clause', [rt.new_string('join')]) }, rt.ArrayItem{ key: 'where_time_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_sql_clause', [rt.new_string('where_time')]) }, rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'total_query'), 'get_sql_clause', [rt.new_string('where')]) }])
	mut var_intervals_query := rt.create_array([rt.ArrayItem{ key: 'select_clause', val: this.get_sql_clause(rt.new_string('select')) }, rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_sql_clause', [rt.new_string('join')]) }, rt.ArrayItem{ key: 'where_time_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_sql_clause', [rt.new_string('where_time')]) }, rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_sql_clause', [rt.new_string('where')]) }])
	mut var_segmenter := create_automattic_woocommerce_admin_api_reports_taxes_stats_segmenter(var_query_args.dup(), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'report_columns'))
	var_totals.array_get_mut(0).array_set('segments', var_segmenter.get_totals_segments(var_totals_query.dup(), var_table_name.dup()))
	this.update_intervals_sql_params(var_query_args.dup(), var_db_interval_count.dup(), var_expected_interval_count.dup(), var_table_name.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'), ', ' + (var_selections).str()])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'), rt.new_string(", MAX(${var_table_name.to_string()}.date_created) AS datetime_anchor")])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('order_by'), this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('limit'), this.get_sql_clause(rt.new_string('limit'))])
	mut var_intervals := rt.call_method(var_wpdb, 'get_results', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_DataStore', 'DataStoreInterface'], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.identical(rt.new_null(), var_intervals)) {
		return create_automattic_woocommerce_admin_api_reports_taxes_stats_wp_error(rt.new_string('woocommerce_analytics_taxes_stats_result_failed'), rt.call_function('__', [rt.new_string('Sorry, fetching tax data failed.'), rt.new_string('woocommerce')]))
	}
	var_totals = // unsupported expression: Expr_Cast_Object
	rt.set_property(var_data_mutated, 'totals', var_totals.dup())
	rt.set_property(var_data_mutated, 'intervals', var_intervals.dup())
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.intervals_missing(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6) }(var_expected_interval_count.dup(), var_db_interval_count.dup(), var_params.array_get('per_page'), var_query_args.array_get('page'), var_query_args.array_get('order'), var_query_args.array_get('orderby'), rt.new_int(var_intervals.dup().array_count()))) {
		this.fill_in_missing_intervals(var_db_intervals.dup(), var_query_args.array_get('adj_after'), var_query_args.array_get('adj_before'), var_query_args.array_get('interval'), var_data_mutated.dup())
		this.sort_intervals(var_data_mutated.dup(), var_query_args.array_get('orderby'), var_query_args.array_get('order'))
		this.remove_extra_records(var_data_mutated.dup(), var_query_args.array_get('page'), var_params.array_get('per_page'), var_db_interval_count.dup(), var_expected_interval_count.dup(), var_query_args.array_get('orderby'), var_query_args.array_get('order'))
	} else {
		this.update_interval_boundary_dates(var_query_args.array_get('after'), var_query_args.array_get('before'), var_query_args.array_get('interval'), rt.get_property(var_data_mutated, 'intervals'))
	}
	var_segmenter.add_intervals_segments(var_data_mutated.dup(), var_intervals_query.dup(), var_table_name.dup())
	return var_data_mutated.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_taxes_stats_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		table_name: rt.new_string('wc_order_tax_lookup')
		cache_key: rt.new_string('taxes_stats')
		column_types: rt.new_array()
		context: rt.new_string('taxes_stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_taxes_stats_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_taxes_stats_segmenter() &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_timeinterval() &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'update_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore.get_taxes(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'table_name' { return this.table_name }
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_taxes_stats_datastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
