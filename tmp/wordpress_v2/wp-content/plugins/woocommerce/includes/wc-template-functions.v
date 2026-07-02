import rt
import crypto.md5

fn wc_template_redirect() {
	mut var_wp_query := rt.new_null()
	mut var_wp := rt.new_null()
	mut var_template := rt.new_null()
	mut var_product := rt.new_null()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_id')))) && rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [rt.new_string('permalink_structure')]))) && rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('shop')]), rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('page_id'))]))) && rt.is_true(rt.call_function('get_post_type_archive_link', [rt.new_string('product')])) {
		rt.call_function('wp_safe_redirect', [rt.call_function('get_post_type_archive_link', [rt.new_string('product')])])
		exit(0)
	}
	if rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('checkout')])])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('checkout')]), rt.call_function('wc_get_page_id', [rt.new_string('cart')]))))) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})) && !rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('order-pay'))) && !(rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_redirect_empty_cart'), rt.new_bool(true)])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))))) {
			rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})])
			exit(0)
		}
	}
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('customer-logout')) {
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')))) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))]), rt.new_string('customer-logout')])) {
			rt.call_function('wp_logout', []rt.PhpVal{})
			rt.call_function('wp_safe_redirect', [wc_get_logout_redirect_url()])
			exit(0)
		}
		rt.call_function('wc_add_notice', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Are you sure you want to log out? <a href="%s">Confirm and log out</a>'), rt.new_string('woocommerce')]), wc_logout_url('')])])
		rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
		exit(0)
	}
	if rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_account_endpoint_page_not_found'), rt.new_bool(true)])) {
		rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
		rt.call_function('status_header', [rt.new_int(404)])
		var_template = rt.call_function('get_query_template', [rt.new_string('404')])
		if !(!rt.is_true(var_template)) && rt.is_true(rt.call_function('file_exists', [var_template.clone()])) {
			rt.include_file((var_template).to_string(), '1')
		} else {
			rt.call_function('wp_safe_redirect', [rt.call_function('home_url', []rt.PhpVal{})])
		}
		exit(0)
	}
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_redirect_single_search_result'), rt.new_bool(true)])) && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_property(var_wp_query, 'found_posts')]))) {
		var_product = rt.call_function('wc_get_product', [rt.get_property(var_wp_query, 'post')])
		if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})) {
			rt.call_function('wp_safe_redirect', [rt.call_function('get_permalink', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]), rt.new_int(302)])
			exit(0)
		}
	}
	if rt.is_true(rt.call_function('is_add_payment_method_page', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
	}
}

fn wc_send_frame_options_header() {
	if rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) {
		rt.call_function('send_frame_options_header', []rt.PhpVal{})
	}
}

fn wc_prevent_endpoint_indexing() {
	if rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) || rt.get_superglobal('_GET').array_isset(rt.new_string('download_file')) {
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
	}
}

fn wc_prevent_adjacent_posts_rel_link_wp_head() {
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		rt.call_function('remove_action', [rt.new_string('wp_head'), rt.new_string('adjacent_posts_rel_link_wp_head'), rt.new_int(10), rt.new_int(0)])
	}
}

fn wc_gallery_noscript() {
	// unsupported statement: Stmt_InlineHTML
}

fn wc_setup_product_data(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_unset(rt.new_string('product'))
	if rt.is_true(rt.new_bool(var_post.clone().is_long())) {
	var_post = rt.call_function('get_post', [var_post.clone()])
	}
	if !rt.is_true(rt.get_property(var_post, 'post_type')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	var_GLOBALS.array_set('product', rt.call_function('wc_get_product', [var_post.clone()]))
	return var_GLOBALS.array_get(rt.new_string('product'))
}

fn wc_setup_loop(var_args rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_default_args := rt.new_null()
	var_default_args = rt.create_array([rt.ArrayItem{ key: 'loop', val: 0 }, rt.ArrayItem{ key: 'columns', val: wc_get_default_products_per_row() }, rt.ArrayItem{ key: 'name', val: '' }, rt.ArrayItem{ key: 'is_shortcode', val: false }, rt.ArrayItem{ key: 'is_paginated', val: true }, rt.ArrayItem{ key: 'is_search', val: false }, rt.ArrayItem{ key: 'is_filtered', val: false }, rt.ArrayItem{ key: 'total', val: 0 }, rt.ArrayItem{ key: 'total_pages', val: 0 }, rt.ArrayItem{ key: 'per_page', val: 0 }, rt.ArrayItem{ key: 'current_page', val: 1 }])
	if rt.is_true(rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_query')), 'get', [rt.new_string('wc_query')])) {
	var_default_args = rt.call_function('array_merge', [var_default_args.clone(), rt.create_array([rt.ArrayItem{ key: 'is_search', val: rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_query')), 'is_search', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_filtered', val: rt.call_function('is_filtered', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_GLOBALS.array_get(rt.new_string('wp_query')), 'found_posts') }, rt.ArrayItem{ key: 'total_pages', val: rt.get_property(var_GLOBALS.array_get(rt.new_string('wp_query')), 'max_num_pages') }, rt.ArrayItem{ key: 'per_page', val: rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_query')), 'get', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'current_page', val: rt.call_function('max', [rt.new_int(1), rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_query')), 'get', [rt.new_string('paged'), rt.new_int(1)])]) }])])
	}
	if var_GLOBALS.array_isset(rt.new_string('woocommerce_loop')) {
	var_default_args = rt.call_function('array_merge', [var_default_args.clone(), var_GLOBALS.array_get(rt.new_string('woocommerce_loop'))])
	}
	var_GLOBALS.array_set('woocommerce_loop', rt.call_function('wp_parse_args', [var_args.clone(), var_default_args.clone()]))
}

fn wc_reset_loop() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_unset(rt.new_string('woocommerce_loop'))
}

fn wc_get_loop_prop(prop string, default string) rt.PhpVal {
	mut var_prop := prop
	mut var_default := default
	mut var_GLOBALS := rt.new_null()
	wc_setup_loop(rt.new_null())
	return if var_GLOBALS.array_isset(rt.new_string('woocommerce_loop')) && var_GLOBALS.array_get(rt.new_string('woocommerce_loop')).array_isset(rt.new_string(prop)) { var_GLOBALS.array_get(rt.new_string('woocommerce_loop')).array_get(rt.new_string(prop)) } else { rt.new_string(default) }
}

fn wc_set_loop_prop(prop string, value string) {
	mut var_prop := prop
	mut var_value := value
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('woocommerce_loop'))) {
		wc_setup_loop(rt.new_null())
	}
	var_GLOBALS.array_get_mut('woocommerce_loop').array_set(prop, value)
}

fn wc_set_loop_product_visibility(var_product_id rt.PhpVal, var_value rt.PhpVal) {
	wc_set_loop_prop("product_visibility_${var_product_id.to_string()}", var_value.clone())
}

fn wc_get_loop_product_visibility(var_product_id rt.PhpVal) rt.PhpVal {
	return wc_get_loop_prop("product_visibility_${var_product_id.to_string()}", rt.new_null())
}

fn woocommerce_product_loop() bool {
	return rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) || rt.is_true(rt.new_bool('products' != woocommerce_get_loop_display_mode()))
}

fn wc_generator_tag(var_gen rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	mut var_version := rt.new_null()
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	var_version = iife_result_0
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		var_gen = rt.concat(var_gen, rt.new_string('\n' + '<meta name="generator" content="WooCommerce ' + (rt.call_function('esc_attr', [var_version.clone()])).str() + '">'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('xhtml'))) {
		var_gen = rt.concat(var_gen, rt.new_string('\n' + '<meta name="generator" content="WooCommerce ' + (rt.call_function('esc_attr', [var_version.clone()])).str() + '" />'))
	}
	return var_gen.clone()
}

fn wc_body_class(var_classes_arg rt.PhpVal) rt.PhpVal {
	mut var_classes := var_classes_arg
	mut var_wp := rt.new_null()
	mut var_account_page_id := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_classes = rt.cast_array(var_classes)
	if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-shop')
	}
	if rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce')
		var_classes.array_push('woocommerce-page')
	} else if rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-checkout')
		var_classes.array_push('woocommerce-page')
	} else if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-cart')
		var_classes.array_push('woocommerce-page')
	} else if rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-account')
		var_classes.array_push('woocommerce-page')
		var_account_page_id = rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_page_id')])
		if !(!rt.is_true(var_account_page_id)) && rt.is_true(rt.identical(rt.call_function('get_post_field', [rt.new_string('post_name'), var_account_page_id.clone()]), rt.call_function('basename', [rt.get_property(var_wp, 'request')]))) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			var_classes.array_push('woocommerce-dashboard')
		}
	}
	if rt.is_true(rt.call_function('is_store_notice_showing', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-demo-store')
	}
	mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_query_vars', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if rt.is_true(rt.call_function('is_wc_endpoint_url', [var_key_shadow.clone()])) {
			var_classes.array_push('woocommerce-' + (rt.call_function('sanitize_html_class', [var_key_shadow.clone()])).str())
		}
	}
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-uses-block-theme')
	}
	if rt.is_true(rt.call_function('wc_block_theme_has_styles_for_element', [rt.new_string('button')])) {
		var_classes.array_push('woocommerce-block-theme-has-button-styles')
	}
	var_classes.array_push('woocommerce-no-js')
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.new_string('wc_no_js')])
	return rt.call_function('array_unique', [var_classes.clone()])
}

fn wc_no_js() {
	mut var_type_attr := ''
	var_type_attr = if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('html5'), rt.new_string('script')])) { '' } else { ' type=\'text/javascript\'' }
	// unsupported statement: Stmt_InlineHTML
	print(var_type_attr)
	// unsupported statement: Stmt_InlineHTML
}

fn wc_product_cat_class(class string, var_category rt.PhpVal) {
	mut var_class := class
	print('class="' + (rt.call_function('esc_attr', [rt.call_function('join', [rt.new_string(' '), wc_get_product_cat_class(class, var_category.clone())])])).str() + '"')
}

fn wc_get_default_products_per_row() rt.PhpVal {
	mut var_columns := rt.new_null()
	mut var_product_grid := rt.new_null()
	mut var_min_columns := rt.new_null()
	mut var_max_columns := rt.new_null()
	var_columns = rt.call_function('get_option', [rt.new_string('woocommerce_catalog_columns'), rt.new_int(4)])
	var_product_grid = rt.call_function('wc_get_theme_support', [rt.new_string('product_grid')])
	var_min_columns = if var_product_grid.array_isset(rt.new_string('min_columns')) { rt.call_function('absint', [var_product_grid.array_get(rt.new_string('min_columns'))]) } else { rt.new_int(0) }
	var_max_columns = if var_product_grid.array_isset(rt.new_string('max_columns')) { rt.call_function('absint', [var_product_grid.array_get(rt.new_string('max_columns'))]) } else { rt.new_int(0) }
	if rt.is_true(var_min_columns) && rt.is_true(rt.less(var_columns, var_min_columns)) {
		var_columns = var_min_columns.clone()
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_columns'), var_columns.clone()])
	} else if rt.is_true(var_max_columns) && rt.is_true(rt.greater(var_columns, var_max_columns)) {
		var_columns = var_max_columns.clone()
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_columns'), var_columns.clone()])
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('loop_shop_columns')])) {
	var_columns = rt.call_function('apply_filters', [rt.new_string('loop_shop_columns'), var_columns.clone()])
	}
	var_columns = rt.call_function('absint', [var_columns.clone()])
	return rt.call_function('max', [rt.new_int(1), var_columns.clone()])
}

fn wc_get_default_product_rows_per_page() rt.PhpVal {
	mut var_rows := rt.new_null()
	mut var_product_grid := rt.new_null()
	mut var_min_rows := rt.new_null()
	mut var_max_rows := rt.new_null()
	var_rows = rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('woocommerce_catalog_rows'), rt.new_int(4)])])
	var_product_grid = rt.call_function('wc_get_theme_support', [rt.new_string('product_grid')])
	var_min_rows = if var_product_grid.array_isset(rt.new_string('min_rows')) { rt.call_function('absint', [var_product_grid.array_get(rt.new_string('min_rows'))]) } else { rt.new_int(0) }
	var_max_rows = if var_product_grid.array_isset(rt.new_string('max_rows')) { rt.call_function('absint', [var_product_grid.array_get(rt.new_string('max_rows'))]) } else { rt.new_int(0) }
	if rt.is_true(var_min_rows) && rt.is_true(rt.less(var_rows, var_min_rows)) {
		var_rows = var_min_rows.clone()
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_rows'), var_rows.clone()])
	} else if rt.is_true(var_max_rows) && rt.is_true(rt.greater(var_rows, var_max_rows)) {
		var_rows = var_max_rows.clone()
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_rows'), var_rows.clone()])
	}
	return var_rows.clone()
}

fn wc_reset_product_grid_settings() {
	mut var_product_grid := rt.new_null()
	var_product_grid = rt.call_function('wc_get_theme_support', [rt.new_string('product_grid')])
	if !(!rt.is_true(var_product_grid.array_get(rt.new_string('default_rows')))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_rows'), rt.call_function('absint', [var_product_grid.array_get(rt.new_string('default_rows'))])])
	}
	if !(!rt.is_true(var_product_grid.array_get(rt.new_string('default_columns')))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_catalog_columns'), rt.call_function('absint', [var_product_grid.array_get(rt.new_string('default_columns'))])])
	}
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
}

fn wc_get_loop_class() string {
	mut var_loop_index := rt.new_null()
	mut var_columns := rt.new_null()
	var_loop_index = wc_get_loop_prop('loop', 0)
	var_columns = rt.call_function('absint', [rt.call_function('max', [rt.new_int(1), wc_get_loop_prop('columns', wc_get_default_products_per_row())])])
	rt.pre_inc(var_loop_index)
	wc_set_loop_prop('loop', var_loop_index.clone())
	if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(rt.sub(var_loop_index, rt.new_int(1)), var_columns))) || rt.is_true(rt.identical(rt.new_int(1), var_columns)) {
		return 'first'
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_loop_index, var_columns))) {
		return 'last'
	}
	return ''
}

fn wc_get_product_cat_class(class string, var_category rt.PhpVal) rt.PhpVal {
	mut var_class := class
	mut var_classes := rt.new_null()
	var_classes = if rt.new_string(class).is_array() { rt.new_string(class) } else { rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), rt.new_string(class)])]) }
	var_classes.array_push('product-category')
	var_classes.array_push('product')
	var_classes.array_push(wc_get_loop_class())
	var_classes = rt.call_function('apply_filters', [rt.new_string('product_cat_class'), var_classes.clone(), rt.new_string(class), var_category.clone()])
	return rt.call_function('array_unique', [rt.call_function('array_filter', [var_classes.clone()])])
}

fn wc_product_post_class(var_classes rt.PhpVal, class string, post_id i64) rt.PhpVal {
	mut var_class := class
	mut var_post_id := post_id
	mut var_product := rt.new_null()
	mut var_key := rt.new_null()
	if !(var_post_id != 0) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [rt.new_int(post_id)]), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)]))))) {
		return var_classes.clone()
	}
	var_product = rt.call_function('wc_get_product', [rt.new_int(post_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return var_classes.clone()
	}
	var_classes.array_push('product')
	var_classes.array_push(wc_get_loop_class())
	var_classes.array_push(rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}))
	if rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})) {
		var_classes.array_push('sale')
	}
	if rt.is_true(rt.call_method(var_product, 'is_featured', []rt.PhpVal{})) {
		var_classes.array_push('featured')
	}
	if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
		var_classes.array_push('downloadable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})) {
		var_classes.array_push('virtual')
	}
	if rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{})) {
		var_classes.array_push('sold-individually')
	}
	if rt.is_true(rt.call_method(var_product, 'is_taxable', []rt.PhpVal{})) {
		var_classes.array_push('taxable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_shipping_taxable', []rt.PhpVal{})) {
		var_classes.array_push('shipping-taxable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})) {
		var_classes.array_push('purchasable')
	}
	if rt.is_true(rt.call_method(var_product, 'get_type', []rt.PhpVal{})) {
		var_classes.array_push('product-type-' + (rt.call_method(var_product, 'get_type', []rt.PhpVal{})).str())
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && rt.is_true(rt.call_method(var_product, 'get_default_attributes', []rt.PhpVal{})) {
		var_classes.array_push('has-default-attributes')
	}
	var_key = rt.call_function('array_search', [rt.new_string('hentry'), var_classes.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
		var_classes.array_unset(var_key)
	}
	return var_classes.clone()
}

fn wc_get_product_taxonomy_class(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_classes := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_term := rt.new_null()
	mut var_term_class := rt.new_null()
	var_classes = rt.new_array()
	mut iter_2 := var_term_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_id_shadow := item_2.val
		var_term = rt.call_function('get_term', [var_term_id_shadow.clone(), var_taxonomy.clone()])
		if !rt.is_true(rt.get_property(var_term, 'slug')) {
			continue
		}
		var_term_class = rt.call_function('sanitize_html_class', [rt.get_property(var_term, 'slug'), rt.get_property(var_term, 'term_id')])
		if var_term_class.clone().is_long() || var_term_class.clone().is_double() || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_term_class.clone().to_string().trim_space()))))) {
		var_term_class = rt.get_property(var_term, 'term_id')
		}
		if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
			var_classes.array_push('tag-' + (var_term_class).str())
		} else {
			var_classes.array_push(rt.call_function('sanitize_html_class', [rt.new_string((var_taxonomy).str() + '-' + (var_term_class).str()), rt.new_string((var_taxonomy).str() + '-' + (rt.get_property(var_term, 'term_id')).str())]))
		}
	}
	return var_classes.clone()
}

fn wc_get_product_class(class string, var_product_arg rt.PhpVal) rt.PhpVal {
	mut var_class := class
	mut var_product := var_product_arg
	mut var_GLOBALS := rt.new_null()
	mut var_post_classes := rt.new_null()
	mut var_filtered := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_type := ''
	mut var_taxonomy := rt.new_null()
	if var_product.clone().is_null() && !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('product')))) {
	var_product = var_GLOBALS.array_get(rt.new_string('product'))
	}
	if rt.is_true(var_product) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')]))))) {
	var_product = rt.call_function('wc_get_product', [var_product.clone()])
	}
	if var_class.len > 0 && var_class != '0' {
		if !(rt.new_string((var_class).str()).is_array()) {
		var_class = (rt.call_function('preg_split', [rt.new_string('#\\s+#'), rt.new_string((var_class).str())])).str()
		}
	} else {
	var_class = (rt.new_array()).str()
	}
	var_post_classes = rt.call_function('array_map', [rt.new_string('esc_attr'), rt.new_string((var_class).str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return var_post_classes.clone()
	}
	var_filtered = rt.call_function('has_filter', [rt.new_string('post_class'), rt.new_string('wc_product_post_class')])
	if rt.is_true(var_filtered) {
		rt.call_function('remove_filter', [rt.new_string('post_class'), rt.new_string('wc_product_post_class'), rt.new_int(20)])
	}
	var_post_classes = rt.call_function('apply_filters', [rt.new_string('post_class'), var_post_classes.clone(), rt.new_string((var_class).str()), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	if rt.is_true(var_filtered) {
		rt.call_function('add_filter', [rt.new_string('post_class'), rt.new_string('wc_product_post_class'), rt.new_int(20), rt.new_int(3)])
	}
	var_classes = rt.call_function('array_merge', [var_post_classes.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'type-product' }, rt.ArrayItem{ key: none, val: 'post-' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: none, val: 'status-' + (rt.call_method(var_product, 'get_status', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: none, val: wc_get_loop_class() }, rt.ArrayItem{ key: none, val: rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}) }]), wc_get_product_taxonomy_class(rt.call_method(var_product, 'get_category_ids', []rt.PhpVal{}), rt.new_string('product_cat')), wc_get_product_taxonomy_class(rt.call_method(var_product, 'get_tag_ids', []rt.PhpVal{}), rt.new_string('product_tag'))])
	if rt.is_true(rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})) {
		var_classes.array_push('has-post-thumbnail')
	}
	if rt.is_true(rt.call_method(var_product, 'get_post_password', []rt.PhpVal{})) {
		var_classes.array_push(if rt.is_true(rt.call_function('post_password_required', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])) { 'post-password-required' } else { 'post-password-protected' })
	}
	if rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})) {
		var_classes.array_push('sale')
	}
	if rt.is_true(rt.call_method(var_product, 'is_featured', []rt.PhpVal{})) {
		var_classes.array_push('featured')
	}
	if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
		var_classes.array_push('downloadable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})) {
		var_classes.array_push('virtual')
	}
	if rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{})) {
		var_classes.array_push('sold-individually')
	}
	if rt.is_true(rt.call_method(var_product, 'is_taxable', []rt.PhpVal{})) {
		var_classes.array_push('taxable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_shipping_taxable', []rt.PhpVal{})) {
		var_classes.array_push('shipping-taxable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})) {
		var_classes.array_push('purchasable')
	}
	if rt.is_true(rt.call_method(var_product, 'get_type', []rt.PhpVal{})) {
		var_classes.array_push('product-type-' + (rt.call_method(var_product, 'get_type', []rt.PhpVal{})).str())
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && rt.is_true(rt.call_method(var_product, 'get_default_attributes', []rt.PhpVal{})) {
		var_classes.array_push('has-default-attributes')
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_get_product_class_include_taxonomies'), rt.new_bool(false)])) {
		var_taxonomies = rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }])])
		var_type = if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) { 'product_variation' } else { 'product' }
		mut iter_3 := rt.cast_array(var_taxonomies).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_taxonomy_shadow := item_3.val
			if rt.is_true(rt.call_function('is_object_in_taxonomy', [rt.new_string((var_type).str()).clone(), var_taxonomy_shadow.clone()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_taxonomy_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }, rt.ArrayItem{ key: none, val: 'product_tag' }]), rt.new_bool(true)]))))) {
			var_classes = rt.call_function('array_merge', [var_classes.clone(), wc_get_product_taxonomy_class(rt.cast_array(rt.call_function('get_the_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_taxonomy_shadow.clone()])), var_taxonomy_shadow.clone())])
			}
		}
	}
	var_classes = rt.call_function('apply_filters', [rt.new_string('woocommerce_post_class'), var_classes.clone(), var_product.clone()])
	return rt.call_function('array_map', [rt.new_string('esc_attr'), rt.call_function('array_unique', [rt.call_function('array_filter', [var_classes.clone()])])])
}

fn wc_product_class(class string, var_product_id rt.PhpVal) {
	mut var_class := class
	print('class="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), wc_get_product_class(var_class, var_product_id.clone())])])).str() + '"')
}

fn wc_query_string_form_fields(var_values_arg rt.PhpVal, var_exclude rt.PhpVal, current_key string, return bool) string {
	mut var_current_key := current_key
	mut var_return := return
	mut var_values := var_values_arg
	mut var_parsed_query_string := rt.new_null()
	mut var_url_parts := rt.new_null()
	mut var_replace_chars := map[string]rt.PhpVal{}
	mut var_query_string := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_new_key := rt.new_null()
	mut var_new_value := rt.new_null()
	mut var_html := ''
	if rt.is_true(rt.new_bool(var_values.clone().is_null())) {
	var_values = rt.get_superglobal('_GET')
	} else if rt.is_true(rt.new_bool(var_values.clone().is_string())) {
		var_url_parts = rt.call_function('wp_parse_url', [var_values.clone()])
		var_values = rt.new_array()
		if !(!rt.is_true(var_url_parts.array_get(rt.new_string('query')))) {
			var_replace_chars = { '.': '{dot}', '+': '{plus}' }
			var_query_string = rt.call_function('str_replace', [rt.func_array_keys(rt.create_array_from_native_map(var_replace_chars)), rt.call_function('array_values', [rt.create_array_from_native_map(var_replace_chars)]), var_url_parts.array_get(rt.new_string('query'))])
			rt.call_function('parse_str', [var_query_string.clone(), var_parsed_query_string.clone()])
			mut iter_4 := var_parsed_query_string.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_value_shadow := item_4.val
				mut var_key_shadow := item_4.key
				var_new_key = rt.call_function('str_replace', [rt.call_function('array_values', [rt.create_array_from_native_map(var_replace_chars)]), rt.func_array_keys(rt.create_array_from_native_map(var_replace_chars)), var_key_shadow.clone()])
				var_new_value = rt.call_function('str_replace', [rt.call_function('array_values', [rt.create_array_from_native_map(var_replace_chars)]), rt.func_array_keys(rt.create_array_from_native_map(var_replace_chars)), var_value_shadow.clone()])
				var_values.array_set(var_new_key, var_new_value.clone())
			}
		}
	}
	var_html = ''
	mut iter_5 := var_values.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value_shadow := item_5.val
		mut var_key_shadow := item_5.key
		if rt.is_true(rt.call_function('in_array', [var_key_shadow.clone(), var_exclude.clone(), rt.new_bool(true)])) {
			continue
		}
		if var_current_key.len > 0 && var_current_key != '0' {
		var_key_shadow = rt.new_string(current_key + '[' + (var_key_shadow).str() + ']')
		}
		if rt.is_true(rt.new_bool(var_value_shadow.clone().is_array())) {
			var_html = var_html + wc_query_string_form_fields(var_value_shadow.clone(), var_exclude.clone(), var_key_shadow.clone(), true)
		} else {
			var_html = var_html + '<input type="hidden" name="' + (rt.call_function('esc_attr', [var_key_shadow.clone()])).str() + '" value="' + (rt.call_function('esc_attr', [rt.call_function('wp_unslash', [var_value_shadow.clone()])])).str() + '" />'
		}
	}
	if var_return {
		return var_html
	}
	print(var_html)
	return ''
}

fn wc_terms_and_conditions_page_id() rt.PhpVal {
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('wc_get_page_id', [rt.new_string('terms')])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_terms_and_conditions_page_id'), if rt.is_true(rt.less(rt.new_int(0), var_page_id)) { rt.call_function('absint', [var_page_id.clone()]) } else { rt.new_int(0) }])
}

fn wc_privacy_policy_page_id() rt.PhpVal {
	mut var_page_id := rt.new_null()
	var_page_id = rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy'), rt.new_int(0)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_policy_page_id'), if rt.is_true(rt.less(rt.new_int(0), var_page_id)) { rt.call_function('absint', [var_page_id.clone()]) } else { rt.new_int(0) }])
}

fn wc_terms_and_conditions_checkbox_enabled() bool {
	mut var_page_id := rt.new_null()
	mut var_page := rt.new_null()
	var_page_id = wc_terms_and_conditions_page_id()
	var_page = if rt.is_true(var_page_id) { rt.call_function('get_post', [var_page_id.clone()]) } else { rt.new_bool(false) }
	return rt.is_true(var_page) && rt.is_true(rt.new_string(wc_get_terms_and_conditions_checkbox_text()))
}

fn wc_get_terms_and_conditions_checkbox_text() string {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_terms_and_conditions_checkbox_text'), rt.call_function('get_option', [rt.new_string('woocommerce_checkout_terms_and_conditions_checkbox_text'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('I have read and agree to the website %s'), rt.new_string('woocommerce')]), rt.new_string('[terms]')])])]).to_string().trim_space()
}

fn wc_get_privacy_policy_text(type string) string {
	mut var_type := type
	mut var_text := ''
	var_text = ''
	mut switch_val_2 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkout'))) {
	var_text = (rt.call_function('get_option', [rt.new_string('woocommerce_checkout_privacy_policy_text'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our %s.'), rt.new_string('woocommerce')]), rt.new_string('[privacy_policy]')])])).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('registration'))) {
	var_text = (rt.call_function('get_option', [rt.new_string('woocommerce_registration_privacy_policy_text'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our %s.'), rt.new_string('woocommerce')]), rt.new_string('[privacy_policy]')])])).str()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_privacy_policy_text'), rt.new_string((var_text).str()).clone(), rt.new_string(type)]).to_string().trim_space()
}

fn wc_terms_and_conditions_checkbox_text() {
	mut var_text := ''
	var_text = wc_get_terms_and_conditions_checkbox_text()
	if !(var_text.len > 0 && var_text != '0') {
		return
	}
	rt.echo_val(rt.call_function('wp_kses_post', [wc_replace_policy_page_link_placeholders(rt.new_string((var_text).str()).clone())]))
}

fn wc_terms_and_conditions_page_content() {
	mut var_terms_page_id := rt.new_null()
	mut var_sanitizer := rt.new_null()
	mut var_page := rt.new_null()
	var_terms_page_id = wc_terms_and_conditions_page_id()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms_page_id)))) {
		return
	}
	var_sanitizer = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.class()])
	var_page = rt.call_function('get_post', [var_terms_page_id.clone()])
	if rt.is_true(var_page) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_page, 'post_status'))) && rt.is_true(rt.get_property(var_page, 'post_content')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_shortcode', [rt.get_property(var_page, 'post_content'), rt.new_string('woocommerce_checkout')]))))) {
		print('<div class="woocommerce-terms-and-conditions" style="display: none; max-height: 200px; overflow: auto;">' + (rt.call_function('wc_format_content', [rt.call_method(var_sanitizer, 'styled_post_content', [rt.get_property(var_page, 'post_content')])])).str() + '</div>')
	}
}

fn wc_checkout_privacy_policy_text() {
	print('<div class="woocommerce-privacy-policy-text">')
	wc_privacy_policy_text('checkout')
	print('</div>')
}

fn wc_registration_privacy_policy_text() {
	print('<div class="woocommerce-privacy-policy-text">')
	wc_privacy_policy_text('registration')
	print('</div>')
}

fn wc_privacy_policy_text(type string) {
	mut var_type := type
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_privacy_policy_page_id())))) {
		return
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [wc_replace_policy_page_link_placeholders(rt.new_string(wc_get_privacy_policy_text(type)))])]))
}

fn wc_replace_policy_page_link_placeholders(var_text rt.PhpVal) rt.PhpVal {
	mut var_privacy_page_id := rt.new_null()
	mut var_terms_page_id := rt.new_null()
	mut var_privacy_link := rt.new_null()
	mut var_terms_link := rt.new_null()
	mut var_find_replace := map[string]rt.PhpVal{}
	var_privacy_page_id = wc_privacy_policy_page_id()
	var_terms_page_id = wc_terms_and_conditions_page_id()
	var_privacy_link = if rt.is_true(var_privacy_page_id) { '<a href="' + (rt.call_function('esc_url', [rt.call_function('get_permalink', [var_privacy_page_id.clone()])])).str() + '" class="woocommerce-privacy-policy-link" target="_blank">' + (rt.call_function('__', [rt.new_string('privacy policy'), rt.new_string('woocommerce')])).str() + '</a>' } else { rt.call_function('__', [rt.new_string('privacy policy'), rt.new_string('woocommerce')]) }
	var_terms_link = if rt.is_true(var_terms_page_id) { '<a href="' + (rt.call_function('esc_url', [rt.call_function('get_permalink', [var_terms_page_id.clone()])])).str() + '" class="woocommerce-terms-and-conditions-link" target="_blank">' + (rt.call_function('__', [rt.new_string('terms and conditions'), rt.new_string('woocommerce')])).str() + '</a>' } else { rt.call_function('__', [rt.new_string('terms and conditions'), rt.new_string('woocommerce')]) }
	var_find_replace = { '[terms]': var_terms_link, '[privacy_policy]': var_privacy_link }
	return rt.call_function('str_replace', [rt.func_array_keys(rt.create_array_from_native_map(var_find_replace)), rt.call_function('array_values', [rt.create_array_from_native_map(var_find_replace)]), var_text.clone()])
}

fn woocommerce_content() {
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
			rt.call_function('the_post', []rt.PhpVal{})
			rt.call_function('wc_get_template_part', [rt.new_string('content'), rt.new_string('single-product')])
		}
	} else {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_show_page_title'), rt.new_bool(true)])) {
			// unsupported statement: Stmt_InlineHTML
			woocommerce_page_title(false)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_archive_description')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(woocommerce_product_loop())) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [rt.new_string('woocommerce_before_shop_loop')])
			// unsupported statement: Stmt_InlineHTML
			woocommerce_product_loop_start(false)
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(wc_get_loop_prop('total', '')) {
				// unsupported statement: Stmt_InlineHTML
				for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('the_post', []rt.PhpVal{})
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('wc_get_template_part', [rt.new_string('content'), rt.new_string('product')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			woocommerce_product_loop_end(false)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [rt.new_string('woocommerce_after_shop_loop')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_no_products_found')])
		}
	}
}

fn woocommerce_output_content_wrapper() {
	rt.call_function('wc_get_template', [rt.new_string('global/wrapper-start.php')])
}

fn woocommerce_output_content_wrapper_end() {
	rt.call_function('wc_get_template', [rt.new_string('global/wrapper-end.php')])
}

fn woocommerce_get_sidebar() {
	rt.call_function('wc_get_template', [rt.new_string('global/sidebar.php')])
}

fn woocommerce_demo_store() {
	mut var_notice := rt.new_null()
	mut var_notice_id := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_store_notice_showing', []rt.PhpVal{}))))) {
		return
	}
	var_notice = rt.call_function('get_option', [rt.new_string('woocommerce_demo_store_notice')])
	if !rt.is_true(var_notice) {
	var_notice = rt.call_function('__', [rt.new_string('This is a demo store for testing purposes &mdash; no orders shall be fulfilled.'), rt.new_string('woocommerce')])
	}
	var_notice_id = md5.hexhash(var_notice.clone().to_string())
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_demo_store'), rt.new_string('<p role="complementary" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Store notice'), rt.new_string('woocommerce')])).str() + '" class="woocommerce-store-notice demo_store" data-notice-id="' + (rt.call_function('esc_attr', [rt.new_string((var_notice_id).str()).clone()])).str() + '" style="display:none;">' + (rt.call_function('wp_kses_post', [var_notice.clone()])).str() + ' <a role="button" href="#" class="woocommerce-store-notice__dismiss-link">' + (rt.call_function('esc_html__', [rt.new_string('Dismiss'), rt.new_string('woocommerce')])).str() + '</a></p>'), var_notice.clone()]))
}

fn woocommerce_page_title(echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_page_title := rt.new_null()
	mut var_shop_page_id := rt.new_null()
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		var_page_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search results: &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), rt.call_function('get_search_query', []rt.PhpVal{})])
		if rt.is_true(rt.call_function('get_query_var', [rt.new_string('paged')])) {
			var_page_title = rt.concat(var_page_title, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('&nbsp;&ndash; Page %s'), rt.new_string('woocommerce')]), rt.call_function('get_query_var', [rt.new_string('paged')])]))
		}
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
	var_page_title = rt.call_function('single_term_title', [rt.new_string(''), rt.new_bool(false)])
	} else {
	var_shop_page_id = rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	var_page_title = rt.call_function('get_the_title', [var_shop_page_id.clone()])
	}
	var_page_title = rt.call_function('apply_filters', [rt.new_string('woocommerce_page_title'), var_page_title.clone()])
	if var_echo {
		rt.echo_val(var_page_title)
	} else {
		return var_page_title.clone()
	}
	return rt.new_null()
}

fn woocommerce_product_loop_start(echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_loop_start := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	wc_set_loop_prop('loop', 0)
	rt.call_function('wc_get_template', [rt.new_string('loop/loop-start.php')])
	var_loop_start = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_loop_start'), rt.call_function('ob_get_clean', []rt.PhpVal{})])
	if var_echo {
		rt.echo_val(var_loop_start)
	} else {
		return var_loop_start.clone()
	}
	return rt.new_null()
}

fn woocommerce_product_loop_end(echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_loop_end := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('loop/loop-end.php')])
	var_loop_end = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_loop_end'), rt.call_function('ob_get_clean', []rt.PhpVal{})])
	if var_echo {
		rt.echo_val(var_loop_end)
	} else {
		return var_loop_end.clone()
	}
	return rt.new_null()
}

fn woocommerce_template_loop_product_title() {
	print('<h2 class="' + (rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_loop_title_classes'), rt.new_string('woocommerce-loop-product__title')])])).str() + '">' + (rt.call_function('get_the_title', []rt.PhpVal{})).str() + '</h2>')
}

fn woocommerce_template_loop_category_title(var_category rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_category, 'name')]))
	if rt.is_true(rt.greater(rt.get_property(var_category, 'count'), rt.new_int(0))) {
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_subcategory_count_html'), rt.new_string(' <mark class="count">(' + (rt.call_function('esc_html', [rt.get_property(var_category, 'count')])).str() + ')</mark>'), var_category.clone()]))
	}
	// unsupported statement: Stmt_InlineHTML
}

fn woocommerce_template_loop_product_link_open() {
	mut var_product := rt.new_null()
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	var_link = rt.call_function('apply_filters', [rt.new_string('woocommerce_loop_product_link'), rt.call_function('get_the_permalink', []rt.PhpVal{}), var_product.clone()])
	print('<a href="' + (rt.call_function('esc_url', [var_link.clone()])).str() + '" class="woocommerce-LoopProduct-link woocommerce-loop-product__link">')
}

fn woocommerce_template_loop_product_link_close() {
	print('</a>')
}

fn woocommerce_template_loop_category_link_open(var_category rt.PhpVal) {
	mut var_category_term := rt.new_null()
	mut var_category_name := rt.new_null()
	var_category_term = rt.call_function('get_term', [var_category.clone(), rt.new_string('product_cat')])
	var_category_name = if rt.is_true(rt.new_bool(!(rt.is_true(var_category_term)))) || rt.is_true(rt.call_function('is_wp_error', [var_category_term.clone()])) { rt.new_string('') } else { rt.get_property(var_category_term, 'name') }
	print('<a aria-label="' + (rt.call_function('sprintf', [rt.call_function('esc_attr__', [rt.new_string('Visit product category %1$s'), rt.new_string('woocommerce')]), rt.call_function('esc_attr', [var_category_name.clone()])])).str() + '" href="' + (rt.call_function('esc_url', [rt.call_function('get_term_link', [var_category.clone(), rt.new_string('product_cat')])])).str() + '">')
}

fn woocommerce_template_loop_category_link_close() {
	print('</a>')
}

fn woocommerce_product_taxonomy_archive_header() {
	rt.call_function('wc_get_template', [rt.new_string('loop/header.php')])
}

fn woocommerce_taxonomy_archive_description() {
	mut var_term := rt.new_null()
	mut var_term_description := rt.new_null()
	if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('absint', [rt.call_function('get_query_var', [rt.new_string('paged')])]))) {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_term) {
			var_term_description = rt.call_function('apply_filters', [rt.new_string('woocommerce_taxonomy_archive_description_raw'), rt.get_property(var_term, 'description'), var_term.clone()])
			if !(!rt.is_true(var_term_description)) {
				print('<div class="term-description">' + (rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [var_term_description.clone()])])).str() + '</div>')
			}
		}
	}
}

fn woocommerce_product_archive_description() {
	mut var_shop_page := rt.new_null()
	mut var_allowed_html := rt.new_null()
	mut var_description := rt.new_null()
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) && rt.is_true(rt.call_function('in_array', [rt.call_function('absint', [rt.call_function('get_query_var', [rt.new_string('paged')])]), rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 1 }]), rt.new_bool(true)])) {
		var_shop_page = rt.call_function('get_post', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])
		if rt.is_true(var_shop_page) {
			var_allowed_html = rt.call_function('wp_kses_allowed_html', [rt.new_string('post')])
			var_allowed_html = rt.call_function('array_merge', [var_allowed_html.clone(), rt.create_array([rt.ArrayItem{ key: 'form', val: rt.create_array([rt.ArrayItem{ key: 'action', val: true }, rt.ArrayItem{ key: 'accept', val: true }, rt.ArrayItem{ key: 'accept-charset', val: true }, rt.ArrayItem{ key: 'enctype', val: true }, rt.ArrayItem{ key: 'method', val: true }, rt.ArrayItem{ key: 'name', val: true }, rt.ArrayItem{ key: 'target', val: true }]) }, rt.ArrayItem{ key: 'input', val: rt.create_array([rt.ArrayItem{ key: 'type', val: true }, rt.ArrayItem{ key: 'id', val: true }, rt.ArrayItem{ key: 'class', val: true }, rt.ArrayItem{ key: 'placeholder', val: true }, rt.ArrayItem{ key: 'name', val: true }, rt.ArrayItem{ key: 'value', val: true }]) }, rt.ArrayItem{ key: 'button', val: rt.create_array([rt.ArrayItem{ key: 'type', val: true }, rt.ArrayItem{ key: 'class', val: true }, rt.ArrayItem{ key: 'label', val: true }]) }, rt.ArrayItem{ key: 'svg', val: rt.create_array([rt.ArrayItem{ key: 'hidden', val: true }, rt.ArrayItem{ key: 'role', val: true }, rt.ArrayItem{ key: 'focusable', val: true }, rt.ArrayItem{ key: 'xmlns', val: true }, rt.ArrayItem{ key: 'width', val: true }, rt.ArrayItem{ key: 'height', val: true }, rt.ArrayItem{ key: 'viewbox', val: true }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: 'd', val: true }]) }])])
			var_description = rt.call_function('wc_format_content', [rt.call_function('wp_kses', [rt.get_property(var_shop_page, 'post_content'), var_allowed_html.clone()])])
			if rt.is_true(var_description) {
				print('<div class="page-description">' + (var_description).str() + '</div>')
			}
		}
	}
}

fn woocommerce_template_loop_add_to_cart(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_product := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_cart_redirect_after_add := false
	mut var_ajax_add_to_cart_enabled := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	var_defaults = { 'quantity': rt.new_int(1), 'class': rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [map[string]rt.PhpVal{}])]), 'aria-describedby_text': rt.call_method(var_product, 'add_to_cart_aria_describedby', []rt.PhpVal{}), 'attributes': { 'data-product_id': rt.call_method(var_product, 'get_id', []rt.PhpVal{}), 'data-product_sku': rt.call_method(var_product, 'get_sku', []rt.PhpVal{}), 'aria-label': rt.call_method(var_product, 'add_to_cart_description', []rt.PhpVal{}), 'rel': rt.new_string('nofollow') } }
	if rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product_Simple')])) {
		var_defaults.array_get_mut('attributes').array_set('data-success_message', rt.call_method(var_product, 'add_to_cart_success_message', []rt.PhpVal{}))
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_loop_add_to_cart_args'), rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)]), var_product.clone()])
	if !(!rt.is_true(var_args.array_get(rt.new_string('attributes')).array_get(rt.new_string('aria-describedby')))) {
		var_args.array_get_mut('attributes').array_set('aria-describedby', rt.call_function('wp_strip_all_tags', [var_args.array_get(rt.new_string('attributes')).array_get(rt.new_string('aria-describedby'))]))
	}
	if var_args.array_get(rt.new_string('attributes')).array_isset(rt.new_string('aria-label')) {
		var_args.array_get_mut('attributes').array_set('aria-label', rt.call_function('wp_strip_all_tags', [var_args.array_get(rt.new_string('attributes')).array_get(rt.new_string('aria-label'))]))
	}
	var_cart_redirect_after_add = (rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]), rt.new_string('yes'))).to_bool()
	var_ajax_add_to_cart_enabled = (rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_enable_ajax_add_to_cart')]), rt.new_string('yes'))).to_bool()
	if !(var_cart_redirect_after_add) && var_ajax_add_to_cart_enabled && rt.is_true(rt.call_method(var_product, 'supports', [rt.new_string('ajax_add_to_cart')])) && rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})) {
		var_args.array_get_mut('attributes').array_set('role', 'button')
	}
	rt.call_function('wc_get_template', [rt.new_string('loop/add-to-cart.php'), var_args.clone()])
}

fn woocommerce_template_loop_product_thumbnail() {
	print(woocommerce_get_product_thumbnail())
}

fn woocommerce_template_loop_price() {
	rt.call_function('wc_get_template', [rt.new_string('loop/price.php')])
}

fn woocommerce_template_loop_rating() {
	rt.call_function('wc_get_template', [rt.new_string('loop/rating.php')])
}

fn woocommerce_show_product_loop_sale_flash() {
	rt.call_function('wc_get_template', [rt.new_string('loop/sale-flash.php')])
}

fn woocommerce_get_product_thumbnail(size string, var_attr_arg rt.PhpVal, placeholder bool) string {
	mut var_size := size
	mut var_placeholder := placeholder
	mut var_attr := var_attr_arg
	mut var_product := rt.new_null()
	mut var_image_size := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return ''
	}
	if !(var_attr.clone().is_array()) {
	var_attr = rt.new_array()
	}
	if !(rt.new_bool(var_placeholder).is_bool()) {
	var_placeholder = true
	}
	var_image_size = rt.call_function('apply_filters', [rt.new_string('single_product_archive_thumbnail_size'), rt.new_string(size)])
	return (rt.call_method(var_product, 'get_image', [var_image_size.clone(), var_attr.clone(), rt.new_bool(var_placeholder)])).str()
}

fn woocommerce_result_count() {
	mut var_default_orderby := rt.new_null()
	mut var_orderby := rt.new_null()
	mut var_catalog_orderedby_options := rt.new_null()
	mut var_orderedby := rt.new_null()
	mut var_args := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_get_loop_prop('is_paginated', ''))))) || !(woocommerce_products_will_display()) {
		return
	}
	var_default_orderby = rt.call_function('apply_filters', [rt.new_string('woocommerce_default_catalog_orderby'), rt.call_function('get_option', [rt.new_string('woocommerce_default_catalog_orderby'), rt.new_string('')])])
	var_orderby = if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))])]) } else { var_default_orderby }
	var_orderby = if rt.is_true(rt.identical(rt.new_string('menu_order'), var_orderby)) { rt.new_string('') } else { var_orderby }
	var_orderby = if var_orderby.clone().is_string() { var_orderby } else { rt.new_string('') }
	var_catalog_orderedby_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_catalog_orderedby'), rt.create_array([rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [rt.new_string('Default sorting'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'popularity', val: rt.call_function('__', [rt.new_string('Sorted by popularity'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [rt.new_string('Sorted by average rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('__', [rt.new_string('Sorted by latest'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price', val: rt.call_function('__', [rt.new_string('Sorted by price: low to high'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price-desc', val: rt.call_function('__', [rt.new_string('Sorted by price: high to low'), rt.new_string('woocommerce')]) }])])
	var_orderedby = if var_catalog_orderedby_options.array_isset(var_orderby) { var_catalog_orderedby_options.array_get(var_orderby) } else { rt.new_string('') }
	var_orderedby = if var_orderedby.clone().is_string() { var_orderedby } else { rt.new_string('') }
	var_args = rt.create_array([rt.ArrayItem{ key: 'total', val: wc_get_loop_prop('total', '') }, rt.ArrayItem{ key: 'per_page', val: wc_get_loop_prop('per_page', '') }, rt.ArrayItem{ key: 'current', val: wc_get_loop_prop('current_page', '') }, rt.ArrayItem{ key: 'orderedby', val: var_orderedby }])
	rt.call_function('wc_get_template', [rt.new_string('loop/result-count.php'), var_args.clone()])
}

fn woocommerce_catalog_ordering(var_attributes rt.PhpVal) {
	mut var_show_default_orderby := false
	mut var_catalog_orderby_options := rt.new_null()
	mut var_default_orderby := rt.new_null()
	mut var_orderby := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_get_loop_prop('is_paginated', ''))))) || !(woocommerce_products_will_display()) {
		return
	}
	var_show_default_orderby = (rt.identical(rt.new_string('menu_order'), rt.call_function('apply_filters', [rt.new_string('woocommerce_default_catalog_orderby'), rt.call_function('get_option', [rt.new_string('woocommerce_default_catalog_orderby'), rt.new_string('menu_order')])]))).to_bool()
	if !(var_attributes).is_null() && var_attributes.array_isset(rt.new_string('useLabel')) && rt.is_true(var_attributes.array_get(rt.new_string('useLabel'))) {
	var_catalog_orderby_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_catalog_orderby'), rt.create_array([rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [rt.new_string('Default'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'popularity', val: rt.call_function('__', [rt.new_string('Popularity'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [rt.new_string('Average rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('__', [rt.new_string('Latest'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price', val: rt.call_function('__', [rt.new_string('Price: low to high'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price-desc', val: rt.call_function('__', [rt.new_string('Price: high to low'), rt.new_string('woocommerce')]) }])])
	} else {
	var_catalog_orderby_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_catalog_orderby'), rt.create_array([rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [rt.new_string('Default sorting'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'popularity', val: rt.call_function('__', [rt.new_string('Sort by popularity'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [rt.new_string('Sort by average rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('__', [rt.new_string('Sort by latest'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price', val: rt.call_function('__', [rt.new_string('Sort by price: low to high'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'price-desc', val: rt.call_function('__', [rt.new_string('Sort by price: high to low'), rt.new_string('woocommerce')]) }])])
	}
	var_default_orderby = if rt.is_true(wc_get_loop_prop('is_search', '')) { rt.new_string('relevance') } else { rt.call_function('apply_filters', [rt.new_string('woocommerce_default_catalog_orderby'), rt.call_function('get_option', [rt.new_string('woocommerce_default_catalog_orderby'), rt.new_string('')])]) }
	var_orderby = if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))])]) } else { var_default_orderby }
	if rt.is_true(wc_get_loop_prop('is_search', '')) {
		var_catalog_orderby_options = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'relevance', val: rt.call_function('__', [rt.new_string('Relevance'), rt.new_string('woocommerce')]) }]), var_catalog_orderby_options.clone()])
		var_catalog_orderby_options.array_unset(rt.new_string('menu_order'))
	}
	if !(var_show_default_orderby) {
		var_catalog_orderby_options.array_unset(rt.new_string('menu_order'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{}))))) {
		var_catalog_orderby_options.array_unset(rt.new_string('rating'))
	}
	if rt.is_true(rt.new_bool(var_orderby.clone().is_array())) {
	var_orderby = rt.call_function('current', [rt.call_function('array_intersect', [var_orderby.clone(), rt.func_array_keys(var_catalog_orderby_options.clone())])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_catalog_orderby_options.clone().array_isset(var_orderby.clone())))))) {
	var_orderby = rt.call_function('current', [rt.func_array_keys(var_catalog_orderby_options.clone())])
	}
	rt.call_function('wc_get_template', [rt.new_string('loop/orderby.php'), rt.create_array([rt.ArrayItem{ key: 'catalog_orderby_options', val: var_catalog_orderby_options }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'show_default_orderby', val: var_show_default_orderby }, rt.ArrayItem{ key: 'use_label', val: if var_attributes.array_isset(rt.new_string('useLabel')) { var_attributes.array_get(rt.new_string('useLabel')) } else { rt.new_bool(false) } }])])
}

fn woocommerce_pagination() {
	mut var_args := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_get_loop_prop('is_paginated', ''))))) || !(woocommerce_products_will_display()) {
		return
	}
	var_args = rt.create_array([rt.ArrayItem{ key: 'total', val: wc_get_loop_prop('total_pages', '') }, rt.ArrayItem{ key: 'current', val: wc_get_loop_prop('current_page', '') }, rt.ArrayItem{ key: 'base', val: rt.call_function('esc_url_raw', [rt.call_function('add_query_arg', [rt.new_string('product-page'), rt.new_string('%#%'), rt.new_bool(false)])]) }, rt.ArrayItem{ key: 'format', val: '?product-page=%#%' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(wc_get_loop_prop('is_shortcode', ''))))) {
		var_args.array_set('format', '')
		var_args.array_set('base', rt.call_function('esc_url_raw', [rt.call_function('str_replace', [rt.new_int(999999999), rt.new_string('%#%'), rt.call_function('remove_query_arg', [rt.new_string('add-to-cart'), rt.call_function('get_pagenum_link', [rt.new_int(999999999), rt.new_bool(false)])])])]))
	}
	rt.call_function('wc_get_template', [rt.new_string('loop/pagination.php'), var_args.clone()])
}

fn woocommerce_show_product_images() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/product-image.php')])
}

fn woocommerce_show_product_thumbnails() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/product-thumbnails.php')])
}

fn wc_get_gallery_image_html(var_attachment_id rt.PhpVal, main_image bool, var_image_index rt.PhpVal) string {
	mut var_main_image := main_image
	mut var_product := rt.new_null()
	mut var_flexslider := rt.new_null()
	mut var_gallery_thumbnail := rt.new_null()
	mut var_thumbnail_size := rt.new_null()
	mut var_image_size := rt.new_null()
	mut var_full_size := rt.new_null()
	mut var_thumbnail_src := rt.new_null()
	mut var_thumbnail_srcset := rt.new_null()
	mut var_thumbnail_sizes := rt.new_null()
	mut var_full_src := rt.new_null()
	mut var_alt_text := rt.new_null()
	mut var_image_params := rt.new_null()
	mut var_image := rt.new_null()
	var_flexslider = rt.new_bool((rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_flexslider_enabled'), rt.call_function('get_theme_support', [rt.new_string('wc-product-gallery-slider')])])).to_bool())
	var_gallery_thumbnail = rt.call_function('wc_get_image_size', [rt.new_string('gallery_thumbnail')])
	var_thumbnail_size = rt.call_function('apply_filters', [rt.new_string('woocommerce_gallery_thumbnail_size'), rt.create_array([rt.ArrayItem{ key: none, val: var_gallery_thumbnail.array_get(rt.new_string('width')) }, rt.ArrayItem{ key: none, val: var_gallery_thumbnail.array_get(rt.new_string('height')) }])])
	var_image_size = rt.call_function('apply_filters', [rt.new_string('woocommerce_gallery_image_size'), if rt.is_true(var_flexslider) || var_main_image { rt.new_string('woocommerce_single') } else { var_thumbnail_size }])
	var_full_size = rt.call_function('apply_filters', [rt.new_string('woocommerce_gallery_full_size'), rt.call_function('apply_filters', [rt.new_string('woocommerce_product_thumbnails_large_size'), rt.new_string('full')])])
	var_thumbnail_src = rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), var_thumbnail_size.clone()])
	var_thumbnail_srcset = rt.call_function('wp_get_attachment_image_srcset', [var_attachment_id.clone(), var_thumbnail_size.clone()])
	var_thumbnail_sizes = rt.call_function('wp_get_attachment_image_sizes', [var_attachment_id.clone(), var_thumbnail_size.clone()])
	var_full_src = rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), var_full_size.clone()])
	var_alt_text = rt.new_string(rt.call_function('wp_strip_all_tags', [rt.call_function('get_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])]).to_string().trim_space())
	var_alt_text = if !rt.is_true(var_alt_text) && rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) { woocommerce_get_alt_from_product_title_and_position(rt.call_method(var_product, 'get_title', []rt.PhpVal{}), rt.new_bool(main_image), var_image_index.clone()) } else { var_alt_text }
	var_image_params = rt.call_function('apply_filters', [rt.new_string('woocommerce_gallery_image_html_attachment_image_params'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_wp_specialchars', [rt.call_function('get_post_field', [rt.new_string('post_title'), var_attachment_id.clone()]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'data-caption', val: rt.call_function('_wp_specialchars', [rt.call_function('get_post_field', [rt.new_string('post_excerpt'), var_attachment_id.clone()]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'data-src', val: if var_full_src.array_isset(rt.new_int(0)) { rt.call_function('esc_url', [var_full_src.array_get(rt.new_int(0))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'data-large_image', val: if var_full_src.array_isset(rt.new_int(0)) { rt.call_function('esc_url', [var_full_src.array_get(rt.new_int(0))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'data-large_image_width', val: if var_full_src.array_isset(rt.new_int(1)) { rt.call_function('esc_attr', [var_full_src.array_get(rt.new_int(1))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'data-large_image_height', val: if var_full_src.array_isset(rt.new_int(2)) { rt.call_function('esc_attr', [var_full_src.array_get(rt.new_int(2))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [rt.new_string((if var_main_image { 'wp-post-image' } else { '' }).str())]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('esc_attr', [var_alt_text.clone()]) }]), var_attachment_id.clone(), var_image_size.clone(), rt.new_bool(main_image)])
	if var_image_params.array_isset(rt.new_string('title')) {
		var_image_params.array_unset(rt.new_string('title'))
	}
	var_image = rt.call_function('wp_get_attachment_image', [var_attachment_id.clone(), var_image_size.clone(), rt.new_bool(false), var_image_params.clone()])
	return '<div data-thumb="' + (rt.call_function('esc_url', [if var_thumbnail_src.array_isset(rt.new_int(0)) { var_thumbnail_src.array_get(rt.new_int(0)) } else { rt.new_string('') }])).str() + '" data-thumb-alt="' + (rt.call_function('esc_attr', [var_alt_text.clone()])).str() + '" data-thumb-srcset="' + (rt.call_function('esc_attr', [if !(var_thumbnail_srcset).is_null() { var_thumbnail_srcset } else { rt.new_string('') }])).str() + '"  data-thumb-sizes="' + (rt.call_function('esc_attr', [if !(var_thumbnail_sizes).is_null() { var_thumbnail_sizes } else { rt.new_string('') }])).str() + '" class="woocommerce-product-gallery__image"><a href="' + (rt.call_function('esc_url', [if var_full_src.array_isset(rt.new_int(0)) { var_full_src.array_get(rt.new_int(0)) } else { rt.new_string('') }])).str() + '">' + (var_image).str() + '</a></div>'
}

fn woocommerce_get_alt_from_product_title_and_position(var_product_name rt.PhpVal, var_main_image rt.PhpVal, var_image_index rt.PhpVal) rt.PhpVal {
	mut var_adder := i64(0)
	if rt.is_true(rt.identical(-1, var_image_index)) {
		return var_product_name.clone()
	}
	var_adder = if rt.is_true(var_main_image) { 1 } else { 2 }
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s - Image %2$s'), rt.new_string('woocommerce')]), var_product_name.clone(), rt.add(var_image_index, rt.new_int(var_adder))])
}

fn woocommerce_output_product_data_tabs() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/tabs/tabs.php')])
}

fn woocommerce_template_single_title() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/title.php')])
}

fn woocommerce_template_single_rating() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [if !(var_GLOBALS.array_get(rt.new_string('product'))).is_null() { var_GLOBALS.array_get(rt.new_string('product')) } else { rt.new_null() }, Class_WC_Product.class()]))))) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/rating.php')])
}

fn woocommerce_template_single_price() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [if !(var_GLOBALS.array_get(rt.new_string('product'))).is_null() { var_GLOBALS.array_get(rt.new_string('product')) } else { rt.new_null() }, Class_WC_Product.class()]))))) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/price.php')])
}

fn woocommerce_template_single_excerpt() {
	mut var_GLOBALS := rt.new_null()
	if !(!(rt.get_property(var_GLOBALS.array_get(rt.new_string('post')), 'post_excerpt')).is_null()) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/short-description.php')])
}

fn woocommerce_template_single_meta() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [if !(var_GLOBALS.array_get(rt.new_string('product'))).is_null() { var_GLOBALS.array_get(rt.new_string('product')) } else { rt.new_null() }, Class_WC_Product.class()]))))) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/meta.php')])
}

fn woocommerce_template_single_sharing() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/share.php')])
}

fn woocommerce_show_product_sale_flash() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/sale-flash.php')])
}

fn woocommerce_template_single_add_to_cart() {
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_' + (rt.call_method(var_product, 'get_type', []rt.PhpVal{})).str() + '_add_to_cart')])
	}
}

fn woocommerce_simple_add_to_cart() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/add-to-cart/simple.php')])
}

fn woocommerce_grouped_add_to_cart() {
	mut var_product := rt.new_null()
	mut var_child_ids := rt.new_null()
	mut var_products := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	var_child_ids = rt.call_method(var_product, 'get_children', []rt.PhpVal{})
	rt.call_function('_prime_post_caches', [var_child_ids.clone()])
	var_products = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_child_ids.clone()]), rt.new_string('wc_products_array_filter_visible_grouped')])
	if rt.is_true(var_products) {
		rt.call_function('wc_get_template', [rt.new_string('single-product/add-to-cart/grouped.php'), rt.create_array([rt.ArrayItem{ key: 'grouped_product', val: var_product }, rt.ArrayItem{ key: 'grouped_products', val: var_products }, rt.ArrayItem{ key: 'quantites_required', val: false }])])
	}
}

fn woocommerce_variable_add_to_cart() {
	mut var_product := rt.new_null()
	mut var_get_variations := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-add-to-cart-variation')])
	var_get_variations = (rt.less_equal(rt.new_int(rt.call_method(var_product, 'get_children', []rt.PhpVal{}).array_count()), rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_variation_threshold'), rt.new_int(30), var_product.clone()]))).to_bool()
	rt.call_function('wc_get_template', [rt.new_string('single-product/add-to-cart/variable.php'), rt.create_array([rt.ArrayItem{ key: 'available_variations', val: if var_get_variations { rt.call_method(var_product, 'get_available_variations', []rt.PhpVal{}) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'selected_attributes', val: rt.call_method(var_product, 'get_default_attributes', []rt.PhpVal{}) }])])
}

fn woocommerce_external_add_to_cart() {
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'add_to_cart_url', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/add-to-cart/external.php'), rt.create_array([rt.ArrayItem{ key: 'product_url', val: rt.call_method(var_product, 'add_to_cart_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'button_text', val: rt.call_method(var_product, 'single_add_to_cart_text', []rt.PhpVal{}) }])])
}

fn woocommerce_quantity_input(var_args_arg rt.PhpVal, var_product_arg rt.PhpVal, echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_args := var_args_arg
	mut var_product := var_product_arg
	mut var_GLOBALS := rt.new_null()
	var_product = if var_product.clone().is_null() { var_GLOBALS.array_get(rt.new_string('product')) } else { var_product }
	var_args = wc_get_quantity_input_args(var_args.clone(), var_product.clone())
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('global/quantity-input.php'), var_args.clone()])
	if var_echo {
		rt.echo_val(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	} else {
		return rt.call_function('ob_get_clean', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn woocommerce_product_description_tab() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/tabs/description.php')])
}

fn woocommerce_product_additional_information_tab() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/tabs/additional-information.php')])
}

fn woocommerce_default_product_tabs(var_tabs rt.PhpVal) rt.PhpVal {
	mut var_product := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.get_property(var_post, 'post_content')) {
		var_tabs.array_set('description', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'priority', val: 10 }, rt.ArrayItem{ key: 'callback', val: 'woocommerce_product_description_tab' }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return var_tabs.clone()
	}
	if rt.is_true(rt.call_method(var_product, 'has_attributes', []rt.PhpVal{})) || rt.is_true(rt.call_function('apply_filters', [rt.new_string('wc_product_enable_dimensions_display'), rt.new_bool(rt.is_true(rt.call_method(var_product, 'has_weight', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_product, 'has_dimensions', []rt.PhpVal{})))])) {
		var_tabs.array_set('additional_information', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Additional information'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'priority', val: 20 }, rt.ArrayItem{ key: 'callback', val: 'woocommerce_product_additional_information_tab' }]))
	}
	if rt.is_true(rt.call_function('comments_open', []rt.PhpVal{})) {
		var_tabs.array_set('reviews', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Reviews (%d)'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_review_count', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'priority', val: 30 }, rt.ArrayItem{ key: 'callback', val: 'comments_template' }]))
	}
	return var_tabs.clone()
}

fn woocommerce_sort_product_tabs(var_tabs_arg rt.PhpVal) i64 {
	mut var_tabs := var_tabs_arg
	if !(rt.create_array_from_native_map(var_tabs).is_array()) {
		rt.call_function('trigger_error', [rt.new_string('Function woocommerce_sort_product_tabs() expects an array as the first parameter. Defaulting to empty array.')])
	var_tabs = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('_sort_priority_callback')]))))) {
fn _sort_priority_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if (!(var_a.array_isset(rt.new_string('priority')) && var_b.array_isset(rt.new_string('priority')))) || rt.is_true(rt.identical(var_a.array_get(rt.new_string('priority')), var_b.array_get(rt.new_string('priority')))) {
		return 0
	}
	return if rt.is_true(rt.less(var_a.array_get(rt.new_string('priority')), var_b.array_get(rt.new_string('priority')))) { -1 } else { 1 }
}

fn woocommerce_comments(var_comment rt.PhpVal, var_args rt.PhpVal, var_depth rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('comment', var_comment.clone())
	rt.call_function('wc_get_template', [rt.new_string('single-product/review.php'), rt.create_array([rt.ArrayItem{ key: 'comment', val: var_comment }, rt.ArrayItem{ key: 'args', val: var_args }, rt.ArrayItem{ key: 'depth', val: var_depth }])])
}

fn woocommerce_review_display_gravatar(var_comment rt.PhpVal) {
	rt.echo_val(rt.call_function('get_avatar', [var_comment.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_review_gravatar_size'), rt.new_string('60')]), rt.new_string('')]))
}

fn woocommerce_review_display_rating() {
	if rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')])) {
		rt.call_function('wc_get_template', [rt.new_string('single-product/review-rating.php')])
	}
}

fn woocommerce_review_display_meta() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/review-meta.php')])
}

fn woocommerce_review_display_comment_text() {
	print('<div class="description">')
	rt.call_function('comment_text', []rt.PhpVal{})
	print('</div>')
}

fn woocommerce_output_related_products() {
	mut var_args := rt.new_null()
	var_args = rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: 4 }, rt.ArrayItem{ key: 'columns', val: 4 }, rt.ArrayItem{ key: 'orderby', val: 'rand' }])
	woocommerce_related_products(rt.call_function('apply_filters', [rt.new_string('woocommerce_output_related_products_args'), var_args.clone()]))
}

fn woocommerce_related_products(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_product := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_related_products := rt.new_null()
	mut var_related_product_ids := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	var_defaults = { 'posts_per_page': rt.new_int(2), 'columns': rt.new_int(2), 'orderby': rt.new_string('rand'), 'order': rt.new_string('desc') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_related_products = rt.new_array()
	var_related_product_ids = rt.call_function('wc_get_related_products', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_args.array_get(rt.new_string('posts_per_page')), rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{})])
	if !(!rt.is_true(var_related_product_ids)) {
		rt.call_function('_prime_post_caches', [var_related_product_ids.clone()])
		var_related_products = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_related_product_ids.clone()]), rt.new_string('wc_products_array_filter_visible')])
		var_related_products = rt.call_function('wc_products_array_orderby', [var_related_products.clone(), var_args.array_get(rt.new_string('orderby')), var_args.array_get(rt.new_string('order'))])
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
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		rt.call_function('_prime_post_caches', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_related_products.clone()])])])
	}
	var_args.array_set('related_products', var_related_products.clone())
	wc_set_loop_prop('name', 'related')
	wc_set_loop_prop('columns', rt.call_function('apply_filters', [rt.new_string('woocommerce_related_products_columns'), var_args.array_get(rt.new_string('columns'))]))
	rt.call_function('wc_get_template', [rt.new_string('single-product/related.php'), var_args.clone()])
}

fn woocommerce_upsell_display(var_limit_arg rt.PhpVal, columns i64, orderby string, order string) {
	mut var_columns := columns
	mut var_orderby := orderby
	mut var_order := order
	mut var_limit := var_limit_arg
	mut var_product := rt.new_null()
	mut var_args := rt.new_null()
	mut var_upsells := rt.new_null()
	mut var_upsell_ids := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_upsell_display_args'), rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: var_limit }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'columns', val: columns }])])
	wc_set_loop_prop('name', 'up-sells')
	wc_set_loop_prop('columns', rt.call_function('apply_filters', [rt.new_string('woocommerce_upsells_columns'), if var_args.array_isset(rt.new_string('columns')) { var_args.array_get(rt.new_string('columns')) } else { rt.new_int(columns) }]))
	var_orderby = (rt.call_function('apply_filters', [rt.new_string('woocommerce_upsells_orderby'), if var_args.array_isset(rt.new_string('orderby')) { var_args.array_get(rt.new_string('orderby')) } else { rt.new_string((var_orderby).str()) }])).str()
	var_order = (rt.call_function('apply_filters', [rt.new_string('woocommerce_upsells_order'), if var_args.array_isset(rt.new_string('order')) { var_args.array_get(rt.new_string('order')) } else { rt.new_string((var_order).str()) }])).str()
	var_limit = rt.call_function('apply_filters', [rt.new_string('woocommerce_upsells_total'), if !(var_args.array_get(rt.new_string('posts_per_page'))).is_null() { var_args.array_get(rt.new_string('posts_per_page')) } else { rt.new_int(var_limit) }]).to_i64()
	var_upsells = rt.new_array()
	var_upsell_ids = rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{})
	if !(!rt.is_true(var_upsell_ids)) {
		rt.call_function('_prime_post_caches', [var_upsell_ids.clone()])
		var_upsells = rt.call_function('wc_products_array_orderby', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_upsell_ids.clone()]), rt.new_string('wc_products_array_filter_visible')]), rt.new_string((var_orderby).str()), rt.new_string((var_order).str())])
		var_upsells = if var_limit > 0 { rt.call_function('array_slice', [var_upsells.clone(), rt.new_int(0), rt.new_int(var_limit).clone()]) } else { var_upsells }
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		rt.call_function('_prime_post_caches', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_upsells.clone()])])])
	}
	rt.call_function('wc_get_template', [rt.new_string('single-product/up-sells.php'), rt.create_array([rt.ArrayItem{ key: 'upsells', val: var_upsells }, rt.ArrayItem{ key: 'posts_per_page', val: var_limit }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'columns', val: columns }])])
}

fn woocommerce_shipping_calculator(button_text string) {
	mut var_button_text := button_text
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_shipping_calc')]))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-country-select')])
	rt.call_function('wc_get_template', [rt.new_string('cart/shipping-calculator.php'), rt.create_array([rt.ArrayItem{ key: 'button_text', val: button_text }])])
}

fn woocommerce_cart_totals() {
	if rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('cart/cart-totals.php')])
}

fn woocommerce_cross_sell_display(limit i64, columns i64, orderby string, order string) {
	mut var_limit := limit
	mut var_columns := columns
	mut var_orderby := orderby
	mut var_order := order
	mut var_product := rt.new_null()
	mut var_cross_sells := rt.new_null()
	mut var_cross_sell_ids := rt.new_null()
	if rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		return
	}
	var_cross_sells = rt.new_array()
	var_cross_sell_ids = if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cross_sells', []rt.PhpVal{}) } else { rt.new_array() }
	if !(!rt.is_true(var_cross_sell_ids)) {
		rt.call_function('_prime_post_caches', [var_cross_sell_ids.clone()])
	var_cross_sells = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_cross_sell_ids.clone()]), rt.new_string('wc_products_array_filter_visible')])
	}
	wc_set_loop_prop('name', 'cross-sells')
	wc_set_loop_prop('columns', rt.call_function('apply_filters', [rt.new_string('woocommerce_cross_sells_columns'), rt.new_int(columns)]))
	var_orderby = (rt.call_function('apply_filters', [rt.new_string('woocommerce_cross_sells_orderby'), rt.new_string((var_orderby).str())])).str()
	var_order = (rt.call_function('apply_filters', [rt.new_string('woocommerce_cross_sells_order'), rt.new_string((var_order).str())])).str()
	var_cross_sells = rt.call_function('wc_products_array_orderby', [var_cross_sells.clone(), rt.new_string((var_orderby).str()), rt.new_string((var_order).str())])
	var_limit = rt.call_function('apply_filters', [rt.new_string('woocommerce_cross_sells_total'), rt.new_int(var_limit)]).to_i64()
	var_cross_sells = if var_limit > 0 { rt.call_function('array_slice', [var_cross_sells.clone(), rt.new_int(0), rt.new_int(var_limit)]) } else { var_cross_sells }
	if !(!rt.is_true(var_cross_sells)) {
		closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
			}
		rt.call_function('_prime_post_caches', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_18_fn), var_cross_sells.clone()])])])
	}
	rt.call_function('wc_get_template', [rt.new_string('cart/cross-sells.php'), rt.create_array([rt.ArrayItem{ key: 'cross_sells', val: var_cross_sells }, rt.ArrayItem{ key: 'posts_per_page', val: var_limit }, rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'columns', val: columns }])])
}

fn woocommerce_button_proceed_to_checkout() {
	rt.call_function('wc_get_template', [rt.new_string('cart/proceed-to-checkout-button.php')])
}

fn woocommerce_widget_shopping_cart_button_view_cart() {
	mut var_wp_button_class := rt.new_null()
	var_wp_button_class = rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' }).str())
	mut iife_temp_25 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_25 := iife_temp_25.has_cart_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_25)))) {
		print('')
	}
	print('<a href="' + (rt.call_function('esc_url', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})])).str() + '" class="button wc-forward' + (rt.call_function('esc_attr', [var_wp_button_class.clone()])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('View cart'), rt.new_string('woocommerce')])).str() + '</a>')
}

fn woocommerce_widget_shopping_cart_proceed_to_checkout() {
	mut var_wp_button_class := rt.new_null()
	var_wp_button_class = rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' }).str())
	print('<a href="' + (rt.call_function('esc_url', [rt.call_function('wc_get_checkout_url', []rt.PhpVal{})])).str() + '" class="button checkout wc-forward' + (rt.call_function('esc_attr', [var_wp_button_class.clone()])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Checkout'), rt.new_string('woocommerce')])).str() + '</a>')
}

fn woocommerce_widget_shopping_cart_subtotal() {
	print('<strong>' + (rt.call_function('esc_html__', [rt.new_string('Subtotal:'), rt.new_string('woocommerce')])).str() + '</strong> ' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_subtotal', []rt.PhpVal{})).str())
}

fn woocommerce_mini_cart(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	var_defaults = { 'list_class': rt.new_string('') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('wc_get_template', [rt.new_string('cart/mini-cart.php'), var_args.clone()])
}

fn woocommerce_login_form(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	var_defaults = { 'message': rt.new_string(''), 'redirect': rt.new_string(''), 'hidden': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('wc_get_template', [rt.new_string('global/form-login.php'), var_args.clone()])
}

fn woocommerce_checkout_login_form() {
	rt.call_function('wc_get_template', [rt.new_string('checkout/form-login.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}) }])])
}

fn woocommerce_breadcrumb(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_breadcrumbs := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_defaults'), rt.create_array([rt.ArrayItem{ key: 'delimiter', val: '&nbsp;&#47;&nbsp;' }, rt.ArrayItem{ key: 'wrap_before', val: '<nav class="woocommerce-breadcrumb" aria-label="Breadcrumb">' }, rt.ArrayItem{ key: 'wrap_after', val: '</nav>' }, rt.ArrayItem{ key: 'before', val: '' }, rt.ArrayItem{ key: 'after', val: '' }, rt.ArrayItem{ key: 'home', val: rt.call_function('_x', [rt.new_string('Home'), rt.new_string('breadcrumb'), rt.new_string('woocommerce')]) }])])])
	var_breadcrumbs = create_wc_breadcrumb()
	if !(!rt.is_true(var_args.array_get(rt.new_string('home')))) {
		var_breadcrumbs.add_crumb(var_args.array_get(rt.new_string('home')), rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_home_url'), rt.call_function('home_url', []rt.PhpVal{})]))
	}
	var_args.array_set('breadcrumb', var_breadcrumbs.generate())
	rt.call_function('do_action', [rt.new_string('woocommerce_breadcrumb'), var_breadcrumbs, var_args.clone()])
	rt.call_function('wc_get_template', [rt.new_string('global/breadcrumb.php'), var_args.clone()])
}

fn woocommerce_order_review(deprecated bool) {
	mut var_deprecated := deprecated
	rt.call_function('wc_get_template', [rt.new_string('checkout/review-order.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}) }])])
}

fn woocommerce_checkout_payment() {
	mut var_available_gateways := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cart is not available. This may indicate that the function is being called before woocommerce_init or in an admin context.'), rt.new_string('woocommerce')]), rt.new_string('9.8.0')])
		return
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_payment', []rt.PhpVal{})) {
		var_available_gateways = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'get_available_payment_gateways', []rt.PhpVal{})
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'set_current_gateway', [var_available_gateways.clone()])
	} else {
	var_available_gateways = rt.new_array()
	}
	rt.call_function('wc_get_template', [rt.new_string('checkout/payment.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'available_gateways', val: var_available_gateways }, rt.ArrayItem{ key: 'order_button_text', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_order_button_text'), rt.call_function('__', [rt.new_string('Place order'), rt.new_string('woocommerce')])]) }])])
}

fn woocommerce_checkout_coupon_form() {
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) || rt.is_true(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}), 'is_registration_enabled', []rt.PhpVal{})) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}), 'is_registration_required', []rt.PhpVal{}))))) {
		rt.call_function('wc_get_template', [rt.new_string('checkout/form-coupon.php'), rt.create_array([rt.ArrayItem{ key: 'checkout', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}) }])])
	}
}

fn woocommerce_products_will_display() bool {
	mut var_display_type := rt.new_null()
	var_display_type = rt.new_string(woocommerce_get_loop_display_mode())
	return rt.is_true(rt.less(rt.new_int(0), wc_get_loop_prop('total', 0))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('subcategories'), var_display_type))))
}

fn woocommerce_get_loop_display_mode() string {
	mut var_parent_id := rt.new_null()
	mut var_display_type := rt.new_null()
	mut var_subcategories := rt.new_null()
	if rt.is_true(wc_get_loop_prop('is_search', '')) || rt.is_true(wc_get_loop_prop('is_filtered', '')) {
		return 'products'
	}
	var_parent_id = rt.new_int(0)
	var_display_type = rt.new_string('')
	if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
	var_display_type = rt.call_function('get_option', [rt.new_string('woocommerce_shop_page_display'), rt.new_string('')])
	} else if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
	var_parent_id = rt.call_function('get_queried_object_id', []rt.PhpVal{})
	var_display_type = rt.call_function('get_term_meta', [var_parent_id.clone(), rt.new_string('display_type'), rt.new_bool(true)])
	var_display_type = if rt.is_true(rt.identical(rt.new_string(''), var_display_type)) { rt.call_function('get_option', [rt.new_string('woocommerce_category_archive_display'), rt.new_string('')]) } else { var_display_type }
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('subcategories'), var_display_type)))) && rt.is_true(rt.less(rt.new_int(1), wc_get_loop_prop('current_page', ''))) {
		return 'products'
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_display_type)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_display_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'products' }, rt.ArrayItem{ key: none, val: 'subcategories' }, rt.ArrayItem{ key: none, val: 'both' }]), rt.new_bool(true)]))))) {
	var_display_type = rt.new_string('products')
	}
	if rt.is_true(rt.call_function('in_array', [var_display_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'subcategories' }, rt.ArrayItem{ key: none, val: 'both' }]), rt.new_bool(true)])) {
		var_subcategories = woocommerce_get_product_subcategories(var_parent_id.clone())
		if !rt.is_true(var_subcategories) {
		var_display_type = rt.new_string('products')
		}
	}
	return (var_display_type).str()
}

fn woocommerce_maybe_show_product_subcategories(loop_html string) string {
	mut var_loop_html := loop_html
	mut var_wp_query := rt.new_null()
	mut var_display_type := ''
	mut iife_temp_26 := Class_WC_Template_Loader{}
	mut iife_result_26 := iife_temp_26.in_content_filter()
	if rt.is_true(wc_get_loop_prop('is_shortcode', '')) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_26)))) {
		return loop_html
	}
	var_display_type = woocommerce_get_loop_display_mode()
	if rt.is_true(rt.identical(rt.new_string('subcategories'), rt.new_string((var_display_type).str()))) || rt.is_true(rt.identical(rt.new_string('both'), rt.new_string((var_display_type).str()))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.new_bool(woocommerce_output_product_categories(rt.create_array([rt.ArrayItem{ key: 'parent_id', val: if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) { rt.call_function('get_queried_object_id', []rt.PhpVal{}) } else { rt.new_int(0) } }])))
		loop_html = loop_html + (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		if rt.is_true(rt.identical(rt.new_string('subcategories'), rt.new_string((var_display_type).str()))) {
			wc_set_loop_prop('total', 0)
			if rt.is_true(rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{})) {
				rt.set_property(var_wp_query, 'post_count', rt.new_int(0))
				rt.set_property(var_wp_query, 'max_num_pages', rt.new_int(0))
			}
		}
	}
	return loop_html
}

fn woocommerce_output_product_categories(var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_product_categories := rt.new_null()
	mut var_category := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'before', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_before_output_product_categories'), rt.new_string('')]) }, rt.ArrayItem{ key: 'after', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_after_output_product_categories'), rt.new_string('')]) }, rt.ArrayItem{ key: 'parent_id', val: 0 }])])
	var_product_categories = woocommerce_get_product_subcategories(var_args.array_get(rt.new_string('parent_id')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_categories)))) {
		return false
	}
	rt.echo_val(var_args.array_get(rt.new_string('before')))
	mut iter_6 := var_product_categories.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_category_shadow := item_6.val
		rt.call_function('wc_get_template', [rt.new_string('content-product_cat.php'), rt.create_array([rt.ArrayItem{ key: 'category', val: var_category_shadow }])])
	}
	rt.echo_val(var_args.array_get(rt.new_string('after')))
	return true
}

fn woocommerce_get_product_subcategories(parent_id i64) rt.PhpVal {
	mut var_parent_id := parent_id
	mut var_cache_key := rt.new_null()
	mut var_product_categories := rt.new_null()
	var_parent_id = (rt.call_function('absint', [rt.new_int(var_parent_id)])).to_i64()
	var_cache_key = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_product_subcategories_cache_key'), rt.new_string('product-category-hierarchy-' + var_parent_id.str()), rt.new_int(var_parent_id)])
	var_product_categories = if rt.is_true(var_cache_key) { rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('product_cat')]) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_product_categories)) {
		var_product_categories = rt.call_function('get_categories', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_subcategories_args'), rt.create_array([rt.ArrayItem{ key: 'parent', val: var_parent_id }, rt.ArrayItem{ key: 'hide_empty', val: 0 }, rt.ArrayItem{ key: 'hierarchical', val: 1 }, rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' }, rt.ArrayItem{ key: 'pad_counts', val: 1 }])])])
		if rt.is_true(var_cache_key) {
			rt.call_function('wp_cache_set', [var_cache_key.clone(), var_product_categories.clone(), rt.new_string('product_cat')])
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_subcategories_hide_empty'), rt.new_bool(true)])) {
	var_product_categories = rt.call_function('wp_list_filter', [var_product_categories.clone(), rt.create_array([rt.ArrayItem{ key: 'count', val: 0 }]), rt.new_string('NOT')])
	}
	return var_product_categories.clone()
}

fn woocommerce_subcategory_thumbnail(var_category rt.PhpVal) {
	mut var_small_thumbnail_size := rt.new_null()
	mut var_dimensions := rt.new_null()
	mut var_thumbnail_id := rt.new_null()
	mut var_image_data := rt.new_null()
	mut var_image := rt.new_null()
	mut var_image_srcset := rt.new_null()
	mut var_image_sizes := rt.new_null()
	var_small_thumbnail_size = rt.call_function('apply_filters', [rt.new_string('subcategory_archive_thumbnail_size'), rt.new_string('woocommerce_thumbnail')])
	var_dimensions = rt.call_function('wc_get_image_size', [var_small_thumbnail_size.clone()])
	var_thumbnail_id = rt.call_function('get_term_meta', [rt.get_property(var_category, 'term_id'), rt.new_string('thumbnail_id'), rt.new_bool(true)])
	if rt.is_true(var_thumbnail_id) {
		var_image_data = rt.call_function('wp_get_attachment_image_src', [var_thumbnail_id.clone(), var_small_thumbnail_size.clone()])
		if var_image_data.clone().is_array() && var_image_data.array_isset(rt.new_int(0)) {
		var_image = var_image_data.array_get(rt.new_int(0))
		var_image_srcset = if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_attachment_image_srcset')])) { rt.call_function('wp_get_attachment_image_srcset', [var_thumbnail_id.clone(), var_small_thumbnail_size.clone()]) } else { rt.new_bool(false) }
		var_image_sizes = if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_attachment_image_sizes')])) { rt.call_function('wp_get_attachment_image_sizes', [var_thumbnail_id.clone(), var_small_thumbnail_size.clone()]) } else { rt.new_bool(false) }
		} else {
		var_image = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
		var_image_srcset = rt.new_bool(false)
		var_image_sizes = rt.new_bool(false)
		}
	} else {
	var_image = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
	var_image_srcset = rt.new_bool(false)
	var_image_sizes = rt.new_bool(false)
	}
	if rt.is_true(var_image) {
		var_image = rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('%20'), var_image.clone()])
		if rt.is_true(var_image_srcset) && rt.is_true(var_image_sizes) {
			print('<img src="' + (rt.call_function('esc_url', [var_image.clone()])).str() + '" alt="' + (rt.call_function('esc_attr', [rt.get_property(var_category, 'name')])).str() + '" width="' + (rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('width'))])).str() + '" height="' + (rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('height'))])).str() + '" srcset="' + (rt.call_function('esc_attr', [var_image_srcset.clone()])).str() + '" sizes="' + (rt.call_function('esc_attr', [var_image_sizes.clone()])).str() + '" />')
		} else {
			print('<img src="' + (rt.call_function('esc_url', [var_image.clone()])).str() + '" alt="' + (rt.call_function('esc_attr', [rt.get_property(var_category, 'name')])).str() + '" width="' + (rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('width'))])).str() + '" height="' + (rt.call_function('esc_attr', [var_dimensions.array_get(rt.new_string('height'))])).str() + '" />')
		}
	}
}

fn woocommerce_order_details_table(var_order_id rt.PhpVal) {
	mut var_order := rt.new_null()
	mut var_template := ''
	mut var_fulfillment_data_store := rt.new_null()
	mut var_fulfillments := rt.new_null()
	mut var_e := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return
	}
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return
	}
	var_template = 'order/order-details.php'
	mut iife_temp_27 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_27 := iife_temp_27.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_27) {
		mut iife_temp_28 := Class_WC_Data_Store{}
		mut iife_result_28 := iife_temp_28.load(rt.new_string('order-fulfillment'))
		var_fulfillment_data_store = iife_result_28
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_fulfillments = rt.call_method(var_fulfillment_data_store, 'read_fulfillments', [Class_WC_Order.class(), var_order_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !(!rt.is_true(var_fulfillments)) {
			var_template = 'order/order-details-fulfillments.php'
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Throwable') {
			var_e = var_e_1.clone()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %s: %s'), var_order_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	rt.call_function('wc_get_template', [rt.new_string((var_template).str()).clone(), rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'show_downloads', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_order_downloads_table_show_downloads'), rt.new_bool(rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))), var_order.clone()]) }])])
}

fn woocommerce_order_downloads_table(var_downloads rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_downloads)))) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('order/order-downloads.php'), rt.create_array([rt.ArrayItem{ key: 'downloads', val: var_downloads }])])
}

fn woocommerce_order_again_button(var_order rt.PhpVal) {
	mut var_statuses_for_reordering := rt.new_null()
	var_statuses_for_reordering = rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_order_again'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [var_statuses_for_reordering.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) || rt.is_true(rt.call_function('is_order_received_page', []rt.PhpVal{})) {
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('order/order-again.php'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'wp_button_class', val: if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' } }, rt.ArrayItem{ key: 'order_again_url', val: rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('order_again'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), rt.call_function('wc_get_cart_url', []rt.PhpVal{})]), rt.new_string('woocommerce-order_again')]) }])])
}

fn woocommerce_form_field(var_key rt.PhpVal, var_args_arg rt.PhpVal, var_value_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_value := var_value_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_custom_attributes := []rt.PhpVal{}
	mut var_required_indicator := rt.new_null()
	mut var_attribute_value := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_validate := rt.new_null()
	mut var_field := rt.new_null()
	mut var_label_id := rt.new_null()
	mut var_sort := rt.new_null()
	mut var_field_container := rt.new_null()
	mut var_is_hidden_field := false
	mut var_countries := rt.new_null()
	mut var_country_code := rt.new_null()
	mut var_country_name := rt.new_null()
	mut var_data_label := rt.new_null()
	mut var_cvalue := rt.new_null()
	mut var_ckey := rt.new_null()
	mut var_for_country := rt.new_null()
	mut var_states := rt.new_null()
	mut var_options := rt.new_null()
	mut var_option_text := rt.new_null()
	mut var_option_key := rt.new_null()
	mut var_field_html := ''
	mut var_maybe_for_attr := rt.new_null()
	mut var_container_class := rt.new_null()
	mut var_container_id := rt.new_null()
	var_defaults = { 'type': rt.new_string('text'), 'label': rt.new_string(''), 'description': rt.new_string(''), 'placeholder': rt.new_string(''), 'maxlength': rt.new_bool(false), 'minlength': rt.new_bool(false), 'required': rt.new_bool(false), 'autocomplete': rt.new_bool(false), 'id': var_key, 'class': rt.new_array(), 'label_class': rt.new_array(), 'input_class': rt.new_array(), 'return': rt.new_bool(false), 'options': rt.new_array(), 'custom_attributes': rt.new_array(), 'validate': rt.new_array(), 'default': rt.new_string(''), 'autofocus': rt.new_string(''), 'priority': rt.new_string(''), 'unchecked_value': rt.new_null(), 'checked_value': rt.new_string('1') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_form_field_args'), var_args.clone(), var_key.clone(), var_value.clone()])
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('class')).is_string())) {
		var_args.array_set('class', rt.create_array([rt.ArrayItem{ key: none, val: var_args.array_get(rt.new_string('class')) }]))
	}
	if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('label_class')).is_string())) {
		var_args.array_set('label_class', rt.create_array([rt.ArrayItem{ key: none, val: var_args.array_get(rt.new_string('label_class')) }]))
	}
	if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
	var_value = var_args.array_get(rt.new_string('default'))
	}
	var_custom_attributes = rt.new_array()
	var_args.array_set('custom_attributes', rt.call_function('array_filter', [rt.cast_array(var_args.array_get(rt.new_string('custom_attributes'))), rt.new_string('strlen')]))
	if rt.is_true(var_args.array_get(rt.new_string('required'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'hidden' }, rt.ArrayItem{ key: none, val: 'checkbox' }]), rt.new_bool(true)]))))) {
			var_args.array_get_mut('custom_attributes').array_set('aria-required', 'true')
			var_args.array_get_mut('label_class').array_push('required_field')
		}
		var_args.array_get_mut('class').array_push('validate-required')
	var_required_indicator = rt.new_string('&nbsp;<span class="required" aria-hidden="true">*</span>')
	} else {
	var_required_indicator = rt.new_string('&nbsp;<span class="optional">(' + (rt.call_function('esc_html__', [rt.new_string('optional'), rt.new_string('woocommerce')])).str() + ')</span>')
	}
	if rt.is_true(var_args.array_get(rt.new_string('maxlength'))) {
		var_args.array_get_mut('custom_attributes').array_set('maxlength', rt.call_function('absint', [var_args.array_get(rt.new_string('maxlength'))]))
	}
	if rt.is_true(var_args.array_get(rt.new_string('minlength'))) {
		var_args.array_get_mut('custom_attributes').array_set('minlength', rt.call_function('absint', [var_args.array_get(rt.new_string('minlength'))]))
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('autocomplete')))) {
		var_args.array_get_mut('custom_attributes').array_set('autocomplete', var_args.array_get(rt.new_string('autocomplete')))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_args.array_get(rt.new_string('autofocus')))) {
		var_args.array_get_mut('custom_attributes').array_set('autofocus', 'autofocus')
	}
	if rt.is_true(var_args.array_get(rt.new_string('description'))) {
		var_args.array_get_mut('custom_attributes').array_set('aria-describedby', (var_args.array_get(rt.new_string('id'))).str() + '-description')
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('custom_attributes')))) && var_args.array_get(rt.new_string('custom_attributes')).is_array() {
		mut iter_7 := var_args.array_get(rt.new_string('custom_attributes')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_attribute_value_shadow := item_7.val
			mut var_attribute_shadow := item_7.key
			var_custom_attributes << (rt.call_function('esc_attr', [var_attribute_shadow.clone()])).str() + '="' + (rt.call_function('esc_attr', [var_attribute_value_shadow.clone()])).str() + '"'
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('validate')))) {
		mut iter_8 := var_args.array_get(rt.new_string('validate')).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_validate_shadow := item_8.val
			var_args.array_get_mut('class').array_push('validate-' + (var_validate_shadow).str())
		}
	}
	var_field = rt.new_string('')
	var_label_id = var_args.array_get(rt.new_string('id'))
	var_sort = if rt.is_true(var_args.array_get(rt.new_string('priority'))) { var_args.array_get(rt.new_string('priority')) } else { rt.new_string('') }
	var_field_container = rt.new_string('<p class="form-row %1$s" id="%2$s" data-priority="' + (rt.call_function('esc_attr', [var_sort.clone()])).str() + '">%3$s</p>')
	var_is_hidden_field = false
	mut switch_val_3 := var_args.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('country'))) {
		var_countries = if rt.is_true(rt.identical(rt.new_string('shipping_country'), var_key)) { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}) } else { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{}) }
		if 1 == var_countries.clone().array_count() {
			var_country_code = rt.call_function('current', [rt.func_array_keys(var_countries.clone())])
			var_country_name = rt.call_function('current', [rt.call_function('array_values', [var_countries.clone()])])
			var_field = rt.concat(var_field, rt.new_string('<select name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' class="country_to_state country_to_state--single ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '">'))
			var_field = rt.concat(var_field, rt.new_string('<option value="' + (rt.call_function('esc_attr', [var_country_code.clone()])).str() + '" selected>' + (rt.call_function('esc_html', [var_country_name.clone()])).str() + '</option>'))
			var_field = rt.concat(var_field, rt.new_string('</select>'))
		} else {
			var_data_label = rt.new_string((if !(!rt.is_true(var_args.array_get(rt.new_string('label')))) { 'data-label="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('label'))])).str() + '"' } else { '' }).str())
			var_field = rt.new_string('<select name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" class="country_to_state country_select ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' data-placeholder="' + (rt.call_function('esc_attr', [if rt.is_true(var_args.array_get(rt.new_string('placeholder'))) { var_args.array_get(rt.new_string('placeholder')) } else { rt.call_function('esc_attr__', [rt.new_string('Select a country / region&hellip;'), rt.new_string('woocommerce')]) }])).str() + '" ' + (var_data_label).str() + '><option value="">' + (rt.call_function('esc_html__', [rt.new_string('Select a country / region&hellip;'), rt.new_string('woocommerce')])).str() + '</option>')
			mut iter_9 := var_countries.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_cvalue_shadow := item_9.val
				mut var_ckey_shadow := item_9.key
				var_field = rt.concat(var_field, rt.new_string('<option value="' + (rt.call_function('esc_attr', [var_ckey_shadow.clone()])).str() + '" ' + (rt.call_function('selected', [var_value.clone(), var_ckey_shadow.clone(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_cvalue_shadow.clone()])).str() + '</option>'))
			}
			var_field = rt.concat(var_field, rt.new_string('</select>'))
			var_field = rt.concat(var_field, rt.new_string('<noscript><button type="submit" name="woocommerce_checkout_update_totals" value="' + (rt.call_function('esc_attr__', [rt.new_string('Update country / region'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Update country / region'), rt.new_string('woocommerce')])).str() + '</button></noscript>'))
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('state'))) {
		var_for_country = if var_args.array_isset(rt.new_string('country')) { var_args.array_get(rt.new_string('country')) } else { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'checkout'), 'get_value', [rt.new_string((if rt.is_true(rt.identical(rt.new_string('billing_state'), var_key)) { 'billing_country' } else { 'shipping_country' }).str())]) }
		var_states = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_states', [var_for_country.clone()])
		if var_states.clone().is_array() && !rt.is_true(var_states) {
			var_field_container = rt.new_string('<p class="form-row %1$s" id="%2$s" style="display: none">%3$s</p>')
			var_field = rt.concat(var_field, rt.new_string('<input type="hidden" class="hidden" name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" value="" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' placeholder="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('placeholder'))])).str() + '" readonly="readonly" data-input-classes="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '"/>'))
		} else if !(var_for_country.clone().is_null()) && var_states.clone().is_array() {
			var_data_label = rt.new_string((if !(!rt.is_true(var_args.array_get(rt.new_string('label')))) { 'data-label="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('label'))])).str() + '"' } else { '' }).str())
			var_field = rt.concat(var_field, rt.new_string('<select name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" class="state_select ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' data-placeholder="' + (rt.call_function('esc_attr', [if rt.is_true(var_args.array_get(rt.new_string('placeholder'))) { var_args.array_get(rt.new_string('placeholder')) } else { rt.call_function('esc_html__', [rt.new_string('Select an option&hellip;'), rt.new_string('woocommerce')]) }])).str() + '"  data-input-classes="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" ' + (var_data_label).str() + '>\n\t\t\t\t\t\t<option value="">' + (rt.call_function('esc_html__', [rt.new_string('Select an option&hellip;'), rt.new_string('woocommerce')])).str() + '</option>'))
			mut iter_10 := var_states.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_cvalue_shadow := item_10.val
				mut var_ckey_shadow := item_10.key
				var_field = rt.concat(var_field, rt.new_string('<option value="' + (rt.call_function('esc_attr', [var_ckey_shadow.clone()])).str() + '" ' + (rt.call_function('selected', [var_value.clone(), var_ckey_shadow.clone(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_cvalue_shadow.clone()])).str() + '</option>'))
			}
			var_field = rt.concat(var_field, rt.new_string('</select>'))
		} else {
			var_field = rt.concat(var_field, rt.new_string('<input type="text" class="input-text ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() + '"  placeholder="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('placeholder'))])).str() + '" name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' data-input-classes="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '"/>'))
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('textarea'))) {
		var_field = rt.concat(var_field, rt.new_string('<textarea name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" class="input-text ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" placeholder="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('placeholder'))])).str() + '" ' + if !rt.is_true(var_args.array_get(rt.new_string('custom_attributes')).array_get(rt.new_string('rows'))) { ' rows="2"' } else { '' } + if !rt.is_true(var_args.array_get(rt.new_string('custom_attributes')).array_get(rt.new_string('cols'))) { ' cols="5"' } else { '' } + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + '>' + (rt.call_function('esc_textarea', [var_value.clone()])).str() + '</textarea>'))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('checkbox'))) {
		var_field = rt.new_string('<label class="checkbox ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('label_class'))])])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + '>')
		if !(var_args.array_get(rt.new_string('unchecked_value')).is_null()) {
			var_field = rt.concat(var_field, rt.call_function('sprintf', [rt.new_string('<input type="hidden" name="%1$s" value="%2$s" />'), rt.call_function('esc_attr', [var_key.clone()]), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('unchecked_value'))])]))
		}
		var_field = rt.concat(var_field, rt.call_function('sprintf', [rt.new_string('<input type="checkbox" name="%1$s" id="%2$s" value="%3$s" class="%4$s" %5$s%6$s /> %7$s'), rt.call_function('esc_attr', [var_key.clone()]), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))]), rt.call_function('esc_attr', [var_args.array_get(rt.new_string('checked_value'))]), rt.call_function('esc_attr', [rt.new_string('input-checkbox ' + (rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])).str())]), rt.call_function('checked', [var_value.clone(), var_args.array_get(rt.new_string('checked_value')), rt.new_bool(false)]), rt.new_string((if rt.is_true(var_args.array_get(rt.new_string('required'))) { ' aria-required="true"' } else { '' }).str()), rt.call_function('wp_kses_post', [var_args.array_get(rt.new_string('label'))])]))
		var_field = rt.concat(var_field, rt.new_string((var_required_indicator).str() + '</label>'))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('text'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('password'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('datetime'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('datetime-local'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('date'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('month'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('time'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('week'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('number'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('email'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('url'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('tel'))) {
		var_field = rt.concat(var_field, rt.new_string('<input type="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('type'))])).str() + '" class="input-text ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" placeholder="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('placeholder'))])).str() + '"  value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' />'))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('hidden'))) {
		var_field = rt.concat(var_field, rt.new_string('<input type="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('type'))])).str() + '" class="input-hidden ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" value="' + (rt.call_function('esc_attr', [var_value.clone()])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' />'))
	var_is_hidden_field = true
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('select'))) {
		var_options = rt.new_string('')
		if !(!rt.is_true(var_args.array_get(rt.new_string('options')))) {
			mut iter_11 := var_args.array_get(rt.new_string('options')).iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_option_text_shadow := item_11.val
				mut var_option_key_shadow := item_11.key
				if rt.is_true(rt.identical(rt.new_string(''), var_option_key_shadow)) {
					if !rt.is_true(var_args.array_get(rt.new_string('placeholder'))) {
						var_args.array_set('placeholder', if rt.is_true(var_option_text_shadow) { var_option_text_shadow } else { rt.call_function('__', [rt.new_string('Choose an option'), rt.new_string('woocommerce')]) })
					}
					var_custom_attributes << 'data-allow_clear="true"'
				}
				var_options = rt.concat(var_options, rt.new_string('<option value="' + (rt.call_function('esc_attr', [var_option_key_shadow.clone()])).str() + '" ' + (rt.call_function('selected', [var_value.clone(), var_option_key_shadow.clone(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_option_text_shadow.clone()])).str() + '</option>'))
			}
			var_field = rt.concat(var_field, rt.new_string('<select name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '" class="select ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' data-placeholder="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('placeholder'))])).str() + '">\n\t\t\t\t\t\t\t' + (var_options).str() + '\n\t\t\t\t\t\t</select>'))
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('radio'))) {
		var_label_id = rt.concat(var_label_id, rt.new_string('_' + (rt.call_function('current', [rt.func_array_keys(var_args.array_get(rt.new_string('options')))])).str()))
		if !(!rt.is_true(var_args.array_get(rt.new_string('options')))) {
			mut iter_12 := var_args.array_get(rt.new_string('options')).iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_option_text_shadow := item_12.val
				mut var_option_key_shadow := item_12.key
				var_field = rt.concat(var_field, rt.new_string('<input type="radio" class="input-radio ' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('input_class'))])])).str() + '" value="' + (rt.call_function('esc_attr', [var_option_key_shadow.clone()])).str() + '" name="' + (rt.call_function('esc_attr', [var_key.clone()])).str() + '" ' + (rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])).str() + ' id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '_' + (rt.call_function('esc_attr', [var_option_key_shadow.clone()])).str() + '"' + (rt.call_function('checked', [var_value.clone(), var_option_key_shadow.clone(), rt.new_bool(false)])).str() + ' />'))
				var_field = rt.concat(var_field, rt.new_string('<label for="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '_' + (rt.call_function('esc_attr', [var_option_key_shadow.clone()])).str() + '" class="radio ' + (rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('label_class'))])).str() + '">' + (rt.call_function('esc_html', [var_option_text_shadow.clone()])).str() + (var_required_indicator).str() + '</label>'))
			}
		}
	}
	if !(!rt.is_true(var_field)) {
		var_field_html = ''
		if rt.is_true(var_args.array_get(rt.new_string('label'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('checkbox'), var_args.array_get(rt.new_string('type')))))) {
			var_maybe_for_attr = rt.new_string((if var_is_hidden_field { '' } else { ' for="' + (rt.call_function('esc_attr', [var_label_id.clone()])).str() + '"' }).str())
			var_field_html = var_field_html + '<label' + (var_maybe_for_attr).str() + ' class="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('label_class'))])])).str() + '">' + (rt.call_function('wp_kses_post', [var_args.array_get(rt.new_string('label'))])).str() + (var_required_indicator).str() + '</label>'
		}
		var_field_html = var_field_html + '<span class="woocommerce-input-wrapper">' + (var_field).str()
		if rt.is_true(var_args.array_get(rt.new_string('description'))) {
			var_field_html = var_field_html + '<span class="description" id="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '-description" aria-hidden="true">' + (rt.call_function('wp_kses_post', [var_args.array_get(rt.new_string('description'))])).str() + '</span>'
		}
		var_field_html = var_field_html + '</span>'
	var_container_class = rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_args.array_get(rt.new_string('class'))])])
	var_container_id = rt.new_string((rt.call_function('esc_attr', [var_args.array_get(rt.new_string('id'))])).str() + '_field')
	var_field = rt.call_function('sprintf', [var_field_container.clone(), var_container_class.clone(), var_container_id.clone(), rt.new_string((var_field_html).str()).clone()])
	}
	var_field = rt.call_function('apply_filters', [rt.new_string('woocommerce_form_field_' + (var_args.array_get(rt.new_string('type'))).str()), var_field.clone(), var_key.clone(), var_args.clone(), var_value.clone()])
	var_field = rt.call_function('apply_filters', [rt.new_string('woocommerce_form_field'), var_field.clone(), var_key.clone(), var_args.clone(), var_value.clone()])
	if rt.is_true(var_args.array_get(rt.new_string('return'))) {
		return var_field.clone()
	} else {
		rt.echo_val(var_field)
	}
	return rt.new_null()
}

fn get_product_search_form(echo bool) rt.PhpVal {
	mut var_echo := echo
	mut var_product_search_form_index := i64(0)
	mut var_form := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	if var_product_search_form_index == 0 {
	var_product_search_form_index = 0
	}
	rt.call_function('do_action', [rt.new_string('pre_get_product_search_form')])
	rt.call_function('wc_get_template', [rt.new_string('product-searchform.php'), rt.create_array([rt.ArrayItem{ key: 'index', val: rt.post_inc(rt.new_int(var_product_search_form_index)) }])])
	var_form = rt.call_function('apply_filters', [rt.new_string('get_product_search_form'), rt.call_function('ob_get_clean', []rt.PhpVal{})])
	if !(var_echo) {
		return var_form.clone()
	}
	rt.echo_val(var_form)
	return rt.new_null()
}

fn woocommerce_output_auth_header() {
	rt.call_function('wc_get_template', [rt.new_string('auth/header.php')])
}

fn woocommerce_output_auth_footer() {
	rt.call_function('wc_get_template', [rt.new_string('auth/footer.php')])
}

fn woocommerce_single_variation() {
	print('<div class="woocommerce-variation single_variation" role="alert" aria-relevant="additions"></div>')
}

fn woocommerce_single_variation_add_to_cart_button() {
	rt.call_function('wc_get_template', [rt.new_string('single-product/add-to-cart/variation-add-to-cart-button.php')])
}

fn wc_dropdown_variation_attribute_options(var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_selected_key := rt.new_null()
	mut var_options := rt.new_null()
	mut var_product := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_name := rt.new_null()
	mut var_id := rt.new_null()
	mut var_class := rt.new_null()
	mut var_required := rt.new_null()
	mut var_show_option_none := rt.new_null()
	mut var_show_option_none_text := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_html := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	mut var_option := rt.new_null()
	mut var_selected := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [rt.call_function('apply_filters', [rt.new_string('woocommerce_dropdown_variation_attribute_options_args'), var_args.clone()]), rt.create_array([rt.ArrayItem{ key: 'options', val: false }, rt.ArrayItem{ key: 'attribute', val: false }, rt.ArrayItem{ key: 'product', val: false }, rt.ArrayItem{ key: 'selected', val: false }, rt.ArrayItem{ key: 'required', val: false }, rt.ArrayItem{ key: 'name', val: '' }, rt.ArrayItem{ key: 'aria-label', val: false }, rt.ArrayItem{ key: 'id', val: '' }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [rt.new_string('Choose an option'), rt.new_string('woocommerce')]) }])])
	if rt.is_true(rt.identical(rt.new_bool(false), var_args.array_get(rt.new_string('selected')))) && rt.is_true(var_args.array_get(rt.new_string('attribute'))) && rt.is_true(rt.new_bool(rt.instance_of(var_args.array_get(rt.new_string('product')), 'WC_Product'))) {
		var_selected_key = rt.new_string('attribute_' + (rt.call_function('sanitize_title', [var_args.array_get(rt.new_string('attribute'))])).str())
		var_args.array_set('selected', if rt.get_superglobal('_REQUEST').array_isset(var_selected_key) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(var_selected_key)])]) } else { rt.call_method(var_args.array_get(rt.new_string('product')), 'get_variation_default_attribute', [var_args.array_get(rt.new_string('attribute'))]) })
	}
	var_options = var_args.array_get(rt.new_string('options'))
	var_product = var_args.array_get(rt.new_string('product'))
	var_attribute = var_args.array_get(rt.new_string('attribute'))
	var_name = if rt.is_true(var_args.array_get(rt.new_string('name'))) { var_args.array_get(rt.new_string('name')) } else { 'attribute_' + (rt.call_function('sanitize_title', [var_attribute.clone()])).str() }
	var_id = if rt.is_true(var_args.array_get(rt.new_string('id'))) { var_args.array_get(rt.new_string('id')) } else { rt.call_function('sanitize_title', [var_attribute.clone()]) }
	var_class = var_args.array_get(rt.new_string('class'))
	var_required = rt.new_bool((var_args.array_get(rt.new_string('required'))).to_bool())
	var_show_option_none = rt.new_bool((var_args.array_get(rt.new_string('show_option_none'))).to_bool())
	var_show_option_none_text = if rt.is_true(var_args.array_get(rt.new_string('show_option_none'))) { var_args.array_get(rt.new_string('show_option_none')) } else { rt.call_function('__', [rt.new_string('Choose an option'), rt.new_string('woocommerce')]) }
	if !rt.is_true(var_options) && !(!rt.is_true(var_product)) && !(!rt.is_true(var_attribute)) {
	var_attributes = rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{})
	var_options = var_attributes.array_get(var_attribute)
	}
	var_html = rt.new_string('<select id="' + (rt.call_function('esc_attr', [var_id.clone()])).str() + '" class="' + (rt.call_function('esc_attr', [var_class.clone()])).str() + '" name="' + (rt.call_function('esc_attr', [var_name.clone()])).str() + if rt.is_true(var_args.array_get(rt.new_string('aria-label'))) { '" aria-label="' + (rt.call_function('esc_attr', [var_args.array_get(rt.new_string('aria-label'))])).str() } else { '' } + '" data-attribute_name="attribute_' + (rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_attribute.clone()])])).str() + '" data-show_option_none="' + if rt.is_true(var_show_option_none) { 'yes' } else { 'no' } + '"' + if rt.is_true(var_required) { ' required' } else { '' } + '>')
	var_html = rt.concat(var_html, rt.new_string('<option value="">' + (rt.call_function('esc_html', [var_show_option_none_text.clone()])).str() + '</option>'))
	if !(!rt.is_true(var_options)) {
		if rt.is_true(var_product) && rt.is_true(rt.call_function('taxonomy_exists', [var_attribute.clone()])) {
			var_terms = rt.call_function('wc_get_product_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_attribute.clone(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'all' }])])
			mut iter_13 := var_terms.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_term_shadow := item_13.val
				if rt.is_true(rt.call_function('in_array', [rt.get_property(var_term_shadow, 'slug'), var_options.clone(), rt.new_bool(true)])) {
					var_html = rt.concat(var_html, rt.new_string('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_term_shadow, 'slug')])).str() + '" ' + (rt.call_function('selected', [rt.call_function('sanitize_title', [var_args.array_get(rt.new_string('selected'))]), rt.get_property(var_term_shadow, 'slug'), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), rt.get_property(var_term_shadow, 'name'), var_term_shadow.clone(), var_attribute.clone(), var_product.clone()])])).str() + '</option>'))
				}
			}
		} else {
			mut iter_14 := var_options.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_option_shadow := item_14.val
				var_selected = if rt.is_true(rt.identical(rt.call_function('sanitize_title', [var_args.array_get(rt.new_string('selected'))]), var_args.array_get(rt.new_string('selected')))) { rt.call_function('selected', [var_args.array_get(rt.new_string('selected')), rt.call_function('sanitize_title', [var_option_shadow.clone()]), rt.new_bool(false)]) } else { rt.call_function('selected', [var_args.array_get(rt.new_string('selected')), var_option_shadow.clone(), rt.new_bool(false)]) }
				var_html = rt.concat(var_html, rt.new_string('<option value="' + (rt.call_function('esc_attr', [var_option_shadow.clone()])).str() + '" ' + (var_selected).str() + '>' + (rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), var_option_shadow.clone(), rt.new_null(), var_attribute.clone(), var_product.clone()])])).str() + '</option>'))
			}
		}
	}
	var_html = rt.concat(var_html, rt.new_string('</select>'))
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_dropdown_variation_attribute_options_html'), var_html.clone(), var_args.clone()]))
}

fn woocommerce_account_content() {
	mut var_wp := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	if !(!rt.is_true(rt.get_property(var_wp, 'query_vars'))) {
		mut iter_15 := rt.get_property(var_wp, 'query_vars').iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_value_shadow := item_15.val
			mut var_key_shadow := item_15.key
			if rt.is_true(rt.identical(rt.new_string('pagename'), var_key_shadow)) {
				continue
			}
			if rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_account_' + (var_key_shadow).str() + '_endpoint')])) {
				rt.call_function('do_action', [rt.new_string('woocommerce_account_' + (var_key_shadow).str() + '_endpoint'), var_value_shadow.clone()])
				return
			}
		}
	}
	rt.call_function('wc_get_template', [rt.new_string('myaccount/dashboard.php'), rt.create_array([rt.ArrayItem{ key: 'current_user', val: rt.call_function('get_user_by', [rt.new_string('id'), rt.call_function('get_current_user_id', []rt.PhpVal{})]) }])])
}

fn woocommerce_account_navigation() {
	rt.call_function('wc_get_template', [rt.new_string('myaccount/navigation.php')])
}

fn woocommerce_account_orders(var_current_page_arg rt.PhpVal) {
	mut var_current_page := var_current_page_arg
	mut var_customer_orders := rt.new_null()
	var_current_page = if !rt.is_true(var_current_page) { rt.new_int(1) } else { rt.call_function('absint', [var_current_page.clone()]) }
	var_customer_orders = rt.call_function('wc_get_orders', [rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_my_orders_query'), rt.create_array([rt.ArrayItem{ key: 'customer', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'page', val: var_current_page }, rt.ArrayItem{ key: 'paginate', val: true }])])])
	rt.call_function('wc_get_template', [rt.new_string('myaccount/orders.php'), rt.create_array([rt.ArrayItem{ key: 'current_page', val: rt.call_function('absint', [var_current_page.clone()]) }, rt.ArrayItem{ key: 'customer_orders', val: var_customer_orders }, rt.ArrayItem{ key: 'has_orders', val: rt.less(rt.new_int(0), rt.get_property(var_customer_orders, 'total')) }, rt.ArrayItem{ key: 'wp_button_class', val: if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { '' } }])])
}

fn woocommerce_account_view_order(var_order_id rt.PhpVal) {
mut iife_temp_29 := Class_WC_Shortcode_My_Account{}
mut iife_result_29 := iife_temp_29.view_order(rt.call_function('absint', [var_order_id.clone()]))
}

fn woocommerce_account_downloads() {
	rt.call_function('wc_get_template', [rt.new_string('myaccount/downloads.php')])
}

fn woocommerce_account_edit_address(var_type_arg rt.PhpVal) {
	mut var_type := var_type_arg
var_type = rt.call_function('wc_edit_address_i18n', [rt.call_function('sanitize_title', [var_type.clone()]), rt.new_bool(true)])
mut iife_temp_30 := Class_WC_Shortcode_My_Account{}
mut iife_result_30 := iife_temp_30.edit_address(var_type.clone())
}

fn woocommerce_account_payment_methods() {
	rt.call_function('wc_get_template', [rt.new_string('myaccount/payment-methods.php')])
}

fn woocommerce_account_add_payment_method() {
mut iife_temp_31 := Class_WC_Shortcode_My_Account{}
mut iife_result_31 := iife_temp_31.add_payment_method()
}

fn woocommerce_account_edit_account() {
mut iife_temp_32 := Class_WC_Shortcode_My_Account{}
mut iife_result_32 := iife_temp_32.edit_account()
}

fn wc_no_products_found() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_print_notice')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.new_string('Function should only be used during frontend requests.'), rt.new_string('9.8.0')])
		return
	}
	rt.call_function('wc_get_template', [rt.new_string('loop/no-products-found.php')])
}

fn wc_get_email_order_items(var_order rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_email_improvements_enabled := rt.new_null()
	mut var_image_size := i64(0)
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_template := ''
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iife_temp_33 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_33 := iife_temp_33.feature_is_enabled(rt.new_string('email_improvements'))
	var_email_improvements_enabled = iife_result_33
	var_image_size = if rt.is_true(var_email_improvements_enabled) { 48 } else { 32 }
	var_defaults = { 'show_sku': rt.new_bool(false), 'show_image': var_email_improvements_enabled, 'image_size': map[string]rt.PhpVal{}, 'plain_text': rt.new_bool(false), 'sent_to_admin': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_template = if rt.is_true(var_args.array_get(rt.new_string('plain_text'))) { 'emails/plain/email-order-items.php' } else { 'emails/email-order-items.php' }
	rt.call_function('wc_get_template', [rt.new_string((var_template).str()).clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_items_args'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'items', val: rt.call_method(var_order, 'get_items', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'show_download_links', val: rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('sent_to_admin')))))) }, rt.ArrayItem{ key: 'show_sku', val: var_args.array_get(rt.new_string('show_sku')) }, rt.ArrayItem{ key: 'show_purchase_note', val: rt.is_true(rt.call_method(var_order, 'is_paid', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('sent_to_admin')))))) }, rt.ArrayItem{ key: 'show_image', val: var_args.array_get(rt.new_string('show_image')) }, rt.ArrayItem{ key: 'image_size', val: var_args.array_get(rt.new_string('image_size')) }, rt.ArrayItem{ key: 'plain_text', val: var_args.array_get(rt.new_string('plain_text')) }, rt.ArrayItem{ key: 'sent_to_admin', val: var_args.array_get(rt.new_string('sent_to_admin')) }])])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_order_items_table'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_order.clone()])
}

fn wc_get_email_fulfillment_items(var_order rt.PhpVal, var_fulfillment rt.PhpVal, var_args_arg rt.PhpVal) string {
	mut var_args := var_args_arg
	mut var_email_improvements_enabled := rt.new_null()
	mut var_image_size := i64(0)
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_template := ''
	mut var_fulfillment_items := rt.new_null()
	mut var_order_items := rt.new_null()
	mut var_order_items_filtered := []rt.PhpVal{}
	mut var_fulfillment_item := map[string]rt.PhpVal{}
	mut var_order_item := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iife_temp_34 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_34 := iife_temp_34.feature_is_enabled(rt.new_string('email_improvements'))
	var_email_improvements_enabled = iife_result_34
	var_image_size = if rt.is_true(var_email_improvements_enabled) { 48 } else { 32 }
	var_defaults = { 'show_sku': rt.new_bool(false), 'show_image': var_email_improvements_enabled, 'image_size': map[string]rt.PhpVal{}, 'plain_text': rt.new_bool(false), 'sent_to_admin': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	var_template = if rt.is_true(var_args.array_get(rt.new_string('plain_text'))) { 'emails/plain/email-fulfillment-items.php' } else { 'emails/email-fulfillment-items.php' }
	var_fulfillment_items = rt.call_method(var_fulfillment, 'get_items', []rt.PhpVal{})
	if !rt.is_true(var_fulfillment_items) {
		return ''
	}
	var_order_items = rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	if !rt.is_true(var_order_items) {
		return ''
	}
	var_order_items_filtered = rt.new_array()
	mut iter_16 := var_fulfillment_items.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_fulfillment_item_shadow := item_16.val
		mut iter_17 := var_order_items.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_order_item_shadow := item_17.val
			if rt.is_true(rt.identical(rt.call_method(var_order_item_shadow, 'get_id', []rt.PhpVal{}), var_fulfillment_item_shadow['item_id'])) {
				if rt.is_true(rt.call_function('method_exists', [var_order_item_shadow.clone(), rt.new_string('get_subtotal')])) && rt.is_true(rt.call_function('method_exists', [var_order_item_shadow.clone(), rt.new_string('set_subtotal')])) && rt.is_true(rt.call_function('method_exists', [var_order_item_shadow.clone(), rt.new_string('get_quantity')])) {
					rt.call_method(var_order_item_shadow, 'set_subtotal', [rt.div(rt.mul(rt.call_method(var_order_item_shadow, 'get_subtotal', []rt.PhpVal{}), var_fulfillment_item_shadow['qty']), rt.call_method(var_order_item_shadow, 'get_quantity', []rt.PhpVal{}))])
				}
				var_order_items_filtered << rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_order_item_shadow, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'qty', val: var_fulfillment_item_shadow['qty'] }, rt.ArrayItem{ key: 'item', val: var_order_item_shadow }]))
				break
			}
		}
	}
	rt.call_function('wc_get_template', [rt.new_string((var_template).str()).clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_email_fulfillment_items_args'), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }, rt.ArrayItem{ key: 'fulfillment', val: var_fulfillment }, rt.ArrayItem{ key: 'items', val: var_order_items_filtered }, rt.ArrayItem{ key: 'show_download_links', val: rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('sent_to_admin')))))) }, rt.ArrayItem{ key: 'show_sku', val: var_args.array_get(rt.new_string('show_sku')) }, rt.ArrayItem{ key: 'show_purchase_note', val: rt.is_true(rt.call_method(var_order, 'is_paid', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('sent_to_admin')))))) }, rt.ArrayItem{ key: 'show_image', val: var_args.array_get(rt.new_string('show_image')) }, rt.ArrayItem{ key: 'image_size', val: var_args.array_get(rt.new_string('image_size')) }, rt.ArrayItem{ key: 'plain_text', val: var_args.array_get(rt.new_string('plain_text')) }, rt.ArrayItem{ key: 'sent_to_admin', val: var_args.array_get(rt.new_string('sent_to_admin')) }])])])
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_get_email_fulfillment_items_table'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_order.clone(), var_fulfillment.clone()])).str()
}

fn wc_display_item_meta(var_item rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_strings := []rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_meta_id := rt.new_null()
	mut var_value := rt.new_null()
	var_strings = rt.new_array()
	var_html = rt.new_string('')
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'before', val: '<ul class="wc-item-meta"><li>' }, rt.ArrayItem{ key: 'after', val: '</li></ul>' }, rt.ArrayItem{ key: 'separator', val: '</li><li>' }, rt.ArrayItem{ key: 'echo', val: true }, rt.ArrayItem{ key: 'autop', val: false }, rt.ArrayItem{ key: 'label_before', val: '<strong class="wc-item-meta-label">' }, rt.ArrayItem{ key: 'label_after', val: ':</strong> ' }])])
	mut iter_18 := rt.call_method(var_item, 'get_formatted_meta_data', []rt.PhpVal{}).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_meta_shadow := item_18.val
		mut var_meta_id_shadow := item_18.key
		var_value = if rt.is_true(var_args.array_get(rt.new_string('autop'))) { rt.call_function('wp_kses_post', [rt.get_property(var_meta_shadow, 'display_value')]) } else { rt.call_function('wp_kses_post', [rt.call_function('make_clickable', [rt.new_string(rt.get_property(var_meta_shadow, 'display_value').to_string().trim_space())])]) }
		var_strings << (var_args.array_get(rt.new_string('label_before'))).str() + (rt.call_function('wp_kses_post', [rt.get_property(var_meta_shadow, 'display_key')])).str() + (var_args.array_get(rt.new_string('label_after'))).str() + (var_value).str()
	}
	if rt.is_true(var_strings) {
	var_html = rt.new_string((var_args.array_get(rt.new_string('before'))).str() + (rt.call_function('implode', [var_args.array_get(rt.new_string('separator')), rt.create_array_from_list(var_strings)])).str() + (var_args.array_get(rt.new_string('after'))).str())
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_display_item_meta'), var_html.clone(), var_item.clone(), var_args.clone()])
	if rt.is_true(var_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	} else {
		return var_html.clone()
	}
	return rt.new_null()
}

fn wc_display_item_downloads(var_item rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_strings := []rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_downloads := rt.new_null()
	mut var_i := i64(0)
	mut var_file := map[string]rt.PhpVal{}
	mut var_prefix := rt.new_null()
	var_strings = rt.new_array()
	var_html = rt.new_string('')
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'before', val: '<ul class ="wc-item-downloads"><li>' }, rt.ArrayItem{ key: 'after', val: '</li></ul>' }, rt.ArrayItem{ key: 'separator', val: '</li><li>' }, rt.ArrayItem{ key: 'echo', val: true }, rt.ArrayItem{ key: 'show_url', val: false }])])
	var_downloads = if var_item.clone().is_object() && rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')])) { rt.call_method(var_item, 'get_item_downloads', []rt.PhpVal{}) } else { rt.new_array() }
	if !(!rt.is_true(var_downloads)) {
		var_i = 0
		mut iter_19 := var_downloads.iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_file_shadow := item_19.val
			var_i += 1
			if rt.is_true(var_args.array_get(rt.new_string('show_url'))) {
				var_strings << '<strong class="wc-item-download-label">' + (rt.call_function('esc_html', [var_file_shadow['name']])).str() + ':</strong> ' + (rt.call_function('esc_html', [var_file_shadow['download_url']])).str()
			} else {
				var_prefix = if var_downloads.clone().array_count() > 1 { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Download %d'), rt.new_string('woocommerce')]), rt.new_int(var_i).clone()]) } else { rt.call_function('__', [rt.new_string('Download'), rt.new_string('woocommerce')]) }
				var_strings << '<strong class="wc-item-download-label">' + (var_prefix).str() + ':</strong> <a href="' + (rt.call_function('esc_url', [var_file_shadow['download_url']])).str() + '" target="_blank">' + (rt.call_function('esc_html', [var_file_shadow['name']])).str() + '</a>'
			}
		}
	}
	if rt.is_true(var_strings) {
	var_html = rt.new_string((var_args.array_get(rt.new_string('before'))).str() + (rt.call_function('implode', [var_args.array_get(rt.new_string('separator')), rt.create_array_from_list(var_strings)])).str() + (var_args.array_get(rt.new_string('after'))).str())
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_display_item_downloads'), var_html.clone(), var_item.clone(), var_args.clone()])
	if rt.is_true(var_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	} else {
		return var_html.clone()
	}
	return rt.new_null()
}

fn woocommerce_photoswipe() {
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-lightbox')])) {
		rt.call_function('wc_get_template', [rt.new_string('single-product/photoswipe.php')])
	}
}

fn wc_display_product_attributes(var_product rt.PhpVal) {
	mut var_product_attributes := rt.new_null()
	mut var_display_dimensions := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_values := rt.new_null()
	mut var_attribute_taxonomy := rt.new_null()
	mut var_attribute_values := rt.new_null()
	mut var_attribute_value := rt.new_null()
	mut var_value_name := rt.new_null()
	mut var_value := rt.new_null()
	var_product_attributes = rt.new_array()
	var_display_dimensions = rt.call_function('apply_filters', [rt.new_string('wc_product_enable_dimensions_display'), rt.new_bool(rt.is_true(rt.call_method(var_product, 'has_weight', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_product, 'has_dimensions', []rt.PhpVal{})))])
	if rt.is_true(var_display_dimensions) && rt.is_true(rt.call_method(var_product, 'has_weight', []rt.PhpVal{})) {
		var_product_attributes.array_set('weight', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Weight'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_weight', [rt.call_method(var_product, 'get_weight', []rt.PhpVal{})]) }]))
	}
	if rt.is_true(var_display_dimensions) && rt.is_true(rt.call_method(var_product, 'has_dimensions', []rt.PhpVal{})) {
		var_product_attributes.array_set('dimensions', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Dimensions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_dimensions', [rt.call_method(var_product, 'get_dimensions', [rt.new_bool(false)])]) }]))
	}
	var_attributes = rt.call_function('array_filter', [rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}), rt.new_string('wc_attributes_array_filter_visible')])
	mut iter_20 := var_attributes.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_attribute_shadow := item_20.val
		var_values = rt.new_array()
		if rt.is_true(rt.call_method(var_attribute_shadow, 'is_taxonomy', []rt.PhpVal{})) {
			var_attribute_taxonomy = rt.call_method(var_attribute_shadow, 'get_taxonomy_object', []rt.PhpVal{})
			var_attribute_values = rt.call_function('wc_get_product_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.call_method(var_attribute_shadow, 'get_name', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'all' }])])
			mut iter_21 := var_attribute_values.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_attribute_value_shadow := item_21.val
				var_value_name = rt.call_function('esc_html', [rt.get_property(var_attribute_value_shadow, 'name')])
				if rt.is_true(rt.get_property(var_attribute_taxonomy, 'attribute_public')) {
					var_values.array_push('<a href="' + (rt.call_function('esc_url', [rt.call_function('get_term_link', [rt.get_property(var_attribute_value_shadow, 'term_id'), rt.call_method(var_attribute_shadow, 'get_name', []rt.PhpVal{})])])).str() + '" rel="tag">' + (var_value_name).str() + '</a>')
				} else {
					var_values.array_push(var_value_name.clone())
				}
			}
		} else {
			var_values = rt.call_method(var_attribute_shadow, 'get_options', []rt.PhpVal{})
			mut iter_22 := var_values.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_value_shadow := item_22.val
			var_value_shadow = rt.call_function('make_clickable', [rt.call_function('esc_html', [var_value_shadow.clone()])])
			}
		}
		var_product_attributes.array_set('attribute_' + (rt.call_function('sanitize_title_with_dashes', [rt.call_method(var_attribute_shadow, 'get_name', []rt.PhpVal{})])).str(), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('wc_attribute_label', [rt.call_method(var_attribute_shadow, 'get_name', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute'), rt.call_function('wpautop', [rt.call_function('wptexturize', [rt.call_function('implode', [rt.new_string(', '), var_values.clone()])])]), var_attribute_shadow.clone(), var_values.clone()]) }]))
	}
	var_product_attributes = rt.call_function('apply_filters', [rt.new_string('woocommerce_display_product_attributes'), var_product_attributes.clone(), var_product.clone()])
	rt.call_function('wc_get_template', [rt.new_string('single-product/product-attributes.php'), rt.create_array([rt.ArrayItem{ key: 'product_attributes', val: var_product_attributes }, rt.ArrayItem{ key: 'product', val: var_product }, rt.ArrayItem{ key: 'attributes', val: var_attributes }, rt.ArrayItem{ key: 'display_dimensions', val: var_display_dimensions }])])
}

fn wc_get_stock_html(var_product rt.PhpVal) rt.PhpVal {
	mut var_html := rt.new_null()
	mut var_availability := rt.new_null()
	var_html = rt.new_string('')
	var_availability = rt.call_method(var_product, 'get_availability', []rt.PhpVal{})
	if !(!rt.is_true(var_availability.array_get(rt.new_string('availability')))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wc_get_template', [rt.new_string('single-product/stock.php'), rt.create_array([rt.ArrayItem{ key: 'product', val: var_product }, rt.ArrayItem{ key: 'class', val: var_availability.array_get(rt.new_string('class')) }, rt.ArrayItem{ key: 'availability', val: var_availability.array_get(rt.new_string('availability')) }])])
	var_html = rt.call_function('ob_get_clean', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_stock_html')])) {
		rt.call_function('wc_deprecated_function', [rt.new_string('The woocommerce_stock_html filter'), rt.new_string(''), rt.new_string('woocommerce_get_stock_html')])
	var_html = rt.call_function('apply_filters', [rt.new_string('woocommerce_stock_html'), var_html.clone(), var_availability.array_get(rt.new_string('availability')), var_product.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_stock_html'), var_html.clone(), var_product.clone()])
}

fn wc_get_rating_html(var_rating rt.PhpVal, count i64) rt.PhpVal {
	mut var_count := count
	mut var_html := rt.new_null()
	mut var_label := rt.new_null()
	var_html = rt.new_string('')
	if rt.is_true(rt.less(rt.new_int(0), var_rating)) {
	var_label = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Rated %s out of 5'), rt.new_string('woocommerce')]), var_rating.clone()])
	var_html = rt.new_string('<div class="star-rating" role="img" aria-label="' + (rt.call_function('esc_attr', [var_label.clone()])).str() + '">' + (wc_get_star_rating_html(var_rating.clone(), count)).str() + '</div>')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_get_rating_html'), var_html.clone(), var_rating.clone(), rt.new_int(count)])
}

fn wc_get_star_rating_html(var_rating rt.PhpVal, count i64) rt.PhpVal {
	mut var_count := count
	mut var_html := rt.new_null()
	var_html = rt.new_string('<span style="width:' + (rt.mul(rt.div(var_rating, rt.new_int(5)), rt.new_int(100))).str() + '%">')
	if 0 < count {
		var_html = rt.concat(var_html, rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Rated %1$s out of 5 based on %2$s customer rating'), rt.new_string('Rated %1$s out of 5 based on %2$s customer ratings'), rt.new_int(count), rt.new_string('woocommerce')]), rt.new_string('<strong class="rating">' + (rt.call_function('esc_html', [var_rating.clone()])).str() + '</strong>'), rt.new_string('<span class="rating">' + (rt.call_function('esc_html', [rt.new_int(count)])).str() + '</span>')]))
	} else {
		var_html = rt.concat(var_html, rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Rated %s out of 5'), rt.new_string('woocommerce')]), rt.new_string('<strong class="rating">' + (rt.call_function('esc_html', [var_rating.clone()])).str() + '</strong>')]))
	}
	var_html = rt.concat(var_html, rt.new_string('</span>'))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_star_rating_html'), var_html.clone(), var_rating.clone(), rt.new_int(count)])
}

fn wc_get_price_html_from_text() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_html_from_text'), rt.new_string('<span class="from">' + (rt.call_function('_x', [rt.new_string('From:'), rt.new_string('min_price'), rt.new_string('woocommerce')])).str() + ' </span>')])
}

fn wc_get_logout_redirect_url() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_logout_default_redirect_url'), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
}

fn wc_logout_url(redirect string) rt.PhpVal {
	mut var_redirect := redirect
	return rt.call_function('wp_logout_url', [if var_redirect.len > 0 && var_redirect != '0' { rt.new_string(redirect) } else { wc_get_logout_redirect_url() }])
}

fn wc_empty_cart_message() {
	mut var_notice := rt.new_null()
	var_notice = rt.call_function('wc_print_notice', [rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('wc_empty_cart_message'), rt.call_function('__', [rt.new_string('Your cart is currently empty.'), rt.new_string('woocommerce')])])]), rt.new_string('notice'), rt.new_array(), rt.new_bool(true)])
	var_notice = rt.call_function('str_replace', [rt.new_string('class="woocommerce-info"'), rt.new_string('class="cart-empty woocommerce-info"'), var_notice.clone()])
	print('<div class="wc-empty-cart-message">' + (var_notice).str() + '</div>')
}

fn wc_page_noindex() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_robots_no_robots')])) {
		return
	}
	if rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('cart')])])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('checkout')])])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])])) {
		rt.call_function('wp_no_robots', []rt.PhpVal{})
	}
}

fn wc_page_no_robots(var_robots rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('cart')])])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('checkout')])])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('myaccount')])])) {
		return rt.call_function('wp_robots_no_robots', [var_robots.clone()])
	}
	return var_robots.clone()
}

fn wc_get_theme_slug_for_templates() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_theme_slug_for_templates'), rt.call_function('get_option', [rt.new_string('template')])])
}

fn wc_get_formatted_cart_item_data(var_cart_item rt.PhpVal, flat bool) string {
	mut var_flat := flat
	mut var_item_data := rt.new_null()
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_term := rt.new_null()
	mut var_label := rt.new_null()
	mut var_data := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	var_item_data = rt.new_array()
	if rt.is_true(rt.call_method(var_cart_item.array_get(rt.new_string('data')), 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) && var_cart_item.array_get(rt.new_string('variation')).is_array() {
		mut iter_23 := var_cart_item.array_get(rt.new_string('variation')).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_value_shadow := item_23.val
			mut var_name_shadow := item_23.key
			var_taxonomy = rt.call_function('wc_attribute_taxonomy_name', [rt.call_function('str_replace', [rt.new_string('attribute_pa_'), rt.new_string(''), rt.call_function('urldecode', [var_name_shadow.clone()])])])
			if rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()])) {
				var_term = rt.call_function('get_term_by', [rt.new_string('slug'), var_value_shadow.clone(), var_taxonomy.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) && rt.is_true(var_term) && rt.is_true(rt.get_property(var_term, 'name')) {
				var_value_shadow = rt.get_property(var_term, 'name')
				}
			var_label = rt.call_function('wc_attribute_label', [var_taxonomy.clone()])
			} else {
			var_value_shadow = rt.call_function('apply_filters', [rt.new_string('woocommerce_variation_option_name'), var_value_shadow.clone(), rt.new_null(), var_taxonomy.clone(), var_cart_item.array_get(rt.new_string('data'))])
			var_label = rt.call_function('wc_attribute_label', [rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_name_shadow.clone()]), var_cart_item.array_get(rt.new_string('data'))])
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_value_shadow)) || rt.is_true(rt.call_function('wc_is_attribute_in_product_name', [var_value_shadow.clone(), rt.call_method(var_cart_item.array_get(rt.new_string('data')), 'get_name', []rt.PhpVal{})])) {
				continue
			}
			var_item_data.array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: var_label }, rt.ArrayItem{ key: 'value', val: var_value_shadow }]))
		}
	}
	var_item_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_item_data'), var_item_data.clone(), rt.create_array_from_native_map(var_cart_item)])
	if rt.is_true(rt.new_bool(var_item_data.clone().is_array())) {
		mut iter_24 := var_item_data.iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_data_shadow := item_24.val
			mut var_key_shadow := item_24.key
			if !(!rt.is_true(var_data_shadow['hidden'])) {
				var_item_data.array_unset(var_key_shadow)
				continue
			}
			var_item_data.array_get_mut(var_key_shadow).array_set('key', if !(!rt.is_true(var_data_shadow['key'])) { var_data_shadow['key'] } else { var_data_shadow['name'] })
			var_item_data.array_get_mut(var_key_shadow).array_set('display', if !(!rt.is_true(var_data_shadow['display'])) { var_data_shadow['display'] } else { var_data_shadow['value'] })
		}
		if var_item_data.clone().array_count() > 0 {
			rt.call_function('ob_start', []rt.PhpVal{})
			if var_flat {
				mut iter_25 := var_item_data.iterator()
				for {
					item_25 := iter_25.next() or { break }
					mut var_data_shadow := item_25.val
					print((rt.call_function('esc_html', [var_data_shadow['key']])).str() + ': ' + (rt.call_function('wp_kses_post', [var_data_shadow['display']])).str() + '\n')
				}
			} else {
				rt.call_function('wc_get_template', [rt.new_string('cart/cart-item-data.php'), rt.create_array([rt.ArrayItem{ key: 'item_data', val: var_item_data }])])
			}
			return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		}
	}
	return ''
}

fn wc_get_cart_remove_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_page_url := rt.new_null()
	var_cart_page_url = rt.call_function('wc_get_cart_url', []rt.PhpVal{})
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_remove_url'), if rt.is_true(var_cart_page_url) { rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('remove_item'), var_cart_item_key.clone(), var_cart_page_url.clone()]), rt.new_string('woocommerce-cart')]) } else { rt.new_string('') }])
}

fn wc_get_cart_undo_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_page_url := rt.new_null()
	mut var_query_args := map[string]rt.PhpVal{}
	var_cart_page_url = rt.call_function('wc_get_cart_url', []rt.PhpVal{})
	var_query_args = { 'undo_item': var_cart_item_key }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_undo_url'), if rt.is_true(var_cart_page_url) { rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_query_args), var_cart_page_url.clone()]), rt.new_string('woocommerce-cart')]) } else { rt.new_string('') }, var_cart_item_key.clone()])
}

fn woocommerce_output_all_notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_print_notices')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.new_string('Function should only be used during frontend requests.'), rt.new_string('9.8.0')])
		return
	}
	print('<div class="woocommerce-notices-wrapper">')
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	print('</div>')
}

fn wc_get_pay_buttons() {
	mut var_supported_gateways := []rt.PhpVal{}
	mut var_available_gateways := rt.new_null()
	mut var_gateway := rt.new_null()
	mut var_pay_button_id := rt.new_null()
	var_supported_gateways = rt.new_array()
	var_available_gateways = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'get_available_payment_gateways', []rt.PhpVal{})
	mut iter_26 := var_available_gateways.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_gateway_shadow := item_26.val
		if rt.is_true(rt.call_method(var_gateway_shadow, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.pay_button()])) {
			var_supported_gateways << rt.call_method(var_gateway_shadow, 'get_pay_button_id', []rt.PhpVal{})
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_supported_gateways)))) {
		return
	}
	print('<div class="woocommerce-pay-buttons">')
	for var_pay_button_id_shadow in var_supported_gateways {
		rt.call_function('printf', [rt.new_string('<div class="woocommerce-pay-button__%1$s %1$s" id="%1$s"></div>'), rt.call_function('esc_attr', [var_pay_button_id_shadow.clone()])])
	}
	print('</div>')
}

fn wc_update_product_archive_title(var_post_type_name rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_shop_page_title := rt.new_null()
	if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
		var_shop_page_title = rt.call_function('get_the_title', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])
		if rt.is_true(var_shop_page_title) {
			return var_shop_page_title.clone()
		}
		return rt.call_function('__', [rt.new_string('Shop'), rt.new_string('woocommerce')])
	}
	return var_post_type_name.clone()
}

fn wc_set_hooked_blocks_version() {
	mut var_option_name := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')]))))) {
		return
	}
	var_option_name = 'woocommerce_hooked_blocks_version'
	if rt.is_true(rt.call_function('get_option', [rt.new_string((var_option_name).str()).clone()])) {
		return
	}
	rt.call_function('add_option', [rt.new_string((var_option_name).str()).clone(), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'stable_version', []rt.PhpVal{})])
}

fn wc_after_switch_theme(var_old_name rt.PhpVal, var_old_theme rt.PhpVal) {
	wc_set_hooked_blocks_version_on_theme_switch(var_old_name.clone(), var_old_theme.clone())
	wc_update_store_notice_visible_on_theme_switch(var_old_name.clone(), var_old_theme.clone())
}

fn wc_update_store_notice_visible_on_theme_switch(var_old_name rt.PhpVal, var_old_theme rt.PhpVal) {
	mut var_enable_store_notice_in_classic_theme_option := ''
	mut var_is_store_notice_active_option := ''
	mut var_enable_store_notice_in_classic_theme := rt.new_null()
	var_enable_store_notice_in_classic_theme_option = 'woocommerce_enable_store_notice_in_classic_theme'
	var_is_store_notice_active_option = 'woocommerce_demo_store'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_old_theme, 'is_block_theme', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_store_notice_showing', []rt.PhpVal{})) {
			rt.call_function('update_option', [rt.new_string((var_is_store_notice_active_option).str()).clone(), rt.call_function('wc_bool_to_string', [rt.new_bool(false)])])
			rt.call_function('add_option', [rt.new_string((var_enable_store_notice_in_classic_theme_option).str()).clone(), rt.call_function('wc_bool_to_string', [rt.new_bool(true)])])
		}
	} else if rt.is_true(rt.call_method(var_old_theme, 'is_block_theme', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		var_enable_store_notice_in_classic_theme = rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string((var_enable_store_notice_in_classic_theme_option).str()).clone(), rt.new_string('no')])])
		if rt.is_true(var_enable_store_notice_in_classic_theme) {
			rt.call_function('update_option', [rt.new_string((var_is_store_notice_active_option).str()).clone(), rt.call_function('wc_bool_to_string', [rt.new_bool(true)])])
			rt.call_function('delete_option', [rt.new_string((var_enable_store_notice_in_classic_theme_option).str()).clone()])
		}
	}
}

fn wc_set_hooked_blocks_version_on_theme_switch(var_old_name rt.PhpVal, var_old_theme rt.PhpVal) {
	mut var_option_name := ''
	mut var_option_value := rt.new_null()
	var_option_name = 'woocommerce_hooked_blocks_version'
	var_option_value = rt.call_function('get_option', [rt.new_string((var_option_name).str()).clone(), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_old_theme, 'is_block_theme', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])) && rt.is_true(rt.identical(rt.new_bool(false), var_option_value)) {
		rt.call_function('add_option', [rt.new_string((var_option_name).str()).clone(), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'stable_version', []rt.PhpVal{})])
	}
}

fn wc_add_aria_label_to_pagination_numbers(var_html_arg rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_html := var_html_arg
	mut var_p := rt.new_null()
	mut var_n := rt.new_null()
	mut var_page_text := rt.new_null()
	var_p = create_wp_html_tag_processor(var_html.clone())
	var_n = rt.new_int(1)
	var_page_text = rt.call_function('__', [rt.new_string('Page'), rt.new_string('woocommerce')])
	for rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'page-numbers' }]))) {
		if rt.is_true(var_p.has_class(rt.new_string('prev'))) || rt.is_true(var_p.has_class(rt.new_string('next'))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('SPAN'), var_p.get_tag())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('A'), var_p.get_tag()))))) {
			continue
		}
		if rt.is_true(var_p.has_class(rt.new_string('current'))) {
		var_n = var_args.array_get(rt.new_string('current'))
		}
		if rt.is_true(var_p.has_class(rt.new_string('dots'))) {
			if rt.is_true(rt.greater(rt.sub(var_args.array_get(rt.new_string('current')), var_args.array_get(rt.new_string('mid_size'))), var_n)) {
			var_n = rt.sub(rt.sub(var_args.array_get(rt.new_string('current')), var_args.array_get(rt.new_string('mid_size'))), rt.new_int(1))
			} else {
			var_n = rt.sub(var_args.array_get(rt.new_string('total')), var_args.array_get(rt.new_string('end_size')))
			}
			rt.pre_inc(var_n)
			continue
		}
		var_p.set_attribute(rt.new_string('aria-label'), rt.new_string((var_page_text).str() + ' ' + (rt.call_function('number_format_i18n', [rt.new_int((var_n).to_i64())])).str()))
		rt.pre_inc(var_n)
	}
	var_html = var_p.get_updated_html()
	return var_html.clone()
}

fn wc_get_quantity_input_args(var_args_arg rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_type := ''
	var_defaults = { 'input_id': rt.call_function('uniqid', [rt.new_string('quantity_')]), 'input_name': rt.new_string('quantity'), 'classes': rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_classes'), map[string]rt.PhpVal{}, var_product.clone()]), 'pattern': rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_pattern'), rt.new_string((if rt.is_true(rt.call_function('wc_is_stock_amount_integer', []rt.PhpVal{})) { '[0-9]*' } else { '' }).str())]), 'inputmode': rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_inputmode'), rt.new_string((if rt.is_true(rt.call_function('wc_is_stock_amount_integer', []rt.PhpVal{})) { 'numeric' } else { 'decimal' }).str())]), 'placeholder': rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_placeholder'), rt.new_string(''), var_product.clone()]), 'autocomplete': rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_autocomplete'), rt.new_string('off'), var_product.clone()]), 'readonly': rt.new_bool(false) }
	if rt.is_true(var_product) {
		var_defaults['min_value'] = rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{})
		var_defaults['max_value'] = rt.call_method(var_product, 'get_max_purchase_quantity', []rt.PhpVal{})
		var_defaults['step'] = rt.call_method(var_product, 'get_purchase_quantity_step', []rt.PhpVal{})
		var_defaults['product_name'] = rt.call_method(var_product, 'get_title', []rt.PhpVal{})
	} else {
		var_defaults['min_value'] = rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_min'), rt.new_int(1), var_product.clone()])
		var_defaults['max_value'] = rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_max'), rt.new_int(-1), var_product.clone()])
		var_defaults['step'] = rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_step'), rt.new_int(1), var_product.clone()])
		var_defaults['product_name'] = rt.new_string('')
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_args'), rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)]), var_product.clone()])
	var_args.array_set('min_value', rt.call_function('max', [var_args.array_get(rt.new_string('min_value')), rt.new_int(0)]))
	var_args.array_set('max_value', if rt.is_true(rt.less(rt.new_int(0), var_args.array_get(rt.new_string('max_value')))) { var_args.array_get(rt.new_string('max_value')) } else { rt.new_string('') })
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('max_value')))))) && rt.is_true(rt.less(var_args.array_get(rt.new_string('max_value')), var_args.array_get(rt.new_string('min_value')))) {
		var_args.array_set('max_value', var_args.array_get(rt.new_string('min_value')))
	}
	var_args.array_set('input_value', if var_args.array_isset(rt.new_string('input_value')) { var_args.array_get(rt.new_string('input_value')) } else { var_defaults['min_value'] })
	var_type = if rt.is_true(rt.greater(var_args.array_get(rt.new_string('min_value')), rt.new_int(0))) && rt.is_true(rt.identical(var_args.array_get(rt.new_string('min_value')), var_args.array_get(rt.new_string('max_value')))) { 'hidden' } else { 'number' }
	var_type = if rt.is_true(var_args.array_get(rt.new_string('readonly'))) && rt.is_true(rt.new_bool('hidden' != var_type)) { 'text' } else { var_type }
	var_args.array_set('type', rt.call_function('apply_filters', [rt.new_string('woocommerce_quantity_input_type'), rt.new_string((var_type).str()).clone()]))
	return var_args.clone()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Breadcrumb {
	rt.PhpObjectBase
}

struct Class_WC_Template_Loader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_My_Account {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_breadcrumb(_args ...rt.PhpVal) &Class_WC_Breadcrumb {
	mut obj := &Class_WC_Breadcrumb{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_template_loader(_args ...rt.PhpVal) &Class_WC_Template_Loader {
	mut obj := &Class_WC_Template_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
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

fn create_wc_shortcode_my_account(_args ...rt.PhpVal) &Class_WC_Shortcode_My_Account {
	mut obj := &Class_WC_Shortcode_My_Account{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Breadcrumb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Breadcrumb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Breadcrumb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Template_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Template_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Template_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Shortcode_My_Account) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_My_Account) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_My_Account) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_template_redirect')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_send_frame_options_header')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_prevent_endpoint_indexing')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_prevent_adjacent_posts_rel_link_wp_head')])
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.new_string('wc_gallery_noscript')])
	rt.call_function('add_action', [rt.new_string('the_post'), rt.new_string('wc_setup_product_data')])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_shop_loop'), rt.new_string('wc_setup_loop')])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_shop_loop'), rt.new_string('woocommerce_reset_loop'), rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('after_switch_theme'), rt.new_string('wc_reset_product_grid_settings')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_content')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_content_wrapper')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_content_wrapper_end')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_get_sidebar')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_demo_store')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_page_title')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_loop_start')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_loop_end')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_product_title')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_category_title')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_product_link_open')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_product_link_close')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_category_link_open')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_category_link_close')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_taxonomy_archive_header')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_taxonomy_archive_description')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_archive_description')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_product_thumbnail')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_price')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_loop_rating')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_show_product_loop_sale_flash')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_get_product_thumbnail')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_result_count')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_catalog_ordering')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_pagination')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_show_product_images')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_show_product_thumbnails')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_get_alt_from_product_title_and_position')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_product_data_tabs')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_title')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_rating')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_price')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_excerpt')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_meta')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_sharing')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_show_product_sale_flash')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_template_single_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_simple_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_grouped_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_variable_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_external_add_to_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_quantity_input')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_description_tab')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_product_additional_information_tab')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_default_product_tabs')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_sort_product_tabs')]))))) {
	}
	rt.call_function('uasort', [rt.create_array_from_native_map(var_tabs), rt.new_string('_sort_priority_callback')])
	return (var_tabs).to_i64()
}

	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_comments')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_review_display_gravatar')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_review_display_rating')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_review_display_meta')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_review_display_comment_text')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_related_products')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_related_products')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_upsell_display')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_shipping_calculator')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_cart_totals')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_cross_sell_display')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_button_proceed_to_checkout')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_widget_shopping_cart_button_view_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_widget_shopping_cart_proceed_to_checkout')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_widget_shopping_cart_subtotal')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_mini_cart')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_login_form')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_checkout_login_form')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_breadcrumb')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_order_review')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_checkout_payment')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_checkout_coupon_form')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_products_will_display')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_get_loop_display_mode')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_maybe_show_product_subcategories')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_product_categories')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_get_product_subcategories')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_subcategory_thumbnail')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_order_details_table')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_order_downloads_table')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_order_again_button')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_form_field')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_product_search_form')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_auth_header')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_output_auth_footer')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_single_variation')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_single_variation_add_to_cart_button')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_dropdown_variation_attribute_options')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_content')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_navigation')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_orders')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_view_order')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_downloads')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_edit_address')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_payment_methods')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_add_payment_method')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_account_edit_account')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_no_products_found')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_email_order_items')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_email_fulfillment_items')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_display_item_meta')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_display_item_downloads')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('woocommerce_photoswipe')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.new_string('wc_page_noindex')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'), rt.new_string('wc_page_no_robots')])
	rt.call_function('add_filter', [rt.new_string('post_type_archive_title'), rt.new_string('wc_update_product_archive_title'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('paginate_links_output'), rt.new_string('wc_add_aria_label_to_pagination_numbers'), rt.new_int(10), rt.new_int(2)])
}
