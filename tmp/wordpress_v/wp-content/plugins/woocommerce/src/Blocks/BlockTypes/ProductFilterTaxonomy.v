import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-filter-taxonomy')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_params_handler := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Internal_ProductFilters_Params.class()])
	mut var_taxonomy_params := rt.call_method(var_params_handler, 'get_param', [rt.new_string('taxonomy')])
	mut var_active_taxonomies := rt.new_array()
	mut var_all_term_slugs := rt.new_array()
	{
		mut iter_1 := var_taxonomy_params.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param_key := item_1.val
			mut var_taxonomy_slug := item_1.key
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_params.array_get(var_param_key))) && rt.is_true(rt.new_bool(var_params.array_get(var_param_key).is_string())))) {
				mut var_term_slugs := rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), var_params.array_get(var_param_key)])])
				var_active_taxonomies.array_set(var_taxonomy_slug, var_term_slugs.dup())
				var_all_term_slugs = rt.call_function('array_merge', [var_all_term_slugs.dup(), var_term_slugs.dup()])
			}
		}
	}
	if !rt.is_true(var_active_taxonomies) {
		return var_items_mutated.dup()
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_active_taxonomies.dup()) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('array_unique', [var_all_term_slugs.dup()]) }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) || !rt.is_true(var_terms))) {
		return var_items_mutated.dup()
	}
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_taxonomy_object := rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')])
			if rt.is_true(var_taxonomy_object) {
				var_items_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'taxonomy/' + (rt.get_property(var_term, 'taxonomy')).str() }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_term, 'slug') }, rt.ArrayItem{ key: 'activeLabel', val: (rt.get_property(rt.get_property(var_taxonomy_object, 'labels'), 'singular_name')).str() + ': ' + (rt.get_property(var_term, 'name')).str() }]))
			}
		}
	}
	return var_items_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('woocommerce_blocks_product_filters_selected_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_selected_filters' }]), rt.new_int(10), rt.new_int(2)])
	this.register_taxonomy_menu_order_rest_field()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) register_taxonomy_menu_order_rest_field()  {
	mut var_sortable_taxonomies := rt.call_function('apply_filters', [rt.new_string('woocommerce_sortable_taxonomies'), rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }])])
	{
		mut iter_1 := var_sortable_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_menu_order := rt.call_function('get_term_meta', [var_term.array_get('id'), rt.new_string('order'), rt.new_bool(true)])
	return if rt.is_true(rt.new_bool(var_menu_order.dup().is_long() || var_menu_order.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	}
			rt.call_function('register_rest_field', [var_taxonomy.dup(), rt.new_string('menu_order'), rt.create_array([rt.ArrayItem{ key: 'get_callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Menu order, used to custom sort the term.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('filterableProductTaxonomies'), this.get_taxonomies()])
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('sortableTaxonomies'), rt.call_function('apply_filters', [rt.new_string('woocommerce_sortable_taxonomies'), rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }])])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) render(var_block_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) || !rt.is_true(var_block_attributes.array_get('taxonomy')))) {
		return ''
	}
	mut var_taxonomy := var_block_attributes.array_get('taxonomy')
	mut var_taxonomy_object := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()]))))))) {
		return ''
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_params_handler := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Internal_ProductFilters_Params.class()])
	mut var_taxonomy_params := rt.call_method(var_params_handler, 'get_param', [rt.new_string('taxonomy')])
	if !(var_taxonomy_params.array_isset(var_taxonomy)) {
		return ''
	}
	rt.call_function('wp_interactivity_config', [rt.new_string('woocommerce/product-filters'), rt.create_array([rt.ArrayItem{ key: 'taxonomyParamsMap', val: var_taxonomy_params }])])
	mut var_filter_context := rt.create_array([rt.ArrayItem{ key: 'showCounts', val: if !(var_block_attributes.array_get('showCounts')).is_null() { var_block_attributes.array_get('showCounts') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'items', val: rt.new_array() }, rt.ArrayItem{ key: 'groupLabel', val: rt.get_property(rt.get_property(var_taxonomy_object, 'labels'), 'singular_name') }])
	mut var_taxonomy_counts := this.get_taxonomy_term_counts(var_block.dup(), var_taxonomy.dup())
	if !(!rt.is_true(var_taxonomy_counts)) {
		mut var_hide_empty := if !(var_block_attributes.array_get('hideEmpty')).is_null() { var_block_attributes.array_get('hideEmpty') } else { rt.new_bool(true) }
		mut var_orderby := if rt.is_true(var_block_attributes.array_get('sortOrder')) { rt.call_function('explode', [rt.new_string('-'), var_block_attributes.array_get('sortOrder')]).array_get(0) } else { rt.new_string('name') }
		mut var_order := rt.new_string(if rt.is_true(var_block_attributes.array_get('sortOrder')) { rt.new_string(rt.call_function('explode', [rt.new_string('-'), var_block_attributes.array_get('sortOrder')]).array_get(1).to_string().to_upper()) } else { rt.new_string('DESC') })
		mut var_taxonomy_terms := this.get_sorted_terms(var_taxonomy.dup(), var_taxonomy_counts.dup(), var_hide_empty.dup(), var_orderby.dup(), var_order.dup())
		if rt.is_true(rt.call_function('is_wp_error', [var_taxonomy_terms.dup()])) {
			return ''
		}
		mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get('filterParams')).is_null() { rt.get_property(var_block, 'context').array_get('filterParams') } else { rt.new_array() }
		mut var_selected_terms := rt.new_array()
		mut var_param_key := var_taxonomy_params.array_get(var_taxonomy)
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_filter_params) && !(!rt.is_true(var_filter_params.array_get(var_param_key))))) && rt.is_true(rt.new_bool(var_filter_params.array_get(var_param_key).is_string())))) {
			var_selected_terms = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), var_filter_params.array_get(var_param_key)])])])
		}
		closure_3_fn := fn [var_taxonomy_counts, var_selected_terms, var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_taxonomy_counts, var_selected_terms, var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	var_term.array_set('count', if !(var_taxonomy_counts.array_get(var_term.array_get('term_id'))).is_null() { var_taxonomy_counts.array_get(var_term.array_get('term_id')) } else { rt.new_int(0) })
	mut var_option := rt.create_array([rt.ArrayItem{ key: 'label', val: var_term.array_get('name') }, rt.ArrayItem{ key: 'value', val: var_term.array_get('slug') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_term.array_get('slug'), var_selected_terms.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_term.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'taxonomy/' + (var_taxonomy).str() }])
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()])) {
		var_option.array_set('id', var_term.array_get('term_id'))
		if rt.is_true(rt.new_bool(var_term.array_isset(rt.new_string('depth')) && rt.is_true(rt.greater(var_term.array_get('depth'), rt.new_int(0))))) {
			var_option.array_set('depth', var_term.array_get('depth'))
		}
		if rt.is_true(rt.new_bool(var_term.array_isset(rt.new_string('parent')) && rt.is_true(rt.greater(var_term.array_get('parent'), rt.new_int(0))))) {
			var_option.array_set('parent', var_term.array_get('parent'))
		}
	}
	return (var_option).str()
	}
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	var_term.array_set('count', if !(var_taxonomy_counts.array_get(var_term.array_get('term_id'))).is_null() { var_taxonomy_counts.array_get(var_term.array_get('term_id')) } else { rt.new_int(0) })
	mut var_option := rt.create_array([rt.ArrayItem{ key: 'label', val: var_term.array_get('name') }, rt.ArrayItem{ key: 'value', val: var_term.array_get('slug') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_term.array_get('slug'), var_selected_terms.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_term.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'taxonomy/' + (var_taxonomy).str() }])
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()])) {
		var_option.array_set('id', var_term.array_get('term_id'))
		if rt.is_true(rt.new_bool(var_term.array_isset(rt.new_string('depth')) && rt.is_true(rt.greater(var_term.array_get('depth'), rt.new_int(0))))) {
			var_option.array_set('depth', var_term.array_get('depth'))
		}
		if rt.is_true(rt.new_bool(var_term.array_isset(rt.new_string('parent')) && rt.is_true(rt.greater(var_term.array_get('parent'), rt.new_int(0))))) {
			var_option.array_set('parent', var_term.array_get('parent'))
		}
	}
	return (var_option).str()
	}
		mut var_taxonomy_options := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_taxonomy_terms.dup()])
		var_filter_context.array_set('items', var_taxonomy_options.dup())
	}
	mut var_wrapper_attributes := rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' }, rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [this.get_block_type()]) }, rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'activeLabelTemplate', val: (rt.get_property(rt.get_property(var_taxonomy_object, 'labels'), 'singular_name')).str() + ': {{label}}' }, rt.ArrayItem{ key: 'filterType', val: 'taxonomy/' + (var_taxonomy).str() }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]) }])
	if !rt.is_true(var_filter_context.array_get('items')) {
		var_wrapper_attributes.array_set('hidden', true)
		var_wrapper_attributes.array_set('class', 'wc-block-product-filter--hidden')
	}
	closure_4_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parsed_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	// unsupported expression: Expr_AssignOp_Concat
	return (var_carry).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.dup()]), rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get('innerBlocks'), rt.new_closure(closure_4_fn), rt.new_string('')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) get_sorted_terms(var_taxonomy rt.PhpVal, var_taxonomy_counts rt.PhpVal, var_hide_empty rt.PhpVal, var_orderby rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_taxonomy_counts_mutated := var_taxonomy_counts
	mut var_hide_empty_mutated := var_hide_empty
	mut var_orderby_mutated := var_orderby
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy_mutated.dup()]))))) {
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_mutated }, rt.ArrayItem{ key: 'hide_empty', val: false }])
		if rt.is_true(var_hide_empty_mutated) {
			var_args.array_set('include', rt.func_array_keys(var_taxonomy_counts_mutated.dup()))
		}
		mut var_terms := rt.call_function('get_terms', [var_args.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) || !rt.is_true(var_terms))) {
			return rt.new_array()
		}
		if rt.is_true(rt.identical(rt.new_string('menu_order'), var_orderby_mutated)) {
			rt.call_function('update_termmeta_cache', [rt.call_function('wp_list_pluck', [var_terms.dup(), rt.new_string('term_id')])])
			closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	mut var_menu_order := rt.call_function('get_term_meta', [var_term.array_get('term_id'), rt.new_string('order'), rt.new_bool(true)])
	var_term.array_set('menu_order', if rt.is_true(rt.new_bool(var_menu_order.dup().is_long() || var_menu_order.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	return // unsupported expression: Expr_Cast_Object
	}
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	mut var_menu_order := rt.call_function('get_term_meta', [var_term.array_get('term_id'), rt.new_string('order'), rt.new_bool(true)])
	var_term.array_set('menu_order', if rt.is_true(rt.new_bool(var_menu_order.dup().is_long() || var_menu_order.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	return // unsupported expression: Expr_Cast_Object
	}
			var_terms = rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_terms.dup()])
		}
		return this.sort_terms_by_criteria(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_terms), (var_orderby_mutated).str(), (var_order_mutated).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_taxonomy_counts_mutated))
	}
	return this.get_hierarchical_terms((var_taxonomy_mutated).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_taxonomy_counts_mutated), (var_hide_empty_mutated).to_bool(), (var_orderby_mutated).str(), (var_order_mutated).str())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) get_taxonomy_term_counts(var_block rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut var_query_vars := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.get_query_vars(arg_0, arg_1) }(var_block.dup(), rt.new_int(1))
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_params_handler := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Internal_ProductFilters_Params.class()])
	mut var_taxonomy_params := rt.call_method(, 'get_param', [])
	if var_taxonomy_params.array_isset(var_taxonomy_mutated) {
		
	}
	if rt.is_true() {
	}
	if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) get_taxonomies() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) sort_hierarchy_terms(var_terms rt.PhpVal, var_orderby rt.PhpVal, var_order rt.PhpVal, var_taxonomy_counts rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_orderby_mutated := var_orderby
	mut var_order_mutated := var_order
	mut var_taxonomy_counts_mutated := var_taxonomy_counts
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) flatten_terms_list(var_terms rt.PhpVal, var_result rt.PhpVal, var_visited_ids rt.PhpVal, depth i64)  {
	mut var_terms_mutated := var_terms
	mut var_result_mutated := var_result
	mut var_visited_ids_mutated := var_visited_ids
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) get_hierarchical_terms(taxonomy string, mut var_taxonomy_counts Class_Automattic_WooCommerce_Blocks_BlockTypes_array, hide_empty bool, orderby string, order string) rt.PhpVal {
	mut taxonomy_mutated := taxonomy
	mut var_taxonomy_counts_mutated := var_taxonomy_counts
	mut hide_empty_mutated := hide_empty
	mut orderby_mutated := orderby
	mut order_mutated := order
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) sort_terms_by_criteria(mut var_terms Class_Automattic_WooCommerce_Blocks_BlockTypes_array, orderby string, order string, mut var_taxonomy_counts Class_Automattic_WooCommerce_Blocks_BlockTypes_array) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut orderby_mutated := orderby
	mut order_mutated := order
	mut var_taxonomy_counts_mutated := var_taxonomy_counts
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfiltertaxonomy() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-filter-taxonomy')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_selected_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_selected_filters(dispatch_arg_0, dispatch_arg_1)
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register_taxonomy_menu_order_rest_field' {
			this.register_taxonomy_menu_order_rest_field()
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_sorted_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.get_sorted_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_taxonomy_term_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_taxonomy_term_counts(dispatch_arg_0, dispatch_arg_1)
		}
		'get_taxonomies' {
			return this.get_taxonomies()
		}
		'sort_hierarchy_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.sort_hierarchy_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'flatten_terms_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.flatten_terms_list(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_hierarchical_terms' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return this.get_hierarchical_terms(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'sort_terms_by_criteria' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.sort_terms_by_criteria(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterTaxonomy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfiltertaxonomy_php() {
	// unsupported statement: Stmt_Declare
}
