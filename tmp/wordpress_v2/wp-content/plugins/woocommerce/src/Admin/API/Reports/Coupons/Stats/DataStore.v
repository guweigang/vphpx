import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore {
	rt.PhpObjectBase
pub mut:
	column_types   rt.PhpVal = rt.new_array()
	report_columns rt.PhpVal = rt.new_null()
	context        rt.PhpVal = rt.new_string('coupons_stats')
	cache_key      rt.PhpVal = rt.new_string('coupons_stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) assign_report_columns() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore{}
	mut iife_result_0 := iife_temp_0.get_db_table_name()
	mut var_table_name := iife_result_0
	this.report_columns = rt.create_array([
		rt.ArrayItem{ key: 'amount', val: 'SUM(discount_amount) as amount' },
		rt.ArrayItem{ key: 'coupons_count', val: 'COUNT(DISTINCT coupon_id) as coupons_count' },
		rt.ArrayItem{
			key: 'orders_count'
			val: 'COUNT(DISTINCT ${var_table_name.to_string()}.order_id) as orders_count'
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) update_sql_query_params(var_query_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_clauses := rt.create_array([rt.ArrayItem{ key: 'where', val: '' },
		rt.ArrayItem{ key: 'join', val: '' }])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore{}
	mut iife_result_1 := iife_temp_1.get_db_table_name()
	mut var_order_coupon_lookup_table := iife_result_1
	mut var_included_coupons := this.get_included_coupons(var_query_args.clone(),
		rt.new_string('coupons'))
	if rt.is_true(var_included_coupons) {
		var_clauses.array_get(rt.new_string('where')) = rt.concat(var_clauses.array_get(rt.new_string('where')),
			rt.new_string(' AND ${var_order_coupon_lookup_table.to_string()}.coupon_id IN (${var_included_coupons.to_string()})'))
	}
	mut var_order_status_filter := this.get_status_subquery(var_query_args.clone())
	if rt.is_true(var_order_status_filter) {
		var_clauses.array_get(rt.new_string('join')) = rt.concat(var_clauses.array_get(rt.new_string('join')), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' JOIN '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_stats ON ')), var_order_coupon_lookup_table),
			rt.new_string('.order_id = ')), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('wc_order_stats.order_id')))
		var_clauses.array_get(rt.new_string('where')) = rt.concat(var_clauses.array_get(rt.new_string('where')),
			rt.new_string(' AND ( ${var_order_status_filter.to_string()} )'))
	}
	this.add_time_period_sql_params(var_query_args.clone(), var_order_coupon_lookup_table.clone())
	this.add_intervals_sql_params(var_query_args.clone(), var_order_coupon_lookup_table.clone())
	var_clauses.array_set('where_time', this.get_sql_clause(rt.new_string('where_time')))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('limit'),
		this.get_sql_clause(rt.new_string('limit'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('order_by'),
		this.get_sql_clause(rt.new_string('order_by'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		this.get_sql_clause(rt.new_string('select'))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string('AS time_interval')])
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'join' },
		rt.ArrayItem{ key: none, val: 'where_time' }, rt.ArrayItem{ key: none, val: 'where' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_clause := item_1.val
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [var_clause.clone(),
			var_clauses.array_get(var_clause)])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'add_sql_clause', [var_clause.clone(),
			var_clauses.array_get(var_clause)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) get_default_query_vars() rt.PhpVal {
	mut var_defaults :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore.get_default_query_vars()
	var_defaults.array_set('coupons', rt.new_array())
	var_defaults.array_set('interval', 'week')
	return var_defaults.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) get_noncached_stats_data(var_query_args rt.PhpVal, var_params rt.PhpVal, var_data rt.PhpVal, var_expected_interval_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore{}
	mut iife_result_2 := iife_temp_2.get_db_table_name()
	mut var_table_name := iife_result_2
	this.initialize_queries()
	mut var_selections := this.selected_columns(var_query_args.clone())
	mut var_totals_query := rt.new_array()
	mut var_intervals_query := rt.new_array()
	mut var_limit_params := this.get_limit_sql_params(var_query_args.clone())
	this.update_sql_query_params(var_query_args.clone(), var_totals_query.clone(),
		var_intervals_query.clone())
	mut var_db_intervals := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
	])
	mut var_db_interval_count := rt.new_int(var_db_intervals.clone().array_count())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'total_query'), 'add_sql_clause', [rt.new_string('select'),
		var_selections.clone()])
	mut var_totals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_totals)) {
		return var_data_mutated.clone()
	}
	var_totals_query = rt.create_array([
		rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_sql_clause', [
			rt.new_string('join'),
		]) },
		rt.ArrayItem{ key: 'where_time_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_sql_clause', [
			rt.new_string('where_time'),
		]) },
		rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'total_query'), 'get_sql_clause', [
			rt.new_string('where'),
		]) },
	])
	var_intervals_query = rt.create_array([
		rt.ArrayItem{ key: 'select_clause', val: this.get_sql_clause(rt.new_string('select')) },
		rt.ArrayItem{ key: 'from_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('join'),
		]) },
		rt.ArrayItem{ key: 'where_time_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('where_time'),
		]) },
		rt.ArrayItem{ key: 'where_clause', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_sql_clause', [
			rt.new_string('where'),
		]) },
		rt.ArrayItem{ key: 'limit', val: this.get_sql_clause(rt.new_string('limit')) },
	])
	mut var_segmenter := create_automattic_woocommerce_admin_api_reports_coupons_stats_segmenter(var_query_args.clone(),
		this.report_columns)
	var_totals.array_get_mut(0).array_set('segments', var_segmenter.get_totals_segments(var_totals_query.clone(),
		var_table_name.clone()))
	var_totals = rt.array_to_object(this.cast_numbers(var_totals.array_get(rt.new_int(0))))
	this.update_intervals_sql_params(var_query_args.clone(), var_db_interval_count.clone(),
		var_expected_interval_count.clone(), var_table_name.clone())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
		'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
		'DataStoreInterface',
	], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
		rt.new_string(', MAX(${var_table_name.to_string()}.date_created) AS datetime_anchor')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_selections)))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'add_sql_clause', [rt.new_string('select'),
			rt.new_string(', ' + var_selections.str())])
	}
	mut var_intervals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore', [
			'Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore',
			'DataStoreInterface',
		], &this), 'interval_query'), 'get_query_statement', []rt.PhpVal{}),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_intervals)) {
		return var_data_mutated.clone()
	}
	rt.set_property(var_data_mutated, 'totals', var_totals.clone())
	rt.set_property(var_data_mutated, 'intervals', var_intervals.clone())
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}
	mut iife_result_3 := iife_temp_3.intervals_missing(var_expected_interval_count.clone(),
		var_db_interval_count.clone(), var_limit_params.array_get(rt.new_string('per_page')),
		var_query_args.array_get(rt.new_string('page')),
		var_query_args.array_get(rt.new_string('order')),
		var_query_args.array_get(rt.new_string('orderby')),
		rt.new_int(var_intervals.clone().array_count()))
	if rt.is_true(iife_result_3) {
		this.fill_in_missing_intervals(var_db_intervals.clone(),
			var_query_args.array_get(rt.new_string('adj_after')),
			var_query_args.array_get(rt.new_string('adj_before')),
			var_query_args.array_get(rt.new_string('interval')), var_data_mutated.clone())
		this.sort_intervals(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('orderby')),
			var_query_args.array_get(rt.new_string('order')))
		this.remove_extra_records(var_data_mutated.clone(),
			var_query_args.array_get(rt.new_string('page')),
			var_limit_params.array_get(rt.new_string('per_page')), var_db_interval_count.clone(),
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

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore{
		PhpObjectBase:  rt.PhpObjectBase{}
		column_types:   rt.new_array()
		report_columns: rt.new_null()
		context:        rt.new_string('coupons_stats')
		cache_key:      rt.new_string('coupons_stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_stats_segmenter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter{
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'column_types' { return this.column_types }
		'report_columns' { return this.report_columns }
		'context' { return this.context }
		'cache_key' { return this.cache_key }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'column_types' {
			this.column_types = val
			return true
		}
		'report_columns' {
			this.report_columns = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		'cache_key' {
			this.cache_key = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
