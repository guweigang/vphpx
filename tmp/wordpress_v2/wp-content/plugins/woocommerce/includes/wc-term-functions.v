import rt
import crypto.md5

fn wc_change_get_terms_defaults(var_defaults rt.PhpVal, var_taxonomies rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := rt.new_null()
	mut var_orderby := rt.new_null()
	if var_taxonomies.clone().is_array() && 1 < var_taxonomies.clone().array_count() {
		return var_defaults.clone()
	}
	var_taxonomy = if var_taxonomies.clone().is_array() { (rt.call_function('current', [
			var_taxonomies.clone(),
		])).str() } else { var_taxonomies }
	var_orderby = rt.new_string('name')
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
		var_taxonomy.clone()]))
	{
		var_orderby = rt.call_function('wc_attribute_orderby', [
			var_taxonomy.clone()])
	} else if rt.is_true(rt.call_function('in_array', [var_taxonomy.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_sortable_taxonomies'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }]),
		]),
		rt.new_bool(true)]))
	{
		var_orderby = rt.new_string('menu_order')
	}
	mut switch_val_1 := var_orderby
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('menu_order')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('name_num')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		var_defaults.array_set('orderby', var_orderby.clone())
	}
	return var_defaults.clone()
}

fn wc_change_pre_get_terms(var_terms_query rt.PhpVal) {
	mut var_args := rt.new_null()
	var_args = rt.get_property(var_terms_query, 'query_vars')
	if rt.is_true(rt.identical(rt.new_string('menu_order'),
		var_args.array_get(rt.new_string('orderby'))))
	{
		var_args.array_set('orderby', 'name')
		var_args.array_set('force_menu_order_sort', true)
	}
	if rt.is_true(rt.identical(rt.new_string('name_num'),
		var_args.array_get(rt.new_string('orderby'))))
	{
		var_args.array_set('orderby', 'name')
		var_args.array_set('force_numeric_name', true)
	}
	if rt.is_true(rt.identical(rt.new_string('count'), var_args.array_get(rt.new_string('fields')))) {
		return
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('menu_order')))) {
		var_args.array_set('order', if rt.is_true(rt.identical(rt.new_string('DESC'),
			rt.new_string(var_args.array_get(rt.new_string('menu_order')).to_string().to_upper())))
		{
			'DESC'
		} else {
			'ASC'
		})
		var_args.array_set('force_menu_order_sort', true)
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('force_menu_order_sort')))) {
		var_args.array_set('orderby', 'meta_value_num')
		var_args.array_set('meta_key', 'order')
		rt.call_method(rt.get_property(var_terms_query, 'meta_query'), 'parse_query_vars', [
			var_args.clone(),
		])
	}
}

fn wc_terms_clauses(var_clauses rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_clauses.array_get(rt.new_string('fields')),
		rt.new_string('COUNT(*)'),
	]), rt.new_bool(false)))))
	{
		return var_clauses.clone()
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('force_numeric_name')))) {
		var_clauses['orderby'] = rt.call_function('str_replace', [
			rt.new_string('ORDER BY t.name'),
			rt.new_string('ORDER BY t.name+0'),
			var_clauses.array_get(rt.new_string('orderby')),
		])
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('force_menu_order_sort')))) {
		var_clauses['join'] = rt.call_function('str_replace', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string(' ON ( t.term_id = ')), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string('.term_id )')),
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string(' ON ( t.term_id = ')), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string('.term_id AND ')),
				rt.get_property(var_wpdb, 'termmeta')), rt.new_string(".meta_key='order')")),
			var_clauses.array_get(rt.new_string('join')),
		])
		var_clauses['where'] = rt.call_function('str_replace', [
			rt.concat(rt.get_property(var_wpdb, 'termmeta'), rt.new_string(".meta_key = 'order'")),
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('( '), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string(".meta_key = 'order' OR ")), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string('.meta_key IS NULL )')),
			var_clauses.array_get(rt.new_string('where')),
		])
		var_clauses['orderby'] = if rt.is_true(rt.identical(rt.new_string('DESC'),
			var_args.array_get(rt.new_string('order'))))
		{
			rt.call_function('str_replace', [rt.new_string('meta_value+0'),
				rt.new_string('meta_value+0 DESC, t.name'), var_clauses.array_get(rt.new_string('orderby'))])
		} else {
			rt.call_function('str_replace', [rt.new_string('meta_value+0'),
				rt.new_string('meta_value+0 ASC, t.name'), var_clauses.array_get(rt.new_string('orderby'))])
		}
	}
	return var_clauses.clone()
}

fn wc_get_object_terms(var_object_id rt.PhpVal, var_taxonomy rt.PhpVal, var_field rt.PhpVal, var_index_key rt.PhpVal) rt.PhpVal {
	mut var_terms := rt.new_null()
	var_terms = rt.call_function('get_the_terms', [var_object_id.clone(),
		var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return rt.new_array()
	}
	return if var_field.clone().is_null() { var_terms } else { rt.call_function('wp_list_pluck', [
			var_terms.clone(),
			var_field.clone(),
			var_index_key.clone(),
		]) }
}

fn _wc_get_cached_product_terms(var_product_id rt.PhpVal, var_taxonomy rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_cache_key := rt.new_null()
	mut var_cache_group := rt.new_null()
	mut var_terms := rt.new_null()
	var_cache_key = rt.new_string('wc_' + var_taxonomy.str() +
		md5.hexhash(rt.call_function('wp_json_encode', [var_args.clone()]).to_string()))
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_cache_prefix(rt.new_string('product_' +
		var_product_id.str()))
	var_cache_group = rt.new_string(iife_result_0.str() + var_product_id.str())
	var_terms = rt.call_function('wp_cache_get', [var_cache_key.clone(),
		var_cache_group.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_terms)))) {
		return var_terms.clone()
	}
	var_terms = rt.call_function('wp_get_post_terms', [var_product_id.clone(),
		var_taxonomy.clone(), var_args.clone()])
	rt.call_function('wp_cache_add', [var_cache_key.clone(), var_terms.clone(),
		var_cache_group.clone()])
	return var_terms.clone()
}

fn wc_get_product_terms(var_product_id rt.PhpVal, var_taxonomy rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return rt.new_array()
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_product_terms'),
		_wc_get_cached_product_terms(var_product_id.clone(), var_taxonomy.clone(), var_args.clone()),
		var_product_id.clone(),
		var_taxonomy.clone(),
		var_args.clone(),
	])
}

fn _wc_get_product_terms_name_num_usort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_name := rt.new_null()
	mut var_b_name := rt.new_null()
	var_a_name = rt.new_float((rt.get_property(var_a, 'name')).to_f64())
	var_b_name = rt.new_float((rt.get_property(var_b, 'name')).to_f64())
	if rt.is_true(rt.less(rt.call_function('abs', [rt.sub(var_a_name, var_b_name)]),
		rt.new_float(0.001)))
	{
		return 0
	}
	return if rt.is_true(rt.less(var_a_name, var_b_name)) { -1 } else { 1 }
}

fn _wc_get_product_terms_parent_usort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.get_property(var_a, 'parent'), rt.get_property(var_b, 'parent'))) {
		return 0
	}
	return if rt.is_true(rt.less(rt.get_property(var_a, 'parent'), rt.get_property(var_b, 'parent'))) {
		1
	} else {
		-1
	}
}

fn wc_product_dropdown_categories(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_wp_query := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'pad_counts', val: 1 },
			rt.ArrayItem{ key: 'show_count', val: 1 }, rt.ArrayItem{ key: 'hierarchical', val: 1 },
			rt.ArrayItem{ key: 'hide_empty', val: 1 }, rt.ArrayItem{
				key: 'show_uncategorized'
				val: 1
			}, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{
				key: 'selected'
				val: if rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('product_cat')) {
					rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('product_cat'))
				} else {
					rt.new_string('')
				}
			}, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
				rt.new_string('Select a category'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'option_none_value', val: '' },
			rt.ArrayItem{ key: 'value_field', val: 'slug' }, rt.ArrayItem{
				key: 'taxonomy'
				val: 'product_cat'
			}, rt.ArrayItem{ key: 'name', val: 'product_cat' },
			rt.ArrayItem{ key: 'class', val: 'dropdown_product_cat' }])])
	if rt.is_true(rt.identical(rt.new_string('order'), var_args.array_get(rt.new_string('orderby')))) {
		var_args.array_set('orderby', 'meta_value_num')
		var_args.array_set('meta_key', 'order')
	}
	rt.call_function('wp_dropdown_categories', [var_args.clone()])
}

fn wc_walk_category_dropdown_tree(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_walker := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Product_Cat_Dropdown_Walker'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/includes/walkers/class-wc-product-cat-dropdown-walker.php', '2')
	}
	if !rt.is_true(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')), rt.new_string('Walker')]))))) {
		var_walker = create_wc_product_cat_dropdown_walker()
	} else {
		var_walker = var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker'))
	}
	return rt.call_method(var_walker, 'walk', [var_args.clone()])
}

fn wc_taxonomy_metadata_migrate_data(var_wp_db_version rt.PhpVal, var_wp_current_db_version rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.greater_equal(var_wp_db_version, rt.new_int(34370)))
		&& rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(34370))) {
		if rt.is_true(rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
				'termmeta')),
				rt.new_string(' ( term_id, meta_key, meta_value ) SELECT woocommerce_term_id, meta_key, meta_value FROM ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_termmeta;')),
		]))
		{
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.new_string('DROP TABLE IF EXISTS '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_termmeta')),
			])
		}
	}
}

fn wc_reorder_terms(var_the_term rt.PhpVal, var_next_id rt.PhpVal, var_taxonomy rt.PhpVal, index i64, var_terms_arg rt.PhpVal) rt.PhpVal {
	mut var_index := index
	mut var_terms := var_terms_arg
	mut var_id := i64(0)
	mut var_term_in_level := false
	mut var_term := rt.new_null()
	mut var_term_id := i64(0)
	mut var_children := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		var_terms = rt.call_function('get_terms', [var_taxonomy.clone(),
			rt.new_string('hide_empty=0&parent=0&menu_order=ASC')])
	}
	if !rt.is_true(var_terms) {
		return rt.new_int(var_index)
	}
	var_id = rt.get_property(var_the_term, 'term_id').to_i64()
	var_term_in_level = false
	mut iter_1 := var_terms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term_shadow := item_1.val
		var_term_id = rt.get_property(var_term_shadow, 'term_id').to_i64()
		if var_term_id == var_id {
			var_term_in_level = true
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_next_id))))
			&& rt.is_true(rt.identical(rt.new_int(var_term_id), var_next_id)) {
			var_index += 1
			var_index = (wc_set_term_order(rt.new_int(var_id).clone(), rt.new_int(var_index),
				var_taxonomy.clone(), true)).to_i64()
		}
		var_index += 1
		var_index = (wc_set_term_order(rt.new_int(var_term_id).clone(), rt.new_int(var_index),
			var_taxonomy.clone(), false)).to_i64()
		rt.call_function('do_action', [rt.new_string('woocommerce_after_set_term_order'),
			var_term_shadow.clone(), rt.new_int(var_index), var_taxonomy.clone()])
		var_children = rt.call_function('get_terms', [var_taxonomy.clone(),
			rt.new_string('parent=${var_term_id.str()}&hide_empty=0&menu_order=ASC')])
		if !(!rt.is_true(var_children)) {
			var_index = (wc_reorder_terms(var_the_term.clone(), var_next_id.clone(),
				var_taxonomy.clone(), var_index, var_children.clone())).to_i64()
		}
	}
	if var_term_in_level && rt.is_true(rt.identical(rt.new_null(), var_next_id)) {
		var_index = (wc_set_term_order(rt.new_int(var_id).clone(), rt.new_int(var_index + 1),
			var_taxonomy.clone(), true)).to_i64()
	}
	return rt.new_int(var_index)
}

fn wc_set_term_order(var_term_id_arg rt.PhpVal, var_index_arg rt.PhpVal, var_taxonomy rt.PhpVal, recursive bool) rt.PhpVal {
	mut var_recursive := recursive
	mut var_term_id := var_term_id_arg
	mut var_index := var_index_arg
	mut var_children := rt.new_null()
	mut var_term := rt.new_null()
	var_term_id = rt.new_int(var_term_id.to_i64())
	var_index = rt.new_int(var_index.to_i64())
	rt.call_function('update_term_meta', [var_term_id.clone(),
		rt.new_string('order'), var_index.clone()])
	if !var_recursive {
		return var_index.clone()
	}
	var_children = rt.call_function('get_terms', [var_taxonomy.clone(),
		rt.new_string('parent=${var_term_id.to_string()}&hide_empty=0&menu_order=ASC')])
	mut iter_2 := var_children.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_shadow := item_2.val
		rt.pre_inc(var_index)
		var_index = wc_set_term_order(rt.get_property(var_term_shadow, 'term_id'),
			var_index.clone(), var_taxonomy.clone(), true)
	}
	rt.call_function('clean_term_cache', [var_term_id.clone(),
		var_taxonomy.clone()])
	return var_index.clone()
}

fn _wc_term_recount(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, callback bool, terms_are_term_taxonomy_ids bool) {
	mut var_callback := callback
	mut var_terms_are_term_taxonomy_ids := terms_are_term_taxonomy_ids
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_term_ids := rt.new_null()
	mut var_term_ids := rt.new_null()
	mut var_exclude_term_ids := []rt.PhpVal{}
	mut var_product_visibility_term_ids := rt.new_null()
	mut var_query := map[string]rt.PhpVal{}
	mut var_term_id := rt.new_null()
	mut var_terms_to_count := rt.new_null()
	mut var_children := rt.new_null()
	mut var_term_query := rt.new_null()
	mut var_count := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_recount_terms'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(terms_are_term_taxonomy_ids))) {
		var_taxonomy_term_ids = var_terms.clone()
		closure_2_fn := fn [var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term_taxonomy_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_term := rt.call_function('get_term_by', [
				rt.new_string('term_taxonomy_id'),
				var_term_taxonomy_id.clone(),
				rt.get_property(var_taxonomy, 'name'),
			])
			return
		}
		closure_3_fn := fn [var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term_taxonomy_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_term := rt.call_function('get_term_by', [
				rt.new_string('term_taxonomy_id'),
				var_term_taxonomy_id.clone(),
				rt.get_property(var_taxonomy, 'name'),
			])
			return
		}
		var_term_ids = rt.call_function('array_map', [rt.new_closure(closure_2_fn),
			var_terms.clone()])
	} else {
		var_taxonomy_term_ids = rt.new_array()
		var_term_ids = rt.func_array_keys(var_terms.clone())
	}
	var_term_ids = rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_term_ids.clone()]),
	])
	var_taxonomy_term_ids = rt.call_function('array_unique', [
		rt.call_function('array_filter', [var_taxonomy_term_ids.clone()]),
	])
	if !rt.is_true(var_term_ids) {
		return
	}
	if var_callback {
		if var_taxonomy_term_ids.clone().array_count() < 1 {
			closure_4_fn := fn [var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_term_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_term := rt.call_function('get_term_by', [
					rt.new_string('term_id'),
					var_term_id.clone(),
					rt.get_property(var_taxonomy, 'name'),
				])
				return
			}
			closure_5_fn := fn [var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_term_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_term := rt.call_function('get_term_by', [
					rt.new_string('term_id'),
					var_term_id.clone(),
					rt.get_property(var_taxonomy, 'name'),
				])
				return
			}
			var_taxonomy_term_ids = rt.call_function('array_map', [
				rt.new_closure(closure_4_fn),
				var_term_ids.clone(),
			])
		}
		rt.call_function('_update_post_term_count', [var_taxonomy_term_ids.clone(),
			var_taxonomy.clone()])
	}
	var_exclude_term_ids = rt.new_array()
	var_product_visibility_term_ids = wc_get_product_visibility_term_ids()
	if rt.is_true(var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))) {
		var_exclude_term_ids << var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')])))
		&& rt.is_true(var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())) {
		var_exclude_term_ids << var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
	}
	var_query = {
		'fields': rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COUNT( DISTINCT ID ) FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' p\n\t\t'))
		'join':   ''
		'where':  "\n\t\t\tWHERE 1=1\n\t\t\tAND p.post_status = 'publish'\n\t\t\tAND p.post_type = 'product'\n\t\t"
	}
	if rt.is_true(rt.new_int(var_exclude_term_ids.len)) {
		rt.new_string((var_query['join']).str()) = rt.concat(rt.new_string((var_query['join']).str()), rt.new_string(
			rt.concat(rt.concat(rt.new_string(' LEFT JOIN ( SELECT object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' WHERE term_taxonomy_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), rt.create_array_from_list(var_exclude_term_ids)])])).str() +
			' ) ) AS exclude_join ON exclude_join.object_id = p.ID'))
		rt.new_string((var_query['where']).str()) = rt.concat(rt.new_string((var_query['where']).str()),
			rt.new_string(' AND exclude_join.object_id IS NULL'))
	}
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		rt.get_property(var_taxonomy, 'name'),
	]))
	{
		mut iter_3 := var_term_ids.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_term_id_shadow := item_3.val
			var_term_ids = rt.call_function('array_merge', [var_term_ids.clone(),
				rt.call_function('get_ancestors', [var_term_id_shadow.clone(),
					rt.get_property(var_taxonomy, 'name')])])
		}
		var_term_ids = rt.call_function('array_unique', [var_term_ids.clone()])
	}
	mut iter_4 := var_term_ids.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term_id_shadow := item_4.val
		var_terms_to_count = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('absint', [
				var_term_id_shadow.clone()]) },
		])
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			rt.get_property(var_taxonomy, 'name'),
		]))
		{
			var_children = rt.call_function('get_term_children', [
				var_term_id_shadow.clone(), rt.get_property(var_taxonomy, 'name')])
			if rt.is_true(var_children)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_children.clone()]))))) {
				var_terms_to_count = rt.call_function('array_unique', [
					rt.call_function('array_map', [rt.new_string('absint'),
						rt.call_function('array_merge', [var_terms_to_count.clone(),
							var_children.clone()])]),
				])
			}
		}
		var_term_query = var_query.clone()
		var_term_query.array_get(rt.new_string('join')) = rt.concat(var_term_query.array_get(rt.new_string('join')), rt.new_string(
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' INNER JOIN ( SELECT object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' INNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' using( term_taxonomy_id ) WHERE term_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_terms_to_count.clone()])])).str() +
			' ) ) AS include_join ON include_join.object_id = p.ID'))
		var_count = rt.call_method(var_wpdb, 'get_var', [
			rt.call_function('implode', [rt.new_string(' '), var_term_query.clone()]),
		])
		rt.call_function('update_term_meta', [var_term_id_shadow.clone(),
			rt.new_string('product_count_' + (rt.get_property(var_taxonomy, 'name')).str()),
			rt.call_function('absint', [var_count.clone()])])
	}
	rt.call_function('delete_transient', [rt.new_string('wc_term_counts')])
}

fn wc_recount_after_stock_change(var_product_id rt.PhpVal) {
	mut var_product_terms := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))))
	{
		return
	}
	if rt.is_true(rt.call_function('wp_defer_term_counting', []rt.PhpVal{})) {
		var_product_terms = rt.call_function('get_the_terms', [
			var_product_id.clone(), rt.new_string('product_cat')])
		if rt.is_true(rt.new_bool(var_product_terms.clone().is_array())) {
			rt.call_function('wp_update_term_count', [
				rt.call_function('array_column', [var_product_terms.clone(),
					rt.new_string('term_taxonomy_id')]),
				rt.new_string('product_cat'),
			])
		}
		var_product_terms = rt.call_function('get_the_terms', [
			var_product_id.clone(), rt.new_string('product_tag')])
		if rt.is_true(rt.new_bool(var_product_terms.clone().is_array())) {
			rt.call_function('wp_update_term_count', [
				rt.call_function('array_column', [var_product_terms.clone(),
					rt.new_string('term_taxonomy_id')]),
				rt.new_string('product_tag'),
			])
		}
	} else {
		_wc_recount_terms_by_product(var_product_id.clone())
	}
}

fn wc_change_term_counts(var_terms rt.PhpVal, var_taxonomies rt.PhpVal) rt.PhpVal {
	mut var_valid_taxonomies := rt.new_null()
	mut var_current_taxonomies := rt.new_null()
	mut var_o_term_counts := rt.new_null()
	mut var_term_counts := rt.new_null()
	mut var_term := rt.new_null()
	mut var_key := rt.new_null()
	mut var_count := rt.new_null()
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		return var_terms.clone()
	}
	var_valid_taxonomies = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_change_term_counts'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' },
			rt.ArrayItem{ key: none, val: 'product_tag' }, rt.ArrayItem{
				key: none
				val: 'product_brand'
			}]),
	])
	var_current_taxonomies = rt.call_function('array_intersect', [
		rt.cast_array(var_taxonomies),
		var_valid_taxonomies.clone(),
	])
	if !rt.is_true(var_current_taxonomies) {
		return var_terms.clone()
	}
	var_o_term_counts = rt.call_function('get_transient', [
		rt.new_string('wc_term_counts'),
	])
	var_term_counts = if rt.is_true(rt.identical(rt.new_bool(false), var_o_term_counts)) {
		rt.new_array()
	} else {
		var_o_term_counts
	}
	mut iter_5 := var_terms.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_term_shadow := item_5.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_term_shadow, 'WP_Term')))
			&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_term_shadow, 'taxonomy'), var_current_taxonomies.clone(), rt.new_bool(true)])) {
			var_key = rt.new_string((rt.get_property(var_term_shadow, 'term_id')).str() + '_' +
				(rt.get_property(var_term_shadow, 'taxonomy')).str())
			if !(var_term_counts.array_isset(var_key)) {
				var_count = rt.call_function('get_term_meta', [
					rt.get_property(var_term_shadow, 'term_id'),
					rt.new_string('product_count_' +
						(rt.get_property(var_term_shadow, 'taxonomy')).str()),
					rt.new_bool(true),
				])
				var_count = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_count)))) { rt.call_function('absint', [
						var_count.clone(),
					]) } else { rt.new_int(0) }
				var_term_counts.array_set(var_key, var_count.clone())
			}
			rt.set_property(var_term_shadow, 'count', var_term_counts.array_get(var_key))
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_term_counts, var_o_term_counts)))) {
		rt.call_function('set_transient', [rt.new_string('wc_term_counts'),
			var_term_counts.clone(), rt.get_constant('MONTH_IN_SECONDS')])
	}
	return var_terms.clone()
}

fn wc_get_term_product_ids(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_product_ids := rt.new_null()
	var_product_ids = rt.call_function('get_term_meta', [var_term_id.clone(),
		rt.new_string('product_ids'), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_product_ids))
		|| !(var_product_ids.clone().is_array()) {
		var_product_ids = rt.call_function('get_objects_in_term', [
			var_term_id.clone(), var_taxonomy.clone()])
		rt.call_function('update_term_meta', [var_term_id.clone(),
			rt.new_string('product_ids'), var_product_ids.clone()])
	}
	return var_product_ids.clone()
}

fn wc_clear_term_product_ids(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal, var_old_tt_ids rt.PhpVal) {
	mut var_term_id := rt.new_null()
	mut iter_6 := var_old_tt_ids.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_term_id_shadow := item_6.val
		rt.call_function('delete_term_meta', [var_term_id_shadow.clone(),
			rt.new_string('product_ids')])
	}
	mut iter_7 := var_tt_ids.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_term_id_shadow := item_7.val
		rt.call_function('delete_term_meta', [var_term_id_shadow.clone(),
			rt.new_string('product_ids')])
	}
}

fn wc_get_product_visibility_term_ids() rt.PhpVal {
	mut var_term_ids_by_blog := rt.new_null()
	mut var_blog_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		rt.new_string('product_visibility'),
	])))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.new_string('wc_get_product_visibility_term_ids should not be called before taxonomies are registered (woocommerce_after_register_post_type action).'),
			rt.new_string('3.1')])
		return rt.new_array()
	}
	var_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	if var_term_ids_by_blog.array_isset(var_blog_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Unit_Tests_Bootstrap')]))))) {
		return var_term_ids_by_blog.array_get(var_blog_id)
	}
	var_term_ids_by_blog.array_set(var_blog_id, rt.call_function('array_map', [
		rt.new_string('absint'),
		rt.call_function('wp_parse_args', [
			rt.call_function('wp_list_pluck', [
				rt.call_function('get_terms', [
					rt.create_array([
						rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
						rt.ArrayItem{ key: 'hide_empty', val: false },
					]),
				]),
				rt.new_string('term_taxonomy_id'),
				rt.new_string('name'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'exclude-from-catalog', val: 0 },
				rt.ArrayItem{ key: 'exclude-from-search', val: 0 },
				rt.ArrayItem{ key: 'featured', val: 0 },
				rt.ArrayItem{ key: 'outofstock', val: 0 },
				rt.ArrayItem{ key: 'rated-1', val: 0 },
				rt.ArrayItem{ key: 'rated-2', val: 0 },
				rt.ArrayItem{ key: 'rated-3', val: 0 },
				rt.ArrayItem{ key: 'rated-4', val: 0 },
				rt.ArrayItem{ key: 'rated-5', val: 0 },
			]),
		]),
	]))
	return var_term_ids_by_blog.array_get(var_blog_id)
}

fn wc_recount_all_terms(include_callback bool) {
	mut var_include_callback := include_callback
	mut var_product_cats := rt.new_null()
	mut var_product_tags := rt.new_null()
	var_product_cats = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
			rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{
				key: 'fields'
				val: 'id=>parent'
			}]),
	])
	_wc_term_recount(var_product_cats.clone(), rt.call_function('get_taxonomy', [
		rt.new_string('product_cat'),
	]), include_callback, false)
	var_product_tags = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_tag' },
			rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{
				key: 'fields'
				val: 'id=>parent'
			}]),
	])
	_wc_term_recount(var_product_tags.clone(), rt.call_function('get_taxonomy', [
		rt.new_string('product_tag'),
	]), include_callback, false)
}

fn _wc_recount_terms_by_product(product_id string) {
	mut var_product_id := product_id
	mut var_product_terms := rt.new_null()
	mut var_product_cats := rt.new_null()
	mut var_term := rt.new_null()
	mut var_product_tags := rt.new_null()
	if product_id == '' {
		return
	}
	var_product_terms = rt.call_function('get_the_terms', [rt.new_string(product_id),
		rt.new_string('product_cat')])
	if rt.is_true(var_product_terms) {
		var_product_cats = rt.new_array()
		mut iter_8 := var_product_terms.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_term_shadow := item_8.val
			var_product_cats.array_set(rt.get_property(var_term_shadow, 'term_id'), rt.get_property(var_term_shadow,
				'parent'))
		}
		_wc_term_recount(var_product_cats.clone(), rt.call_function('get_taxonomy', [
			rt.new_string('product_cat'),
		]), false, false)
	}
	var_product_terms = rt.call_function('get_the_terms', [rt.new_string(product_id),
		rt.new_string('product_tag')])
	if rt.is_true(var_product_terms) {
		var_product_tags = rt.new_array()
		mut iter_9 := var_product_terms.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_term_shadow := item_9.val
			var_product_tags.array_set(rt.get_property(var_term_shadow, 'term_id'), rt.get_property(var_term_shadow,
				'parent'))
		}
		_wc_term_recount(var_product_tags.clone(), rt.call_function('get_taxonomy', [
			rt.new_string('product_tag'),
		]), false, false)
	}
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Product_Cat_Dropdown_Walker {
	rt.PhpObjectBase
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_cat_dropdown_walker(_args ...rt.PhpVal) &Class_WC_Product_Cat_Dropdown_Walker {
	mut obj := &Class_WC_Product_Cat_Dropdown_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Cat_Dropdown_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Cat_Dropdown_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('get_terms_defaults'),
		rt.new_string('wc_change_get_terms_defaults'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('pre_get_terms'),
		rt.new_string('wc_change_pre_get_terms'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('terms_clauses'),
		rt.new_string('wc_terms_clauses'), rt.new_int(99), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_upgrade'),
		rt.new_string('wc_taxonomy_metadata_migrate_data'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_set_stock_status'),
		rt.new_string('wc_recount_after_stock_change'),
	])
	rt.call_function('add_filter', [rt.new_string('get_terms'),
		rt.new_string('wc_change_term_counts'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('set_object_terms'),
		rt.new_string('wc_clear_term_product_ids'), rt.new_int(10),
		rt.new_int(6)])
}
