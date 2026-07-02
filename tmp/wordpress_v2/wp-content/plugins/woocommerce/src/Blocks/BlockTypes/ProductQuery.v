import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	rt.PhpObjectBase
pub mut:
	block_name                                            rt.PhpVal = rt.new_string('product-query')
	parsed_block                                          rt.PhpVal = rt.new_null()
	custom_order_opts                                     rt.PhpVal = rt.new_array()
	attributes_filter_query_args                          rt.PhpVal = rt.new_array()
	is_custom_inherit_global_query_implementation_enabled rt.PhpVal = rt.new_bool(false)
	valid_query_vars                                      rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) initialize() {
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'set_query_vars' },
		])])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('pre_render_block'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_query' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_rest_query' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_collection_params'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'extend_rest_query_allowed_params' },
		]),
		rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) check_if_post_template_has_support_for_grid_view() bool {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}
	mut iife_result_0 := iife_temp_0.wp_version_compare(rt.new_string('6.3'), rt.new_string('>='))
	if rt.is_true(iife_result_0) {
		return true
	}
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('gutenberg/gutenberg.php'),
	]))
	{
		mut var_gutenberg_version := rt.new_string('')
		if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')])) {
			var_gutenberg_version = rt.get_constant('GUTENBERG_VERSION')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_version)))) {
			mut var_gutenberg_data := rt.call_function('get_file_data', [
				rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/gutenberg/gutenberg.php'),
				rt.create_array([rt.ArrayItem{ key: 'Version', val: 'Version' }]),
			])
			var_gutenberg_version = var_gutenberg_data.array_get(rt.new_string('Version'))
		}
		return (rt.call_function('version_compare', [var_gutenberg_version.clone(),
			rt.new_string('16.0'), rt.new_string('>=')])).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut var_post_template_has_support_for_grid_view :=
		rt.new_bool(this.check_if_post_template_has_support_for_grid_view())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('postTemplateHasSupportForGridView'),
		var_post_template_has_support_for_grid_view.clone(),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('loopShopPerPage'),
		rt.call_function('apply_filters', [rt.new_string('loop_shop_per_page'),
			rt.mul(rt.call_function('wc_get_default_products_per_row', []rt.PhpVal{}), rt.call_function('wc_get_default_product_rows_per_page',
				[]rt.PhpVal{}))])])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(var_parsed_block rt.PhpVal) bool {
	mut var_parsed_block_mutated := var_parsed_block
	return
		var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_isset(rt.new_string('namespace'))
		&& rt.is_true(rt.identical(rt.call_function('substr', [var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('namespace')), rt.new_int(0), rt.new_int(11)]), rt.new_string('woocommerce')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) enqueue_styles(block_content string, mut var_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('core/query'), var_block.array_get(rt.new_string('blockName'))))
		&& rt.is_true(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_block))) {
		rt.call_function('wp_enqueue_style', [
			rt.new_string('wc-blocks-style-product-query'),
		])
	}
	return rt.new_string(block_content)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) update_query(var_pre_render rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/query'),
		var_parsed_block_mutated.array_get(rt.new_string('blockName'))))))
	{
		return var_pre_render.clone()
	}
	this.parsed_block = var_parsed_block_mutated.clone()
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(var_parsed_block_mutated.clone())) {
		rt.call_function('wp_interactivity_config', [rt.new_string('core/router'),
			rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('hasFilterableProducts'),
			rt.new_bool(true),
		])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('isRenderingPhpTemplate'),
			rt.new_bool(true),
		])
		rt.call_function('add_filter', [rt.new_string('query_loop_block_query_vars'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'build_query' },
			]),
			rt.new_int(10), rt.new_int(2)])
	}
	return var_pre_render.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) merge_tax_queries(var_queries rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) update_rest_query(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_woo_attributes := rt.call_method(var_request, 'get_param', [
		rt.new_string('__woocommerceAttributes'),
	])
	mut var_is_valid_attributes := rt.new_bool(var_woo_attributes.clone().is_array())
	mut var_orderby := rt.call_method(var_request, 'get_param', [
		rt.new_string('orderby'),
	])
	mut var_woo_stock_status := rt.call_method(var_request, 'get_param', [
		rt.new_string('__woocommerceStockStatus'),
	])
	mut var_on_sale := rt.identical(rt.call_method(var_request, 'get_param', [
		rt.new_string('__woocommerceOnSale'),
	]), rt.new_string('true'))
	mut var_on_sale_query := if rt.is_true(var_on_sale) {
		this.get_on_sale_products_query()
	} else {
		rt.new_array()
	}
	mut var_orderby_query := if rt.is_true(var_orderby) {
		this.get_custom_orderby_query(var_orderby.clone())
	} else {
		rt.new_array()
	}
	mut var_attributes_query := if rt.is_true(var_is_valid_attributes) {
		this.get_product_attributes_query(var_woo_attributes.clone())
	} else {
		rt.new_array()
	}
	mut var_stock_query := if var_woo_stock_status.clone().is_array() {
		this.get_stock_status_query(var_woo_stock_status.clone())
	} else {
		rt.new_array()
	}
	mut var_visibility_query := if var_woo_stock_status.clone().is_array() {
		this.get_product_visibility_query(var_stock_query.clone())
	} else {
		rt.new_array()
	}
	mut var_tax_query := if rt.is_true(var_is_valid_attributes) {
		this.merge_tax_queries(var_attributes_query.clone(), var_visibility_query.clone())
	} else {
		rt.new_array()
	}
	return rt.call_function('array_merge', [var_args.clone(),
		var_on_sale_query.clone(), var_orderby_query.clone(),
		var_stock_query.clone(), var_tax_query.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) build_query(var_query rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_parsed_block := this.parsed_block
	mut var_is_product_collection_block := if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))
	} else {
		rt.new_bool(false)
	}
	if !(this.is_woocommerce_variation(var_parsed_block.clone()))
		|| rt.is_true(var_is_product_collection_block) {
		return var_query_mutated.clone()
	}
	mut var_common_query_values := rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.new_array() },
		rt.ArrayItem{
			key: 'posts_per_page'
			val: var_query_mutated.array_get(rt.new_string('posts_per_page'))
		},
		rt.ArrayItem{ key: 'orderby', val: var_query_mutated.array_get(rt.new_string('orderby')) },
		rt.ArrayItem{ key: 'order', val: var_query_mutated.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'offset', val: var_query_mutated.array_get(rt.new_string('offset')) },
		rt.ArrayItem{ key: 'post__in', val: rt.new_array() },
		rt.ArrayItem{
			key: 'post_status'
			val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
		},
		rt.ArrayItem{ key: 'post_type', val: 'product' },
		rt.ArrayItem{ key: 'tax_query', val: rt.new_array() },
	])
	mut var_handpicked_products := if var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_isset(rt.new_string('include')) {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_get(rt.new_string('include'))
	} else {
		var_common_query_values.array_get(rt.new_string('post__in'))
	}
	mut var_merged_query := this.merge_queries(var_common_query_values.clone(),
		this.get_global_query(var_parsed_block.clone()),
		this.get_custom_orderby_query(var_query_mutated.array_get(rt.new_string('orderby'))),
		this.get_queries_by_custom_attributes(var_parsed_block.clone()),
		this.get_queries_by_applied_filters(),
		this.get_filter_by_taxonomies_query(var_query_mutated.clone()),
		this.get_filter_by_keyword_query(var_query_mutated.clone()))
	return this.filter_query_to_only_include_ids(var_merged_query.clone(),
		var_handpicked_products.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) merge_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_query.clone().is_array()) {
			return var_acc.clone()
		}
		if !rt.is_true(rt.call_function('array_intersect', [this.get_valid_query_vars(),
			rt.func_array_keys(var_query.clone())])) {
			return this.merge_queries(var_acc.clone(), rt.call_function('array_values', [
				var_query.clone(),
			]))
		}
		return this.array_merge_recursive_replace_non_array_properties(var_acc.clone(),
			var_query.clone())
	}
	mut var_merged_query := rt.call_function('array_reduce', [
		var_queries_mutated.clone(), rt.new_closure(closure_2_fn),
		rt.new_array()])
	if !(!rt.is_true(var_merged_query.array_get(rt.new_string('post__in'))))
		&& var_merged_query.array_get(rt.new_string('post__in')).is_array()
		&& var_merged_query.array_get(rt.new_string('post__in')).array_count() > rt.call_function('array_unique', [var_merged_query.array_get(rt.new_string('post__in'))]).array_count() {
		var_merged_query.array_set('post__in', rt.call_function('array_unique', [
			rt.call_function('array_diff', [var_merged_query.array_get(rt.new_string('post__in')),
				rt.call_function('array_unique', [
					var_merged_query.array_get(rt.new_string('post__in')),
				])]),
		]))
	}
	return var_merged_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) extend_rest_query_allowed_params(var_params rt.PhpVal) rt.PhpVal {
	mut var_original_enum := if var_params.array_get(rt.new_string('orderby')).array_isset(rt.new_string('enum')) {
		var_params.array_get(rt.new_string('orderby')).array_get(rt.new_string('enum'))
	} else {
		rt.new_array()
	}
	var_params.array_get_mut('orderby').array_set('enum', rt.call_function('array_merge', [
		var_original_enum.clone(),
		this.custom_order_opts,
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_on_sale_products_query() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'post__in', val: rt.call_function('wc_get_product_ids_on_sale',
			[]rt.PhpVal{}) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_custom_orderby_query(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_orderby_mutated.clone(), this.custom_order_opts, rt.new_bool(true)])))))
	{
		return rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	mut var_meta_keys := rt.create_array([
		rt.ArrayItem{ key: 'popularity', val: 'total_sales' },
		rt.ArrayItem{ key: 'rating', val: '_wc_average_rating' },
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_key', val: var_meta_keys.array_get(var_orderby_mutated) },
		rt.ArrayItem{ key: 'orderby', val: 'meta_value_num' },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) filter_query_to_only_include_ids(var_query rt.PhpVal, var_ids rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if !(!rt.is_true(var_ids)) {
		var_query_mutated.array_set('post__in', if !rt.is_true(var_query_mutated.array_get(rt.new_string('post__in'))) { var_ids } else { rt.call_function('array_intersect', [
				var_ids.clone(),
				var_query_mutated.array_get(rt.new_string('post__in')),
			]) })
	}
	return var_query_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_product_attributes_query(var_attributes rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
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
		var_attributes.clone(), rt.new_closure(closure_3_fn),
		rt.new_array()])
	return rt.create_array([
		rt.ArrayItem{ key: 'tax_query', val: rt.call_function('array_values', [
			var_grouped_attributes.clone(),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_stock_status_query(var_stock_statii rt.PhpVal) rt.PhpVal {
	if !(var_stock_statii.clone().is_array()) {
		return rt.new_array()
	}
	mut var_stock_status_options := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
		[]rt.PhpVal{}))
	if var_stock_statii.clone().array_count() == var_stock_status_options.clone().array_count()
		&& rt.is_true(rt.identical(rt.call_function('array_diff', [var_stock_statii.clone(), var_stock_status_options.clone()]), rt.call_function('array_diff', [var_stock_status_options.clone(), var_stock_statii.clone()]))) {
		return rt.new_array()
	}
	mut var_diff := rt.call_function('array_diff', [var_stock_status_options.clone(),
		var_stock_statii.clone()])
	if var_diff.clone().array_count() == 1
		&& rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), var_diff.clone(), rt.new_bool(true)])) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_stock_status' },
				rt.ArrayItem{ key: 'value', val: rt.cast_array(var_stock_statii) },
				rt.ArrayItem{ key: 'compare', val: 'IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_product_visibility_query(var_stock_query rt.PhpVal) rt.PhpVal {
	mut var_stock_query_mutated := var_stock_query
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
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_query_vars_from_filter_blocks() rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_arr := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.call_function('array_merge', [
			rt.call_function('array_values', [var_arr.clone()]),
			var_acc.clone(),
		])
	}
	mut var_attributes_filter_query_args := rt.call_function('array_reduce', [
		rt.call_function('array_values', [this.get_filter_by_attributes_query_vars()]),
		rt.new_closure(closure_4_fn),
		rt.new_array(),
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'price_filter_query_args', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.min_price_query_var()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.max_price_query_var()
			},
		]) },
		rt.ArrayItem{ key: 'stock_filter_query_args', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.stock_status_query_var()
			},
		]) },
		rt.ArrayItem{ key: 'attributes_filter_query_args', val: var_attributes_filter_query_args },
		rt.ArrayItem{ key: 'rating_filter_query_args', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Blocks_BlockTypes_RatingFilter.rating_query_var()
			},
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) set_query_vars(var_public_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars := this.get_query_vars_from_filter_blocks()
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_query_vars_filter_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.call_function('array_merge', [var_query_vars_filter_block.clone(),
			var_acc.clone()])
	}
	return rt.call_function('array_reduce', [
		rt.call_function('array_values', [var_query_vars.clone()]),
		rt.new_closure(closure_5_fn),
		var_public_query_vars.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_attributes_query_vars() rt.PhpVal {
	if !(!rt.is_true(this.attributes_filter_query_args)) {
		return this.attributes_filter_query_args
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
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
		rt.new_closure(closure_6_fn),
		rt.new_array(),
	])
	return this.attributes_filter_query_args
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_queries_by_applied_filters() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'price_filter', val: this.get_filter_by_price_query() },
		rt.ArrayItem{ key: 'attributes_filter', val: this.get_filter_by_attributes_query() },
		rt.ArrayItem{ key: 'stock_status_filter', val: this.get_filter_by_stock_status_query() },
		rt.ArrayItem{ key: 'rating_filter', val: this.get_filter_by_rating_query() },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_queries_by_custom_attributes(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_query :=
		var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('query'))
	mut var_on_sale_enabled := rt.new_bool(
		var_query.array_isset(rt.new_string('__woocommerceOnSale'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_query.array_get(rt.new_string('__woocommerceOnSale')))))
	mut var_attributes_query := if var_query.array_isset(rt.new_string('__woocommerceAttributes')) {
		this.get_product_attributes_query(var_query.array_get(rt.new_string('__woocommerceAttributes')))
	} else {
		rt.new_array()
	}
	mut var_stock_query := if var_query.array_isset(rt.new_string('__woocommerceStockStatus')) {
		this.get_stock_status_query(var_query.array_get(rt.new_string('__woocommerceStockStatus')))
	} else {
		rt.new_array()
	}
	mut var_visibility_query := this.get_product_visibility_query(var_stock_query.clone())
	return rt.create_array([
		rt.ArrayItem{
			key: 'on_sale'
			val: if rt.is_true(var_on_sale_enabled) {
				this.get_on_sale_products_query()
			} else {
				rt.new_array()
			}
		},
		rt.ArrayItem{ key: 'attributes', val: var_attributes_query },
		rt.ArrayItem{ key: 'stock_status', val: var_stock_query },
		rt.ArrayItem{ key: 'visibility', val: var_visibility_query },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_price_query() rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_attributes_query() rt.PhpVal {
	mut var_attributes_filter_query_args := this.get_filter_by_attributes_query_vars()
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
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
		rt.new_closure(closure_7_fn), rt.new_array()])
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_stock_status_query() rt.PhpVal {
	mut var_filter_stock_status_values := rt.call_function('get_query_var', [
		Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.stock_status_query_var(),
	])
	if !rt.is_true(var_filter_stock_status_values) {
		return rt.new_array()
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_stock_status := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter{}
		mut iife_result_8 := iife_temp_8.get_stock_status_query_var_values()
		return rt.call_function('in_array',
			[var_stock_status.clone(), iife_result_8, rt.new_bool(true)])
	}
	mut var_filtered_stock_status_values := rt.call_function('array_filter', [
		rt.call_function('explode', [rt.new_string(','), var_filter_stock_status_values.clone()]),
		rt.new_closure(closure_9_fn),
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_valid_query_vars() rt.PhpVal {
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
		])])
	return this.valid_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) array_merge_recursive_replace_non_array_properties(var_base rt.PhpVal, var_new rt.PhpVal) rt.PhpVal {
	mut var_base_mutated := var_base
	mut iter_2 := var_new.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_global_query(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_custom_inherit_global_query_implementation_enabled)))) {
		return rt.new_array()
	}
	mut var_inherit_enabled := rt.new_bool(
		var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_isset(rt.new_string('__woocommerceInherit'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')).array_get(rt.new_string('__woocommerceInherit')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_inherit_enabled)))) {
		return rt.new_array()
	}
	mut var_query := rt.new_array()
	if rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('taxonomy'))
		&& rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('term')) {
		var_query.array_set('tax_query', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'taxonomy'
					val: rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('taxonomy'))
				},
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{
					key: 'terms'
					val: rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('term'))
				},
			]) },
		]))
	}
	if rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('s')) {
		var_query.array_set('s',
			rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('s')))
	}
	return var_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_rating_query() rt.PhpVal {
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
	closure_10_fn := fn [var_product_visibility_terms] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_rating := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_visibility_terms.array_get(rt.new_string('rated-' + var_rating.str()))
	}
	closure_11_fn := fn [var_product_visibility_terms] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_rating := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product_visibility_terms.array_get(rt.new_string('rated-' + var_rating.str()))
	}
	mut var_rating_terms := rt.call_function('array_map', [rt.new_closure(closure_10_fn),
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_taxonomies_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if !(var_query_mutated.array_isset(rt.new_string('tax_query')))
		|| !(var_query_mutated.array_get(rt.new_string('tax_query')).is_array()) {
		return rt.new_array()
	}
	mut var_tax_query := var_query_mutated.array_get(rt.new_string('tax_query'))
	mut var_product_taxonomies := rt.call_function('array_diff', [
		rt.call_function('get_object_taxonomies', [rt.new_string('product'),
			rt.new_string('names')]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product_visibility' },
			rt.ArrayItem{ key: none, val: 'product_shipping_class' }]),
	])
	closure_12_fn := fn [var_product_taxonomies] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_item.array_isset(rt.new_string('taxonomy'))
			&& rt.is_true(rt.call_function('in_array', [var_item.array_get(rt.new_string('taxonomy')), var_product_taxonomies.clone(), rt.new_bool(true)])))
	}
	mut var_result := rt.call_function('array_filter', [var_tax_query.clone(),
		rt.new_closure(closure_12_fn)])
	return if !(!rt.is_true(var_result)) { rt.create_array([
			rt.ArrayItem{ key: 'tax_query', val: var_result },
		]) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_keyword_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if !(var_query_mutated.clone().is_array()) {
		return rt.new_array()
	}
	if var_query_mutated.array_isset(rt.new_string('s')) {
		return rt.create_array([
			rt.ArrayItem{ key: 's', val: var_query_mutated.array_get(rt.new_string('s')) },
		])
	}
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery{
		PhpObjectBase:                                         rt.PhpObjectBase{}
		block_name:                                            rt.new_string('product-query')
		parsed_block:                                          rt.new_null()
		custom_order_opts:                                     rt.new_array()
		attributes_filter_query_args:                          rt.new_array()
		is_custom_inherit_global_query_implementation_enabled: rt.new_bool(false)
		valid_query_vars:                                      rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
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

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'check_if_post_template_has_support_for_grid_view' {
			return rt.new_bool(this.check_if_post_template_has_support_for_grid_view())
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_woocommerce_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(dispatch_arg_0))
		}
		'enqueue_styles' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.enqueue_styles(dispatch_arg_0, mut dispatch_arg_1)
		}
		'update_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_query(dispatch_arg_0, dispatch_arg_1)
		}
		'merge_tax_queries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.merge_tax_queries(dispatch_arg_0)
		}
		'update_rest_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_rest_query(dispatch_arg_0, dispatch_arg_1)
		}
		'build_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.build_query(dispatch_arg_0, dispatch_arg_1)
		}
		'merge_queries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.merge_queries(dispatch_arg_0)
		}
		'extend_rest_query_allowed_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.extend_rest_query_allowed_params(dispatch_arg_0)
		}
		'get_on_sale_products_query' {
			return this.get_on_sale_products_query()
		}
		'get_custom_orderby_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_orderby_query(dispatch_arg_0)
		}
		'filter_query_to_only_include_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_query_to_only_include_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_attributes_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_attributes_query(dispatch_arg_0)
		}
		'get_stock_status_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status_query(dispatch_arg_0)
		}
		'get_product_visibility_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_visibility_query(dispatch_arg_0)
		}
		'get_query_vars_from_filter_blocks' {
			return this.get_query_vars_from_filter_blocks()
		}
		'set_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_query_vars(dispatch_arg_0)
		}
		'get_filter_by_attributes_query_vars' {
			return this.get_filter_by_attributes_query_vars()
		}
		'get_queries_by_applied_filters' {
			return this.get_queries_by_applied_filters()
		}
		'get_queries_by_custom_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_queries_by_custom_attributes(dispatch_arg_0)
		}
		'get_filter_by_price_query' {
			return this.get_filter_by_price_query()
		}
		'get_filter_by_attributes_query' {
			return this.get_filter_by_attributes_query()
		}
		'get_filter_by_stock_status_query' {
			return this.get_filter_by_stock_status_query()
		}
		'get_valid_query_vars' {
			return this.get_valid_query_vars()
		}
		'array_merge_recursive_replace_non_array_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.array_merge_recursive_replace_non_array_properties(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_global_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_global_query(dispatch_arg_0)
		}
		'get_filter_by_rating_query' {
			return this.get_filter_by_rating_query()
		}
		'get_filter_by_taxonomies_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filter_by_taxonomies_query(dispatch_arg_0)
		}
		'get_filter_by_keyword_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filter_by_keyword_query(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'parsed_block' { return this.parsed_block }
		'custom_order_opts' { return this.custom_order_opts }
		'attributes_filter_query_args' { return this.attributes_filter_query_args }
		'is_custom_inherit_global_query_implementation_enabled' { return this.is_custom_inherit_global_query_implementation_enabled }
		'valid_query_vars' { return this.valid_query_vars }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'parsed_block' {
			this.parsed_block = val
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
		'is_custom_inherit_global_query_implementation_enabled' {
			this.is_custom_inherit_global_query_implementation_enabled = val
			return true
		}
		'valid_query_vars' {
			this.valid_query_vars = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
