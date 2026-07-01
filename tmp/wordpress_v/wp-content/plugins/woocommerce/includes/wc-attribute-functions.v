import rt

fn wc_get_text_attributes(var_raw_attributes rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_raw_attributes.dup().is_string()))))) {
		return rt.new_array()
	}
	return rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.get_constant('WC_DELIMITER'), rt.call_function('html_entity_decode', [var_raw_attributes.dup(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])])]), rt.new_string('wc_get_text_attributes_filter_callback')])
}

fn wc_get_text_attributes_filter_callback(var_value rt.PhpVal) rt.PhpVal {
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn wc_implode_text_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [' ' + (rt.get_constant('WC_DELIMITER')).str() + ' ', var_attributes.dup()])
}

fn wc_get_attribute_taxonomies() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_prefix := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('woocommerce-attributes'))
	mut var_cache_key := rt.new_string((var_prefix).str() + 'attributes')
	mut var_cache_value := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_cache_value.dup()
	}
	mut var_raw_attribute_taxonomies := rt.call_function('get_transient', [rt.new_string('wc_attribute_taxonomies')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_raw_attribute_taxonomies)) {
		// unsupported statement: Stmt_Global
		var_raw_attribute_taxonomies = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_name != \'\' ORDER BY attribute_name ASC;'))])
		rt.call_function('set_transient', [rt.new_string('wc_attribute_taxonomies'), var_raw_attribute_taxonomies.dup()])
	}
	var_raw_attribute_taxonomies = rt.cast_array(rt.call_function('array_filter', [rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_taxonomies'), var_raw_attribute_taxonomies.dup()])]))
	mut var_attribute_taxonomies := rt.new_array()
	{
		mut iter_1 := var_raw_attribute_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			var_attribute_taxonomies.array_set('id:' + (rt.get_property(var_result, 'attribute_id')).str(), var_result.dup())
		}
	}
	rt.call_function('wp_cache_set', [var_cache_key.dup(), var_attribute_taxonomies.dup(), rt.new_string('woocommerce-attributes')])
	return var_attribute_taxonomies.dup()
}

fn wc_get_attribute_taxonomy_ids() rt.PhpVal {
	mut var_prefix := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('woocommerce-attributes'))
	mut var_cache_key := rt.new_string((var_prefix).str() + 'ids')
	mut var_cache_value := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_cache_value.dup()
	}
	mut var_taxonomy_ids := rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [wc_get_attribute_taxonomies(), rt.new_string('attribute_id'), rt.new_string('attribute_name')])])
	rt.call_function('wp_cache_set', [var_cache_key.dup(), var_taxonomy_ids.dup(), rt.new_string('woocommerce-attributes')])
	return var_taxonomy_ids.dup()
}

fn wc_get_attribute_taxonomy_labels() rt.PhpVal {
	mut var_prefix := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('woocommerce-attributes'))
	mut var_cache_key := rt.new_string((var_prefix).str() + 'labels')
	mut var_cache_value := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_cache_value.dup()
	}
	mut var_taxonomy_labels := rt.call_function('wp_list_pluck', [wc_get_attribute_taxonomies(), rt.new_string('attribute_label'), rt.new_string('attribute_name')])
	rt.call_function('wp_cache_set', [var_cache_key.dup(), var_taxonomy_labels.dup(), rt.new_string('woocommerce-attributes')])
	return var_taxonomy_labels.dup()
}

fn wc_attribute_taxonomy_name(var_attribute_name rt.PhpVal) string {
	return if rt.is_true(var_attribute_name) { 'pa_' + (rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_name.dup()])).str() } else { '' }
}

fn wc_variation_attribute_name(var_attribute_name rt.PhpVal) string {
	return 'attribute_' + (rt.call_function('sanitize_title', [var_attribute_name.dup()])).str()
}

fn wc_attribute_taxonomy_name_by_id(var_attribute_id rt.PhpVal) string {
	mut var_taxonomy_ids := wc_get_attribute_taxonomy_ids()
	mut var_attribute_name := // unsupported expression: Expr_Cast_String
	return wc_attribute_taxonomy_name(var_attribute_name.dup())
}

fn wc_attribute_taxonomy_id_by_name(var_name rt.PhpVal) rt.PhpVal {
	var_name = wc_attribute_taxonomy_slug(var_name.dup())
	mut var_taxonomy_ids := wc_get_attribute_taxonomy_ids()
	return if var_taxonomy_ids.array_isset(var_name) { var_taxonomy_ids.array_get(var_name) } else { rt.new_int(0) }
}

fn wc_attribute_label(var_name rt.PhpVal, product string) rt.PhpVal {
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [var_name.dup()])) {
		mut var_slug := wc_attribute_taxonomy_slug(var_name.dup())
		mut var_all_labels := wc_get_attribute_taxonomy_labels()
		mut var_label := if var_all_labels.array_isset(var_slug) { var_all_labels.array_get(var_slug) } else { var_slug }
	} else if var_product.len > 0 && var_product != '0' {
		if rt.is_true(rt.call_method(rt.new_string(product), 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			product = (rt.call_function('wc_get_product', [rt.call_method(rt.new_string(product), 'get_parent_id', []rt.PhpVal{})])).str()
		}
		mut var_attributes := rt.new_array()
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_attributes = rt.call_method(rt.new_string(product), 'get_attributes', []rt.PhpVal{})
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_attributes) && var_attributes.array_isset(rt.call_function('sanitize_title', [var_name.dup()])))) {
			var_label = rt.call_method(var_attributes.array_get(rt.call_function('sanitize_title', [var_name.dup()])), 'get_name', []rt.PhpVal{})
		} else {
			var_label = var_name.dup()
		}
	} else {
		var_label = var_name.dup()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_label'), var_label.dup(), var_name.dup(), rt.new_string(product)])
}

fn wc_attribute_orderby(var_name rt.PhpVal) rt.PhpVal {
	var_name = wc_attribute_taxonomy_slug(var_name.dup())
	mut var_id := wc_attribute_taxonomy_id_by_name(var_name.dup())
	mut var_taxonomies := wc_get_attribute_taxonomies()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_orderby'), if var_taxonomies.array_isset('id:' + (var_id).str()) { rt.get_property(var_taxonomies.array_get('id:' + (var_id).str()), 'attribute_orderby') } else { rt.new_string('menu_order') }, var_name.dup()])
}

fn wc_get_attribute_taxonomy_names() rt.PhpVal {
	mut var_taxonomy_names := rt.new_array()
	mut var_attribute_taxonomies := wc_get_attribute_taxonomies()
	if !(!rt.is_true(var_attribute_taxonomies)) {
		{
			mut iter_1 := var_attribute_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				var_taxonomy_names << wc_attribute_taxonomy_name(rt.get_property(var_tax, 'attribute_name'))
			}
		}
	}
	return var_taxonomy_names.dup()
}

fn wc_get_attribute_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('product_attributes_type_selector'), rt.create_array([rt.ArrayItem{ key: 'select', val: rt.call_function('__', [rt.new_string('Select'), rt.new_string('woocommerce')]) }])]))
}

fn wc_has_custom_attribute_types() bool {
	mut var_types := wc_get_attribute_types()
	return 1 < var_types.dup().array_count() || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_types.dup().array_isset(rt.new_string('select')))))))
}

fn wc_get_attribute_type_label(var_type rt.PhpVal) rt.PhpVal {
	mut var_types := wc_get_attribute_types()
	return if var_types.array_isset(var_type) { var_types.array_get(var_type) } else { rt.call_function('__', [rt.new_string('Select'), rt.new_string('woocommerce')]) }
}

fn wc_check_if_attribute_name_is_reserved(var_attribute_name rt.PhpVal) rt.PhpVal {
	mut var_reserved_terms := ['attachment', 'attachment_id', 'author', 'author_name', 'calendar', 'cat', 'category', 'category__and', 'category__in', 'category__not_in', 'category_name', 'comments_per_page', 'comments_popup', 'cpage', 'day', 'debug', 'error', 'exact', 'feed', 'hour', 'link_category', 'm', 'minute', 'monthnum', 'more', 'name', 'nav_menu', 'nopaging', 'offset', 'order', 'orderby', 'p', 'page', 'page_id', 'paged', 'pagename', 'pb', 'perm', 'post', 'post__in', 'post__not_in', 'post_format', 'post_mime_type', 'post_status', 'post_tag', 'post_type', 'posts', 'posts_per_archive_page', 'posts_per_page', 'preview', 'robots', 's', 'search', 'second', 'sentence', 'showposts', 'static', 'subpost', 'subpost_id', 'tag', 'tag__and', 'tag__in', 'tag__not_in', 'tag_id', 'tag_slug__and', 'tag_slug__in', 'taxonomy', 'tb', 'term', 'type', 'w', 'withcomments', 'withoutcomments', 'year']
	return rt.call_function('in_array', [var_attribute_name.dup(), var_reserved_terms.dup(), rt.new_bool(true)])
}

fn wc_attributes_array_filter_visible(var_attribute rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_attribute) && rt.is_true(rt.call_function('is_a', [var_attribute.dup(), rt.new_string('WC_Product_Attribute')])))) && rt.is_true(rt.call_method(var_attribute, 'get_visible', []rt.PhpVal{})))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('taxonomy_exists', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})]))))
}

fn wc_attributes_array_filter_variation(var_attribute rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(rt.is_true(var_attribute) && rt.is_true(rt.call_function('is_a', [var_attribute.dup(), rt.new_string('WC_Product_Attribute')])))) && rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}))
}

fn wc_is_attribute_in_product_name(var_attribute rt.PhpVal, var_name rt.PhpVal) rt.PhpVal {
	mut var_is_in_name := rt.is_true(rt.call_function('stristr', [var_name.dup(), ' ' + (var_attribute).str() + ','])) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.call_function('strrev', [var_name.dup()]), rt.call_function('strrev', [' ' + (var_attribute).str()])])))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_attribute_in_product_name'), rt.new_bool(var_is_in_name).dup(), var_attribute.dup(), var_name.dup()])
}

fn wc_array_filter_default_attributes(var_attribute rt.PhpVal) bool {
	return rt.is_true(rt.call_function('is_scalar', [var_attribute.dup()])) && rt.is_true(rt.new_bool(!(!rt.is_true(var_attribute)) || rt.is_true(rt.identical(rt.new_string('0'), var_attribute))))
}

fn wc_get_attribute(var_id rt.PhpVal) rt.PhpVal {
	mut var_attributes := wc_get_attribute_taxonomies()
	if !(var_attributes.array_isset('id:' + (var_id).str())) {
		return rt.new_null()
	}
	mut var_data := .array_get()
	mut var_attribute := 
	
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_attribute_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
