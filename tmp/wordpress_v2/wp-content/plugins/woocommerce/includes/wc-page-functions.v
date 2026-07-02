import rt

fn wc_page_endpoint_title(var_title_arg rt.PhpVal) rt.PhpVal {
	mut var_title := var_title_arg
	mut var_wp_query := rt.new_null()
	mut var_endpoint := rt.new_null()
	mut var_action := rt.new_null()
	mut var_endpoint_title := rt.new_null()
	if !(var_wp_query.clone().is_null())
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_page', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) {
		var_endpoint = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'query'), 'get_current_endpoint', []rt.PhpVal{})
		var_action = if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))]),
			]) } else { rt.new_string('') }
		var_endpoint_title = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'query'), 'get_endpoint_title', [var_endpoint.clone(),
			var_action.clone()])
		var_title = if rt.is_true(var_endpoint_title) { var_endpoint_title } else { var_title }
		rt.call_function('remove_filter', [rt.new_string('the_title'),
			rt.new_string('wc_page_endpoint_title')])
	}
	return var_title.clone()
}

fn wc_page_endpoint_document_title_parts(var_title rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_endpoint := rt.new_null()
	mut var_action := rt.new_null()
	mut var_endpoint_title := rt.new_null()
	if !(var_wp_query.clone().is_null())
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_page', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) {
		var_endpoint = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'query'), 'get_current_endpoint', []rt.PhpVal{})
		var_action = if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))]),
			]) } else { rt.new_string('') }
		var_endpoint_title = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'query'), 'get_endpoint_title', [var_endpoint.clone(),
			var_action.clone()])
		var_title.array_set('title', if rt.is_true(var_endpoint_title) {
			var_endpoint_title
		} else {
			var_title.array_get(rt.new_string('title'))
		})
		rt.call_function('remove_filter', [rt.new_string('document_title_parts'),
			rt.new_string('wc_page_endpoint_document_title_parts')])
	}
	return var_title.clone()
}

fn wc_get_page_id(var_page_arg rt.PhpVal) rt.PhpVal {
	mut var_page := var_page_arg
	if rt.is_true(rt.identical(rt.new_string('pay'), var_page))
		|| rt.is_true(rt.identical(rt.new_string('thanks'), var_page)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.1'),
			rt.new_string('The "pay" and "thanks" pages are no-longer used - an endpoint is added to the checkout instead. To get a valid link use the WC_Order::get_checkout_payment_url() or WC_Order::get_checkout_order_received_url() methods instead.')])
		var_page = rt.new_string('checkout')
	}
	if rt.is_true(rt.identical(rt.new_string('change_password'), var_page))
		|| rt.is_true(rt.identical(rt.new_string('edit_address'), var_page))
		|| rt.is_true(rt.identical(rt.new_string('lost_password'), var_page)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.1'),
			rt.new_string('The "change_password", "edit_address" and "lost_password" pages are no-longer used - an endpoint is added to the my-account instead. To get a valid link use the wc_customer_edit_account_url() function instead.')])
		var_page = rt.new_string('myaccount')
	}
	var_page = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_' + var_page.str() + '_page_id'),
		rt.call_function('get_option', [
			rt.new_string('woocommerce_' + var_page.str() + '_page_id'),
		]),
	])
	return if rt.is_true(var_page) { rt.call_function('absint', [
			var_page.clone()]) } else { -1 }
}

fn wc_get_page_permalink(var_page rt.PhpVal, var_fallback rt.PhpVal) rt.PhpVal {
	mut var_page_id := rt.new_null()
	mut var_permalink := rt.new_null()
	var_page_id = wc_get_page_id(var_page.clone())
	var_permalink = if rt.is_true(rt.less(rt.new_int(0), var_page_id)) { rt.call_function('get_permalink', [
			var_page_id.clone(),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalink)))) {
		var_permalink = if var_fallback.clone().is_null() {
			rt.call_function('get_home_url', []rt.PhpVal{})
		} else {
			var_fallback
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_' + var_page.str() + '_page_permalink'),
		var_permalink.clone(),
	])
}

fn wc_get_endpoint_url(var_endpoint_arg rt.PhpVal, value string, permalink string) rt.PhpVal {
	mut var_value := value
	mut var_permalink := permalink
	mut var_endpoint := var_endpoint_arg
	mut var_query_vars := rt.new_null()
	mut var_query_string := rt.new_null()
	mut var_url := rt.new_null()
	if !(var_permalink.len > 0 && var_permalink != '0') {
		var_permalink = (rt.call_function('get_permalink', []rt.PhpVal{})).str()
	}
	var_query_vars = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'get_query_vars', []rt.PhpVal{})
	var_endpoint = if !(!rt.is_true(var_query_vars.array_get(var_endpoint))) {
		var_query_vars.array_get(var_endpoint)
	} else {
		var_endpoint
	}
	var_value = (if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_myaccount_edit_address_endpoint'),
		rt.new_string('edit-address'),
	]), var_endpoint))
	{
		rt.call_function('wc_edit_address_i18n', [rt.new_string(var_value.str())])
	} else {
		rt.new_string(var_value.str())
	}).str()
	if rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		if rt.is_true(rt.call_function('strstr', [rt.new_string(var_permalink.str()),
			rt.new_string('?')]))
		{
			var_query_string =
				rt.new_string('?' +(rt.call_function('wp_parse_url', [rt.new_string(var_permalink.str()), rt.get_constant('PHP_URL_QUERY')])).str())
			var_permalink = (rt.call_function('current', [
				rt.call_function('explode', [rt.new_string('?'),
					rt.new_string(var_permalink.str())]),
			])).str()
		} else {
			var_query_string = rt.new_string('')
		}
		var_url = rt.call_function('trailingslashit', [
			rt.new_string(var_permalink.str()),
		])
		if var_value.len > 0 && var_value != '0' {
			var_url = rt.concat(var_url, rt.new_string(
				(rt.call_function('trailingslashit', [var_endpoint.clone()])).str() +
				(rt.call_function('user_trailingslashit', [rt.new_string(var_value.str())])).str()))
		} else {
			var_url = rt.concat(var_url, rt.call_function('user_trailingslashit', [
				var_endpoint.clone(),
			]))
		}
		var_url = rt.concat(var_url, var_query_string)
	} else {
		var_url = rt.call_function('add_query_arg', [var_endpoint.clone(),
			rt.new_string(var_value.str()), rt.new_string(var_permalink.str())])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_endpoint_url'),
		var_url.clone(),
		var_endpoint.clone(),
		rt.new_string(var_value.str()),
		rt.new_string(var_permalink.str()),
	])
}

fn wc_get_review_order_url(var_order rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return ''
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint{}
	mut iife_result_0 := iife_temp_0.get_url(var_order.clone())
	return iife_result_0.str()
}

fn wc_nav_menu_items(var_items rt.PhpVal) rt.PhpVal {
	mut var_logout_endpoint := rt.new_null()
	mut var_item := rt.new_null()
	mut var_key := rt.new_null()
	mut var_path := rt.new_null()
	mut var_query := rt.new_null()
	mut var_is_logout_link := false
	var_logout_endpoint = rt.call_function('get_option', [
		rt.new_string('woocommerce_logout_endpoint'),
		rt.new_string('customer-logout'),
	])
	if !(!rt.is_true(var_logout_endpoint)) && !(!rt.is_true(var_items))
		&& var_items.clone().is_array() {
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item_shadow := item_1.val
			mut var_key_shadow := item_1.key
			if !rt.is_true(rt.get_property(var_item_shadow, 'url')) {
				continue
			}
			var_path = if !(rt.call_function('wp_parse_url', [
				rt.get_property(var_item_shadow, 'url'),
				rt.get_constant('PHP_URL_PATH'),
			])).is_null() { rt.call_function('wp_parse_url', [
					rt.get_property(var_item_shadow, 'url'),
					rt.get_constant('PHP_URL_PATH'),
				]) } else { rt.new_string('') }
			var_query = if !(rt.call_function('wp_parse_url', [
				rt.get_property(var_item_shadow, 'url'),
				rt.get_constant('PHP_URL_QUERY'),
			])).is_null() { rt.call_function('wp_parse_url', [
					rt.get_property(var_item_shadow, 'url'),
					rt.get_constant('PHP_URL_QUERY'),
				]) } else { rt.new_string('') }
			var_is_logout_link =
				rt.is_true(rt.call_function('strstr', [var_path.clone(), var_logout_endpoint.clone()]))
				|| rt.is_true(rt.call_function('strstr', [var_query.clone(), var_logout_endpoint.clone()]))
			if !var_is_logout_link {
				continue
			}
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
				rt.set_property(var_items.array_get(var_key_shadow), 'url', rt.call_function('wp_nonce_url', [
					rt.get_property(var_item_shadow, 'url'),
					rt.new_string('customer-logout'),
				]))
			} else {
				var_items.array_unset(var_key_shadow)
			}
		}
	}
	return var_items.clone()
}

fn wc_nav_menu_inner_blocks(var_inner_blocks rt.PhpVal) rt.PhpVal {
	mut var_logout_endpoint := rt.new_null()
	mut var_inner_block := rt.new_null()
	mut var_inner_block_key := rt.new_null()
	mut var_url := rt.new_null()
	mut var_path := rt.new_null()
	mut var_query := rt.new_null()
	mut var_is_logout_link := false
	var_logout_endpoint = rt.call_function('get_option', [
		rt.new_string('woocommerce_logout_endpoint'),
		rt.new_string('customer-logout'),
	])
	if !(!rt.is_true(var_logout_endpoint)) && rt.is_true(var_inner_blocks) {
		mut iter_2 := var_inner_blocks.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_inner_block_shadow := item_2.val
			mut var_inner_block_key_shadow := item_2.key
			var_url = if !(rt.get_property(var_inner_block_shadow, 'parsed_block').array_get(rt.new_string('attrs')).array_get(rt.new_string('url'))).is_null() {
				rt.get_property(var_inner_block_shadow, 'parsed_block').array_get(rt.new_string('attrs')).array_get(rt.new_string('url'))
			} else {
				rt.new_string('')
			}
			var_path = if !(rt.call_function('wp_parse_url', [
				var_url.clone(), rt.get_constant('PHP_URL_PATH')])).is_null() { rt.call_function('wp_parse_url', [
					var_url.clone(),
					rt.get_constant('PHP_URL_PATH'),
				]) } else { rt.new_string('') }
			var_query = if !(rt.call_function('wp_parse_url', [
				var_url.clone(), rt.get_constant('PHP_URL_QUERY')])).is_null() { rt.call_function('wp_parse_url', [
					var_url.clone(),
					rt.get_constant('PHP_URL_QUERY'),
				]) } else { rt.new_string('') }
			var_is_logout_link =
				rt.is_true(rt.call_function('strstr', [var_path.clone(), var_logout_endpoint.clone()]))
				|| rt.is_true(rt.call_function('strstr', [var_query.clone(), var_logout_endpoint.clone()]))
			if !var_is_logout_link {
				continue
			}
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
				rt.get_property(var_inner_block_shadow, 'parsed_block').array_get_mut('attrs').array_set('url', rt.call_function('wp_nonce_url', [
					rt.get_property(var_inner_block_shadow, 'parsed_block').array_get(rt.new_string('attrs')).array_get(rt.new_string('url')),
					rt.new_string('customer-logout'),
				]))
			} else {
				var_inner_blocks.array_unset(var_inner_block_key_shadow)
			}
		}
	}
	return var_inner_blocks.clone()
}

fn wc_nav_menu_item_classes(var_menu_items rt.PhpVal) rt.PhpVal {
	mut var_shop_page := rt.new_null()
	mut var_page_for_posts := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_key := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_menu_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{}))))) {
		return var_menu_items.clone()
	}
	var_shop_page = wc_get_page_id(rt.new_string('shop'))
	var_page_for_posts = rt.new_int((rt.call_function('get_option', [
		rt.new_string('page_for_posts'),
	])).to_i64())
	if !(!rt.is_true(var_menu_items)) && var_menu_items.clone().is_array() {
		mut iter_3 := var_menu_items.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_menu_item_shadow := item_3.val
			mut var_key_shadow := item_3.key
			var_classes = rt.cast_array(rt.get_property(var_menu_item_shadow, 'classes'))
			var_menu_id = rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64())
			if rt.is_true(rt.identical(var_page_for_posts, var_menu_id))
				&& !(rt.get_property(var_menu_item_shadow, 'object')).is_null()
				&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item_shadow, 'object'))) {
				rt.set_property(var_menu_items.array_get(var_key_shadow), 'current',
					rt.new_bool(false))
				if rt.is_true(rt.call_function('in_array', [
					rt.new_string('current_page_parent'),
					var_classes.clone(),
					rt.new_bool(true),
				]))
				{
					var_classes.array_unset(rt.call_function('array_search', [
						rt.new_string('current_page_parent'),
						var_classes.clone(),
						rt.new_bool(true),
					]))
				}
				if rt.is_true(rt.call_function('in_array', [
					rt.new_string('current-menu-item'),
					var_classes.clone(),
					rt.new_bool(true),
				]))
				{
					var_classes.array_unset(rt.call_function('array_search', [
						rt.new_string('current-menu-item'),
						var_classes.clone(),
						rt.new_bool(true),
					]))
				}
			} else if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
				&& rt.is_true(rt.identical(var_shop_page, var_menu_id))
				&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item_shadow, 'object'))) {
				rt.set_property(var_menu_items.array_get(var_key_shadow), 'current',
					rt.new_bool(true))
				var_classes.array_push('current-menu-item')
				var_classes.array_push('current_page_item')
			} else if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')]))
				&& rt.is_true(rt.identical(var_shop_page, var_menu_id)) {
				var_classes.array_push('current_page_parent')
			}
			rt.set_property(var_menu_items.array_get(var_key_shadow), 'classes', rt.call_function('array_unique', [
				var_classes.clone(),
			]))
		}
	}
	return var_menu_items.clone()
}

fn wc_list_pages(var_pages_arg rt.PhpVal) rt.PhpVal {
	mut var_pages := var_pages_arg
	mut var_shop_page := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{}))))) {
		return var_pages.clone()
	}
	var_pages = rt.call_function('str_replace', [rt.new_string('current_page_parent'),
		rt.new_string(''), var_pages.clone()])
	var_shop_page = rt.new_string('page-item-' + (wc_get_page_id(rt.new_string('shop'))).str())
	if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
		return rt.call_function('str_replace', [var_shop_page.clone(),
			rt.new_string(var_shop_page.str() + ' current_page_item'),
			var_pages.clone()])
	}
	return rt.call_function('str_replace', [var_shop_page.clone(),
		rt.new_string(var_shop_page.str() + ' current_page_parent'),
		var_pages.clone()])
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_endpoint(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.new_string('wc_page_endpoint_title')])
	rt.call_function('add_filter', [rt.new_string('document_title_parts'),
		rt.new_string('wc_page_endpoint_document_title_parts')])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu_objects'),
		rt.new_string('wc_nav_menu_items'), rt.new_int(10)])
	rt.call_function('add_filter', [
		rt.new_string('block_core_navigation_render_inner_blocks'),
		rt.new_string('wc_nav_menu_inner_blocks'),
	])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu_objects'),
		rt.new_string('wc_nav_menu_item_classes'), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_list_pages'),
		rt.new_string('wc_list_pages')])
}
