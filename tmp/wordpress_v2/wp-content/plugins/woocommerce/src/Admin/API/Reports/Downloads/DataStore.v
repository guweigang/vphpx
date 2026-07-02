import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore {
	rt.PhpObjectBase
pub mut:
	cache_key    rt.PhpVal = rt.new_string('downloads')
	column_types rt.PhpVal = rt.new_array()
	context      rt.PhpVal = rt.new_string('downloads')
}

fn init_static_automattic_woocommerce_admin_api_reports_downloads_datastore() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'table_name', rt.new_string('wc_download_log'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) assign_report_columns() {
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'download_log_id as id' },
		rt.ArrayItem{ key: 'date', val: 'timestamp as date_gmt' },
		rt.ArrayItem{ key: 'download_id', val: 'product_permissions.download_id' },
		rt.ArrayItem{ key: 'product_id', val: 'product_permissions.product_id' },
		rt.ArrayItem{ key: 'order_id', val: 'product_permissions.order_id' },
		rt.ArrayItem{ key: 'user_id', val: 'product_permissions.user_id' },
		rt.ArrayItem{ key: 'ip_address', val: 'user_ip_address as ip_address' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) add_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_lookup_table := iife_result_0
	mut var_permission_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'woocommerce_downloadable_product_permissions')
	mut var_operator := this.get_match_operator(var_query_args.clone())
	mut var_where_filters := rt.new_array()
	mut var_join :=
		rt.new_string('JOIN ${var_permission_table.to_string()} as product_permissions ON ${var_lookup_table.to_string()}.permission_id = product_permissions.permission_id')
	mut var_where_time := this.add_time_period_sql_params(var_query_args.clone(),
		var_lookup_table.clone())
	if rt.is_true(var_where_time) {
		if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery')).is_null() {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where_time'),
				var_where_time.clone()])
		} else {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'interval_query'), 'add_sql_clause', [
				rt.new_string('where_time'), var_where_time.clone()])
		}
	}
	this.get_limit_sql_params(var_query_args.clone())
	var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
		rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('product_id'),
		rt.new_string('IN'), this.get_included_products(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
		rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('product_id'),
		rt.new_string('NOT IN'), this.get_excluded_products(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
		rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('order_id'),
		rt.new_string('IN'), this.get_included_orders(var_query_args.clone())))
	var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
		rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('order_id'),
		rt.new_string('NOT IN'), this.get_excluded_orders(var_query_args.clone())))
	mut var_customer_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_customer_lookup')
	mut var_customer_lookup :=
		rt.new_string('SELECT ${var_customer_lookup_table.to_string()}.user_id FROM ${var_customer_lookup_table.to_string()} WHERE ${var_customer_lookup_table.to_string()}.customer_id IN (%s)')
	mut var_included_customers := this.get_included_customers(var_query_args.clone())
	mut var_excluded_customers := this.get_excluded_customers(var_query_args.clone())
	if rt.is_true(var_included_customers) {
		var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
			rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('user_id'),
			rt.new_string('IN'), rt.call_function('sprintf', [
			var_customer_lookup.clone(), var_included_customers.clone()])))
	}
	if rt.is_true(var_excluded_customers) {
		var_where_filters.array_push(this.get_object_where_filter(var_lookup_table.clone(),
			rt.new_string('permission_id'), var_permission_table.clone(), rt.new_string('user_id'),
			rt.new_string('NOT IN'), rt.call_function('sprintf', [
			var_customer_lookup.clone(), var_excluded_customers.clone()])))
	}
	mut var_included_ip_addresses := this.get_included_ip_addresses(var_query_args.clone())
	mut var_excluded_ip_addresses := this.get_excluded_ip_addresses(var_query_args.clone())
	if rt.is_true(var_included_ip_addresses) {
		var_where_filters.array_push("${var_lookup_table.to_string()}.user_ip_address IN ('${var_included_ip_addresses.to_string()}')")
	}
	if rt.is_true(var_excluded_ip_addresses) {
		var_where_filters.array_push("${var_lookup_table.to_string()}.user_ip_address NOT IN ('${var_excluded_ip_addresses.to_string()}')")
	}
	var_where_filters = rt.call_function('array_filter', [var_where_filters.clone()])
	mut var_where_subclause := rt.call_function('implode', [
		rt.new_string(' ${var_operator.to_string()} '),
		var_where_filters.clone(),
	])
	if rt.is_true(var_where_subclause) {
		if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery')).is_null() {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'subquery'), 'add_sql_clause', [rt.new_string('where'),
				rt.new_string('AND ( ${var_where_subclause.to_string()} )')])
		} else {
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this), 'interval_query'), 'add_sql_clause', [
				rt.new_string('where'), rt.new_string('AND ( ${var_where_subclause.to_string()} )')])
		}
	}
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery')).is_null() {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			var_join.clone()])
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('join'),
			var_join.clone()])
	}
	this.add_order_by(var_query_args.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_included_ip_addresses(var_query_args rt.PhpVal) rt.PhpVal {
	return rt.new_string(this.get_filtered_ip_addresses(var_query_args.clone(),
		rt.new_string('ip_address_includes')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_excluded_ip_addresses(var_query_args rt.PhpVal) rt.PhpVal {
	return rt.new_string(this.get_filtered_ip_addresses(var_query_args.clone(),
		rt.new_string('ip_address_excludes')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_filtered_ip_addresses(var_query_args rt.PhpVal, var_field rt.PhpVal) string {
	if var_query_args.array_isset(var_field) && var_query_args.array_get(var_field).is_array()
		&& var_query_args.array_get(var_field).array_count() > 0 {
		mut var_ip_addresses := rt.call_function('array_map', [
			rt.new_string('esc_sql'), var_query_args.array_get(var_field)])
		var_ip_addresses = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_analytics_' + var_field.str()),
			var_ip_addresses.clone(),
			var_query_args.clone(),
			var_field.clone(),
			this.context,
		])
		return (rt.call_function('implode', [rt.new_string("','"),
			var_ip_addresses.clone()])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_included_customers(var_query_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{}
	mut iife_result_1 := iife_temp_1.get_filtered_ids(var_query_args.clone(),
		rt.new_string('customer_includes'))
	return iife_result_1
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_excluded_customers(var_query_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{}
	mut iife_result_2 := iife_temp_2.get_filtered_ids(var_query_args.clone(),
		rt.new_string('customer_excludes'))
	return iife_result_2
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) add_time_period_sql_params(var_query_args rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
	mut var_table_name_mutated := var_table_name
	mut var_where_time := rt.new_string('')
	if rt.is_true(var_query_args.array_get(rt.new_string('before'))) {
		mut var_datetime_str := rt.call_method(var_query_args.array_get(rt.new_string('before')),
			'format', [
			rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
				'sql_datetime_format'),
		])
		var_where_time = rt.concat(var_where_time,
			rt.new_string(" AND ${var_table_name.to_string()}.timestamp <= '${var_datetime_str.to_string()}'"))
	}
	if rt.is_true(var_query_args.array_get(rt.new_string('after'))) {
		var_datetime_str = rt.call_method(var_query_args.array_get(rt.new_string('after')),
			'format', [
			rt.get_static_prop('Automattic_WooCommerce_Admin_API_Reports_TimeInterval',
				'sql_datetime_format'),
		])
		var_where_time = rt.concat(var_where_time,
			rt.new_string(" AND ${var_table_name.to_string()}.timestamp >= '${var_datetime_str.to_string()}'"))
	}
	return var_where_time.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) add_order_by(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	this.clear_sql_clause(rt.new_string('order_by'))
	mut var_order_by := rt.new_string('')
	if var_query_args.array_isset(rt.new_string('orderby')) {
		var_order_by = rt.new_string(this.normalize_order_by(rt.call_function('esc_sql', [
			var_query_args.array_get(rt.new_string('orderby')),
		])))
		this.add_sql_clause(rt.new_string('order_by'), var_order_by.clone())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_order_by.clone(),
		rt.new_string('_products'),
	])))))
	{
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'add_sql_clause', [rt.new_string('join'),
			rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(' AS _products ON product_permissions.product_id = _products.ID'))])
	}
	this.add_orderby_order_clause(var_query_args.clone(), rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		[]string{}, this))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_default_query_vars()
	var_defaults.array_set('orderby', 'timestamp')
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	this.initialize_queries()
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'pages', val: 0 },
		rt.ArrayItem{ key: 'page_no', val: 0 },
	]))
	mut var_selections := this.selected_columns(var_query_args.clone())
	this.add_sql_query_params(var_query_args.clone())
	mut var_db_records_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM (\n\t\t\t\t'), rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{})),
			rt.new_string('\n\t\t\t) AS tt')),
	])).to_i64())
	mut var_params := this.get_limit_params(var_query_args.clone())
	mut var_total_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_db_records_count, var_params.array_get(rt.new_string('per_page'))),
	])).to_i64())
	if rt.is_true(rt.less(var_query_args.array_get(rt.new_string('page')), rt.new_int(1)))
		|| rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('page')), var_total_pages)) {
		return var_data.clone()
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'clear_sql_clause', [rt.new_string('select')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('order_by'),
		this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	mut var_download_data := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_DataStore',
			'DataStoreInterface',
		], &this), 'subquery'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_download_data)) {
		return var_data.clone()
	}
	var_download_data = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
				'Automattic_WooCommerce_Admin_API_Reports_DataStore',
				'DataStoreInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'cast_numbers' },
		]),
		var_download_data.clone(),
	])
	var_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_download_data },
		rt.ArrayItem{ key: 'total', val: var_db_records_count },
		rt.ArrayItem{ key: 'pages', val: var_total_pages },
		rt.ArrayItem{
			key: 'page_no'
			val: rt.new_int((var_query_args.array_get(rt.new_string('page'))).to_i64())
		},
	]))
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_order_by_mutated := var_order_by
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by_mutated)) {
		return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_download_log.timestamp'
	}
	if rt.is_true(rt.identical(rt.new_string('product'), var_order_by_mutated)) {
		return '_products.post_title'
	}
	return var_order_by_mutated.str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) initialize_queries() {
	this.clear_all_clauses()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{}
	mut iife_result_3 := iife_temp_3.get_db_table_name()
	mut var_table_name := iife_result_3
	this.dispatch_set_prop('subquery', create_automattic_woocommerce_admin_api_reports_sqlquery(
		(this.context).str() + '_subquery'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('from'),
		var_table_name.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string('${var_table_name.to_string()}.download_log_id')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_DataStore',
		'DataStoreInterface',
	], &this), 'subquery'), 'add_sql_clause', [rt.new_string('group_by'),
		rt.new_string('${var_table_name.to_string()}.download_log_id')])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_downloads_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_key:     rt.new_string('downloads')
		column_types:  rt.new_array()
		context:       rt.new_string('downloads')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		'add_sql_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sql_query_params(dispatch_arg_0)
			return rt.new_null()
		}
		'get_included_ip_addresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_ip_addresses(dispatch_arg_0)
		}
		'get_excluded_ip_addresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_ip_addresses(dispatch_arg_0)
		}
		'get_filtered_ip_addresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_filtered_ip_addresses(dispatch_arg_0, dispatch_arg_1))
		}
		'get_included_customers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_customers(dispatch_arg_0)
		}
		'get_excluded_customers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_customers(dispatch_arg_0)
		}
		'add_time_period_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_time_period_sql_params(dispatch_arg_0, dispatch_arg_1)
		}
		'add_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_order_by(dispatch_arg_0)
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
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_key' { return this.cache_key }
		'column_types' { return this.column_types }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
