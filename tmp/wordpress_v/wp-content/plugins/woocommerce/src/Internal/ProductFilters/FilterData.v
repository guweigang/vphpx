import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	rt.PhpObjectBase
pub mut:
		query_clauses rt.PhpVal = rt.new_null()
		taxonomy_hierarchy_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) construct(mut var_query_clauses Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator, mut var_taxonomy_hierarchy_data Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData)  {
	this.query_clauses = var_query_clauses.dup()
	this.taxonomy_hierarchy_data = var_taxonomy_hierarchy_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_filtered_price(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_product_filter_data'), rt.new_null(), rt.new_string('price'), var_query_vars_mutated.dup(), rt.new_array()])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.dup().is_array())) {
		return var_pre_filter_counts.dup()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_query_vars_mutated), rt.new_string('price'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.dup())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.dup()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		// unsupported statement: Stmt_Global
		mut var_price_filter_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\t\tFROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')), var_product_ids), rt.new_string(' )\n\t\t\t')))
		var_results = rt.cast_array(rt.call_method(var_wpdb, 'get_row', [var_price_filter_sql.dup()]))
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_filter_data'), var_results.dup(), rt.new_string('price'), var_query_vars_mutated.dup(), rt.new_array()])
	this.set_cache(var_transient_key.dup(), var_results.dup())
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_stock_status_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_statuses Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_product_filter_data'), rt.new_null(), rt.new_string('stock'), var_query_vars_mutated.dup(), rt.new_array()])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.dup().is_array())) {
		return var_pre_filter_counts.dup()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_query_vars_mutated), rt.new_string('stock'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.dup())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.dup()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		// unsupported statement: Stmt_Global
		{
			mut iter_1 := var_statuses.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_status := item_1.val
				mut var_stock_status_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT COUNT( DISTINCT posts.ID ) as status_count\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' as postmeta ON posts.ID = postmeta.post_id\n\t\t\t\t\tAND postmeta.meta_key = \'_stock_status\'\n\t\t\t\t\tAND postmeta.meta_value = \'')) + (rt.call_function('esc_sql', [var_status.dup()])).str() + "'\n\t\t\t\t\tWHERE posts.ID IN ( ${var_product_ids.to_string()} )\n\t\t\t\t")
				mut var_result := rt.call_method(var_wpdb, 'get_row', [var_stock_status_count_sql.dup()])
				var_results.array_set(var_status, rt.get_property(var_result, 'status_count'))
			}
		}
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_filter_data'), var_results.dup(), rt.new_string('stock'), var_query_vars_mutated.dup(), rt.new_array()])
	this.set_cache(var_transient_key.dup(), var_results.dup())
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_rating_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_product_filter_data'), rt.new_null(), rt.new_string('rating'), var_query_vars_mutated.dup(), rt.new_array()])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.dup().is_array())) {
		return var_pre_filter_counts.dup()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_query_vars_mutated), rt.new_string('rating'), rt.new_null())
	mut var_cached_data := this.get_cache(var_transient_key.dup())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.dup()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		// unsupported statement: Stmt_Global
		mut var_rating_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT COUNT( DISTINCT product_id ) as product_count, ROUND( average_rating, 0 ) as rounded_average_rating\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string('\n\t\t\t\tWHERE product_id IN ( ')), var_product_ids), rt.new_string(' )\n\t\t\t\tAND average_rating > 0\n\t\t\t\tGROUP BY rounded_average_rating\n\t\t\t\tORDER BY rounded_average_rating DESC\n\t\t\t')))
		var_results = rt.call_method(var_wpdb, 'get_results', [var_rating_count_sql.dup()])
		var_results = rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_results.dup(), rt.new_string('product_count'), rt.new_string('rounded_average_rating')])])
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_filter_data'), var_results.dup(), rt.new_string('rating'), var_query_vars_mutated.dup(), rt.new_array()])
	this.set_cache(var_transient_key.dup(), var_results.dup())
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_attribute_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, attribute_to_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_product_filter_data'), rt.new_null(), rt.new_string('attribute'), var_query_vars_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count }])])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.dup().is_array())) {
		return var_pre_filter_counts.dup()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_query_vars_mutated), rt.new_string('attribute'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count }]))
	mut var_cached_data := this.get_cache(var_transient_key.dup())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.dup()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		// unsupported statement: Stmt_Global
		mut var_taxonomy_escaped := rt.call_function('esc_sql', [rt.call_function('wc_sanitize_taxonomy_name', [rt.new_string(attribute_to_count)])])
		mut var_attribute_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT COUNT( DISTINCT posts.ID ) as term_count, terms.term_id as term_count_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS terms USING( term_id )\n\t\t\t\tWHERE posts.ID IN ( ')), var_product_ids), rt.new_string(' )\n\t\t\t\tAND term_taxonomy.taxonomy = \'')), var_taxonomy_escaped), rt.new_string('\'\n\t\t\t\tGROUP BY terms.term_id\n\t\t\t')))
		var_results = rt.call_method(var_wpdb, 'get_results', [var_attribute_count_sql.dup()])
		var_results = rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_results.dup(), rt.new_string('term_count'), rt.new_string('term_count_id')])])
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_filter_data'), var_results.dup(), rt.new_string('attribute'), var_query_vars_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: attribute_to_count }])])
	this.set_cache(var_transient_key.dup(), var_results.dup())
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_taxonomy_counts(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array, taxonomy_to_count string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_pre_filter_counts := rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_product_filter_data'), rt.new_null(), rt.new_string('taxonomy'), var_query_vars_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count }])])
	if rt.is_true(rt.new_bool(var_pre_filter_counts.dup().is_array())) {
		return var_pre_filter_counts.dup()
	}
	mut var_transient_key := this.get_transient_key(rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_query_vars_mutated), rt.new_string('taxonomy'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count }]))
	mut var_cached_data := this.get_cache(var_transient_key.dup())
	if !(!rt.is_true(var_cached_data)) {
		return var_cached_data.dup()
	}
	mut var_results := rt.new_array()
	mut var_product_ids := this.get_cached_product_ids(mut var_query_vars_mutated)
	if rt.is_true(var_product_ids) {
		// unsupported statement: Stmt_Global
		mut var_taxonomy_escaped := rt.call_function('esc_sql', [rt.call_function('wc_sanitize_taxonomy_name', [rt.new_string(taxonomy_to_count)])])
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.new_string(taxonomy_to_count)])) {
			var_results = this.get_hierarchical_taxonomy_counts((var_product_ids).str(), taxonomy_to_count)
		} else {
			mut var_taxonomy_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT COUNT( DISTINCT term_relationships.object_id ) as term_count, term_taxonomy.term_taxonomy_id as term_count_id\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\t\t\tWHERE term_relationships.object_id IN ( ')), var_product_ids), rt.new_string(' )\n\t\t\t\t\tAND term_taxonomy.taxonomy = \'')), var_taxonomy_escaped), rt.new_string('\'\n\t\t\t\t\tGROUP BY term_taxonomy.term_taxonomy_id\n\t\t\t\t')))
			mut var_base_results := rt.call_method(var_wpdb, 'get_results', [var_taxonomy_count_sql.dup()])
			var_results = rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_base_results.dup(), rt.new_string('term_count'), rt.new_string('term_count_id')])])
		}
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_filter_data'), var_results.dup(), rt.new_string('taxonomy'), var_query_vars_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy_to_count }])])
	this.set_cache(var_transient_key.dup(), var_results.dup())
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_hierarchical_taxonomy_counts(product_ids string, taxonomy_name string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut product_ids_mutated := product_ids
	// unsupported statement: Stmt_Global
	mut var_taxonomy_escaped := rt.call_function('esc_sql', [rt.call_function('wc_sanitize_taxonomy_name', [rt.new_string(taxonomy_name)])])
	mut var_base_terms_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT DISTINCT tt.term_id, tt.term_taxonomy_id\n\t\t\tFROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\tWHERE tr.object_id IN ( ')), rt.new_string(product_ids_mutated)), rt.new_string(' )\n\t\t\tAND tt.taxonomy = \'')), var_taxonomy_escaped), rt.new_string('\'\n\t\t')))
	mut var_base_terms := rt.call_method(var_wpdb, 'get_results', [var_base_terms_sql.dup()])
	if !rt.is_true(var_base_terms) {
		return rt.new_array()
	}
	mut var_hierarchy_counts := rt.new_array()
	mut var_processed_terms := rt.new_array()
	{
		mut iter_1 := var_base_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_term_id := // unsupported expression: Expr_Cast_Int
			if !(var_hierarchy_counts.array_isset(var_term_id)) {
				mut var_descendants := rt.call_method(this.taxonomy_hierarchy_data, 'get_descendants', [var_term_id.dup(), rt.new_string(taxonomy_name)])
				var_descendants.array_push(var_term_id.dup())
				var_hierarchy_counts.array_set(var_term_id, var_descendants.dup())
			}
			mut var_ancestors := rt.call_method(this.taxonomy_hierarchy_data, 'get_ancestors', [var_term_id.dup(), rt.new_string(taxonomy_name)])
			{
				mut iter_2 := var_ancestors.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_ancestor_id := item_2.val
					if rt.is_true(rt.call_function('in_array', [var_ancestor_id.dup(), var_processed_terms.dup(), rt.new_bool(true)])) {
						continue
					}
					var_descendants = rt.call_method(, 'get_descendants', [.dup(), ])
					.array_push(.dup())
					
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_transient_key(var_query_vars rt.PhpVal, var_filter_type rt.PhpVal, var_extra rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) normalize_query_vars(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_p := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_cache(var_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) set_cache(var_key rt.PhpVal, var_value rt.PhpVal) bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) get_cached_product_ids(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
}

fn create_automattic_woocommerce_internal_productfilters_filterdata(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData{
		PhpObjectBase: rt.PhpObjectBase{}
		query_clauses: rt.new_null()
		taxonomy_hierarchy_data: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_filtered_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_filtered_price(mut dispatch_arg_0)
		}
		'get_stock_status_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_stock_status_counts(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_rating_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_rating_counts(mut dispatch_arg_0)
		}
		'get_attribute_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_attribute_counts(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_taxonomy_counts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_cached_product_ids(mut dispatch_arg_0)
		}
		else { return none }
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
		'query_clauses' { this.query_clauses = val; return true }
		'taxonomy_hierarchy_data' { this.taxonomy_hierarchy_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productfilters_filterdata_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
