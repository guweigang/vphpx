import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	rt.PhpObjectBase
pub mut:
		cache_group rt.PhpVal = rt.new_string('reports')
		cache_timeout rt.PhpVal = rt.new_int(3600)
		cache_key rt.PhpVal = rt.new_string('')
		table_name rt.PhpVal = rt.new_string('')
		date_column_name rt.PhpVal = rt.new_string('date_created')
		column_types rt.PhpVal = rt.new_array()
		report_columns rt.PhpVal = rt.new_array()
		order_by rt.PhpVal = rt.new_string('')
		order rt.PhpVal = rt.new_string('')
		limit_parameters rt.PhpVal = rt.new_array()
		context rt.PhpVal = rt.new_string('reports')
		subquery rt.PhpVal = rt.new_null()
		total_query rt.PhpVal = rt.new_null()
		interval_query rt.PhpVal = rt.new_null()
		force_cache_refresh bool
		debug_cache bool
		debug_cache_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) construct()  {
	Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.set_db_table_name()
	this.assign_report_columns()
	if rt.is_true(this.report_columns) {
		this.report_columns = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_report_columns'), this.report_columns, this.context, Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_db_table_name()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_envelope')) {
		this.debug_cache = true
		rt.call_function('add_filter', [rt.new_string('rest_envelope_response'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_SqlQuery', 'DataStoreInterface'], &this) }, rt.ArrayItem{ key: none, val: 'add_debug_cache_to_envelope' }]), rt.new_int(999), rt.new_int(2)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_defaults := this.get_default_query_vars()
	var_query_args_mutated = rt.call_function('wp_parse_args', [var_query_args_mutated.dup(), var_defaults.dup()])
	this.normalize_timezones(var_query_args_mutated.dup(), var_defaults.dup())
	mut var_cache_key := this.get_cache_key(var_query_args_mutated.dup())
	mut var_data := rt.new_bool(this.get_cached_data(var_cache_key.dup()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		var_data = this.get_noncached_data(var_query_args_mutated.dup())
		this.set_cached_data(var_cache_key.dup(), var_data.dup())
	}
	return var_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_default_query_vars() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'per_page', val: rt.call_function('get_option', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'before', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.default_before() }() }, rt.ArrayItem{ key: 'after', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.default_after() }() }, rt.ArrayItem{ key: 'fields', val: '*' }])
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_db_table_name() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return if !(rt.get_property(var_wpdb, '{"nodeType":"Expr_StaticPropertyFetch","line":267,"class":"static","name":"table_name"}')).is_null() { rt.get_property(var_wpdb, '{"nodeType":"Expr_StaticPropertyFetch","line":267,"class":"static","name":"table_name"}') } else { rt.concat(rt.get_property(var_wpdb, 'prefix'), // unsupported expression: Expr_StaticPropertyFetch) }
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_noncached_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	return create_automattic_woocommerce_admin_api_reports_wp_error(rt.new_string('invalid-method'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Method \'%s\' not implemented. Must be overridden in subclass.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 405 }]))
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.set_db_table_name()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) && !(!(rt.get_property(var_wpdb, '{"nodeType":"Expr_StaticPropertyFetch","line":288,"class":"static","name":"table_name"}')).is_null()))) {
		rt.set_property(var_wpdb, '{"nodeType":"Expr_StaticPropertyFetch","line":289,"class":"static","name":"table_name"}', rt.concat(rt.get_property(var_wpdb, 'prefix'), // unsupported expression: Expr_StaticPropertyFetch))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) should_use_cache() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_cache_key(var_params rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
	if var_params_mutated.array_isset(rt.new_string('force_cache_refresh')) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_params_mutated.array_get('force_cache_refresh'))) {
			this.force_cache_refresh = true
		}
		var_params_mutated.array_unset(rt.new_string('force_cache_refresh'))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), this.debug_cache)) {
		this.debug_cache_data.array_set('query_args', var_params_mutated.dup())
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_param := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_param)))
	}
	var_params_mutated = rt.call_function('array_filter', [var_params_mutated.dup(), rt.new_closure(closure_1_fn)])
	rt.call_function('ksort', [var_params_mutated.dup()])
	return rt.call_function('implode', [rt.new_string('_'), rt.create_array([rt.ArrayItem{ key: none, val: 'wc_report' }, rt.ArrayItem{ key: none, val: this.cache_key }, rt.ArrayItem{ key: none, val: md5.hexhash(rt.call_function('wp_json_encode', [var_params_mutated.dup()]).to_string()) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_cached_data(var_cache_key rt.PhpVal) bool {
	mut var_cache_key_mutated := var_cache_key
	if rt.is_true(rt.identical(rt.new_bool(true), this.debug_cache)) {
		this.debug_cache_data.array_set('should_use_cache', this.should_use_cache())
		this.debug_cache_data.array_set('force_cache_refresh', this.force_cache_refresh)
		this.debug_cache_data.array_set('cache_hit', false)
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.should_use_cache()) && rt.is_true(rt.identical(rt.new_bool(false), this.force_cache_refresh)))) {
		mut var_cached_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}; return temp.get(arg_0) }(var_cache_key_mutated.dup())
		mut var_cache_hit := // unsupported expression: Expr_BinaryOp_NotIdentical
		if rt.is_true(rt.identical(rt.new_bool(true), this.debug_cache)) {
			this.debug_cache_data.array_set('cache_hit', var_cache_hit.dup())
		}
		return (var_cached_data).to_bool()
	}
	this.force_cache_refresh = false
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) set_cached_data(var_cache_key rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_cache_key_mutated := var_cache_key
	mut var_value_mutated := var_value
	if rt.is_true(this.should_use_cache()) {
		return (fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_Cache{}; return temp.set(arg_0, arg_1) }(var_cache_key_mutated.dup(), var_value_mutated.dup())).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_debug_cache_to_envelope(var_envelope rt.PhpVal, var_response rt.PhpVal) rt.PhpVal {
	mut var_envelope_mutated := var_envelope
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_envelope_mutated.dup()
	}
	if !(!rt.is_true(this.debug_cache_data)) {
		var_envelope_mutated.array_set('debug_cache', this.debug_cache_data)
	}
	return var_envelope_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) interval_cmp(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), this.order_by)) || rt.is_true(rt.identical(rt.new_string(''), this.order)))) {
		return 0
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.identical(var_a.array_get(this.order_by), var_b.array_get(this.order_by))) {
		if rt.is_true(rt.identical(var_a.array_get('time_interval'), var_b.array_get('time_interval'))) {
			return 0
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.greater(var_a.array_get('time_interval'), var_b.array_get('time_interval'))) {
			return 1
		} else if rt.is_true(rt.less(var_a.array_get('time_interval'), var_b.array_get('time_interval'))) {
			return (// unsupported expression: Expr_UnaryMinus).to_i64()
		}
	} else if rt.is_true(rt.greater(var_a.array_get(this.order_by), var_b.array_get(this.order_by))) {
		return (if rt.is_true(rt.identical(rt.new_string(this.order.to_string().to_lower()), rt.new_string('desc'))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }).to_i64()
	} else if rt.is_true(rt.less(var_a.array_get(this.order_by), var_b.array_get(this.order_by))) {
		return (if rt.is_true(rt.identical(rt.new_string(this.order.to_string().to_lower()), rt.new_string('desc'))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) sort_intervals(var_data rt.PhpVal, var_sort_by rt.PhpVal, var_direction rt.PhpVal)  {
	mut var_data_mutated := var_data
	this.sort_array(rt.get_property(var_data_mutated, 'intervals'), var_sort_by.dup(), var_direction.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) sort_array(var_arr rt.PhpVal, var_sort_by rt.PhpVal, var_direction rt.PhpVal)  {
	this.order_by = this.normalize_order_by(var_sort_by.dup())
	this.order = var_direction.dup()
	rt.call_function('usort', [var_arr.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_DataStore', ['Automattic_WooCommerce_Admin_API_Reports_SqlQuery', 'DataStoreInterface'], &this) }, rt.ArrayItem{ key: none, val: 'interval_cmp' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) fill_in_missing_intervals(var_db_intervals rt.PhpVal, var_start_datetime rt.PhpVal, var_end_datetime rt.PhpVal, var_time_interval rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_record := rt.new_null()
	mut var_db_intervals_mutated := var_db_intervals
	mut var_start_datetime_mutated := var_start_datetime
	mut var_data_mutated := var_data
	mut var_local_tz := create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string', []rt.PhpVal{}))
	mut var_time_ids := rt.call_function('array_flip', [rt.call_function('wp_list_pluck', [rt.get_property(var_data_mutated, 'intervals'), rt.new_string('time_interval')])])
	var_db_intervals_mutated = rt.call_function('array_flip', [var_db_intervals_mutated.dup()])
	mut var_totals_arr := rt.call_function('get_object_vars', [rt.get_property(var_data_mutated, 'totals')])
	{
		mut iter_1 := var_totals_arr.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_key := item_1.key
			var_totals_arr.array_set(var_key, 0)
		}
	}
	var_totals_arr.array_unset(rt.new_string('products'))
	for rt.is_true(rt.less_equal(var_start_datetime_mutated, var_end_datetime)) {
		mut var_next_start := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.iterate(arg_0, arg_1) }(var_start_datetime_mutated.dup(), var_time_interval.dup())
		mut var_time_id := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval{}; return temp.time_interval_id(arg_0, arg_1) }(var_time_interval.dup(), var_start_datetime_mutated.dup())
		if rt.is_true(rt.greater(var_next_start, var_end_datetime)) {
			mut var_interval_end := rt.call_method(var_end_datetime, 'format', [rt.new_string('Y-m-d H:i:s')])
		} else {
			mut var_prev_end_timestamp := rt.sub(// unsupported expression: Expr_Cast_Int, rt.new_int(1))
			mut var_prev_end := create_automattic_woocommerce_admin_api_reports_datetime()
			var_prev_end.settimestamp(var_prev_end_timestamp.dup())
			var_prev_end.settimezone(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_DateTimeZone', []string{}, var_local_tz))
			var_interval_end = var_prev_end.format(rt.new_string('Y-m-d H:i:s'))
		}
		if rt.is_true(rt.new_bool(var_time_ids.dup().array_isset(var_time_id.dup()))) {
			// unsupported expression: Expr_AssignRef
			var_record.array_set('date_start', rt.call_method(var_start_datetime_mutated, 'format', [rt.new_string('Y-m-d H:i:s')]))
			var_record.array_set('date_end', var_interval_end.dup())
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_db_intervals_mutated.dup().array_isset(var_time_id.dup())))))) {
			mut var_record_arr := rt.new_array()
			var_record_arr.array_set('time_interval', var_time_id.dup())
			var_record_arr.array_set('date_start', rt.call_method(var_start_datetime_mutated, 'format', [rt.new_string('Y-m-d H:i:s')]))
			var_record_arr.array_set('date_end', var_interval_end.dup())
			rt.get_property(var_data_mutated, 'intervals').array_push(rt.call_function('array_merge', [var_record_arr.dup(), var_totals_arr.dup()]))
		}
		var_start_datetime_mutated = var_next_start.dup()
	}
	return var_data_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) normalize_timezones(var_query_args rt.PhpVal, var_defaults rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	mut var_defaults_mutated := var_defaults
	mut var_local_tz := create_automattic_woocommerce_admin_api_reports_datetimezone(rt.call_function('wc_timezone_string', []rt.PhpVal{}))
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'before' }, rt.ArrayItem{ key: none, val: 'after' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query_arg_key := item_1.val
			if rt.is_true(rt.new_bool(var_query_args_mutated.array_isset(var_query_arg_key) && rt.is_true(rt.new_bool(var_query_args_mutated.array_get(var_query_arg_key).is_string())))) {
				mut var_datetime := create_automattic_woocommerce_admin_api_reports_datetime(var_query_args_mutated.array_get(var_query_arg_key), var_local_tz.dup())
				var_datetime.settimezone(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_DateTimeZone', []string{}, var_local_tz))
				var_query_args_mutated.array_set(var_query_arg_key, var_datetime.dup())
			} else if rt.is_true(rt.new_bool(var_query_args_mutated.array_isset(var_query_arg_key) && rt.is_true(rt.call_function('is_a', [var_query_args_mutated.array_get(var_query_arg_key), rt.new_string('DateTime')])))) {
				rt.call_method(var_query_args_mutated.array_get(var_query_arg_key), 'setTimezone', [var_local_tz])
			} else {
				var_query_args_mutated.array_set(var_query_arg_key, if var_defaults_mutated.array_isset(var_query_arg_key) { var_defaults_mutated.array_get(var_query_arg_key) } else { rt.new_null() })
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) remove_extra_records(var_data rt.PhpVal, var_page_no rt.PhpVal, var_items_per_page rt.PhpVal, var_db_interval_count rt.PhpVal, var_expected_interval_count rt.PhpVal, var_order_by rt.PhpVal, var_order rt.PhpVal)  {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_string('date'), rt.new_string(var_order_by.dup().to_string().to_lower()))) {
		mut var_offset := rt.new_int(rt.new_int(0))
	} else {
		if rt.is_true(rt.identical(rt.new_string('asc'), rt.new_string(var_order.dup().to_string().to_lower()))) {
			var_offset = rt.mul(rt.sub(var_page_no, rt.new_int(1)), var_items_per_page)
		} else {
			var_offset = rt.sub(rt.mul(rt.sub(, ), var_items_per_page), var_db_interval_count)
		}
		var_offset = if rt.is_true(rt.less(var_offset, rt.new_int(0))) { rt.new_int(0) } else { var_offset }
	}
	mut var_count := rt.sub(var_expected_interval_count, rt.mul(rt.sub(, ), var_items_per_page))
	if rt.is_true(rt.less(var_count, rt.new_int(0))) {
		var_count = rt.new_int(rt.new_int(0))
	} else if rt.is_true(rt.greater(var_count, var_items_per_page)) {
		var_count = 
	}
	rt.set_property(, 'intervals', )
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) expected_intervals_on_page(var_expected_interval_count rt.PhpVal, var_items_per_page rt.PhpVal, var_page_no rt.PhpVal) i64 {
	
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) intervals_missing(var_expected_interval_count rt.PhpVal, var_db_records rt.PhpVal, var_items_per_page rt.PhpVal, var_page_no rt.PhpVal, var_order rt.PhpVal, var_order_by rt.PhpVal, var_intervals_count rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) update_intervals_sql_params(var_query_args rt.PhpVal, var_db_interval_count rt.PhpVal, var_expected_interval_count rt.PhpVal, var_table_name rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	mut var_table_name_mutated := var_table_name
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) cast_numbers(var_array rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) selected_columns(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_excluded_report_order_statuses() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.normalize_order_status(var_status rt.PhpVal) string {
	mut var_status_mutated := var_status
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) normalize_order_by(var_order_by rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) update_interval_boundary_dates(var_start_datetime rt.PhpVal, var_end_datetime rt.PhpVal, var_time_interval rt.PhpVal, var_intervals rt.PhpVal)  {
	mut var_start_datetime_mutated := var_start_datetime
	mut var_intervals_mutated := var_intervals
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) create_interval_subtotals(var_intervals rt.PhpVal)  {
	mut var_intervals_mutated := var_intervals
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_time_period_sql_params(var_query_args rt.PhpVal, var_table_name rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	mut var_table_name_mutated := var_table_name
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_limit_sql_params(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_limit_params(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_ids_table(var_ids rt.PhpVal, var_id_field rt.PhpVal, var_other_values rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_fields(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) format_join_selections(var_fields rt.PhpVal, var_default_results_fields rt.PhpVal, var_outer_selections rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_order_by_sql_params(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_intervals_sql_params(var_query_args rt.PhpVal, var_table_name rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	mut var_table_name_mutated := var_table_name
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_refund_subquery(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_products_by_cat_ids(var_categories rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_object_where_filter(var_select_table rt.PhpVal, var_select_field rt.PhpVal, var_filter_table rt.PhpVal, var_filter_field rt.PhpVal, var_compare rt.PhpVal, var_id_list rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_products_array(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_products(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_variations(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_variations(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_products_array(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_products(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_categories(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_coupons(var_query_args rt.PhpVal, field string) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut field_mutated := field
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_coupons(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_orders(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_orders(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_included_users(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_excluded_users(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_status_subquery(var_query_args rt.PhpVal, operator string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut operator_mutated := operator
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_order_status_clause(var_query_args rt.PhpVal, var_table_name rt.PhpVal, var_sql_query rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut var_table_name_mutated := var_table_name
	mut var_sql_query_mutated := var_sql_query
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_order_by_clause(var_query_args rt.PhpVal, var_sql_query rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_sql_query_mutated := var_sql_query
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) add_orderby_order_clause(var_query_args rt.PhpVal, var_sql_query rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	mut var_sql_query_mutated := var_sql_query
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_customer_subquery(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_attribute_subqueries(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_match_operator(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) get_filtered_ids(var_query_args rt.PhpVal, var_field rt.PhpVal, separator string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_args_mutated := var_query_args
	mut var_field_mutated := var_field
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) assign_report_columns()  {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_DateTime {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_datastore() &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		cache_group: rt.new_string('reports')
		cache_timeout: rt.new_int(3600)
		cache_key: rt.new_string('')
		table_name: rt.new_string('')
		date_column_name: rt.new_string('date_created')
		column_types: rt.new_array()
		report_columns: rt.new_array()
		order_by: rt.new_string('')
		order: rt.new_string('')
		limit_parameters: rt.new_array()
		context: rt.new_string('reports')
		subquery: rt.new_null()
		total_query: rt.new_null()
		interval_query: rt.new_null()
		force_cache_refresh: false
		debug_cache: false
		debug_cache_data: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_sqlquery() &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_SqlQuery{
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

fn create_automattic_woocommerce_admin_api_reports_wp_error() &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_cache() &Class_Automattic_WooCommerce_Admin_API_Reports_Cache {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datetimezone() &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_datetime() &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_data(dispatch_arg_0)
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_db_table_name' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_db_table_name()
		}
		'get_noncached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_noncached_data(dispatch_arg_0)
		}
		'set_db_table_name' {
			Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.set_db_table_name()
			return rt.new_null()
		}
		'should_use_cache' {
			return this.should_use_cache()
		}
		'get_cache_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cache_key(dispatch_arg_0)
		}
		'get_cached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_cached_data(dispatch_arg_0))
		}
		'set_cached_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_cached_data(dispatch_arg_0, dispatch_arg_1))
		}
		'add_debug_cache_to_envelope' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_debug_cache_to_envelope(dispatch_arg_0, dispatch_arg_1)
		}
		'interval_cmp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.interval_cmp(dispatch_arg_0, dispatch_arg_1))
		}
		'sort_intervals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.sort_intervals(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'sort_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.sort_array(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'fill_in_missing_intervals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.fill_in_missing_intervals(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'normalize_timezones' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.normalize_timezones(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_extra_records' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			this.remove_extra_records(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
			return rt.new_null()
		}
		'expected_intervals_on_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_int(this.expected_intervals_on_page(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'intervals_missing' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return rt.new_bool(this.intervals_missing(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6))
		}
		'update_intervals_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.update_intervals_sql_params(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'cast_numbers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.cast_numbers(dispatch_arg_0)
		}
		'selected_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.selected_columns(dispatch_arg_0)
		}
		'get_excluded_report_order_statuses' {
			return Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.get_excluded_report_order_statuses()
		}
		'normalize_order_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_API_Reports_DataStore.normalize_order_status(dispatch_arg_0))
		}
		'normalize_order_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.normalize_order_by(dispatch_arg_0))
		}
		'update_interval_boundary_dates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.update_interval_boundary_dates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'create_interval_subtotals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create_interval_subtotals(dispatch_arg_0)
			return rt.new_null()
		}
		'add_time_period_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_time_period_sql_params(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_limit_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_limit_sql_params(dispatch_arg_0)
		}
		'get_limit_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_limit_params(dispatch_arg_0)
		}
		'get_ids_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_ids_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_fields(dispatch_arg_0)
		}
		'format_join_selections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.format_join_selections(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_order_by_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_order_by_sql_params(dispatch_arg_0)
			return rt.new_null()
		}
		'add_intervals_sql_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_intervals_sql_params(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_refund_subquery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_refund_subquery(dispatch_arg_0)
		}
		'get_products_by_cat_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products_by_cat_ids(dispatch_arg_0)
		}
		'get_object_where_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return rt.new_string(this.get_object_where_filter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'get_included_products_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_products_array(dispatch_arg_0)
		}
		'get_included_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_products(dispatch_arg_0)
		}
		'get_included_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_variations(dispatch_arg_0)
		}
		'get_excluded_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_variations(dispatch_arg_0)
		}
		'get_excluded_products_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_products_array(dispatch_arg_0)
		}
		'get_excluded_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_products(dispatch_arg_0)
		}
		'get_included_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_categories(dispatch_arg_0)
		}
		'get_included_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_included_coupons(dispatch_arg_0, dispatch_arg_1)
		}
		'get_excluded_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_coupons(dispatch_arg_0)
		}
		'get_included_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_orders(dispatch_arg_0)
		}
		'get_excluded_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_orders(dispatch_arg_0)
		}
		'get_included_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_included_users(dispatch_arg_0)
		}
		'get_excluded_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_excluded_users(dispatch_arg_0)
		}
		'get_status_subquery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_status_subquery(dispatch_arg_0, dispatch_arg_1)
		}
		'add_order_status_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_order_status_clause(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'add_order_by_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_order_by_clause(dispatch_arg_0, dispatch_arg_1)
		}
		'add_orderby_order_clause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_orderby_order_clause(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_customer_subquery' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_customer_subquery(dispatch_arg_0)
		}
		'get_attribute_subqueries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute_subqueries(dispatch_arg_0)
		}
		'get_match_operator' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_match_operator(dispatch_arg_0)
		}
		'get_filtered_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_filtered_ids(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'assign_report_columns' {
			this.assign_report_columns()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_group' { return this.cache_group }
		'cache_timeout' { return this.cache_timeout }
		'cache_key' { return this.cache_key }
		'table_name' { return this.table_name }
		'date_column_name' { return this.date_column_name }
		'column_types' { return this.column_types }
		'report_columns' { return this.report_columns }
		'order_by' { return this.order_by }
		'order' { return this.order }
		'limit_parameters' { return this.limit_parameters }
		'context' { return this.context }
		'subquery' { return this.subquery }
		'total_query' { return this.total_query }
		'interval_query' { return this.interval_query }
		'force_cache_refresh' { return rt.new_bool(this.force_cache_refresh) }
		'debug_cache' { return rt.new_bool(this.debug_cache) }
		'debug_cache_data' { return this.debug_cache_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_group' { this.cache_group = val; return true }
		'cache_timeout' { this.cache_timeout = val; return true }
		'cache_key' { this.cache_key = val; return true }
		'table_name' { this.table_name = val; return true }
		'date_column_name' { this.date_column_name = val; return true }
		'column_types' { this.column_types = val; return true }
		'report_columns' { this.report_columns = val; return true }
		'order_by' { this.order_by = val; return true }
		'order' { this.order = val; return true }
		'limit_parameters' { this.limit_parameters = val; return true }
		'context' { this.context = val; return true }
		'subquery' { this.subquery = val; return true }
		'total_query' { this.total_query = val; return true }
		'interval_query' { this.interval_query = val; return true }
		'force_cache_refresh' { this.force_cache_refresh = (val).to_bool(); return true }
		'debug_cache' { this.debug_cache = (val).to_bool(); return true }
		'debug_cache_data' { this.debug_cache_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_TimeInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_datastore_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
