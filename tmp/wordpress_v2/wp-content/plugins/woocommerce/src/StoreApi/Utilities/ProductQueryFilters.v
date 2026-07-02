import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) get_filtered_price(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	var_request.array_unset(rt.new_string('min_price'))
	var_request.array_unset(rt.new_string('max_price'))
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_query_args := var_product_query.prepare_objects_query(var_request.clone())
	var_query_args.array_set('no_found_rows', true)
	var_query_args.array_set('posts_per_page', -1)
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_result := var_query.query(var_query_args.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_price_filter_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT min( min_price ) as min_price, MAX( max_price ) as max_price\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')),
		var_product_query_sql), rt.new_string(' )\n\t\t'))).str())
	return rt.call_method(var_wpdb, 'get_row', [var_price_filter_sql.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) get_stock_status_counts(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	mut var_stock_status_options := rt.call_function('array_map', [
		rt.new_string('esc_sql'),
		rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})),
	])
	mut var_hide_outofstock_items := rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), var_hide_outofstock_items)) {
		var_stock_status_options.array_unset(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
	}
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_query_args := var_product_query.prepare_objects_query(var_request.clone())
	var_query_args.array_unset(rt.new_string('stock_status'))
	var_query_args.array_set('no_found_rows', true)
	var_query_args.array_set('posts_per_page', -1)
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_result := var_query.query(var_query_args.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) generate_stock_status_count_query(var_status rt.PhpVal, var_product_query_sql rt.PhpVal, var_stock_status_options rt.PhpVal) rt.PhpVal {
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
		rt.new_string(" as postmeta ON posts.ID = postmeta.post_id\n            AND postmeta.meta_key = '_stock_status'\n            AND postmeta.meta_value = '")),
		var_status_mutated), rt.new_string("'\n\t\t\tWHERE posts.ID IN ( ")),
		var_product_query_sql_mutated), rt.new_string(' )\n\t\t'))).str())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) get_attribute_counts(var_request rt.PhpVal, var_attributes rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_attributes_mutated := var_attributes
	rt.call_method(var_request, 'set_param', [rt.new_string('page'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('per_page'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('order'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('orderby'),
		rt.new_null()])
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_query_args := var_product_query.prepare_objects_query(var_request.clone())
	var_query_args.array_set('no_found_rows', true)
	var_query_args.array_set('posts_per_page', -1)
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_result := var_query.query(var_query_args.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	if var_attributes_mutated.clone().array_count() == rt.call_function('array_filter', [
		var_attributes_mutated.clone(),
		rt.new_string('is_numeric'),
	]).array_count() {
		var_attributes_mutated = rt.call_function('array_map', [
			rt.new_string('wc_attribute_taxonomy_name_by_id'),
			rt.call_function('wp_parse_id_list', [var_attributes_mutated.clone()]),
		])
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_attribute = rt.call_function('wc_sanitize_taxonomy_name', [
			var_attribute.clone()])
		return rt.call_function('esc_sql', [var_attribute.clone()])
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_attribute = rt.call_function('wc_sanitize_taxonomy_name', [
			var_attribute.clone()])
		return rt.call_function('esc_sql', [var_attribute.clone()])
	}
	mut var_attributes_to_count := rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_attributes_mutated.clone(),
	])
	mut var_attributes_to_count_sql := rt.new_string(
		"AND term_taxonomy.taxonomy IN ('" + (rt.call_function('implode', [rt.new_string("','"), var_attributes_to_count.clone()])).str() +
		"')")
	mut var_attribute_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT posts.ID ) as term_count, terms.term_id as term_count_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'posts')), rt.new_string(' AS posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'term_relationships')),
		rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'term_taxonomy')),
		rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
		'terms')), rt.new_string(' AS terms USING( term_id )\n\t\t\tWHERE posts.ID IN ( ')),
		var_product_query_sql), rt.new_string(' )\n\t\t\t')), var_attributes_to_count_sql),
		rt.new_string('\n\t\t\tGROUP BY terms.term_id\n\t\t'))).str())
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_attribute_count_sql.clone()])
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_function('wp_list_pluck', [var_results.clone(),
			rt.new_string('term_count'), rt.new_string('term_count_id')])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) get_rating_counts(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	var_request.array_unset(rt.new_string('rating'))
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_query_args := var_product_query.prepare_objects_query(var_request.clone())
	var_query_args.array_set('no_found_rows', true)
	var_query_args.array_set('posts_per_page', -1)
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_result := var_query.query(var_query_args.clone())
	mut var_product_query_sql := rt.get_property(var_query, 'request')
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_query },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_pre_query'),
		rt.new_string('__return_empty_array')])
	mut var_rating_count_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT product_id ) as product_count, ROUND( average_rating, 0 ) as rounded_average_rating\n\t\t\tFROM '), rt.get_property(var_wpdb,
		'wc_product_meta_lookup')), rt.new_string('\n\t\t\tWHERE product_id IN ( ')),
		var_product_query_sql),
		rt.new_string(' )\n\t\t\tAND average_rating > 0\n\t\t\tGROUP BY rounded_average_rating\n\t\t\tORDER BY rounded_average_rating ASC\n\t\t'))).str())
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_rating_count_sql.clone()])
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_function('wp_list_pluck', [var_results.clone(),
			rt.new_string('product_count'), rt.new_string('rounded_average_rating')])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) get_taxonomy_counts(var_request rt.PhpVal, var_taxonomies rt.PhpVal) rt.PhpVal {
	rt.call_method(var_request, 'set_param', [rt.new_string('page'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('per_page'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('order'),
		rt.new_null()])
	rt.call_method(var_request, 'set_param', [rt.new_string('orderby'),
		rt.new_null()])
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	mut var_query_vars := var_product_query.prepare_objects_query(var_request.clone())
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_filter_data_provider := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class(),
	])
	mut var_filter_data := rt.call_method(var_filter_data_provider, 'with', [
		var_product_query,
	])
	mut var_all_counts := rt.new_array()
	mut iter_2 := var_taxonomies.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_taxonomy := item_2.val
		mut var_counts := rt.call_method(var_filter_data, 'get_taxonomy_counts', [
			var_query_vars.clone(),
			var_taxonomy.clone(),
		])
		var_all_counts = rt.add(var_all_counts, var_counts)
	}
	return var_all_counts.clone()
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_productqueryfilters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_productquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_filtered_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filtered_price(dispatch_arg_0)
		}
		'get_stock_status_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status_counts(dispatch_arg_0)
		}
		'generate_stock_status_count_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.generate_stock_status_count_query(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_attribute_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_attribute_counts(dispatch_arg_0, dispatch_arg_1)
		}
		'get_rating_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rating_counts(dispatch_arg_0)
		}
		'get_taxonomy_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_taxonomy_counts(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
