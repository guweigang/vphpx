import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer {
	rt.PhpObjectBase
pub mut:
		data_store rt.PhpVal = rt.new_null()
		lookup_table_name rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) init(mut var_data_store Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore)  {
	this.data_store = var_data_store.dup()
	this.lookup_table_name = var_data_store.get_lookup_table_name()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) filtering_via_lookup_table_is_active() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_enabled')]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) filter_by_attribute_post_clauses(mut var_args Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array, mut var_wp_query Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Query, mut var_attributes_to_filter_by Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_attributes_to_filter_by_mutated := var_attributes_to_filter_by
	// unsupported statement: Stmt_Global
	mut var_enable_filtering := rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_post_clause_filtering'), var_wp_query.is_main_query(), var_wp_query])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_enable_filtering)))) || rt.is_true(rt.new_bool(!(rt.is_true(this.filtering_via_lookup_table_is_active())))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array', []string{}, var_args)
	}
	mut var_clause_root := rt.new_string(rt.concat(rt.concat(rt.new_string(' '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID IN ( SELECT product_or_parent_id FROM (')))
	mut var_hide_out_of_stock := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_attributes_filterer_hide_out_of_stock'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))])
	if rt.is_true(var_hide_out_of_stock) {
		mut var_in_stock_clause := rt.new_string(rt.new_string(' AND in_stock = 1'))
	} else {
		var_in_stock_clause = rt.new_string(rt.new_string(''))
	}
	mut var_attribute_ids_for_and_filtering := rt.new_array()
	mut var_clauses := rt.new_array()
	{
		mut iter_1 := var_attributes_to_filter_by_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_taxonomy := item_1.key
			mut var_all_terms := rt.call_function('get_terms', [var_taxonomy.dup(), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }])])
			mut var_term_ids_by_slug := rt.call_function('wp_list_pluck', [var_all_terms.dup(), rt.new_string('term_id'), rt.new_string('slug')])
			mut var_term_ids_to_filter_by := rt.call_function('array_values', [rt.call_function('array_intersect_key', [var_term_ids_by_slug.dup(), rt.call_function('array_flip', [var_data.array_get('terms')])])])
			var_term_ids_to_filter_by = rt.call_function('array_map', [rt.new_string('absint'), var_term_ids_to_filter_by.dup()])
			mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_term_ids_to_filter_by.dup()])).str() + ')')
			mut var_is_and_query := rt.identical(rt.new_string('and'), var_data.array_get('query_type'))
			mut var_count := rt.new_int(rt.new_int(var_term_ids_to_filter_by.dup().array_count()))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				if rt.is_true(rt.new_bool(rt.is_true(var_is_and_query) && rt.is_true(rt.greater(var_count, rt.new_int(1))))) {
					var_attribute_ids_for_and_filtering = rt.call_function('array_merge', [var_attribute_ids_for_and_filtering.dup(), var_term_ids_to_filter_by.dup()])
				} else {
					var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\t\t\t\tSELECT product_or_parent_id\n\t\t\t\t\t\t\tFROM ')), this.lookup_table_name), rt.new_string(' lt\n\t\t\t\t\t\t\tWHERE term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\t\t\t)')))
				}
			}
		}
	}
	if !(!rt.is_true(var_attribute_ids_for_and_filtering)) {
		mut var_count := rt.new_int(rt.new_int(var_attribute_ids_for_and_filtering.dup().array_count()))
		mut var_term_ids_to_filter_by_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_attribute_ids_for_and_filtering.dup()])).str() + ')')
		var_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t'), var_clause_root), rt.new_string('\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.lookup_table_name), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=0\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\tGROUP BY product_id\n\t\t\t\tHAVING COUNT(product_id)=')), var_count), rt.new_string('\n\t\t\t\tUNION\n\t\t\t\tSELECT product_or_parent_id\n\t\t\t\tFROM ')), this.lookup_table_name), rt.new_string(' lt\n\t\t\t\tWHERE is_variation_attribute=1\n\t\t\t\t')), var_in_stock_clause), rt.new_string('\n\t\t\t\tAND term_id in ')), var_term_ids_to_filter_by_list), rt.new_string('\n\t\t\t\tGROUP BY product_or_parent_id\n\t\t\t\tHAVING COUNT(DISTINCT term_id)=')), var_count), rt.new_string('\n\t\t\t)')))
	}
	if !(!rt.is_true(var_clauses)) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if !(!rt.is_true(var_attributes_to_filter_by_mutated)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array', []string{}, var_args)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) get_filtered_term_product_counts(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_use_lookup_table := this.filtering_via_lookup_table_is_active()
	mut var_tax_query := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{}; return temp.get_main_tax_query() }()
	mut var_meta_query := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{}; return temp.get_main_meta_query() }()
	if rt.is_true(rt.identical(rt.new_string('or'), var_query_type)) {
		{
			mut iter_1 := var_tax_query.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_query := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_query.dup().is_array())) && rt.is_true(rt.identical(var_taxonomy, var_query.array_get('taxonomy'))))) {
					var_tax_query.array_unset(var_key)
				}
			}
		}
	}
	var_meta_query = create_automattic_woocommerce_internal_productattributeslookup_wp_meta_query(var_meta_query.dup())
	var_tax_query = create_automattic_woocommerce_internal_productattributeslookup_wp_tax_query(var_tax_query.dup())
	if rt.is_true(var_use_lookup_table) {
		mut var_query := this.get_product_counts_query_using_lookup_table(var_tax_query.dup(), var_meta_query.dup(), var_taxonomy.dup(), var_term_ids.dup())
	} else {
		var_query = this.get_product_counts_query_not_using_lookup_table(var_tax_query.dup(), var_meta_query.dup(), var_term_ids.dup())
	}
	var_query = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_filtered_term_product_counts_query'), var_query.dup()])
	mut var_query_sql := rt.call_function('implode', [rt.new_string(' '), var_query.dup()])
	mut var_query_hash := rt.new_string(rt.new_string(md5.hexhash(var_query_sql.dup().to_string())))
	mut var_cache := rt.call_function('apply_filters', [rt.new_string('woocommerce_layered_nav_count_maybe_cache'), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(true), var_cache)) {
		mut var_cached_counts := rt.cast_array(rt.call_function('get_transient', ['wc_layered_nav_counts_' + (rt.call_function('sanitize_title', [var_taxonomy.dup()])).str()]))
	} else {
		var_cached_counts = rt.new_array()
	}
	if !(var_cached_counts.array_isset(var_query_hash)) {
		mut var_results := rt.call_method(var_wpdb, 'get_results', [var_query_sql.dup(), rt.get_constant('ARRAY_A')])
		mut var_counts := rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_results.dup(), rt.new_string('term_count'), rt.new_string('term_count_id')])])
		var_cached_counts.array_set(var_query_hash, var_counts.dup())
		if rt.is_true(rt.identical(rt.new_bool(true), var_cache)) {
			rt.call_function('set_transient', ['wc_layered_nav_counts_' + (rt.call_function('sanitize_title', [var_taxonomy.dup()])).str(), var_cached_counts.dup(), rt.get_constant('DAY_IN_SECONDS')])
		}
	}
	return rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(var_cached_counts.array_get(var_query_hash))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) get_product_counts_query_using_lookup_table(var_tax_query rt.PhpVal, var_meta_query rt.PhpVal, var_taxonomy rt.PhpVal, var_term_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_query_mutated := var_tax_query
	mut var_meta_query_mutated := var_meta_query
	// unsupported statement: Stmt_Global
	mut var_meta_query_sql := rt.call_method(var_meta_query_mutated, 'get_sql', [rt.new_string('post'), this.lookup_table_name, rt.new_string('product_or_parent_id')])
	mut var_tax_query_sql := rt.call_method(var_tax_query_mutated, 'get_sql', [this.lookup_table_name, rt.new_string('product_or_parent_id')])
	mut var_hide_out_of_stock := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_attributes_filterer_hide_out_of_stock'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))])
	mut var_in_stock_clause := rt.new_string(if rt.is_true(var_hide_out_of_stock) { rt.new_string(' AND in_stock = 1') } else { rt.new_string('') })
	mut var_query := rt.new_array()
	var_query.array_set('select', 'SELECT COUNT(DISTINCT product_or_parent_id) as term_count, term_id as term_count_id')
	var_query.array_set('from', rt.concat(rt.new_string('FROM '), this.lookup_table_name))
	var_query.array_set('join', rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t'), var_tax_query_sql.array_get('join')), rt.new_string(' ')), var_meta_query_sql.array_get('join')), rt.new_string('\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), this.lookup_table_name), rt.new_string('.product_or_parent_id')))
	mut var_encoded_taxonomy := rt.call_function('sanitize_title', [var_taxonomy.dup()])
	mut var_term_ids_sql := rt.new_string(this.get_term_ids_sql(var_term_ids.dup()))
	var_query.array_set('where', rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tWHERE '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type IN ( \'product\' )\n\t\t\tAND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'publish\'\n\t\t\t')), var_tax_query_sql.array_get('where')), rt.new_string(' ')), var_meta_query_sql.array_get('where')), rt.new_string('\n\t\t\tAND ')), this.lookup_table_name), rt.new_string('.taxonomy=\'')), var_encoded_taxonomy), rt.new_string('\'\n\t\t\tAND ')), this.lookup_table_name), rt.new_string('.term_id IN ')), var_term_ids_sql), rt.new_string('\n\t\t\t')), var_in_stock_clause))
	if !(!rt.is_true(var_term_ids)) {
		mut var_attributes_to_filter_by := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
		if !(!rt.is_true(var_attributes_to_filter_by)) {
			mut var_and_term_ids := rt.new_array()
			{
				mut iter_1 := var_attributes_to_filter_by.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_data := item_1.val
					mut var_taxonomy_shadow := item_1.key
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						continue
					}
					mut var_all_terms := rt.call_function('get_terms', [var_taxonomy_shadow.dup(), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }])])
					mut var_term_ids_by_slug := rt.call_function('wp_list_pluck', [var_all_terms.dup(), rt.new_string('term_id'), rt.new_string('slug')])
					mut var_term_ids_to_filter_by := rt.call_function('array_values', [rt.call_function('array_intersect_key', [var_term_ids_by_slug.dup(), rt.call_function('array_flip', [var_data.array_get('terms')])])])
					var_and_term_ids = rt.call_function('array_merge', [var_and_term_ids.dup(), var_term_ids_to_filter_by.dup()])
				}
			}
			if !(!rt.is_true(var_and_term_ids)) {
				mut var_terms_count := rt.new_int(rt.new_int(var_and_term_ids.dup().array_count()))
				mut var_term_ids_list := rt.new_string('(' + (rt.call_function('join', [rt.new_string(','), var_and_term_ids.dup()])).str() + ')')
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else if rt.is_true(var_hide_out_of_stock) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_search_query_sql := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{}; return temp.get_main_search_query_sql() }()
	if rt.is_true(var_search_query_sql) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_query.array_set('group_by', 'GROUP BY terms.term_id')
	var_query.array_set('group_by', rt.concat(rt.concat(rt.new_string('GROUP BY '), this.lookup_table_name), rt.new_string('.term_id')))
	return var_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) get_product_counts_query_not_using_lookup_table(var_tax_query rt.PhpVal, var_meta_query rt.PhpVal, var_term_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_query_mutated := var_tax_query
	mut var_meta_query_mutated := var_meta_query
	// unsupported statement: Stmt_Global
	mut var_meta_query_sql := rt.call_method(var_meta_query_mutated, 'get_sql', [rt.new_string('post'), rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_tax_query_sql := rt.call_method(var_tax_query_mutated, 'get_sql', [rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_query := rt.new_array()
	var_query.array_set('select', rt.concat(rt.concat(rt.new_string('SELECT COUNT( DISTINCT '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID ) AS term_count, terms.term_id AS term_count_id')))
	var_query.array_set('from', rt.concat(rt.new_string('FROM '), rt.get_property(var_wpdb, 'posts')))
	var_query.array_set('join', rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tINNER JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = term_relationships.object_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS terms USING( term_id )\n\t\t\t')) + (var_tax_query_sql.array_get('join')).str() + (var_meta_query_sql.array_get('join')).str())
	mut var_term_ids_sql := rt.new_string(this.get_term_ids_sql(var_term_ids.dup()))
	var_query.array_set('where', rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tWHERE '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type IN ( \'product\' )\n\t\t\tAND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'publish\'\n\t\t\t')), var_tax_query_sql.array_get('where')), rt.new_string(' ')), var_meta_query_sql.array_get('where')), rt.new_string('\n\t\t\tAND terms.term_id IN ')), var_term_ids_sql))
	mut var_search_query_sql := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{}; return temp.get_main_search_query_sql() }()
	if rt.is_true(var_search_query_sql) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_query.array_set('group_by', 'GROUP BY terms.term_id')
	return var_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) get_term_ids_sql(var_term_ids rt.PhpVal) string {
	return '(' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [, .dup()])])).str() + ')'
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productattributeslookup_filterer() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer{
		PhpObjectBase: rt.PhpObjectBase{}
		data_store: rt.new_null()
		lookup_table_name: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wc_query() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wp_meta_query() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_wp_tax_query() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'filtering_via_lookup_table_is_active' {
			return this.filtering_via_lookup_table_is_active()
		}
		'filter_by_attribute_post_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.filter_by_attribute_post_clauses(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_filtered_term_product_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_filtered_term_product_counts(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_product_counts_query_using_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_product_counts_query_using_lookup_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_product_counts_query_not_using_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_product_counts_query_not_using_lookup_table(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_term_ids_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_term_ids_sql(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store' { return this.data_store }
		'lookup_table_name' { return this.lookup_table_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store' { this.data_store = val; return true }
		'lookup_table_name' { this.lookup_table_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productattributeslookup_filterer_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
