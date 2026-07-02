import rt

fn wc_get_text_attributes(var_raw_attributes rt.PhpVal) rt.PhpVal {
	if !(var_raw_attributes.clone().is_string()) {
		return rt.new_array()
	}
	return rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.get_constant('WC_DELIMITER'), rt.call_function('html_entity_decode', [var_raw_attributes.clone(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])])]), rt.new_string('wc_get_text_attributes_filter_callback')])
}

fn wc_get_text_attributes_filter_callback(var_value rt.PhpVal) bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))
}

fn wc_implode_text_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string(' ' + (rt.get_constant('WC_DELIMITER')).str() + ' '), var_attributes.clone()])
}

fn wc_get_attribute_taxonomies() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_cache_value := rt.new_null()
	mut var_raw_attribute_taxonomies := rt.new_null()
	mut var_attribute_taxonomies := rt.new_null()
	mut var_result := rt.new_null()
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_cache_prefix(rt.new_string('woocommerce-attributes'))
	var_prefix = iife_result_0
	var_cache_key = rt.new_string((var_prefix).str() + 'attributes')
	var_cache_value = rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)))) {
		return var_cache_value.clone()
	}
	var_raw_attribute_taxonomies = rt.call_function('get_transient', [rt.new_string('wc_attribute_taxonomies')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_raw_attribute_taxonomies)) {
		var_raw_attribute_taxonomies = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_name != \'\' ORDER BY attribute_name ASC;'))])
		rt.call_function('set_transient', [rt.new_string('wc_attribute_taxonomies'), var_raw_attribute_taxonomies.clone()])
	}
	var_raw_attribute_taxonomies = rt.cast_array(rt.call_function('array_filter', [rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_taxonomies'), var_raw_attribute_taxonomies.clone()])]))
	var_attribute_taxonomies = rt.new_array()
	mut iter_1 := var_raw_attribute_taxonomies.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result_shadow := item_1.val
		var_attribute_taxonomies.array_set('id:' + (rt.get_property(var_result_shadow, 'attribute_id')).str(), var_result_shadow.clone())
	}
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_attribute_taxonomies.clone(), rt.new_string('woocommerce-attributes')])
	return var_attribute_taxonomies.clone()
}

fn wc_get_attribute_taxonomy_ids() rt.PhpVal {
	mut var_prefix := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_cache_value := rt.new_null()
	mut var_taxonomy_ids := rt.new_null()
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_cache_prefix(rt.new_string('woocommerce-attributes'))
	var_prefix = iife_result_1
	var_cache_key = rt.new_string((var_prefix).str() + 'ids')
	var_cache_value = rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)))) {
		return var_cache_value.clone()
	}
	var_taxonomy_ids = rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('wp_list_pluck', [wc_get_attribute_taxonomies(), rt.new_string('attribute_id'), rt.new_string('attribute_name')])])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_taxonomy_ids.clone(), rt.new_string('woocommerce-attributes')])
	return var_taxonomy_ids.clone()
}

fn wc_get_attribute_taxonomy_labels() rt.PhpVal {
	mut var_prefix := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_cache_value := rt.new_null()
	mut var_taxonomy_labels := rt.new_null()
	mut iife_temp_2 := Class_WC_Cache_Helper{}
	mut iife_result_2 := iife_temp_2.get_cache_prefix(rt.new_string('woocommerce-attributes'))
	var_prefix = iife_result_2
	var_cache_key = rt.new_string((var_prefix).str() + 'labels')
	var_cache_value = rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)))) {
		return var_cache_value.clone()
	}
	var_taxonomy_labels = rt.call_function('wp_list_pluck', [wc_get_attribute_taxonomies(), rt.new_string('attribute_label'), rt.new_string('attribute_name')])
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_taxonomy_labels.clone(), rt.new_string('woocommerce-attributes')])
	return var_taxonomy_labels.clone()
}

fn wc_attribute_taxonomy_name(var_attribute_name rt.PhpVal) string {
	return if rt.is_true(var_attribute_name) { 'pa_' + (rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_name.clone()])).str() } else { '' }
}

fn wc_variation_attribute_name(var_attribute_name rt.PhpVal) string {
	return 'attribute_' + (rt.call_function('sanitize_title', [var_attribute_name.clone()])).str()
}

fn wc_attribute_taxonomy_name_by_id(var_attribute_id rt.PhpVal) string {
	mut var_taxonomy_ids := rt.new_null()
	mut var_attribute_name := rt.new_null()
	var_taxonomy_ids = wc_get_attribute_taxonomy_ids()
	var_attribute_name = rt.new_string((rt.call_function('array_search', [var_attribute_id.clone(), var_taxonomy_ids.clone(), rt.new_bool(true)])).str())
	return wc_attribute_taxonomy_name(var_attribute_name.clone())
}

fn wc_attribute_taxonomy_id_by_name(var_name_arg rt.PhpVal) rt.PhpVal {
	mut var_name := var_name_arg
	mut var_taxonomy_ids := rt.new_null()
	var_name = wc_attribute_taxonomy_slug(var_name.clone())
	var_taxonomy_ids = wc_get_attribute_taxonomy_ids()
	return if var_taxonomy_ids.array_isset(var_name) { var_taxonomy_ids.array_get(var_name) } else { rt.new_int(0) }
}

fn wc_attribute_label(var_name rt.PhpVal, product string) rt.PhpVal {
	mut var_product := product
	mut var_slug := rt.new_null()
	mut var_all_labels := rt.new_null()
	mut var_label := rt.new_null()
	mut var_attributes := rt.new_null()
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [var_name.clone()])) {
	var_slug = wc_attribute_taxonomy_slug(var_name.clone())
	var_all_labels = wc_get_attribute_taxonomy_labels()
	var_label = if var_all_labels.array_isset(var_slug) { var_all_labels.array_get(var_slug) } else { var_slug }
	} else if var_product.len > 0 && var_product != '0' {
		if rt.is_true(rt.call_method(rt.new_string((var_product).str()), 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		var_product = (rt.call_function('wc_get_product', [rt.call_method(rt.new_string((var_product).str()), 'get_parent_id', []rt.PhpVal{})])).str()
		}
		var_attributes = rt.new_array()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_string((var_product).str()))))) {
		var_attributes = rt.call_method(rt.new_string((var_product).str()), 'get_attributes', []rt.PhpVal{})
		}
		if rt.is_true(var_attributes) && var_attributes.array_isset(rt.call_function('sanitize_title', [var_name.clone()])) {
		var_label = rt.call_method(var_attributes.array_get(rt.call_function('sanitize_title', [var_name.clone()])), 'get_name', []rt.PhpVal{})
		} else {
		var_label = var_name.clone()
		}
	} else {
	var_label = var_name.clone()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_label'), var_label.clone(), var_name.clone(), rt.new_string((var_product).str())])
}

fn wc_attribute_orderby(var_name_arg rt.PhpVal) rt.PhpVal {
	mut var_name := var_name_arg
	mut var_id := rt.new_null()
	mut var_taxonomies := rt.new_null()
	var_name = wc_attribute_taxonomy_slug(var_name.clone())
	var_id = wc_attribute_taxonomy_id_by_name(var_name.clone())
	var_taxonomies = wc_get_attribute_taxonomies()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_orderby'), if var_taxonomies.array_isset('id:' + (var_id).str()) { rt.get_property(var_taxonomies.array_get(rt.new_string('id:' + (var_id).str())), 'attribute_orderby') } else { rt.new_string('menu_order') }, var_name.clone()])
}

fn wc_get_attribute_taxonomy_names() rt.PhpVal {
	mut var_taxonomy_names := []rt.PhpVal{}
	mut var_attribute_taxonomies := rt.new_null()
	mut var_tax := rt.new_null()
	var_taxonomy_names = rt.new_array()
	var_attribute_taxonomies = wc_get_attribute_taxonomies()
	if !(!rt.is_true(var_attribute_taxonomies)) {
		mut iter_2 := var_attribute_taxonomies.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax_shadow := item_2.val
			var_taxonomy_names << wc_attribute_taxonomy_name(rt.get_property(var_tax_shadow, 'attribute_name'))
		}
	}
	return var_taxonomy_names.clone()
}

fn wc_get_attribute_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('product_attributes_type_selector'), rt.create_array([rt.ArrayItem{ key: 'select', val: rt.call_function('__', [rt.new_string('Select'), rt.new_string('woocommerce')]) }])]))
}

fn wc_has_custom_attribute_types() bool {
	mut var_types := rt.new_null()
	var_types = wc_get_attribute_types()
	return 1 < var_types.clone().array_count() || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_types.clone().array_isset(rt.new_string('select')))))))
}

fn wc_get_attribute_type_label(var_type rt.PhpVal) rt.PhpVal {
	mut var_types := rt.new_null()
	var_types = wc_get_attribute_types()
	return if var_types.array_isset(var_type) { var_types.array_get(var_type) } else { rt.call_function('__', [rt.new_string('Select'), rt.new_string('woocommerce')]) }
}

fn wc_check_if_attribute_name_is_reserved(var_attribute_name rt.PhpVal) rt.PhpVal {
	mut var_reserved_terms := []rt.PhpVal{}
	var_reserved_terms = ['attachment', 'attachment_id', 'author', 'author_name', 'calendar', 'cat', 'category', 'category__and', 'category__in', 'category__not_in', 'category_name', 'comments_per_page', 'comments_popup', 'cpage', 'day', 'debug', 'error', 'exact', 'feed', 'hour', 'link_category', 'm', 'minute', 'monthnum', 'more', 'name', 'nav_menu', 'nopaging', 'offset', 'order', 'orderby', 'p', 'page', 'page_id', 'paged', 'pagename', 'pb', 'perm', 'post', 'post__in', 'post__not_in', 'post_format', 'post_mime_type', 'post_status', 'post_tag', 'post_type', 'posts', 'posts_per_archive_page', 'posts_per_page', 'preview', 'robots', 's', 'search', 'second', 'sentence', 'showposts', 'static', 'subpost', 'subpost_id', 'tag', 'tag__and', 'tag__in', 'tag__not_in', 'tag_id', 'tag_slug__and', 'tag_slug__in', 'taxonomy', 'tb', 'term', 'type', 'w', 'withcomments', 'withoutcomments', 'year']
	return rt.call_function('in_array', [var_attribute_name.clone(), rt.create_array_from_list(var_reserved_terms), rt.new_bool(true)])
}

fn wc_attributes_array_filter_visible(var_attribute rt.PhpVal) bool {
	return rt.is_true(var_attribute) && rt.is_true(rt.call_function('is_a', [var_attribute.clone(), rt.new_string('WC_Product_Attribute')])) && rt.is_true(rt.call_method(var_attribute, 'get_visible', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('taxonomy_exists', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})]))
}

fn wc_attributes_array_filter_variation(var_attribute rt.PhpVal) bool {
	return rt.is_true(var_attribute) && rt.is_true(rt.call_function('is_a', [var_attribute.clone(), rt.new_string('WC_Product_Attribute')])) && rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}))
}

fn wc_is_attribute_in_product_name(var_attribute rt.PhpVal, var_name rt.PhpVal) rt.PhpVal {
	mut var_is_in_name := false
	var_is_in_name = rt.is_true(rt.call_function('stristr', [var_name.clone(), rt.new_string(' ' + (var_attribute).str() + ',')])) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.call_function('strrev', [var_name.clone()]), rt.call_function('strrev', [rt.new_string(' ' + (var_attribute).str())])])))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_attribute_in_product_name'), rt.new_bool(var_is_in_name).clone(), var_attribute.clone(), var_name.clone()])
}

fn wc_array_filter_default_attributes(var_attribute rt.PhpVal) bool {
	return rt.is_true(rt.call_function('is_scalar', [var_attribute.clone()])) && !(!rt.is_true(var_attribute)) || rt.is_true(rt.identical(rt.new_string('0'), var_attribute))
}

fn wc_get_attribute(var_id rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_null()
	mut var_data := rt.new_null()
	mut var_attribute := rt.new_null()
	var_attributes = wc_get_attribute_taxonomies()
	if !(var_attributes.array_isset('id:' + (var_id).str())) {
		return rt.new_null()
	}
	var_data = var_attributes.array_get(rt.new_string('id:' + (var_id).str()))
	var_attribute = create_stdclass()
	rt.set_property(var_attribute, 'id', rt.new_int((rt.get_property(var_data, 'attribute_id')).to_i64()))
	rt.set_property(var_attribute, 'name', rt.get_property(var_data, 'attribute_label'))
	rt.set_property(var_attribute, 'slug', rt.new_string(wc_attribute_taxonomy_name(rt.get_property(var_data, 'attribute_name'))))
	rt.set_property(var_attribute, 'type', rt.get_property(var_data, 'attribute_type'))
	rt.set_property(var_attribute, 'order_by', rt.get_property(var_data, 'attribute_orderby'))
	rt.set_property(var_attribute, 'has_archives', (rt.get_property(var_data, 'attribute_public')).to_bool())
	return var_attribute.clone()
}

fn wc_create_attribute(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_wc_product_attributes := rt.new_null()
	mut var_wp_taxonomies := rt.new_null()
	mut var_id := rt.new_null()
	mut var_format := []rt.PhpVal{}
	mut var_slug := rt.new_null()
	mut var_data := rt.new_null()
	mut var_results := rt.new_null()
	mut var_old_slug := rt.new_null()
	mut var_old_taxonomy_name := rt.new_null()
	mut var_new_taxonomy_name := rt.new_null()
	mut var_old_attribute_key := rt.new_null()
	mut var_new_attribute_key := rt.new_null()
	mut var_metadatas := rt.new_null()
	mut var_metadata := map[string]rt.PhpVal{}
	mut var_product_id := rt.new_null()
	mut var_unserialized_data := rt.new_null()
	var_args = rt.call_function('wp_unslash', [var_args.clone()])
	var_id = rt.new_int(if !(!rt.is_true(var_args.array_get(rt.new_string('id')))) { var_args.array_get(rt.new_string('id')).to_i64() } else { 0 })
	var_format = ['%s', '%s', '%s', '%s', '%d']
	if !rt.is_true(var_args.array_get(rt.new_string('name'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('missing_attribute_name'), rt.call_function('__', [rt.new_string('Please, provide an attribute name.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !rt.is_true(var_args.array_get(rt.new_string('slug'))) {
	var_slug = rt.call_function('wc_sanitize_taxonomy_name', [var_args.array_get(rt.new_string('name'))])
	} else {
	var_slug = rt.call_function('preg_replace', [rt.new_string('/^pa\\_/'), rt.new_string(''), rt.call_function('wc_sanitize_taxonomy_name', [var_args.array_get(rt.new_string('slug'))])])
	}
	if var_slug.clone().to_string().len > 28 {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_product_attribute_slug_too_long'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Slug "%s" is too long (28 characters max). Shorten it, please.'), rt.new_string('woocommerce')]), var_slug.clone()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	} else if rt.is_true(wc_check_if_attribute_name_is_reserved(var_slug.clone())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_product_attribute_slug_reserved_name'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Slug "%s" is not allowed because it is a reserved term. Change it, please.'), rt.new_string('woocommerce')]), var_slug.clone()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	} else if (rt.is_true(rt.identical(rt.new_int(0), var_id)) && rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string(wc_attribute_taxonomy_name(var_slug.clone()))]))) || (var_args.array_isset(rt.new_string('old_slug')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_args.array_get(rt.new_string('old_slug')), var_slug)))) && rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string(wc_attribute_taxonomy_name(var_slug.clone()))]))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_product_attribute_slug_already_exists'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Slug "%s" is already in use. Change it, please.'), rt.new_string('woocommerce')]), var_slug.clone()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !rt.is_true(var_args.array_get(rt.new_string('type'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(wc_get_attribute_types().array_isset(var_args.array_get(rt.new_string('type')))))))) {
		var_args.array_set('type', 'select')
	}
	if !rt.is_true(var_args.array_get(rt.new_string('order_by'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('order_by')), rt.create_array([rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'name_num' }, rt.ArrayItem{ key: none, val: 'id' }]), rt.new_bool(true)]))))) {
		var_args.array_set('order_by', 'menu_order')
	}
	var_data = rt.create_array([rt.ArrayItem{ key: 'attribute_label', val: var_args.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'attribute_name', val: var_slug }, rt.ArrayItem{ key: 'attribute_type', val: var_args.array_get(rt.new_string('type')) }, rt.ArrayItem{ key: 'attribute_orderby', val: var_args.array_get(rt.new_string('order_by')) }, rt.ArrayItem{ key: 'attribute_public', val: if var_args.array_isset(rt.new_string('has_archives')) { rt.new_int((var_args.array_get(rt.new_string('has_archives'))).to_i64()) } else { 0 } }])
	if rt.is_true(rt.identical(rt.new_int(0), var_id)) {
		var_results = rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_attribute_taxonomies'), var_data.clone(), rt.create_array_from_list(var_format)])
		if rt.is_true(rt.call_function('is_wp_error', [var_results.clone()])) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('cannot_create_attribute'), rt.call_method(var_results, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		var_id = rt.get_property(var_wpdb, 'insert_id')
		rt.call_function('do_action', [rt.new_string('woocommerce_attribute_added'), var_id.clone(), var_data.clone()])
	} else {
		var_results = rt.call_method(var_wpdb, 'update', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_attribute_taxonomies'), var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'attribute_id', val: var_id }]), rt.create_array_from_list(var_format), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
		if rt.is_true(rt.identical(rt.new_bool(false), var_results)) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('cannot_update_attribute'), rt.call_function('__', [rt.new_string('Could not update the attribute.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		var_old_slug = if !(!rt.is_true(var_args.array_get(rt.new_string('old_slug')))) { rt.call_function('wc_sanitize_taxonomy_name', [var_args.array_get(rt.new_string('old_slug'))]) } else { var_slug }
		rt.call_function('do_action', [rt.new_string('woocommerce_attribute_updated'), var_id.clone(), var_data.clone(), var_old_slug.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_slug, var_slug)))) {
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: wc_attribute_taxonomy_name(var_data.array_get(rt.new_string('attribute_name'))) }]), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pa_' + (var_old_slug).str() }])])
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'termmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'order' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'order_pa_' + (rt.call_function('sanitize_title', [var_old_slug.clone()])).str() }])])
			var_old_taxonomy_name = rt.new_string('pa_' + (var_old_slug).str())
			var_new_taxonomy_name = rt.new_string('pa_' + (var_data.array_get(rt.new_string('attribute_name'))).str())
			var_old_attribute_key = rt.call_function('sanitize_title', [var_old_taxonomy_name.clone()])
			var_new_attribute_key = rt.call_function('sanitize_title', [var_new_taxonomy_name.clone()])
			var_metadatas = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id, meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_product_attributes\' AND meta_value LIKE %s')), rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_old_taxonomy_name.clone()])).str() + '%')]), rt.get_constant('ARRAY_A')])
			mut iter_3 := var_metadatas.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_metadata_shadow := item_3.val
				var_product_id = var_metadata_shadow['post_id']
				var_unserialized_data = rt.call_function('maybe_unserialize', [var_metadata_shadow['meta_value']])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_unserialized_data)))) || !(var_unserialized_data.clone().is_array()) || !(var_unserialized_data.array_isset(var_old_attribute_key)) {
					continue
				}
				var_unserialized_data.array_set(var_new_attribute_key, var_unserialized_data.array_get(var_old_attribute_key))
				var_unserialized_data.array_unset(var_old_attribute_key)
				var_unserialized_data.array_get_mut(var_new_attribute_key).array_set('name', var_new_taxonomy_name.clone())
				rt.call_function('update_post_meta', [var_product_id.clone(), rt.new_string('_product_attributes'), rt.call_function('wp_slash', [var_unserialized_data.clone()])])
			}
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'attribute_pa_' + (rt.call_function('sanitize_title', [var_data.array_get(rt.new_string('attribute_name'))])).str() }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'attribute_pa_' + (rt.call_function('sanitize_title', [var_old_slug.clone()])).str() }])])
			if var_wc_product_attributes.array_isset(var_old_taxonomy_name) && !(var_wc_product_attributes.array_isset(var_new_taxonomy_name)) {
				var_wc_product_attributes.array_set(var_new_taxonomy_name, var_wc_product_attributes.array_get(var_old_taxonomy_name))
			}
			if var_wp_taxonomies.array_isset(var_old_taxonomy_name) && !(var_wp_taxonomies.array_isset(var_new_taxonomy_name)) {
				var_wp_taxonomies.array_set(var_new_taxonomy_name, var_wp_taxonomies.array_get(var_old_taxonomy_name))
			}
		}
	}
	rt.call_function('wp_schedule_single_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('woocommerce_flush_rewrite_rules')])
	rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.invalidate_cache_group(rt.new_string('woocommerce-attributes'))
	return var_id.clone()
}

fn wc_update_attribute(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_attribute := rt.new_null()
	var_attribute = wc_get_attribute(var_id.clone())
	var_args.array_set('id', if rt.is_true(var_attribute) { rt.get_property(var_attribute, 'id') } else { rt.new_int(0) })
	if rt.is_true(var_args.array_get(rt.new_string('id'))) {
		var_args.array_set('has_archives', if !(var_args.array_get(rt.new_string('has_archives'))).is_null() { var_args.array_get(rt.new_string('has_archives')) } else { rt.get_property(var_attribute, 'has_archives') })
		var_args.array_set('name', if !(var_args.array_get(rt.new_string('name'))).is_null() { var_args.array_get(rt.new_string('name')) } else { rt.get_property(var_attribute, 'name') })
		var_args.array_set('order_by', if !(var_args.array_get(rt.new_string('order_by'))).is_null() { var_args.array_get(rt.new_string('order_by')) } else { rt.get_property(var_attribute, 'order_by') })
		var_args.array_set('slug', if !(var_args.array_get(rt.new_string('slug'))).is_null() { var_args.array_get(rt.new_string('slug')) } else { rt.get_property(var_attribute, 'slug') })
		var_args.array_set('type', if !(var_args.array_get(rt.new_string('type'))).is_null() { var_args.array_get(rt.new_string('type')) } else { rt.get_property(var_attribute, 'type') })
	}
	if rt.is_true(var_args.array_get(rt.new_string('id'))) && !rt.is_true(var_args.array_get(rt.new_string('name'))) {
		var_args.array_set('name', rt.get_property(var_attribute, 'name'))
	}
	var_args.array_set('old_slug', rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT attribute_name\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies\n\t\t\t\tWHERE attribute_id = %d\n\t\t\t')), var_args.array_get(rt.new_string('id'))])]))
	return wc_create_attribute(var_args.clone())
}

fn wc_delete_attribute(var_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_name := rt.new_null()
	mut var_taxonomy := ''
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	var_name = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT attribute_name\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies\n\t\t\tWHERE attribute_id = %d\n\t\t\t')), var_id.clone()])])
	var_taxonomy = wc_attribute_taxonomy_name(var_name.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_before_attribute_delete'), var_id.clone(), var_name.clone(), rt.new_string((var_taxonomy).str()).clone()])
	if rt.is_true(var_name) && rt.is_true(rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_id = %d')), var_id.clone()])])) {
		if rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string((var_taxonomy).str()).clone()])) {
			var_terms = rt.call_function('get_terms', [rt.new_string((var_taxonomy).str()).clone(), rt.new_string('orderby=name&hide_empty=0')])
			mut iter_4 := var_terms.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_term_shadow := item_4.val
				rt.call_function('wp_delete_term', [rt.get_property(var_term_shadow, 'term_id'), rt.new_string((var_taxonomy).str()).clone()])
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_attribute_deleted'), var_id.clone(), var_name.clone(), rt.new_string((var_taxonomy).str()).clone()])
		rt.call_function('wp_schedule_single_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('woocommerce_flush_rewrite_rules')])
		rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
		mut iife_temp_4 := Class_WC_Cache_Helper{}
		mut iife_result_4 := iife_temp_4.invalidate_cache_group(rt.new_string('woocommerce-attributes'))
		return true
	}
	return false
}

fn wc_attribute_taxonomy_slug(var_attribute_name_arg rt.PhpVal) rt.PhpVal {
	mut var_attribute_name := var_attribute_name_arg
	mut var_prefix := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_cache_value := rt.new_null()
	mut var_attribute_slug := rt.new_null()
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.get_cache_prefix(rt.new_string('woocommerce-attributes'))
	var_prefix = iife_result_5
	var_cache_key = rt.new_string((var_prefix).str() + 'slug-' + (var_attribute_name).str())
	var_cache_value = rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce-attributes')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)))) {
		return var_cache_value.clone()
	}
	var_attribute_name = rt.call_function('wc_sanitize_taxonomy_name', [var_attribute_name.clone()])
	var_attribute_slug = if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_attribute_name.clone(), rt.new_string('pa_')]))) { rt.call_function('substr', [var_attribute_name.clone(), rt.new_int(3)]) } else { var_attribute_name }
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_attribute_slug.clone(), rt.new_string('woocommerce-attributes')])
	return var_attribute_slug.clone()
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
