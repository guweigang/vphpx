import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	rt.PhpObjectBase
pub mut:
	valid_query_vars             rt.PhpVal = rt.new_null()
	custom_order_opts            rt.PhpVal = rt.new_array()
	attributes_filter_query_args rt.PhpVal = rt.new_array()
	collection_handler_store     rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) construct() {
	this.valid_query_vars = this.get_valid_query_vars()
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_price_range_filter_posts_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_collection_handler_store(var_collection_handler_store rt.PhpVal) {
	this.collection_handler_store = var_collection_handler_store.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_collection_handler(var_collection_name rt.PhpVal, var_handlers rt.PhpVal) {
	mut var_handlers_mutated := var_handlers
	this.collection_handler_store.array_set(var_collection_name, var_handlers_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) set_attributes_filter_query_args(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.attributes_filter_query_args = var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_valid_query_vars() rt.PhpVal {
	if !(!rt.is_true(this.valid_query_vars)) {
		return this.valid_query_vars
	}
	mut var_valid_query_vars := rt.func_array_keys(rt.call_method(create_wp_query(),
		'fill_query_vars', [rt.new_array()]))
	this.valid_query_vars = rt.call_function('array_merge', [
		var_valid_query_vars.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'date_query' },
			rt.ArrayItem{ key: none, val: 'exact' },
			rt.ArrayItem{ key: none, val: 'ignore_sticky_posts' },
			rt.ArrayItem{ key: none, val: 'lazy_load_term_meta' },
			rt.ArrayItem{ key: none, val: 'meta_compare_key' },
			rt.ArrayItem{ key: none, val: 'meta_compare' },
			rt.ArrayItem{ key: none, val: 'meta_query' },
			rt.ArrayItem{ key: none, val: 'meta_type_key' },
			rt.ArrayItem{ key: none, val: 'meta_type' },
			rt.ArrayItem{ key: none, val: 'nopaging' },
			rt.ArrayItem{ key: none, val: 'offset' },
			rt.ArrayItem{ key: none, val: 'order' },
			rt.ArrayItem{ key: none, val: 'orderby' },
			rt.ArrayItem{ key: none, val: 'page' },
			rt.ArrayItem{ key: none, val: 'post_type' },
			rt.ArrayItem{ key: none, val: 'posts_per_page' },
			rt.ArrayItem{ key: none, val: 'suppress_filters' },
			rt.ArrayItem{ key: none, val: 'tax_query' },
			rt.ArrayItem{ key: none, val: 'isProductCollection' },
			rt.ArrayItem{ key: none, val: 'priceRange' },
		])])
	return this.valid_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_custom_order_opts() rt.PhpVal {
	return this.custom_order_opts
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_final_frontend_query(var_collection_args rt.PhpVal, var_query rt.PhpVal, page i64, is_exclude_applied_filters bool) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_product_ids := if !(var_query.array_get(rt.new_string('post__in'))).is_null() {
		var_query.array_get(rt.new_string('post__in'))
	} else {
		rt.new_array()
	}
	mut var_offset_raw := if !(var_query.array_get(rt.new_string('offset'))).is_null() {
		var_query.array_get(rt.new_string('offset'))
	} else {
		rt.new_int(0)
	}
	mut var_per_page_raw := if !(var_query.array_get(rt.new_string('perPage'))).is_null() {
		var_query.array_get(rt.new_string('perPage'))
	} else {
		rt.new_null()
	}
	mut var_offset := if var_offset_raw.clone().is_long() || var_offset_raw.clone().is_double() { rt.call_function('max', [
			rt.new_int(0),
			rt.new_int(var_offset_raw.to_i64()),
		]) } else { rt.new_int(0) }
	mut var_per_page := if var_per_page_raw.clone().is_long() || var_per_page_raw.clone().is_double() { rt.call_function('max', [
			rt.new_int(1),
			rt.new_int(var_per_page_raw.to_i64()),
		]) } else { rt.new_int(9) }
	mut var_order := if !(var_query.array_get(rt.new_string('order'))).is_null() {
		var_query.array_get(rt.new_string('order'))
	} else {
		rt.new_string('asc')
	}
	mut var_search := if !(var_query.array_get(rt.new_string('search'))).is_null() {
		var_query.array_get(rt.new_string('search'))
	} else {
		rt.new_string('')
	}
	mut var_common_query_values := rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.new_array() },
		rt.ArrayItem{ key: 'posts_per_page', val: var_per_page },
		rt.ArrayItem{ key: 'order', val: var_order },
		rt.ArrayItem{ key: 'offset', val: rt.add(rt.mul(var_per_page, page - 1), var_offset) },
		rt.ArrayItem{ key: 'post__in', val: var_product_ids },
		rt.ArrayItem{ key: 'post_status', val: 'publish' },
		rt.ArrayItem{ key: 'post_type', val: 'product' },
		rt.ArrayItem{ key: 'tax_query', val: rt.new_array() },
		rt.ArrayItem{ key: 'paged', val: page },
		rt.ArrayItem{ key: 's', val: var_search },
	])
	mut var_is_on_sale := if !(var_query.array_get(rt.new_string('woocommerceOnSale'))).is_null() {
		var_query.array_get(rt.new_string('woocommerceOnSale'))
	} else {
		rt.new_bool(false)
	}
	mut var_order_by := if !(var_query.array_get(rt.new_string('orderBy'))).is_null() {
		var_query.array_get(rt.new_string('orderBy'))
	} else {
		rt.new_string('')
	}
	mut var_stock_status := if !(var_query.array_get(rt.new_string('woocommerceStockStatus'))).is_null() {
		var_query.array_get(rt.new_string('woocommerceStockStatus'))
	} else {
		rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))
	}
	mut var_product_attributes := if !(var_query.array_get(rt.new_string('woocommerceAttributes'))).is_null() {
		var_query.array_get(rt.new_string('woocommerceAttributes'))
	} else {
		rt.new_array()
	}
	mut var_taxonomies_query := this.get_filter_by_taxonomies_query(if !(var_query.array_get(rt.new_string('tax_query'))).is_null() {
		var_query.array_get(rt.new_string('tax_query'))
	} else {
		rt.new_array()
	})
	mut var_handpicked_products := if !(var_query.array_get(rt.new_string('woocommerceHandPickedProducts'))).is_null() {
		var_query.array_get(rt.new_string('woocommerceHandPickedProducts'))
	} else {
		rt.new_array()
	}
	mut var_time_frame := if !(var_query.array_get(rt.new_string('timeFrame'))).is_null() {
		var_query.array_get(rt.new_string('timeFrame'))
	} else {
		rt.new_null()
	}
	mut var_price_range := if !(var_query.array_get(rt.new_string('priceRange'))).is_null() {
		var_query.array_get(rt.new_string('priceRange'))
	} else {
		rt.new_null()
	}
	mut var_featured := if !(var_query.array_get(rt.new_string('featured'))).is_null() {
		var_query.array_get(rt.new_string('featured'))
	} else {
		rt.new_bool(false)
	}
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))).is_null() {
		this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))
	} else {
		rt.new_null()
	}
	if var_handlers.array_isset(rt.new_string('frontend_args')) {
		var_collection_args_mutated = rt.call_function('call_user_func', [
			var_handlers.array_get(rt.new_string('frontend_args')),
			var_collection_args_mutated.clone(),
			var_query.clone(),
		])
	}
	mut var_final_query := this.get_final_query_args(var_collection_args_mutated.clone(),
		var_common_query_values.clone(), rt.create_array([
		rt.ArrayItem{ key: 'on_sale', val: var_is_on_sale },
		rt.ArrayItem{ key: 'stock_status', val: var_stock_status },
		rt.ArrayItem{ key: 'orderby', val: var_order_by },
		rt.ArrayItem{ key: 'product_attributes', val: var_product_attributes },
		rt.ArrayItem{ key: 'taxonomies_query', val: var_taxonomies_query },
		rt.ArrayItem{ key: 'handpicked_products', val: var_handpicked_products },
		rt.ArrayItem{ key: 'featured', val: var_featured },
		rt.ArrayItem{ key: 'timeFrame', val: var_time_frame },
		rt.ArrayItem{ key: 'priceRange', val: var_price_range },
	]), is_exclude_applied_filters)
	return var_final_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_taxonomies_query(var_tax_query rt.PhpVal) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	if !(var_tax_query_mutated.clone().is_array()) {
		return rt.new_array()
	}
	mut var_product_taxonomies := rt.call_function('array_diff', [
		rt.call_function('get_object_taxonomies', [rt.new_string('product'),
			rt.new_string('names')]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product_visibility' },
			rt.ArrayItem{ key: none, val: 'product_shipping_class' }]),
	])
	closure_1_fn := fn [var_product_taxonomies] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_item.array_isset(rt.new_string('taxonomy'))
			&& rt.is_true(rt.call_function('in_array', [var_item.array_get(rt.new_string('taxonomy')), var_product_taxonomies.clone(), rt.new_bool(true)])))
	}
	mut var_result := rt.call_function('array_filter', [var_tax_query_mutated.clone(),
		rt.new_closure(closure_1_fn)])
	return if !(!rt.is_true(var_result)) { rt.create_array([
			rt.ArrayItem{ key: 'tax_query', val: var_result },
		]) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_final_query_args(var_collection_args rt.PhpVal, var_common_query_values rt.PhpVal, var_query rt.PhpVal, is_exclude_applied_filters bool) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_common_query_values_mutated := var_common_query_values
	mut var_orderby_query := if rt.is_true(var_query.array_get(rt.new_string('orderby'))) {
		this.get_custom_orderby_query(var_query.array_get(rt.new_string('orderby')))
	} else {
		rt.new_array()
	}
	mut var_on_sale_query :=
		this.get_on_sale_products_query(var_query.array_get(rt.new_string('on_sale')))
	mut var_stock_query :=
		this.get_stock_status_query(var_query.array_get(rt.new_string('stock_status')))
	mut var_visibility_query := if var_query.array_get(rt.new_string('stock_status')).is_array() {
		this.get_product_visibility_query(var_stock_query.clone(),
			var_query.array_get(rt.new_string('stock_status')))
	} else {
		rt.new_array()
	}
	mut var_featured_query := this.get_featured_query(if !(var_query.array_get(rt.new_string('featured'))).is_null() {
		var_query.array_get(rt.new_string('featured'))
	} else {
		rt.new_bool(false)
	})
	mut var_attributes_query :=
		this.get_product_attributes_query(var_query.array_get(rt.new_string('product_attributes')))
	mut var_taxonomies_query := if !(var_query.array_get(rt.new_string('taxonomies_query'))).is_null() {
		var_query.array_get(rt.new_string('taxonomies_query'))
	} else {
		rt.new_array()
	}
	mut var_tax_query := this.merge_tax_queries(var_visibility_query.clone(),
		var_attributes_query.clone(), var_taxonomies_query.clone(), var_featured_query.clone())
	mut var_date_query := this.get_date_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array](if !(var_query.array_get(rt.new_string('timeFrame'))).is_null() {
		var_query.array_get(rt.new_string('timeFrame'))
	} else {
		rt.new_array()
	}))
	mut var_price_query_args := this.get_price_range_query_args(if !(var_query.array_get(rt.new_string('priceRange'))).is_null() {
		var_query.array_get(rt.new_string('priceRange'))
	} else {
		rt.new_array()
	})
	mut var_handpicked_query := this.get_handpicked_query(if !(var_query.array_get(rt.new_string('handpicked_products'))).is_null() {
		var_query.array_get(rt.new_string('handpicked_products'))
	} else {
		rt.new_bool(false)
	})
	mut var_applied_filters_query := if var_is_exclude_applied_filters {
		rt.new_array()
	} else {
		this.get_queries_by_applied_filters()
	}
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))).is_null() {
		this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))
	} else {
		rt.new_null()
	}
	if var_handlers.array_isset(rt.new_string('build_query')) {
		mut var_collection_query := rt.call_function('call_user_func', [
			var_handlers.array_get(rt.new_string('build_query')),
			var_collection_args_mutated.clone(),
			var_common_query_values_mutated.clone(),
			var_query.clone(),
			rt.new_bool(is_exclude_applied_filters),
		])
	} else {
		var_collection_query = rt.new_array()
	}
	return this.merge_queries(var_common_query_values_mutated.clone(), var_orderby_query.clone(),
		var_on_sale_query.clone(), var_stock_query.clone(), var_tax_query.clone(),
		var_applied_filters_query.clone(), var_date_query.clone(), var_price_query_args.clone(),
		var_handpicked_query.clone(), var_collection_query.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_preview_query_args(var_collection_args rt.PhpVal, var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_collection_args_mutated := var_collection_args
	mut var_args_mutated := var_args
	mut var_collection_query := rt.new_array()
	mut var_handlers := if !(this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))).is_null() {
		this.collection_handler_store.array_get(var_collection_args_mutated.array_get(rt.new_string('name')))
	} else {
		rt.new_null()
	}
	if var_handlers.array_isset(rt.new_string('preview_query')) {
		var_collection_query = rt.call_function('call_user_func', [
			var_handlers.array_get(rt.new_string('preview_query')),
			var_collection_args_mutated.clone(),
			var_args_mutated.clone(),
			var_request.clone(),
		])
	}
	mut var_orderby_query := if rt.is_true(var_args_mutated.array_get(rt.new_string('orderby'))) {
		this.get_custom_orderby_query(var_args_mutated.array_get(rt.new_string('orderby')))
	} else {
		rt.new_array()
	}
	var_args_mutated = this.merge_queries(var_args_mutated.clone(), var_orderby_query.clone(),
		var_collection_query.clone())
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_stock_status_query(var_stock_statuses rt.PhpVal) rt.PhpVal {
	if !(var_stock_statuses.clone().is_array()) {
		return rt.new_array()
	}
	mut var_stock_status_options := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
		[]rt.PhpVal{}))
	if var_stock_statuses.clone().array_count() == var_stock_status_options.clone().array_count()
		&& rt.is_true(rt.identical(rt.call_function('array_diff', [var_stock_statuses.clone(), var_stock_status_options.clone()]), rt.call_function('array_diff', [var_stock_status_options.clone(), var_stock_statuses.clone()]))) {
		return rt.new_array()
	}
	mut var_diff := rt.call_function('array_diff', [var_stock_status_options.clone(),
		var_stock_statuses.clone()])
	if var_diff.clone().array_count() == 1
		&& rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), var_diff.clone(), rt.new_bool(true)])) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_stock_status' },
				rt.ArrayItem{ key: 'value', val: rt.cast_array(var_stock_statuses) },
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_tax_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_tax_query := rt.new_array()
	mut iter_1 := var_queries_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_query := item_1.val
		if !(!rt.is_true(var_query.array_get(rt.new_string('tax_query')))) {
			var_tax_query = rt.call_function('array_merge', [
				var_tax_query.clone(), var_query.array_get(rt.new_string('tax_query'))])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'tax_query', val: var_tax_query }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_product_attributes_query(var_attributes rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_attributes) {
		return rt.new_array()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_item := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_taxonomy := rt.call_function('sanitize_title', [
			var_item.array_get(rt.new_string('taxonomy')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('key_exists', [
			var_taxonomy.clone(),
			var_carry.clone(),
		])))))
		{
			var_carry.array_set(var_taxonomy, rt.create_array([
				rt.ArrayItem{ key: 'field', val: 'term_id' },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
				rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{ key: none, val: var_item.array_get(rt.new_string('termId')) },
				]) },
			]))
		} else {
			var_carry.array_get_mut(var_taxonomy).array_get_mut('terms').array_push(var_item.array_get(rt.new_string('termId')))
		}
		return var_carry.clone()
	}
	mut var_grouped_attributes := rt.call_function('array_reduce', [
		var_attributes.clone(), rt.new_closure(closure_2_fn),
		rt.new_array()])
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.call_function('array_values', [
			var_grouped_attributes.clone(),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_featured_query(var_featured rt.PhpVal) rt.PhpVal {
	mut var_featured_mutated := var_featured
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_featured_mutated))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('true'), var_featured_mutated)))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'name' },
				rt.ArrayItem{ key: 'terms', val: 'featured' },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_price_query() rt.PhpVal {
	mut var_min_price := rt.call_function('get_query_var', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.min_price_query_var(),
	])
	mut var_max_price := rt.call_function('get_query_var', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.max_price_query_var(),
	])
	mut var_max_price_query := if !rt.is_true(var_max_price) { rt.new_array() } else { rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_price' },
			rt.ArrayItem{ key: 'value', val: var_max_price },
			rt.ArrayItem{ key: 'compare', val: '<=' },
			rt.ArrayItem{ key: 'type', val: 'numeric' },
		]) }
	mut var_min_price_query := if !rt.is_true(var_min_price) { rt.new_array() } else { rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_price' },
			rt.ArrayItem{ key: 'value', val: var_min_price },
			rt.ArrayItem{ key: 'compare', val: '>=' },
			rt.ArrayItem{ key: 'type', val: 'numeric' },
		]) }
	if !rt.is_true(var_min_price_query) && !rt.is_true(var_max_price_query) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: var_max_price_query },
				rt.ArrayItem{ key: none, val: var_min_price_query },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_attributes_query() rt.PhpVal {
	mut var_attributes_filter_query_args := this.get_filter_by_attributes_query_vars()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query_args := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_attribute_name := var_query_args.array_get(rt.new_string('filter'))
		mut var_attribute_query_type := var_query_args.array_get(rt.new_string('query_type'))
		mut var_attribute_value := rt.call_function('get_query_var', [
			var_attribute_name.clone()])
		mut var_attribute_query := rt.call_function('get_query_var', [
			var_attribute_query_type.clone()])
		if !rt.is_true(var_attribute_value) {
			return var_acc.clone()
		}
		var_attribute_value = rt.call_function('explode', [rt.new_string(','),
			var_attribute_value.clone()])
		var_acc.array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('str_replace', [
				Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter.filter_query_var_prefix(),
				rt.new_string('pa_'),
				var_attribute_name.clone(),
			]) },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: var_attribute_value },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(rt.new_string('and'), var_attribute_query)) {
					'AND'
				} else {
					'IN'
				}
			},
		]))
		return var_acc.clone()
	}
	mut var_queries := rt.call_function('array_reduce', [var_attributes_filter_query_args.clone(),
		rt.new_closure(closure_3_fn), rt.new_array()])
	if !rt.is_true(var_queries) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: var_queries },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_attributes_query_vars() rt.PhpVal {
	if !(!rt.is_true(this.attributes_filter_query_args)) {
		return this.attributes_filter_query_args
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_attribute := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_acc.array_set(rt.get_property(var_attribute, 'attribute_name'), rt.create_array([
			rt.ArrayItem{ key: 'filter', val:
				(Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter.filter_query_var_prefix()).str() +
				(rt.get_property(var_attribute, 'attribute_name')).str() },
			rt.ArrayItem{ key: 'query_type', val:
				(Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter.query_type_query_var_prefix()).str() +
				(rt.get_property(var_attribute, 'attribute_name')).str() },
		]))
		return var_acc.clone()
	}
	this.attributes_filter_query_args = rt.call_function('array_reduce', [
		rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
		rt.new_closure(closure_4_fn),
		rt.new_array(),
	])
	return this.attributes_filter_query_args
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_stock_status_query() rt.PhpVal {
	mut var_filter_stock_status_values := rt.call_function('get_query_var', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.stock_status_query_var(),
	])
	if !rt.is_true(var_filter_stock_status_values) {
		return rt.new_array()
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_stock_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter{}
		mut iife_result_5 := iife_temp_5.get_stock_status_query_var_values()
		return rt.call_function('in_array',
			[var_stock_status.clone(), iife_result_5, rt.new_bool(true)])
	}
	mut var_filtered_stock_status_values := rt.call_function('array_filter', [
		rt.call_function('explode', [rt.new_string(','), var_filter_stock_status_values.clone()]),
		rt.new_closure(closure_6_fn),
	])
	if !rt.is_true(var_filtered_stock_status_values) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_stock_status' },
				rt.ArrayItem{ key: 'value', val: var_filtered_stock_status_values },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_rating_query() rt.PhpVal {
	mut var_filter_rating_values := rt.call_function('get_query_var', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_RatingFilter.rating_query_var(),
	])
	if !rt.is_true(var_filter_rating_values) {
		return rt.new_array()
	}
	mut var_parsed_filter_rating_values := rt.call_function('explode', [
		rt.new_string(','),
		var_filter_rating_values.clone(),
	])
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	if !rt.is_true(var_parsed_filter_rating_values) || !rt.is_true(var_product_visibility_terms) {
		return rt.new_array()
	}
	closure_7_fn := fn [var_product_visibility_terms] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_rating := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_visibility_terms.array_get(rt.new_string('rated-' + var_rating.str()))
	}
	closure_8_fn := fn [var_product_visibility_terms] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_rating := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_visibility_terms.array_get(rt.new_string('rated-' + var_rating.str()))
	}
	mut var_rating_terms := rt.call_function('array_map', [rt.new_closure(closure_7_fn),
		var_parsed_filter_rating_values.clone()])
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'terms', val: var_rating_terms },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
				rt.ArrayItem{ key: 'rating_filter', val: true },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_filter_by_taxonomy_query() rt.PhpVal {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_params_handler := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Automattic_WooCommerce_Internal_ProductFilters_Params.class(),
	])
	mut var_taxonomy_params := rt.call_method(var_params_handler, 'get_param', [
		rt.new_string('taxonomy'),
	])
	if !rt.is_true(var_taxonomy_params) {
		return rt.new_array()
	}
	mut var_tax_queries := rt.new_array()
	mut iter_2 := var_taxonomy_params.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_param_key := item_2.val
		mut var_taxonomy_slug := item_2.key
		mut var_param_value := rt.call_function('get_query_var', [
			var_param_key.clone()])
		if !(var_param_value.clone().is_string()) || !rt.is_true(var_param_value) {
			continue
		}
		mut var_term_values := rt.call_function('explode', [rt.new_string(','),
			var_param_value.clone()])
		mut var_term_slugs := rt.call_function('array_values', [
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('sanitize_title'),
					var_term_values.clone()]),
			]),
		])
		if !rt.is_true(var_term_slugs) {
			continue
		}
		var_tax_queries.array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_slug },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: var_term_slugs },
			rt.ArrayItem{ key: 'operator', val: 'IN' },
		]))
	}
	if !rt.is_true(var_tax_queries) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: var_tax_queries },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) array_merge_recursive_replace_non_array_properties(var_base rt.PhpVal, var_new_array rt.PhpVal) rt.PhpVal {
	mut var_base_mutated := var_base
	mut iter_3 := var_new_array.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if rt.is_true(rt.new_bool(var_key.clone().is_long() || var_key.clone().is_double())) {
			var_base_mutated.array_push(var_value.clone())
		} else if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			if !(var_base_mutated.array_isset(var_key)) {
				var_base_mutated.array_set(var_key, rt.new_array())
			}
			var_base_mutated.array_set(var_key, this.array_merge_recursive_replace_non_array_properties(var_base_mutated.array_get(var_key),
				var_value.clone()))
		} else {
			var_base_mutated.array_set(var_key, var_value.clone())
		}
	}
	return var_base_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_queries_by_applied_filters() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'price_filter', val: this.get_filter_by_price_query() },
		rt.ArrayItem{ key: 'attributes_filter', val: this.get_filter_by_attributes_query() },
		rt.ArrayItem{ key: 'stock_status_filter', val: this.get_filter_by_stock_status_query() },
		rt.ArrayItem{ key: 'rating_filter', val: this.get_filter_by_rating_query() },
		rt.ArrayItem{ key: 'taxonomy_filter', val: this.get_filter_by_taxonomy_query() },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_product_visibility_query(var_stock_query rt.PhpVal, var_stock_status rt.PhpVal) rt.PhpVal {
	mut var_stock_query_mutated := var_stock_query
	mut var_stock_status_mutated := var_stock_status
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	mut var_product_visibility_not_in := rt.create_array([
		rt.ArrayItem{
			key: none
			val: if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
				var_product_visibility_terms.array_get(rt.new_string('exclude-from-search'))
			} else {
				var_product_visibility_terms.array_get(rt.new_string('exclude-from-catalog'))
			}
		},
	])
	if !rt.is_true(var_stock_query_mutated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), var_stock_status_mutated.clone(), rt.new_bool(true)]))))) {
		var_product_visibility_not_in.array_push(var_product_visibility_terms.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'terms', val: var_product_visibility_not_in },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_date_query(mut var_time_frame Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array) rt.PhpVal {
	mut var_time_frame_mutated := var_time_frame
	if !rt.is_true(var_time_frame_mutated.array_get(rt.new_string('operator')))
		|| !rt.is_true(var_time_frame_mutated.array_get(rt.new_string('value'))) {
		return rt.new_array()
	}
	mut var_query_operator := rt.new_string((if rt.is_true(rt.identical(rt.new_string('in'),
		var_time_frame_mutated.array_get(rt.new_string('operator'))))
	{
		'after'
	} else {
		'before'
	}).str())
	return rt.create_array([
		rt.ArrayItem{ key: 'date_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'column', val: 'post_date_gmt' },
				rt.ArrayItem{
					key: var_query_operator
					val: var_time_frame_mutated.array_get(rt.new_string('value'))
				},
				rt.ArrayItem{ key: 'inclusive', val: true },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_price_range_query_args(var_price_range rt.PhpVal) rt.PhpVal {
	mut var_price_range_mutated := var_price_range
	if !rt.is_true(var_price_range_mutated) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'isProductCollection', val: true },
		rt.ArrayItem{ key: 'priceRange', val: var_price_range_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_price_range_filter_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_clauses_mutated := var_clauses
	mut var_query_vars := rt.get_property(var_query, 'query_vars')
	mut var_is_product_collection_block := if !(var_query_vars.array_get(rt.new_string('isProductCollection'))).is_null() {
		var_query_vars.array_get(rt.new_string('isProductCollection'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_clauses_mutated.clone()
	}
	mut var_price_range := if !(var_query_vars.array_get(rt.new_string('priceRange'))).is_null() {
		var_query_vars.array_get(rt.new_string('priceRange'))
	} else {
		rt.new_null()
	}
	if !rt.is_true(var_price_range) {
		return var_clauses_mutated.clone()
	}
	mut var_adjust_for_taxes := rt.new_bool(this.should_adjust_price_range_for_taxes())
	var_clauses_mutated.array_set('join',
		this.append_product_sorting_table_join(var_clauses_mutated.array_get(rt.new_string('join'))))
	mut var_min_price := if !(var_price_range.array_get(rt.new_string('min'))).is_null() {
		var_price_range.array_get(rt.new_string('min'))
	} else {
		rt.new_null()
	}
	if rt.is_true(var_min_price) {
		if rt.is_true(var_adjust_for_taxes) {
			var_clauses_mutated.array_get(rt.new_string('where')) = rt.concat(var_clauses_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_min_price.clone(),
				'max_price', '>='))
		} else {
			var_clauses_mutated.array_get(rt.new_string('where')) = rt.concat(var_clauses_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.max_price >= %f '),
				var_min_price.clone(),
			]))
		}
	}
	mut var_max_price := if !(var_price_range.array_get(rt.new_string('max'))).is_null() {
		var_price_range.array_get(rt.new_string('max'))
	} else {
		rt.new_null()
	}
	if rt.is_true(var_max_price) {
		if rt.is_true(var_adjust_for_taxes) {
			var_clauses_mutated.array_get(rt.new_string('where')) = rt.concat(var_clauses_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_max_price.clone(),
				'min_price', '<='))
		} else {
			var_clauses_mutated.array_get(rt.new_string('where')) = rt.concat(var_clauses_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.min_price <= %f '),
				var_max_price.clone(),
			]))
		}
	}
	return var_clauses_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	mut var_product_tax_classes := rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.new_string('SELECT DISTINCT tax_class FROM '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(';')),
	])
	if !rt.is_true(var_product_tax_classes) {
		return ''
	}
	mut var_or_queries := rt.new_array()
	mut iter_4 := var_product_tax_classes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_tax_class := item_4.val
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_tax_display := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut iife_temp_8 := Class_WC_Tax{}
	mut iife_result_8 := iife_temp_8.get_rates(var_tax_class.clone())
	mut var_tax_rates := iife_result_8
	mut iife_temp_9 := Class_WC_Tax{}
	mut iife_result_9 := iife_temp_9.get_base_tax_rates(var_tax_class.clone())
	mut var_base_tax_rates := iife_result_9
	if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display)) {
		mut iife_temp_10 := Class_WC_Tax{}
		mut iife_result_10 := iife_temp_10.calc_tax(var_price_filter.clone(),
			var_base_tax_rates.clone(), rt.new_bool(true))
		mut iife_temp_11 := Class_WC_Tax{}
		mut iife_result_11 := iife_temp_11.calc_tax(var_price_filter.clone(),
			var_tax_rates.clone(), rt.new_bool(true))
		mut var_taxes := if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_adjust_non_base_location_prices'),
			rt.new_bool(true),
		]))
		{ iife_result_10 } else { iife_result_11 }
		return rt.sub(var_price_filter, rt.call_function('array_sum', [
			var_taxes.clone()]))
	}
	mut iife_temp_12 := Class_WC_Tax{}
	mut iife_result_12 := iife_temp_12.calc_tax(var_price_filter.clone(), var_tax_rates.clone(),
		rt.new_bool(false))
	var_taxes = iife_result_12
	return rt.add(var_price_filter, rt.call_function('array_sum', [
		var_taxes.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) should_adjust_price_range_for_taxes() bool {
	mut var_display_setting := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut var_price_storage_method := rt.new_string((if rt.is_true(rt.call_function('wc_prices_include_tax',
		[]rt.PhpVal{}))
	{
		'incl'
	} else {
		'excl'
	}).str())
	return rt.new_bool(!rt.is_true(rt.identical(var_display_setting, var_price_storage_method)))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_handpicked_query(var_handpicked_products rt.PhpVal) rt.PhpVal {
	mut var_handpicked_products_mutated := var_handpicked_products
	if rt.is_true(rt.identical(rt.new_bool(false), var_handpicked_products_mutated)) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'post__in', val: var_handpicked_products_mutated },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_on_sale_products_query(var_is_on_sale rt.PhpVal) rt.PhpVal {
	mut var_is_on_sale_mutated := var_is_on_sale
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_on_sale_mutated)))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'post__in', val: rt.call_function('wc_get_product_ids_on_sale',
			[]rt.PhpVal{}) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	mut var_special_query_vars := rt.create_array([
		rt.ArrayItem{ key: 'post__in', val: rt.new_array() },
	])
	mut var_special_query_keys := rt.func_array_keys(var_special_query_vars.clone())
	closure_14_fn := fn [var_special_query_keys, mut var_special_query_vars] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_query.clone().is_array()) {
			return var_acc.clone()
		}
		if !(!rt.is_true(var_query))
			&& !rt.is_true(rt.call_function('array_intersect', [this.get_valid_query_vars(), rt.func_array_keys(var_query.clone())])) {
			return this.merge_queries(var_acc.clone(), rt.call_function('array_values', [
				var_query.clone(),
			]))
		}
		mut iter_5 := var_special_query_keys.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_query_var := item_5.val
			if var_query.array_isset(var_query_var) {
				var_special_query_vars.array_get_mut(var_query_var).array_push(var_query.array_get(var_query_var))
				var_query.array_unset(var_query_var)
			}
		}
		return this.array_merge_recursive_replace_non_array_properties(var_acc.clone(),
			var_query.clone())
	}
	mut var_merged_query := rt.call_function('array_reduce', [
		var_queries_mutated.clone(), rt.new_closure(closure_14_fn),
		rt.new_array()])
	var_merged_query.array_set('post__in',
		this.merge_post__in(var_special_query_vars.array_get(rt.new_string('post__in'))))
	return var_merged_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) get_custom_orderby_query(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_orderby_mutated.clone(), this.custom_order_opts, rt.new_bool(true)])))))
		|| rt.is_true(rt.identical(rt.new_string('post__in'), var_orderby_mutated)) {
		return rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	if rt.is_true(rt.identical(rt.new_string('price'), var_orderby_mutated)) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_price_sorting_posts_clauses' },
			]),
			rt.new_int(10), rt.new_int(2)])
		return rt.create_array([rt.ArrayItem{ key: 'isProductCollection', val: true },
			rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	if rt.is_true(rt.identical(rt.new_string('sales'), var_orderby_mutated))
		|| rt.is_true(rt.identical(rt.new_string('popularity'), var_orderby_mutated)) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_sales_sorting_posts_clauses' },
			]),
			rt.new_int(10), rt.new_int(2)])
		return rt.create_array([rt.ArrayItem{ key: 'isProductCollection', val: true },
			rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	if rt.is_true(rt.identical(rt.new_string('menu_order'), var_orderby_mutated)) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_menu_order_with_title_fallback_posts_clauses' },
			]),
			rt.new_int(10), rt.new_int(2)])
		return rt.create_array([rt.ArrayItem{ key: 'isProductCollection', val: true },
			rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	if rt.is_true(rt.identical(rt.new_string('random'), var_orderby_mutated)) {
		return rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'rand' }])
	}
	mut var_meta_keys := rt.create_array([
		rt.ArrayItem{ key: 'rating', val: '_wc_average_rating' },
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_key', val: var_meta_keys.array_get(var_orderby_mutated) },
		rt.ArrayItem{ key: 'orderby', val: 'meta_value_num' },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_price_sorting_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
	mut var_query_vars := rt.get_property(var_query, 'query_vars')
	mut var_is_product_collection_block := if !(var_query_vars.array_get(rt.new_string('isProductCollection'))).is_null() {
		var_query_vars.array_get(rt.new_string('isProductCollection'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_clauses_mutated.clone()
	}
	mut var_orderby := if !(var_query_vars.array_get(rt.new_string('orderby'))).is_null() {
		var_query_vars.array_get(rt.new_string('orderby'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('price'), var_orderby)))) {
		return var_clauses_mutated.clone()
	}
	var_clauses_mutated.array_set('join',
		this.append_product_sorting_table_join(var_clauses_mutated.array_get(rt.new_string('join'))))
	mut var_is_ascending_order := rt.identical(rt.new_string('asc'), rt.new_string(if !(var_query_vars.array_get(rt.new_string('order'))).is_null() {
		var_query_vars.array_get(rt.new_string('order'))
	} else {
		rt.new_string('desc')
	}.to_string().to_lower()))
	var_clauses_mutated.array_set('orderby', if rt.is_true(var_is_ascending_order) {
		'wc_product_meta_lookup.min_price ASC, wc_product_meta_lookup.product_id ASC'
	} else {
		'wc_product_meta_lookup.max_price DESC, wc_product_meta_lookup.product_id DESC'
	})
	return var_clauses_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_sales_sorting_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
	mut var_query_vars := rt.get_property(var_query, 'query_vars')
	mut var_is_product_collection_block := if !(var_query_vars.array_get(rt.new_string('isProductCollection'))).is_null() {
		var_query_vars.array_get(rt.new_string('isProductCollection'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_clauses_mutated.clone()
	}
	mut var_orderby := if !(var_query_vars.array_get(rt.new_string('orderby'))).is_null() {
		var_query_vars.array_get(rt.new_string('orderby'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('sales'), var_orderby))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('popularity'), var_orderby)))) {
		return var_clauses_mutated.clone()
	}
	var_clauses_mutated.array_set('join',
		this.append_product_sorting_table_join(var_clauses_mutated.array_get(rt.new_string('join'))))
	mut var_is_ascending_order := rt.identical(rt.new_string('asc'), rt.new_string(if !(var_query_vars.array_get(rt.new_string('order'))).is_null() {
		var_query_vars.array_get(rt.new_string('order'))
	} else {
		rt.new_string('desc')
	}.to_string().to_lower()))
	var_clauses_mutated.array_set('orderby', if rt.is_true(var_is_ascending_order) {
		'wc_product_meta_lookup.total_sales ASC, wc_product_meta_lookup.product_id ASC'
	} else {
		'wc_product_meta_lookup.total_sales DESC, wc_product_meta_lookup.product_id DESC'
	})
	return var_clauses_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) merge_post__in(var_post__in rt.PhpVal) rt.PhpVal {
	mut var_post__in_mutated := var_post__in
	if !rt.is_true(var_post__in_mutated) {
		return rt.new_array()
	}
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_val := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_val.clone().is_array() && !(!rt.is_true(var_val)))
	}
	var_post__in_mutated = rt.call_function('array_filter', [
		var_post__in_mutated.clone(), rt.new_closure(closure_15_fn)])
	if !rt.is_true(var_post__in_mutated) {
		return rt.new_array()
	}
	if var_post__in_mutated.clone().array_count() > 1 {
		var_post__in_mutated = rt.call_function('array_intersect', [
			var_post__in_mutated.clone()])
		if !rt.is_true(var_post__in_mutated) {
			return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
		}
	} else {
		var_post__in_mutated = rt.call_function('reset', [var_post__in_mutated.clone()])
	}
	return rt.call_function('array_values', [
		rt.call_function('array_unique', [var_post__in_mutated.clone(),
			rt.get_constant('SORT_NUMERIC')]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) add_menu_order_with_title_fallback_posts_clauses(var_clauses rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_clauses_mutated := var_clauses
	mut var_query_vars := rt.get_property(var_query, 'query_vars')
	mut var_is_product_collection_block := if !(var_query_vars.array_get(rt.new_string('isProductCollection'))).is_null() {
		var_query_vars.array_get(rt.new_string('isProductCollection'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_clauses_mutated.clone()
	}
	mut var_orderby := if !(var_query_vars.array_get(rt.new_string('orderby'))).is_null() {
		var_query_vars.array_get(rt.new_string('orderby'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('menu_order'), var_orderby)))) {
		return var_clauses_mutated.clone()
	}
	mut var_is_ascending_order := rt.new_bool(!(var_query_vars.array_isset(rt.new_string('order')))
		|| rt.is_true(rt.identical(rt.new_string('asc'), rt.new_string(var_query_vars.array_get(rt.new_string('order')).to_string().to_lower()))))
	var_clauses_mutated.array_set('orderby', if rt.is_true(var_is_ascending_order) {
		'menu_order ASC, post_title ASC'
	} else {
		'menu_order DESC, post_title DESC'
	})
	return var_clauses_mutated.clone()
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_querybuilder() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder{
		PhpObjectBase:                rt.PhpObjectBase{}
		valid_query_vars:             rt.new_null()
		custom_order_opts:            rt.new_array()
		attributes_filter_query_args: rt.new_array()
		collection_handler_store:     rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_stockfilter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter{
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
			return this.get_final_frontend_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			return this.get_final_query_args(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			return this.array_merge_recursive_replace_non_array_properties(dispatch_arg_0,
				dispatch_arg_1)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filter_for_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_price_filter_for_tax_class(dispatch_arg_0, dispatch_arg_1)
		}
		'should_adjust_price_range_for_taxes' {
			return rt.new_bool(this.should_adjust_price_range_for_taxes())
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
			return this.add_menu_order_with_title_fallback_posts_clauses(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
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
		'valid_query_vars' {
			this.valid_query_vars = val
			return true
		}
		'custom_order_opts' {
			this.custom_order_opts = val
			return true
		}
		'attributes_filter_query_args' {
			this.attributes_filter_query_args = val
			return true
		}
		'collection_handler_store' {
			this.collection_handler_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
