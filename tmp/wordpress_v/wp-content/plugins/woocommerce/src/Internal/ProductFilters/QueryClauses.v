import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses {
	rt.PhpObjectBase
pub mut:
		params rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) init(mut var_params Class_Automattic_WooCommerce_Internal_ProductFilters_Params)  {
	this.params = var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_query_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_wp_query Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(var_wp_query.get(rt.new_string('filter_stock_status'))) {
		mut var_stock_statuses := rt.new_string(rt.new_string(var_wp_query.get(rt.new_string('filter_stock_status')).to_string().trim_space()))
		var_stock_statuses = rt.call_function('explode', [rt.new_string(','), var_stock_statuses.dup()])
		var_args_mutated = this.add_stock_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_stock_statuses))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_wp_query.get(rt.new_string('min_price'))) || rt.is_true(var_wp_query.get(rt.new_string('max_price'))))) {
		mut var_price_range := rt.create_array([rt.ArrayItem{ key: 'min_price', val: var_wp_query.get(rt.new_string('min_price')) }, rt.ArrayItem{ key: 'max_price', val: var_wp_query.get(rt.new_string('max_price')) }])
		var_price_range = rt.call_function('array_filter', [var_price_range.dup()])
		var_args_mutated = this.add_price_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_price_range))
	}
	var_args_mutated = this.add_attribute_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	var_args_mutated = this.add_taxonomy_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_taxonomies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_query_clauses_for_main_query(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_wp_query Class_Automattic_WooCommerce_Internal_ProductFilters_WP_Query) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_wp_query.is_main_query())))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	if rt.is_true(var_wp_query.get(rt.new_string('filter_stock_status'))) {
		mut var_stock_statuses := rt.new_string(rt.new_string(var_wp_query.get(rt.new_string('filter_stock_status')).to_string().trim_space()))
		var_stock_statuses = rt.call_function('explode', [rt.new_string(','), var_stock_statuses.dup()])
		var_stock_statuses = rt.call_function('array_filter', [var_stock_statuses.dup()])
		var_args_mutated = this.add_stock_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](var_stock_statuses))
	}
	var_args_mutated = this.add_taxonomy_clauses(mut var_args_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](this.get_chosen_taxonomies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_array](rt.get_property(var_wp_query, 'query_vars')))))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) add_stock_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductFilters_array, mut var_stock_statuses Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_stock_statuses_mutated := var_stock_statuses
	var_stock_statuses_mutated = rt.call_function('array_filter', [var_stock_statuses_mutated.dup()])
	if !rt.is_true(var_stock_statuses_mutated) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_filtered_stock_statuses := rt.call_function('array_intersect', [rt.call_function('array_map', [rt.new_string('esc_sql'), var_stock_statuses_mutated.dup()]), rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))])
	if !(!rt.is_true(var_filtered_stock_statuses)) {
		var_args_mutated.array_set('join', this.append_product_sorting_table_join((var_args_mutated.array_get('join')).str()))
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(!rt.is_true(var_stock_statuses_mutated)) && !rt.is_true(var_filtered_stock_statuses) {
		// unsupported expression: Expr_AssignOp_Concat
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
	// unsupported statement: Stmt_Global
	mut var_adjust_for_taxes := rt.new_bool(this.should_adjust_price_filters_for_displayed_taxes())
	var_args_mutated.array_set('join', this.append_product_sorting_table_join((var_args_mutated.array_get('join')).str()))
	if var_price_range_mutated.array_isset(rt.new_string('min_price')) {
		mut var_min_price_filter := rt.new_int(rt.new_int(var_price_range_mutated.array_get('min_price').to_i64()))
		if rt.is_true(var_adjust_for_taxes) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if var_price_range_mutated.array_isset(rt.new_string('max_price')) {
		mut var_max_price_filter := rt.new_int(rt.new_int(var_price_range_mutated.array_get('max_price').to_i64()))
		if rt.is_true(var_adjust_for_taxes) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
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
	// unsupported statement: Stmt_Global
	mut var_clause_root := rt.new_string(rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID IN ( SELECT product_or_parent_id FROM (')))
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
		mut var_in_stock_clause := rt.new_string(rt.new_string(' AND in_stock = 1'))
	} else {
		var_in_stock_clause = rt.new_string(rt.new_string(''))
	}
	mut var_attribute_ids_for_and_filtering := rt.new_array()
	mut var_clauses := rt.new_array()
	mut var_all_terms_slugs := rt.new_array()
	{
		mut iter_1 := var_chosen_attributes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_data.array_get('terms'))) && rt.is_true(rt.new_bool(var_data.array_get('terms').is_array())))) {
				var_all_terms_slugs = rt.call_function('array_merge', [var_all_terms_slugs.dup(), var_data.array_get('terms')])
			}
		}
	}
	mut var_all_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_chosen_attributes_mutated.dup()) }, rt.ArrayItem{ key: 'slug', val: var_all_terms_slugs }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_all_terms.dup()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_terms_by_taxonomy := rt.new_array()
	{
		mut iter_1 := var_all_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_terms_by_taxonomy.array_get_mut(rt.get_property(var_term, 'taxonomy')).array_push(var_term.dup())
		}
	}
	{
		mut iter_1 := var_chosen_attributes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_taxonomy := item_1.key
			mut var_current_attribute_terms := if !(var_terms_by_taxonomy.array_get(var_taxonomy)).is_null() { var_terms_by_taxonomy.array_get(var_taxonomy) } else { rt.new_array() }
			mut var_term_ids_by_slug := rt.call_function('wp_list_pluck', [var_current_attribute_terms.dup(), rt.new_string('term_id'), rt.new_string('slug')])
			mut var_term_ids_to_filter_by := rt.call_function('array_values', [rt.call_function('array_intersect_key', [var_term_ids_by_slug.dup(), rt.call_function('array_flip', [var_data.array_get('terms')])])])
			var_term_ids_to_filter_by = rt.call_function('array_map', [rt.new_string('absint'), var_term_ids_to_filter_by.dup()])
			mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_term_ids_to_filter_by.dup()])).str() + ')')
			mut var_is_and_query := rt.identical(rt.new_string('and'), rt.new_string(var_data.array_get('query_type').to_string().to_lower()))
			mut var_count := rt.new_int(rt.new_int(var_term_ids_to_filter_by.dup().array_count()))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				if rt.is_true(rt.new_bool(rt.is_true(var_is_and_query) && rt.is_true(rt.greater(var_count, rt.new_int(1))))) {
					var_attribute_ids_for_and_filtering = rt.call_function('array_merge', [var_attribute_ids_for_and_filtering.dup(), var_term_ids_to_filter_by.dup()])
				} else {
					var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\t\t\t\tSELECT product_or_parent_id\n\t\t\t\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\t\t\t\tWHERE term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\t\t\t)')))
				}
			}
		}
	}
	if !(!rt.is_true(var_attribute_ids_for_and_filtering)) {
		mut var_count := rt.new_int(rt.new_int(var_attribute_ids_for_and_filtering.dup().array_count()))
		mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_attribute_ids_for_and_filtering.dup()])).str() + ')')
		var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=0\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\tGROUP BY product_id\n\t\t\t\tHAVING COUNT(product_id)=')), var_count), rt.new_string('\n\t\t\t\tUNION\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.get_lookup_table_name()), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=1\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t)')))
	}
	if !(!rt.is_true(var_clauses)) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if !(!rt.is_true(var_chosen_attributes_mutated)) {
		// unsupported expression: Expr_AssignOp_Concat
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
	// unsupported statement: Stmt_Global
	mut var_tax_queries := rt.new_array()
	mut var_all_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_chosen_taxonomies_mutated.dup()) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('array_merge', [rt.call_function('array_values', [var_chosen_taxonomies_mutated.dup()])]) }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_all_terms.dup()])) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, var_args_mutated)
	}
	mut var_term_ids_by_taxonomy := rt.new_array()
	{
		mut iter_1 := var_all_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_term_ids_by_taxonomy.array_get_mut(rt.get_property(var_term, 'taxonomy')).array_push(rt.get_property(var_term, 'term_id'))
		}
	}
	{
		mut iter_1 := var_term_ids_by_taxonomy.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term_ids := item_1.val
			mut var_taxonomy := item_1.key
			if !rt.is_true(var_term_ids) {
				continue
			}
			if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()])) {
				mut var_expanded_term_ids := var_term_ids.dup()
				{
					mut iter_2 := var_term_ids.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_term_id := item_2.val
						mut var_cache_key := rt.new_string((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())).str() + 'child_terms_' + (var_taxonomy).str() + '_' + (var_term_id).str())
						mut var_children := rt.call_function('wp_cache_get', [var_cache_key.dup()])
						if rt.is_true(rt.identical(rt.new_bool(false), var_children)) {
							var_children = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'child_of', val: var_term_id }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
							if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_children.dup()]))))) {
								rt.call_function('wp_cache_set', [var_cache_key.dup(), var_children.dup(), rt.new_string(''), rt.get_constant('HOUR_IN_SECONDS')])
							} else {
								var_children = rt.new_array()
							}
						}
						var_expanded_term_ids = rt.call_function('array_merge', [var_expanded_term_ids.dup(), var_children.dup()])
					}
				}
				var_term_ids = rt.call_function('array_unique', [var_expanded_term_ids.dup()])
			}
			mut var_term_ids_list := rt.new_string('(' + (rt.call_function('implode', [, ])).str() + ')')
			var_tax_queries.array_push(rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(, ), ), ), ), ), ), ), ), var_taxonomy.dup()]))
		}
	}
	if !(!rt.is_true(var_tax_queries)) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_array', []string{}, )
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) append_product_sorting_table_join(sql string) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) should_adjust_price_filters_for_displayed_taxes() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_price_filter_query_for_displayed_taxes(price_filter f64, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) adjust_price_filter_for_tax_class(price_filter f64, tax_class string) f64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_chosen_attributes(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_chosen_taxonomies(mut var_query_vars Class_Automattic_WooCommerce_Internal_ProductFilters_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses) get_lookup_table_name() string {
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfilters_queryclauses() &Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses{
		PhpObjectBase: rt.PhpObjectBase{}
		params: rt.new_null()
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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




pub fn init_wp_content_plugins_woocommerce_src_internal_productfilters_queryclauses_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
