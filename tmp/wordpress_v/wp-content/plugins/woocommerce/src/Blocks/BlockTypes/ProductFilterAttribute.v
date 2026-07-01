import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-filter-attribute')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('woocommerce_blocks_product_filters_selected_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_selected_filters' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('deleted_transient'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'delete_default_attribute_id_transient' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_block_patterns' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes_mutated))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultProductFilterAttribute'), this.get_default_product_attribute()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) delete_default_attribute_id_transient(var_transient rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('wc_attribute_taxonomies'), var_transient)) {
		rt.call_function('delete_transient', [rt.new_string('wc_block_product_filter_attribute_default_attribute')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_attribute_object := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	var_acc.array_set(rt.get_property(var_attribute_object, 'attribute_name'), rt.get_property(var_attribute_object, 'attribute_label'))
	return var_acc.dup()
	}
	mut var_product_attributes_map := rt.call_function('array_reduce', [rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}), rt.new_closure(closure_1_fn), rt.new_array()])
	mut var_active_attributes := rt.new_array()
	mut var_all_term_slugs := rt.new_array()
	mut var_query_types := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_product_attributes_map.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute_name := item_1.val
			mut var_param_key := rt.new_string(rt.new_string("filter_${var_attribute_name.to_string()}"))
			if rt.is_true(rt.new_bool(!rt.is_true(var_params.array_get(var_param_key)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_params.array_get(var_param_key).is_string()))))))) {
				continue
			}
			mut var_term_slugs := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_params.array_get(var_param_key)])])])
			if !rt.is_true(var_term_slugs) {
				continue
			}
			var_active_attributes.array_set("pa_${var_attribute_name.to_string()}", var_term_slugs.dup())
			var_query_types.array_set(var_attribute_name, if !(var_params.array_get('query_type_' + (var_attribute_name).str())).is_null() { var_params.array_get('query_type_' + (var_attribute_name).str()) } else { rt.new_string('or') })
			var_all_term_slugs = rt.call_function('array_merge', [var_all_term_slugs.dup(), var_term_slugs.dup()])
		}
	}
	if !rt.is_true(var_active_attributes) {
		return var_items_mutated.dup()
	}
	mut var_attribute_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_active_attributes.dup()) }, rt.ArrayItem{ key: 'slug', val: var_all_term_slugs }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_attribute_terms.dup()])) || !rt.is_true(var_attribute_terms))) {
		return var_items_mutated.dup()
	}
	{
		mut iter_1 := var_attribute_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term_object := item_1.val
			mut var_attribute_name := rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_term_object, 'taxonomy')])
			var_items_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'attribute/' + (var_attribute_name).str() }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_term_object, 'slug') }, rt.ArrayItem{ key: 'activeLabel', val: rt.call_function('sprintf', [rt.new_string('%s: %s'), var_product_attributes_map.array_get(var_attribute_name), rt.get_property(var_term_object, 'name')]) }, rt.ArrayItem{ key: 'attributeQueryType', val: if !(var_query_types.array_get(var_attribute_name)).is_null() { var_query_types.array_get(var_attribute_name) } else { rt.new_string('or') } }]))
		}
	}
	return var_items_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) render(var_block_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_attributes_mutated := var_block_attributes
	if !rt.is_true(var_block_attributes_mutated.array_get('attributeId')) {
		mut var_default_product_attribute := this.get_default_product_attribute()
		var_block_attributes_mutated.array_set('attributeId', rt.get_property(var_default_product_attribute, 'attribute_id'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) || !rt.is_true(var_block_attributes_mutated.array_get('attributeId')))) {
		return ''
	}
	mut var_product_attribute := rt.call_function('wc_get_attribute', [var_block_attributes_mutated.array_get('attributeId')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_attribute)))) {
		return ''
	}
	mut var_attribute_counts := this.get_attribute_counts(var_block.dup(), rt.get_property(var_product_attribute, 'slug'), var_block_attributes_mutated.array_get('queryType'))
	mut var_hide_empty := if !(var_block_attributes_mutated.array_get('hideEmpty')).is_null() { var_block_attributes_mutated.array_get('hideEmpty') } else { rt.new_bool(true) }
	mut var_orderby := if rt.is_true(var_block_attributes_mutated.array_get('sortOrder')) { rt.call_function('explode', [rt.new_string('-'), var_block_attributes_mutated.array_get('sortOrder')]).array_get(0) } else { rt.new_string('name') }
	mut var_order := rt.new_string(if rt.is_true(var_block_attributes_mutated.array_get('sortOrder')) { rt.new_string(rt.call_function('explode', [rt.new_string('-'), var_block_attributes_mutated.array_get('sortOrder')]).array_get(1).to_string().to_upper()) } else { rt.new_string('DESC') })
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_product_attribute, 'slug') }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'order', val: var_order }])
	if rt.is_true(var_hide_empty) {
		var_args.array_set('include', rt.func_array_keys(var_attribute_counts.dup()))
	} else {
		var_args.array_set('hide_empty', false)
	}
	mut var_attribute_terms := rt.call_function('get_terms', [var_args.dup()])
	mut var_filter_param_key := rt.new_string('filter_' + (rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str())
	mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get('filterParams')).is_null() { rt.get_property(var_block, 'context').array_get('filterParams') } else { rt.new_array() }
	mut var_selected_terms := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_filter_params) && !(!rt.is_true(var_filter_params.array_get(var_filter_param_key))))) && rt.is_true(rt.new_bool(var_filter_params.array_get(var_filter_param_key).is_string())))) {
		var_selected_terms = rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(','), var_filter_params.array_get(var_filter_param_key)])])
	}
	mut var_filter_context := rt.create_array([rt.ArrayItem{ key: 'showCounts', val: if !(var_block_attributes_mutated.array_get('showCounts')).is_null() { var_block_attributes_mutated.array_get('showCounts') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'items', val: rt.new_array() }, rt.ArrayItem{ key: 'groupLabel', val: rt.get_property(var_product_attribute, 'name') }])
	if !(!rt.is_true(var_attribute_counts)) {
		closure_3_fn := fn [var_block_attributes, var_attribute_counts, var_selected_terms, var_product_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_block_attributes, var_attribute_counts, var_selected_terms, var_product_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	var_term.array_set('count', if !(var_attribute_counts.array_get(var_term.array_get('term_id'))).is_null() { var_attribute_counts.array_get(var_term.array_get('term_id')) } else { rt.new_int(0) })
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: var_term.array_get('name') }, rt.ArrayItem{ key: 'value', val: var_term.array_get('slug') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_term.array_get('slug'), var_selected_terms.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_term.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'attribute/' + (rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str() }, rt.ArrayItem{ key: 'attributeQueryType', val: var_block_attributes_mutated.array_get('queryType') }])).str()
	}
	mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_term = rt.cast_array(var_term)
	var_term.array_set('count', if !(var_attribute_counts.array_get(var_term.array_get('term_id'))).is_null() { var_attribute_counts.array_get(var_term.array_get('term_id')) } else { rt.new_int(0) })
	return (rt.create_array([rt.ArrayItem{ key: 'label', val: var_term.array_get('name') }, rt.ArrayItem{ key: 'value', val: var_term.array_get('slug') }, rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [var_term.array_get('slug'), var_selected_terms.dup(), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'count', val: var_term.array_get('count') }, rt.ArrayItem{ key: 'type', val: 'attribute/' + (rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str() }, rt.ArrayItem{ key: 'attributeQueryType', val: var_block_attributes_mutated.array_get('queryType') }])).str()
	}
		mut var_attribute_options := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_attribute_terms.dup()])
		var_filter_context.array_set('items', var_attribute_options.dup())
	}
	mut var_wrapper_attributes := rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' }, rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [this.get_full_block_name()]) }, rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'activeLabelTemplate', val: rt.concat(rt.get_property(var_product_attribute, 'name'), rt.new_string(': {{label}}')) }, rt.ArrayItem{ key: 'filterType', val: 'attribute/' + (rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str() }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]) }])
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_attribute_counts(var_block rt.PhpVal, var_slug rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut var_query_vars := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.get_query_vars(arg_0, arg_1) }(var_block.dup(), rt.new_int(1))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_query_vars.array_unset('filter_' + (rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), var_slug.dup()])).str())
	}
	if rt.is_true(rt.new_bool(var_query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_unset(rt.new_string('taxonomy'))
		var_query_vars.array_unset(rt.new_string('term'))
	}
	if !(!rt.is_true(var_query_vars.array_get('tax_query'))) {
		var_query_vars.array_set('tax_query', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}; return temp.remove_query_array(arg_0, arg_1, arg_2) }(var_query_vars.array_get('tax_query'), rt.new_string('taxonomy'), var_slug.dup()))
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_counts := rt.call_method(rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class()]), 'with', [rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses.class()])]), 'get_attribute_counts', [var_query_vars.dup(), var_slug.dup()])
	mut var_attribute_counts := rt.new_array()
	{
		mut iter_1 := var_counts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_attribute_counts.array_push(rt.create_array([rt.ArrayItem{ key: 'term', val: var_key }, rt.ArrayItem{ key: 'count', val: var_value.dup().to_i64() }]))
		}
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_acc := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_count := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	var_acc.array_set(var_count.array_get('term'), var_count.array_get('count'))
	return var_acc.dup()
	}
	var_attribute_counts = rt.call_function('array_reduce', [var_attribute_counts.dup(), rt.new_closure(closure_5_fn), rt.new_array()])
	return var_attribute_counts.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_default_product_attribute() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(var_cached) {
		return var_cached.dup()
	}
	mut var_cached := rt.call_function('get_transient', [rt.new_string('wc_block_product_filter_attribute_default_attribute')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_cached) && !(rt.get_property(var_cached, 'attribute_id')).is_null())) && !(rt.get_property(var_cached, 'attribute_name')).is_null())) && !(rt.get_property(var_cached, 'attribute_label')).is_null())) && !(rt.get_property(var_cached, 'attribute_type')).is_null())) && !(rt.get_property(var_cached, 'attribute_orderby')).is_null())) && !(rt.get_property(var_cached, 'attribute_public')).is_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_cached.dup()
	}
	mut var_attributes := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_int(rt.call_function('wp_count_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pa_' + (rt.get_property(var_attribute, 'attribute_name')).str() }, rt.ArrayItem{ key: 'hide_empty', val: false }])]).to_i64())
	}
	mut var_attribute := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_int(rt.call_function('wp_count_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pa_' + (rt.get_property(var_attribute, 'attribute_name')).str() }, rt.ArrayItem{ key: 'hide_empty', val: false }])]).to_i64())
	}
	mut var_attributes_count := rt.call_function('array_map', [rt.new_closure(closure_6_fn), var_attributes.dup()])
	rt.call_function('asort', [var_attributes_count.dup()])
	mut var_search := rt.new_int(rt.new_int(30))
	mut var_closest := rt.new_null()
	mut var_attribute_id := rt.new_null()
	{
		mut iter_1 := var_attributes_count.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_id := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_closest)) || rt.is_true(rt.greater(rt.call_function('abs', [rt.sub(var_search, var_closest)]), rt.call_function('abs', [rt.sub(var_count, var_search)]))))) {
				var_closest = var_count
				var_attribute_id = var_id
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_closest) && rt.is_true(rt.greater_equal(var_count, var_search)))) {
				break
			}
		}
	}
	mut var_default_attribute := // unsupported expression: Expr_Cast_Object
	if rt.is_true(var_attribute_id) {
		var_default_attribute = 
		
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) register_block_patterns()  {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_block_type_editor_style() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterattribute() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-filter-attribute')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'delete_default_attribute_id_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_default_attribute_id_transient(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_selected_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_selected_filters(dispatch_arg_0, dispatch_arg_1)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_attribute_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_attribute_counts(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_default_product_attribute' {
			return this.get_default_product_attribute()
		}
		'register_block_patterns' {
			this.register_block_patterns()
			return rt.new_null()
		}
		'get_block_type_editor_style' {
			return this.get_block_type_editor_style()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productfilterattribute_php() {
	// unsupported statement: Stmt_Declare
}
