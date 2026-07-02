import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-filter-attribute')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_blocks_product_filters_selected_items'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'prepare_selected_filters' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('deleted_transient'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'delete_default_attribute_id_transient' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_block_patterns' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated))
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [
			rt.new_string('defaultProductFilterAttribute'),
			this.get_default_product_attribute(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) delete_default_attribute_id_transient(var_transient rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('wc_attribute_taxonomies'), var_transient)) {
		rt.call_function('delete_transient', [
			rt.new_string('wc_block_product_filter_attribute_default_attribute'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) prepare_selected_filters(var_items rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_attribute_object := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_acc.array_set(rt.get_property(var_attribute_object, 'attribute_name'), rt.get_property(var_attribute_object,
			'attribute_label'))
		return var_acc.clone()
	}
	mut var_product_attributes_map := rt.call_function('array_reduce', [
		rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
		rt.new_array(),
	])
	mut var_active_attributes := rt.new_array()
	mut var_all_term_slugs := rt.new_array()
	mut var_query_types := rt.new_array()
	mut iter_1 := rt.func_array_keys(var_product_attributes_map.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attribute_name := item_1.val
		mut var_param_key := rt.new_string('filter_${var_attribute_name.to_string()}')
		if !rt.is_true(var_params.array_get(var_param_key))
			|| !(var_params.array_get(var_param_key).is_string()) {
			continue
		}
		mut var_term_slugs := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('explode', [rt.new_string(','),
					var_params.array_get(var_param_key)])]),
		])
		if !rt.is_true(var_term_slugs) {
			continue
		}
		var_active_attributes.array_set('pa_${var_attribute_name.to_string()}',
			var_term_slugs.clone())
		var_query_types.array_set(var_attribute_name, if !(var_params.array_get(rt.new_string(
			'query_type_' + var_attribute_name.str()))).is_null() {
			var_params.array_get(rt.new_string('query_type_' + var_attribute_name.str()))
		} else {
			rt.new_string('or')
		})
		var_all_term_slugs = rt.call_function('array_merge', [
			var_all_term_slugs.clone(), var_term_slugs.clone()])
	}
	if !rt.is_true(var_active_attributes) {
		return var_items_mutated.clone()
	}
	mut var_attribute_terms := rt.call_function('get_terms', [
		rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: rt.func_array_keys(var_active_attributes.clone()) },
			rt.ArrayItem{ key: 'slug', val: var_all_term_slugs },
			rt.ArrayItem{ key: 'hide_empty', val: false },
		]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_attribute_terms.clone()]))
		|| !rt.is_true(var_attribute_terms) {
		return var_items_mutated.clone()
	}
	mut iter_2 := var_attribute_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_object := item_2.val
		mut var_attribute_name := rt.call_function('str_replace', [
			rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_term_object, 'taxonomy')])
		var_items_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'attribute/' + var_attribute_name.str() },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_term_object, 'slug') },
			rt.ArrayItem{ key: 'activeLabel', val: rt.call_function('sprintf', [
				rt.new_string('%s: %s'),
				var_product_attributes_map.array_get(var_attribute_name),
				rt.get_property(var_term_object, 'name'),
			]) },
			rt.ArrayItem{
				key: 'attributeQueryType'
				val: if !(var_query_types.array_get(var_attribute_name)).is_null() {
					var_query_types.array_get(var_attribute_name)
				} else {
					rt.new_string('or')
				}
			},
		]))
	}
	return var_items_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) render(var_block_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_attributes_mutated := var_block_attributes
	if !rt.is_true(var_block_attributes_mutated.array_get(rt.new_string('attributeId'))) {
		mut var_default_product_attribute := this.get_default_product_attribute()
		var_block_attributes_mutated.array_set('attributeId', rt.get_property(var_default_product_attribute,
			'attribute_id'))
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| !rt.is_true(var_block_attributes_mutated.array_get(rt.new_string('attributeId'))) {
		return ''
	}
	mut var_product_attribute := rt.call_function('wc_get_attribute', [
		var_block_attributes_mutated.array_get(rt.new_string('attributeId')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_attribute)))) {
		return ''
	}
	mut var_attribute_counts := this.get_attribute_counts(var_block.clone(), rt.get_property(var_product_attribute,
		'slug'), var_block_attributes_mutated.array_get(rt.new_string('queryType')))
	mut var_hide_empty := if !(var_block_attributes_mutated.array_get(rt.new_string('hideEmpty'))).is_null() {
		var_block_attributes_mutated.array_get(rt.new_string('hideEmpty'))
	} else {
		rt.new_bool(true)
	}
	mut var_orderby := if rt.is_true(var_block_attributes_mutated.array_get(rt.new_string('sortOrder'))) { rt.call_function('explode', [
			rt.new_string('-'),
			var_block_attributes_mutated.array_get(rt.new_string('sortOrder')),
		]).array_get(rt.new_int(0)) } else { rt.new_string('name') }
	mut var_order := rt.new_string((if rt.is_true(var_block_attributes_mutated.array_get(rt.new_string('sortOrder'))) { rt.call_function('explode', [
			rt.new_string('-'),
			var_block_attributes_mutated.array_get(rt.new_string('sortOrder')),
		]).array_get(rt.new_int(1)).to_string().to_upper() } else { 'DESC' }).str())
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_product_attribute, 'slug') },
		rt.ArrayItem{ key: 'orderby', val: var_orderby },
		rt.ArrayItem{ key: 'order', val: var_order },
	])
	if rt.is_true(var_hide_empty) {
		var_args.array_set('include', rt.func_array_keys(var_attribute_counts.clone()))
	} else {
		var_args.array_set('hide_empty', false)
	}
	mut var_attribute_terms := rt.call_function('get_terms', [
		var_args.clone()])
	mut var_filter_param_key :=
		rt.new_string('filter_' +(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str())
	mut var_filter_params := if !(rt.get_property(var_block, 'context').array_get(rt.new_string('filterParams'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('filterParams'))
	} else {
		rt.new_array()
	}
	mut var_selected_terms := rt.new_array()
	if rt.is_true(var_filter_params)
		&& !(!rt.is_true(var_filter_params.array_get(var_filter_param_key)))
		&& var_filter_params.array_get(var_filter_param_key).is_string() {
		var_selected_terms = rt.call_function('array_filter', [
			rt.call_function('explode',
				[rt.new_string(','), var_filter_params.array_get(var_filter_param_key)]),
		])
	}
	mut var_filter_context := rt.create_array([
		rt.ArrayItem{
			key: 'showCounts'
			val: if !(var_block_attributes_mutated.array_get(rt.new_string('showCounts'))).is_null() {
				var_block_attributes_mutated.array_get(rt.new_string('showCounts'))
			} else {
				rt.new_bool(false)
			}
		},
		rt.ArrayItem{ key: 'items', val: rt.new_array() },
		rt.ArrayItem{ key: 'groupLabel', val: rt.get_property(var_product_attribute, 'name') },
	])
	if !(!rt.is_true(var_attribute_counts)) {
		closure_2_fn := fn [var_block_attributes, var_attribute_counts, var_selected_terms, var_product_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_term = rt.cast_array(var_term)
			var_term.array_set('count', if !(var_attribute_counts.array_get(var_term.array_get(rt.new_string('term_id')))).is_null() {
				var_attribute_counts.array_get(var_term.array_get(rt.new_string('term_id')))
			} else {
				rt.new_int(0)
			})
			return (rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_term.array_get(rt.new_string('name')) },
				rt.ArrayItem{ key: 'value', val: var_term.array_get(rt.new_string('slug')) },
				rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [
					var_term.array_get(rt.new_string('slug')),
					var_selected_terms.clone(),
					rt.new_bool(true),
				]) },
				rt.ArrayItem{ key: 'count', val: var_term.array_get(rt.new_string('count')) },
				rt.ArrayItem{
					key: 'type'
					val: 'attribute/' +(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str()
				},
				rt.ArrayItem{
					key: 'attributeQueryType'
					val: var_block_attributes_mutated.array_get(rt.new_string('queryType'))
				},
			])).str()
		}
		closure_3_fn := fn [var_block_attributes, var_attribute_counts, var_selected_terms, var_product_attribute] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_term = rt.cast_array(var_term)
			var_term.array_set('count', if !(var_attribute_counts.array_get(var_term.array_get(rt.new_string('term_id')))).is_null() {
				var_attribute_counts.array_get(var_term.array_get(rt.new_string('term_id')))
			} else {
				rt.new_int(0)
			})
			return (rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_term.array_get(rt.new_string('name')) },
				rt.ArrayItem{ key: 'value', val: var_term.array_get(rt.new_string('slug')) },
				rt.ArrayItem{ key: 'selected', val: rt.call_function('in_array', [
					var_term.array_get(rt.new_string('slug')),
					var_selected_terms.clone(),
					rt.new_bool(true),
				]) },
				rt.ArrayItem{ key: 'count', val: var_term.array_get(rt.new_string('count')) },
				rt.ArrayItem{
					key: 'type'
					val: 'attribute/' +(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str()
				},
				rt.ArrayItem{
					key: 'attributeQueryType'
					val: var_block_attributes_mutated.array_get(rt.new_string('queryType'))
				},
			])).str()
		}
		mut var_attribute_options := rt.call_function('array_map', [
			rt.new_closure(closure_2_fn),
			var_attribute_terms.clone(),
		])
		var_filter_context.array_set('items', var_attribute_options.clone())
	}
	mut var_wrapper_attributes := rt.create_array([
		rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/product-filters' },
		rt.ArrayItem{ key: 'data-wp-key', val: rt.call_function('wp_unique_prefixed_id', [
			this.get_full_block_name(),
		]) },
		rt.ArrayItem{ key: 'data-wp-context', val: rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{ key: 'activeLabelTemplate', val: rt.concat(rt.get_property(var_product_attribute,
					'name'), rt.new_string(': {{label}}')) },
				rt.ArrayItem{
					key: 'filterType'
					val: 'attribute/' +(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), rt.get_property(var_product_attribute, 'slug')])).str()
				},
			]),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		]) },
	])
	if !rt.is_true(var_filter_context.array_get(rt.new_string('items'))) {
		var_wrapper_attributes.array_set('hidden', true)
		var_wrapper_attributes.array_set('class', 'wc-block-product-filter--hidden')
	}
	closure_4_fn := fn [var_filter_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parsed_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_carry = rt.concat(var_carry, rt.call_method(create_automattic_woocommerce_blocks_blocktypes_wp_block(var_parsed_block.clone(), rt.create_array([
			rt.ArrayItem{ key: 'filterData', val: var_filter_context },
		])), 'render', []rt.PhpVal{}))
		return var_carry.str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		rt.call_function('get_block_wrapper_attributes', [var_wrapper_attributes.clone()]),
		rt.call_function('array_reduce', [rt.get_property(var_block, 'parsed_block').array_get(rt.new_string('innerBlocks')),
			rt.new_closure(closure_4_fn), rt.new_string('')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_attribute_counts(var_block rt.PhpVal, var_slug rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('filterParams'))) {
		return rt.new_array()
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}
	mut iife_result_4 := iife_temp_4.get_query_vars(var_block.clone(), rt.new_int(1))
	mut var_query_vars := iife_result_4
	if rt.is_true(rt.new_bool('and' != var_query_type.clone().to_string().to_lower())) {
		var_query_vars.array_unset('filter_' +(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), var_slug.clone()])).str())
	}
	if var_query_vars.array_isset(rt.new_string('taxonomy'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_query_vars.array_get(rt.new_string('taxonomy')), rt.new_string('pa_')]))))) {
		var_query_vars.array_unset(rt.new_string('taxonomy'))
		var_query_vars.array_unset(rt.new_string('term'))
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('tax_query')))) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}
		mut iife_result_5 := iife_temp_5.remove_query_array(var_query_vars.array_get(rt.new_string('tax_query')),
			rt.new_string('taxonomy'), var_slug.clone())
		var_query_vars.array_set('tax_query', iife_result_5)
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_counts := rt.call_method(rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider.class(),
	]), 'with', [
		rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_ProductFilters_QueryClauses.class(),
		]),
	]), 'get_attribute_counts', [var_query_vars.clone(), var_slug.clone()])
	mut var_attribute_counts := rt.new_array()
	mut iter_3 := var_counts.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		var_attribute_counts.array_push(rt.create_array([
			rt.ArrayItem{ key: 'term', val: var_key },
			rt.ArrayItem{ key: 'count', val: var_value.clone().to_i64() },
		]))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_count := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_acc.array_set(var_count.array_get(rt.new_string('term')),
			var_count.array_get(rt.new_string('count')))
		return var_acc.clone()
	}
	var_attribute_counts = rt.call_function('array_reduce', [
		var_attribute_counts.clone(), rt.new_closure(closure_7_fn),
		rt.new_array()])
	return var_attribute_counts.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_default_product_attribute() rt.PhpVal {
	mut var_cached := rt.new_null()
	if rt.is_true(var_cached) {
		return var_cached.clone()
	}
	var_cached = rt.call_function('get_transient', [
		rt.new_string('wc_block_product_filter_attribute_default_attribute'),
	])
	if rt.is_true(var_cached) && !(rt.get_property(var_cached, 'attribute_id')).is_null()
		&& !(rt.get_property(var_cached, 'attribute_name')).is_null()
		&& !(rt.get_property(var_cached, 'attribute_label')).is_null()
		&& !(rt.get_property(var_cached, 'attribute_type')).is_null()
		&& !(rt.get_property(var_cached, 'attribute_orderby')).is_null()
		&& !(rt.get_property(var_cached, 'attribute_public')).is_null()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_cached, 'attribute_id'))))) {
		return var_cached.clone()
	}
	mut var_attributes := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(rt.call_function('wp_count_terms', [
			rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'pa_' +
					(rt.get_property(var_attribute, 'attribute_name')).str() },
				rt.ArrayItem{ key: 'hide_empty', val: false },
			]),
		]).to_i64())
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_attribute := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int(rt.call_function('wp_count_terms', [
			rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'pa_' +
					(rt.get_property(var_attribute, 'attribute_name')).str() },
				rt.ArrayItem{ key: 'hide_empty', val: false },
			]),
		]).to_i64())
	}
	mut var_attributes_count := rt.call_function('array_map', [
		rt.new_closure(closure_8_fn),
		var_attributes.clone(),
	])
	rt.call_function('asort', [var_attributes_count.clone()])
	mut var_search := rt.new_int(30)
	mut var_closest := rt.new_null()
	mut var_attribute_id := rt.new_null()
	mut iter_4 := var_attributes_count.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_count := item_4.val
		mut var_id := item_4.key
		if rt.is_true(rt.identical(rt.new_null(), var_closest))
			|| rt.is_true(rt.greater(rt.call_function('abs', [rt.sub(var_search, var_closest)]), rt.call_function('abs', [rt.sub(var_count, var_search)]))) {
			var_closest = var_count
			var_attribute_id = var_id
		}
		if rt.is_true(var_closest) && rt.is_true(rt.greater_equal(var_count, var_search)) {
			break
		}
	}
	mut var_default_attribute := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'attribute_id', val: '0' },
		rt.ArrayItem{ key: 'attribute_name', val: 'attribute' },
		rt.ArrayItem{ key: 'attribute_label', val: rt.call_function('__', [
			rt.new_string('Attribute'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'attribute_type', val: 'select' },
		rt.ArrayItem{ key: 'attribute_orderby', val: 'menu_order' },
		rt.ArrayItem{ key: 'attribute_public', val: 0 },
	]))
	if rt.is_true(var_attribute_id) {
		var_default_attribute = var_attributes.array_get(var_attribute_id)
		rt.call_function('set_transient', [
			rt.new_string('wc_block_product_filter_attribute_default_attribute'),
			var_default_attribute.clone(),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	return var_default_attribute.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) register_block_patterns() {
	mut var_default_attribute := this.get_default_product_attribute()
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/default-attribute-filter'),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'inserter', val: false }, rt.ArrayItem{ key: 'content', val: rt.call_function('strtr', [
				rt.new_string('\n<!-- wp:woocommerce/product-filter-attribute {"attributeId":{{attribute_id}}} -->\n<div class="wp-block-woocommerce-product-filter-attribute">\n\t<!-- wp:group {"metadata":{"name":"Header"},"style":{"spacing":{"blockGap":"0"}},"layout":{"type":"flex","flexWrap":"nowrap"}} -->\n\t<div class="wp-block-group">\n\t\t<!-- wp:heading {"level":3} -->\n\t\t<h3 class="wp-block-heading">{{attribute_label}}</h3>\n\t\t<!-- /wp:heading -->\n\t<!-- /wp:group -->\n\n\t<!-- wp:woocommerce/product-filter-checkbox-list {"lock":{"remove":true}} -->\n\t<div class="wp-block-woocommerce-product-filter-checkbox-list wc-block-product-filter-checkbox-list"></div>\n\t<!-- /wp:woocommerce/product-filter-checkbox-list -->\n\n</div>\n<!-- /wp:woocommerce/product-filter-attribute -->\n\t\t\t\t\t'),
				rt.create_array([
					rt.ArrayItem{ key: '{{attribute_id}}', val: rt.get_property(var_default_attribute,
						'attribute_id').to_i64() },
					rt.ArrayItem{ key: '{{attribute_label}}', val: rt.call_function('esc_html', [
						rt.get_property(var_default_attribute, 'attribute_label'),
					]) },
				]),
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productfilterattribute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductFilterAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-filter-attribute')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_block(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
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
		'block_name' {
			this.block_name = val
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
