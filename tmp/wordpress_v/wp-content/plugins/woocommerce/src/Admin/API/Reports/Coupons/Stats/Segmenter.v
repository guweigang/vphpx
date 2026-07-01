import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_segment_selections_product_level(var_products_table rt.PhpVal) rt.PhpVal {
	mut var_columns_mapping := rt.create_array([rt.ArrayItem{ key: 'amount', val: "SUM(${var_products_table.to_string()}.coupon_amount) as amount" }])
	return var_columns_mapping.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_segment_selections_order_level(var_coupons_lookup_table rt.PhpVal) rt.PhpVal {
	mut var_columns_mapping := rt.create_array([rt.ArrayItem{ key: 'coupons_count', val: "COUNT(DISTINCT ${var_coupons_lookup_table.to_string()}.coupon_id) as coupons_count" }, rt.ArrayItem{ key: 'orders_count', val: "COUNT(DISTINCT ${var_coupons_lookup_table.to_string()}.order_id) as orders_count" }])
	return var_columns_mapping.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) segment_selections_orders(var_coupons_lookup_table rt.PhpVal, var_overrides rt.PhpVal) rt.PhpVal {
	mut var_columns_mapping := rt.create_array([rt.ArrayItem{ key: 'amount', val: "SUM(${var_coupons_lookup_table.to_string()}.discount_amount) as amount" }, rt.ArrayItem{ key: 'coupons_count', val: "COUNT(DISTINCT ${var_coupons_lookup_table.to_string()}.coupon_id) as coupons_count" }, rt.ArrayItem{ key: 'orders_count', val: "COUNT(DISTINCT ${var_coupons_lookup_table.to_string()}.order_id) as orders_count" }])
	if rt.is_true(var_overrides) {
		var_columns_mapping = rt.call_function('array_merge', [var_columns_mapping.dup(), var_overrides.dup()])
	}
	return var_columns_mapping.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_product_related_totals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_segmenting_selections_mutated := var_segmenting_selections
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	mut var_segmenting_dimension_name_mutated := var_segmenting_dimension_name
	mut var_unique_orders_table_mutated := var_unique_orders_table
	// unsupported statement: Stmt_Global
	mut var_segments_products := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\t'), var_segmenting_groupby_mutated), rt.new_string(' AS ')), var_segmenting_dimension_name_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_selections_mutated.array_get('product_level')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_selections_mutated.array_get('order_level')), rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_totals_query.array_get('from_clause')), rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')), var_totals_query.array_get('where_time_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_totals_query.array_get('where_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated), rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated), rt.get_constant('ARRAY_A')])
	mut var_totals_segments := this.merge_segment_totals_results(var_segmenting_dimension_name_mutated.dup(), var_segments_products.dup(), rt.new_array())
	return var_totals_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_product_related_intervals_segments(var_segmenting_selections rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_segmenting_dimension_name rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal, var_unique_orders_table rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_segmenting_selections_mutated := var_segmenting_selections
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	mut var_segmenting_dimension_name_mutated := var_segmenting_dimension_name
	mut var_unique_orders_table_mutated := var_unique_orders_table
	// unsupported statement: Stmt_Global
	mut var_limit_parts := rt.call_function('explode', [rt.new_string(','), var_intervals_query.array_get('limit')])
	mut var_orig_rowcount := rt.new_int(rt.new_int(var_limit_parts.array_get(1).to_i64()))
	mut var_segmenting_limit := rt.new_string((var_limit_parts.array_get(0)).str() + ',' + (rt.mul(var_orig_rowcount, rt.new_int(this.get_all_segments().array_count()))).str())
	mut var_segments_products := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\t'), var_intervals_query.array_get('select_clause')), rt.new_string(' AS time_interval,\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated), rt.new_string(' AS ')), var_segmenting_dimension_name_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_selections_mutated.array_get('product_level')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_selections_mutated.array_get('order_level')), rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_intervals_query.array_get('from_clause')), rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')), var_intervals_query.array_get('where_time_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_intervals_query.array_get('where_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated), rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\ttime_interval, ')), var_segmenting_groupby_mutated), rt.new_string('\n\t\t\t\t\t')), var_segmenting_limit), rt.get_constant('ARRAY_A')])
	mut var_intervals_segments := this.merge_segment_intervals_results(var_segmenting_dimension_name_mutated.dup(), var_segments_products.dup(), rt.new_array())
	return var_intervals_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_order_related_totals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_totals_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	// unsupported statement: Stmt_Global
	mut var_totals_segments := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\t'), var_segmenting_groupby_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_select), rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_totals_query.array_get('from_clause')), rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')), var_totals_query.array_get('where_time_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_totals_query.array_get('where_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated), rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated), rt.get_constant('ARRAY_A')])
	var_totals_segments = this.reformat_totals_segments(var_totals_segments.dup(), var_segmenting_groupby_mutated.dup())
	return var_totals_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_order_related_intervals_segments(var_segmenting_select rt.PhpVal, var_segmenting_from rt.PhpVal, var_segmenting_where rt.PhpVal, var_segmenting_groupby rt.PhpVal, var_table_name rt.PhpVal, var_intervals_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_segmenting_from_mutated := var_segmenting_from
	mut var_segmenting_where_mutated := var_segmenting_where
	mut var_segmenting_groupby_mutated := var_segmenting_groupby
	// unsupported statement: Stmt_Global
	mut var_limit_parts := rt.call_function('explode', [rt.new_string(','), var_intervals_query.array_get('limit')])
	mut var_orig_rowcount := rt.new_int(rt.new_int(var_limit_parts.array_get(1).to_i64()))
	mut var_segmenting_limit := rt.new_string((var_limit_parts.array_get(0)).str() + ',' + (rt.mul(var_orig_rowcount, rt.new_int(this.get_all_segments().array_count()))).str())
	mut var_intervals_segments := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT\n\t\t\t\t\t\tMAX('), var_table_name), rt.new_string('.date_created) AS datetime_anchor,\n\t\t\t\t\t\t')), var_intervals_query.array_get('select_clause')), rt.new_string(' AS time_interval,\n\t\t\t\t\t\t')), var_segmenting_groupby_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_select), rt.new_string('\n\t\t\t\t\tFROM\n\t\t\t\t\t\t')), var_table_name), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_from_mutated), rt.new_string('\n\t\t\t\t\t\t')), var_intervals_query.array_get('from_clause')), rt.new_string('\n\t\t\t\t\tWHERE\n\t\t\t\t\t\t1=1\n\t\t\t\t\t\t')), var_intervals_query.array_get('where_time_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_intervals_query.array_get('where_clause')), rt.new_string('\n\t\t\t\t\t\t')), var_segmenting_where_mutated), rt.new_string('\n\t\t\t\t\tGROUP BY\n\t\t\t\t\t\ttime_interval, ')), var_segmenting_groupby_mutated), rt.new_string('\n\t\t\t\t\t')), var_segmenting_limit), rt.get_constant('ARRAY_A')])
	var_intervals_segments = this.reformat_intervals_segments(var_intervals_segments.dup(), var_segmenting_groupby_mutated.dup())
	return var_intervals_segments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) get_segments(var_type rt.PhpVal, var_query_params rt.PhpVal, var_table_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_isset(rt.new_string('segmentby'))) || rt.is_true(rt.identical(rt.new_string(''), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('segmentby'))))) {
		return rt.new_array()
	}
	mut var_segments := rt.new_null()
	mut var_product_segmenting_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
	mut var_unique_orders_table := rt.new_string(rt.new_string(''))
	mut var_segmenting_where := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('segmentby'))) {
		mut var_product_level_columns := this.get_segment_selections_product_level(var_product_segmenting_table.dup())
		mut var_order_level_columns := this.get_segment_selections_order_level(var_table_name.dup())
		mut var_segmenting_selections := rt.create_array([rt.ArrayItem{ key: 'product_level', val: this.prepare_selections(var_product_level_columns.dup()) }, rt.ArrayItem{ key: 'order_level', val: this.prepare_selections(var_order_level_columns.dup()) }])
		this.dispatch_set_prop('report_columns', rt.call_function('array_merge', [var_product_level_columns.dup(), var_order_level_columns.dup()]))
		mut var_segmenting_from := rt.new_string(rt.new_string("INNER JOIN ${var_product_segmenting_table.to_string()} ON (${var_table_name.to_string()}.order_id = ${var_product_segmenting_table.to_string()}.order_id)"))
		mut var_segmenting_groupby := rt.new_string((var_product_segmenting_table).str() + '.product_id')
		mut var_segmenting_dimension_name := rt.new_string(rt.new_string('product_id'))
		var_segments = this.get_product_related_segments(var_type.dup(), var_segmenting_selections.dup(), var_segmenting_from.dup(), var_segmenting_where.dup(), var_segmenting_groupby.dup(), var_segmenting_dimension_name.dup(), var_table_name.dup(), var_query_params.dup(), var_unique_orders_table.dup())
	} else if rt.is_true(rt.identical(rt.new_string('variation'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('segmentby'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_isset(rt.new_string('product_includes'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('product_includes').is_array()))))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_ParameterException', []string{}, create_automattic_woocommerce_admin_api_reports_parameterexception(rt.new_string('wc_admin_reports_invalid_segmenting_variation'), rt.call_function('__', [rt.new_string('product_includes parameter need to specify exactly one product when segmenting by variation.'), rt.new_string('woocommerce')]))))
		}
		var_product_level_columns = this.get_segment_selections_product_level(var_product_segmenting_table.dup())
		var_order_level_columns = this.get_segment_selections_order_level(var_table_name.dup())
		var_segmenting_selections = rt.create_array([rt.ArrayItem{ key: 'product_level', val: this.prepare_selections(var_product_level_columns.dup()) }, rt.ArrayItem{ key: 'order_level', val: this.prepare_selections(var_order_level_columns.dup()) }])
		this.dispatch_set_prop('report_columns', rt.call_function('array_merge', [var_product_level_columns.dup(), var_order_level_columns.dup()]))
		var_segmenting_from = rt.new_string(rt.new_string("INNER JOIN ${var_product_segmenting_table.to_string()} ON (${var_table_name.to_string()}.order_id = ${var_product_segmenting_table.to_string()}.order_id)"))
		var_segmenting_where = rt.new_string(rt.concat(rt.concat(rt.concat(rt.new_string('AND '), var_product_segmenting_table), rt.new_string('.product_id = ')), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('product_includes').array_get(0)))
		var_segmenting_groupby = rt.new_string((var_product_segmenting_table).str() + '.variation_id')
		var_segmenting_dimension_name = rt.new_string(rt.new_string('variation_id'))
		var_segments = this.get_product_related_segments(var_type.dup(), var_segmenting_selections.dup(), var_segmenting_from.dup(), var_segmenting_where.dup(), var_segmenting_groupby.dup(), var_segmenting_dimension_name.dup(), var_table_name.dup(), var_query_params.dup(), var_unique_orders_table.dup())
	} else if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('segmentby'))) {
		var_product_level_columns = this.get_segment_selections_product_level(var_product_segmenting_table.dup())
		var_order_level_columns = this.get_segment_selections_order_level(var_table_name.dup())
		var_segmenting_selections = rt.create_array([rt.ArrayItem{ key: 'product_level', val: this.prepare_selections(var_product_level_columns.dup()) }, rt.ArrayItem{ key: 'order_level', val: this.prepare_selections(var_order_level_columns.dup()) }])
		this.dispatch_set_prop('report_columns', rt.call_function('array_merge', [var_product_level_columns.dup(), var_order_level_columns.dup()]))
		var_segmenting_from = rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tINNER JOIN '), var_product_segmenting_table), rt.new_string(' ON (')), var_table_name), rt.new_string('.order_id = ')), var_product_segmenting_table), rt.new_string('.order_id)\n\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' ON ')), var_product_segmenting_table), rt.new_string('.product_id = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.object_id\n\t\t\tJOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.term_taxonomy_id = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.term_taxonomy_id\n\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string('.term_id = ')), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string('.category_id\n\t\t\t')))
		var_segmenting_where = rt.new_string(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'wc_category_lookup')), rt.new_string('.category_tree_id IS NOT NULL')))
		var_segmenting_groupby = rt.new_string(rt.concat(rt.get_property(var_wpdb, 'wc_category_lookup'), rt.new_string('.category_tree_id')))
		var_segmenting_dimension_name = rt.new_string(rt.new_string('category_id'))
		var_segments = this.get_product_related_segments(var_type.dup(), var_segmenting_selections.dup(), var_segmenting_from.dup(), var_segmenting_where.dup(), var_segmenting_groupby.dup(), var_segmenting_dimension_name.dup(), var_table_name.dup(), var_query_params.dup(), var_unique_orders_table.dup())
	} else if rt.is_true(rt.identical(rt.new_string('coupon'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter', ['Automattic_WooCommerce_Admin_API_Reports_Segmenter'], &this), 'query_args').array_get('segmentby'))) {
		mut var_coupon_level_columns := this.segment_selections_orders(var_table_name.dup(), rt.new_null())
		var_segmenting_selections = this.prepare_selections(var_coupon_level_columns.dup())
		this.dispatch_set_prop('report_columns', var_coupon_level_columns.dup())
		var_segmenting_from = rt.new_string(rt.new_string(''))
		var_segmenting_groupby = rt.new_string(rt.new_string("${var_table_name.to_string()}.coupon_id"))
		var_segments = this.get_order_related_segments(var_type.dup(), var_segmenting_selections.dup(), var_segmenting_from.dup(), var_segmenting_where.dup(), var_segmenting_groupby.dup(), var_table_name.dup(), var_query_params.dup())
	}
	return var_segments.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_stats_segmenter() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_segmenter() &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Segmenter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_parameterexception() &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_ParameterException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_segment_selections_product_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_segment_selections_product_level(dispatch_arg_0)
		}
		'get_segment_selections_order_level' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_segment_selections_order_level(dispatch_arg_0)
		}
		'segment_selections_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.segment_selections_orders(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Stats_Segmenter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_coupons_stats_segmenter_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
