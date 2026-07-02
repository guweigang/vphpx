import rt

fn wc_get_products(var_args rt.PhpVal) rt.PhpVal {
	mut var_map_legacy := map[string]rt.PhpVal{}
	mut var_to := rt.new_null()
	mut var_from := rt.new_null()
	mut var_query := rt.new_null()
	var_map_legacy = {
		'numberposts':    'limit'
		'post_status':    'status'
		'post_parent':    'parent'
		'posts_per_page': 'limit'
		'paged':          'page'
	}
	for var_from_shadow, var_to_shadow in var_map_legacy {
		if var_args.array_isset(rt.new_string(var_from_shadow.str())) {
			var_args.array_set(rt.new_string(var_to_shadow.str()),
				var_args.array_get(rt.new_string(var_from_shadow.str())))
		}
	}
	var_query = create_wc_product_query(var_args.clone())
	return var_query.get_products()
}

fn wc_get_product(the_product bool, var_deprecated rt.PhpVal) bool {
	mut var_the_product := the_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_taxonomy')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_post_type')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s should not be called before the %2$s, %3$s and %4$s actions have finished.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('wc_get_product'),
				rt.new_string('woocommerce_init'),
				rt.new_string('woocommerce_after_register_taxonomy'),
				rt.new_string('woocommerce_after_register_post_type'),
			]),
			rt.new_string('3.9')])
		return false
	}
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('args'),
			rt.new_string('3.0'),
			rt.new_string('Passing args to wc_get_product is deprecated. If you need to force a type, construct the product class directly.')])
	}
	return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'product_factory'),
		'get_product', [rt.new_bool(the_product), var_deprecated.clone()])).to_bool()
}

fn wc_get_product_object(var_product_type rt.PhpVal, product_id i64) rt.PhpVal {
	mut var_product_id := product_id
	mut var_classname := rt.new_null()
	mut iife_temp_0 := Class_WC_Product_Factory{}
	mut iife_result_0 := iife_temp_0.get_product_classname(rt.new_int(product_id),
		var_product_type.clone())
	var_classname = iife_result_0
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_classname, [
		rt.new_int(product_id),
	]))
}

fn wc_product_sku_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_product_sku_enabled'),
		rt.new_bool(true)])
}

fn wc_product_weight_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_product_weight_enabled'),
		rt.new_bool(true)])
}

fn wc_product_dimensions_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('wc_product_dimensions_enabled'),
		rt.new_bool(true),
	])
}

fn wc_delete_product_transients(post_id i64) {
	mut var_post_id := post_id
	mut var_transients_to_clear := []rt.PhpVal{}
	mut var_transient := rt.new_null()
	var_transients_to_clear = ['wc_products_onsale', 'wc_featured_products', 'wc_outofstock_count',
		'wc_low_stock_count']
	for var_transient_shadow in var_transients_to_clear {
		rt.call_function('delete_transient', [rt.new_string(var_transient_shadow.str()).clone()])
	}
	if post_id > 0 {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil.class(),
		]), 'delete_product_specific_transients', [rt.new_int(post_id)])
	}
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_transient_version(rt.new_string('product'),
		rt.new_bool(true))
	rt.call_function('do_action', [
		rt.new_string('woocommerce_delete_product_transients'),
		rt.new_int(post_id),
	])
}

fn wc_delete_related_product_transients(var_post_id rt.PhpVal) {
	mut var_transient_name := rt.new_null()
	mut var_old_transient := rt.new_null()
	mut var_old_related_product_ids := rt.new_null()
	mut var_new_related_product_ids := rt.new_null()
	mut var_related_product_ids := rt.new_null()
	mut var_related_product_transients := rt.new_null()
	rt.call_function('wc_deprecated_function', [
		rt.new_string('wc_delete_related_product_transients'),
		rt.new_string('10.1.0'),
		rt.new_string('This function is deprecated and will be removed in a future version.'),
	])
	if !(var_post_id.clone().is_long() || var_post_id.clone().is_double()) {
		return
	}
	var_transient_name = rt.new_string('wc_related_' + var_post_id.str())
	var_old_transient = rt.call_function('get_transient', [var_transient_name.clone()])
	var_old_related_product_ids = rt.new_array()
	if var_old_transient.clone().is_array() && !(!rt.is_true(var_old_transient)) {
		var_old_related_product_ids = var_old_transient.array_get(rt.call_function('array_key_first', [
			var_old_transient.clone(),
		]))
	}
	rt.call_function('delete_transient', [var_transient_name.clone()])
	var_new_related_product_ids = wc_get_related_products(var_post_id.clone(), 1000, rt.new_null(),
		rt.new_null())
	var_related_product_ids = rt.call_function('array_unique', [
		rt.call_function('array_merge', [var_old_related_product_ids.clone(),
			var_new_related_product_ids.clone()]),
	])
	if !rt.is_true(var_related_product_ids) {
		return
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	var_related_product_transients = rt.call_function('array_map', [
		rt.new_closure(closure_3_fn),
		var_related_product_ids.clone(),
	])
	rt.call_function('_wc_delete_transients', [var_related_product_transients.clone()])
}

fn wc_get_product_ids_on_sale() rt.PhpVal {
	mut var_product_ids_on_sale := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_on_sale_products := rt.new_null()
	var_product_ids_on_sale = rt.call_function('get_transient', [
		rt.new_string('wc_products_onsale'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_product_ids_on_sale)))) {
		return var_product_ids_on_sale.clone()
	}
	mut iife_temp_4 := Class_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('product'))
	var_data_store = iife_result_4
	var_on_sale_products = rt.call_method(var_data_store, 'get_on_sale_products', []rt.PhpVal{})
	var_product_ids_on_sale = rt.call_function('wp_parse_id_list', [
		rt.call_function('array_merge', [
			rt.call_function('wp_list_pluck', [
				var_on_sale_products.clone(),
				rt.new_string('id'),
			]),
			rt.call_function('array_diff', [
				rt.call_function('wp_list_pluck', [var_on_sale_products.clone(),
					rt.new_string('parent_id')]),
				rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
			]),
		]),
	])
	rt.call_function('set_transient', [rt.new_string('wc_products_onsale'),
		var_product_ids_on_sale.clone(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	return var_product_ids_on_sale.clone()
}

fn wc_get_featured_product_ids() rt.PhpVal {
	mut var_featured_product_ids := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_featured := rt.new_null()
	mut var_product_ids := rt.new_null()
	mut var_parent_ids := rt.new_null()
	var_featured_product_ids = rt.call_function('get_transient', [
		rt.new_string('wc_featured_products'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_featured_product_ids)))) {
		return var_featured_product_ids.clone()
	}
	mut iife_temp_5 := Class_WC_Data_Store{}
	mut iife_result_5 := iife_temp_5.load(rt.new_string('product'))
	var_data_store = iife_result_5
	var_featured = rt.call_method(var_data_store, 'get_featured_product_ids', []rt.PhpVal{})
	var_product_ids = rt.func_array_keys(var_featured.clone())
	var_parent_ids = rt.call_function('array_values', [
		rt.call_function('array_filter', [var_featured.clone()]),
	])
	var_featured_product_ids = rt.call_function('array_unique', [
		rt.call_function('array_merge', [var_product_ids.clone(),
			var_parent_ids.clone()]),
	])
	rt.call_function('set_transient', [rt.new_string('wc_featured_products'),
		var_featured_product_ids.clone(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	return var_featured_product_ids.clone()
}

fn wc_product_post_type_link(permalink string, var_post rt.PhpVal) rt.PhpVal {
	mut var_permalink := permalink
	mut var_needs_category := false
	mut var_product_cat := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_deepest_term := rt.new_null()
	mut var_deepest_ancestors := rt.new_null()
	mut var_term := rt.new_null()
	mut var_ancestors := rt.new_null()
	mut var_category_object := rt.new_null()
	mut var_ancestor := rt.new_null()
	mut var_ancestor_object := rt.new_null()
	mut var_find := []rt.PhpVal{}
	mut var_replace := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post,
		'post_type')))))
	{
		return rt.new_string(var_permalink.str())
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string(var_permalink.str()),
		rt.new_string('%'),
	])))
	{
		return rt.new_string(var_permalink.str())
	}
	var_needs_category =
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(var_permalink.str()), rt.new_string('%category%')]), rt.new_bool(false)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(var_permalink.str()), rt.new_string('%product_cat%')]), rt.new_bool(false)))))
	var_product_cat = rt.new_string('')
	if var_needs_category {
		var_terms = rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'),
			rt.new_string('product_cat')])
		if !(!rt.is_true(var_terms))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])))))
			&& var_terms.clone().is_array() {
			var_terms = rt.call_function('array_values', [var_terms.clone()])
			var_deepest_term = var_terms.array_get(rt.new_int(0))
			var_deepest_ancestors = if rt.is_true(rt.get_property(var_deepest_term, 'parent')) { rt.call_function('get_ancestors', [
					rt.get_property(var_deepest_term, 'term_id'),
					rt.new_string('product_cat'),
				]) } else { rt.new_array() }
			mut iter_1 := var_terms.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term_shadow := item_1.val
				if rt.is_true(rt.identical(rt.get_property(var_term_shadow, 'term_id'), rt.get_property(var_deepest_term,
					'term_id')))
				{
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_term_shadow, 'parent'))))) {
					continue
				}
				var_ancestors = rt.call_function('get_ancestors', [
					rt.get_property(var_term_shadow, 'term_id'),
					rt.new_string('product_cat'),
				])
				if var_ancestors.clone().array_count() > var_deepest_ancestors.clone().array_count() {
					var_deepest_ancestors = var_ancestors.clone()
					var_deepest_term = var_term_shadow.clone()
				}
			}
			var_category_object = rt.call_function('apply_filters', [
				rt.new_string('wc_product_post_type_link_product_cat'),
				var_deepest_term.clone(),
				var_terms.clone(),
				var_post.clone(),
			])
			var_category_object = if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_category_object,
				'WP_Term'))))))
			{
				var_deepest_term
			} else {
				var_category_object
			}
			var_product_cat = rt.get_property(var_category_object, 'slug')
			if rt.is_true(rt.get_property(var_category_object, 'parent')) {
				var_ancestors = if rt.is_true(rt.identical(rt.get_property(var_category_object, 'term_id'), rt.get_property(var_deepest_term, 'term_id'))) { var_deepest_ancestors } else { rt.call_function('get_ancestors', [
						rt.get_property(var_category_object, 'term_id'),
						rt.new_string('product_cat'),
					]) }
				mut iter_2 := var_ancestors.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_ancestor_shadow := item_2.val
					var_ancestor_object = rt.call_function('get_term', [
						var_ancestor_shadow.clone(), rt.new_string('product_cat')])
					if rt.is_true(rt.call_function('apply_filters', [
						rt.new_string('woocommerce_product_post_type_link_parent_category_only'),
						rt.new_bool(false),
					]))
					{
						var_product_cat = rt.get_property(var_ancestor_object, 'slug')
					} else {
						var_product_cat = rt.new_string(
							(rt.get_property(var_ancestor_object, 'slug')).str() + '/' +
							var_product_cat.str())
					}
				}
			}
		} else {
			var_product_cat = rt.call_function('_x', [rt.new_string('uncategorized'),
				rt.new_string('slug'), rt.new_string('woocommerce')])
		}
	}
	var_find = ['%year%', '%monthnum%', '%day%', '%hour%', '%minute%', '%second%', '%post_id%',
		'%category%', '%product_cat%']
	var_replace = [
		rt.call_function('date_i18n', [rt.new_string('Y'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		rt.call_function('date_i18n', [rt.new_string('m'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		rt.call_function('date_i18n', [rt.new_string('d'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		rt.call_function('date_i18n', [rt.new_string('H'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		rt.call_function('date_i18n', [rt.new_string('i'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		rt.call_function('date_i18n', [rt.new_string('s'),
			rt.call_function('strtotime', [rt.get_property(var_post, 'post_date')])]),
		(rt.get_property(var_post, 'ID')).str(),
		var_product_cat,
		var_product_cat,
	]
	var_permalink = (rt.call_function('str_replace', [
		rt.create_array_from_list(var_find),
		rt.create_array_from_list(var_replace),
		rt.new_string(var_permalink.str()),
	])).str()
	return rt.new_string(var_permalink.str())
}

fn wc_product_canonical_redirect() {
	mut var_wp_rewrite := rt.new_null()
	mut var_specified_category_slug := rt.new_null()
	mut var_expected_category_slug := rt.new_null()
	mut var_query_vars := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_wp_rewrite.clone(), Class_WP_Rewrite.class()]))))) {
		return
	}
	var_specified_category_slug = rt.call_function('get_query_var', [
		rt.new_string('product_cat'),
	])
	var_specified_category_slug = if var_specified_category_slug.clone().is_array() { rt.new_string('') } else { rt.call_function('urldecode', [
			rt.new_string(var_specified_category_slug.str()),
		]) }
	if rt.is_true(rt.identical(rt.new_string(''), var_specified_category_slug)) {
		return
	}
	var_expected_category_slug = wc_product_post_type_link('%product_cat%', rt.call_function('get_post', [
		rt.call_function('get_the_ID', []rt.PhpVal{}),
	]))
	var_expected_category_slug = rt.call_function('urldecode', [
		var_expected_category_slug.clone()])
	if rt.is_true(rt.identical(var_specified_category_slug, var_expected_category_slug)) {
		return
	}
	var_query_vars = if !(rt.get_superglobal('_GET')).is_null()
		&& rt.get_superglobal('_GET').clone().is_array() {
		rt.get_superglobal('_GET')
	} else {
		rt.new_array()
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('add_query_arg', [var_query_vars.clone(),
			rt.call_method(rt.new_bool(wc_get_product(rt.call_function('get_the_ID', []rt.PhpVal{}),
				rt.new_null())), 'get_permalink', []rt.PhpVal{})]),
		rt.new_int(301),
	])
	exit(0)
}

fn wc_placeholder_img_src(size string) rt.PhpVal {
	mut var_size := size
	mut var_src := rt.new_null()
	mut var_placeholder_image := rt.new_null()
	mut var_image := rt.new_null()
	var_src = rt.new_string(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
		'/assets/images/placeholder.webp')
	var_placeholder_image = rt.call_function('get_option', [
		rt.new_string('woocommerce_placeholder_image'),
		rt.new_int(0),
	])
	if !(!rt.is_true(var_placeholder_image)) {
		if rt.is_true(rt.new_bool(var_placeholder_image.clone().is_long()
			|| var_placeholder_image.clone().is_double()))
		{
			var_image = rt.call_function('wp_get_attachment_image_src', [
				var_placeholder_image.clone(), rt.new_string(size)])
			if !(!rt.is_true(var_image.array_get(rt.new_int(0)))) {
				var_src = var_image.array_get(rt.new_int(0))
			}
		} else {
			var_src = var_placeholder_image.clone()
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_placeholder_img_src'),
		var_src.clone(),
	])
}

fn wc_placeholder_img(size string, attr string) rt.PhpVal {
	mut var_size := size
	mut var_attr := attr
	mut var_dimensions := rt.new_null()
	mut var_placeholder_image := rt.new_null()
	mut var_default_attr := map[string]rt.PhpVal{}
	mut var_image_html := rt.new_null()
	mut var_image := rt.new_null()
	mut var_hwstring := rt.new_null()
	mut var_attributes := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	var_dimensions = rt.call_function('wc_get_image_size', [rt.new_string(size)])
	var_placeholder_image = rt.call_function('get_option', [
		rt.new_string('woocommerce_placeholder_image'),
		rt.new_int(0),
	])
	var_default_attr = {
		'class': rt.new_string('woocommerce-placeholder wp-post-image')
		'alt':   rt.call_function('__', [rt.new_string('Placeholder'),
			rt.new_string('woocommerce')])
	}
	var_attr = (rt.call_function('wp_parse_args', [rt.new_string(var_attr.str()),
		rt.create_array_from_native_map(var_default_attr)])).str()
	if rt.is_true(rt.call_function('wp_attachment_is_image', [
		var_placeholder_image.clone()]))
	{
		var_image_html = rt.call_function('wp_get_attachment_image', [
			var_placeholder_image.clone(), rt.new_string(size),
			rt.new_bool(false), rt.new_string(var_attr.str())])
	} else {
		var_image = wc_placeholder_img_src(size)
		var_hwstring = rt.call_function('image_hwstring', [
			var_dimensions.array_get(rt.new_string('width')),
			var_dimensions.array_get(rt.new_string('height')),
		])
		var_attributes = rt.new_array()
		mut iter_3 := rt.new_string(var_attr.str()).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value_shadow := item_3.val
			mut var_name_shadow := item_3.key
			var_attributes << (rt.call_function('esc_attr', [var_name_shadow.clone()])).str() +
				'="' + (rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
		}
		var_image_html = rt.new_string('<img src="' +
			(rt.call_function('esc_url', [var_image.clone()])).str() + '" ' + var_hwstring.str() +
			(rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_attributes)])).str() +
			'/>')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_placeholder_img'),
		var_image_html.clone(),
		rt.new_string(size),
		var_dimensions.clone(),
	])
}

fn wc_get_formatted_variation(var_variation rt.PhpVal, flat bool, include_names bool, skip_attributes_in_name bool) rt.PhpVal {
	mut var_flat := flat
	mut var_include_names := include_names
	mut var_skip_attributes_in_name := skip_attributes_in_name
	mut var_return := rt.new_null()
	mut var_variation_attributes := rt.new_null()
	mut var_product := rt.new_null()
	mut var_variation_name := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_list_type := ''
	mut var_variation_list := []rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_term := rt.new_null()
	var_return = rt.new_string('')
	if rt.is_true(rt.call_function('is_a', [var_variation.clone(),
		rt.new_string('WC_Product_Variation')]))
	{
		var_variation_attributes = rt.call_method(var_variation, 'get_attributes', []rt.PhpVal{})
		var_product = var_variation
		var_variation_name = rt.call_method(var_variation, 'get_name', []rt.PhpVal{})
	} else {
		var_product = rt.new_bool(false)
		var_variation_name = rt.new_string('')
		var_variation_attributes = rt.new_array()
		if rt.is_true(rt.new_bool(var_variation.clone().is_array())) {
			mut iter_4 := var_variation.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_value_shadow := item_4.val
				mut var_key_shadow := item_4.key
				var_variation_attributes.array_set(rt.call_function('str_replace', [
					rt.new_string('attribute_'),
					rt.new_string(''),
					var_key_shadow.clone(),
				]), var_value_shadow.clone())
			}
		}
	}
	var_list_type = if var_include_names { 'dl' } else { 'ul' }
	if var_variation_attributes.clone().is_array() && !(!rt.is_true(var_variation_attributes)) {
		if !var_flat {
			var_return = rt.new_string('<' + var_list_type + ' class="variation">')
		}
		var_variation_list = rt.new_array()
		mut iter_5 := var_variation_attributes.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_value_shadow := item_5.val
			mut var_name_shadow := item_5.key
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_name_shadow.clone()]))
			{
				var_term = rt.call_function('get_term_by', [rt.new_string('slug'),
					var_value_shadow.clone(), var_name_shadow.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])))))
					&& rt.is_true(var_term)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_term, 'name')))))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_term, 'name'))))) {
					var_value_shadow = rt.get_property(var_term, 'name')
				}
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_value_shadow))
				|| (var_skip_attributes_in_name
				&& rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_value_shadow.clone(), var_variation_name.clone()]))) {
				continue
			}
			if var_include_names {
				if var_flat {
					var_variation_list <<
						(rt.call_function('wc_attribute_label', [var_name_shadow.clone(), var_product.clone()])).str() +
						': ' + (rt.call_function('rawurldecode', [var_value_shadow.clone()])).str()
				} else {
					var_variation_list << '<dt>' +
						(rt.call_function('wc_attribute_label', [var_name_shadow.clone(), var_product.clone()])).str() +
						':</dt><dd>' +
						(rt.call_function('rawurldecode', [var_value_shadow.clone()])).str() +
						'</dd>'
				}
			} else if var_flat {
				var_variation_list << rt.call_function('rawurldecode', [
					var_value_shadow.clone()])
			} else {
				var_variation_list << '<li>' +
					(rt.call_function('rawurldecode', [var_value_shadow.clone()])).str() + '</li>'
			}
		}
		if var_flat {
			var_return = rt.concat(var_return, rt.call_function('implode', [
				rt.new_string(', '),
				rt.create_array_from_list(var_variation_list),
			]))
		} else {
			var_return = rt.concat(var_return, rt.call_function('implode', [
				rt.new_string(''),
				rt.create_array_from_list(var_variation_list),
			]))
		}
		if !var_flat {
			var_return = rt.concat(var_return, rt.new_string('</' + var_list_type + '>'))
		}
	}
	return var_return.clone()
}

fn wc_schedule_product_sale_events(var_product rt.PhpVal) {
	mut var_product_id := rt.new_null()
	mut var_date_from := rt.new_null()
	mut var_date_to := rt.new_null()
	mut var_start_ts := rt.new_null()
	mut var_end_ts := rt.new_null()
	var_product_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	var_date_from = rt.call_method(var_product, 'get_date_on_sale_from', [
		rt.new_string('edit'),
	])
	var_date_to = rt.call_method(var_product, 'get_date_on_sale_to', [
		rt.new_string('edit'),
	])
	if rt.is_true(var_date_from) {
		var_start_ts = rt.call_method(var_date_from, 'getTimestamp', []rt.PhpVal{})
		if rt.is_true(rt.greater(var_start_ts, rt.call_function('time', []rt.PhpVal{}))) {
			rt.call_function('as_schedule_single_action', [var_start_ts.clone(),
				rt.new_string('wc_product_start_scheduled_sale'),
				rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
				rt.new_string('woocommerce-sales')])
		}
	}
	if rt.is_true(var_date_to) {
		var_end_ts = rt.call_method(var_date_to, 'getTimestamp', []rt.PhpVal{})
		if rt.is_true(rt.greater(var_end_ts, rt.call_function('time', []rt.PhpVal{}))) {
			rt.call_function('as_schedule_single_action', [var_end_ts.clone(),
				rt.new_string('wc_product_end_scheduled_sale'),
				rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
				rt.new_string('woocommerce-sales')])
		}
	}
}

fn wc_apply_sale_state_for_product(var_product rt.PhpVal, mode string) {
	mut var_mode := mode
	mut var_product_id := rt.new_null()
	mut var_sale_price := rt.new_null()
	mut var_regular_price := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_parent_id := rt.new_null()
	var_product_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('start'), rt.new_string(mode))) {
		var_sale_price = rt.call_method(var_product, 'get_sale_price', [
			rt.new_string('edit'),
		])
		if rt.is_true(var_sale_price) {
			rt.call_method(var_product, 'set_price', [var_sale_price.clone()])
			rt.call_method(var_product, 'save', []rt.PhpVal{})
			rt.call_function('update_post_meta', [var_product_id.clone(),
				rt.new_string('_price'), var_sale_price.clone()])
		}
	} else if rt.is_true(rt.identical(rt.new_string('end'), rt.new_string(mode))) {
		var_regular_price = rt.call_method(var_product, 'get_regular_price', [
			rt.new_string('edit'),
		])
		rt.call_method(var_product, 'set_price', [var_regular_price.clone()])
		rt.call_method(var_product, 'save', []rt.PhpVal{})
		rt.call_function('update_post_meta', [var_product_id.clone(),
			rt.new_string('_price'), var_regular_price.clone()])
	}
	mut iife_temp_6 := Class_WC_Data_Store{}
	mut iife_result_6 := iife_temp_6.load(rt.new_string('product'))
	var_data_store = iife_result_6
	if rt.is_true(rt.call_method(var_data_store, 'has_callable', [
		rt.new_string('refresh_product_lookup_table'),
	]))
	{
		rt.call_method(var_data_store, 'refresh_product_lookup_table', [
			var_product_id.clone()])
	}
	wc_delete_product_transients(var_product_id.clone())
	if rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variation')])) {
		var_parent_id = rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
		if rt.is_true(var_parent_id) {
			mut iife_temp_7 := Class_WC_Product_Variable{}
			mut iife_result_7 := iife_temp_7.sync(var_parent_id.clone())
		}
	}
}

fn wc_handle_product_start_scheduled_sale(var_product_id rt.PhpVal) {
	mut var_product := false
	mut var_now := rt.new_null()
	mut var_date_from := rt.new_null()
	mut var_date_to := rt.new_null()
	var_product = wc_get_product(var_product_id.clone())
	if !var_product {
		return
	}
	if rt.is_true(rt.call_method(rt.new_bool(var_product), 'is_type', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'variable' },
			rt.ArrayItem{ key: none, val: 'grouped' }]),
	]))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.new_bool(var_product),
		'get_sale_price', [rt.new_string('edit')])))))
	{
		return
	}
	var_now = rt.call_function('time', []rt.PhpVal{})
	var_date_from = rt.call_method(rt.new_bool(var_product), 'get_date_on_sale_from', [
		rt.new_string('edit'),
	])
	var_date_to = rt.call_method(rt.new_bool(var_product), 'get_date_on_sale_to', [
		rt.new_string('edit'),
	])
	if rt.is_true(var_date_from)
		&& rt.is_true(rt.greater(rt.call_method(var_date_from, 'getTimestamp', []rt.PhpVal{}), var_now)) {
		return
	}
	if rt.is_true(var_date_to)
		&& rt.is_true(rt.less(rt.call_method(var_date_to, 'getTimestamp', []rt.PhpVal{}), var_now)) {
		return
	}
	if rt.new_float((rt.call_method(rt.new_bool(var_product), 'get_price', [
		rt.new_string('edit'),
	])).to_f64()) == rt.new_float((rt.call_method(rt.new_bool(var_product), 'get_sale_price', [
		rt.new_string('edit'),
	])).to_f64()) {
		return
	}
	wc_apply_sale_state_for_product(rt.new_bool(var_product).clone(), 'start')
}

fn wc_handle_product_end_scheduled_sale(var_product_id rt.PhpVal) {
	mut var_product := false
	mut var_now := rt.new_null()
	mut var_date_to := rt.new_null()
	var_product = wc_get_product(var_product_id.clone())
	if !var_product {
		return
	}
	if rt.is_true(rt.call_method(rt.new_bool(var_product), 'is_type', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'variable' },
			rt.ArrayItem{ key: none, val: 'grouped' }]),
	]))
	{
		return
	}
	var_now = rt.call_function('time', []rt.PhpVal{})
	var_date_to = rt.call_method(rt.new_bool(var_product), 'get_date_on_sale_to', [
		rt.new_string('edit'),
	])
	if rt.is_true(var_date_to)
		&& rt.is_true(rt.greater(rt.call_method(var_date_to, 'getTimestamp', []rt.PhpVal{}), var_now)) {
		return
	}
	if rt.new_float((rt.call_method(rt.new_bool(var_product), 'get_price', [
		rt.new_string('edit'),
	])).to_f64()) == rt.new_float((rt.call_method(rt.new_bool(var_product), 'get_regular_price', [
		rt.new_string('edit'),
	])).to_f64()) {
		return
	}
	wc_apply_sale_state_for_product(rt.new_bool(var_product).clone(), 'end')
}

fn wc_maybe_schedule_product_sale_events(var_product_id_arg rt.PhpVal, var_product_arg rt.PhpVal) {
	mut var_product_id := var_product_id_arg
	mut var_product := var_product_arg
	mut var_date_from := rt.new_null()
	mut var_date_to := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		var_product = rt.new_bool(wc_get_product(var_product_id.clone(), rt.new_null()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			return
		}
	}
	var_product_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	rt.call_function('as_unschedule_all_actions', [
		rt.new_string('wc_product_start_scheduled_sale'),
		rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
		rt.new_string('woocommerce-sales'),
	])
	rt.call_function('as_unschedule_all_actions', [
		rt.new_string('wc_product_end_scheduled_sale'),
		rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]),
		rt.new_string('woocommerce-sales'),
	])
	var_date_from = rt.call_method(var_product, 'get_date_on_sale_from', [
		rt.new_string('edit'),
	])
	var_date_to = rt.call_method(var_product, 'get_date_on_sale_to', [
		rt.new_string('edit'),
	])
	if rt.is_true(var_date_from) || rt.is_true(var_date_to) {
		wc_schedule_product_sale_events(var_product.clone())
	}
}

fn wc_maybe_schedule_sale_events_on_meta_change(var_meta_id rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal) {
	mut var_post_type := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_sale_price_dates_from'), var_meta_key))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_sale_price_dates_to'), var_meta_key)))) {
		return
	}
	if rt.is_true(rt.call_function('doing_action', [rt.new_string('wc_product_start_scheduled_sale')]))
		|| rt.is_true(rt.call_function('doing_action', [rt.new_string('wc_product_end_scheduled_sale')])) {
		return
	}
	var_post_type = rt.call_function('get_post_type', [var_object_id.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_post_type))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type)))) {
		return
	}
	wc_maybe_schedule_product_sale_events(var_object_id.clone(), rt.new_null())
}

fn wc_scheduled_sales() {
	mut var_data_store := rt.new_null()
	mut var_product_util := rt.new_null()
	mut var_must_refresh_transient := false
	mut var_product_ids := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_product := false
	mut iife_temp_8 := Class_WC_Data_Store{}
	mut iife_result_8 := iife_temp_8.load(rt.new_string('product'))
	var_data_store = iife_result_8
	var_product_util = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil.class(),
	])
	var_must_refresh_transient = false
	var_product_ids = rt.call_method(var_data_store, 'get_starting_sales', []rt.PhpVal{})
	if rt.is_true(var_product_ids) {
		rt.call_function('_prime_post_caches', [var_product_ids.clone()])
		var_must_refresh_transient = true
		rt.call_function('do_action', [
			rt.new_string('wc_before_products_starting_sales'),
			var_product_ids.clone(),
		])
		mut iter_6 := var_product_ids.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_product_id_shadow := item_6.val
			var_product = wc_get_product(var_product_id_shadow.clone())
			if var_product {
				wc_apply_sale_state_for_product(rt.new_bool(var_product).clone(), 'start')
			}
			rt.call_method(var_product_util, 'delete_product_specific_transients', [
				if var_product { rt.new_bool(var_product) } else { var_product_id_shadow },
			])
		}
		rt.call_function('do_action', [rt.new_string('wc_after_products_starting_sales'),
			var_product_ids.clone()])
		rt.call_function('delete_transient', [rt.new_string('wc_products_onsale')])
	}
	var_product_ids = rt.call_method(var_data_store, 'get_ending_sales', []rt.PhpVal{})
	if rt.is_true(var_product_ids) {
		rt.call_function('_prime_post_caches', [var_product_ids.clone()])
		var_must_refresh_transient = true
		rt.call_function('do_action', [rt.new_string('wc_before_products_ending_sales'),
			var_product_ids.clone()])
		mut iter_7 := var_product_ids.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_product_id_shadow := item_7.val
			var_product = wc_get_product(var_product_id_shadow.clone())
			if var_product {
				wc_apply_sale_state_for_product(rt.new_bool(var_product).clone(), 'end')
			}
			rt.call_method(var_product_util, 'delete_product_specific_transients', [
				if var_product { rt.new_bool(var_product) } else { var_product_id_shadow },
			])
		}
		rt.call_function('do_action', [rt.new_string('wc_after_products_ending_sales'),
			var_product_ids.clone()])
		rt.call_function('delete_transient', [rt.new_string('wc_products_onsale')])
	}
	if var_must_refresh_transient {
		mut iife_temp_9 := Class_WC_Cache_Helper{}
		mut iife_result_9 := iife_temp_9.get_transient_version(rt.new_string('product'),
			rt.new_bool(true))
	}
}

fn wc_get_attachment_image_attributes(var_attr rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{
		return var_attr.clone()
	}
	if var_attr.array_isset(rt.new_string('src'))
		&& rt.is_true(rt.call_function('strstr', [var_attr.array_get(rt.new_string('src')), rt.new_string('woocommerce_uploads/')])) {
		var_attr.array_set('src', wc_placeholder_img_src(''))
		if var_attr.array_isset(rt.new_string('srcset')) {
			var_attr.array_set('srcset', '')
		}
	}
	return var_attr.clone()
}

fn wc_prepare_attachment_for_js(var_response rt.PhpVal) rt.PhpVal {
	mut var_value := rt.new_null()
	mut var_size := rt.new_null()
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{
		return var_response.clone()
	}
	if var_response.array_isset(rt.new_string('url'))
		&& rt.is_true(rt.call_function('strstr', [var_response.array_get(rt.new_string('url')), rt.new_string('woocommerce_uploads/')])) {
		var_response.array_get_mut('full').array_set('url', wc_placeholder_img_src(''))
		if var_response.array_isset(rt.new_string('sizes')) {
			mut iter_8 := var_response.array_get(rt.new_string('sizes')).iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_value_shadow := item_8.val
				mut var_size_shadow := item_8.key
				var_response.array_get_mut('sizes').array_get_mut(var_size_shadow).array_set('url',
					wc_placeholder_img_src(''))
			}
		}
	}
	return var_response.clone()
}

fn wc_track_product_view() {
	mut var_post := rt.new_null()
	mut var_viewed_products := rt.new_null()
	mut var_keys := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('woocommerce_recently_viewed_products'), rt.new_bool(true)]))))) {
		return
	}
	if !rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.new_string('woocommerce_recently_viewed'))) {
		var_viewed_products = rt.new_array()
	} else {
		var_viewed_products = rt.call_function('wp_parse_id_list', [
			rt.cast_array(rt.call_function('explode', [rt.new_string('|'),
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_COOKIE').array_get(rt.new_string('woocommerce_recently_viewed')),
				])])),
		])
	}
	var_keys = rt.call_function('array_flip', [var_viewed_products.clone()])
	if var_keys.array_isset(rt.get_property(var_post, 'ID')) {
		var_viewed_products.array_unset(var_keys.array_get(rt.get_property(var_post, 'ID')))
	}
	var_viewed_products.array_push(rt.get_property(var_post, 'ID'))
	if var_viewed_products.clone().array_count() > 15 {
		rt.call_function('array_shift', [var_viewed_products.clone()])
	}
	rt.call_function('wc_setcookie', [rt.new_string('woocommerce_recently_viewed'),
		rt.call_function('implode', [rt.new_string('|'), var_viewed_products.clone()])])
}

fn wc_get_product_types() rt.PhpVal {
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('product_type_selector'),
		rt.create_array([
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductType.simple(), val: rt.call_function('__', [
				rt.new_string('Simple product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductType.grouped(), val: rt.call_function('__', [
				rt.new_string('Grouped product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductType.external(), val: rt.call_function('__', [
				rt.new_string('External/Affiliate product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductType.variable(), val: rt.call_function('__', [
				rt.new_string('Variable product'),
				rt.new_string('woocommerce'),
			]) },
		]),
	]))
}

fn wc_product_has_unique_sku(var_product_id rt.PhpVal, var_sku rt.PhpVal) bool {
	mut var_has_unique_sku := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_sku_found := rt.new_null()
	var_has_unique_sku = rt.call_function('apply_filters', [
		rt.new_string('wc_product_pre_has_unique_sku'),
		rt.new_null(),
		var_product_id.clone(),
		var_sku.clone(),
	])
	if !(var_has_unique_sku.clone().is_null()) {
		return rt.is_true(var_has_unique_sku.clone())
	}
	mut iife_temp_10 := Class_WC_Data_Store{}
	mut iife_result_10 := iife_temp_10.load(rt.new_string('product'))
	var_data_store = iife_result_10
	var_sku_found = rt.call_method(var_data_store, 'is_existing_sku', [
		var_product_id.clone(), var_sku.clone()])
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wc_product_has_unique_sku'),
		var_sku_found.clone(),
		var_product_id.clone(),
		var_sku.clone(),
	]))
	{
		return false
	}
	return true
}

fn wc_product_has_global_unique_id(var_product_id rt.PhpVal, var_global_unique_id rt.PhpVal) bool {
	mut var_has_global_unique_id := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_global_unique_id_found := rt.new_null()
	mut var_logger := rt.new_null()
	var_has_global_unique_id = rt.call_function('apply_filters', [
		rt.new_string('wc_product_pre_has_global_unique_id'),
		rt.new_null(),
		var_product_id.clone(),
		var_global_unique_id.clone(),
	])
	if !(var_has_global_unique_id.clone().is_null()) {
		return rt.is_true(var_has_global_unique_id.clone())
	}
	mut iife_temp_11 := Class_WC_Data_Store{}
	mut iife_result_11 := iife_temp_11.load(rt.new_string('product'))
	var_data_store = iife_result_11
	if rt.is_true(rt.call_method(var_data_store, 'has_callable', [
		rt.new_string('is_existing_global_unique_id'),
	]))
	{
		var_global_unique_id_found = rt.call_method(var_data_store, 'is_existing_global_unique_id', [
			var_product_id.clone(),
			var_global_unique_id.clone(),
		])
	} else {
		var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'error', [
			rt.new_string('The method is_existing_global_unique_id is not implemented in the data store.'),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc_product_has_global_unique_id' },
			]),
		])
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wc_product_has_global_unique_id'),
		var_global_unique_id_found.clone(),
		var_product_id.clone(),
		var_global_unique_id.clone(),
	]))
	{
		return false
	}
	return true
}

fn wc_product_force_unique_sku(var_product_id rt.PhpVal) {
	mut var_product := false
	mut var_current_sku := rt.new_null()
	mut var_new_sku := rt.new_null()
	mut var_e := rt.new_null()
	var_product = wc_get_product(var_product_id.clone())
	var_current_sku = if var_product { rt.call_method(rt.new_bool(var_product), 'get_sku', [
			rt.new_string('edit'),
		]) } else { rt.new_string('') }
	if rt.is_true(var_current_sku) {
		var_new_sku = wc_product_generate_unique_sku(var_product_id.clone(),
			var_current_sku.clone(), 0)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_sku, var_new_sku)))) {
			rt.call_method(rt.new_bool(var_product), 'set_sku', [
				var_new_sku.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			rt.call_method(rt.new_bool(var_product), 'save', []rt.PhpVal{})
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			var_e = var_e_1.clone()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
}

fn wc_product_generate_unique_sku(var_product_id rt.PhpVal, var_sku rt.PhpVal, index i64) rt.PhpVal {
	mut var_index := index
	mut var_generated_sku := rt.new_null()
	var_generated_sku = if 0 < index { var_sku.str() + '-' + index.str() } else { var_sku }
	if !(wc_product_has_unique_sku(var_product_id.clone(), var_generated_sku.clone())) {
		var_generated_sku = wc_product_generate_unique_sku(var_product_id.clone(), var_sku.clone(),

			index + 1)
	}
	return var_generated_sku.clone()
}

fn wc_get_product_id_by_sku(var_sku rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut iife_temp_12 := Class_WC_Data_Store{}
	mut iife_result_12 := iife_temp_12.load(rt.new_string('product'))
	var_data_store = iife_result_12
	return rt.call_method(var_data_store, 'get_product_id_by_sku', [
		var_sku.clone()])
}

fn wc_get_product_id_by_global_unique_id(var_global_unique_id rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut var_logger := rt.new_null()
	mut iife_temp_13 := Class_WC_Data_Store{}
	mut iife_result_13 := iife_temp_13.load(rt.new_string('product'))
	var_data_store = iife_result_13
	if rt.is_true(rt.call_method(var_data_store, 'has_callable', [
		rt.new_string('get_product_id_by_global_unique_id'),
	]))
	{
		return rt.call_method(var_data_store, 'get_product_id_by_global_unique_id', [
			var_global_unique_id.clone(),
		])
	} else {
		var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
		rt.call_method(var_logger, 'error', [
			rt.new_string('The method get_product_id_by_global_unique_id is not implemented in the data store.'),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc_get_product_id_by_global_unique_id' },
			]),
		])
	}
	return rt.new_null()
}

fn wc_get_product_variation_attributes(var_variation_id rt.PhpVal) rt.PhpVal {
	mut var_all_meta := rt.new_null()
	mut var_parent_id := rt.new_null()
	mut var_parent_attributes := rt.new_null()
	mut var_found_parent_attributes := []rt.PhpVal{}
	mut var_variation_attributes := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_attribute_name := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var_text_attributes := rt.new_null()
	mut var_text_attribute := rt.new_null()
	var_all_meta = if rt.call_function('get_post_meta', [var_variation_id.clone()]).is_array() { rt.call_function('get_post_meta', [
			var_variation_id.clone(),
		]) } else { rt.new_array() }
	var_parent_id = rt.call_function('wp_get_post_parent_id', [
		var_variation_id.clone()])
	var_parent_attributes = rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('get_post_meta', [var_parent_id.clone(),
			rt.new_string('_product_attributes'), rt.new_bool(true)])),
	])
	var_found_parent_attributes = rt.new_array()
	var_variation_attributes = rt.new_array()
	mut iter_9 := var_parent_attributes.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_options_shadow := item_9.val
		mut var_attribute_name_shadow := item_9.key
		if !(!rt.is_true(var_options_shadow['is_variation'])) {
			var_attribute = rt.new_string('attribute_' +
				(rt.call_function('sanitize_title', [var_attribute_name_shadow.clone()])).str())
			var_found_parent_attributes << var_attribute.clone()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_variation_attributes.clone().array_isset(var_attribute.clone())))))) {
				var_variation_attributes.array_set(var_attribute, '')
			}
		}
	}
	mut iter_10 := var_all_meta.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value_shadow := item_10.val
		mut var_name_shadow := item_10.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_name_shadow.clone(), rt.new_string('attribute_')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_name_shadow.clone(), rt.create_array_from_list(var_found_parent_attributes), rt.new_bool(true)]))))) {
			var_variation_attributes.array_unset(var_name_shadow)
			continue
		}
		if rt.is_true(rt.identical(rt.call_function('sanitize_title', [var_value_shadow.array_get(rt.new_int(0))]), var_value_shadow.array_get(rt.new_int(0))))
			&& rt.is_true(rt.call_function('version_compare', [rt.call_function('get_post_meta', [var_parent_id.clone(), rt.new_string('_product_version'), rt.new_bool(true)]), rt.new_string('2.4.0'), rt.new_string('<')])) {
			mut iter_11 := var_parent_attributes.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_attribute_shadow := item_11.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical('attribute_' +(rt.call_function('sanitize_title', [var_attribute_shadow.array_get(rt.new_string('name'))])).str(),
					var_name_shadow))))
				{
					continue
				}
				var_text_attributes = rt.call_function('wc_get_text_attributes', [
					var_attribute_shadow.array_get(rt.new_string('value')),
				])
				mut iter_12 := var_text_attributes.iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var_text_attribute_shadow := item_12.val
					if rt.is_true(rt.identical(rt.call_function('sanitize_title', [
						var_text_attribute_shadow.clone(),
					]), var_value_shadow.array_get(rt.new_int(0))))
					{
						var_value_shadow.array_set(0, var_text_attribute_shadow.clone())
						break
					}
				}
			}
		}
		var_variation_attributes.array_set(var_name_shadow,
			var_value_shadow.array_get(rt.new_int(0)))
	}
	return var_variation_attributes.clone()
}

fn wc_get_product_cat_ids(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_cats := rt.new_null()
	mut var_product_cat := rt.new_null()
	var_product_cats = wc_get_product_term_ids(var_product_id.clone(), 'product_cat')
	mut iter_13 := var_product_cats.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_product_cat_shadow := item_13.val
		var_product_cats = rt.call_function('array_merge', [var_product_cats.clone(),
			rt.call_function('get_ancestors', [var_product_cat_shadow.clone(),
				rt.new_string('product_cat')])])
	}
	return var_product_cats.clone()
}

fn wc_get_product_attachment_props(var_attachment_id rt.PhpVal, product bool) rt.PhpVal {
	mut var_product := product
	mut var_props := map[string]rt.PhpVal{}
	mut var_attachment := rt.new_null()
	mut var_alt_text := rt.new_null()
	mut var_full_size := rt.new_null()
	mut var_src := rt.new_null()
	mut var_gallery_thumbnail := rt.new_null()
	mut var_gallery_thumbnail_size := rt.new_null()
	mut var_thumbnail_size := rt.new_null()
	mut var_image_size := rt.new_null()
	var_props = {
		'title':   rt.new_string('')
		'caption': rt.new_string('')
		'url':     rt.new_string('')
		'alt':     rt.new_string('')
		'src':     rt.new_string('')
		'srcset':  rt.new_bool(false)
		'sizes':   rt.new_bool(false)
	}
	var_attachment = rt.call_function('get_post', [var_attachment_id.clone()])
	if rt.is_true(var_attachment)
		&& rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_attachment, 'post_type'))) {
		var_props['title'] = rt.call_function('wp_strip_all_tags', [
			rt.get_property(var_attachment, 'post_title'),
		])
		var_props['caption'] = rt.call_function('wp_strip_all_tags', [
			rt.get_property(var_attachment, 'post_excerpt'),
		])
		var_props['url'] = rt.call_function('wp_get_attachment_url', [
			var_attachment_id.clone()])
		var_alt_text = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [
				rt.call_function('get_post_meta', [var_attachment_id.clone(),
					rt.new_string('_wp_attachment_image_alt'),
					rt.new_bool(true)]),
			]) },
			rt.ArrayItem{ key: none, val: var_props['caption'] },
			rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [
				rt.get_property(var_attachment, 'post_title'),
			]) },
		])
		if var_product
			&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(product), 'WC_Product'))) {
			var_alt_text.array_push(rt.call_function('wp_strip_all_tags', [
				rt.call_function('get_the_title', [
					rt.call_method(rt.new_bool(product), 'get_id', []rt.PhpVal{}),
				]),
			]))
		}
		var_alt_text = rt.call_function('array_filter', [var_alt_text.clone()])
		var_props['alt'] = if rt.is_true(var_alt_text) { rt.call_function('reset', [
				var_alt_text.clone(),
			]) } else { rt.new_string('') }
		var_full_size = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_gallery_full_size'),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_thumbnails_large_size'),
				rt.new_string('full'),
			]),
		])
		var_src = rt.call_function('wp_get_attachment_image_src', [
			var_attachment_id.clone(), var_full_size.clone()])
		var_props['full_src'] = if !(var_src.array_get(rt.new_int(0))).is_null() {
			var_src.array_get(rt.new_int(0))
		} else {
			rt.new_null()
		}
		var_props['full_src_w'] = if !(var_src.array_get(rt.new_int(1))).is_null() {
			var_src.array_get(rt.new_int(1))
		} else {
			rt.new_null()
		}
		var_props['full_src_h'] = if !(var_src.array_get(rt.new_int(2))).is_null() {
			var_src.array_get(rt.new_int(2))
		} else {
			rt.new_null()
		}
		var_gallery_thumbnail = rt.call_function('wc_get_image_size', [
			rt.new_string('gallery_thumbnail'),
		])
		var_gallery_thumbnail_size = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_gallery_thumbnail_size'),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_gallery_thumbnail.array_get(rt.new_string('width'))
				},
				rt.ArrayItem{
					key: none
					val: var_gallery_thumbnail.array_get(rt.new_string('height'))
				},
			]),
		])
		var_src = rt.call_function('wp_get_attachment_image_src', [
			var_attachment_id.clone(), var_gallery_thumbnail_size.clone()])
		var_props['gallery_thumbnail_src'] = if !(var_src.array_get(rt.new_int(0))).is_null() {
			var_src.array_get(rt.new_int(0))
		} else {
			rt.new_null()
		}
		var_props['gallery_thumbnail_src_w'] = if !(var_src.array_get(rt.new_int(1))).is_null() {
			var_src.array_get(rt.new_int(1))
		} else {
			rt.new_null()
		}
		var_props['gallery_thumbnail_src_h'] = if !(var_src.array_get(rt.new_int(2))).is_null() {
			var_src.array_get(rt.new_int(2))
		} else {
			rt.new_null()
		}
		var_thumbnail_size = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_thumbnail_size'),
			rt.new_string('woocommerce_thumbnail'),
		])
		var_src = rt.call_function('wp_get_attachment_image_src', [
			var_attachment_id.clone(), var_thumbnail_size.clone()])
		var_props['thumb_src'] = if !(var_src.array_get(rt.new_int(0))).is_null() {
			var_src.array_get(rt.new_int(0))
		} else {
			rt.new_null()
		}
		var_props['thumb_src_w'] = if !(var_src.array_get(rt.new_int(1))).is_null() {
			var_src.array_get(rt.new_int(1))
		} else {
			rt.new_null()
		}
		var_props['thumb_src_h'] = if !(var_src.array_get(rt.new_int(2))).is_null() {
			var_src.array_get(rt.new_int(2))
		} else {
			rt.new_null()
		}
		var_image_size = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_gallery_image_size'),
			rt.new_string('woocommerce_single'),
		])
		var_src = rt.call_function('wp_get_attachment_image_src', [
			var_attachment_id.clone(), var_image_size.clone()])
		var_props['src'] = if !(var_src.array_get(rt.new_int(0))).is_null() {
			var_src.array_get(rt.new_int(0))
		} else {
			rt.new_null()
		}
		var_props['src_w'] = if !(var_src.array_get(rt.new_int(1))).is_null() {
			var_src.array_get(rt.new_int(1))
		} else {
			rt.new_null()
		}
		var_props['src_h'] = if !(var_src.array_get(rt.new_int(2))).is_null() {
			var_src.array_get(rt.new_int(2))
		} else {
			rt.new_null()
		}
		var_props['srcset'] = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_srcset'),
		]))
		{ rt.call_function('wp_get_attachment_image_srcset', [
				var_attachment_id.clone(), var_image_size.clone()]) } else { rt.new_bool(false) }
		var_props['sizes'] = if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_get_attachment_image_sizes'),
		]))
		{ rt.call_function('wp_get_attachment_image_sizes', [
				var_attachment_id.clone(), var_image_size.clone()]) } else { rt.new_bool(false) }
	}
	return var_props.clone()
}

fn wc_get_product_visibility_options() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_visibility_options'),
		rt.create_array([
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), val: rt.call_function('__', [
				rt.new_string('Shop and search results'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog(), val: rt.call_function('__', [
				rt.new_string('Shop only'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.search(), val: rt.call_function('__', [
				rt.new_string('Search results only'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden(), val: rt.call_function('__', [
				rt.new_string('Hidden'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
}

fn wc_get_product_tax_class_options() rt.PhpVal {
	mut var_tax_classes := rt.new_null()
	mut var_tax_class_options := rt.new_null()
	mut var_class := rt.new_null()
	mut iife_temp_14 := Class_WC_Tax{}
	mut iife_result_14 := iife_temp_14.get_tax_classes()
	var_tax_classes = iife_result_14
	var_tax_class_options = rt.new_array()
	var_tax_class_options.array_set('', rt.call_function('__', [
		rt.new_string('Standard'),
		rt.new_string('woocommerce'),
	]))
	if !(!rt.is_true(var_tax_classes)) {
		mut iter_14 := var_tax_classes.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_class_shadow := item_14.val
			var_tax_class_options.array_set(rt.call_function('sanitize_title', [
				var_class_shadow.clone(),
			]), var_class_shadow.clone())
		}
	}
	return var_tax_class_options.clone()
}

fn wc_get_product_stock_status_options() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_stock_status_options'),
		rt.create_array([
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(), val: rt.call_function('__', [
				rt.new_string('In stock'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()
				val: rt.call_function('__', [
					rt.new_string('Out of stock'),
					rt.new_string('woocommerce'),
				])
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder()
				val: rt.call_function('__', [
					rt.new_string('On backorder'),
					rt.new_string('woocommerce'),
				])
			},
		]),
	])
}

fn wc_get_product_backorder_options() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'no', val: rt.call_function('__', [
			rt.new_string('Do not allow'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'notify', val: rt.call_function('__', [
			rt.new_string('Allow, but notify customer'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'yes', val: rt.call_function('__', [
			rt.new_string('Allow'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn wc_get_related_products(var_product_id_arg rt.PhpVal, limit i64, var_exclude_ids_arg rt.PhpVal, var_related_by rt.PhpVal) rt.PhpVal {
	mut var_limit := limit
	mut var_product_id := var_product_id_arg
	mut var_exclude_ids := var_exclude_ids_arg
	mut var_transient_name := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_transient := rt.new_null()
	mut var_related_posts := rt.new_null()
	mut var_cats_array := rt.new_null()
	mut var_tags_array := rt.new_null()
	mut var_data_store := rt.new_null()
	if !(rt.new_int(var_limit).is_long()) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [
				rt.new_string('Invalid limit type passed to wc_get_related_products. Expected integer, got %s with value: %s'),
				rt.call_function('gettype', [rt.new_int(var_limit)]),
				rt.call_function('wp_json_encode', [rt.new_int(var_limit)]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'wc_get_related_products' },
			]),
		])
	}
	var_limit = (if rt.new_int(var_limit).is_long() || rt.new_int(var_limit).is_double() {
		var_limit
	} else {
		rt.new_null()
	}).to_i64()
	if rt.is_true(rt.identical(rt.new_null(), rt.new_int(var_limit))) {
		return rt.new_array()
	}
	var_product_id = rt.call_function('absint', [var_product_id.clone()])
	var_limit = if var_limit >= -1 { var_limit } else { 5 }
	var_exclude_ids = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{
			key: none
			val: var_product_id
		}]),
		var_exclude_ids.clone(),
	])
	var_transient_name = rt.new_string('wc_related_' + var_product_id.str())
	var_query_args = rt.call_function('http_build_query', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: var_limit },
			rt.ArrayItem{ key: 'exclude_ids', val: var_exclude_ids },
			rt.ArrayItem{ key: 'related_by', val: var_related_by }]),
	])
	var_transient = rt.call_function('get_transient', [var_transient_name.clone()])
	var_related_posts = if rt.is_true(var_transient) && var_transient.clone().is_array()
		&& var_transient.array_isset(var_query_args) {
		var_transient.array_get(var_query_args)
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_related_posts))
		|| var_related_posts.clone().array_count() < var_limit {
		var_cats_array = if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_related_posts_relate_by_category'),
			rt.new_bool(true),
			var_product_id.clone(),
		]))
		{ rt.call_function('apply_filters', [
				rt.new_string('woocommerce_get_related_product_cat_terms'),
				wc_get_product_term_ids(var_product_id.clone(), 'product_cat'),
				var_product_id.clone(),
			]) } else { rt.new_array() }
		var_tags_array = if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_related_posts_relate_by_tag'),
			rt.new_bool(true),
			var_product_id.clone(),
		]))
		{ rt.call_function('apply_filters', [
				rt.new_string('woocommerce_get_related_product_tag_terms'),
				wc_get_product_term_ids(var_product_id.clone(), 'product_tag'),
				var_product_id.clone(),
			]) } else { rt.new_array() }
		if !rt.is_true(var_cats_array) && !rt.is_true(var_tags_array)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_related_posts_force_display'), rt.new_bool(false), var_product_id.clone()]))))) {
			var_related_posts = rt.new_array()
		} else {
			mut iife_temp_15 := Class_WC_Data_Store{}
			mut iife_result_15 := iife_temp_15.load(rt.new_string('product'))
			var_data_store = iife_result_15
			var_related_posts = rt.call_method(var_data_store, 'get_related_products', [
				var_cats_array.clone(),
				var_tags_array.clone(),
				var_exclude_ids.clone(),
				rt.new_int(var_limit + 10),
				var_product_id.clone(),
			])
		}
		if rt.is_true(var_transient) && var_transient.clone().is_array() {
			var_transient.array_set(var_query_args, var_related_posts.clone())
		} else {
			var_transient = rt.create_array([
				rt.ArrayItem{ key: var_query_args, val: var_related_posts },
			])
		}
		rt.call_function('set_transient', [var_transient_name.clone(),
			var_transient.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	var_related_posts = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_related_products'),
		var_related_posts.clone(),
		var_product_id.clone(),
		rt.create_array([rt.ArrayItem{ key: 'limit', val: var_limit },
			rt.ArrayItem{ key: 'excluded_ids', val: var_exclude_ids }]),
	])
	var_related_posts = if var_related_posts.clone().is_array() {
		var_related_posts
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_related_posts_shuffle'),
		rt.new_bool(true),
	]))
	{
		rt.call_function('shuffle', [var_related_posts.clone()])
	}
	return rt.call_function('array_slice', [var_related_posts.clone(),
		rt.new_int(0), rt.new_int(var_limit)])
}

fn wc_get_product_term_ids(var_product_id rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_terms := rt.new_null()
	var_terms = rt.call_function('get_the_terms', [var_product_id.clone(),
		rt.new_string(taxonomy)])
	return if !rt.is_true(var_terms) || rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) { rt.new_array() } else { rt.call_function('wp_list_pluck', [
			var_terms.clone(),
			rt.new_string('term_id'),
		]) }
}

fn wc_get_price_including_tax(var_product rt.PhpVal, var_args_arg rt.PhpVal) f64 {
	mut var_args := var_args_arg
	mut var_price := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_line_price := rt.new_null()
	mut var_return_price := rt.new_null()
	mut var_taxes_total := rt.new_null()
	mut var_tax_rates := rt.new_null()
	mut var_taxes := rt.new_null()
	mut var_base_tax_rates := rt.new_null()
	mut var_remove_taxes := rt.new_null()
	mut var_remove_taxes_total := rt.new_null()
	mut var_base_taxes := rt.new_null()
	mut var_modded_taxes := rt.new_null()
	mut var_base_taxes_total := rt.new_null()
	mut var_modded_taxes_total := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: '' },
			rt.ArrayItem{ key: 'price', val: '' }])])
	var_price = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_args.array_get(rt.new_string('price'))))))
	{
		rt.call_function('max', [rt.new_float(0),
			rt.new_float((var_args.array_get(rt.new_string('price'))).to_f64())])
	} else {
		rt.new_float((rt.call_method(var_product, 'get_price', []rt.PhpVal{})).to_f64())
	}
	var_qty = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('qty')))))) { rt.call_function('max', [
			rt.new_float(0),
			rt.new_float((var_args.array_get(rt.new_string('qty'))).to_f64()),
		]) } else { rt.new_int(1) }
	if !rt.is_true(var_qty) {
		return 0
	}
	var_line_price = rt.mul(var_price, var_qty)
	var_return_price = var_line_price.clone()
	if rt.is_true(rt.call_method(var_product, 'is_taxable', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax',
			[]rt.PhpVal{})))))
		{
			if !(!rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')))
				&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_is_vat_exempt', []rt.PhpVal{})) {
				var_taxes_total = rt.new_float(0)
			} else {
				mut iife_temp_16 := Class_WC_Tax{}
				mut iife_result_16 := iife_temp_16.get_rates(rt.call_method(var_product,
					'get_tax_class', []rt.PhpVal{}))
				var_tax_rates = iife_result_16
				mut iife_temp_17 := Class_WC_Tax{}
				mut iife_result_17 := iife_temp_17.calc_tax(var_line_price.clone(),
					var_tax_rates.clone(), rt.new_bool(false))
				var_taxes = iife_result_17
				if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
					rt.new_string('woocommerce_tax_round_at_subtotal'),
				])))
				{
					var_taxes_total = rt.call_function('array_sum', [
						var_taxes.clone()])
				} else {
					var_taxes_total = rt.call_function('array_sum', [
						rt.call_function('array_map', [
							rt.new_string('wc_round_tax_total'),
							var_taxes.clone(),
						]),
					])
				}
			}
			mut iife_temp_18 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_18 := iife_temp_18.round(rt.add(var_line_price, var_taxes_total), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}))
			var_return_price = iife_result_18
		} else {
			mut iife_temp_19 := Class_WC_Tax{}
			mut iife_result_19 := iife_temp_19.get_rates(rt.call_method(var_product,
				'get_tax_class', []rt.PhpVal{}))
			var_tax_rates = iife_result_19
			mut iife_temp_20 := Class_WC_Tax{}
			mut iife_result_20 := iife_temp_20.get_base_tax_rates(rt.call_method(var_product,
				'get_tax_class', [rt.new_string('unfiltered')]))
			var_base_tax_rates = iife_result_20
			if !(!rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')))
				&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_is_vat_exempt', []rt.PhpVal{})) {
				mut iife_temp_21 := Class_WC_Tax{}
				mut iife_result_21 := iife_temp_21.calc_tax(var_line_price.clone(),
					var_base_tax_rates.clone(), rt.new_bool(true))
				mut iife_temp_22 := Class_WC_Tax{}
				mut iife_result_22 := iife_temp_22.calc_tax(var_line_price.clone(),
					var_tax_rates.clone(), rt.new_bool(true))
				var_remove_taxes = if rt.is_true(rt.call_function('apply_filters', [
					rt.new_string('woocommerce_adjust_non_base_location_prices'),
					rt.new_bool(true),
				]))
				{ iife_result_21 } else { iife_result_22 }
				if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
					rt.new_string('woocommerce_tax_round_at_subtotal'),
				])))
				{
					var_remove_taxes_total = rt.call_function('array_sum', [
						var_remove_taxes.clone()])
				} else {
					var_remove_taxes_total = rt.call_function('array_sum', [
						rt.call_function('array_map', [
							rt.new_string('wc_round_tax_total'),
							var_remove_taxes.clone(),
						]),
					])
				}
				mut iife_temp_23 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_23 := iife_temp_23.round(rt.sub(var_line_price,
					var_remove_taxes_total), rt.call_function('wc_get_price_decimals',
					[]rt.PhpVal{}))
				var_return_price = iife_result_23
			} else if
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tax_rates, var_base_tax_rates))))
				&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_adjust_non_base_location_prices'), rt.new_bool(true)])) {
				mut iife_temp_24 := Class_WC_Tax{}
				mut iife_result_24 := iife_temp_24.calc_tax(var_line_price.clone(),
					var_base_tax_rates.clone(), rt.new_bool(true))
				var_base_taxes = iife_result_24
				mut iife_temp_25 := Class_WC_Tax{}
				mut iife_result_25 := iife_temp_25.calc_tax(rt.sub(var_line_price, rt.call_function('array_sum', [
					var_base_taxes.clone(),
				])), var_tax_rates.clone(), rt.new_bool(false))
				var_modded_taxes = iife_result_25
				if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
					rt.new_string('woocommerce_tax_round_at_subtotal'),
				])))
				{
					var_base_taxes_total = rt.call_function('array_sum', [
						var_base_taxes.clone()])
					var_modded_taxes_total = rt.call_function('array_sum', [
						var_modded_taxes.clone()])
				} else {
					var_base_taxes_total = rt.call_function('array_sum', [
						rt.call_function('array_map', [
							rt.new_string('wc_round_tax_total'),
							var_base_taxes.clone(),
						]),
					])
					var_modded_taxes_total = rt.call_function('array_sum', [
						rt.call_function('array_map', [
							rt.new_string('wc_round_tax_total'),
							var_modded_taxes.clone(),
						]),
					])
				}
				mut iife_temp_26 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_26 := iife_temp_26.round(rt.add(rt.sub(var_line_price,
					var_base_taxes_total), var_modded_taxes_total), rt.call_function('wc_get_price_decimals',
					[]rt.PhpVal{}))
				var_return_price = iife_result_26
			}
		}
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_price_including_tax'),
		var_return_price.clone(),
		var_qty.clone(),
		var_product.clone(),
	])).to_f64()
}

fn wc_get_price_excluding_tax(var_product rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_price := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_line_price := rt.new_null()
	mut var_order := rt.new_null()
	mut var_customer_id := rt.new_null()
	mut var_tax_rates := rt.new_null()
	mut var_customer := rt.new_null()
	mut var_tax_location := rt.new_null()
	mut var_remove_taxes := rt.new_null()
	mut var_return_price := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return rt.new_string('')
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: '' },
			rt.ArrayItem{ key: 'price', val: '' }])])
	var_price = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_args.array_get(rt.new_string('price'))))))
	{
		rt.call_function('max', [rt.new_float(0),
			rt.new_float((var_args.array_get(rt.new_string('price'))).to_f64())])
	} else {
		rt.new_float((rt.call_method(var_product, 'get_price', []rt.PhpVal{})).to_f64())
	}
	var_qty = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('qty')))))) { rt.call_function('max', [
			rt.new_float(0),
			rt.new_float((var_args.array_get(rt.new_string('qty'))).to_f64()),
		]) } else { rt.new_int(1) }
	if !rt.is_true(var_qty) {
		return rt.new_float(0)
	}
	var_line_price = rt.mul(var_price, var_qty)
	if rt.is_true(rt.call_method(var_product, 'is_taxable', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
		mut iife_temp_27 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_27 := iife_temp_27.get_value_or_default(var_args.clone(),
			rt.new_string('order'))
		var_order = iife_result_27
		var_customer_id = if rt.is_true(var_order) {
			rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})
		} else {
			rt.new_int(0)
		}
		var_tax_rates = rt.new_bool(false)
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_adjust_non_base_location_prices'),
			rt.new_bool(true),
		]))
		{
			mut iife_temp_28 := Class_WC_Tax{}
			mut iife_result_28 := iife_temp_28.get_base_tax_rates(rt.call_method(var_product,
				'get_tax_class', [rt.new_string('unfiltered')]))
			var_tax_rates = iife_result_28
		} else if rt.is_true(var_customer_id) {
			var_customer = rt.call_method(rt.call_method(rt.call_function('wc_get_container',
				[]rt.PhpVal{}), 'get', [
				Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
			]), 'get_instance_of', [Class_WC_Customer.class(),
				var_customer_id.clone()])
			mut iife_temp_29 := Class_WC_Tax{}
			mut iife_result_29 := iife_temp_29.get_rates(rt.call_method(var_product,
				'get_tax_class', []rt.PhpVal{}), var_customer.clone())
			var_tax_rates = iife_result_29
		} else if var_order.clone().is_object()
			&& rt.is_true(rt.call_function('method_exists', [var_order.clone(), rt.new_string('get_taxable_location')])) {
			var_tax_location = rt.call_method(var_order, 'get_taxable_location', []rt.PhpVal{})
			if var_tax_location.clone().is_array()
				&& var_tax_location.array_isset(rt.new_string('country')) {
				mut iife_temp_30 := Class_WC_Tax{}
				mut iife_result_30 := iife_temp_30.find_rates(rt.create_array([
					rt.ArrayItem{
						key: 'country'
						val: var_tax_location.array_get(rt.new_string('country'))
					},
					rt.ArrayItem{
						key: 'state'
						val: if !(var_tax_location.array_get(rt.new_string('state'))).is_null() {
							var_tax_location.array_get(rt.new_string('state'))
						} else {
							rt.new_string('')
						}
					},
					rt.ArrayItem{
						key: 'postcode'
						val: if !(var_tax_location.array_get(rt.new_string('postcode'))).is_null() {
							var_tax_location.array_get(rt.new_string('postcode'))
						} else {
							rt.new_string('')
						}
					},
					rt.ArrayItem{
						key: 'city'
						val: if !(var_tax_location.array_get(rt.new_string('city'))).is_null() {
							var_tax_location.array_get(rt.new_string('city'))
						} else {
							rt.new_string('')
						}
					},
					rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_product,
						'get_tax_class', []rt.PhpVal{}) },
				]))
				var_tax_rates = iife_result_30
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_tax_rates)) {
			mut iife_temp_31 := Class_WC_Tax{}
			mut iife_result_31 := iife_temp_31.get_rates(rt.call_method(var_product,
				'get_tax_class', []rt.PhpVal{}), rt.new_null())
			var_tax_rates = iife_result_31
		}
		mut iife_temp_32 := Class_WC_Tax{}
		mut iife_result_32 := iife_temp_32.calc_tax(var_line_price.clone(), var_tax_rates.clone(),
			rt.new_bool(true))
		var_remove_taxes = iife_result_32
		var_return_price = rt.sub(var_line_price, rt.call_function('array_sum', [
			var_remove_taxes.clone(),
		]))
	} else {
		var_return_price = var_line_price.clone()
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_price_excluding_tax'),
		var_return_price.clone(),
		var_qty.clone(),
		var_product.clone(),
	])
}

fn wc_get_price_to_display(var_product rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_price := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_tax_display := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'qty', val: 1 }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_product,
			'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'display_context', val: 'shop' }])])
	var_price = var_args.array_get(rt.new_string('price'))
	var_qty = var_args.array_get(rt.new_string('qty'))
	var_tax_display = rt.call_function('get_option', [
		rt.new_string((if rt.is_true(rt.identical(rt.new_string('cart'),
			var_args.array_get(rt.new_string('display_context'))))
		{
			'woocommerce_tax_display_cart'
		} else {
			'woocommerce_tax_display_shop'
		}).str()),
	])
	return if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display)) { rt.new_float(wc_get_price_including_tax(var_product.clone(), rt.create_array([
			rt.ArrayItem{ key: 'qty', val: var_qty },
			rt.ArrayItem{ key: 'price', val: var_price },
		]))) } else { wc_get_price_excluding_tax(var_product.clone(), rt.create_array([
			rt.ArrayItem{ key: 'qty', val: var_qty },
			rt.ArrayItem{ key: 'price', val: var_price },
		])) }
}

fn wc_get_product_category_list(var_product_id rt.PhpVal, sep string, before string, after string) rt.PhpVal {
	mut var_sep := sep
	mut var_before := before
	mut var_after := after
	return rt.call_function('get_the_term_list', [var_product_id.clone(),
		rt.new_string('product_cat'), rt.new_string(before), rt.new_string(sep),
		rt.new_string(after)])
}

fn wc_get_product_tag_list(var_product_id rt.PhpVal, sep string, before string, after string) rt.PhpVal {
	mut var_sep := sep
	mut var_before := before
	mut var_after := after
	return rt.call_function('get_the_term_list', [var_product_id.clone(),
		rt.new_string('product_tag'), rt.new_string(before), rt.new_string(sep),
		rt.new_string(after)])
}

fn wc_products_array_filter_visible(var_product rt.PhpVal) bool {
	return rt.is_true(var_product)
		&& rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')]))
		&& rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{}))
}

fn wc_products_array_filter_visible_grouped(var_product rt.PhpVal) bool {
	return rt.is_true(var_product)
		&& rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')]))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.call_method(var_product, 'get_status', []rt.PhpVal{})))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_product'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))
}

fn wc_products_array_filter_editable(var_product rt.PhpVal) bool {
	return rt.is_true(var_product)
		&& rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_product'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))
}

fn wc_products_array_filter_readable(var_product rt.PhpVal) bool {
	return rt.is_true(var_product)
		&& rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_product'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))
}

fn wc_products_array_orderby(var_products_arg rt.PhpVal, orderby string, order string) rt.PhpVal {
	mut var_orderby := orderby
	mut var_order := order
	mut var_products := var_products_arg
	var_orderby = var_orderby.to_lower()
	var_order = var_order.to_lower()
	mut switch_val_1 := rt.new_string(var_orderby.str())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('title')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('id')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('date')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('modified')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('menu_order')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('price'))) {
		rt.call_function('usort', [var_products.clone(),
			rt.new_string('wc_products_array_orderby_' + var_orderby)])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('none'))) {
	} else {
		rt.call_function('shuffle', [var_products.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('desc'), rt.new_string(var_order.str()))) {
		var_products = rt.call_function('array_reverse', [var_products.clone()])
	}
	return var_products.clone()
}

fn wc_products_array_orderby_title(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strcasecmp', [
		rt.call_method(var_a, 'get_name', []rt.PhpVal{}),
		rt.call_method(var_b, 'get_name', []rt.PhpVal{}),
	])
}

fn wc_products_array_orderby_id(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.call_method(var_a, 'get_id', []rt.PhpVal{}), rt.call_method(var_b,
		'get_id', []rt.PhpVal{})))
	{
		return 0
	}
	return if rt.is_true(rt.less(rt.call_method(var_a, 'get_id', []rt.PhpVal{}), rt.call_method(var_b,
		'get_id', []rt.PhpVal{})))
	{
		-1
	} else {
		1
	}
}

fn wc_products_array_orderby_date(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.call_method(var_a, 'get_date_created', []rt.PhpVal{}), rt.call_method(var_b,
		'get_date_created', []rt.PhpVal{})))
	{
		return 0
	}
	return if rt.is_true(rt.less(rt.call_method(var_a, 'get_date_created', []rt.PhpVal{}), rt.call_method(var_b,
		'get_date_created', []rt.PhpVal{})))
	{
		-1
	} else {
		1
	}
}

fn wc_products_array_orderby_modified(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.call_method(var_a, 'get_date_modified', []rt.PhpVal{}), rt.call_method(var_b,
		'get_date_modified', []rt.PhpVal{})))
	{
		return 0
	}
	return if rt.is_true(rt.less(rt.call_method(var_a, 'get_date_modified', []rt.PhpVal{}), rt.call_method(var_b,
		'get_date_modified', []rt.PhpVal{})))
	{
		-1
	} else {
		1
	}
}

fn wc_products_array_orderby_menu_order(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.call_method(var_a, 'get_menu_order', []rt.PhpVal{}), rt.call_method(var_b,
		'get_menu_order', []rt.PhpVal{})))
	{
		return 0
	}
	return if rt.is_true(rt.less(rt.call_method(var_a, 'get_menu_order', []rt.PhpVal{}), rt.call_method(var_b,
		'get_menu_order', []rt.PhpVal{})))
	{
		-1
	} else {
		1
	}
}

fn wc_products_array_orderby_price(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.call_method(var_a, 'get_price', []rt.PhpVal{}), rt.call_method(var_b,
		'get_price', []rt.PhpVal{})))
	{
		return 0
	}
	return if rt.is_true(rt.less(rt.call_method(var_a, 'get_price', []rt.PhpVal{}), rt.call_method(var_b,
		'get_price', []rt.PhpVal{})))
	{
		-1
	} else {
		1
	}
}

fn wc_deferred_product_sync(var_product_id rt.PhpVal) {
	mut var_wc_deferred_product_sync := []rt.PhpVal{}
	if !rt.is_true(var_wc_deferred_product_sync) {
		var_wc_deferred_product_sync = rt.new_array()
	}
	var_wc_deferred_product_sync << var_product_id.clone()
}

fn wc_update_product_lookup_tables_is_running() bool {
	mut var_table_updates_pending := rt.new_null()
	var_table_updates_pending = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'queue', []rt.PhpVal{}), 'search', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: 'pending' },
			rt.ArrayItem{ key: 'group', val: 'wc_update_product_lookup_tables' },
			rt.ArrayItem{ key: 'per_page', val: 1 }]),
	])
	return (rt.new_int(var_table_updates_pending.clone().array_count())).to_bool()
}

fn wc_update_product_lookup_tables() {
	mut var_wpdb := rt.new_null()
	mut var_is_cli := rt.new_null()
	mut var_columns := []rt.PhpVal{}
	mut var_column := rt.new_null()
	mut var_index := rt.new_null()
	mut var_rating_count_rows := rt.new_null()
	mut iife_temp_33 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_33 := iife_temp_33.is_true(rt.new_string('WP_CLI'))
	var_is_cli = iife_result_33
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_cli)))) {
		mut iife_temp_34 := Class_WC_Admin_Notices{}
		mut iife_result_34 := iife_temp_34.add_notice(rt.new_string('regenerating_lookup_table'))
	}
	rt.call_function('update_option', [
		rt.new_string('woocommerce_product_lookup_table_is_generating'),
		rt.new_bool(true),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\tINSERT IGNORE INTO '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')),
			rt.new_string(' (`product_id`)\n\t\tSELECT\n\t\t\tposts.ID\n\t\tFROM ')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(" posts\n\t\tWHERE\n\t\t\tposts.post_type IN ('product', 'product_variation')\n\t\t")),
	])
	var_columns = ['min_max_price', 'stock_quantity', 'sku', 'global_unique_id', 'stock_status',
		'average_rating', 'total_sales', 'downloadable', 'virtual', 'onsale', 'tax_class',
		'tax_status']
	for var_index_shadow, var_column_shadow in var_columns {
		if rt.is_true(var_is_cli) {
			wc_update_product_lookup_tables_column(rt.new_string(var_column_shadow.str()).clone())
		} else {
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'schedule_single', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(var_index_shadow)),
				rt.new_string('wc_update_product_lookup_tables_column'),
				rt.create_array([
					rt.ArrayItem{ key: 'column', val: rt.new_string(var_column_shadow.str()) },
				]),
				rt.new_string('wc_update_product_lookup_tables'),
			])
		}
	}
	if rt.is_true(var_is_cli) {
		var_rating_count_rows = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT post_id, meta_value FROM '), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string("\n\t\t\tWHERE meta_key = '_wc_rating_count'\n\t\t\tAND meta_value != ''\n\t\t\tAND meta_value != 'a:0:{}'\n\t\t\t")),
			rt.get_constant('ARRAY_A'),
		])
		wc_update_product_lookup_tables_rating_count(var_rating_count_rows.clone())
	} else {
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
			'schedule_single', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)),
			rt.new_string('wc_update_product_lookup_tables_rating_count_batch'),
			rt.create_array([rt.ArrayItem{ key: 'offset', val: 0 },
				rt.ArrayItem{ key: 'limit', val: 50 }]),
			rt.new_string('wc_update_product_lookup_tables'),
		])
	}
}

fn wc_update_product_lookup_tables_column(var_column_arg rt.PhpVal) {
	mut var_column := var_column_arg
	mut var_wpdb := rt.new_null()
	mut var_meta_key := rt.new_null()
	mut var_decimals := rt.new_null()
	if !rt.is_true(var_column) {
		return
	}
	mut switch_val_2 := var_column
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('min_max_price'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tUPDATE\n\t\t\t\t\t'), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(' lookup_table\n\t\t\t\t\tINNER JOIN (\n\t\t\t\t\t\tSELECT lookup_table.product_id, MIN( meta_value+0 ) as min_price, MAX( meta_value+0 ) as max_price\n\t\t\t\t\t\tFROM ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')), rt.new_string(' lookup_table\n\t\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" meta1 ON lookup_table.product_id = meta1.post_id AND meta1.meta_key = '_price'\n\t\t\t\t\t\tWHERE\n\t\t\t\t\t\t\tmeta1.meta_value <> ''\n\t\t\t\t\t\tGROUP BY lookup_table.product_id\n\t\t\t\t\t) as source on source.product_id = lookup_table.product_id\n\t\t\t\tSET\n\t\t\t\t\tlookup_table.min_price = source.min_price,\n\t\t\t\t\tlookup_table.max_price = source.max_price\n\t\t\t\t")),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('stock_quantity'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tUPDATE\n\t\t\t\t\t'), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')), rt.new_string(' lookup_table\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" meta1 ON lookup_table.product_id = meta1.post_id AND meta1.meta_key = '_manage_stock'\n\t\t\t\t\tLEFT JOIN ")), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" meta2 ON lookup_table.product_id = meta2.post_id AND meta2.meta_key = '_stock'\n\t\t\t\tSET\n\t\t\t\t\tlookup_table.stock_quantity = meta2.meta_value\n\t\t\t\tWHERE\n\t\t\t\t\tmeta1.meta_value = 'yes'\n\t\t\t\t")),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('sku')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('global_unique_id')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('stock_status')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('average_rating')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('total_sales')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('tax_class')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('tax_status'))) {
		if rt.is_true(rt.identical(rt.new_string('total_sales'), var_column)) {
			var_meta_key = rt.new_string('total_sales')
		} else if rt.is_true(rt.identical(rt.new_string('average_rating'), var_column)) {
			var_meta_key = rt.new_string('_wc_average_rating')
		} else {
			var_meta_key = rt.new_string('_' + var_column.str())
		}
		var_column = rt.call_function('esc_sql', [var_column.clone()])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tUPDATE\n\t\t\t\t\t\t'), rt.get_property(var_wpdb,
					'wc_product_meta_lookup')),
					rt.new_string(' lookup_table\n\t\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string(' meta ON lookup_table.product_id = meta.post_id AND meta.meta_key = %s\n\t\t\t\t\tSET\n\t\t\t\t\t\tlookup_table.`')),
					var_column), rt.new_string('` = meta.meta_value\n\t\t\t\t\t')),
				var_meta_key.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('downloadable')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('virtual'))) {
		var_column = rt.call_function('esc_sql', [var_column.clone()])
		var_meta_key = rt.new_string('_' + var_column.str())
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tUPDATE\n\t\t\t\t\t\t'), rt.get_property(var_wpdb,
					'wc_product_meta_lookup')),
					rt.new_string(' lookup_table\n\t\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string(' meta1 ON lookup_table.product_id = meta1.post_id AND meta1.meta_key = %s\n\t\t\t\t\tSET\n\t\t\t\t\t\tlookup_table.`')),
					var_column),
					rt.new_string("` = IF ( meta1.meta_value = 'yes', 1, 0 )\n\t\t\t\t\t")),
				var_meta_key.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('onsale'))) {
		var_column = rt.call_function('esc_sql', [var_column.clone()])
		var_decimals = rt.call_function('absint', [
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tUPDATE\n\t\t\t\t\t\t'), rt.get_property(var_wpdb,
					'wc_product_meta_lookup')),
					rt.new_string(' lookup_table\n\t\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string(" meta1 ON lookup_table.product_id = meta1.post_id AND meta1.meta_key = '_price'\n\t\t\t\t\t\tLEFT JOIN ")), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string(" meta2 ON lookup_table.product_id = meta2.post_id AND meta2.meta_key = '_sale_price'\n\t  \t\t\t\t\tLEFT JOIN ")), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string(" meta3 ON lookup_table.product_id = meta3.post_id AND meta3.meta_key = '_regular_price'\n\t\t\t\t\tSET\n\t\t\t\t\t\tlookup_table.`")),
					var_column),
					rt.new_string("` = IF (\n\t\t\t\t\t\t\tCAST( meta1.meta_value AS DECIMAL ) >= 0\n\t\t\t\t\t\t\tAND CAST( meta2.meta_value AS CHAR ) != ''\n\t\t\t\t\t\t\tAND CAST( meta1.meta_value AS DECIMAL( 10, %d ) ) = CAST( meta2.meta_value AS DECIMAL( 10, %d ) )\n\t\t\t\t\t\t\tAND CAST( meta3.meta_value AS DECIMAL( 10, %d ) ) > CAST( meta2.meta_value AS DECIMAL( 10, %d ) )\n\t\t\t\t\t\t, 1, 0 )\n\t\t\t\t\t")),
				var_decimals.clone(),
				var_decimals.clone(),
				var_decimals.clone(),
				var_decimals.clone(),
			]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('tax_status'), var_column)) {
		rt.call_function('delete_option', [
			rt.new_string('woocommerce_product_lookup_table_is_generating'),
		])
	}
}

fn wc_update_product_lookup_tables_rating_count(var_rows rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_row := map[string]rt.PhpVal{}
	mut var_count := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rows)))) || !(var_rows.clone().is_array()) {
		return
	}
	mut iter_15 := var_rows.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_row_shadow := item_15.val
		var_count = rt.call_function('array_sum', [
			rt.cast_array(rt.call_function('maybe_unserialize', [var_row_shadow['meta_value']])),
		])
		rt.call_method(var_wpdb, 'update', [
			rt.get_property(var_wpdb, 'wc_product_meta_lookup'),
			rt.create_array([
				rt.ArrayItem{ key: 'rating_count', val: rt.call_function('absint', [
					var_count.clone(),
				]) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.call_function('absint', [
					var_row_shadow['post_id'],
				]) },
			]),
		])
	}
}

fn wc_update_product_lookup_tables_rating_count_batch(offset i64, limit i64) {
	mut var_offset := offset
	mut var_limit := limit
	mut var_wpdb := rt.new_null()
	mut var_rating_count_rows := rt.new_null()
	if !(var_limit != 0) {
		return
	}
	var_rating_count_rows = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT post_id, meta_value FROM '), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string("\n\t\t\tWHERE meta_key = '_wc_rating_count'\n\t\t\tAND meta_value != ''\n\t\t\tAND meta_value != 'a:0:{}'\n\t\t\tORDER BY post_id ASC\n\t\t\tLIMIT %d, %d\n\t\t\t")),
			rt.new_int(offset),
			rt.new_int(var_limit),
		]),
		rt.get_constant('ARRAY_A'),
	])
	if rt.is_true(var_rating_count_rows) {
		wc_update_product_lookup_tables_rating_count(var_rating_count_rows.clone())
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
			'schedule_single', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1)),
			rt.new_string('wc_update_product_lookup_tables_rating_count_batch'),
			rt.create_array([rt.ArrayItem{ key: 'offset', val: offset + var_limit },
				rt.ArrayItem{ key: 'limit', val: var_limit }]),
			rt.new_string('wc_update_product_lookup_tables'),
		])
	}
}

fn wc_product_attach_featured_image(var_attachment_id rt.PhpVal, var_product_arg rt.PhpVal, save_product bool) {
	mut var_save_product := save_product
	mut var_product := var_product_arg
	mut var_attachment_post := rt.new_null()
	mut var_file_name := rt.new_null()
	mut var_product_id := rt.new_null()
	var_attachment_post = rt.call_function('get_post', [var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_post)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_null(), var_product))
		&& rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU.class()]), 'is_enabled', []rt.PhpVal{})) {
		var_file_name = rt.call_function('pathinfo', [
			rt.get_property(var_attachment_post, 'post_title'),
			rt.get_constant('PATHINFO_FILENAME'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_file_name)))) {
			return
		}
		var_product_id = wc_get_product_id_by_sku(var_file_name.clone())
		var_product = rt.new_bool(wc_get_product(var_product_id.clone(), rt.new_null()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return
	}
	rt.call_method(var_product, 'set_image_id', [var_attachment_id.clone()])
	if var_save_product {
		rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_attachment_post, 'post_parent'))) {
		rt.call_function('wp_update_post', [
			rt.create_array([rt.ArrayItem{ key: 'ID', val: var_attachment_id },
				rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_product, 'get_id',
					[]rt.PhpVal{}) }]),
		])
	}
}

struct Class_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

fn create_wc_product_query(_args ...rt.PhpVal) &Class_WC_Product_Query {
	mut obj := &Class_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory(_args ...rt.PhpVal) &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variable(_args ...rt.PhpVal) &Class_WC_Product_Variable {
	mut obj := &Class_WC_Product_Variable{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Variable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Product_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_query()
		return rt.new_object('WC_Product_Query', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Variable', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_variable()
		return rt.new_object('WC_Product_Variable', []string{}, obj)
	})
	rt.register_class_factory('WC_Tax', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tax()
		return rt.new_object('WC_Tax', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_NumberUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_numberutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_NumberUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_ArrayUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_arrayutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_ArrayUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Notices', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_notices()
		return rt.new_object('WC_Admin_Notices', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('post_type_link'),
		rt.new_string('wc_product_post_type_link'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('wc_product_canonical_redirect'), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('wc_product_start_scheduled_sale'),
		rt.new_string('wc_handle_product_start_scheduled_sale')])
	rt.call_function('add_action', [rt.new_string('wc_product_end_scheduled_sale'),
		rt.new_string('wc_handle_product_end_scheduled_sale')])
	rt.call_function('add_action', [rt.new_string('added_post_meta'),
		rt.new_string('wc_maybe_schedule_sale_events_on_meta_change'),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'),
		rt.new_string('wc_maybe_schedule_sale_events_on_meta_change'),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'),
		rt.new_string('wc_maybe_schedule_sale_events_on_meta_change'),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_scheduled_sales'),
		rt.new_string('wc_scheduled_sales')])
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_attributes'),
		rt.new_string('wc_get_attachment_image_attributes')])
	rt.call_function('add_filter', [rt.new_string('wp_prepare_attachment_for_js'),
		rt.new_string('wc_prepare_attachment_for_js')])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('wc_track_product_view'), rt.new_int(20)])
	rt.call_function('add_action', [
		rt.new_string('wc_update_product_lookup_tables_column'),
		rt.new_string('wc_update_product_lookup_tables_column'),
	])
	rt.call_function('add_action', [
		rt.new_string('wc_update_product_lookup_tables_rating_count_batch'),
		rt.new_string('wc_update_product_lookup_tables_rating_count_batch'),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('add_attachment'),
		rt.new_string('wc_product_attach_featured_image')])
}
