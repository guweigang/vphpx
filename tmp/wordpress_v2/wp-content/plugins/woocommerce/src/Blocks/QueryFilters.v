import rt

struct Class_Automattic_WooCommerce_Blocks_QueryFilters {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) init() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) main_query_filter(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_query'), rt.call_method(var_wp_query, 'get', [rt.new_string('wc_query')]))))) {
		return var_args_mutated.clone()
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [
		rt.new_string('filter_stock_status'),
	]))
	{
		var_args_mutated = this.stock_filter_clauses(var_args_mutated.clone(), var_wp_query.clone())
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) add_query_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = this.stock_filter_clauses(var_args_mutated.clone(), var_wp_query.clone())
	var_args_mutated = this.price_filter_clauses(var_args_mutated.clone(), var_wp_query.clone())
	var_args_mutated = this.attribute_filter_clauses(var_args_mutated.clone(), var_wp_query.clone())
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_filtered_price(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', -1)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	var_query.query(var_query_vars_mutated.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_price_filter_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\tFROM '), rt.get_property(var_wpdb,
		'wc_product_meta_lookup')), rt.new_string('\n\t\tWHERE product_id IN ( ')),
		var_product_query_sql), rt.new_string(' )\n\t\t'))).str())
	return rt.call_method(var_wpdb, 'get_row', [var_price_filter_sql.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_stock_status_counts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_stock_status_options := rt.call_function('array_map', [
		rt.new_string('esc_sql'),
		rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})),
	])
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', -1)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	mut var_result := var_query.query(var_query_vars_mutated.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_stock_status_counts := rt.new_array()
	mut iter_1 := var_stock_status_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status := item_1.val
		mut var_stock_status_count_sql := this.generate_stock_status_count_query(var_status.clone(),
			var_product_query_sql.clone(), var_stock_status_options.clone())
		var_result = rt.call_method(var_wpdb, 'get_row', [var_stock_status_count_sql.clone()])
		var_stock_status_counts.array_set(var_status, rt.get_property(var_result, 'status_count'))
	}
	return var_stock_status_counts.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_rating_counts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', -1)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	var_query.query(var_query_vars_mutated.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_rating_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT product_id ) as product_count, ROUND( average_rating, 0 ) as rounded_average_rating\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')),
		var_product_query_sql),
		rt.new_string(' )\n\t\t\tAND average_rating > 0\n\t\t\tGROUP BY rounded_average_rating\n\t\t\tORDER BY rounded_average_rating DESC\n\t\t'))).str())
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_rating_count_sql.clone()])
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_function('wp_list_pluck', [var_results.clone(),
			rt.new_string('product_count'), rt.new_string('rounded_average_rating')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_attribute_counts(var_query_vars rt.PhpVal, var_attribute_to_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', -1)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	mut var_result := var_query.query(var_query_vars_mutated.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_attributes_to_count := rt.call_function('esc_sql', [
		rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_to_count.clone()]),
	])
	mut var_attribute_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(DISTINCT posts.ID) as term_count, terms.term_id as term_count_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'posts')), rt.new_string(' AS posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'term_relationships')),
		rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'term_taxonomy')),
		rt.new_string(' AS term_taxonomy ON term_relationships.term_taxonomy_id = term_taxonomy.term_taxonomy_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'terms')),
		rt.new_string(' AS terms ON term_taxonomy.term_id = terms.term_id\n\t\t\tWHERE posts.ID IN ( ')),
		var_product_query_sql), rt.new_string(" )\n\t\t\tAND term_taxonomy.taxonomy IN ('")),
		var_attributes_to_count),
		rt.new_string("')\n\t\t\tAND posts.post_status = 'publish'\n\t\t\tAND posts.post_type = 'product'\n\t\t\tGROUP BY terms.term_id\n\t\t\tORDER BY terms.name ASC"))).str())
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_attribute_count_sql.clone()])
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_function('wp_list_pluck', [var_results.clone(),
			rt.new_string('term_count'), rt.new_string('term_count_id')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) stock_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [
		rt.new_string('filter_stock_status'),
	])))))
	{
		return var_args_mutated.clone()
	}
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(
		" AND wc_product_meta_lookup.stock_status IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('explode', [rt.new_string(','), rt.call_method(var_wp_query, 'get', [rt.new_string('filter_stock_status')])])])])).str() +
		"')"))
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) price_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')]))))) {
		return var_args_mutated.clone()
	}
	mut var_adjust_for_taxes := rt.new_bool(this.adjust_price_filters_for_displayed_taxes())
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')])) {
		mut var_min_price_filter := rt.new_int(rt.call_method(var_wp_query, 'get', [
			rt.new_string('min_price'),
		]).to_i64())
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_min_price_filter.clone(),
				'max_price', '>='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.max_price >= %f '),
				var_min_price_filter.clone(),
			]))
		}
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')])) {
		mut var_max_price_filter := rt.new_int(rt.call_method(var_wp_query, 'get', [
			rt.new_string('max_price'),
		]).to_i64())
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_max_price_filter.clone(),
				'min_price', '<='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.min_price <= %f '),
				var_max_price_filter.clone(),
			]))
		}
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
		var_sql.clone(), rt.new_string('wc_product_meta_lookup')])))))
	{
		var_sql = rt.concat(var_sql, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup ON ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id ')))
	}
	return var_sql.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) generate_stock_status_count_query(var_status rt.PhpVal, var_product_query_sql rt.PhpVal, var_stock_status_options rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	mut var_product_query_sql_mutated := var_product_query_sql
	mut var_stock_status_options_mutated := var_stock_status_options
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_status_mutated.clone(), var_stock_status_options_mutated.clone(),
		rt.new_bool(true)])))))
	{
		return rt.new_bool(false)
	}
	var_status_mutated = rt.call_function('esc_sql', [var_status_mutated.clone()])
	return rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT posts.ID ) as status_count\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'posts')), rt.new_string(' as posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'postmeta')),
		rt.new_string(" as postmeta ON posts.ID = postmeta.post_id\n\t\t\tAND postmeta.meta_key = '_stock_status'\n\t\t\tAND postmeta.meta_value = '")),
		var_status_mutated), rt.new_string("'\n\t\t\tWHERE posts.ID IN ( ")),
		var_product_query_sql_mutated), rt.new_string(' )\n\t\t'))).str())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	mut var_product_tax_classes := rt.call_function('array_filter', [
		rt.call_method(var_wpdb, 'get_col', [
			rt.concat(rt.concat(rt.new_string('SELECT DISTINCT tax_class FROM '), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')), rt.new_string(';')),
		]),
	])
	if !rt.is_true(var_product_tax_classes) {
		return ''
	}
	mut var_or_queries := rt.new_array()
	mut iter_2 := var_product_tax_classes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_tax_class := item_2.val
		mut var_adjusted_price_filter := this.adjust_price_filter_for_tax_class(var_price_filter.clone(),
			var_tax_class.clone())
		var_or_queries.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('( wc_product_meta_lookup.tax_class = %s AND wc_product_meta_lookup.`' +
				(rt.call_function('esc_sql', [rt.new_string(column)])).str() + '` ' +
				(rt.call_function('esc_sql', [rt.new_string(operator)])).str() + ' %f )'),
			var_tax_class.clone(),
			var_adjusted_price_filter.clone(),
		]))
	}
	return (rt.call_method(var_wpdb, 'prepare', [
		rt.new_string(
			' AND (\n\t\t\t\twc_product_meta_lookup.tax_status = "taxable" AND ( 0=1 OR ' + (rt.call_function('implode', [rt.new_string(' OR '), var_or_queries.clone()])).str() +
			')\n\t\t\t\tOR ( wc_product_meta_lookup.tax_status != "taxable" AND wc_product_meta_lookup.`' + (rt.call_function('esc_sql', [rt.new_string(column)])).str() +
			'` ' + (rt.call_function('esc_sql', [rt.new_string(operator)])).str() +
			' %f )\n\t\t\t) '),
		var_price_filter.clone(),
	])).str()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) adjust_price_filters_for_displayed_taxes() bool {
	mut var_display := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut var_database := rt.new_string((if rt.is_true(rt.call_function('wc_prices_include_tax',
		[]rt.PhpVal{}))
	{
		'incl'
	} else {
		'excl'
	}).str())
	return rt.new_bool(!rt.is_true(rt.identical(var_display, var_database)))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_tax_display := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut iife_temp_0 := Class_WC_Tax{}
	mut iife_result_0 := iife_temp_0.get_rates(var_tax_class.clone())
	mut var_tax_rates := iife_result_0
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1.get_base_tax_rates(var_tax_class.clone())
	mut var_base_tax_rates := iife_result_1
	if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display)) {
		mut iife_temp_2 := Class_WC_Tax{}
		mut iife_result_2 := iife_temp_2.calc_tax(var_price_filter.clone(),
			var_base_tax_rates.clone(), rt.new_bool(true))
		mut iife_temp_3 := Class_WC_Tax{}
		mut iife_result_3 := iife_temp_3.calc_tax(var_price_filter.clone(), var_tax_rates.clone(),
			rt.new_bool(true))
		mut var_taxes := if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_adjust_non_base_location_prices'),
			rt.new_bool(true),
		]))
		{ iife_result_2 } else { iife_result_3 }
		return rt.sub(var_price_filter, rt.call_function('array_sum', [
			var_taxes.clone()]))
	}
	mut iife_temp_4 := Class_WC_Tax{}
	mut iife_result_4 := iife_temp_4.calc_tax(var_price_filter.clone(), var_tax_rates.clone(),
		rt.new_bool(false))
	var_taxes = iife_result_4
	return rt.add(var_price_filter, rt.call_function('array_sum', [
		var_taxes.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_lookup_table_name() rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
	]), 'get_lookup_table_name', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) attribute_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clauses := rt.new_null()
	mut var_args_mutated := var_args
	mut var_chosen_attributes := this.get_chosen_attributes(rt.get_property(var_wp_query,
		'query_vars'))
	if !rt.is_true(var_chosen_attributes) {
		return var_args_mutated.clone()
	}
	mut var_clause_root := rt.new_string((rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb,
		'posts')), rt.new_string('.ID IN ( SELECT product_or_parent_id FROM ('))).str())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))
	{
		mut var_in_stock_clause := rt.new_string(' AND in_stock = 1')
	} else {
		var_in_stock_clause = rt.new_string('')
	}
	mut var_attribute_ids_for_and_filtering := rt.new_array()
	mut iter_3 := var_chosen_attributes.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_data := item_3.val
		mut var_taxonomy := item_3.key
		mut var_all_terms := rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'hide_empty', val: false }]),
		])
		mut var_term_ids_by_slug := rt.call_function('wp_list_pluck', [
			var_all_terms.clone(), rt.new_string('term_id'), rt.new_string('slug')])
		mut var_term_ids_to_filter_by := rt.call_function('array_values', [
			rt.call_function('array_intersect_key', [var_term_ids_by_slug.clone(),
				rt.call_function('array_flip', [var_data.array_get(rt.new_string('terms'))])]),
		])
		var_term_ids_to_filter_by = rt.call_function('array_map', [
			rt.new_string('absint'),
			var_term_ids_to_filter_by.clone(),
		])
		mut var_term_ids_to_filter_by_list := rt.new_string('(' +
			(rt.call_function('join', [rt.new_string(','), var_term_ids_to_filter_by.clone()])).str() +
			')')
		mut var_is_and_query := rt.identical(rt.new_string('and'),
			var_data.array_get(rt.new_string('query_type')))
		mut var_count := rt.new_int(var_term_ids_to_filter_by.clone().array_count())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_count)))) {
			if rt.is_true(var_is_and_query) && rt.is_true(rt.greater(var_count, rt.new_int(1))) {
				var_attribute_ids_for_and_filtering = rt.call_function('array_merge', [
					var_attribute_ids_for_and_filtering.clone(),
					var_term_ids_to_filter_by.clone(),
				])
			} else {
				var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\t\t'),
					var_clause_root),
					rt.new_string('\n\t\t\t\t\t\t\tSELECT product_or_parent_id\n\t\t\t\t\t\t\tFROM ')),
					this.get_lookup_table_name()),
					rt.new_string(' lt\n\t\t\t\t\t\t\tWHERE term_id in ')),
					var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\t\t\t\t')),
					var_in_stock_clause), rt.new_string('\n\t\t\t\t\t\t)')))
			}
		}
	}
	if !(!rt.is_true(var_attribute_ids_for_and_filtering)) {
		mut var_count := rt.new_int(var_attribute_ids_for_and_filtering.clone().array_count())
		mut var_term_ids_to_filter_by_list := rt.new_string('(' +
			(rt.call_function('join', [rt.new_string(','), var_attribute_ids_for_and_filtering.clone()])).str() +
			')')
		var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t'),
			var_clause_root), rt.new_string('\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')),
			this.get_lookup_table_name()),
			rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=0\n\t\t\t\t')),
			var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')),
			var_term_ids_to_filter_by_list),
			rt.new_string('\n\t\t\t\tGROUP BY product_id\n\t\t\t\tHAVING COUNT(product_id)=')),
			var_count),
			rt.new_string('\n\t\t\t\tUNION\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')),
			this.get_lookup_table_name()),
			rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=1\n\t\t\t\t')),
			var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')),
			var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t)')))
	}
	if !(!rt.is_true(var_clauses)) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(
			' AND (' + (rt.call_function('join', [rt.new_string(' temp ) AND '), var_clauses.clone()])).str() +
			' temp ))'))
	} else if !(!rt.is_true(var_chosen_attributes)) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')),
			rt.new_string(' AND 1=0'))
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_chosen_attributes(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_chosen_attributes := rt.new_array()
	if !rt.is_true(var_query_vars_mutated) {
		return var_chosen_attributes.clone()
	}
	mut iter_4 := var_query_vars_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			var_key.clone(), rt.new_string('filter_')])))
		{
			if !(var_value.clone().is_string()) {
				continue
			}
			mut var_attribute := rt.call_function('wc_sanitize_taxonomy_name', [
				rt.call_function('str_replace', [rt.new_string('filter_'),
					rt.new_string(''), var_key.clone()]),
			])
			mut var_taxonomy := rt.call_function('wc_attribute_taxonomy_name', [
				var_attribute.clone(),
			])
			mut var_filter_terms := if !(!rt.is_true(var_value)) { rt.call_function('explode', [
					rt.new_string(','),
					rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [var_value.clone()]),
					]),
				]) } else { rt.new_array() }
			if !rt.is_true(var_filter_terms)
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()])))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute.clone()]))))) {
				continue
			}
			mut var_query_type := if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('query_type_' + var_attribute.str())))) && rt.is_true(rt.call_function('in_array', [var_query_vars_mutated.array_get(rt.new_string('query_type_' + var_attribute.str())), rt.create_array([rt.ArrayItem{
				key: none
				val: 'and'
			}, rt.ArrayItem{ key: none, val: 'or' }]), rt.new_bool(true)])) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						var_query_vars_mutated.array_get(rt.new_string('query_type_' + var_attribute.str())),
					]),
				]) } else { rt.new_string('') }
			var_chosen_attributes.array_get_mut(var_taxonomy).array_set('terms', rt.call_function('array_map', [
				rt.new_string('sanitize_title'),
				var_filter_terms.clone(),
			]))
			var_chosen_attributes.array_get_mut(var_taxonomy).array_set('query_type', if rt.is_true(var_query_type) {
				var_query_type
			} else {
				rt.new_string('and')
			})
		}
	}
	return var_chosen_attributes.clone()
}

struct Class_Automattic_WooCommerce_Blocks_WP_Query {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_queryfilters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_QueryFilters {
	mut obj := &Class_Automattic_WooCommerce_Blocks_QueryFilters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Blocks_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'main_query_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.main_query_filter(dispatch_arg_0, dispatch_arg_1)
		}
		'add_query_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_query_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'get_filtered_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filtered_price(dispatch_arg_0)
		}
		'get_stock_status_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status_counts(dispatch_arg_0)
		}
		'get_rating_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rating_counts(dispatch_arg_0)
		}
		'get_attribute_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_attribute_counts(dispatch_arg_0, dispatch_arg_1)
		}
		'stock_filter_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.stock_filter_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'price_filter_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.price_filter_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_product_sorting_table_join(dispatch_arg_0)
		}
		'generate_stock_status_count_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.generate_stock_status_count_query(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_price_filter_query_for_displayed_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filters_for_displayed_taxes' {
			return rt.new_bool(this.adjust_price_filters_for_displayed_taxes())
		}
		'adjust_price_filter_for_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_price_filter_for_tax_class(dispatch_arg_0, dispatch_arg_1)
		}
		'get_lookup_table_name' {
			return this.get_lookup_table_name()
		}
		'attribute_filter_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.attribute_filter_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'get_chosen_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_chosen_attributes(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
