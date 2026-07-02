import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
pub mut:
	attributes rt.PhpVal = rt.new_array()
	content    rt.PhpVal = rt.new_string('')
	query_args rt.PhpVal = rt.new_array()
	meta_query rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_block_type_attributes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
		rt.ArrayItem{ key: 'columns', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])) },
		rt.ArrayItem{ key: 'rows', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		])) },
		rt.ArrayItem{ key: 'categories', val: this.get_schema_list_ids() },
		rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: 'any' },
		]) },
		rt.ArrayItem{ key: 'contentVisibility', val: this.get_schema_content_visibility() },
		rt.ArrayItem{ key: 'align', val: this.get_schema_align() },
		rt.ArrayItem{ key: 'alignButtons', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'isPreview', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'default', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
				[]rt.PhpVal{})) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) render(var_attributes rt.PhpVal, content string, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	this.attributes = this.parse_attributes(var_attributes_mutated.clone())
	this.content = rt.new_string(content)
	this.query_args = this.parse_query_args()
	mut var_products := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('wc_get_product'),
			this.get_products()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_products)))) {
		return ''
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
	}
	rt.call_function('_prime_post_caches', [
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				var_products.clone()]),
		]),
	])
	mut iter_1 := var_products.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product := item_1.val
		rt.call_method(var_product, 'set_description', [rt.new_string('')])
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_StoreApi_StoreApi{}
	mut iife_result_8 := iife_temp_8.container()
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_api'), 'add_inline_script', [rt.new_string('wp-hooks'),
		rt.new_string(
			'\n\t\t\twindow.addEventListener( "DOMContentLoaded", () => {\n\t\t\t\twp.hooks.doAction(\n\t\t\t\t\t"experimental__woocommerce_blocks-product-list-render",\n\t\t\t\t\t{\n\t\t\t\t\t\tproducts: JSON.parse( decodeURIComponent( "' + (rt.call_function('esc_js', [rt.call_function('rawurlencode', [rt.call_function('wp_json_encode', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{
			key: none
			val: rt.call_method(rt.call_method(iife_result_8, 'get', [Class_Automattic_WooCommerce_StoreApi_SchemaController.class()]), 'get', [rt.new_string('product')])
		}, rt.ArrayItem{ key: none, val: 'get_item_response' }]), var_products.clone()])])])])).str() +
			'" ) ),\n\t\t\t\t\t\tlistName: "' +
			(rt.call_function('esc_js', [rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock'], &this), 'block_name')])).str() +
			'"\n\t\t\t\t\t}\n\t\t\t\t);\n\t\t\t} );\n\t\t\t'),
		rt.new_string('after')])
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="%s"><ul class="wc-block-grid__products">%s</ul></div>'),
		rt.call_function('esc_attr', [this.get_container_classes()]),
		rt.call_function('implode', [rt.new_string(''),
			rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
						'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
					], &this) },
					rt.ArrayItem{ key: none, val: 'render_product' },
				]),
				var_products.clone(),
			])]),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_schema_content_visibility() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'image', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'title', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'price', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'rating', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'button', val: this.get_schema_boolean(rt.new_bool(true)) },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_schema_orderby() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'popularity' },
			rt.ArrayItem{ key: none, val: 'price_asc' },
			rt.ArrayItem{ key: none, val: 'price_desc' },
			rt.ArrayItem{ key: none, val: 'rating' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'menu_order' },
		]) }, rt.ArrayItem{ key: 'default', val: 'date' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'columns', val: rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		]) },
		rt.ArrayItem{ key: 'rows', val: rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		]) },
		rt.ArrayItem{ key: 'alignButtons', val: false },
		rt.ArrayItem{ key: 'categories', val: rt.new_array() },
		rt.ArrayItem{ key: 'catOperator', val: 'any' },
		rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
			rt.ArrayItem{ key: 'image', val: true },
			rt.ArrayItem{ key: 'title', val: true },
			rt.ArrayItem{ key: 'price', val: true },
			rt.ArrayItem{ key: 'rating', val: true },
			rt.ArrayItem{ key: 'button', val: true },
		]) },
		rt.ArrayItem{ key: 'stockStatus', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
			[]rt.PhpVal{})) },
	])
	return rt.call_function('wp_parse_args', [var_attributes_mutated.clone(),
		var_defaults.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) parse_query_args() rt.PhpVal {
	this.meta_query = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'get_meta_query', []rt.PhpVal{})
	mut var_query_args := rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: 'product' },
		rt.ArrayItem{ key: 'post_status', val: 'publish' },
		rt.ArrayItem{ key: 'fields', val: 'ids' },
		rt.ArrayItem{ key: 'ignore_sticky_posts', val: true },
		rt.ArrayItem{ key: 'no_found_rows', val: false },
		rt.ArrayItem{ key: 'orderby', val: '' },
		rt.ArrayItem{ key: 'order', val: '' },
		rt.ArrayItem{ key: 'meta_query', val: this.meta_query },
		rt.ArrayItem{ key: 'tax_query', val: rt.new_array() },
		rt.ArrayItem{ key: 'posts_per_page', val: this.get_products_limit() },
	])
	this.set_block_query_args(var_query_args.clone())
	this.set_ordering_query_args(var_query_args.clone())
	this.set_categories_query_args(var_query_args.clone())
	this.set_visibility_query_args(var_query_args.clone())
	this.set_stock_status_query_args(var_query_args.clone())
	return var_query_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) set_ordering_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	if this.attributes.array_isset(rt.new_string('orderby')) {
		if rt.is_true(rt.identical(rt.new_string('price_desc'),
			this.attributes.array_get(rt.new_string('orderby'))))
		{
			var_query_args_mutated.array_set('orderby', 'price')
			var_query_args_mutated.array_set('order', 'DESC')
		} else if rt.is_true(rt.identical(rt.new_string('price_asc'),
			this.attributes.array_get(rt.new_string('orderby'))))
		{
			var_query_args_mutated.array_set('orderby', 'price')
			var_query_args_mutated.array_set('order', 'ASC')
		} else if rt.is_true(rt.identical(rt.new_string('date'),
			this.attributes.array_get(rt.new_string('orderby'))))
		{
			var_query_args_mutated.array_set('orderby', 'date')
			var_query_args_mutated.array_set('order', 'DESC')
		} else {
			var_query_args_mutated.array_set('orderby',
				this.attributes.array_get(rt.new_string('orderby')))
		}
	}
	var_query_args_mutated = rt.call_function('array_merge', [
		var_query_args_mutated.clone(),
		rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'query'), 'get_catalog_ordering_args', [
			var_query_args_mutated.array_get(rt.new_string('orderby')),
			var_query_args_mutated.array_get(rt.new_string('order')),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) set_block_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) set_categories_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get(rt.new_string('categories')))) {
		mut var_categories := rt.call_function('array_map', [
			rt.new_string('absint'), this.attributes.array_get(rt.new_string('categories'))])
		var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
			rt.ArrayItem{ key: 'terms', val: var_categories },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(rt.new_string('all'),
					this.attributes.array_get(rt.new_string('catOperator'))))
				{
					'AND'
				} else {
					'IN'
				}
			},
			rt.ArrayItem{
				key: 'include_children'
				val: if rt.is_true(rt.identical(rt.new_string('all'),
					this.attributes.array_get(rt.new_string('catOperator'))))
				{
					false
				} else {
					true
				}
			},
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) set_visibility_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	mut var_product_visibility_not_in := rt.create_array([
		rt.ArrayItem{
			key: none
			val: var_product_visibility_terms.array_get(rt.new_string('exclude-from-catalog'))
		},
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))
	{
		var_product_visibility_not_in.array_push(var_product_visibility_terms.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()))
	}
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
		rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
		rt.ArrayItem{ key: 'terms', val: var_product_visibility_not_in },
		rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) set_stock_status_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	mut var_stock_statuses := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
		[]rt.PhpVal{}))
	if this.attributes.array_isset(rt.new_string('stockStatus'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stock_statuses, this.attributes.array_get(rt.new_string('stockStatus')))))) {
		var_query_args_mutated.array_set('meta_query', this.meta_query)
		var_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_stock_status' },
			rt.ArrayItem{ key: 'value', val: rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: none, val: '' }]),
				this.attributes.array_get(rt.new_string('stockStatus')),
			]) },
			rt.ArrayItem{ key: 'compare', val: 'IN' },
		]))
	} else {
		var_query_args_mutated.array_set('meta_query', this.meta_query)
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_products_limit() i64 {
	if this.attributes.array_isset(rt.new_string('rows'))
		&& this.attributes.array_isset(rt.new_string('columns'))
		&& !(!rt.is_true(this.attributes.array_get(rt.new_string('rows')))) {
		this.attributes.array_set('limit',
			this.attributes.array_get(rt.new_string('columns')).to_i64() * this.attributes.array_get(rt.new_string('rows')).to_i64())
	}
	return this.attributes.array_get(rt.new_string('limit')).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_products() rt.PhpVal {
	mut var_is_cacheable := rt.new_bool((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_product_grid_is_cacheable'),
		rt.new_bool(true),
		this.query_args,
	])).to_bool())
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper{}
	mut iife_result_9 := iife_temp_9.get_transient_version(rt.new_string('product_query'))
	mut var_transient_version := iife_result_9
	mut var_query := create_automattic_woocommerce_blocks_utils_blockswpquery(this.query_args)
	mut var_results := rt.call_function('wp_parse_id_list', [if rt.is_true(var_is_cacheable) {
		var_query.get_cached_posts(var_transient_version.clone())
	} else {
		var_query.get_posts()
	}])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'remove_ordering_args', []rt.PhpVal{})
	if !(!rt.is_true(var_results)) {
		rt.call_function('_prime_post_caches', [var_results.clone()])
	}
	this.prime_product_variations(var_results.clone())
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_non_cached_ids(var_product_ids rt.PhpVal, var_cache_key rt.PhpVal) rt.PhpVal {
	mut var_non_cached_ids := rt.new_array()
	mut var_cache_values := rt.call_function('wp_cache_get_multiple', [
		var_product_ids.clone(), var_cache_key.clone()])
	mut iter_2 := var_cache_values.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_id := item_2.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
			var_non_cached_ids.array_push(rt.new_int(var_id.to_i64()))
		}
	}
	return var_non_cached_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) prime_product_variations(var_product_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_cache_group := rt.new_string('product_variation_meta_data')
	mut var_prime_product_ids := this.get_non_cached_ids(rt.call_function('wp_parse_id_list', [
		var_product_ids.clone(),
	]), var_cache_group.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_prime_product_ids)))) {
		return
	}
	mut var_product_variations := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('SELECT ID as variation_id, post_parent as product_id from '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_parent IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), var_prime_product_ids.clone()])).str() +
			' )').str()),
		rt.get_constant('ARRAY_A'),
	])
	mut var_prime_variation_ids := rt.call_function('array_column', [
		var_product_variations.clone(), rt.new_string('variation_id')])
	mut var_variation_ids_by_parent := rt.call_function('array_column', [
		var_product_variations.clone(), rt.new_string('product_id'),
		rt.new_string('variation_id')])
	if !rt.is_true(var_prime_variation_ids) {
		return
	}
	mut var_all_variation_meta_data := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT post_id as variation_id, meta_key as attribute_key, meta_value as attribute_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('esc_sql'), var_prime_variation_ids.clone()])])).str() +
				') AND meta_key LIKE %s').str()),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('attribute_')])).str() + '%'),
		]),
	])
	closure_11_fn := fn [var_variation_ids_by_parent] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_values := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_data := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_values.array_get_mut(if !(var_variation_ids_by_parent.array_get(rt.get_property(var_data,
			'variation_id'))).is_null() {
			var_variation_ids_by_parent.array_get(rt.get_property(var_data, 'variation_id'))
		} else {
			rt.new_int(0)
		}).array_push(var_data.clone())
		return
	}
	mut var_primed_data := rt.call_function('array_reduce', [
		var_all_variation_meta_data.clone(), rt.new_closure(closure_11_fn),
		rt.call_function('array_fill_keys', [var_prime_product_ids.clone(),
			rt.new_array()])])
	mut iter_3 := var_primed_data.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_variation_meta_data := item_3.val
		mut var_product_id := item_3.key
		rt.call_function('wp_cache_set', [var_product_id.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'last_modified', val: rt.call_function('get_the_modified_date', [
					rt.new_string('U'),
					var_product_id.clone(),
				]) },
				rt.ArrayItem{ key: 'data', val: var_variation_meta_data },
			]),
			var_cache_group.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_container_classes() rt.PhpVal {
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-block-grid' },
		rt.ArrayItem{ key: none, val: rt.concat(rt.new_string('wp-block-'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
		], &this), 'block_name')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.new_string('wp-block-woocommerce-'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
		], &this), 'block_name')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.new_string('wc-block-'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
		], &this), 'block_name')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.new_string('has-'),
			this.attributes.array_get(rt.new_string('columns'))), rt.new_string('-columns')) }])
	if rt.is_true(rt.greater(this.attributes.array_get(rt.new_string('rows')), rt.new_int(1))) {
		var_classes.array_push('has-multiple-rows')
	}
	if this.attributes.array_isset(rt.new_string('align')) {
		var_classes.array_push(rt.concat(rt.new_string('align'),
			this.attributes.array_get(rt.new_string('align'))))
	}
	if !(!rt.is_true(this.attributes.array_get(rt.new_string('alignButtons')))) {
		var_classes.array_push('has-aligned-buttons')
	}
	if !(!rt.is_true(this.attributes.array_get(rt.new_string('className')))) {
		var_classes.array_push(this.attributes.array_get(rt.new_string('className')))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) render_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'permalink', val: rt.call_function('esc_url', [
			rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
		]) },
		rt.ArrayItem{ key: 'image', val: this.get_image_html(var_product.clone()) },
		rt.ArrayItem{ key: 'title', val: this.get_title_html(var_product.clone()) },
		rt.ArrayItem{ key: 'rating', val: this.get_rating_html(var_product.clone()) },
		rt.ArrayItem{ key: 'price', val: this.get_price_html(var_product.clone()) },
		rt.ArrayItem{ key: 'badge', val: this.get_sale_badge_html(var_product.clone()) },
		rt.ArrayItem{ key: 'button', val: this.get_button_html(var_product.clone()) },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_product_grid_item_html'),
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<li class="wc-block-grid__product">\n\t\t\t\t<a href="'), rt.get_property(var_data,
			'permalink')), rt.new_string('" class="wc-block-grid__product-link">\n\t\t\t\t\t')), rt.get_property(var_data,
			'badge')), rt.new_string('\n\t\t\t\t\t')), rt.get_property(var_data, 'image')),
			rt.new_string('\n\t\t\t\t\t')), rt.get_property(var_data, 'title')),
			rt.new_string('\n\t\t\t\t</a>\n\t\t\t\t')), rt.get_property(var_data, 'price')),
			rt.new_string('\n\t\t\t\t')), rt.get_property(var_data, 'rating')),
			rt.new_string('\n\t\t\t\t')), rt.get_property(var_data, 'button')),
			rt.new_string('\n\t\t\t</li>')),
		var_data.clone(),
		var_product.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_image_html(var_product rt.PhpVal) string {
	if rt.is_true(rt.new_bool(this.attributes.array_get(rt.new_string('contentVisibility')).array_isset(rt.new_string('image'))))
		&& rt.is_true(rt.identical(rt.new_bool(false), this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('image')))) {
		return ''
	}
	mut var_attr := rt.create_array([rt.ArrayItem{ key: 'alt', val: '' }])
	if rt.is_true(rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})) {
		mut var_image_alt := rt.call_function('get_post_meta', [
			rt.call_method(var_product, 'get_image_id', []rt.PhpVal{}),
			rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true),
		])
		var_attr = rt.create_array([
			rt.ArrayItem{
				key: 'alt'
				val: if rt.is_true(var_image_alt) {
					var_image_alt
				} else {
					rt.call_method(var_product, 'get_name', []rt.PhpVal{})
				}
			},
		])
	}
	return '<div class="wc-block-grid__product-image">' +
		(rt.call_method(var_product, 'get_image', [rt.new_string('woocommerce_thumbnail'), var_attr.clone()])).str() +
		'</div>'
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_title_html(var_product rt.PhpVal) string {
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('title'))) {
		return ''
	}
	return '<div class="wc-block-grid__product-title">' +
		(rt.call_function('wp_kses_post', [rt.call_method(var_product, 'get_title', []rt.PhpVal{})])).str() +
		'</div>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_rating_html(var_product rt.PhpVal) string {
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('rating'))) {
		return ''
	}
	mut var_rating_count := rt.call_method(var_product, 'get_rating_count', []rt.PhpVal{})
	mut var_average := rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_rating_count, rt.new_int(0))) {
		return (rt.call_function('sprintf', [
			rt.new_string('<div class="wc-block-grid__product-rating">%s</div>'),
			rt.call_function('wc_get_rating_html', [var_average.clone(),
				var_rating_count.clone()]),
		])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_price_html(var_product rt.PhpVal) string {
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('price'))) {
		return ''
	}
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="wc-block-grid__product-price price">%s</div>'),
		rt.call_function('wp_kses_post', [
			rt.call_method(var_product, 'get_price_html', []rt.PhpVal{}),
		]),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_sale_badge_html(var_product rt.PhpVal) string {
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('price'))) {
		return ''
	}
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('image'))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{}))))) {
		return ''
	}
	return '<div class="wc-block-grid__product-onsale">\n\t\t\t<span aria-hidden="true">' +
		(rt.call_function('esc_html__', [rt.new_string('Sale'), rt.new_string('woocommerce')])).str() +
		'</span>\n\t\t\t<span class="screen-reader-text">' +
		(rt.call_function('esc_html__', [rt.new_string('Product on sale'), rt.new_string('woocommerce')])).str() +
		'</span>\n\t\t</div>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_button_html(var_product rt.PhpVal) string {
	if !rt.is_true(this.attributes.array_get(rt.new_string('contentVisibility')).array_get(rt.new_string('button'))) {
		return ''
	}
	return '<div class="wp-block-button wc-block-grid__product-add-to-cart">' +
		(this.get_add_to_cart(var_product.clone())).str() + '</div>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_add_to_cart(var_product rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.create_array([
		rt.ArrayItem{ key: 'aria-label', val: rt.call_method(var_product,
			'add_to_cart_description', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'data-quantity', val: '1' },
		rt.ArrayItem{ key: 'data-product_id', val: rt.call_method(var_product, 'get_id',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'data-product_sku', val: rt.call_method(var_product, 'get_sku',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'data-price', val: rt.call_function('wc_get_price_to_display', [
			var_product.clone(),
		]) },
		rt.ArrayItem{ key: 'rel', val: 'nofollow' },
		rt.ArrayItem{ key: 'class', val: 'wp-block-button__link ' +
			(if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_wp_theme_get_element_class_name')])) { rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')]) } else { rt.new_string('') }).str() +
			' add_to_cart_button' },
	])
	if rt.is_true(rt.call_method(var_product, 'supports', [rt.new_string('ajax_add_to_cart')]))
		&& rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})) {
		var_attributes.array_get(rt.new_string('class')) = rt.concat(var_attributes.array_get(rt.new_string('class')),
			rt.new_string(' ajax_add_to_cart'))
	}
	var_attributes = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_product_grid_add_to_cart_attributes'),
		var_attributes.clone(),
		var_product.clone(),
	])
	return rt.call_function('sprintf', [rt.new_string('<a href="%s" %s>%s</a>'),
		rt.call_function('esc_url', [
			rt.call_method(var_product, 'add_to_cart_url', []rt.PhpVal{}),
		]),
		rt.call_function('wc_implode_html_attributes', [
			var_attributes.clone(),
		]),
		rt.call_function('esc_html', [
			rt.call_method(var_product, 'add_to_cart_text', []rt.PhpVal{}),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('minColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::min_columns'),
			rt.new_int(1),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('maxColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::max_columns'),
			rt.new_int(6),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('minRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::min_rows'),
			rt.new_int(1),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('maxRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::max_rows'),
			rt.new_int(6),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) get_block_type_style() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-style' },
		rt.ArrayItem{ key: none, val: 'wc-blocks-style-all-products' }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
		attributes:    rt.new_array()
		content:       rt.new_string('')
		query_args:    rt.new_array()
		meta_query:    rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractdynamicblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_storeapi(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wc_cache_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blockswpquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_schema_content_visibility' {
			return this.get_schema_content_visibility()
		}
		'get_schema_orderby' {
			return this.get_schema_orderby()
		}
		'parse_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_attributes(dispatch_arg_0)
		}
		'parse_query_args' {
			return this.parse_query_args()
		}
		'set_ordering_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_ordering_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_block_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_block_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_categories_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_categories_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_stock_status_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_stock_status_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'get_products_limit' {
			return rt.new_int(this.get_products_limit())
		}
		'get_products' {
			return this.get_products()
		}
		'get_non_cached_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_non_cached_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'prime_product_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prime_product_variations(dispatch_arg_0)
			return rt.new_null()
		}
		'get_container_classes' {
			return this.get_container_classes()
		}
		'render_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_product(dispatch_arg_0)
		}
		'get_image_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_image_html(dispatch_arg_0))
		}
		'get_title_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_title_html(dispatch_arg_0))
		}
		'get_rating_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_rating_html(dispatch_arg_0))
		}
		'get_price_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_price_html(dispatch_arg_0))
		}
		'get_sale_badge_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_sale_badge_html(dispatch_arg_0))
		}
		'get_button_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_button_html(dispatch_arg_0))
		}
		'get_add_to_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_add_to_cart(dispatch_arg_0)
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
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'attributes' { return this.attributes }
		'content' { return this.content }
		'query_args' { return this.query_args }
		'meta_query' { return this.meta_query }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'attributes' {
			this.attributes = val
			return true
		}
		'content' {
			this.content = val
			return true
		}
		'query_args' {
			this.query_args = val
			return true
		}
		'meta_query' {
			this.meta_query = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
