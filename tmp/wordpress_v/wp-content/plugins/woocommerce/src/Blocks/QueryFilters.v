import rt

struct Class_Automattic_WooCommerce_Blocks_QueryFilters {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) init()  {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) main_query_filter(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{}))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_args_mutated.dup()
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('filter_stock_status')])) {
		var_args_mutated = this.stock_filter_clauses(var_args_mutated.dup(), var_wp_query.dup())
	}
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) add_query_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = this.stock_filter_clauses(var_args_mutated.dup(), var_wp_query.dup())
	var_args_mutated = this.price_filter_clauses(var_args_mutated.dup(), var_wp_query.dup())
	var_args_mutated = this.attribute_filter_clauses(var_args_mutated.dup(), var_wp_query.dup())
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_filtered_price(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	// unsupported statement: Stmt_Global
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', // unsupported expression: Expr_UnaryMinus)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	var_query.query(var_query_vars_mutated.dup())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	mut var_price_filter_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\tFROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string('\n\t\tWHERE product_id IN ( ')), var_product_query_sql), rt.new_string(' )\n\t\t')))
	return rt.call_method(var_wpdb, 'get_row', [var_price_filter_sql.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_stock_status_counts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	// unsupported statement: Stmt_Global
	mut var_stock_status_options := rt.call_function('array_map', [rt.new_string('esc_sql'), rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))])
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', // unsupported expression: Expr_UnaryMinus)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	mut var_result := var_query.query(var_query_vars_mutated.dup())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	mut var_stock_status_counts := rt.new_array()
	{
		mut iter_1 := var_stock_status_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			mut var_stock_status_count_sql := this.generate_stock_status_count_query(var_status.dup(), var_product_query_sql.dup(), var_stock_status_options.dup())
			var_result = rt.call_method(var_wpdb, 'get_row', [var_stock_status_count_sql.dup()])
			var_stock_status_counts.array_set(var_status, rt.get_property(var_result, 'status_count'))
		}
	}
	return var_stock_status_counts.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_rating_counts(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	// unsupported statement: Stmt_Global
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', // unsupported expression: Expr_UnaryMinus)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	var_query.query(var_query_vars_mutated.dup())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	mut var_rating_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT product_id ) as product_count, ROUND( average_rating, 0 ) as rounded_average_rating\n\t\t\tFROM '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')), var_product_query_sql), rt.new_string(' )\n\t\t\tAND average_rating > 0\n\t\t\tGROUP BY rounded_average_rating\n\t\t\tORDER BY rounded_average_rating DESC\n\t\t')))
	mut var_results := rt.call_method(var_wpdb, 'get_results', [var_rating_count_sql.dup()])
	return rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_results.dup(), rt.new_string('product_count'), rt.new_string('rounded_average_rating')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_attribute_counts(var_query_vars rt.PhpVal, var_attribute_to_count rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	// unsupported statement: Stmt_Global
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	var_query_vars_mutated.array_set('no_found_rows', true)
	var_query_vars_mutated.array_set('posts_per_page', // unsupported expression: Expr_UnaryMinus)
	var_query_vars_mutated.array_set('fields', 'ids')
	mut var_query := create_automattic_woocommerce_blocks_wp_query()
	mut var_result := var_query.query(var_query_vars_mutated.dup())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_QueryFilters', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'), rt.new_string('__return_empty_array')])
	mut var_attributes_to_count := rt.call_function('esc_sql', [rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_to_count.dup()])])
	mut var_attribute_count_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(DISTINCT posts.ID) as term_count, terms.term_id as term_count_id\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS term_taxonomy ON term_relationships.term_taxonomy_id = term_taxonomy.term_taxonomy_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS terms ON term_taxonomy.term_id = terms.term_id\n\t\t\tWHERE posts.ID IN ( ')), var_product_query_sql), rt.new_string(' )\n\t\t\tAND term_taxonomy.taxonomy IN (\'')), var_attributes_to_count), rt.new_string('\')\n\t\t\tAND posts.post_status = \'publish\'\n\t\t\tAND posts.post_type = \'product\'\n\t\t\tGROUP BY terms.term_id\n\t\t\tORDER BY terms.name ASC')))
	mut var_results := rt.call_method(var_wpdb, 'get_results', [var_attribute_count_sql.dup()])
	return rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [var_results.dup(), rt.new_string('term_count'), rt.new_string('term_count_id')])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) stock_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('filter_stock_status')]))))) {
		return var_args_mutated.dup()
	}
	var_args_mutated.array_set('join', this.append_product_sorting_table_join(var_args_mutated.array_get('join')))
	// unsupported expression: Expr_AssignOp_Concat
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) price_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')]))))))) {
		return var_args_mutated.dup()
	}
	// unsupported statement: Stmt_Global
	mut var_adjust_for_taxes := this.adjust_price_filters_for_displayed_taxes()
	var_args_mutated.array_set('join', this.append_product_sorting_table_join(var_args_mutated.array_get('join')))
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')])) {
		mut var_min_price_filter := rt.new_int(rt.new_int(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')]).to_i64()))
		if rt.is_true(var_adjust_for_taxes) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')])) {
		mut var_max_price_filter := rt.new_int(rt.new_int(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')]).to_i64()))
		if rt.is_true(var_adjust_for_taxes) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_sql.dup(), rt.new_string('wc_product_meta_lookup')]))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_sql.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) generate_stock_status_count_query(var_status rt.PhpVal, var_product_query_sql rt.PhpVal, var_stock_status_options rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	mut var_product_query_sql_mutated := var_product_query_sql
	mut var_stock_status_options_mutated := var_stock_status_options
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_mutated.dup(), var_stock_status_options_mutated.dup(), rt.new_bool(true)]))))) {
		return rt.new_bool(false)
	}
	// unsupported statement: Stmt_Global
	var_status_mutated = rt.call_function('esc_sql', [var_status_mutated.dup()])
	return rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT posts.ID ) as status_count\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' as postmeta ON posts.ID = postmeta.post_id\n\t\t\tAND postmeta.meta_key = \'_stock_status\'\n\t\t\tAND postmeta.meta_value = \'')), var_status_mutated), rt.new_string('\'\n\t\t\tWHERE posts.ID IN ( ')), var_product_query_sql_mutated), rt.new_string(' )\n\t\t')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_product_tax_classes := rt.call_function('array_filter', [rt.call_method(, 'get_col', [])])
	if !rt.is_true(var_product_tax_classes) {
		return ''
	}
	mut var_or_queries := 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_class := item_1.val
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) adjust_price_filters_for_displayed_taxes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_lookup_table_name() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) attribute_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clauses := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Blocks_QueryFilters) get_chosen_attributes(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

struct Class_Automattic_WooCommerce_Blocks_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_queryfilters() &Class_Automattic_WooCommerce_Blocks_QueryFilters {
	mut obj := &Class_Automattic_WooCommerce_Blocks_QueryFilters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_wp_query() &Class_Automattic_WooCommerce_Blocks_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Blocks_WP_Query{
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
			return this.generate_stock_status_count_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_price_filter_query_for_displayed_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filters_for_displayed_taxes' {
			return this.adjust_price_filters_for_displayed_taxes()
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_queryfilters_php() {
	// unsupported statement: Stmt_Declare
}
