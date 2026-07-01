import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	rt.PhpObjectBase
pub mut:
		all_segment_ids rt.PhpVal = rt.new_bool(false)
		segment_labels rt.PhpVal = rt.new_array()
		query_args rt.PhpVal = rt.new_string('')
		report_columns rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) construct(var_query_args rt.PhpVal, var_report_columns rt.PhpVal)  {
	this.query_args = var_query_args.dup()
	this.report_columns = var_report_columns.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) prepare_selections(var_columns_mapping rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.query_args.array_isset(rt.new_string('fields')) && rt.is_true(rt.new_bool(this.query_args.array_get('fields').is_array())))) {
		mut var_keep := rt.new_array()
		{
			mut iter_1 := this.query_args.array_get('fields').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				if var_columns_mapping.array_isset(var_field) {
					var_keep.array_set(var_field, var_columns_mapping.array_get(var_field))
				}
			}
		}
		mut var_selections := rt.call_function('implode', [rt.new_string(', '), var_keep.dup()])
	} else {
		var_selections = rt.call_function('implode', [rt.new_string(', '), var_columns_mapping.dup()])
	}
	if rt.is_true(var_selections) {
		var_selections = rt.new_string(',' + (var_selections).str())
	}
	return var_selections.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) reformat_totals_segments(var_segments_db_result rt.PhpVal, var_segment_dimension rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_segment_result := rt.new_array()
	if rt.is_true(rt.call_function('strpos', [var_segment_dimension_mutated.dup(), rt.new_string('.')])) {
		var_segment_dimension_mutated = rt.call_function('substr', [rt.call_function('strstr', [var_segment_dimension_mutated.dup(), rt.new_string('.')]), rt.new_int(1)])
	}
	mut var_segment_labels := this.get_segment_labels()
	{
		mut iter_1 := var_segments_db_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			var_segment_data.array_unset(var_segment_dimension_mutated)
			mut var_segment_datum := rt.create_array([rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'subtotals', val: var_segment_data }])
			var_segment_result.array_set(var_segment_id, var_segment_datum.dup())
		}
	}
	return var_segment_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) merge_segment_totals_results(var_segment_dimension rt.PhpVal, var_result1 rt.PhpVal, var_result2 rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_result_segments := rt.new_array()
	mut var_segment_labels := this.get_segment_labels()
	{
		mut iter_1 := var_result1.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			var_segment_data.array_unset(var_segment_dimension_mutated)
			var_result_segments.array_set(var_segment_id, rt.create_array([rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'subtotals', val: var_segment_data }]))
		}
	}
	{
		mut iter_1 := var_result2.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			var_segment_data.array_unset(var_segment_dimension_mutated)
			if !(var_result_segments.array_isset(var_segment_id)) {
				var_result_segments.array_set(var_segment_id, rt.create_array([rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'subtotals', val: rt.new_array() }]))
			}
			var_result_segments.array_get_mut(var_segment_id).array_set('subtotals', rt.call_function('array_merge', [var_result_segments.array_get(var_segment_id).array_get('subtotals'), var_segment_data.dup()]))
		}
	}
	return var_result_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) merge_segment_intervals_results(var_segment_dimension rt.PhpVal, var_result1 rt.PhpVal, var_result2 rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_result_segments := rt.new_array()
	mut var_segment_labels := this.get_segment_labels()
	{
		mut iter_1 := var_result1.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			mut var_time_interval := var_segment_data.array_get('time_interval')
			if !(var_result_segments.array_isset(var_time_interval)) {
				var_result_segments.array_set(var_time_interval, rt.new_array())
				var_result_segments.array_get_mut(var_time_interval).array_set('segments', rt.new_array())
			}
			var_segment_data.array_unset(rt.new_string('time_interval'))
			var_segment_data.array_unset(rt.new_string('datetime_anchor'))
			var_segment_data.array_unset(var_segment_dimension_mutated)
			mut var_segment_datum := rt.create_array([rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'subtotals', val: var_segment_data }])
			var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id, var_segment_datum.dup())
		}
	}
	{
		mut iter_1 := var_result2.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			mut var_time_interval := var_segment_data.array_get('time_interval')
			if !(var_result_segments.array_isset(var_time_interval)) {
				var_result_segments.array_set(var_time_interval, rt.new_array())
				var_result_segments.array_get_mut(var_time_interval).array_set('segments', rt.new_array())
			}
			var_segment_data.array_unset(rt.new_string('time_interval'))
			var_segment_data.array_unset(rt.new_string('datetime_anchor'))
			var_segment_data.array_unset(var_segment_dimension_mutated)
			if !(var_result_segments.array_get(var_time_interval).array_get('segments').array_isset(var_segment_id)) {
				var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id, rt.create_array([rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'subtotals', val: rt.new_array() }]))
			}
			var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_get_mut(var_segment_id).array_set('subtotals', rt.call_function('array_merge', [var_result_segments.array_get(var_time_interval).array_get('segments').array_get(var_segment_id).array_get('subtotals'), var_segment_data.dup()]))
		}
	}
	return var_result_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) reformat_intervals_segments(var_segments_db_result rt.PhpVal, var_segment_dimension rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_aggregated_segment_result := rt.new_array()
	if rt.is_true(rt.call_function('strpos', [var_segment_dimension_mutated.dup(), rt.new_string('.')])) {
		var_segment_dimension_mutated = rt.call_function('substr', [rt.call_function('strstr', [var_segment_dimension_mutated.dup(), rt.new_string('.')]), rt.new_int(1)])
	}
	mut var_segment_labels := this.get_segment_labels()
	{
		mut iter_1 := var_segments_db_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment_data := item_1.val
			mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
			if !(var_segment_labels.array_isset(var_segment_id)) {
				continue
			}
			mut var_time_interval := var_segment_data.array_get('time_interval')
			if !(var_aggregated_segment_result.array_isset(var_time_interval)) {
				var_aggregated_segment_result.array_set(var_time_interval, rt.new_array())
				var_aggregated_segment_result.array_get_mut(var_time_interval).array_set('segments', rt.new_array())
			}
			var_segment_data.array_unset(rt.new_string('time_interval'))
			var_segment_data.array_unset(rt.new_string('datetime_anchor'))
			var_segment_data.array_unset(var_segment_dimension_mutated)
			mut var_segment_datum := rt.create_array([rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) }, rt.ArrayItem{ key: 'segment_id', val: var_segment_id }, rt.ArrayItem{ key: 'subtotals', val: var_segment_data }])
			var_aggregated_segment_result.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id, var_segment_datum.dup())
		}
	}
	return var_aggregated_segment_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) set_all_segments()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(this.query_args.array_isset(rt.new_string('segmentby'))) || rt.is_true(rt.identical(rt.new_string(''), this.query_args.array_get('segmentby'))))) {
		this.all_segment_ids = rt.new_array()
		return rt.new_null()
	}
	mut var_segments := rt.new_array()
	mut var_segment_labels := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('product'), this.query_args.array_get('segmentby'))) {
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'return', val: 'objects' }, rt.ArrayItem{ key: 'limit', val: // unsupported expression: Expr_UnaryMinus }])
		if this.query_args.array_isset(rt.new_string('product_includes')) {
			var_args.array_set('include', this.query_args.array_get('product_includes'))
		}
		if this.query_args.array_isset(rt.new_string('category_includes')) {
			mut var_categories := this.query_args.array_get('category_includes')
			var_args.array_set('category', rt.new_array())
			{
				mut iter_1 := var_categories.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_category_id := item_1.val
					mut var_terms := rt.call_function('get_term_by', [rt.new_string('id'), var_category_id.dup(), rt.new_string('product_cat')])
					var_args.array_get_mut('category').array_push(rt.get_property(var_terms, 'slug'))
				}
			}
		}
		mut var_segment_objects := rt.call_function('wc_get_products', [var_args.dup()])
		{
			mut iter_1 := var_segment_objects.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_segment := item_1.val
				mut var_id := rt.call_method(var_segment, 'get_id', []rt.PhpVal{})
				var_segments.array_push(var_id.dup())
				var_segment_labels.array_set(var_id, rt.call_method(var_segment, 'get_name', []rt.PhpVal{}))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('variation'), this.query_args.array_get('segmentby'))) {
		var_args = rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
		if rt.is_true(rt.new_bool(rt.is_true() &&  == )) {
			
		}
		if .array_isset() {
		}
		
	} else if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	} else if rt.is_true() {
	} else {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_all_segments() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_segment_labels() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) segment_cmp(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) fill_in_missing_segments(var_segments rt.PhpVal) rt.PhpVal {
	mut var_segments_mutated := var_segments
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) fill_in_missing_interval_segments(var_data rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_totals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_intervals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_totals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_intervals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_segments(var_type rt.PhpVal, var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_segments(var_type rt.PhpVal, var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_query_params rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_segments(var_type rt.PhpVal, var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_query_params rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) assign_segments_to_intervals(var_intervals rt.PhpVal, var_intervals_segments rt.PhpVal)  {
	mut var_intervals_mutated := var_intervals
	mut var_intervals_segments_mutated := var_intervals_segments
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_totals_segments(var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) add_intervals_segments(var_data rt.PhpVal, var_intervals_query rt.PhpVal, var_table_name rt.PhpVal)  {
}

fn create_automattic_woocommerce_admin_api_reports_segmenter(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
		all_segment_ids: rt.new_bool(false)
		segment_labels: rt.new_array()
		query_args: rt.new_string('')
		report_columns: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_selections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_selections(dispatch_arg_0)
		}
		'reformat_totals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.reformat_totals_segments(dispatch_arg_0, dispatch_arg_1)
		}
		'merge_segment_totals_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.merge_segment_totals_results(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'merge_segment_intervals_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.merge_segment_intervals_results(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'reformat_intervals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.reformat_intervals_segments(dispatch_arg_0, dispatch_arg_1)
		}
		'set_all_segments' {
			this.set_all_segments()
			return rt.new_null()
		}
		'get_all_segments' {
			return this.get_all_segments()
		}
		'get_segment_labels' {
			return this.get_segment_labels()
		}
		'segment_cmp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.segment_cmp(dispatch_arg_0, dispatch_arg_1))
		}
		'fill_in_missing_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fill_in_missing_segments(dispatch_arg_0)
		}
		'fill_in_missing_interval_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.fill_in_missing_interval_segments(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_related_totals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
			return this.get_product_related_totals_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
		}
		'get_product_related_intervals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
			return this.get_product_related_intervals_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
		}
		'get_order_related_totals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.get_order_related_totals_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'get_order_related_intervals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.get_order_related_intervals_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'get_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_product_related_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
			dispatch_arg_8 := if args.len > 8 { args[8] } else { rt.new_null() }
			return this.get_product_related_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7, dispatch_arg_8)
		}
		'get_order_related_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.get_order_related_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'assign_segments_to_intervals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.assign_segments_to_intervals(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_totals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_totals_segments(dispatch_arg_0, dispatch_arg_1)
		}
		'add_intervals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_intervals_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'all_segment_ids' { return this.all_segment_ids }
		'segment_labels' { return this.segment_labels }
		'query_args' { return this.query_args }
		'report_columns' { return this.report_columns }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'all_segment_ids' { this.all_segment_ids = val; return true }
		'segment_labels' { this.segment_labels = val; return true }
		'query_args' { this.query_args = val; return true }
		'report_columns' { this.report_columns = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_segmenter_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
