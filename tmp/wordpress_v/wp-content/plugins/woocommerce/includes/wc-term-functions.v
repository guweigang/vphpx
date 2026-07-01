import rt
import crypto.md5

fn wc_change_get_terms_defaults(var_defaults rt.PhpVal, var_taxonomies rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_taxonomies.dup().is_array())) && 1 < var_taxonomies.dup().array_count())) {
		return var_defaults.dup()
	}
	mut var_taxonomy := if rt.is_true(rt.new_bool(var_taxonomies.dup().is_array())) { // unsupported expression: Expr_Cast_String } else { var_taxonomies }
	mut var_orderby := rt.new_string(rt.new_string('name'))
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [var_taxonomy.dup()])) {
		var_orderby = rt.call_function('wc_attribute_orderby', [var_taxonomy.dup()])
	} else if rt.is_true(rt.call_function('in_array', [var_taxonomy.dup(), rt.call_function('apply_filters', [rt.new_string('woocommerce_sortable_taxonomies'), rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }])]), rt.new_bool(true)])) {
		var_orderby = rt.new_string(rt.new_string('menu_order'))
	}
	mut switch_val_1 := var_orderby
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('menu_order'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('name_num'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		var_defaults.array_set('orderby', var_orderby.dup())
	}
	return var_defaults.dup()
}

fn wc_change_pre_get_terms(var_terms_query rt.PhpVal) {
	mut var_args := rt.new_null()
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.identical(rt.new_string('menu_order'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'name')
		var_args.array_set('force_menu_order_sort', true)
	}
	if rt.is_true(rt.identical(rt.new_string('name_num'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'name')
		var_args.array_set('force_numeric_name', true)
	}
	if rt.is_true(rt.identical(rt.new_string('count'), var_args.array_get('fields'))) {
		return rt.new_null()
	}
	if !(!rt.is_true(var_args.array_get('menu_order'))) {
		var_args.array_set('order', if rt.is_true(rt.identical(rt.new_string('DESC'), rt.new_string(var_args.array_get('menu_order').to_string().to_upper()))) { 'DESC' } else { 'ASC' })
		var_args.array_set('force_menu_order_sort', true)
	}
	if !(!rt.is_true(var_args.array_get('force_menu_order_sort'))) {
		var_args.array_set('orderby', 'meta_value_num')
		var_args.array_set('meta_key', 'order')
		rt.call_method(rt.get_property(var_terms_query, 'meta_query'), 'parse_query_vars', [var_args.dup()])
	}
}

fn wc_terms_clauses(var_clauses rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_clauses.dup()
	}
	if !(!rt.is_true(var_args.array_get('force_numeric_name'))) {
		var_clauses['orderby'] = rt.call_function('str_replace', [rt.new_string('ORDER BY t.name'), rt.new_string('ORDER BY t.name+0'), var_clauses.array_get('orderby')])
	}
	if !(!rt.is_true(var_args.array_get('force_menu_order_sort'))) {
		var_clauses['join'] = rt.call_function('str_replace', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' ON ( t.term_id = ')), rt.get_property(var_wpdb, 'termmeta')), rt.new_string('.term_id )')), rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('LEFT JOIN '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' ON ( t.term_id = ')), rt.get_property(var_wpdb, 'termmeta')), rt.new_string('.term_id AND ')), rt.get_property(var_wpdb, 'termmeta')), rt.new_string('.meta_key=\'order\')')), var_clauses.array_get('join')])
		var_clauses['where'] = rt.call_function('str_replace', [rt.concat(rt.get_property(var_wpdb, 'termmeta'), rt.new_string('.meta_key = \'order\'')), rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('( '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string('.meta_key = \'order\' OR ')), rt.get_property(var_wpdb, 'termmeta')), rt.new_string('.meta_key IS NULL )')), var_clauses.array_get('where')])
		var_clauses['orderby'] = if rt.is_true(rt.identical(rt.new_string('DESC'), var_args.array_get('order'))) { rt.call_function('str_replace', [rt.new_string('meta_value+0'), rt.new_string('meta_value+0 DESC, t.name'), var_clauses.array_get('orderby')]) } else { rt.call_function('str_replace', [rt.new_string('meta_value+0'), rt.new_string('meta_value+0 ASC, t.name'), var_clauses.array_get('orderby')]) }
	}
	return var_clauses.dup()
}

fn wc_get_object_terms(var_object_id rt.PhpVal, var_taxonomy rt.PhpVal, var_field rt.PhpVal, var_index_key rt.PhpVal) rt.PhpVal {
	mut var_terms := rt.call_function('get_the_terms', [var_object_id.dup(), var_taxonomy.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) || rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])))) {
		return rt.new_array()
	}
	return if rt.is_true(rt.new_bool(var_field.dup().is_null())) { var_terms } else { rt.call_function('wp_list_pluck', [var_terms.dup(), var_field.dup(), var_index_key.dup()]) }
}

fn _wc_get_cached_product_terms(var_product_id rt.PhpVal, var_taxonomy rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_cache_key := rt.new_string('wc_' + (var_taxonomy).str() + md5.hexhash(rt.call_function('wp_json_encode', [var_args.dup()]).to_string()))
	mut var_cache_group := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('product_' + (var_product_id).str())), var_product_id))
	mut var_terms := rt.call_function('wp_cache_get', [var_cache_key.dup(), var_cache_group.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_terms.dup()
	}
	var_terms = rt.call_function('wp_get_post_terms', [var_product_id.dup(), var_taxonomy.dup(), var_args.dup()])
	rt.call_function('wp_cache_add', [var_cache_key.dup(), var_terms.dup(), var_cache_group.dup()])
	return var_terms.dup()
}

fn wc_get_product_terms(var_product_id rt.PhpVal, var_taxonomy rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()]))))) {
		return rt.new_array()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_product_terms'), _wc_get_cached_product_terms(var_product_id.dup(), var_taxonomy.dup(), var_args.dup()), var_product_id.dup(), var_taxonomy.dup(), var_args.dup()])
}

fn _wc_get_product_terms_name_num_usort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_name := // unsupported expression: Expr_Cast_Double
	mut var_b_name := // unsupported expression: Expr_Cast_Double
	if rt.is_true(rt.less(rt.call_function('abs', [rt.sub(var_a_name, var_b_name)]), rt.new_float(0.001))) {
		return 0
	}
	return (if rt.is_true(rt.less(var_a_name, var_b_name)) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }).to_i64()
}

fn _wc_get_product_terms_parent_usort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.get_property(var_a, 'parent'), rt.get_property(var_b, 'parent'))) {
		return 0
	}
	return (if rt.is_true(rt.less(rt.get_property(var_a, 'parent'), rt.get_property(var_b, 'parent'))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
}

fn wc_product_dropdown_categories(var_args rt.PhpVal) {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'pad_counts', val: 1 }, rt.ArrayItem{ key: 'show_count', val: 1 }, rt.ArrayItem{ key: 'hierarchical', val: 1 }, rt.ArrayItem{ key: 'hide_empty', val: 1 }, rt.ArrayItem{ key: 'show_uncategorized', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'selected', val: if rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('product_cat')) { rt.get_property(var_wp_query, 'query_vars').array_get('product_cat') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [rt.new_string('Select a category'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'option_none_value', val: '' }, rt.ArrayItem{ key: 'value_field', val: 'slug' }, rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' }, rt.ArrayItem{ key: 'name', val: 'product_cat' }, rt.ArrayItem{ key: 'class', val: 'dropdown_product_cat' }])])
	if rt.is_true(rt.identical(rt.new_string('order'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'meta_value_num')
		var_args.array_set('meta_key', 'order')
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('wp_dropdown_categories', [var_args.dup()])
}

fn wc_walk_category_dropdown_tree(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_Cat_Dropdown_Walker'), rt.new_bool(false)]))))) {
		rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/walkers/class-wc-product-cat-dropdown-walker.php', '2')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args.array_get(2).array_get('walker')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_args.array_get(2).array_get('walker'), rt.new_string('Walker')]))))))) {
		mut var_walker := create_wc_product_cat_dropdown_walker()
	} else {
		var_walker = var_args.array_get(2).array_get('walker')
	}
	return rt.call_method(var_walker, 'walk', [var_args.dup()])
}

fn wc_taxonomy_metadata_migrate_data(var_wp_db_version rt.PhpVal, var_wp_current_db_version rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_wp_db_version, rt.new_int(34370))) && rt.is_true(rt.less(var_wp_current_db_version, rt.new_int(34370))))) {
		// unsupported statement: Stmt_Global
		if rt.is_true(rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' ( term_id, meta_key, meta_value ) SELECT woocommerce_term_id, meta_key, meta_value FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_termmeta;'))])) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DROP TABLE IF EXISTS '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_termmeta'))])
		}
	}
}

fn wc_reorder_terms(var_the_term rt.PhpVal, var_next_id rt.PhpVal, var_taxonomy rt.PhpVal, index i64, var_terms rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		var_terms = rt.call_function('get_terms', [var_taxonomy.dup(), rt.new_string('hide_empty=0&parent=0&menu_order=ASC')])
	}
	if !rt.is_true(var_terms) {
		return rt.new_int(index)
	}
	mut var_id := rt.get_property(var_the_term, 'term_id').to_i64()
	mut var_term_in_level := false
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_term_id := rt.get_property(var_term, 'term_id').to_i64()
			if var_term_id == var_id {
				var_term_in_level = true
				continue
				// unsupported statement: Stmt_Nop
			}
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_int(var_term_id), var_next_id)))) {
				var_index += 1
				index = (wc_set_term_order(rt.new_int(var_id).dup(), rt.new_int(index), var_taxonomy.dup(), true)).to_i64()
			}
			var_index += 1
			index = (wc_set_term_order(rt.new_int(var_term_id).dup(), rt.new_int(index), var_taxonomy.dup(), false)).to_i64()
			rt.call_function('do_action', [rt.new_string('woocommerce_after_set_term_order'), var_term.dup(), rt.new_int(index), var_taxonomy.dup()])
			mut var_children := rt.call_function('get_terms', [var_taxonomy.dup(), rt.new_string("parent=${var_term_id.str()}&hide_empty=0&menu_order=ASC")])
			if !(!rt.is_true(var_children)) {
				index = (wc_reorder_terms(var_the_term.dup(), var_next_id.dup(), var_taxonomy.dup(), index, var_children.dup())).to_i64()
			}
		}
	}
	if rt.is_true(rt.new_bool(var_term_in_level && rt.is_true(rt.identical(rt.new_null(), var_next_id)))) {
		index = (wc_set_term_order(rt.new_int(var_id).dup(), index + 1, var_taxonomy.dup(), true)).to_i64()
	}
	return rt.new_int(index)
}

fn wc_set_term_order(var_term_id rt.PhpVal, var_index rt.PhpVal, var_taxonomy rt.PhpVal, recursive bool) rt.PhpVal {
	var_term_id = // unsupported expression: Expr_Cast_Int
	var_index = // unsupported expression: Expr_Cast_Int
	rt.call_function('update_term_meta', [var_term_id.dup(), rt.new_string('order'), var_index.dup()])
	if !(var_recursive) {
		return var_index.dup()
	}
	mut var_children := rt.call_function('get_terms', [.dup(), ])
	{
		mut iter_1 := var_children.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			
		}
	}
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Product_Cat_Dropdown_Walker {
	rt.PhpObjectBase
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_cat_dropdown_walker() &Class_WC_Product_Cat_Dropdown_Walker {
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_term_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_filter', [rt.new_string('get_terms_defaults'), rt.new_string('wc_change_get_terms_defaults'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('pre_get_terms'), rt.new_string('wc_change_pre_get_terms'), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('terms_clauses'), rt.new_string('wc_terms_clauses'), rt.new_int(99), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_upgrade'), rt.new_string('wc_taxonomy_metadata_migrate_data'), rt.new_int(10), rt.new_int(2)])
}
