import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore {
	rt.PhpObjectBase
pub mut:
	column_types rt.PhpVal = rt.new_array()
	cache_key    rt.PhpVal = rt.new_string('downloads_stats')
	context      rt.PhpVal = rt.new_string('downloads_stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) assign_report_columns() {
	this.dispatch_set_prop('report_columns', rt.create_array([
		rt.ArrayItem{
			key: 'download_count'
			val: 'COUNT(DISTINCT download_log_id) as download_count'
		},
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore.get_default_query_vars()
	var_defaults.array_set('interval', 'week')
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) get_noncached_stats_data(var_query_args rt.PhpVal, var_params rt.PhpVal, var_data rt.PhpVal, var_expected_interval_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.initialize_queries()
	mut var_selections := this.selected_columns(var_query_args.clone())
	this.add_sql_query_params(var_query_args.clone())
	mut var_where_time := this.add_time_period_sql_params(var_query_args.clone(),
		var_table_name.clone())
	this.add_intervals_sql_params(var_query_args.clone(), var_table_name.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string((this.get_sql_clause(rt.new_string('select'))).str() + ' AS time_interval')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'str_replace_clause', [rt.new_string('select'),
		rt.new_string('date_created'), rt.new_string('timestamp')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'str_replace_clause', [rt.new_string('where_time'),
		rt.new_string('date_created'), rt.new_string('timestamp')])
	mut var_db_intervals := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
	])
	mut var_db_records_count := rt.new_int(var_db_intervals.clone().array_count())
	this.update_intervals_sql_params(var_query_args.clone(), var_db_records_count.clone(),
		var_expected_interval_count.clone(), var_table_name.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'str_replace_clause', [rt.new_string('where_time'),
		rt.new_string('date_created'), rt.new_string('timestamp')])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where'),
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('where'),
		])])
	if rt.is_true(var_where_time) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'add_sql_clause', [rt.new_string('where_time'),
			var_where_time.clone()])
	}
	mut var_totals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_totals)) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_downloads_stats_wp_error(rt.new_string('woocommerce_analytics_downloads_stats_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching downloads data failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('order_by'),
		this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string(', MAX(timestamp) AS datetime_anchor')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_selections)))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
			rt.new_string(', ' + var_selections.str())])
	}
	mut var_intervals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_intervals)) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_downloads_stats_wp_error(rt.new_string('woocommerce_analytics_downloads_stats_result_failed'), rt.call_function('__', [
			rt.new_string('Sorry, fetching downloads data failed.'),
			rt.new_string('woocommerce'),
		])))
	}
	var_totals = rt.array_to_object(this.cast_numbers(var_totals.array_get(rt.new_int(0))))
	rt.set_property(var_data_mutated, 'totals', var_totals.clone())
	rt.set_property(var_data_mutated, 'intervals', var_intervals.clone())
	if rt.is_true(this.intervals_missing(var_expected_interval_count.clone(),
		var_db_records_count.clone(), var_params.array_get(rt.new_string('per_page')),
		var_query_args.array_get(rt.new_string('page')),
		var_query_args.array_get(rt.new_string('order')),
		var_query_args.array_get(rt.new_string('orderby')),
		rt.new_int(var_intervals.clone().array_count())))
	{
		this.fill_in_missing_intervals(var_db_intervals.clone(),
			var_query_args.array_get(rt.new_string('adj_after')),
			var_query_args.array_get(rt.new_string('adj_before')),
			var_query_args.array_get(rt.new_string('interval')), var_data_mutated.clone())
		this.sort_intervals(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('orderby')),
			var_query_args.array_get(rt.new_string('order')))
		this.remove_extra_records(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('page')),
			var_params.array_get(rt.new_string('per_page')), var_db_records_count.clone(),
			var_expected_interval_count.clone(),
			var_query_args.array_get(rt.new_string('orderby')),
			var_query_args.array_get(rt.new_string('order')))
	} else {
		this.update_interval_boundary_dates(var_query_args.array_get(rt.new_string('after')),
			var_query_args.array_get(rt.new_string('before')),
			var_query_args.array_get(rt.new_string('interval')), rt.get_property(var_data_mutated,
			'intervals'))
	}
	return var_data_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('date'), var_order_by)) {
		return 'time_interval'
	}
	return var_order_by.str()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_downloads_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		column_types:  rt.new_array()
		cache_key:     rt.new_string('downloads_stats')
		context:       rt.new_string('downloads_stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_downloads_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_downloads_stats_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'assign_report_columns' {
			this.assign_report_columns()
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
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'column_types' { return this.column_types }
		'cache_key' { return this.cache_key }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'column_types' {
			this.column_types = val
			return true
		}
		'cache_key' {
			this.cache_key = val
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Stats_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
