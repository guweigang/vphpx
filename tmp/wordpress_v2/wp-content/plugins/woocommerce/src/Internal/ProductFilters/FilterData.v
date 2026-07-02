import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	rt.PhpObjectBase
pub mut:
	query_clauses           rt.PhpVal = rt.new_null()
	taxonomy_hierarchy_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) construct(mut var_query_clauses Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator, mut var_taxonomy_hierarchy_data Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) {
	this.query_clauses = var_query_clauses
	this.taxonomy_hierarchy_data = var_taxonomy_hierarchy_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_filtered_price(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pre_product_filter_data'),
		rt.new_null(),
		rt.new_string('price'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.clone().is_array())) {
		return var_pre_filter_counts.clone()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated), rt.new_string('price'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.clone())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.clone()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		mut var_price_filter_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')),
			var_product_ids), rt.new_string(' )\n\t\t\t'))).str())
		var_results = rt.cast_array(rt.call_method(var_wpdb, 'get_row', [
			var_price_filter_sql.clone()]))
	}
	var_results = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_data'),
		var_results.clone(),
		rt.new_string('price'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	this.set_cache(var_transient_key.clone(), var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_stock_status_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_statuses Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pre_product_filter_data'),
		rt.new_null(),
		rt.new_string('stock'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.clone().is_array())) {
		return var_pre_filter_counts.clone()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated), rt.new_string('stock'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.clone())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.clone()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		mut iter_1 := var_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			mut var_stock_status_count_sql := rt.new_string((
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT COUNT( DISTINCT posts.ID ) as status_count\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" as postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\tAND postmeta.meta_key = '_stock_status'\n\t\t\t\t\tAND postmeta.meta_value = '")) +
				(rt.call_function('esc_sql', [var_status.clone()])).str() +
				"'\n\t\t\t\t\tWHERE posts.ID IN ( ${var_product_ids.to_string()} )\n\t\t\t\t").str())
			mut var_result := rt.call_method(var_wpdb, 'get_row', [
				var_stock_status_count_sql.clone()])
			var_results.array_set(var_status, rt.get_property(var_result, 'status_count'))
		}
	}
	var_results = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_data'),
		var_results.clone(),
		rt.new_string('stock'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	this.set_cache(var_transient_key.clone(), var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_rating_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pre_product_filter_data'),
		rt.new_null(),
		rt.new_string('rating'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.clone().is_array())) {
		return var_pre_filter_counts.clone()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated), rt.new_string('rating'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.clone())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.clone()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		mut var_rating_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT COUNT( DISTINCT product_id ) as product_count, ROUND( average_rating, 0 ) as rounded_average_rating\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string('\n\t\t\t\tWHERE product_id IN ( ')),
			var_product_ids),
			rt.new_string(' )\n\t\t\t\tAND average_rating > 0\n\t\t\t\tGROUP BY rounded_average_rating\n\t\t\t\tORDER BY rounded_average_rating DESC\n\t\t\t'))).str())
		var_results = rt.call_method(var_wpdb, 'get_results', [
			var_rating_count_sql.clone()])
		var_results = rt.call_function('array_map', [rt.new_string('absint'),
			rt.call_function('wp_list_pluck', [var_results.clone(),
				rt.new_string('product_count'), rt.new_string('rounded_average_rating')])])
	}
	var_results = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_data'),
		var_results.clone(),
		rt.new_string('rating'),
		var_query_vars_mutated,
		rt.new_array(),
	])
	this.set_cache(var_transient_key.clone(), var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_attribute_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, attribute_to_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pre_product_filter_data'),
		rt.new_null(),
		rt.new_string('attribute'),
		var_query_vars_mutated,
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count }]),
	])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.clone().is_array())) {
		return var_pre_filter_counts.clone()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated), rt.new_string('attribute'), rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count },
	]))
	mut var_cached_data := this.get_cache(var_transient_key.clone())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.clone()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		mut var_taxonomy_escaped := rt.call_function('esc_sql', [
			rt.call_function('wc_sanitize_taxonomy_name', [
				rt.new_string(attribute_to_count),
			]),
		])
		mut var_attribute_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT COUNT( DISTINCT posts.ID ) as term_count, terms.term_id as term_count_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' AS posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
			'term_relationships')),
			rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
			'term_taxonomy')),
			rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
			'terms')), rt.new_string(' AS terms USING( term_id )\n\t\t\t\tWHERE posts.ID IN ( ')),
			var_product_ids), rt.new_string(" )\n\t\t\t\tAND term_taxonomy.taxonomy = '")),
			var_taxonomy_escaped), rt.new_string("'\n\t\t\t\tGROUP BY terms.term_id\n\t\t\t"))).str())
		var_results = rt.call_method(var_wpdb, 'get_results', [
			var_attribute_count_sql.clone()])
		var_results = rt.call_function('array_map', [rt.new_string('absint'),
			rt.call_function('wp_list_pluck', [var_results.clone(),
				rt.new_string('term_count'), rt.new_string('term_count_id')])])
	}
	var_results = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_data'),
		var_results.clone(),
		rt.new_string('attribute'),
		var_query_vars_mutated,
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count }]),
	])
	this.set_cache(var_transient_key.clone(), var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_taxonomy_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, taxonomy_to_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_pre_product_filter_data'),
		rt.new_null(),
		rt.new_string('taxonomy'),
		var_query_vars_mutated,
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count }]),
	])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.clone().is_array())) {
		return var_pre_filter_counts.clone()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated), rt.new_string('taxonomy'), rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count },
	]))
	mut var_cached_data := this.get_cache(var_transient_key.clone())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.clone()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		mut var_taxonomy_escaped := rt.call_function('esc_sql', [
			rt.call_function('wc_sanitize_taxonomy_name', [
				rt.new_string(taxonomy_to_count),
			]),
		])
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.new_string(taxonomy_to_count),
		]))
		{
			var_results = this.get_hierarchical_taxonomy_counts(var_product_ids.str(),
				taxonomy_to_count)
		} else {
			mut var_taxonomy_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT COUNT( DISTINCT term_relationships.object_id ) as term_count, term_taxonomy.term_taxonomy_id as term_count_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'term_relationships')),
				rt.new_string(' AS term_relationships\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'term_taxonomy')),
				rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\t\t\tWHERE term_relationships.object_id IN ( ')),
				var_product_ids), rt.new_string(" )\n\t\t\t\t\tAND term_taxonomy.taxonomy = '")),
				var_taxonomy_escaped),
				rt.new_string("'\n\t\t\t\t\tGROUP BY term_taxonomy.term_taxonomy_id\n\t\t\t\t"))).str())
			mut var_base_results := rt.call_method(var_wpdb, 'get_results', [
				var_taxonomy_count_sql.clone()])
			var_results = rt.call_function('array_map', [rt.new_string('absint'),
				rt.call_function('wp_list_pluck', [var_base_results.clone(),
					rt.new_string('term_count'), rt.new_string('term_count_id')])])
		}
	}
	var_results = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_data'),
		var_results.clone(),
		rt.new_string('taxonomy'),
		var_query_vars_mutated,
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count }]),
	])
	this.set_cache(var_transient_key.clone(), var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_hierarchical_taxonomy_counts(product_ids string, taxonomy_name string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut product_ids_mutated := product_ids
	mut var_taxonomy_escaped := rt.call_function('esc_sql', [
		rt.call_function('wc_sanitize_taxonomy_name', [rt.new_string(taxonomy_name)]),
	])
	mut var_base_terms_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT DISTINCT tt.term_id, tt.term_taxonomy_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'term_relationships')), rt.new_string(' tr\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'term_taxonomy')),
		rt.new_string(' tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\tWHERE tr.object_id IN ( ')),
		rt.new_string(product_ids_mutated)), rt.new_string(" )\n\t\t\tAND tt.taxonomy = '")),
		var_taxonomy_escaped), rt.new_string("'\n\t\t"))).str())
	mut var_base_terms := rt.call_method(var_wpdb, 'get_results', [
		var_base_terms_sql.clone()])
	if !rt.is_true(var_base_terms) {
		return rt.new_array()
	}
	mut var_hierarchy_counts := rt.new_array()
	mut var_processed_terms := rt.new_array()
	mut iter_2 := var_base_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term := item_2.val
		mut var_term_id := rt.new_int((rt.get_property(var_term, 'term_id')).to_i64())
		if !(var_hierarchy_counts.array_isset(var_term_id)) {
			mut var_descendants := rt.call_method(this.taxonomy_hierarchy_data, 'get_descendants', [
				var_term_id.clone(),
				rt.new_string(taxonomy_name),
			])
			var_descendants.array_push(var_term_id.clone())
			var_hierarchy_counts.array_set(var_term_id, var_descendants.clone())
		}
		mut var_ancestors := rt.call_method(this.taxonomy_hierarchy_data, 'get_ancestors', [
			var_term_id.clone(),
			rt.new_string(taxonomy_name),
		])
		mut iter_3 := var_ancestors.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_ancestor_id := item_3.val
			if rt.is_true(rt.call_function('in_array', [var_ancestor_id.clone(),
				var_processed_terms.clone(), rt.new_bool(true)]))
			{
				continue
			}
			var_descendants = rt.call_method(this.taxonomy_hierarchy_data, 'get_descendants', [
				var_ancestor_id.clone(),
				rt.new_string(taxonomy_name),
			])
			var_descendants.array_push(var_ancestor_id.clone())
			var_hierarchy_counts.array_set(var_ancestor_id, var_descendants.clone())
			var_processed_terms.array_push(var_ancestor_id.clone())
		}
	}
	if !rt.is_true(var_hierarchy_counts) {
		return rt.new_array()
	}
	mut var_count_cases := rt.new_array()
	mut iter_4 := var_hierarchy_counts.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term_ids := item_4.val
		mut var_term_id := item_4.key
		mut var_term_ids_str := rt.call_function('implode', [
			rt.new_string(','),
			rt.call_function('array_map', [
				rt.new_string('absint'), var_term_ids.clone()])])
		var_count_cases.array_push('COUNT(DISTINCT CASE WHEN tt.term_id IN (${var_term_ids_str.to_string()}) THEN tr.object_id END) as count_${var_term_id.to_string()}')
	}
	mut var_batch_count_sql := rt.new_string('\n\t\t\tSELECT ' +
		(rt.call_function('implode', [rt.new_string(', '), var_count_cases.clone()])).str() +
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tFROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\tWHERE tr.object_id IN ( ')), rt.new_string(product_ids_mutated)), rt.new_string(" )\n\t\t\tAND tt.taxonomy = '")), var_taxonomy_escaped), rt.new_string("'\n\t\t")))
	mut var_count_result := rt.call_method(var_wpdb, 'get_row', [
		var_batch_count_sql.clone(), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_count_result) {
		return rt.new_array()
	}
	mut var_final_counts := rt.new_array()
	mut iter_5 := var_hierarchy_counts.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_term_ids := item_5.val
		mut var_term_id := item_5.key
		mut var_count_key := rt.new_string('count_${var_term_id.to_string()}')
		if var_count_result.array_isset(var_count_key)
			&& rt.is_true(rt.greater(var_count_result.array_get(var_count_key), rt.new_int(0))) {
			var_final_counts.array_set(var_term_id, rt.call_function('absint', [
				var_count_result.array_get(var_count_key),
			]))
		}
	}
	return var_final_counts.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_transient_key(var_query_vars rt.PhpVal, var_filter_type rt.PhpVal, var_extra rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	return rt.call_function('sprintf', [rt.new_string('wc_%s_%s'),
		Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group(),
		rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{
					key: 'query_vars'
					val: this.normalize_query_vars(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_query_vars_mutated))
				},
				rt.ArrayItem{ key: 'extra', val: var_extra },
				rt.ArrayItem{ key: 'filter_type', val: var_filter_type },
			]),
		]).to_string()))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) normalize_query_vars(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_p := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_taxonomy_set_params := rt.create_array([
		rt.ArrayItem{ key: none, val: 'categories' },
		rt.ArrayItem{ key: none, val: 'tags' },
		rt.ArrayItem{ key: none, val: 'brands' },
	])
	rt.call_function('ksort', [var_query_vars_mutated])
	mut iter_6 := var_query_vars_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		if !(var_key.clone().is_string()) || !(var_value.clone().is_string()) {
			continue
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_key.clone(), rt.new_string('filter_')]))
			|| rt.is_true(rt.identical(rt.new_string('rating_filter'), var_key))
			|| rt.is_true(rt.call_function('in_array', [var_key.clone(), var_taxonomy_set_params.clone(), rt.new_bool(true)])) {
			mut var_pieces := rt.call_function('array_map', [
				rt.new_string('trim'),
				rt.call_function('explode', [
					rt.new_string(','), var_value.clone()])])
			var_pieces = rt.call_function('array_map', [rt.new_string('strtolower'),
				var_pieces.clone()])
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_p := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_p)))
			}
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_p := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_p)))
			}
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_p := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_p)))
			}
			closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_p := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_p)))
			}
			var_pieces = rt.call_function('array_values', [
				rt.call_function('array_unique', [
					rt.call_function('array_filter', [var_pieces.clone(),
						rt.new_closure(closure_1_fn)]),
				]),
			])
			rt.call_function('sort', [var_pieces.clone()])
			var_query_vars_mutated.array_set(var_key, rt.call_function('implode', [
				rt.new_string(','),
				var_pieces.clone(),
			]))
		} else if rt.is_true(rt.call_function('str_starts_with', [
			var_key.clone(), rt.new_string('query_type_')]))
		{
			var_query_vars_mutated.array_set(var_key,
				var_value.clone().to_string().trim_space().to_lower())
		} else if rt.is_true(rt.identical(rt.new_string('min_price'), var_key))
			|| rt.is_true(rt.identical(rt.new_string('max_price'), var_key)) {
			var_query_vars_mutated.array_set(var_key, var_value.clone().to_string().trim_space())
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{},
		var_query_vars_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_cache(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		return rt.new_null()
	}
	mut var_cache := rt.call_function('get_transient', [var_key.clone()])
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 :=
		iife_temp_4.get_transient_version(Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())
	mut var_transient_version := iife_result_4
	if !rt.is_true(var_cache.array_get(rt.new_string('version')))
		|| !(var_cache.array_get(rt.new_string('value')).is_array())
		|| !rt.is_true(var_cache.array_get(rt.new_string('value')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_transient_version, var_cache.array_get(rt.new_string('version')))))) {
		return rt.new_null()
	}
	return var_cache.array_get(rt.new_string('value'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) set_cache(var_key rt.PhpVal, var_value rt.PhpVal) bool {
	if !(var_value.clone().is_array()) {
		return false
	}
	mut var_max_entries := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_filter_cache_max_entries'),
		rt.new_int(1000),
	])).to_i64())
	if rt.is_true(rt.greater(var_max_entries, rt.new_int(0))) {
		mut var_count := rt.new_int((rt.call_function('get_transient', [
			Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_entry_count_transient(),
		])).to_i64())
		if rt.is_true(rt.greater_equal(var_count, var_max_entries)) {
			return false
		}
		rt.call_function('set_transient', [
			Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_entry_count_transient(),
			rt.add(var_count, rt.new_int(1)),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 :=
		iife_temp_5.get_transient_version(Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())
	mut var_transient_version := iife_result_5
	mut var_transient_value := rt.create_array([
		rt.ArrayItem{ key: 'version', val: var_transient_version },
		rt.ArrayItem{ key: 'value', val: var_value },
	])
	return (rt.call_function('set_transient', [var_key.clone(),
		var_transient_value.clone(), rt.get_constant('DAY_IN_SECONDS')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_cached_product_ids(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut iife_temp_6 := Class_WC_Cache_Helper{}
	mut iife_result_6 :=
		iife_temp_6.get_cache_prefix(Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())
	mut var_cache_key := rt.new_string(iife_result_6.str() +
		md5.hexhash(rt.call_function('wp_json_encode', [this.normalize_query_vars(mut var_query_vars_mutated)]).to_string()))
	mut var_cache := rt.call_function('wp_cache_get', [var_cache_key.clone()])
	if rt.is_true(var_cache) {
		return var_cache.clone()
	}
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.query_clauses },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', -1)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_internal_productfilters_wp_query()
	var_query.query(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array',
		[]string{}, var_query_vars_mutated))
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.query_clauses },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.get_property(var_query, 'request'),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_results)))) {
		var_results = rt.new_array()
	}
	var_results = rt.call_function('implode', [rt.new_string(','),
		rt.call_function('array_column', [var_results.clone(),
			rt.new_string('ID')])])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_results.clone()])
	return var_results.clone()
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfilters_filterdata(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData{
		PhpObjectBase:           rt.PhpObjectBase{}
		query_clauses:           rt.new_null()
		taxonomy_hierarchy_data: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfilters_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_filtered_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_filtered_price(mut dispatch_arg_0)
		}
		'get_stock_status_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_stock_status_counts(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_rating_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_rating_counts(mut dispatch_arg_0)
		}
		'get_attribute_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_attribute_counts(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_taxonomy_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_taxonomy_counts(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_hierarchical_taxonomy_counts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_hierarchical_taxonomy_counts(dispatch_arg_0, dispatch_arg_1)
		}
		'get_transient_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_transient_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'normalize_query_vars' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.normalize_query_vars(mut dispatch_arg_0)
		}
		'get_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cache(dispatch_arg_0)
		}
		'set_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_cache(dispatch_arg_0, dispatch_arg_1))
		}
		'get_cached_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_cached_product_ids(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_clauses' { return this.query_clauses }
		'taxonomy_hierarchy_data' { return this.taxonomy_hierarchy_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_clauses' {
			this.query_clauses = val
			return true
		}
		'taxonomy_hierarchy_data' {
			this.taxonomy_hierarchy_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
