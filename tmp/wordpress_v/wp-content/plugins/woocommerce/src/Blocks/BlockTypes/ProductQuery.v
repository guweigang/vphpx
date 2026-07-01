import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-query')
		parsed_block rt.PhpVal = rt.new_null()
		custom_order_opts rt.PhpVal = rt.new_array()
		attributes_filter_query_args rt.PhpVal = rt.new_array()
		is_custom_inherit_global_query_implementation_enabled rt.PhpVal = rt.new_bool(false)
		valid_query_vars rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) initialize()  {
	rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'set_query_vars' }])])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('pre_render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'update_query' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_styles' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'update_rest_query' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_collection_params'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'extend_rest_query_allowed_params' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) check_if_post_template_has_support_for_grid_view() bool {
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}; return temp.wp_version_compare(arg_0, arg_1) }(rt.new_string('6.3'), rt.new_string('>='))) {
		return true
	}
	if rt.is_true(rt.call_function('is_plugin_active', [rt.new_string('gutenberg/gutenberg.php')])) {
		mut var_gutenberg_version := rt.new_string(rt.new_string(''))
		if rt.is_true(rt.call_function('defined', [rt.new_string('GUTENBERG_VERSION')])) {
			var_gutenberg_version = rt.get_constant('GUTENBERG_VERSION')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_version)))) {
			mut var_gutenberg_data := rt.call_function('get_file_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/gutenberg/gutenberg.php', rt.create_array([rt.ArrayItem{ key: 'Version', val: 'Version' }])])
			var_gutenberg_version = var_gutenberg_data.array_get('Version')
		}
		return (rt.call_function('version_compare', [var_gutenberg_version.dup(), rt.new_string('16.0'), rt.new_string('>=')])).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes))
	mut var_post_template_has_support_for_grid_view := rt.new_bool(this.check_if_post_template_has_support_for_grid_view())
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('postTemplateHasSupportForGridView'), var_post_template_has_support_for_grid_view.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('loopShopPerPage'), rt.call_function('apply_filters', [rt.new_string('loop_shop_per_page'), rt.mul(rt.call_function('wc_get_default_products_per_row', []rt.PhpVal{}), rt.call_function('wc_get_default_product_rows_per_page', []rt.PhpVal{}))])])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(var_parsed_block rt.PhpVal) bool {
	mut var_parsed_block_mutated := var_parsed_block
	return var_parsed_block_mutated.array_get('attrs').array_isset(rt.new_string('namespace')) && rt.is_true(rt.identical(rt.call_function('substr', [var_parsed_block_mutated.array_get('attrs').array_get('namespace'), rt.new_int(0), rt.new_int(11)]), rt.new_string('woocommerce')))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) enqueue_styles(block_content string, mut var_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/query'), var_block.array_get('blockName'))) && rt.is_true(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_block))))) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wc-blocks-style-product-query')])
	}
	return rt.new_string(block_content)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) update_query(var_pre_render rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_pre_render.dup()
	}
	this.parsed_block = var_parsed_block_mutated.dup()
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(var_parsed_block_mutated.dup())) {
		rt.call_function('wp_interactivity_config', [rt.new_string('core/router'), rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('hasFilterableProducts'), rt.new_bool(true)])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('isRenderingPhpTemplate'), rt.new_bool(true)])
		rt.call_function('add_filter', [rt.new_string('query_loop_block_query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'build_query' }]), rt.new_int(10), rt.new_int(2)])
	}
	return var_pre_render.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) merge_tax_queries(var_queries rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) update_rest_query(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_woo_attributes := rt.call_method(var_request, 'get_param', [rt.new_string('__woocommerceAttributes')])
	mut var_is_valid_attributes := rt.new_bool(rt.new_bool(var_woo_attributes.dup().is_array()))
	mut var_orderby := rt.call_method(var_request, 'get_param', [rt.new_string('orderby')])
	mut var_woo_stock_status := rt.call_method(var_request, 'get_param', [rt.new_string('__woocommerceStockStatus')])
	mut var_on_sale := rt.identical(rt.call_method(var_request, 'get_param', [rt.new_string('__woocommerceOnSale')]), rt.new_string('true'))
	mut var_on_sale_query := if rt.is_true(var_on_sale) { this.get_on_sale_products_query() } else { rt.new_array() }
	mut var_orderby_query := if rt.is_true(var_orderby) { this.get_custom_orderby_query(var_orderby.dup()) } else { rt.new_array() }
	mut var_attributes_query := if rt.is_true(var_is_valid_attributes) { this.get_product_attributes_query(var_woo_attributes.dup()) } else { rt.new_array() }
	mut var_stock_query := if rt.is_true(rt.new_bool(var_woo_stock_status.dup().is_array())) { this.get_stock_status_query(var_woo_stock_status.dup()) } else { rt.new_array() }
	mut var_visibility_query := if rt.is_true(rt.new_bool(var_woo_stock_status.dup().is_array())) { this.get_product_visibility_query(var_stock_query.dup()) } else { rt.new_array() }
	mut var_tax_query := if rt.is_true(var_is_valid_attributes) { this.merge_tax_queries(var_attributes_query.dup(), var_visibility_query.dup()) } else { rt.new_array() }
	return rt.call_function('array_merge', [var_args.dup(), var_on_sale_query.dup(), var_orderby_query.dup(), var_stock_query.dup(), var_tax_query.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) build_query(var_query rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_parsed_block := this.parsed_block
	mut var_is_product_collection_block := if !(rt.get_property(var_block, 'context').array_get('query').array_get('isProductCollectionBlock')).is_null() { rt.get_property(var_block, 'context').array_get('query').array_get('isProductCollectionBlock') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(this.is_woocommerce_variation(var_parsed_block.dup())) || rt.is_true(var_is_product_collection_block))) {
		return var_query_mutated.dup()
	}
	mut var_common_query_values := rt.create_array([rt.ArrayItem{ key: 'meta_query', val: rt.new_array() }, rt.ArrayItem{ key: 'posts_per_page', val: var_query_mutated.array_get('posts_per_page') }, rt.ArrayItem{ key: 'orderby', val: var_query_mutated.array_get('orderby') }, rt.ArrayItem{ key: 'order', val: var_query_mutated.array_get('order') }, rt.ArrayItem{ key: 'offset', val: var_query_mutated.array_get('offset') }, rt.ArrayItem{ key: 'post__in', val: rt.new_array() }, rt.ArrayItem{ key: 'post_status', val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'tax_query', val: rt.new_array() }])
	mut var_handpicked_products := if var_parsed_block.array_get('attrs').array_get('query').array_isset(rt.new_string('include')) { var_parsed_block.array_get('attrs').array_get('query').array_get('include') } else { var_common_query_values.array_get('post__in') }
	mut var_merged_query := this.merge_queries(var_common_query_values.dup(), this.get_global_query(var_parsed_block.dup()), this.get_custom_orderby_query(var_query_mutated.array_get('orderby')), this.get_queries_by_custom_attributes(var_parsed_block.dup()), this.get_queries_by_applied_filters(), this.get_filter_by_taxonomies_query(var_query_mutated.dup()), this.get_filter_by_keyword_query(var_query_mutated.dup()))
	return this.filter_query_to_only_include_ids(var_merged_query.dup(), var_handpicked_products.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) merge_queries(var_queries rt.PhpVal) rt.PhpVal {
	mut var_queries_mutated := var_queries
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_query := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_query.dup().is_array()))))) {
		return var_acc.dup()
	}
	if !rt.is_true(rt.call_function('array_intersect', [this.get_valid_query_vars(), rt.func_array_keys(var_query.dup())])) {
		return this.merge_queries(var_acc.dup(), rt.call_function('array_values', [var_query.dup()]))
	}
	return this.array_merge_recursive_replace_non_array_properties(var_acc.dup(), var_query.dup())
	}
	mut var_merged_query := rt.call_function('array_reduce', [var_queries_mutated.dup(), rt.new_closure(closure_1_fn), rt.new_array()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_merged_query.array_get('post__in'))) && rt.is_true(rt.new_bool(var_merged_query.array_get('post__in').is_array())))) && var_merged_query.array_get('post__in').array_count() > rt.call_function('array_unique', [var_merged_query.array_get('post__in')]).array_count())) {
		var_merged_query.array_set('post__in', rt.call_function('array_unique', [rt.call_function('array_diff', [var_merged_query.array_get('post__in'), rt.call_function('array_unique', [var_merged_query.array_get('post__in')])])]))
	}
	return var_merged_query.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) extend_rest_query_allowed_params(var_params rt.PhpVal) rt.PhpVal {
	mut var_original_enum := if var_params.array_get('orderby').array_isset(rt.new_string('enum')) { var_params.array_get('orderby').array_get('enum') } else { rt.new_array() }
	var_params.array_get_mut('orderby').array_set('enum', rt.call_function('array_merge', [var_original_enum.dup(), this.custom_order_opts]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_on_sale_products_query() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'post__in', val: rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{}) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_custom_orderby_query(var_orderby rt.PhpVal) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_orderby_mutated.dup(), this.custom_order_opts, rt.new_bool(true)]))))) {
		return rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby_mutated }])
	}
	mut var_meta_keys := rt.create_array([rt.ArrayItem{ key: 'popularity', val: 'total_sales' }, rt.ArrayItem{ key: 'rating', val: '_wc_average_rating' }])
	return rt.create_array([rt.ArrayItem{ key: 'meta_key', val: var_meta_keys.array_get(var_orderby_mutated) }, rt.ArrayItem{ key: 'orderby', val: 'meta_value_num' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) filter_query_to_only_include_ids(var_query rt.PhpVal, var_ids rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	if !(!rt.is_true(var_ids)) {
		var_query_mutated.array_set('post__in', if !rt.is_true(var_query_mutated.array_get('post__in')) { var_ids } else { rt.call_function('array_intersect', [var_ids.dup(), var_query_mutated.array_get('post__in')]) })
	}
	return var_query_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_product_attributes_query(var_attributes rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_stock_status_query(var_stock_statii rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_stock_statii.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_stock_status_options := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(var_stock_statii.dup().array_count() == var_stock_status_options.dup().array_count() && rt.is_true(rt.identical(rt.call_function('array_diff', [var_stock_statii.dup(), var_stock_status_options.dup()]), rt.call_function('array_diff', [var_stock_status_options.dup(), var_stock_statii.dup()]))))) {
		return rt.new_array()
	}
	mut var_diff := rt.call_function('array_diff', [var_stock_status_options.dup(), var_stock_statii.dup()])
	if rt.is_true(rt.new_bool(var_diff.dup().array_count() == 1 && rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), var_diff.dup(), rt.new_bool(true)])))) {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'meta_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: rt.cast_array(var_stock_statii) }, rt.ArrayItem{ key: 'compare', val: 'IN' }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_product_visibility_query(var_stock_query rt.PhpVal) rt.PhpVal {
	mut var_stock_query_mutated := var_stock_query
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
	mut var_product_visibility_not_in := rt.create_array([rt.ArrayItem{ key: none, val: if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) { var_product_visibility_terms.array_get('exclude-from-search') } else { var_product_visibility_terms.array_get('exclude-from-catalog') } }])
	if rt.is_true(rt.new_bool(!rt.is_true(var_stock_query_mutated) && rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))))) {
		var_product_visibility_not_in.array_push(var_product_visibility_terms.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()))
	}
	return rt.create_array([rt.ArrayItem{ key: 'tax_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: var_product_visibility_not_in }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_query_vars_from_filter_blocks() rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_arr := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('array_merge', [rt.call_function('array_values', [var_arr.dup()]), var_acc.dup()])
	}
	mut var_attributes_filter_query_args := rt.call_function('array_reduce', [rt.call_function('array_values', [this.get_filter_by_attributes_query_vars()]), rt.new_closure(closure_3_fn), rt.new_array()])
	return rt.create_array([rt.ArrayItem{ key: 'price_filter_query_args', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.min_price_query_var() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_BlockTypes_PriceFilter.max_price_query_var() }]) }, rt.ArrayItem{ key: 'stock_filter_query_args', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.stock_status_query_var() }]) }, rt.ArrayItem{ key: 'attributes_filter_query_args', val: var_attributes_filter_query_args }, rt.ArrayItem{ key: 'rating_filter_query_args', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_BlockTypes_RatingFilter.rating_query_var() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) set_query_vars(var_public_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars := this.get_query_vars_from_filter_blocks()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_query_vars_filter_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('array_merge', [var_query_vars_filter_block.dup(), var_acc.dup()])
	}
	return rt.call_function('array_reduce', [rt.call_function('array_values', [var_query_vars.dup()]), rt.new_closure(closure_4_fn), var_public_query_vars.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_attributes_query_vars() rt.PhpVal {
	if !(!rt.is_true(this.attributes_filter_query_args)) {
		return this.attributes_filter_query_args
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	
	}
	this.attributes_filter_query_args = rt.call_function('array_reduce', [rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}), rt.new_closure(closure_5_fn), rt.new_array()])
	return this.attributes_filter_query_args
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_queries_by_applied_filters() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_queries_by_custom_attributes(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_price_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_attributes_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_stock_status_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_valid_query_vars() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) array_merge_recursive_replace_non_array_properties(var_base rt.PhpVal, var_new rt.PhpVal) rt.PhpVal {
	mut var_base_mutated := var_base
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_global_query(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_parsed_block_mutated := var_parsed_block
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_rating_query() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_taxonomies_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) get_filter_by_keyword_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productquery() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-query')
		parsed_block: rt.new_null()
		custom_order_opts: rt.new_array()
		attributes_filter_query_args: rt.new_array()
		is_custom_inherit_global_query_implementation_enabled: rt.new_bool(false)
		valid_query_vars: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils() &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_woocommerce_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery.is_woocommerce_variation(dispatch_arg_0))
		}
		'enqueue_styles' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 { args[1] } else { rt.new_null() })
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
			return this.array_merge_recursive_replace_non_array_properties(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
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
		'block_name' { this.block_name = val; return true }
		'parsed_block' { this.parsed_block = val; return true }
		'custom_order_opts' { this.custom_order_opts = val; return true }
		'attributes_filter_query_args' { this.attributes_filter_query_args = val; return true }
		'is_custom_inherit_global_query_implementation_enabled' { this.is_custom_inherit_global_query_implementation_enabled = val; return true }
		'valid_query_vars' { this.valid_query_vars = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productquery_php() {
	// unsupported statement: Stmt_Declare
}
