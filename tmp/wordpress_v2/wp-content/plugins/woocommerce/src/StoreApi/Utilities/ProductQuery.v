import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'offset', val: var_request.array_get(rt.new_string('offset')) },
		rt.ArrayItem{ key: 'order', val: var_request.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'orderby', val: var_request.array_get(rt.new_string('orderby')) },
		rt.ArrayItem{ key: 'paged', val: var_request.array_get(rt.new_string('page')) },
		rt.ArrayItem{ key: 'post__in', val: var_request.array_get(rt.new_string('include')) },
		rt.ArrayItem{ key: 'post__not_in', val: var_request.array_get(rt.new_string('exclude')) },
		rt.ArrayItem{
			key: 'posts_per_page'
			val: if rt.is_true(var_request.array_get(rt.new_string('per_page'))) {
				var_request.array_get(rt.new_string('per_page'))
			} else {
				-1
			}
		},
		rt.ArrayItem{ key: 'post_parent__in', val: var_request.array_get(rt.new_string('parent')) },
		rt.ArrayItem{
			key: 'post_parent__not_in'
			val: var_request.array_get(rt.new_string('parent_exclude'))
		},
		rt.ArrayItem{ key: 'search', val: var_request.array_get(rt.new_string('search')) },
		rt.ArrayItem{ key: 'slug', val: var_request.array_get(rt.new_string('slug')) },
		rt.ArrayItem{ key: 'fields', val: 'ids' },
		rt.ArrayItem{ key: 'ignore_sticky_posts', val: true },
		rt.ArrayItem{
			key: 'post_status'
			val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
		},
		rt.ArrayItem{ key: 'date_query', val: rt.new_array() },
		rt.ArrayItem{ key: 'post_type', val: 'product' },
	])
	if !(!rt.is_true(var_request.array_get(rt.new_string('sku'))))
		|| !(!rt.is_true(var_request.array_get(rt.new_string('slug')))) {
		var_args.array_set('post_type', rt.create_array([
			rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' },
		]))
	}
	mut var_tax_query := rt.new_array()
	if !(!rt.is_true(var_request.array_get(rt.new_string('type')))) {
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(),
			var_request.array_get(rt.new_string('type'))))
		{
			var_args.array_set('post_type', 'product_variation')
		} else {
			var_args.array_set('post_type', 'product')
			var_tax_query.array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_type' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: var_request.array_get(rt.new_string('type')) },
			]))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get(rt.new_string('orderby')))) {
		var_args.array_set('orderby', 'date ID')
	}
	if var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('before',
			var_request.array_get(rt.new_string('before')))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('after',
			var_request.array_get(rt.new_string('after')))
	}
	if var_request.array_isset(rt.new_string('date_column'))
		&& !(!rt.is_true(var_args.array_get(rt.new_string('date_query')).array_get(rt.new_int(0)))) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('column', 'post_' +
			(var_request.array_get(rt.new_string('date_column'))).str())
	}
	mut var_custom_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'sku' },
		rt.ArrayItem{ key: none, val: 'min_price' }, rt.ArrayItem{ key: none, val: 'max_price' },
		rt.ArrayItem{ key: none, val: 'stock_status' }])
	mut iter_1 := var_custom_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if !(!rt.is_true(var_request.array_get(var_key))) {
			var_args.array_set(var_key, var_request.array_get(var_key))
		}
	}
	mut var_operator_mapping := rt.create_array([rt.ArrayItem{ key: 'in', val: 'IN' },
		rt.ArrayItem{ key: 'not_in', val: 'NOT IN' }, rt.ArrayItem{ key: 'and', val: 'AND' }])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string('_unstable_tax_' + var_value.str())
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_string('_unstable_tax_' + var_value.str())
	}
	mut var_all_product_taxonomies := rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		rt.call_function('get_taxonomies', [
			rt.create_array([
				rt.ArrayItem{ key: 'object_type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'product' },
				]) },
			]),
			rt.new_string('names'),
		]),
	])
	mut var_default_taxonomies := rt.create_array([
		rt.ArrayItem{ key: 'product_cat', val: 'category' },
		rt.ArrayItem{ key: 'product_tag', val: 'tag' },
		rt.ArrayItem{ key: 'product_brand', val: 'brand' },
	])
	mut var_taxonomies := rt.call_function('array_merge', [var_all_product_taxonomies.clone(),
		var_default_taxonomies.clone()])
	mut iter_2 := var_taxonomies.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		mut var_taxonomy := item_2.key
		if !(!rt.is_true(var_request.array_get(var_key))) {
			mut var_type := rt.new_string((if
				var_request.array_get(var_key).array_get(rt.new_int(0)).is_long()
				|| var_request.array_get(var_key).array_get(rt.new_int(0)).is_double() {
				'term_id'
			} else {
				'slug'
			}).str())
			mut var_operator := if rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string(var_key.str() + '_operator')])) && var_operator_mapping.array_isset(rt.call_method(var_request, 'get_param', [rt.new_string(var_key.str() + '_operator')])) { var_operator_mapping.array_get(rt.call_method(var_request, 'get_param', [
					rt.new_string(var_key.str() + '_operator'),
				])) } else { rt.new_string('IN') }
			var_tax_query.array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'field', val: var_type },
				rt.ArrayItem{ key: 'terms', val: var_request.array_get(var_key) },
				rt.ArrayItem{ key: 'operator', val: var_operator },
			]))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('attributes')))) {
		mut var_att_queries := rt.new_array()
		mut iter_3 := var_request.array_get(rt.new_string('attributes')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute := item_3.val
			if !rt.is_true(var_attribute.array_get(rt.new_string('term_id')))
				&& !rt.is_true(var_attribute.array_get(rt.new_string('slug'))) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [
				var_attribute.array_get(rt.new_string('attribute')),
				rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}),
				rt.new_bool(true),
			]))
			{
				mut var_operator := if var_attribute.array_isset(rt.new_string('operator'))
					&& var_operator_mapping.array_isset(var_attribute.array_get(rt.new_string('operator'))) {
					var_operator_mapping.array_get(var_attribute.array_get(rt.new_string('operator')))
				} else {
					rt.new_string('IN')
				}
				var_att_queries.array_push(rt.create_array([
					rt.ArrayItem{
						key: 'taxonomy'
						val: var_attribute.array_get(rt.new_string('attribute'))
					},
					rt.ArrayItem{
						key: 'field'
						val: if !(!rt.is_true(var_attribute.array_get(rt.new_string('term_id')))) {
							'term_id'
						} else {
							'slug'
						}
					},
					rt.ArrayItem{
						key: 'terms'
						val: if !(!rt.is_true(var_attribute.array_get(rt.new_string('term_id')))) {
							var_attribute.array_get(rt.new_string('term_id'))
						} else {
							var_attribute.array_get(rt.new_string('slug'))
						}
					},
					rt.ArrayItem{ key: 'operator', val: var_operator },
				]))
			}
		}
		if 1 < var_att_queries.clone().array_count() {
			mut var_relation := if rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('attribute_relation')])) && var_operator_mapping.array_isset(rt.call_method(var_request, 'get_param', [rt.new_string('attribute_relation')])) { var_operator_mapping.array_get(rt.call_method(var_request, 'get_param', [
					rt.new_string('attribute_relation'),
				])) } else { rt.new_string('IN') }
			var_tax_query.array_push(rt.create_array([
				rt.ArrayItem{ key: 'relation', val: var_relation },
				rt.ArrayItem{ key: none, val: var_att_queries },
			]))
		} else {
			var_tax_query = rt.call_function('array_merge', [
				var_tax_query.clone(), var_att_queries.clone()])
		}
	}
	if !(!rt.is_true(var_tax_query))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_variation'), var_args.array_get(rt.new_string('post_type')))))) {
		if !(!rt.is_true(var_args.array_get(rt.new_string('tax_query')))) {
			var_args.array_set('tax_query', rt.call_function('array_merge', [
				var_tax_query.clone(), var_args.array_get(rt.new_string('tax_query'))]))
		} else {
			var_args.array_set('tax_query', var_tax_query.clone())
		}
	} else {
		if !(!rt.is_true(var_args.array_get(rt.new_string('tax_query')))) {
			var_args.array_set('meta_query', this.convert_tax_query_to_meta_query(rt.call_function('array_merge', [
				var_tax_query.clone(),
				var_args.array_get(rt.new_string('tax_query')),
			])))
		} else {
			var_args.array_set('meta_query',
				this.convert_tax_query_to_meta_query(var_tax_query.clone()))
		}
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('featured')).is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
			rt.ArrayItem{ key: 'field', val: 'name' },
			rt.ArrayItem{ key: 'terms', val: 'featured' },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(rt.new_bool(true),
					var_request.array_get(rt.new_string('featured'))))
				{
					'IN'
				} else {
					'NOT IN'
				}
			},
		]))
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('on_sale')).is_bool())) {
		mut var_on_sale_key := rt.new_string((if rt.is_true(var_request.array_get(rt.new_string('on_sale'))) {
			'post__in'
		} else {
			'post__not_in'
		}).str())
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([
				rt.ArrayItem{ key: none, val: 0 },
			]) } else { var_on_sale_ids }
		var_args.array_get(var_on_sale_key) = rt.add(var_args.array_get(var_on_sale_key),
			var_on_sale_ids)
	}
	mut var_catalog_visibility := rt.call_method(var_request, 'get_param', [
		rt.new_string('catalog_visibility'),
	])
	mut var_rating := rt.call_method(var_request, 'get_param', [
		rt.new_string('rating')])
	mut var_visibility_options := rt.call_function('wc_get_product_visibility_options',
		[]rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [var_catalog_visibility.clone(),
		rt.func_array_keys(var_visibility_options.clone()), rt.new_bool(true)]))
	{
		mut var_exclude_from_catalog := rt.new_string((if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.search(),
			var_catalog_visibility))
		{
			''
		} else {
			'exclude-from-catalog'
		}).str())
		mut var_exclude_from_search := rt.new_string((if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(),
			var_catalog_visibility))
		{
			''
		} else {
			'exclude-from-search'
		}).str())
		var_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
			rt.ArrayItem{ key: 'field', val: 'name' },
			rt.ArrayItem{ key: 'terms', val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_exclude_from_catalog },
				rt.ArrayItem{ key: none, val: var_exclude_from_search },
			]) },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden(),
					var_catalog_visibility))
				{
					'AND'
				} else {
					'NOT IN'
				}
			},
			rt.ArrayItem{ key: 'rating_filter', val: true },
		]))
	}
	if rt.is_true(var_rating) {
		mut var_rating_terms := rt.new_array()
		mut iter_4 := var_rating.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			var_rating_terms.array_push('rated-' + var_value.str())
		}
		var_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
			rt.ArrayItem{ key: 'field', val: 'name' },
			rt.ArrayItem{ key: 'terms', val: var_rating_terms },
		]))
	}
	mut var_orderby := rt.call_method(var_request, 'get_param', [
		rt.new_string('orderby'),
	])
	mut var_order := rt.call_method(var_request, 'get_param', [
		rt.new_string('order')])
	mut var_ordering_args := rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}),
		'query'), 'get_catalog_ordering_args', [var_orderby.clone(),
		var_order.clone()])
	var_args.array_set('orderby', var_ordering_args.array_get(rt.new_string('orderby')))
	var_args.array_set('order', var_ordering_args.array_get(rt.new_string('order')))
	if rt.is_true(rt.identical(rt.new_string('include'), var_orderby)) {
		var_args.array_set('orderby', 'post__in')
	} else if rt.is_true(rt.identical(rt.new_string('id'), var_orderby)) {
		var_args.array_set('orderby', 'ID')
	} else if rt.is_true(rt.identical(rt.new_string('slug'), var_orderby)) {
		var_args.array_set('orderby', 'name')
	}
	if rt.is_true(var_ordering_args.array_get(rt.new_string('meta_key'))) {
		var_args.array_set('meta_key', var_ordering_args.array_get(rt.new_string('meta_key')))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('related')))) {
		mut var_product_id := rt.call_function('absint', [
			var_request.array_get(rt.new_string('related')),
		])
		mut var_related_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_related_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_related_product, 'is_visible', []rt.PhpVal{}))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
				[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_not_found'), rt.call_function('__', [
				rt.new_string('The related product ID is invalid or the product is not visible.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(404))))
		}
		mut var_limit := rt.new_int(if !(!rt.is_true(var_request.array_get(rt.new_string('per_page')))) {
			rt.new_int((var_request.array_get(rt.new_string('per_page'))).to_i64())
		} else {
			100
		})
		mut var_related := rt.call_function('wc_get_related_products', [
			var_product_id.clone(), var_limit.clone()])
		if !(!rt.is_true(var_related)) {
			var_args.array_set('post__in', if !(!rt.is_true(var_args.array_get(rt.new_string('post__in')))) { rt.call_function('array_values', [
					rt.call_function('array_intersect', [
						var_args.array_get(rt.new_string('post__in')),
						var_related.clone(),
					]),
				]) } else { rt.call_function('array_values', [
					var_related.clone()]) })
		} else {
			var_args.array_set('post__in', rt.create_array([
				rt.ArrayItem{ key: none, val: 0 },
			]))
		}
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) convert_tax_query_to_meta_query(var_tax_query rt.PhpVal) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	mut var_meta_query := rt.new_array()
	mut iter_5 := var_tax_query_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tax_query_item := item_5.val
		mut var_taxonomy := var_tax_query_item.array_get(rt.new_string('taxonomy'))
		mut var_terms := var_tax_query_item.array_get(rt.new_string('terms'))
		mut var_meta_key := rt.new_string('attribute_' + var_taxonomy.str())
		var_meta_query.array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: var_meta_key },
			rt.ArrayItem{ key: 'value', val: var_terms },
		]))
		if var_tax_query_item.array_isset(rt.new_string('operator')) {
			var_meta_query.array_get_mut(0).array_set('compare',
				var_tax_query_item.array_get(rt.new_string('operator')))
		}
	}
	return var_meta_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_results(var_request rt.PhpVal) rt.PhpVal {
	mut var_query_args := this.prepare_objects_query(var_request.clone())
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_ProductQuery', [
				'QueryClausesGenerator',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	mut var_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
	mut var_results := var_query.query(var_query_args.clone())
	mut var_total_posts := rt.get_property(var_query, 'found_posts')
	if rt.is_true(rt.less(var_total_posts, rt.new_int(1)))
		&& rt.is_true(rt.greater(var_query_args.array_get(rt.new_string('paged')), rt.new_int(1))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_automattic_woocommerce_storeapi_utilities_wp_query()
		var_count_query.query(var_query_args.clone())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_ProductQuery', [
				'QueryClausesGenerator',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_query_clauses' },
		]),
		rt.new_int(10)])
	return rt.create_array([rt.ArrayItem{ key: 'results', val: var_results },
		rt.ArrayItem{ key: 'total', val: rt.new_int(var_total_posts.to_i64()) },
		rt.ArrayItem{
			key: 'pages'
			val: if rt.is_true(rt.greater(rt.get_property(var_query, 'query_vars').array_get(rt.new_string('posts_per_page')), rt.new_int(0))) { rt.new_int((rt.call_function('ceil', [
					rt.div(var_total_posts, rt.new_int((rt.get_property(var_query, 'query_vars').array_get(rt.new_string('posts_per_page'))).to_i64())),
				])).to_i64()) } else { 1 }
		}])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_objects(var_request rt.PhpVal) rt.PhpVal {
	mut var_results := this.get_results(var_request.clone())
	if !(!rt.is_true(var_results.array_get(rt.new_string('results')))) {
		rt.call_function('_prime_post_caches', [var_results.array_get(rt.new_string('results'))])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'objects', val: rt.call_function('array_map', [
			rt.new_string('wc_get_product'),
			var_results.array_get(rt.new_string('results')),
		]) },
		rt.ArrayItem{ key: 'total', val: var_results.array_get(rt.new_string('total')) },
		rt.ArrayItem{ key: 'pages', val: var_results.array_get(rt.new_string('pages')) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_last_modified() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_last_modified := rt.call_function('wp_cache_get', [
		rt.new_string('last_modified'),
		rt.new_string('wc_products'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_last_modified)) {
		mut var_last_modified_gmt := rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string('SELECT MAX( post_modified_gmt ) FROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(" WHERE post_type IN ( 'product', 'product_variation' )")),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_last_modified_gmt)))) {
			return rt.new_null()
		}
		var_last_modified = rt.new_string(
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.call_function('strtotime', [var_last_modified_gmt.clone()])])).str() +
			' GMT')
		rt.call_function('wp_cache_set', [rt.new_string('last_modified'),
			var_last_modified.clone(), rt.new_string('wc_products')])
	}
	return var_last_modified.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) add_query_clauses(mut var_args Class_Automattic_WooCommerce_StoreApi_Utilities_array, mut var_wp_query Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	if rt.is_true(var_wp_query.get(rt.new_string('search'))) {
		mut var_search := rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_wp_query.get(rt.new_string('search'))])).str() +
			'%')
		mut var_search_query := if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) { rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string(' AND ( '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_title LIKE %s OR wc_product_meta_lookup.sku LIKE %s ) ')),
				var_search.clone(),
				var_search.clone(),
			]) } else { rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_title LIKE %s ')),
				var_search.clone(),
			]) }
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')),
			var_search_query)
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	}
	if rt.is_true(var_wp_query.get(rt.new_string('sku'))) {
		mut var_skus := rt.call_function('explode', [rt.new_string(','),
			var_wp_query.get(rt.new_string('sku'))])
		if 1 < var_skus.clone().array_count() {
			var_skus.array_push(var_wp_query.get(rt.new_string('sku')))
		}
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(
			" AND wc_product_meta_lookup.sku IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_skus.clone()])])).str() +
			"')"))
	}
	if rt.is_true(var_wp_query.get(rt.new_string('slug'))) {
		mut var_slugs := rt.call_function('explode', [rt.new_string(','),
			var_wp_query.get(rt.new_string('slug'))])
		if 1 < var_slugs.clone().array_count() {
			var_slugs.array_push(var_wp_query.get(rt.new_string('slug')))
		}
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
		mut var_post_name__in := rt.call_function('implode', [
			rt.new_string('","'),
			rt.call_function('array_map', [
				rt.new_string('esc_sql'), var_slugs.clone()])])
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.post_name IN ("')), var_post_name__in), rt.new_string('")')))
	}
	if rt.is_true(var_wp_query.get(rt.new_string('stock_status'))) {
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.new_string(
			" AND wc_product_meta_lookup.stock_status IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_wp_query.get(rt.new_string('stock_status'))])])).str() +
			"')"))
	} else if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))
	{
		var_args_mutated.array_set('join',
			this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
		var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')),
			rt.new_string(" AND wc_product_meta_lookup.stock_status NOT IN ('outofstock')"))
	}
	if rt.is_true(var_wp_query.get(rt.new_string('min_price')))
		|| rt.is_true(var_wp_query.get(rt.new_string('max_price'))) {
		var_args_mutated = this.add_price_filter_clauses(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_array',
			[]string{}, var_args_mutated), rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WP_Query',
			[]string{}, var_wp_query))
	}
	return rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_array', []string{},
		var_args_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) add_price_filter_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_adjust_for_taxes := rt.new_bool(this.adjust_price_filters_for_displayed_taxes())
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('min_price')])) {
		mut var_min_price_filter := rt.new_float(this.prepare_price_filter(rt.call_method(var_wp_query,
			'get', [rt.new_string('min_price')])))
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_min_price_filter.clone(),
				'max_price', '>='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.max_price >= %f '),
				var_min_price_filter.clone(),
			]))
		}
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('max_price')])) {
		mut var_max_price_filter := rt.new_float(this.prepare_price_filter(rt.call_method(var_wp_query,
			'get', [rt.new_string('max_price')])))
		if rt.is_true(var_adjust_for_taxes) {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), this.get_price_filter_query_for_displayed_taxes(var_max_price_filter.clone(),
				'min_price', '<='))
		} else {
			var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
				'prepare', [
				rt.new_string(' AND wc_product_meta_lookup.min_price <= %f '),
				var_max_price_filter.clone(),
			]))
		}
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) get_price_filter_query_for_displayed_taxes(var_price_filter rt.PhpVal, column string, operator string) string {
	mut var_wpdb := rt.new_null()
	mut operator_mutated := operator
	mut var_product_tax_classes := rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.new_string('SELECT DISTINCT tax_class FROM '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(';')),
	])
	if !rt.is_true(var_product_tax_classes) {
		return ''
	}
	mut var_or_queries := rt.new_array()
	mut iter_6 := var_product_tax_classes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_tax_class := item_6.val
		mut var_adjusted_price_filter := this.adjust_price_filter_for_tax_class(var_price_filter.clone(),
			var_tax_class.clone())
		var_or_queries.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('( wc_product_meta_lookup.tax_class = %s AND wc_product_meta_lookup.`' +
				(rt.call_function('esc_sql', [rt.new_string(column)])).str() + '` ' +
				(rt.call_function('esc_sql', [rt.new_string(operator_mutated).clone()])).str() +
				' %f )'),
			var_tax_class.clone(),
			var_adjusted_price_filter.clone(),
		]))
	}
	return (rt.call_method(var_wpdb, 'prepare', [
		rt.new_string(
			' AND (\n\t\t\t\twc_product_meta_lookup.tax_status = "taxable" AND ( 0=1 OR ' + (rt.call_function('implode', [rt.new_string(' OR '), var_or_queries.clone()])).str() +
			')\n\t\t\t\tOR ( wc_product_meta_lookup.tax_status != "taxable" AND wc_product_meta_lookup.`' + (rt.call_function('esc_sql', [rt.new_string(column)])).str() +
			'` ' + (rt.call_function('esc_sql', [rt.new_string(operator_mutated).clone()])).str() +
			' %f )\n\t\t\t) '),
		var_price_filter.clone(),
	])).str()
	return ''
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) adjust_price_filters_for_displayed_taxes() bool {
	mut var_display := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut var_database := rt.new_string((if rt.is_true(rt.call_function('wc_prices_include_tax',
		[]rt.PhpVal{}))
	{
		'incl'
	} else {
		'excl'
	}).str())
	return rt.new_bool(!rt.is_true(rt.identical(var_display, var_database)))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) prepare_price_filter(var_price_filter rt.PhpVal) f64 {
	return rt.div(var_price_filter, rt.new_null()).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) adjust_price_filter_for_tax_class(var_price_filter rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_tax_display := rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_shop'),
	])
	mut iife_temp_2 := Class_WC_Tax{}
	mut iife_result_2 := iife_temp_2.get_rates(var_tax_class.clone())
	mut var_tax_rates := iife_result_2
	mut iife_temp_3 := Class_WC_Tax{}
	mut iife_result_3 := iife_temp_3.get_base_tax_rates(var_tax_class.clone())
	mut var_base_tax_rates := iife_result_3
	if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display)) {
		mut iife_temp_4 := Class_WC_Tax{}
		mut iife_result_4 := iife_temp_4.calc_tax(var_price_filter.clone(),
			var_base_tax_rates.clone(), rt.new_bool(true))
		mut iife_temp_5 := Class_WC_Tax{}
		mut iife_result_5 := iife_temp_5.calc_tax(var_price_filter.clone(), var_tax_rates.clone(),
			rt.new_bool(true))
		mut var_taxes := if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_adjust_non_base_location_prices'),
			rt.new_bool(true),
		]))
		{ iife_result_4 } else { iife_result_5 }
		return rt.sub(var_price_filter, rt.call_function('array_sum', [
			var_taxes.clone()]))
	}
	mut iife_temp_6 := Class_WC_Tax{}
	mut iife_result_6 := iife_temp_6.calc_tax(var_price_filter.clone(), var_tax_rates.clone(),
		rt.new_bool(false))
	var_taxes = iife_result_6
	return rt.add(var_price_filter, rt.call_function('array_sum', [
		var_taxes.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
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

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_productquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Query](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
			return rt.new_string(this.get_price_filter_query_for_displayed_taxes(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'adjust_price_filters_for_displayed_taxes' {
			return rt.new_bool(this.adjust_price_filters_for_displayed_taxes())
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
		else {
			return none
		}
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
