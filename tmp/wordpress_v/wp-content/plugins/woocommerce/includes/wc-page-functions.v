import rt

fn wc_page_endpoint_title(var_title rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_query.dup().is_null()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{})))) && rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})))) && rt.is_true(rt.call_function('is_page', []rt.PhpVal{})))) && rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})))) {
		mut var_endpoint := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_current_endpoint', []rt.PhpVal{})
		mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('action')])]) } else { rt.new_string('') }
		mut var_endpoint_title := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_endpoint_title', [var_endpoint.dup(), var_action.dup()])
		var_title = if rt.is_true(var_endpoint_title) { var_endpoint_title } else { var_title }
		rt.call_function('remove_filter', [rt.new_string('the_title'), rt.new_string('wc_page_endpoint_title')])
	}
	return var_title.dup()
}

fn wc_page_endpoint_document_title_parts(var_title rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_query.dup().is_null()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))))) && rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{})))) && rt.is_true(rt.call_function('is_page', []rt.PhpVal{})))) && rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})))) {
		mut var_endpoint := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_current_endpoint', []rt.PhpVal{})
		mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('action')])]) } else { rt.new_string('') }
		mut var_endpoint_title := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_endpoint_title', [var_endpoint.dup(), var_action.dup()])
		var_title.array_set('title', if rt.is_true(var_endpoint_title) { var_endpoint_title } else { var_title.array_get('title') })
		rt.call_function('remove_filter', [rt.new_string('document_title_parts'), rt.new_string('wc_page_endpoint_document_title_parts')])
	}
	return var_title.dup()
}

fn wc_get_page_id(var_page rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('pay'), var_page)) || rt.is_true(rt.identical(rt.new_string('thanks'), var_page)))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.1'), rt.new_string('The "pay" and "thanks" pages are no-longer used - an endpoint is added to the checkout instead. To get a valid link use the WC_Order::get_checkout_payment_url() or WC_Order::get_checkout_order_received_url() methods instead.')])
		var_page = rt.new_string(rt.new_string('checkout'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('change_password'), var_page)) || rt.is_true(rt.identical(rt.new_string('edit_address'), var_page)))) || rt.is_true(rt.identical(rt.new_string('lost_password'), var_page)))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.1'), rt.new_string('The "change_password", "edit_address" and "lost_password" pages are no-longer used - an endpoint is added to the my-account instead. To get a valid link use the wc_customer_edit_account_url() function instead.')])
		var_page = rt.new_string(rt.new_string('myaccount'))
	}
	var_page = rt.call_function('apply_filters', ['woocommerce_get_' + (var_page).str() + '_page_id', rt.call_function('get_option', ['woocommerce_' + (var_page).str() + '_page_id'])])
	return if rt.is_true(var_page) { rt.call_function('absint', [var_page.dup()]) } else { // unsupported expression: Expr_UnaryMinus }
}

fn wc_get_page_permalink(var_page rt.PhpVal, var_fallback rt.PhpVal) rt.PhpVal {
	mut var_page_id := wc_get_page_id(var_page.dup())
	mut var_permalink := if rt.is_true(rt.less(rt.new_int(0), var_page_id)) { rt.call_function('get_permalink', [var_page_id.dup()]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalink)))) {
		var_permalink = if rt.is_true(rt.new_bool(var_fallback.dup().is_null())) { rt.call_function('get_home_url', []rt.PhpVal{}) } else { var_fallback }
	}
	return rt.call_function('apply_filters', ['woocommerce_get_' + (var_page).str() + '_page_permalink', var_permalink.dup()])
}

fn wc_get_endpoint_url(var_endpoint rt.PhpVal, value string, permalink string) rt.PhpVal {
	if !(var_permalink.len > 0 && var_permalink != '0') {
		permalink = (rt.call_function('get_permalink', []rt.PhpVal{})).str()
	}
	mut var_query_vars := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_query_vars', []rt.PhpVal{})
	var_endpoint = if !(!rt.is_true(var_query_vars.array_get(var_endpoint))) { var_query_vars.array_get(var_endpoint) } else { var_endpoint }
	value = (if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_edit_address_endpoint'), rt.new_string('edit-address')]), var_endpoint)) { rt.call_function('wc_edit_address_i18n', [rt.new_string(value)]) } else { rt.new_string(value) }).str()
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		if rt.is_true(rt.call_function('strstr', [rt.new_string(permalink), rt.new_string('?')])) {
			mut var_query_string := rt.new_string('?' + (rt.call_function('wp_parse_url', [rt.new_string(permalink), rt.get_constant('PHP_URL_QUERY')])).str())
			permalink = (rt.call_function('current', [rt.call_function('explode', [rt.new_string('?'), rt.new_string(permalink)])])).str()
		} else {
			var_query_string = rt.new_string(rt.new_string(''))
		}
		mut var_url := rt.call_function('trailingslashit', [rt.new_string(permalink)])
		if var_value.len > 0 && var_value != '0' {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		var_url = rt.call_function('add_query_arg', [var_endpoint.dup(), rt.new_string(value), rt.new_string(permalink)])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_endpoint_url'), var_url.dup(), var_endpoint.dup(), rt.new_string(value), rt.new_string(permalink)])
}

fn wc_get_review_order_url(var_order rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return ''
	}
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint{}; return temp.get_url(arg_0) }(var_order.dup())).str()
}

fn wc_nav_menu_items(var_items rt.PhpVal) rt.PhpVal {
	mut var_logout_endpoint := rt.call_function('get_option', [rt.new_string('woocommerce_logout_endpoint'), rt.new_string('customer-logout')])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_logout_endpoint)) && !(!rt.is_true(var_items)) && rt.is_true(rt.new_bool(var_items.dup().is_array())))) {
		{
			mut iter_1 := var_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_key := item_1.key
				if !rt.is_true(rt.get_property(var_item, 'url')) {
					continue
				}
				mut var_path := if !(rt.call_function('wp_parse_url', [rt.get_property(var_item, 'url'), rt.get_constant('PHP_URL_PATH')])).is_null() { rt.call_function('wp_parse_url', [rt.get_property(var_item, 'url'), rt.get_constant('PHP_URL_PATH')]) } else { rt.new_string('') }
				mut var_query := if !(rt.call_function('wp_parse_url', [rt.get_property(var_item, 'url'), rt.get_constant('PHP_URL_QUERY')])).is_null() { rt.call_function('wp_parse_url', [rt.get_property(var_item, 'url'), rt.get_constant('PHP_URL_QUERY')]) } else { rt.new_string('') }
				mut var_is_logout_link := rt.is_true(rt.call_function('strstr', [var_path.dup(), var_logout_endpoint.dup()])) || rt.is_true(rt.call_function('strstr', [var_query.dup(), var_logout_endpoint.dup()]))
				if !(var_is_logout_link) {
					continue
				}
				if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
					rt.set_property(var_items.array_get(var_key), 'url', rt.call_function('wp_nonce_url', [rt.get_property(var_item, 'url'), rt.new_string('customer-logout')]))
				} else {
					var_items.array_unset(var_key)
				}
			}
		}
	}
	return var_items.dup()
}

fn wc_nav_menu_inner_blocks(var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_logout_endpoint := rt.call_function('get_option', [rt.new_string('woocommerce_logout_endpoint'), rt.new_string('customer-logout')])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_logout_endpoint)) && rt.is_true(var_inner_blocks))) {
		{
			mut iter_1 := var_inner_blocks.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_inner_block := item_1.val
				mut var_inner_block_key := item_1.key
				mut var_url := if !(rt.get_property(var_inner_block, 'parsed_block').array_get('attrs').array_get('url')).is_null() { rt.get_property(var_inner_block, 'parsed_block').array_get('attrs').array_get('url') } else { rt.new_string('') }
				mut var_path := if !(rt.call_function('wp_parse_url', [var_url.dup(), rt.get_constant('PHP_URL_PATH')])).is_null() { rt.call_function('wp_parse_url', [var_url.dup(), rt.get_constant('PHP_URL_PATH')]) } else { rt.new_string('') }
				mut var_query := if !(rt.call_function('wp_parse_url', [var_url.dup(), rt.get_constant('PHP_URL_QUERY')])).is_null() { rt.call_function('wp_parse_url', [var_url.dup(), rt.get_constant('PHP_URL_QUERY')]) } else { rt.new_string('') }
				mut var_is_logout_link := rt.is_true(rt.call_function('strstr', [var_path.dup(), var_logout_endpoint.dup()])) || rt.is_true(rt.call_function('strstr', [var_query.dup(), var_logout_endpoint.dup()]))
				if !(var_is_logout_link) {
					continue
				}
				if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
					rt.get_property(var_inner_block, 'parsed_block').array_get_mut('attrs').array_set('url', rt.call_function('wp_nonce_url', [rt.get_property(var_inner_block, 'parsed_block').array_get('attrs').array_get('url'), rt.new_string('customer-logout')]))
				} else {
					var_inner_blocks.array_unset(var_inner_block_key)
				}
			}
		}
	}
	return var_inner_blocks.dup()
}

fn wc_nav_menu_item_classes(var_menu_items rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{}))))) {
		return var_menu_items.dup()
	}
	mut var_shop_page := wc_get_page_id(rt.new_string('shop'))
	mut var_page_for_posts := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_items)) && rt.is_true(rt.new_bool(var_menu_items.dup().is_array())))) {
		{
			mut iter_1 := var_menu_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_menu_item := item_1.val
				mut var_key := item_1.key
				mut var_classes := rt.cast_array(rt.get_property(var_menu_item, 'classes'))
				mut var_menu_id := // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_page_for_posts, var_menu_id)) && !(rt.get_property(var_menu_item, 'object')).is_null())) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item, 'object'))))) {
					rt.set_property(var_menu_items.array_get(var_key), 'current', rt.new_bool(false))
					if rt.is_true(rt.call_function('in_array', [rt.new_string('current_page_parent'), var_classes.dup(), rt.new_bool(true)])) {
						var_classes.array_unset(rt.call_function('array_search', [rt.new_string('current_page_parent'), var_classes.dup(), rt.new_bool(true)]))
					}
					if rt.is_true(rt.call_function('in_array', [rt.new_string('current-menu-item'), var_classes.dup(), rt.new_bool(true)])) {
						var_classes.array_unset(rt.call_function('array_search', [rt.new_string('current-menu-item'), var_classes.dup(), rt.new_bool(true)]))
					}
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) && rt.is_true(rt.identical(var_shop_page, var_menu_id)))) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item, 'object'))))) {
					rt.set_property(var_menu_items.array_get(var_key), 'current', rt.new_bool(true))
					var_classes.array_push('current-menu-item')
					var_classes.array_push('current_page_item')
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) && rt.is_true(rt.identical(var_shop_page, var_menu_id)))) {
					var_classes.array_push('current_page_parent')
				}
				rt.set_property(var_menu_items.array_get(var_key), 'classes', rt.call_function('array_unique', [var_classes.dup()]))
			}
		}
	}
	return var_menu_items.dup()
}

fn wc_list_pages(var_pages rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{}))))) {
		return var_pages.dup()
	}
	var_pages = rt.call_function('str_replace', [rt.new_string('current_page_parent'), rt.new_string(''), var_pages.dup()])
	mut var_shop_page := rt.new_string('page-item-' + (wc_get_page_id(rt.new_string('shop'))).str())
	if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
		return rt.call_function('str_replace', [var_shop_page.dup(), (var_shop_page).str() + ' current_page_item', var_pages.dup()])
	}
	return rt.call_function('str_replace', [var_shop_page.dup(), (var_shop_page).str() + ' current_page_parent', var_pages.dup()])
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_endpoint() &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wc_page_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.new_string('wc_page_endpoint_title')])
	rt.call_function('add_filter', [rt.new_string('document_title_parts'), rt.new_string('wc_page_endpoint_document_title_parts')])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu_objects'), rt.new_string('wc_nav_menu_items'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('block_core_navigation_render_inner_blocks'), rt.new_string('wc_nav_menu_inner_blocks')])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu_objects'), rt.new_string('wc_nav_menu_item_classes'), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_list_pages'), rt.new_string('wc_list_pages')])
}
