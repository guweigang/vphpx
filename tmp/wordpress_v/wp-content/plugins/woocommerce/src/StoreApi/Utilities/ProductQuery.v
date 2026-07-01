import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'offset', val: var_request.array_get('offset') }, rt.ArrayItem{ key: 'order', val: var_request.array_get('order') }, rt.ArrayItem{ key: 'orderby', val: var_request.array_get('orderby') }, rt.ArrayItem{ key: 'paged', val: var_request.array_get('page') }, rt.ArrayItem{ key: 'post__in', val: var_request.array_get('include') }, rt.ArrayItem{ key: 'post__not_in', val: var_request.array_get('exclude') }, rt.ArrayItem{ key: 'posts_per_page', val: if rt.is_true(var_request.array_get('per_page')) { var_request.array_get('per_page') } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'post_parent__in', val: var_request.array_get('parent') }, rt.ArrayItem{ key: 'post_parent__not_in', val: var_request.array_get('parent_exclude') }, rt.ArrayItem{ key: 'search', val: var_request.array_get('search') }, rt.ArrayItem{ key: 'slug', val: var_request.array_get('slug') }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'ignore_sticky_posts', val: true }, rt.ArrayItem{ key: 'post_status', val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }, rt.ArrayItem{ key: 'date_query', val: rt.new_array() }, rt.ArrayItem{ key: 'post_type', val: 'product' }])
	if !(!rt.is_true(var_request.array_get('sku'))) || !(!rt.is_true(var_request.array_get('slug'))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	}
	mut var_tax_query := rt.new_array()
	if !(!rt.is_true(var_request.array_get('type'))) {
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), var_request.array_get('type'))) {
			var_args.array_set('post_type', 'product_variation')
		} else {
			var_args.array_set('post_type', 'product')
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get('type') }]))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'date ID')
	}
	if var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('before', var_request.array_get('before'))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('after', var_request.array_get('after'))
	}
	if var_request.array_isset(rt.new_string('date_column')) && !(!rt.is_true(var_args.array_get('date_query').array_get(0))) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('column', 'post_' + (var_request.array_get('date_column')).str())
	}
	mut var_custom_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'sku' }, rt.ArrayItem{ key: none, val: 'min_price' }, rt.ArrayItem{ key: none, val: 'max_price' }, rt.ArrayItem{ key: none, val: 'stock_status' }])
	{
		mut iter_1 := var_custom_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if !(!rt.is_true(var_request.array_get(var_key))) {
				var_args.array_set(var_key, var_request.array_get(var_key))
			}
		}
	}
	mut var_operator_mapping := rt.create_array([rt.ArrayItem{ key: 'in', val: 'IN' }, rt.ArrayItem{ key: 'not_in', val: 'NOT IN' }, rt.ArrayItem{ key: 'and', val: 'AND' }])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('_unstable_tax_' + (var_value).str())
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('_unstable_tax_' + (var_value).str())
	}
	mut var_all_product_taxonomies := rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'object_type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]) }]), rt.new_string('names')])])
	mut var_default_taxonomies := rt.create_array([rt.ArrayItem{ key: 'product_cat', val: 'category' }, rt.ArrayItem{ key: 'product_tag', val: 'tag' }, rt.ArrayItem{ key: 'product_brand', val: 'brand' }])
	mut var_taxonomies := rt.call_function('array_merge', [var_all_product_taxonomies.dup(), var_default_taxonomies.dup()])
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_taxonomy := item_1.key
			if !(!rt.is_true(var_request.array_get(var_key))) {
				mut var_type := rt.new_string(if rt.is_true(rt.new_bool(var_request.array_get(var_key).array_get(0).is_long() || var_request.array_get(var_key).array_get(0).is_double())) { rt.new_string('term_id') } else { rt.new_string('slug') })
				mut var_operator := if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_request, 'get_param', [(var_key).str() + '_operator'])) && var_operator_mapping.array_isset(rt.call_method(var_request, 'get_param', [(var_key).str() + '_operator'])))) { var_operator_mapping.array_get(rt.call_method(var_request, 'get_param', [(var_key).str() + '_operator'])) } else { rt.new_string('IN') }
				var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'field', val: var_type }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(var_key) }, rt.ArrayItem{ key: 'operator', val: var_operator }]))
			}
		}
	}
	if !(!rt.is_true(var_request.array_get('attributes'))) {
		mut var_att_queries := rt.new_array()
		{
			mut iter_1 := var_request.array_get('attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				if !rt.is_true(var_attribute.array_get('term_id')) && !rt.is_true(var_attribute.array_get('slug')) {
					continue
				}
				if rt.is_true(rt.call_function('in_array', [var_attribute.array_get('attribute'), rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}), rt.new_bool(true)])) {
					mut var_operator := if var_attribute.array_isset(rt.new_string('operator')) && var_operator_mapping.array_isset(var_attribute.array_get('operator')) { var_operator_mapping.array_get(var_attribute.array_get('operator')) } else { rt.new_string('IN') }
					var_att_queries.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_attribute.array_get('attribute') }, rt.ArrayItem{ key: 'field', val: if !(!rt.is_true(var_attribute.array_get('term_id'))) { 'term_id' } else { 'slug' } }, rt.ArrayItem{ key: 'terms', val: if !(!rt.is_true(var_attribute.array_get('term_id'))) { var_attribute.array_get('term_id') } else { var_attribute.array_get('slug') } }, rt.ArrayItem{ key: 'operator', val: var_operator }]))
				}
			}
		}
		if 1 < var_att_queries.dup().array_count() {
			mut var_relation := if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('attribute_relation')])) && var_operator_mapping.array_isset(rt.call_method(var_request, 'get_param', [rt.new_string('attribute_relation')])))) { var_operator_mapping.array_get(rt.call_method(var_request, 'get_param', [rt.new_string('attribute_relation')])) } else { rt.new_string('IN') }
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'relation', val: var_relation }, rt.ArrayItem{ key: none, val: var_att_queries }]))
		} else {
			var_tax_query = rt.call_function('array_merge', [var_tax_query.dup(), var_att_queries.dup()])
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_tax_query)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if !(!rt.is_true(var_args.array_get('tax_query'))) {
			var_args.array_set('tax_query', rt.call_function('array_merge', [var_tax_query.dup(), var_args.array_get('tax_query')]))
			// unsupported statement: Stmt_Nop
		} else {
			var_args.array_set('tax_query', var_tax_query.dup())
			// unsupported statement: Stmt_Nop
		}
	} else {
		if !(!rt.is_true(var_args.array_get('tax_query'))) {
			var_args.array_set('meta_query', this.convert_tax_query_to_meta_query(rt.call_function('array_merge', [var_tax_query.dup(), var_args.array_get('tax_query')])))
			// unsupported statement: Stmt_Nop
		} else {
			var_args.array_set('meta_query', this.convert_tax_query_to_meta_query(var_tax_query.dup()))
			// unsupported statement: Stmt_Nop
		}
	}
	if rt.is_true(rt.new_bool(var_request.array_get('featured').is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get('featured'))) { 'IN' } else { 'NOT IN' } }]))
	}
	if rt.is_true(rt.new_bool(var_request.array_get('on_sale').is_bool())) {
		mut var_on_sale_key := rt.new_string(if rt.is_true(var_request.array_get('on_sale')) { rt.new_string('post__in') } else { rt.new_string('post__not_in') })
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		// unsupported expression: Expr_AssignOp_Plus
	}
	mut var_catalog_visibility := rt.call_method(var_request, 'get_param', [rt.new_string('catalog_visibility')])
	mut var_rating := rt.call_method(var_request, 'get_param', [rt.new_string('rating')])
	mut var_visibility_options := rt.call_function('wc_get_product_visibility_options', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [var_catalog_visibility.dup(), rt.func_array_keys(var_visibility_options.dup()), rt.new_bool(true)])) {
		mut var_exclude_from_catalog := rt.new_string(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.search(), var_catalog_visibility)) { rt.new_string('') } else { rt.new_string('exclude-from-catalog') })
		mut var_exclude_from_search := rt.new_string(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), var_catalog_visibility)) { rt.new_string('') } else { rt.new_string('exclude-from-search') })
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: var_exclude_from_catalog }, rt.ArrayItem{ key: none, val: var_exclude_from_search }]) }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden(), var_catalog_visibility)) { 'AND' } else { 'NOT IN' } }, rt.ArrayItem{ key: 'rating_filter', val: true }]))
	}
	if rt.is_true(var_rating) {
		mut var_rating_terms := rt.new_array()
		{
			mut iter_1 := var_rating.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				var_rating_terms.array_push('rated-' + (var_value).str())
			}
		}
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: var_rating_terms }]))
	}
	mut var_orderby := rt.call_method(var_request, 'get_param', [rt.new_string('orderby')])
	mut var_order := rt.call_method(var_request, 'get_param', [rt.new_string('order')])
	mut var_ordering_args := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'query'), 'get_catalog_ordering_args', [var_orderby.dup(), var_order.dup()])
	var_args.array_set('orderby', var_ordering_args.array_get('orderby'))
	var_args.array_set('order', var_ordering_args.array_get('order'))
	if rt.is_true(rt.identical(rt.new_string('include'), var_orderby)) {
		var_args.array_set('orderby', 'post__in')
	} else if rt.is_true(rt.identical(rt.new_string('id'), var_orderby)) {
		var_args.array_set('orderby', 'ID')
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.identical(rt.new_string('slug'), var_orderby)) {
		var_args.array_set('orderby', 'name')
	}
	if rt.is_true(var_ordering_args.array_get('meta_key')) {
		var_args.array_set('meta_key', var_ordering_args.array_get('meta_key'))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(var_request.array_get('related'))) {
		mut var_product_id := rt.call_function('absint', [var_request.array_get('related')])
		mut var_related_product := rt.call_function('wc_get_product', [var_product_id.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_related_product)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_related_product, 'is_visible', []rt.PhpVal{}))))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_not_found'), rt.call_function('__', [rt.new_string('The related product ID is invalid or the product is not visible.'), rt.new_string('woocommerce')]), rt.new_int(404))))
		}
		mut var_limit := if !(!rt.is_true(var_request.array_get('per_page'))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(100) }
		mut var_related := rt.call_function('wc_get_related_products', [var_product_id.dup(), var_limit.dup()])
		if !(!rt.is_true(var_related)) {
			var_args.array_set('post__in', if !(!rt.is_true(var_args.array_get('post__in'))) { rt.call_function('array_values', [rt.call_function('array_intersect', [var_args.array_get('post__in'), var_related.dup()])]) } else { rt.call_function('array_values', [var_related.dup()]) })
		} else {
			var_args.array_set('post__in', rt.create_array([rt.ArrayItem{ key: none, val: 0 }]))
		}
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) convert_tax_query_to_meta_query(var_tax_query rt.PhpVal) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	mut var_meta_query := rt.new_array()
	{
		mut iter_1 := var_tax_query_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_query_item := item_1.val
			mut var_taxonomy := var_tax_query_item.array_get('taxonomy')
			mut var_terms := var_tax_query_item.array_get('terms')
			mut var_meta_key := rt.new_string('attribute_' + (var_taxonomy).str())
			var_meta_query.array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: var_meta_key }, rt.ArrayItem{ key: 'value', val: var_terms }]))
			if var_tax_query_item.array_isset(rt.new_string('operator')) {
				var_meta_query.array_get_mut(0).array_set('compare', var_tax_query_item.array_get('operator'))
			}
		}
	}
	return var_meta_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_results(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.dup())
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_ProductQuery', ['QueryClausesGenerator'], &this) }, rt.ArrayItem{ key: none, val: 'add_query_clauses' }]), rt.new_int(10), rt.new_int(2)])
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_results := var_query.query(var_query_args.dup())
	mut var_total_posts := rt.get_property(var_query, 'found_posts')
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && rt.is_true(rt.greater(var_query_args.array_get('paged'), rt.new_int(1))))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
		.query(.dup())
		
	}
	
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_objects(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_last_modified() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) add_query_clauses(mut var_args Class_Automattic_WooCommerce_StoreApi_Utilities_array, mut var_wp_query Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) add_price_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	mut operator_mutated := operator
	return ''
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) adjust_price_filters_for_displayed_taxes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) prepare_price_filter(var_price_filter rt.PhpVal) f64 {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_productquery() &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wp_query() &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'convert_tax_query_to_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.convert_tax_query_to_meta_query(dispatch_arg_0)
		}
		'get_results' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_results(dispatch_arg_0)
		}
		'get_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_objects(dispatch_arg_0)
		}
		'get_last_modified' {
			return this.get_last_modified()
		}
		'add_query_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.add_query_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'add_price_filter_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_price_filter_clauses(dispatch_arg_0, dispatch_arg_1)
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
		'prepare_price_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(this.prepare_price_filter(dispatch_arg_0))
		}
		'adjust_price_filter_for_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_price_filter_for_tax_class(dispatch_arg_0, dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_product_sorting_table_join(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_productquery_php() {
	// unsupported statement: Stmt_Declare
}
