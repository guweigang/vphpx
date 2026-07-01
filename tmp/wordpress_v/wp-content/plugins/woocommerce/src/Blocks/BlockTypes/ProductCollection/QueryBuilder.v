import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	rt.PhpObjectBase
pub mut:
		valid_query_vars rt.PhpVal = rt.new_null()
		custom_order_opts rt.PhpVal = rt.new_array()
		attributes_filter_query_args rt.PhpVal = rt.new_array()
		collection_handler_store rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) construct()  {
	this.valid_query_vars = this.get_valid_query_vars()
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_price_range_filter_posts_clauses' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_collection_handler_store(var_collection_handler_store rt.PhpVal)  {
	this.collection_handler_store = var_collection_handler_store.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_collection_handler(var_collection_name rt.PhpVal, var_handlers rt.PhpVal)  {
	mut var_handlers_mutated := var_handlers
	this.collection_handler_store.array_set(var_collection_name, var_handlers_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_attributes_filter_query_args(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	this.attributes_filter_query_args = var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_valid_query_vars() rt.PhpVal {
	if !(!rt.is_true(this.valid_query_vars)) {
		return this.valid_query_vars
	}
	mut var_valid_query_vars := rt.func_array_keys(rt.call_method(create_wp_query(), 'fill_query_vars', [rt.new_array()]))
	this.valid_query_vars = rt.call_function('array_merge', [var_valid_query_vars.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'date_query' }, rt.ArrayItem{ key: none, val: 'exact' }, rt.ArrayItem{ key: none, val: 'ignore_sticky_posts' }, rt.ArrayItem{ key: none, val: 'lazy_load_term_meta' }, rt.ArrayItem{ key: none, val: 'meta_compare_key' }, rt.ArrayItem{ key: none, val: 'meta_compare' }, rt.ArrayItem{ key: none, val: 'meta_query' }, rt.ArrayItem{ key: none, val: 'meta_type_key' }, rt.ArrayItem{ key: none, val: 'meta_type' }, rt.ArrayItem{ key: none, val: 'nopaging' }, rt.ArrayItem{ key: none, val: 'offset' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'orderby' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'posts_per_page' }, rt.ArrayItem{ key: none, val: 'suppress_filters' }, rt.ArrayItem{ key: none, val: 'tax_query' }, rt.ArrayItem{ key: none, val: 'isProductCollection' }, rt.ArrayItem{ key: none, val: 'priceRange' }])])
	return this.valid_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_custom_order_opts() rt.PhpVal {
	return this.custom_order_opts
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_final_frontend_query(var_collection_args rt.PhpVal, var_query rt.PhpVal, page i64, is_exclude_applied_filters bool) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_product_ids := if !(var_query.array_get('post__in')).is_null() { var_query.array_get('post__in') } else { rt.new_array() }
	mut var_offset_raw := if !(var_query.array_get('offset')).is_null() { var_query.array_get('offset') } else { rt.new_int(0) }
	mut var_per_page_raw := if !(var_query.array_get('perPage')).is_null() { var_query.array_get('perPage') } else { rt.new_null() }
	mut var_offset := if rt.is_true(rt.new_bool(var_offset_raw.dup().is_long() || var_offset_raw.dup().is_double())) { rt.call_function('max', [rt.new_int(0), // unsupported expression: Expr_Cast_Int]) } else { rt.new_int(0) }
	mut var_per_page := if rt.is_true(rt.new_bool(var_per_page_raw.dup().is_long() || var_per_page_raw.dup().is_double())) { rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int]) } else { rt.new_int(9) }
	mut var_order := if !(var_query.array_get('order')).is_null() { var_query.array_get('order') } else { rt.new_string('asc') }
	mut var_search := if !(var_query.array_get('search')).is_null() { var_query.array_get('search') } else { rt.new_string('') }
	mut var_common_query_values := rt.create_array([rt.ArrayItem{ key: 'meta_query', val: rt.new_array() }, rt.ArrayItem{ key: 'posts_per_page', val: var_per_page }, rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'offset', val: rt.add(rt.mul(var_per_page, page - 1), var_offset) }, rt.ArrayItem{ key: 'post__in', val: var_product_ids }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'tax_query', val: rt.new_array() }, rt.ArrayItem{ key: 'paged', val: page }, rt.ArrayItem{ key: 's', val: var_search }])
	mut var_is_on_sale := if !(var_query.array_get('woocommerceOnSale')).is_null() { var_query.array_get('woocommerceOnSale') } else { rt.new_bool(false) }
	mut var_order_by := if !(var_query.array_get('orderBy')).is_null() { var_query.array_get('orderBy') } else { rt.new_string('') }
	mut var_stock_status := if !(var_query.array_get('woocommerceStockStatus')).is_null() { var_query.array_get('woocommerceStockStatus') } else { rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }
	mut var_product_attributes := if !(var_query.array_get('woocommerceAttributes')).is_null() { var_query.array_get('woocommerceAttributes') } else { rt.new_array() }
	mut var_taxonomies_query := this.get_filter_by_taxonomies_query(if !(var_query.array_get('tax_query')).is_null() { var_query.array_get('tax_query') } else { rt.new_array() })
	mut var_handpicked_products := if !(var_query.array_get('woocommerceHandPickedProducts')).is_null() { var_query.array_get('woocommerceHandPickedProducts') } else { rt.new_array() }
	mut var_time_frame := if !(var_query.array_get('timeFrame')).is_null() { var_query.array_get('timeFrame') } else { rt.new_null() }
	mut var_price_range := if !(var_query.array_get('priceRange')).is_null() { var_query.array_get('priceRange') } else { rt.new_null() }
	mut var_featured := if !(var_query.array_get('featured')).is_null() { var_query.array_get('featured') } else { rt.new_bool(false) }
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name'))).is_null() { this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name')) } else { rt.new_null() }
	if var_handlers.array_isset(rt.new_string('frontend_args')) {
		var_collection_args_mutated = rt.call_function('call_user_func', [var_handlers.array_get('frontend_args'), var_collection_args_mutated.dup(), var_query.dup()])
	}
	mut var_final_query := this.get_final_query_args(var_collection_args_mutated.dup(), var_common_query_values.dup(), rt.create_array([rt.ArrayItem{ key: 'on_sale', val: var_is_on_sale }, rt.ArrayItem{ key: 'stock_status', val: var_stock_status }, rt.ArrayItem{ key: 'orderby', val: var_order_by }, rt.ArrayItem{ key: 'product_attributes', val: var_product_attributes }, rt.ArrayItem{ key: 'taxonomies_query', val: var_taxonomies_query }, rt.ArrayItem{ key: 'handpicked_products', val: var_handpicked_products }, rt.ArrayItem{ key: 'featured', val: var_featured }, rt.ArrayItem{ key: 'timeFrame', val: var_time_frame }, rt.ArrayItem{ key: 'priceRange', val: var_price_range }]), is_exclude_applied_filters)
	return var_final_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_taxonomies_query(var_tax_query rt.PhpVal) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_tax_query_mutated.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_product_taxonomies := rt.call_function('array_diff', [rt.call_function('get_object_taxonomies', [rt.new_string('product'), rt.new_string('names')]), rt.create_array([rt.ArrayItem{ key: none, val: 'product_visibility' }, rt.ArrayItem{ key: none, val: 'product_shipping_class' }])])
	closure_1_fn := fn [var_product_taxonomies] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_item.array_isset(rt.new_string('taxonomy')) && rt.is_true(rt.call_function('in_array', [var_item.array_get('taxonomy'), var_product_taxonomies.dup(), rt.new_bool(true)])))
	}
	mut var_result := rt.call_function('array_filter', [var_tax_query_mutated.dup(), rt.new_closure(closure_1_fn)])
	return if !(!rt.is_true(var_result)) { rt.create_array([rt.ArrayItem{ key: 'tax_query', val: var_result }]) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_final_query_args(var_collection_args rt.PhpVal, var_common_query_values rt.PhpVal, var_query rt.PhpVal, is_exclude_applied_filters bool) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_common_query_values_mutated := var_common_query_values
	mut var_orderby_query := if rt.is_true(var_query.array_get('orderby')) { this.get_custom_orderby_query(var_query.array_get('orderby')) } else { rt.new_array() }
	mut var_on_sale_query := this.get_on_sale_products_query(var_query.array_get('on_sale'))
	mut var_stock_query := this.get_stock_status_query(var_query.array_get('stock_status'))
	mut var_visibility_query := if rt.is_true(rt.new_bool(var_query.array_get('stock_status').is_array())) { this.get_product_visibility_query(var_stock_query.dup(), var_query.array_get('stock_status')) } else { rt.new_array() }
	mut var_featured_query := this.get_featured_query(if !(var_query.array_get('featured')).is_null() { var_query.array_get('featured') } else { rt.new_bool(false) })
	mut var_attributes_query := this.get_product_attributes_query(var_query.array_get('product_attributes'))
	mut var_taxonomies_query := if !(var_query.array_get('taxonomies_query')).is_null() { var_query.array_get('taxonomies_query') } else { rt.new_array() }
	mut var_tax_query := this.merge_tax_queries(var_visibility_query.dup(), var_attributes_query.dup(), var_taxonomies_query.dup(), var_featured_query.dup())
	mut var_date_query := this.get_date_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array](if !(var_query.array_get('timeFrame')).is_null() { var_query.array_get('timeFrame') } else { rt.new_array() }))
	mut var_price_query_args := this.get_price_range_query_args(if !(var_query.array_get('priceRange')).is_null() { var_query.array_get('priceRange') } else { rt.new_array() })
	mut var_handpicked_query := this.get_handpicked_query(if !(var_query.array_get('handpicked_products')).is_null() { var_query.array_get('handpicked_products') } else { rt.new_bool(false) })
	mut var_applied_filters_query := if var_is_exclude_applied_filters { rt.new_array() } else { this.get_queries_by_applied_filters() }
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name'))).is_null() { this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name')) } else { rt.new_null() }
	if var_handlers.array_isset(rt.new_string('build_query')) {
		mut var_collection_query := rt.call_function('call_user_func', [var_handlers.array_get('build_query'), var_collection_args_mutated.dup(), var_common_query_values_mutated.dup(), var_query.dup(), rt.new_bool(is_exclude_applied_filters)])
	} else {
		var_collection_query = rt.new_array()
	}
	return this.merge_queries(var_common_query_values_mutated.dup(), var_orderby_query.dup(), var_on_sale_query.dup(), var_stock_query.dup(), var_tax_query.dup(), var_applied_filters_query.dup(), var_date_query.dup(), var_price_query_args.dup(), var_handpicked_query.dup(), var_collection_query.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_preview_query_args(var_collection_args rt.PhpVal, var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_args_mutated := var_args
	mut var_collection_query := rt.new_array()
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name'))).is_null() { this.collection_handler_store.array_get(var_collection_args_mutated.array_get('name')) } else { rt.new_null() }
	if var_handlers.array_isset(rt.new_string('preview_query')) {
		var_collection_query = rt.call_function('call_user_func', [var_handlers.array_get('preview_query'), var_collection_args_mutated.dup(), var_args_mutated.dup(), var_request.dup()])
	}
	mut var_orderby_query := if rt.is_true(var_args_mutated.array_get('orderby')) { this.get_custom_orderby_query(var_args_mutated.array_get('orderby')) } else { rt.new_array() }
	var_args_mutated = this.merge_queries(var_args_mutated.dup(), var_orderby_query.dup(), var_collection_query.dup())
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_stock_status_query(var_stock_statuses rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_stock_statuses.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_stock_status_options := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(var_stock_statuses.dup().array_count() == var_stock_status_options.dup().array_count() && rt.is_true(rt.identical(rt.call_function('array_diff', [var_stock_statuses.dup(), var_stock_status_options.dup()]), rt.call_function('array_diff', [var_stock_status_options.dup(), var_stock_statuses.dup()]))))) {
		return rt.new_array()
	}
	mut var_diff := rt.call_function('array_diff', [var_stock_status_options.dup(), var_stock_statuses.dup()])
	if rt.is_true(rt.new_bool(var_diff.dup().array_count() == 1 && rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), var_diff.dup(), rt.new_bool(true)])))) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'meta_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: rt.cast_array(var_stock_statuses) }, rt.ArrayItem{ key: 'compare', val: 'IN' }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_tax_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_tax_query := rt.new_array()
	{
		mut iter_1 := var_queries_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			if !(!rt.is_true(var_query.array_get('tax_query'))) {
				var_tax_query = rt.call_function('array_merge', [var_tax_query.dup(), var_query.array_get('tax_query')])
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'tax_query', val: var_tax_query }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_product_attributes_query(var_attributes rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_attributes) {
		return rt.new_array()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_item := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_taxonomy := rt.call_function('sanitize_title', [var_item.array_get('taxonomy')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('key_exists', [var_taxonomy.dup(), var_carry.dup()]))))) {
		var_carry.array_set(var_taxonomy, rt.create_array([rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'operator', val: 'IN' }, rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: var_item.array_get('termId') }]) }]))
	} else {
		var_carry.array_get_mut(var_taxonomy).array_get_mut('terms').array_push(var_item.array_get('termId'))
	}
	return var_carry.dup()
	}
	mut var_grouped_attributes := rt.call_function('array_reduce', [var_attributes.dup(), rt.new_closure(closure_2_fn), rt.new_array()])
	return rt.create_array([rt.ArrayItem{ key: 'tax_query', val: rt.call_function('array_values', [var_grouped_attributes.dup()]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_featured_query(var_featured rt.PhpVal) rt.PhpVal {
	mut var_featured_mutated := var_featured
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'tax_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: 'IN' }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_price_query() rt.PhpVal {
	mut var_min_price := rt.call_function('get_query_var', [Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.min_price_query_var()])
	mut var_max_price := rt.call_function('get_query_var', [Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.max_price_query_var()])
	mut var_max_price_query := if !rt.is_true(var_max_price) { rt.new_array() } else { rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'value', val: var_max_price }, rt.ArrayItem{ key: 'compare', val: '<=' }, rt.ArrayItem{ key: 'type', val: 'numeric' }]) }
	mut var_min_price_query := if !rt.is_true(var_min_price) { rt.new_array() } else { rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'value', val: var_min_price }, rt.ArrayItem{ key: 'compare', val: '>=' }, rt.ArrayItem{ key: 'type', val: 'numeric' }]) }
	if !rt.is_true(var_min_price_query) && !rt.is_true(var_max_price_query) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'meta_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_max_price_query }, rt.ArrayItem{ key: none, val: var_min_price_query }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_attributes_query() rt.PhpVal {
	mut var_attributes_filter_query_args := this.get_filter_by_attributes_query_vars()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_query_args := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_attribute_name := 
	
	}
	mut var_queries := rt.call_function('array_reduce', [var_attributes_filter_query_args.dup(), rt.new_closure(closure_3_fn), rt.new_array()])
	if !rt.is_true(var_queries) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: , val:  }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_attributes_query_vars() rt.PhpVal {
	if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_stock_status_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_rating_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_taxonomy_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) array_merge_recursive_replace_non_array_properties(var_base rt.PhpVal, var_new_array rt.PhpVal) rt.PhpVal {
	mut var_base_mutated := var_base
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_queries_by_applied_filters() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_product_visibility_query(var_stock_query rt.PhpVal, var_stock_status rt.PhpVal) rt.PhpVal {
	mut var_stock_query_mutated := var_stock_query
	mut var_stock_status_mutated := var_stock_status
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_date_query(mut var_time_frame Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array) rt.PhpVal {
	mut var_time_frame_mutated := var_time_frame
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_price_range_query_args(var_price_range rt.PhpVal) rt.PhpVal {
	mut var_price_range_mutated := var_price_range
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_price_range_filter_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clauses_mutated := var_clauses
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) should_adjust_price_range_for_taxes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_handpicked_query(var_handpicked_products rt.PhpVal) rt.PhpVal {
	mut var_handpicked_products_mutated := var_handpicked_products
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_on_sale_products_query(var_is_on_sale rt.PhpVal) rt.PhpVal {
	mut var_is_on_sale_mutated := var_is_on_sale
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_custom_orderby_query(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_price_sorting_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_sales_sorting_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_post__in(var_post__in rt.PhpVal) rt.PhpVal {
	mut var_post__in_mutated := var_post__in
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_menu_order_with_title_fallback_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_querybuilder() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
		valid_query_vars: rt.new_null()
		custom_order_opts: rt.new_array()
		attributes_filter_query_args: rt.new_array()
		collection_handler_store: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'set_collection_handler_store' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_collection_handler_store(dispatch_arg_0)
			return rt.new_null()
		}
		'set_collection_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_collection_handler(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_attributes_filter_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attributes_filter_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'get_valid_query_vars' {
			return this.get_valid_query_vars()
		}
		'get_custom_order_opts' {
			return this.get_custom_order_opts()
		}
		'get_final_frontend_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_final_frontend_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_filter_by_taxonomies_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filter_by_taxonomies_query(dispatch_arg_0)
		}
		'get_final_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.get_final_query_args(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_preview_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_preview_query_args(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_stock_status_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status_query(dispatch_arg_0)
		}
		'merge_tax_queries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.merge_tax_queries(dispatch_arg_0)
		}
		'get_product_attributes_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_attributes_query(dispatch_arg_0)
		}
		'get_featured_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_featured_query(dispatch_arg_0)
		}
		'get_filter_by_price_query' {
			return this.get_filter_by_price_query()
		}
		'get_filter_by_attributes_query' {
			return this.get_filter_by_attributes_query()
		}
		'get_filter_by_attributes_query_vars' {
			return this.get_filter_by_attributes_query_vars()
		}
		'get_filter_by_stock_status_query' {
			return this.get_filter_by_stock_status_query()
		}
		'get_filter_by_rating_query' {
			return this.get_filter_by_rating_query()
		}
		'get_filter_by_taxonomy_query' {
			return this.get_filter_by_taxonomy_query()
		}
		'array_merge_recursive_replace_non_array_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.array_merge_recursive_replace_non_array_properties(dispatch_arg_0, dispatch_arg_1)
		}
		'get_queries_by_applied_filters' {
			return this.get_queries_by_applied_filters()
		}
		'get_product_visibility_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_product_visibility_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_date_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_date_query(mut dispatch_arg_0)
		}
		'get_price_range_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_price_range_query_args(dispatch_arg_0)
		}
		'add_price_range_filter_posts_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_price_range_filter_posts_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'get_price_filter_query_for_displayed_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filter_for_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_price_filter_for_tax_class(dispatch_arg_0, dispatch_arg_1)
		}
		'should_adjust_price_range_for_taxes' {
			return this.should_adjust_price_range_for_taxes()
		}
		'get_handpicked_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_handpicked_query(dispatch_arg_0)
		}
		'get_on_sale_products_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_on_sale_products_query(dispatch_arg_0)
		}
		'merge_queries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.merge_queries(dispatch_arg_0)
		}
		'get_custom_orderby_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_orderby_query(dispatch_arg_0)
		}
		'add_price_sorting_posts_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_price_sorting_posts_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'add_sales_sorting_posts_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_sales_sorting_posts_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_product_sorting_table_join(dispatch_arg_0)
		}
		'merge_post__in' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.merge_post__in(dispatch_arg_0)
		}
		'add_menu_order_with_title_fallback_posts_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_menu_order_with_title_fallback_posts_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'valid_query_vars' { return this.valid_query_vars }
		'custom_order_opts' { return this.custom_order_opts }
		'attributes_filter_query_args' { return this.attributes_filter_query_args }
		'collection_handler_store' { return this.collection_handler_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'valid_query_vars' { this.valid_query_vars = val; return true }
		'custom_order_opts' { this.custom_order_opts = val; return true }
		'attributes_filter_query_args' { this.attributes_filter_query_args = val; return true }
		'collection_handler_store' { this.collection_handler_store = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productcollection_querybuilder_php() {
	// unsupported statement: Stmt_Declare
}
