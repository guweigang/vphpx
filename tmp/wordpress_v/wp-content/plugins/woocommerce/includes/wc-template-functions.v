import rt

fn wc_template_redirect() {
	mut var_wp_query := rt.new_null()
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('page_id'))) && rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [rt.new_string('permalink_structure')]))))) && rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('shop')]), rt.call_function('absint', [rt.get_superglobal('_GET').array_get('page_id')]))))) && rt.is_true(rt.call_function('get_post_type_archive_link', [rt.new_string('product')])))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('get_post_type_archive_link', [rt.new_string('product')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('checkout')])])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})))) && !rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('order-pay')))) && !(rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_redirect_empty_cart'), rt.new_bool(true)])))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))))) {
			rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})])
			// unsupported expression: Expr_Exit
		}
	}
	if rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('customer-logout')) {
		if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wpnonce'))) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get('_wpnonce')]), rt.new_string('customer-logout')])))) {
			rt.call_function('wp_logout', []rt.PhpVal{})
			rt.call_function('wp_safe_redirect', [wc_get_logout_redirect_url()])
			// unsupported expression: Expr_Exit
		}
		rt.call_function('wc_add_notice', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Are you sure you want to log out? <a href="%s">Confirm and log out</a>'), rt.new_string('woocommerce')]), wc_logout_url('')])])
		rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_account_endpoint_page_not_found'), rt.new_bool(true)])))) {
		rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
		rt.call_function('status_header', [rt.new_int(404)])
		mut var_template := rt.call_function('get_query_template', [rt.new_string('404')])
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_template)) && rt.is_true(rt.call_function('file_exists', [var_template.dup()])))) {
			rt.include_file((var_template).to_string(), '1')
		} else {
			rt.call_function('wp_safe_redirect', [rt.call_function('home_url', []rt.PhpVal{})])
		}
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_redirect_single_search_result'), rt.new_bool(true)])))) && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_property(var_wp_query, 'found_posts')]))))) {
		mut var_product := rt.call_function('wc_get_product', [rt.get_property(var_wp_query, 'post')])
		if rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})))) {
			rt.call_function('wp_safe_redirect', [rt.call_function('get_permalink', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]), rt.new_int(302)])
			// unsupported expression: Expr_Exit
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_add_payment_method_page', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
	}
}

fn wc_send_frame_options_header() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))))) {
		rt.call_function('send_frame_options_header', []rt.PhpVal{})
	}
}

fn wc_prevent_endpoint_indexing() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) || rt.get_superglobal('_GET').array_isset(rt.new_string('download_file')))) {
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
	}
	// unsupported statement: Stmt_Nop
}

fn wc_prevent_adjacent_posts_rel_link_wp_head() {
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		rt.call_function('remove_action', [rt.new_string('wp_head'), rt.new_string('adjacent_posts_rel_link_wp_head'), rt.new_int(10), rt.new_int(0)])
	}
}

fn wc_gallery_noscript() {
	// unsupported statement: Stmt_InlineHTML
}

fn wc_setup_product_data(var_post rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_unset(rt.new_string('product'))
	if rt.is_true(rt.new_bool(var_post.dup().is_long())) {
		var_post = rt.call_function('get_post', [var_post.dup()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_post, 'post_type')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)]))))))) {
		return rt.new_null()
	}
	var_GLOBALS.array_set('product', rt.call_function('wc_get_product', [var_post.dup()]))
	return var_GLOBALS.array_get('product')
}

fn wc_setup_loop(var_args rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_default_args := rt.create_array([rt.ArrayItem{ key: 'loop', val: 0 }, rt.ArrayItem{ key: 'columns', val: wc_get_default_products_per_row() }, rt.ArrayItem{ key: 'name', val: '' }, rt.ArrayItem{ key: 'is_shortcode', val: false }, rt.ArrayItem{ key: 'is_paginated', val: true }, rt.ArrayItem{ key: 'is_search', val: false }, rt.ArrayItem{ key: 'is_filtered', val: false }, rt.ArrayItem{ key: 'total', val: 0 }, rt.ArrayItem{ key: 'total_pages', val: 0 }, rt.ArrayItem{ key: 'per_page', val: 0 }, rt.ArrayItem{ key: 'current_page', val: 1 }])
	if rt.is_true(rt.call_method(var_GLOBALS.array_get('wp_query'), 'get', [rt.new_string('wc_query')])) {
		var_default_args = rt.call_function('array_merge', [var_default_args.dup(), rt.create_array([rt.ArrayItem{ key: 'is_search', val: rt.call_method(var_GLOBALS.array_get('wp_query'), 'is_search', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_filtered', val: rt.call_function('is_filtered', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_GLOBALS.array_get('wp_query'), 'found_posts') }, rt.ArrayItem{ key: 'total_pages', val: rt.get_property(var_GLOBALS.array_get('wp_query'), 'max_num_pages') }, rt.ArrayItem{ key: 'per_page', val: rt.call_method(var_GLOBALS.array_get('wp_query'), 'get', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'current_page', val: rt.call_function('max', [rt.new_int(1), rt.call_method(var_GLOBALS.array_get('wp_query'), 'get', [rt.new_string('paged'), rt.new_int(1)])]) }])])
	}
	if var_GLOBALS.array_isset(rt.new_string('woocommerce_loop')) {
		var_default_args = rt.call_function('array_merge', [var_default_args.dup(), var_GLOBALS.array_get('woocommerce_loop')])
	}
	var_GLOBALS.array_set('woocommerce_loop', rt.call_function('wp_parse_args', [var_args.dup(), var_default_args.dup()]))
}

fn wc_reset_loop() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_unset(rt.new_string('woocommerce_loop'))
}

fn wc_get_loop_prop(prop string, default string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	wc_setup_loop(rt.new_null())
	return if var_GLOBALS.array_isset(rt.new_string('woocommerce_loop')) && var_GLOBALS.array_get('woocommerce_loop').array_isset(rt.new_string(prop)) { var_GLOBALS.array_get('woocommerce_loop').array_get(prop) } else { rt.new_string(default) }
}

fn wc_set_loop_prop(prop string, value string) {
	mut var_GLOBALS := rt.new_null()
	if !(var_GLOBALS.array_isset(rt.new_string('woocommerce_loop'))) {
		wc_setup_loop(rt.new_null())
	}
	var_GLOBALS.array_get_mut('woocommerce_loop').array_set(prop, value)
}

fn wc_set_loop_product_visibility(var_product_id rt.PhpVal, var_value rt.PhpVal) {
	wc_set_loop_prop("product_visibility_${var_product_id.to_string()}", var_value.dup())
}

fn wc_get_loop_product_visibility(var_product_id rt.PhpVal) rt.PhpVal {
	return wc_get_loop_prop("product_visibility_${var_product_id.to_string()}", rt.new_null())
}

fn woocommerce_product_loop() bool {
	return rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn wc_generator_tag(var_gen rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('xhtml'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_gen.dup()
}

fn wc_body_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
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
		mut var_account_page_id := rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_page_id')])
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_account_page_id)) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_post_field', [, .dup()]), rt.call_function('basename', []))) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))) {
			var_classes.array_push('woocommerce-dashboard')
		}
	}
	if rt.is_true(rt.call_function('is_store_notice_showing', []rt.PhpVal{})) {
		var_classes.array_push('woocommerce-demo-store')
	}
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_query_vars', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_function('is_wc_endpoint_url', [var_key.dup()])) {
				.array_push()
			}
		}
	}
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		
	}
	if rt.is_true() {
	}
	
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_template_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_template_redirect')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_send_frame_options_header')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_prevent_endpoint_indexing')])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.new_string('wc_prevent_adjacent_posts_rel_link_wp_head')])
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.new_string('wc_gallery_noscript')])
	rt.call_function('add_action', [rt.new_string('the_post'), rt.new_string('wc_setup_product_data')])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_shop_loop'), rt.new_string('wc_setup_loop')])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_shop_loop'), rt.new_string('woocommerce_reset_loop'), rt.new_int(999)])
}
