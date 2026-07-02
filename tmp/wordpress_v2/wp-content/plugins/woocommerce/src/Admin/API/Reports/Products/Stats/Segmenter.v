import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) get_segment_selections_product_level(var_products_table rt.PhpVal) rt.PhpVal {
	mut var_columns_mapping := rt.create_array([
		rt.ArrayItem{
			key: 'items_sold'
			val: 'SUM(${var_products_table.to_string()}.product_qty) as items_sold'
		},
		rt.ArrayItem{
			key: 'net_revenue'
			val: 'SUM(${var_products_table.to_string()}.product_net_revenue ) AS net_revenue'
		},
		rt.ArrayItem{
			key: 'orders_count'
			val: 'COUNT( DISTINCT ${var_products_table.to_string()}.order_id ) AS orders_count'
		},
		rt.ArrayItem{
			key: 'products_count'
			val: 'COUNT( DISTINCT ${var_products_table.to_string()}.product_id ) AS products_count'
		},
		rt.ArrayItem{
			key: 'variations_count'
			val: 'COUNT( DISTINCT ${var_products_table.to_string()}.variation_id ) AS variations_count'
		},
	])
	return var_columns_mapping.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) get_product_related_totals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_segmenting_selections_mutated := var_segmenting_selections
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	mut var_segmenting_dimension_name_mutated := var_segmenting_dimension_name
	mut var_unique_orders_table_mutated := var_unique_orders_table
	mut var_product_segmenting_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_product_lookup')
	mut var_segments_products := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\t'),
			var_segmenting_groupby_mutated), rt.new_string(' AS ')),
			var_segmenting_dimension_name_mutated), rt.new_string('\n\t\t\t\t\t\t')),
			var_segmenting_selections_mutated.array_get(rt.new_string('product_level'))),
			rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name),
			rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated),
			rt.new_string('\n\t\t\t\t\t\t')),
			var_totals_query.array_get(rt.new_string('from_clause'))),
			rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')),
			var_totals_query.array_get(rt.new_string('where_time_clause'))),
			rt.new_string('\n\t\t\t\t\t\t')),
			var_totals_query.array_get(rt.new_string('where_clause'))),
			rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated),
			rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated),
		rt.get_constant('ARRAY_A'),
	])
	mut var_totals_segments := this.merge_segment_totals_results(var_segmenting_dimension_name_mutated.clone(),
		var_segments_products.clone(), rt.new_array())
	return var_totals_segments.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) get_product_related_intervals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_limit_parts := rt.new_null()
	mut var_segmenting_selections_mutated := var_segmenting_selections
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	mut var_segmenting_dimension_name_mutated := var_segmenting_dimension_name
	mut var_unique_orders_table_mutated := var_unique_orders_table
	mut var_product_segmenting_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_product_lookup')
	rt.call_function('preg_match', [rt.new_string('/LIMIT (\\d+)\\s?,\\s?(\\d+)/'),
		var_intervals_query.array_get(rt.new_string('limit')),
		var_limit_parts.clone()])
	mut var_segment_count := rt.new_int(this.get_all_segments().array_count())
	mut var_orig_offset := rt.new_int(var_limit_parts.array_get(rt.new_int(1)).to_i64())
	mut var_orig_rowcount := rt.new_int(var_limit_parts.array_get(rt.new_int(2)).to_i64())
	mut var_segmenting_limit := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('LIMIT %d, %d'),
		rt.mul(var_orig_offset, var_segment_count),
		rt.mul(var_orig_rowcount, var_segment_count),
	])
	mut var_segments_products := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\t'),
			var_intervals_query.array_get(rt.new_string('select_clause'))),
			rt.new_string(' AS time_interval,\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated),
			rt.new_string(' AS ')), var_segmenting_dimension_name_mutated),
			rt.new_string('\n\t\t\t\t\t\t')),
			var_segmenting_selections_mutated.array_get(rt.new_string('product_level'))),
			rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name),
			rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated),
			rt.new_string('\n\t\t\t\t\t\t')),
			var_intervals_query.array_get(rt.new_string('from_clause'))),
			rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')),
			var_intervals_query.array_get(rt.new_string('where_time_clause'))),
			rt.new_string('\n\t\t\t\t\t\t')),
			var_intervals_query.array_get(rt.new_string('where_clause'))),
			rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated),
			rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\ttime_interval, ')),
			var_segmenting_groupby_mutated), rt.new_string('\n\t\t\t\t\t')), var_segmenting_limit),
		rt.get_constant('ARRAY_A'),
	])
	mut var_intervals_segments := this.merge_segment_intervals_results(var_segmenting_dimension_name_mutated.clone(),
		var_segments_products.clone(), rt.new_array())
	return var_intervals_segments.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) get_segments(var_type rt.PhpVal, var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_isset(rt.new_string('segmentby')))
		|| rt.is_true(rt.identical(rt.new_string(''), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get(rt.new_string('segmentby')))) {
		return rt.new_array()
	}
	mut var_product_segmenting_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_order_product_lookup')
	mut var_unique_orders_table := rt.new_string('uniq_orders')
	mut var_segmenting_where := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', [
		'Automattic_WooCommerce_Admin_API_Reports_Segmenter',
	], &this), 'query_args').array_get(rt.new_string('segmentby'))))
	{
		mut var_product_level_columns :=
			this.get_segment_selections_product_level(var_product_segmenting_table.clone())
		mut var_segmenting_selections := rt.create_array([
			rt.ArrayItem{
				key: 'product_level'
				val: this.prepare_selections(var_product_level_columns.clone())
			},
		])
		this.dispatch_set_prop('report_columns', var_product_level_columns.clone())
		mut var_segmenting_from := rt.new_string('')
		mut var_segmenting_groupby := rt.new_string(var_product_segmenting_table.str() +
			'.product_id')
		mut var_segmenting_dimension_name := rt.new_string('product_id')
		mut var_segments := this.get_product_related_segments(var_type.clone(),
			var_segmenting_selections.clone(), var_segmenting_from.clone(),
			var_segmenting_where.clone(), var_segmenting_groupby.clone(),
			var_segmenting_dimension_name.clone(), var_table_name.clone(),
			var_query_params.clone(), var_unique_orders_table.clone())
	} else if rt.is_true(rt.identical(rt.new_string('variation'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', [
		'Automattic_WooCommerce_Admin_API_Reports_Segmenter',
	], &this), 'query_args').array_get(rt.new_string('segmentby'))))
	{
		if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_isset(rt.new_string('product_includes')))
			|| !(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get(rt.new_string('product_includes')).is_array())
			|| rt.is_true(rt.new_bool(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get(rt.new_string('product_includes')).array_count() != 1)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_ParameterException',
				[]string{}, create_automattic_woocommerce_admin_api_reports_parameterexception(rt.new_string('wc_admin_reports_invalid_segmenting_variation'), rt.call_function('__', [
				rt.new_string('product_includes parameter need to specify exactly one product when segmenting by variation.'),
				rt.new_string('woocommerce'),
			]))))
		}
		var_product_level_columns =
			this.get_segment_selections_product_level(var_product_segmenting_table.clone())
		var_segmenting_selections = rt.create_array([
			rt.ArrayItem{
				key: 'product_level'
				val: this.prepare_selections(var_product_level_columns.clone())
			},
		])
		this.dispatch_set_prop('report_columns', var_product_level_columns.clone())
		var_segmenting_from = rt.new_string('')
		var_segmenting_where = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('AND '),
			var_product_segmenting_table), rt.new_string('.product_id = ')), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', [
			'Automattic_WooCommerce_Admin_API_Reports_Segmenter',
		], &this), 'query_args').array_get(rt.new_string('product_includes')).array_get(rt.new_int(0)))).str())
		var_segmenting_groupby = rt.new_string(var_product_segmenting_table.str() + '.variation_id')
		var_segmenting_dimension_name = rt.new_string('variation_id')
		var_segments = this.get_product_related_segments(var_type.clone(),
			var_segmenting_selections.clone(), var_segmenting_from.clone(),
			var_segmenting_where.clone(), var_segmenting_groupby.clone(),
			var_segmenting_dimension_name.clone(), var_table_name.clone(),
			var_query_params.clone(), var_unique_orders_table.clone())
	} else if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', [
		'Automattic_WooCommerce_Admin_API_Reports_Segmenter',
	], &this), 'query_args').array_get(rt.new_string('segmentby'))))
	{
		var_product_level_columns =
			this.get_segment_selections_product_level(var_product_segmenting_table.clone())
		var_segmenting_selections = rt.create_array([
			rt.ArrayItem{
				key: 'product_level'
				val: this.prepare_selections(var_product_level_columns.clone())
			},
		])
		this.dispatch_set_prop('report_columns', var_product_level_columns.clone())
		var_segmenting_from = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tLEFT JOIN '), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string(' ON ')), var_product_segmenting_table),
			rt.new_string('.product_id = ')), rt.get_property(var_wpdb, 'term_relationships')),
			rt.new_string('.object_id\n\t\t\tJOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')),
			rt.new_string(' ON ')), rt.get_property(var_wpdb, 'term_taxonomy')),
			rt.new_string('.term_taxonomy_id = ')), rt.get_property(var_wpdb, 'term_relationships')),
			rt.new_string('.term_taxonomy_id\n\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
			'wc_category_lookup')), rt.new_string(' ON ')), rt.get_property(var_wpdb,
			'term_taxonomy')), rt.new_string('.term_id = ')), rt.get_property(var_wpdb,
			'wc_category_lookup')), rt.new_string('.category_id\n\t\t\t'))).str())
		var_segmenting_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
			'wc_category_lookup')), rt.new_string('.category_tree_id IS NOT NULL'))).str())
		var_segmenting_groupby = rt.new_string((rt.concat(rt.get_property(var_wpdb,
			'wc_category_lookup'), rt.new_string('.category_tree_id'))).str())
		var_segmenting_dimension_name = rt.new_string('category_id')
		if rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter', [
			'Automattic_WooCommerce_Admin_API_Reports_Segmenter',
		], &this), 'query_args').array_isset(rt.new_string('category_includes'))
		{
			mut var_category_ids := rt.call_function('implode', [
				rt.new_string(','), this.get_all_segments()])
			var_segmenting_where = rt.concat(var_segmenting_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
				'wc_category_lookup')), rt.new_string('.category_id IN ( ')), var_category_ids),
				rt.new_string(' )')))
		}
		var_segments = this.get_product_related_segments(var_type.clone(),
			var_segmenting_selections.clone(), var_segmenting_from.clone(),
			var_segmenting_where.clone(), var_segmenting_groupby.clone(),
			var_segmenting_dimension_name.clone(), var_table_name.clone(),
			var_query_params.clone(), var_unique_orders_table.clone())
	}
	return var_segments.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_products_stats_segmenter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_segmenter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_parameterexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_segment_selections_product_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_segment_selections_product_level(dispatch_arg_0)
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
		'get_segments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_segments(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Stats_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
