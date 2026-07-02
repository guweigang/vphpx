import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	rt.PhpObjectBase
pub mut:
	all_segment_ids rt.PhpVal = rt.new_bool(false)
	segment_labels  rt.PhpVal = rt.new_array()
	query_args      rt.PhpVal = rt.new_string('')
	report_columns  rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) construct(var_query_args rt.PhpVal, var_report_columns rt.PhpVal) {
	this.query_args = var_query_args.clone()
	this.report_columns = var_report_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) prepare_selections(var_columns_mapping rt.PhpVal) rt.PhpVal {
	if this.query_args.array_isset(rt.new_string('fields'))
		&& this.query_args.array_get(rt.new_string('fields')).is_array() {
		mut var_keep := rt.new_array()
		mut iter_1 := this.query_args.array_get(rt.new_string('fields')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			if var_columns_mapping.array_isset(var_field) {
				var_keep.array_set(var_field, var_columns_mapping.array_get(var_field))
			}
		}
		mut var_selections := rt.call_function('implode', [rt.new_string(', '),
			var_keep.clone()])
	} else {
		var_selections = rt.call_function('implode', [rt.new_string(', '),
			var_columns_mapping.clone()])
	}
	if rt.is_true(var_selections) {
		var_selections = rt.new_string(',' + var_selections.str())
	}
	return var_selections.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) reformat_totals_segments(var_segments_db_result rt.PhpVal, var_segment_dimension rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_segment_result := rt.new_array()
	if rt.is_true(rt.call_function('strpos', [var_segment_dimension_mutated.clone(),
		rt.new_string('.')]))
	{
		var_segment_dimension_mutated = rt.call_function('substr', [
			rt.call_function('strstr', [var_segment_dimension_mutated.clone(),
				rt.new_string('.')]),
			rt.new_int(1),
		])
	}
	mut var_segment_labels := this.get_segment_labels()
	mut iter_2 := var_segments_db_result.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_segment_data := item_2.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		var_segment_data.array_unset(var_segment_dimension_mutated)
		mut var_segment_datum := rt.create_array([
			rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
			rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) },
			rt.ArrayItem{ key: 'subtotals', val: var_segment_data },
		])
		var_segment_result.array_set(var_segment_id, var_segment_datum.clone())
	}
	return var_segment_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) merge_segment_totals_results(var_segment_dimension rt.PhpVal, var_result1 rt.PhpVal, var_result2 rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_result_segments := rt.new_array()
	mut var_segment_labels := this.get_segment_labels()
	mut iter_3 := var_result1.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_segment_data := item_3.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		var_segment_data.array_unset(var_segment_dimension_mutated)
		var_result_segments.array_set(var_segment_id, rt.create_array([
			rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) },
			rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
			rt.ArrayItem{ key: 'subtotals', val: var_segment_data },
		]))
	}
	mut iter_4 := var_result2.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_segment_data := item_4.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		var_segment_data.array_unset(var_segment_dimension_mutated)
		if !(var_result_segments.array_isset(var_segment_id)) {
			var_result_segments.array_set(var_segment_id, rt.create_array([
				rt.ArrayItem{
					key: 'segment_label'
					val: var_segment_labels.array_get(var_segment_id)
				},
				rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
				rt.ArrayItem{ key: 'subtotals', val: rt.new_array() },
			]))
		}
		var_result_segments.array_get_mut(var_segment_id).array_set('subtotals', rt.call_function('array_merge', [
			var_result_segments.array_get(var_segment_id).array_get(rt.new_string('subtotals')),
			var_segment_data.clone(),
		]))
	}
	return var_result_segments.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) merge_segment_intervals_results(var_segment_dimension rt.PhpVal, var_result1 rt.PhpVal, var_result2 rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_result_segments := rt.new_array()
	mut var_segment_labels := this.get_segment_labels()
	mut iter_5 := var_result1.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_segment_data := item_5.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		mut var_time_interval := var_segment_data.array_get(rt.new_string('time_interval'))
		if !(var_result_segments.array_isset(var_time_interval)) {
			var_result_segments.array_set(var_time_interval, rt.new_array())
			var_result_segments.array_get_mut(var_time_interval).array_set('segments',
				rt.new_array())
		}
		var_segment_data.array_unset(rt.new_string('time_interval'))
		var_segment_data.array_unset(rt.new_string('datetime_anchor'))
		var_segment_data.array_unset(var_segment_dimension_mutated)
		mut var_segment_datum := rt.create_array([
			rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) },
			rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
			rt.ArrayItem{ key: 'subtotals', val: var_segment_data },
		])
		var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id,
			var_segment_datum.clone())
	}
	mut iter_6 := var_result2.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_segment_data := item_6.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		mut var_time_interval := var_segment_data.array_get(rt.new_string('time_interval'))
		if !(var_result_segments.array_isset(var_time_interval)) {
			var_result_segments.array_set(var_time_interval, rt.new_array())
			var_result_segments.array_get_mut(var_time_interval).array_set('segments',
				rt.new_array())
		}
		var_segment_data.array_unset(rt.new_string('time_interval'))
		var_segment_data.array_unset(rt.new_string('datetime_anchor'))
		var_segment_data.array_unset(var_segment_dimension_mutated)
		if !(var_result_segments.array_get(var_time_interval).array_get(rt.new_string('segments')).array_isset(var_segment_id)) {
			var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id, rt.create_array([
				rt.ArrayItem{
					key: 'segment_label'
					val: var_segment_labels.array_get(var_segment_id)
				},
				rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
				rt.ArrayItem{ key: 'subtotals', val: rt.new_array() },
			]))
		}
		var_result_segments.array_get_mut(var_time_interval).array_get_mut('segments').array_get_mut(var_segment_id).array_set('subtotals', rt.call_function('array_merge', [
			var_result_segments.array_get(var_time_interval).array_get(rt.new_string('segments')).array_get(var_segment_id).array_get(rt.new_string('subtotals')),
			var_segment_data.clone(),
		]))
	}
	return var_result_segments.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) reformat_intervals_segments(var_segments_db_result rt.PhpVal, var_segment_dimension rt.PhpVal) rt.PhpVal {
	mut var_segment_dimension_mutated := var_segment_dimension
	mut var_aggregated_segment_result := rt.new_array()
	if rt.is_true(rt.call_function('strpos', [var_segment_dimension_mutated.clone(),
		rt.new_string('.')]))
	{
		var_segment_dimension_mutated = rt.call_function('substr', [
			rt.call_function('strstr', [var_segment_dimension_mutated.clone(),
				rt.new_string('.')]),
			rt.new_int(1),
		])
	}
	mut var_segment_labels := this.get_segment_labels()
	mut iter_7 := var_segments_db_result.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_segment_data := item_7.val
		mut var_segment_id := var_segment_data.array_get(var_segment_dimension_mutated)
		if !(var_segment_labels.array_isset(var_segment_id)) {
			continue
		}
		mut var_time_interval := var_segment_data.array_get(rt.new_string('time_interval'))
		if !(var_aggregated_segment_result.array_isset(var_time_interval)) {
			var_aggregated_segment_result.array_set(var_time_interval, rt.new_array())
			var_aggregated_segment_result.array_get_mut(var_time_interval).array_set('segments',
				rt.new_array())
		}
		var_segment_data.array_unset(rt.new_string('time_interval'))
		var_segment_data.array_unset(rt.new_string('datetime_anchor'))
		var_segment_data.array_unset(var_segment_dimension_mutated)
		mut var_segment_datum := rt.create_array([
			rt.ArrayItem{ key: 'segment_label', val: var_segment_labels.array_get(var_segment_id) },
			rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
			rt.ArrayItem{ key: 'subtotals', val: var_segment_data },
		])
		var_aggregated_segment_result.array_get_mut(var_time_interval).array_get_mut('segments').array_set(var_segment_id,
			var_segment_datum.clone())
	}
	return var_aggregated_segment_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) set_all_segments() {
	mut var_wpdb := rt.new_null()
	if !(this.query_args.array_isset(rt.new_string('segmentby')))
		|| rt.is_true(rt.identical(rt.new_string(''), this.query_args.array_get(rt.new_string('segmentby')))) {
		this.all_segment_ids = rt.new_array()
		return
	}
	mut var_segments := rt.new_array()
	mut var_segment_labels := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('product'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'return', val: 'objects' },
			rt.ArrayItem{ key: 'limit', val: -1 }])
		if this.query_args.array_isset(rt.new_string('product_includes')) {
			var_args.array_set('include',
				this.query_args.array_get(rt.new_string('product_includes')))
		}
		if this.query_args.array_isset(rt.new_string('category_includes')) {
			mut var_categories := this.query_args.array_get(rt.new_string('category_includes'))
			var_args.array_set('category', rt.new_array())
			mut iter_8 := var_categories.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_category_id := item_8.val
				mut var_terms := rt.call_function('get_term_by', [
					rt.new_string('id'), var_category_id.clone(),
					rt.new_string('product_cat')])
				var_args.array_get_mut('category').array_push(rt.get_property(var_terms, 'slug'))
			}
		}
		mut var_segment_objects := rt.call_function('wc_get_products', [
			var_args.clone()])
		mut iter_9 := var_segment_objects.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_segment := item_9.val
			mut var_id := rt.call_method(var_segment, 'get_id', []rt.PhpVal{})
			var_segments.array_push(var_id.clone())
			var_segment_labels.array_set(var_id, rt.call_method(var_segment, 'get_name',
				[]rt.PhpVal{}))
		}
	} else if rt.is_true(rt.identical(rt.new_string('variation'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		var_args = rt.create_array([rt.ArrayItem{ key: 'return', val: 'objects' },
			rt.ArrayItem{ key: 'limit', val: -1 }, rt.ArrayItem{
				key: 'type'
				val: Class_Automattic_WooCommerce_Enums_ProductType.variation()
			}])
		if this.query_args.array_isset(rt.new_string('product_includes'))
			&& this.query_args.array_get(rt.new_string('product_includes')).is_array()
			&& this.query_args.array_get(rt.new_string('product_includes')).array_count() == 1 {
			var_args.array_set('parent',
				this.query_args.array_get(rt.new_string('product_includes')).array_get(rt.new_int(0)))
		}
		if this.query_args.array_isset(rt.new_string('variation_includes')) {
			var_args.array_set('include',
				this.query_args.array_get(rt.new_string('variation_includes')))
		}
		var_segment_objects = rt.call_function('wc_get_products', [
			var_args.clone()])
		mut iter_10 := var_segment_objects.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_segment := item_10.val
			mut var_id := rt.call_method(var_segment, 'get_id', []rt.PhpVal{})
			var_segments.array_push(var_id.clone())
			mut var_product_name := rt.call_method(var_segment, 'get_name', []rt.PhpVal{})
			mut var_separator := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_variation_title_attributes_separator'),
				rt.new_string(' - '),
				var_segment.clone(),
			])
			mut var_attributes := rt.call_function('wc_get_formatted_variation', [
				var_segment.clone(),
				rt.new_bool(true),
				rt.new_bool(false),
			])
			var_segment_labels.array_set(var_id, var_product_name.str() + var_separator.str() +
				var_attributes.str())
		}
		if var_args.array_isset(rt.new_string('parent'))
			&& !rt.is_true(var_args.array_get(rt.new_string('include'))) {
			mut var_parent_object := rt.call_function('wc_get_product', [
				var_args.array_get(rt.new_string('parent')),
			])
			var_segments.array_push(0)
			var_segment_labels.array_set(0, rt.call_method(var_parent_object, 'get_name',
				[]rt.PhpVal{}))
		}
	} else if rt.is_true(rt.identical(rt.new_string('category'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		var_args = rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' }])
		if this.query_args.array_isset(rt.new_string('category_includes')) {
			var_args.array_set('include',
				this.query_args.array_get(rt.new_string('category_includes')))
		}
		var_categories = rt.call_function('get_categories', [
			var_args.clone()])
		var_segments = rt.call_function('wp_list_pluck', [var_categories.clone(),
			rt.new_string('cat_ID')])
		var_segment_labels = rt.call_function('wp_list_pluck', [
			var_categories.clone(), rt.new_string('name'), rt.new_string('cat_ID')])
	} else if rt.is_true(rt.identical(rt.new_string('coupon'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		var_args = rt.new_array()
		if this.query_args.array_isset(rt.new_string('coupons')) {
			var_args.array_set('include', this.query_args.array_get(rt.new_string('coupons')))
		}
		mut var_coupons_store := create_automattic_woocommerce_admin_api_reports_coupons_datastore()
		mut var_coupons := var_coupons_store.get_coupons(var_args.clone())
		var_segments = rt.call_function('wp_list_pluck', [var_coupons.clone(),
			rt.new_string('ID')])
		var_segment_labels = rt.call_function('wp_list_pluck', [
			var_coupons.clone(), rt.new_string('post_title'),
			rt.new_string('ID')])
		var_segment_labels = rt.call_function('array_map', [
			rt.new_string('wc_format_coupon_code'),
			var_segment_labels.clone(),
		])
	} else if rt.is_true(rt.identical(rt.new_string('customer_type'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		var_segments = rt.create_array([rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 1 }])
	} else if rt.is_true(rt.identical(rt.new_string('tax_rate_id'),
		this.query_args.array_get(rt.new_string('segmentby'))))
	{
		var_args = rt.new_array()
		if this.query_args.array_isset(rt.new_string('taxes')) {
			var_args.array_set('include', this.query_args.array_get(rt.new_string('taxes')))
		}
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{}
		mut iife_result_0 := iife_temp_0.get_taxes(var_args.clone())
		mut var_taxes := iife_result_0
		mut iter_11 := var_taxes.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_tax := item_11.val
			mut var_id := var_tax.array_get(rt.new_string('tax_rate_id'))
			var_segments.array_push(var_id.clone())
			mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax{}
			mut iife_result_1 := iife_temp_1.get_rate_code(rt.new_object('stdClass', []string{},
				rt.array_to_object(var_tax)))
			var_segment_labels.array_set(var_id, iife_result_1)
		}
	} else {
		var_segments = rt.new_array()
	}
	this.all_segment_ids = var_segments.clone()
	this.segment_labels = var_segment_labels.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_all_segments() rt.PhpVal {
	if !(this.all_segment_ids.is_array()) {
		this.set_all_segments()
	}
	return this.all_segment_ids
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_segment_labels() rt.PhpVal {
	if !(this.all_segment_ids.is_array()) {
		this.set_all_segments()
	}
	return this.segment_labels
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) segment_cmp(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(var_a.array_get(rt.new_string('segment_id')),
		var_b.array_get(rt.new_string('segment_id'))))
	{
		return 0
	} else if rt.is_true(rt.greater(var_a.array_get(rt.new_string('segment_id')),
		var_b.array_get(rt.new_string('segment_id'))))
	{
		return 1
	} else if rt.is_true(rt.less(var_a.array_get(rt.new_string('segment_id')),
		var_b.array_get(rt.new_string('segment_id'))))
	{
		return -1
	}
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) fill_in_missing_segments(var_segments rt.PhpVal) rt.PhpVal {
	mut var_segments_mutated := var_segments
	mut var_segment_subtotals := rt.new_array()
	if this.query_args.array_isset(rt.new_string('fields'))
		&& this.query_args.array_get(rt.new_string('fields')).is_array() {
		mut iter_12 := this.query_args.array_get(rt.new_string('fields')).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_field := item_12.val
			if this.report_columns.array_isset(var_field) {
				var_segment_subtotals.array_set(var_field, 0)
			}
		}
	} else {
		mut iter_13 := this.report_columns.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_sql_clause := item_13.val
			mut var_field := item_13.key
			var_segment_subtotals.array_set(var_field, 0)
		}
	}
	if !(var_segments_mutated.clone().is_array()) {
		var_segments_mutated = rt.new_array()
	}
	mut var_all_segment_ids := this.get_all_segments()
	mut var_segment_labels := this.get_segment_labels()
	mut iter_14 := var_all_segment_ids.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_segment_id := item_14.val
		if !(var_segments_mutated.array_isset(var_segment_id)) {
			var_segments_mutated.array_set(var_segment_id, rt.create_array([
				rt.ArrayItem{ key: 'segment_id', val: var_segment_id },
				rt.ArrayItem{
					key: 'segment_label'
					val: var_segment_labels.array_get(var_segment_id)
				},
				rt.ArrayItem{ key: 'subtotals', val: var_segment_subtotals },
			]))
		}
	}
	mut var_segments_no_keys := rt.call_function('array_values', [
		var_segments_mutated.clone()])
	rt.call_function('usort', [var_segments_no_keys.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Segmenter',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'segment_cmp' },
		])])
	return var_segments_no_keys.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) fill_in_missing_interval_segments(var_data rt.PhpVal) {
	mut iter_15 := rt.get_property(var_data, 'intervals').iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_interval_data := item_15.val
		mut var_order_id := item_15.key
		rt.get_property(var_data, 'intervals').array_get_mut(var_order_id).array_set('segments', this.fill_in_missing_segments(rt.get_property(var_data,
			'intervals').array_get(var_order_id).array_get(rt.new_string('segments'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_totals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_intervals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_totals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_intervals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_segments(var_type rt.PhpVal, var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_product_related_segments(var_type rt.PhpVal, var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_query_params rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('totals'), var_type)) {
		return this.get_product_related_totals_segments(var_segmenting_selections.clone(),
			var_segmenting_from.clone(), var_segmenting_where.clone(),
			var_segmenting_groupby.clone(), var_segmenting_dimension_name.clone(),
			var_table_name.clone(), var_query_params.clone(), var_unique_orders_table.clone())
	} else if rt.is_true(rt.identical(rt.new_string('intervals'), var_type)) {
		return this.get_product_related_intervals_segments(var_segmenting_selections.clone(),
			var_segmenting_from.clone(), var_segmenting_where.clone(),
			var_segmenting_groupby.clone(), var_segmenting_dimension_name.clone(),
			var_table_name.clone(), var_query_params.clone(), var_unique_orders_table.clone())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_order_related_segments(var_type rt.PhpVal, var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_query_params rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('totals'), var_type)) {
		return this.get_order_related_totals_segments(var_segmenting_select.clone(),
			var_segmenting_from.clone(), var_segmenting_where.clone(),
			var_segmenting_groupby.clone(), var_table_name.clone(), var_query_params.clone())
	} else if rt.is_true(rt.identical(rt.new_string('intervals'), var_type)) {
		return this.get_order_related_intervals_segments(var_segmenting_select.clone(),
			var_segmenting_from.clone(), var_segmenting_where.clone(),
			var_segmenting_groupby.clone(), var_table_name.clone(), var_query_params.clone())
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) assign_segments_to_intervals(var_intervals rt.PhpVal, var_intervals_segments rt.PhpVal) {
	mut var_intervals_mutated := var_intervals
	mut var_intervals_segments_mutated := var_intervals_segments
	mut var_old_keys := rt.func_array_keys(var_intervals_mutated.clone())
	mut iter_16 := var_intervals_mutated.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_interval := item_16.val
		var_intervals_mutated.array_set(var_interval.array_get(rt.new_string('time_interval')),
			var_interval.clone())
		var_intervals_mutated.array_get_mut(var_interval.array_get(rt.new_string('time_interval'))).array_set('segments',
			rt.new_array())
	}
	mut iter_17 := var_old_keys.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_key := item_17.val
		var_intervals_mutated.array_unset(var_key)
	}
	mut iter_18 := var_intervals_segments_mutated.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_segment := item_18.val
		mut var_time_interval := item_18.key
		if var_intervals_mutated.array_isset(var_time_interval) {
			var_intervals_mutated.array_get_mut(var_time_interval).array_set('segments',
				var_segment.array_get(rt.new_string('segments')))
		}
	}
	var_intervals_mutated = rt.call_function('array_values', [
		var_intervals_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) get_totals_segments(var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
	mut var_segments := this.get_segments(rt.new_string('totals'), var_query_params.clone(),
		var_table_name.clone())
	var_segments = this.fill_in_missing_segments(var_segments.clone())
	return var_segments.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) add_intervals_segments(var_data rt.PhpVal, var_intervals_query rt.PhpVal, var_table_name rt.PhpVal) {
	mut var_intervals_segments := this.get_segments(rt.new_string('intervals'),
		var_intervals_query.clone(), var_table_name.clone())
	this.assign_segments_to_intervals(rt.get_property(var_data, 'intervals'),
		var_intervals_segments.clone())
	this.fill_in_missing_interval_segments(var_data.clone())
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_segmenter(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter{
		PhpObjectBase:   rt.PhpObjectBase{}
		all_segment_ids: rt.new_bool(false)
		segment_labels:  rt.new_array()
		query_args:      rt.new_string('')
		report_columns:  rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_coupons_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_taxes_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_wc_tax(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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
			return this.merge_segment_intervals_results(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return this.get_product_related_totals_segments(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6,
				dispatch_arg_7)
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
			return this.get_product_related_intervals_segments(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6,
				dispatch_arg_7)
		}
		'get_order_related_totals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.get_order_related_totals_segments(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'get_order_related_intervals_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return this.get_order_related_intervals_segments(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
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
			return this.get_product_related_segments(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6,
				dispatch_arg_7, dispatch_arg_8)
		}
		'get_order_related_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.get_order_related_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
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
		else {
			return none
		}
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
		'all_segment_ids' {
			this.all_segment_ids = val
			return true
		}
		'segment_labels' {
			this.segment_labels = val
			return true
		}
		'query_args' {
			this.query_args = val
			return true
		}
		'report_columns' {
			this.report_columns = val
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Taxes_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
