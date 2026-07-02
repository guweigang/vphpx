import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses {
	rt.PhpObjectBase
pub mut:
		params rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) init(mut var_params Class_Automattic_WooCommerce_Internal_ProductFilters_Params) {
	this.params = var_params
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_query_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_wp_query Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(var_wp_query.get(rt.new_string('filter_stock_status'))) {
	mut var_stock_statuses := rt.new_string(var_wp_query.get(rt.new_string('filter_stock_status')).to_string().trim_space())
	var_stock_statuses = rt.call_function('explode', [rt.new_string(','), var_stock_statuses.clone()])
	var_args_mutated = this.add_stock_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_stock_statuses))
	}
	if rt.is_true(var_wp_query.get(rt.new_string('min_price'))) || rt.is_true(var_wp_query.get(rt.new_string('max_price'))) {
	mut var_price_range := rt.create_array([rt.ArrayItem{ key: 'min_price', val: var_wp_query.get(rt.new_string('min_price')) }, rt.ArrayItem{ key: 'max_price', val: var_wp_query.get(rt.new_string('max_price')) }])
	var_price_range = rt.call_function('array_filter', [var_price_range.clone()])
	var_args_mutated = this.add_price_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_price_range))
	}
	var_args_mutated = this.add_attribute_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	var_args_mutated = this.add_taxonomy_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_taxonomies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_query_clauses_for_main_query(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_wp_query Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_query.is_main_query())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_query'), var_wp_query.get(rt.new_string('wc_query')))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	if rt.is_true(var_wp_query.get(rt.new_string('filter_stock_status'))) {
	mut var_stock_statuses := rt.new_string(var_wp_query.get(rt.new_string('filter_stock_status')).to_string().trim_space())
	var_stock_statuses = rt.call_function('explode', [rt.new_string(','), var_stock_statuses.clone()])
	var_stock_statuses = rt.call_function('array_filter', [var_stock_statuses.clone()])
	var_args_mutated = this.add_stock_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_stock_statuses))
	}
	var_args_mutated = this.add_taxonomy_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_taxonomies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_stock_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_stock_statuses Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_stock_statuses_mutated := var_stock_statuses
	var_stock_statuses_mutated = rt.call_function('array_filter', [var_stock_statuses_mutated])
	if !rt.is_true(var_stock_statuses_mutated) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_filtered_stock_statuses := rt.call_function('array_intersect', [rt.call_function('array_map', [rt.new_string('esc_sql'), var_stock_statuses_mutated]), rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))])
	if !(!rt.is_true(var_filtered_stock_statuses)) {
		var_args_mutated.array_set('join', this.append_product_sorting_table_join((var_args_mutated.array_get(rt.new_string('join'))).str()))
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND wc_product_meta_lookup.stock_status IN ("' + (rt.call_function('implode', [rt.new_string('","'), var_filtered_stock_statuses.clone()])).str() + '")'))
	}
	if !(!rt.is_true(var_stock_statuses_mutated)) && !rt.is_true(var_filtered_stock_statuses) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND 1=0'))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_price_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_price_range Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_price_range_mutated := var_price_range
	if !(var_price_range_mutated.array_isset(rt.new_string('min_price'))) && !(var_price_range_mutated.array_isset(rt.new_string('max_price'))) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_adjust_for_taxes := rt.new_bool(this.should_adjust_price_filters_for_displayed_taxes())
	var_args_mutated.array_set('join', this.append_product_sorting_table_join((var_args_mutated.array_get(rt.new_string('join'))).str()))
	if var_price_range_mutated.array_isset(rt.new_string('min_price')) {
		mut var_min_price_filter := rt.new_int(var_price_range_mutated.array_get(rt.new_string('min_price')).to_i64())
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes((var_min_price_filter).to_f64(), 'max_price', '>='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND wc_product_meta_lookup.max_price >= %f '), var_min_price_filter.clone()]))
		}
	}
	if var_price_range_mutated.array_isset(rt.new_string('max_price')) {
		mut var_max_price_filter := rt.new_int(var_price_range_mutated.array_get(rt.new_string('max_price')).to_i64())
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes((var_max_price_filter).to_f64(), 'min_price', '<='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND wc_product_meta_lookup.min_price <= %f '), var_max_price_filter.clone()]))
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_attribute_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_chosen_attributes Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_chosen_attributes_mutated := var_chosen_attributes
	if !rt.is_true(var_chosen_attributes_mutated) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_clause_root := rt.new_string((rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID IN ( SELECT product_or_parent_id FROM ('))).str())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
	mut var_in_stock_clause := rt.new_string(' AND in_stock = 1')
	} else {
	var_in_stock_clause = rt.new_string('')
	}
	mut var_attribute_ids_for_and_filtering := rt.new_array()
	mut var_clauses := rt.new_array()
	mut var_all_terms_slugs := rt.new_array()
	mut iter_1 := var_chosen_attributes_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		if !(!rt.is_true(var_data.array_get(rt.new_string('terms')))) && var_data.array_get(rt.new_string('terms')).is_array() {
		var_all_terms_slugs = rt.call_function('array_merge', [var_all_terms_slugs.clone(), var_data.array_get(rt.new_string('terms'))])
		}
	}
	mut var_all_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_chosen_attributes_mutated) }, rt.ArrayItem{ key: 'slug', val: var_all_terms_slugs }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_all_terms.clone()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_terms_by_taxonomy := rt.new_array()
	mut iter_2 := var_all_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term := item_2.val
		var_terms_by_taxonomy.array_get_mut(rt.get_property(var_term, 'taxonomy')).array_push(var_term.clone())
	}
	mut iter_3 := var_chosen_attributes_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_data := item_3.val
		mut var_taxonomy := item_3.key
		mut var_current_attribute_terms := if !(var_terms_by_taxonomy.array_get(var_taxonomy)).is_null() { var_terms_by_taxonomy.array_get(var_taxonomy) } else { rt.new_array() }
		mut var_term_ids_by_slug := rt.call_function('wp_list_pluck', [var_current_attribute_terms.clone(), rt.new_string('term_id'), rt.new_string('slug')])
		mut var_term_ids_to_filter_by := rt.call_function('array_values', [rt.call_function('array_intersect_key', [var_term_ids_by_slug.clone(), rt.call_function('array_flip', [var_data.array_get(rt.new_string('terms'))])])])
		var_term_ids_to_filter_by = rt.call_function('array_map', [rt.new_string('absint'), var_term_ids_to_filter_by.clone()])
		mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_term_ids_to_filter_by.clone()])).str() + ')')
		mut var_is_and_query := rt.identical(rt.new_string('and'), rt.new_string(var_data.array_get(rt.new_string('query_type')).to_string().to_lower()))
		mut var_count := rt.new_int(var_term_ids_to_filter_by.clone().array_count())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_count)))) {
			if rt.is_true(var_is_and_query) && rt.is_true(rt.greater(var_count, rt.new_int(1))) {
			var_attribute_ids_for_and_filtering = rt.call_function('array_merge', [var_attribute_ids_for_and_filtering.clone(), var_term_ids_to_filter_by.clone()])
			} else {
				var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\t\t\t\tSELECT product_or_parent_id\n\t\t\t\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\t\t\t\tWHERE term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\t\t\t)')))
			}
		}
	}
	if !(!rt.is_true(var_attribute_ids_for_and_filtering)) {
		mut var_count := rt.new_int(var_attribute_ids_for_and_filtering.clone().array_count())
		mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_attribute_ids_for_and_filtering.clone()])).str() + ')')
		var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=0\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\tGROUP BY product_id\n\t\t\t\tHAVING COUNT(product_id)=')), var_count), rt.new_string('\n\t\t\t\tUNION\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=1\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t)')))
	}
	if !(!rt.is_true(var_clauses)) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND (' + (rt.call_function('join', [rt.new_string(' temp ) AND '), var_clauses.clone()])).str() + ' temp ))'))
	} else if !(!rt.is_true(var_chosen_attributes_mutated)) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND 1=0'))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_taxonomy_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_chosen_taxonomies Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_chosen_taxonomies_mutated := var_chosen_taxonomies
	if !rt.is_true(var_chosen_taxonomies_mutated) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_tax_queries := rt.new_array()
	mut var_all_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_chosen_taxonomies_mutated) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('array_merge', [rt.call_function('array_values', [var_chosen_taxonomies_mutated])]) }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_all_terms.clone()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_term_ids_by_taxonomy := rt.new_array()
	mut iter_4 := var_all_terms.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term := item_4.val
		var_term_ids_by_taxonomy.array_get_mut(rt.get_property(var_term, 'taxonomy')).array_push(rt.get_property(var_term, 'term_id'))
	}
	mut iter_5 := var_term_ids_by_taxonomy.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_term_ids := item_5.val
		mut var_taxonomy := item_5.key
		if !rt.is_true(var_term_ids) {
			continue
		}
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()])) {
			mut var_expanded_term_ids := var_term_ids.clone()
			mut iter_6 := var_term_ids.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_term_id := item_6.val
				mut iife_temp_0 := Class_WC_Cache_Helper{}
				mut iife_result_0 := iife_temp_0.get_cache_prefix(Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())
				mut var_cache_key := rt.new_string((iife_result_0).str() + 'child_terms_' + (var_taxonomy).str() + '_' + (var_term_id).str())
				mut var_children := rt.call_function('wp_cache_get', [var_cache_key.clone()])
				if rt.is_true(rt.identical(rt.new_bool(false), var_children)) {
					var_children = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'child_of', val: var_term_id }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_children.clone()]))))) {
						rt.call_function('wp_cache_set', [var_cache_key.clone(), var_children.clone(), rt.new_string(''), rt.get_constant('HOUR_IN_SECONDS')])
					} else {
					var_children = rt.new_array()
					}
				}
			var_expanded_term_ids = rt.call_function('array_merge', [var_expanded_term_ids.clone(), var_children.clone()])
			}
		var_term_ids = rt.call_function('array_unique', [var_expanded_term_ids.clone()])
		}
		mut var_term_ids_list := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_term_ids.clone()])])).str() + ')')
		var_tax_queries.array_push(rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('EXISTS (\n\t\t\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\t\t\tWHERE tr.object_id = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID\n\t\t\t\t\tAND tt.taxonomy = %s\n\t\t\t\t\tAND tt.term_id IN ')), var_term_ids_list), rt.new_string('\n\t\t\t\t)')), var_taxonomy.clone()]))
	}
	if !(!rt.is_true(var_tax_queries)) {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND (' + (rt.call_function('implode', [rt.new_string(' AND '), var_tax_queries.clone()])).str() + ')'))
	} else {
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(' AND 1=0'))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) append_product_sorting_table_join(sql string) string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [rt.new_string(sql), rt.new_string('wc_product_meta_lookup')]))))) {
		sql = sql + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id '))
	}
	return sql
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) should_adjust_price_filters_for_displayed_taxes() bool {
	mut var_display := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
	mut var_database := rt.new_string((if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) { 'incl' } else { 'excl' }).str())
	return rt.new_bool(!rt.is_true(rt.identical(var_display, var_database)))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_price_filter_query_for_displayed_taxes(price_filter f64, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(operator), rt.create_array([rt.ArrayItem{ key: none, val: '>=' }, rt.ArrayItem{ key: none, val: '<=' }]), rt.new_bool(true)]))))) {
		return ''
	}
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_cache_prefix(rt.new_string('filter_clauses'))
	mut var_cache_key := rt.new_string((iife_result_1).str() + 'tax_classes')
	mut var_product_tax_classes := rt.call_function('wp_cache_get', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_tax_classes)))) {
		var_product_tax_classes = rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.new_string('SELECT DISTINCT tax_class FROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(';'))])
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_product_tax_classes.clone()])
	}
	if !rt.is_true(var_product_tax_classes) {
		return ''
	}
	mut var_or_queries := rt.new_array()
	mut iter_7 := var_product_tax_classes.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_tax_class := item_7.val
		mut var_adjusted_price_filter := rt.new_float(this.adjust_price_filter_for_tax_class(price_filter, (var_tax_class).str()))
		var_or_queries.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('( wc_product_meta_lookup.tax_class = %s AND wc_product_meta_lookup.`' + (rt.call_function('esc_sql', [rt.new_string(column)])).str() + '` ' + (rt.call_function('esc_sql', [rt.new_string(operator)])).str() + ' %f )'), var_tax_class.clone(), var_adjusted_price_filter.clone()]))
	}
	return (rt.call_method(var_wpdb, 'prepare', [rt.new_string(' AND (\n\t\t\t\twc_product_meta_lookup.tax_status = "taxable" AND ( 0=1 OR ' + (rt.call_function('implode', [rt.new_string(' OR '), var_or_queries.clone()])).str() + ')\n\t\t\t\tOR ( wc_product_meta_lookup.tax_status != "taxable" AND wc_product_meta_lookup.`' + (rt.call_function('esc_sql', [rt.new_string(column)])).str() + '` ' + (rt.call_function('esc_sql', [rt.new_string(operator)])).str() + ' %f )\n\t\t\t) '), rt.new_float(price_filter)])).str()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) adjust_price_filter_for_tax_class(price_filter f64, tax_class string) f64 {
	mut var_tax_display := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
	mut iife_temp_2 := Class_WC_Tax{}
	mut iife_result_2 := iife_temp_2.get_rates(rt.new_string(tax_class))
	mut var_tax_rates := iife_result_2
	mut iife_temp_3 := Class_WC_Tax{}
	mut iife_result_3 := iife_temp_3.get_base_tax_rates(rt.new_string(tax_class))
	mut var_base_tax_rates := iife_result_3
	if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display)) {
		mut iife_temp_4 := Class_WC_Tax{}
		mut iife_result_4 := iife_temp_4.calc_tax(rt.new_float(price_filter), var_base_tax_rates.clone(), rt.new_bool(true))
		mut iife_temp_5 := Class_WC_Tax{}
		mut iife_result_5 := iife_temp_5.calc_tax(rt.new_float(price_filter), var_tax_rates.clone(), rt.new_bool(true))
		mut var_taxes := if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_adjust_non_base_location_prices'), rt.new_bool(true)])) { iife_result_4 } else { iife_result_5 }
		return price_filter - rt.call_function('array_sum', [var_taxes.clone()])
	}
	mut iife_temp_6 := Class_WC_Tax{}
	mut iife_result_6 := iife_temp_6.calc_tax(rt.new_float(price_filter), var_tax_rates.clone(), rt.new_bool(false))
	var_taxes = iife_result_6
	return price_filter + rt.call_function('array_sum', [var_taxes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_chosen_attributes(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_chosen_attributes := rt.new_array()
	if !rt.is_true(var_query_vars) {
		return var_chosen_attributes.clone()
	}
	mut iter_8 := var_query_vars.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_value := item_8.val
		mut var_key := item_8.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.clone(), rt.new_string('filter_')]))) {
			mut var_attribute := rt.call_function('wc_sanitize_taxonomy_name', [rt.call_function('str_replace', [rt.new_string('filter_'), rt.new_string(''), var_key.clone()])])
			mut var_taxonomy := rt.call_function('wc_attribute_taxonomy_name', [var_attribute.clone()])
			mut var_filter_terms := if !(!rt.is_true(var_value)) { rt.call_function('explode', [rt.new_string(','), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_value.clone()])])]) } else { rt.new_array() }
			if !rt.is_true(var_filter_terms) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute.clone()]))))) {
				continue
			}
			mut var_query_type := if !(!rt.is_true(var_query_vars.array_get(rt.new_string('query_type_' + (var_attribute).str())))) && rt.is_true(rt.call_function('in_array', [var_query_vars.array_get(rt.new_string('query_type_' + (var_attribute).str())), rt.create_array([rt.ArrayItem{ key: none, val: 'and' }, rt.ArrayItem{ key: none, val: 'or' }]), rt.new_bool(true)])) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [var_query_vars.array_get(rt.new_string('query_type_' + (var_attribute).str()))])]) } else { rt.new_string('') }
			var_chosen_attributes.array_get_mut(var_taxonomy).array_set('terms', rt.call_function('array_map', [rt.new_string('sanitize_title'), var_filter_terms.clone()]))
			var_chosen_attributes.array_get_mut(var_taxonomy).array_set('query_type', if rt.is_true(var_query_type) { var_query_type } else { rt.new_string('and') })
		}
	}
	return var_chosen_attributes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_chosen_taxonomies(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_chosen_taxonomies := rt.new_array()
	if !rt.is_true(var_query_vars) {
		return var_chosen_taxonomies.clone()
	}
	mut iter_9 := rt.call_method(this.params, 'get_param', [rt.new_string('taxonomy')]).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_param := item_9.val
		mut var_taxonomy := item_9.key
		if var_query_vars.array_isset(var_param) && !(var_query_vars.array_get(var_param).to_string().trim_space() == '') {
			var_chosen_taxonomies.array_set(var_taxonomy, rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), var_query_vars.array_get(var_param)])])]))
		}
	}
	return var_chosen_taxonomies.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_lookup_table_name() string {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()]), 'get_lookup_table_name', []rt.PhpVal{})).str()
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfilters_queryclauses(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses{
		PhpObjectBase: rt.PhpObjectBase{}
		params: rt.new_null()
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_Params](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_query_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_query_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_query_clauses_for_main_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_query_clauses_for_main_query(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_stock_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_stock_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_price_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_price_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_attribute_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_attribute_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_taxonomy_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_taxonomy_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.append_product_sorting_table_join(dispatch_arg_0))
		}
		'should_adjust_price_filters_for_displayed_taxes' {
			return rt.new_bool(this.should_adjust_price_filters_for_displayed_taxes())
		}
		'get_price_filter_query_for_displayed_taxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filter_for_tax_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_float(this.adjust_price_filter_for_tax_class(dispatch_arg_0, dispatch_arg_1))
		}
		'get_chosen_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_chosen_attributes(mut dispatch_arg_0)
		}
		'get_chosen_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_chosen_taxonomies(mut dispatch_arg_0)
		}
		'get_lookup_table_name' {
			return rt.new_string(this.get_lookup_table_name())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'params' { return this.params }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'params' { this.params = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
