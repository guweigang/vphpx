import rt

struct Class_WC_AJAX {
	rt.PhpObjectBase
}

fn Class_WC_AJAX.init() {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'define_ajax' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'do_wc_ajax' }]), rt.new_int(0)])
	Class_WC_AJAX.add_ajax_events()
}

fn Class_WC_AJAX.get_endpoint(request string) rt.PhpVal {
	return rt.call_function('esc_url_raw', [rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_get_endpoint'), rt.call_function('add_query_arg', [rt.new_string('wc-ajax'), rt.new_string(request), rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'remove_item' }, rt.ArrayItem{ key: none, val: 'add-to-cart' }, rt.ArrayItem{ key: none, val: 'added-to-cart' }, rt.ArrayItem{ key: none, val: 'order_again' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('home_url', [rt.new_string('/'), rt.new_string('relative')])])]), rt.new_string(request)])])
}

fn Class_WC_AJAX.set_wc_ajax_argument_in_query() {
	mut var_wp_query := rt.new_null()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc-ajax')))) && !rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')])) {
		rt.call_method(var_wp_query, 'set', [rt.new_string('wc-ajax'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc-ajax'))])])])
	}
}

fn Class_WC_AJAX.define_ajax() {
	mut var_wp_query := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	Class_WC_AJAX.set_wc_ajax_argument_in_query()
	if !(!rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')]))) {
		rt.call_function('wc_maybe_define_constant', [rt.new_string('DOING_AJAX'), rt.new_bool(true)])
		rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_DOING_AJAX'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) || (rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')))))) {
			rt.call_function('ini_set', [rt.new_string('display_errors'), rt.new_int(0)])
		}
		rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'hide_errors', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.wc_ajax_headers() {
	mut var_file := rt.new_null()
	mut var_line := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('send_origin_headers', []rt.PhpVal{})
		rt.call_function('send_nosniff_header', []rt.PhpVal{})
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())])
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
		rt.call_function('status_header', [rt.new_int(200)])
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('WP_DEBUG'))
	} else if rt.is_true(iife_result_0) {
		rt.call_function('headers_sent', [var_file.clone(), var_line.clone()])
		rt.call_function('trigger_error', [rt.new_string("wc_ajax_headers cannot set headers - headers already sent by ${var_file.to_string()} on line ${var_line.to_string()}"), rt.get_constant('E_USER_NOTICE')])
	}
}

fn Class_WC_AJAX.do_wc_ajax() {
	mut var_wp_query := rt.new_null()
	Class_WC_AJAX.set_wc_ajax_argument_in_query()
	mut var_action := rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')])
	if rt.is_true(var_action) {
		Class_WC_AJAX.wc_ajax_headers()
		var_action = rt.call_function('sanitize_text_field', [var_action.clone()])
		rt.call_function('do_action', [rt.new_string('wc_ajax_' + (var_action).str())])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.add_ajax_events() {
	mut var_ajax_events_nopriv := ['get_refreshed_fragments', 'apply_coupon', 'remove_coupon', 'update_shipping_method', 'get_cart_totals', 'update_order_review', 'add_to_cart', 'remove_from_cart', 'checkout', 'get_variation', 'get_customer_location']
	for var_ajax_event in var_ajax_events_nopriv {
		rt.call_function('add_action', [rt.new_string('wp_ajax_woocommerce_' + ajax_event), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
		rt.call_function('add_action', [rt.new_string('wp_ajax_nopriv_woocommerce_' + ajax_event), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
		rt.call_function('add_action', [rt.new_string('wc_ajax_' + ajax_event), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
	}
	mut var_ajax_events := ['feature_product', 'mark_order_status', 'get_order_details', 'add_attribute', 'add_new_attribute', 'remove_variations', 'save_attributes', 'add_attributes_and_variations', 'add_variation', 'link_all_variations', 'revoke_access_to_download', 'grant_access_to_download', 'get_customer_details', 'add_order_item', 'add_order_fee', 'add_order_shipping', 'add_order_tax', 'add_coupon_discount', 'remove_order_coupon', 'remove_order_item', 'remove_order_tax', 'calc_line_taxes', 'save_order_items', 'load_order_items', 'add_order_note', 'delete_order_note', 'json_search_order_metakeys', 'json_search_products', 'json_search_products_and_variations', 'json_search_downloadable_products_and_variations', 'json_search_customers', 'json_search_categories', 'json_search_categories_tree', 'json_search_taxonomy_terms', 'json_search_product_attributes', 'json_search_pages', 'term_ordering', 'product_ordering', 'refund_line_items', 'delete_refund', 'rated', 'update_api_key', 'load_variations', 'save_variations', 'bulk_edit_variations', 'tax_rates_save_changes', 'shipping_zones_save_changes', 'shipping_zone_add_method', 'shipping_zone_remove_method', 'shipping_zone_methods_save_changes', 'shipping_zone_methods_save_settings', 'shipping_classes_save_changes', 'shipping_providers_save_changes', 'toggle_gateway_enabled', 'load_status_widget', 'load_recent_reviews_widget']
	for var_ajax_event in var_ajax_events {
		rt.call_function('add_action', [rt.new_string('wp_ajax_woocommerce_' + ajax_event), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
	}
	mut var_ajax_private_events := ['order_add_meta', 'order_delete_meta']
	for var_ajax_event in var_ajax_private_events {
		closure_2_fn := fn [var_ajax_event] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: rt.new_string((var_ajax_event).str()) }])])
			return rt.new_null()
			}
		rt.call_function('add_action', [rt.new_string('wp_ajax_woocommerce_' + ajax_event), rt.new_closure(closure_2_fn)])
	}
	mut var_ajax_heartbeat_callbacks := ['order_refresh_lock', 'check_locked_orders']
	for var_ajax_callback in var_ajax_heartbeat_callbacks {
		closure_3_fn := fn [var_ajax_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_response := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_data := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return
			}
		rt.call_function('add_filter', [rt.new_string('heartbeat_received'), rt.new_closure(closure_3_fn), rt.new_int(11), rt.new_int(2)])
	}
}

fn Class_WC_AJAX.get_refreshed_fragments() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_mini_cart', []rt.PhpVal{})
	mut var_mini_cart := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'fragments', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_fragments'), rt.create_array([rt.ArrayItem{ key: 'div.widget_shopping_cart_content', val: '<div class="widget_shopping_cart_content">' + (var_mini_cart).str() + '</div>' }])]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_hash', []rt.PhpVal{}) }])
	rt.call_function('wp_send_json', [var_data.clone()])
}

fn Class_WC_AJAX.apply_coupon() {
	rt.call_function('check_ajax_referer', [rt.new_string('apply-coupon'), rt.new_string('security')])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_3 := iife_temp_3.get_value_or_default(rt.get_superglobal('_POST').clone(), rt.new_string('coupon_code'))
	mut var_coupon_code := iife_result_3
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_4 := iife_temp_4.get_value_or_default(rt.get_superglobal('_POST').clone(), rt.new_string('billing_email'))
	mut var_billing_email := iife_result_4
	if var_billing_email.clone().is_string() && rt.is_true(rt.call_function('is_email', [var_billing_email.clone()])) {
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'), 'set_billing_email', [var_billing_email.clone()])
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_5 := iife_temp_5.is_null_or_whitespace(var_coupon_code.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'add_discount', [rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [var_coupon_code.clone()])])])
	} else {
		mut iife_temp_6 := Class_WC_Coupon{}
		mut iife_result_6 := iife_temp_6.get_generic_coupon_error(Class_WC_Coupon.e_wc_coupon_please_enter())
		mut iife_temp_7 := Class_WC_Coupon{}
		mut iife_result_7 := iife_temp_7.get_generic_coupon_error(Class_WC_Coupon.e_wc_coupon_please_enter())
		rt.call_function('wc_add_notice', [iife_result_6, rt.new_string('error')])
	}
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.remove_coupon() {
	rt.call_function('check_ajax_referer', [rt.new_string('remove-coupon'), rt.new_string('security')])
	mut var_coupon := if rt.get_superglobal('_POST').array_isset(rt.new_string('coupon')) { rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('coupon'))])]) } else { rt.new_bool(false) }
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_8 := iife_temp_8.is_null_or_whitespace(var_coupon.clone())
	if rt.is_true(iife_result_8) {
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('Sorry there was a problem removing this coupon.'), rt.new_string('woocommerce')]), rt.new_string('error')])
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'remove_coupon', [var_coupon.clone()])
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('Coupon has been removed.'), rt.new_string('woocommerce')])])
	}
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.update_shipping_method() {
	rt.call_function('check_ajax_referer', [rt.new_string('update-shipping-method'), rt.new_string('security')])
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'), rt.new_bool(true)])
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')])
	mut var_posted_shipping_methods := if rt.get_superglobal('_POST').array_isset(rt.new_string('shipping_method')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('shipping_method'))])]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(var_posted_shipping_methods.clone().is_array())) {
		mut iter_1 := var_posted_shipping_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_i := item_1.key
			if !(var_value.clone().is_string()) {
				continue
			}
			var_chosen_shipping_methods.array_set(var_i, var_value.clone())
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_shipping_methods'), var_chosen_shipping_methods.clone()])
	Class_WC_AJAX.get_cart_totals()
}

fn Class_WC_AJAX.get_cart_totals() {
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'), rt.new_bool(true)])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'calculate_totals', []rt.PhpVal{})
	rt.call_function('woocommerce_cart_totals', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.update_order_review_expired() {
	rt.call_function('wp_send_json', [rt.create_array([rt.ArrayItem{ key: 'fragments', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_update_order_review_fragments'), rt.create_array([rt.ArrayItem{ key: 'form.woocommerce-checkout', val: rt.call_function('wc_print_notice', [rt.new_string((rt.call_function('esc_html__', [rt.new_string('Sorry, your session has expired.'), rt.new_string('woocommerce')])).str() + ' <a href="' + (rt.call_function('esc_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])).str() + '" class="wc-backward">' + (rt.call_function('esc_html__', [rt.new_string('Return to shop'), rt.new_string('woocommerce')])).str() + '</a>'), rt.new_string('error'), rt.new_array(), rt.new_bool(true)]) }])]) }])])
}

fn Class_WC_AJAX.update_order_review() {
	rt.call_function('check_ajax_referer', [rt.new_string('update-order-review'), rt.new_string('security')])
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CHECKOUT'), rt.new_bool(true)])
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_update_order_review_expired'), rt.new_bool(true)])) {
		Class_WC_AJAX.update_order_review_expired()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_checkout_update_order_review'), if rt.get_superglobal('_POST').array_isset(rt.new_string('post_data')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('post_data'))]) } else { rt.new_string('') }])
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')])
	mut var_posted_shipping_methods := if rt.get_superglobal('_POST').array_isset(rt.new_string('shipping_method')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('shipping_method'))])]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(var_posted_shipping_methods.clone().is_array())) {
		mut iter_2 := var_posted_shipping_methods.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_i := item_2.key
			if !(var_value.clone().is_string()) {
				continue
			}
			var_chosen_shipping_methods.array_set(var_i, var_value.clone())
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_shipping_methods'), var_chosen_shipping_methods.clone()])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_payment_method'), if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('payment_method'))) { rt.new_string('') } else { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('payment_method'))])]) }])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'set_props', [rt.create_array([rt.ArrayItem{ key: 'billing_country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('country')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('country'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'billing_state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('state')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('state'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'billing_postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('postcode')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('postcode'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'billing_city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('city')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('city'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'billing_address_1', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('address')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('address'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'billing_address_2', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('address_2')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('address_2'))])]) } else { rt.new_null() } }])])
	if rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'set_props', [rt.create_array([rt.ArrayItem{ key: 'shipping_country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('country')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('country'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('state')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('state'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('postcode')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('postcode'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('city')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('city'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_address_1', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('address')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('address'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_address_2', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('address_2')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('address_2'))])]) } else { rt.new_null() } }])])
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'set_props', [rt.create_array([rt.ArrayItem{ key: 'shipping_country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_country')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_country'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_state')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_state'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_postcode')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_postcode'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_city')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_city'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_address_1', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_address')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_address'))])]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'shipping_address_2', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('s_address_2')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('s_address_2'))])]) } else { rt.new_null() } }])])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('has_full_address')) && rt.is_true(rt.call_function('wc_string_to_bool', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('has_full_address'))])])])) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'set_calculated_shipping', [rt.new_bool(true)])
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'set_calculated_shipping', [rt.new_bool(false)])
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'save', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'calculate_shipping', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'calculate_totals', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_order_review', []rt.PhpVal{})
	mut var_woocommerce_order_review := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_checkout_payment', []rt.PhpVal{})
	mut var_woocommerce_checkout_payment := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_reload_checkout := rt.new_bool(!(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'reload_checkout')).is_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reload_checkout)))) {
	mut var_messages := rt.call_function('wc_print_notices', [rt.new_bool(true)])
	} else {
	var_messages = rt.new_string('')
	}
	rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'refresh_totals') = rt.new_null()
	rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'reload_checkout') = rt.new_null()
	rt.call_function('wp_send_json', [rt.create_array([rt.ArrayItem{ key: 'result', val: if !rt.is_true(var_messages) { 'success' } else { 'failure' } }, rt.ArrayItem{ key: 'messages', val: var_messages }, rt.ArrayItem{ key: 'reload', val: var_reload_checkout }, rt.ArrayItem{ key: 'fragments', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_update_order_review_fragments'), rt.create_array([rt.ArrayItem{ key: '.woocommerce-checkout-review-order-table', val: var_woocommerce_order_review }, rt.ArrayItem{ key: '.woocommerce-checkout-payment', val: var_woocommerce_checkout_payment }])]) }])])
}

fn Class_WC_AJAX.add_to_cart() {
	rt.call_function('ob_start', []rt.PhpVal{})
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('product_id'))) {
		return
	}
	mut var_product_id := rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_product_id'), rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))])])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	mut var_quantity := if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('quantity'))) { rt.new_int(1) } else { rt.call_function('wc_stock_amount', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('quantity'))])]) }
	mut var_passed_validation := rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_validation'), rt.new_bool(true), var_product_id.clone(), var_quantity.clone()])
	mut var_product_status := rt.call_function('get_post_status', [var_product_id.clone()])
	mut var_variation_id := rt.new_int(0)
	mut var_variation := rt.new_array()
	if rt.is_true(var_product) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) {
	var_variation_id = var_product_id.clone()
	var_product_id = rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
	var_variation = rt.call_method(var_product, 'get_variation_attributes', []rt.PhpVal{})
	}
	if rt.is_true(var_passed_validation) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'add_to_cart', [var_product_id.clone(), var_quantity.clone(), var_variation_id.clone(), var_variation.clone()]))))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_product_status)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_ajax_added_to_cart'), var_product_id.clone()])
		rt.call_function('do_action', [rt.new_string('internal_woocommerce_cart_item_added_from_user_request'), if rt.is_true(var_variation_id) { var_variation_id } else { var_product_id }, var_quantity.clone()])
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_cart_redirect_after_add')]))) {
			rt.call_function('wc_add_to_cart_message', [rt.create_array([rt.ArrayItem{ key: var_product_id, val: var_quantity }]), rt.new_bool(true)])
		}
		Class_WC_AJAX.get_refreshed_fragments()
	} else {
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'error', val: true }, rt.ArrayItem{ key: 'product_url', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_redirect_after_error'), rt.call_function('get_permalink', [var_product_id.clone()]), var_product_id.clone()]) }])
		rt.call_function('wp_send_json', [var_data.clone()])
	}
}

fn Class_WC_AJAX.remove_from_cart() {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_cart_item_key := rt.call_function('wc_clean', [if rt.get_superglobal('_POST').array_isset(rt.new_string('cart_item_key')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('cart_item_key'))]) } else { rt.new_string('') }])
	if rt.is_true(var_cart_item_key) && var_cart_item_key.clone().is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'remove_cart_item', [var_cart_item_key.clone()]))))) {
		rt.call_function('do_action', [rt.new_string('internal_woocommerce_cart_item_removed_from_user_request'), var_cart_item_key.clone(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')])
		Class_WC_AJAX.get_refreshed_fragments()
	} else {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.checkout() {
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CHECKOUT'), rt.new_bool(true)])
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'checkout', []rt.PhpVal{}), 'process_checkout', []rt.PhpVal{})
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn Class_WC_AJAX.get_variation() {
	rt.call_function('ob_start', []rt.PhpVal{})
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_variable_product := rt.call_function('wc_get_product', [rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_variable_product)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut iife_temp_9 := Class_WC_Data_Store{}
	mut iife_result_9 := iife_temp_9.load(rt.new_string('product'))
	mut var_data_store := iife_result_9
	mut var_variation_id := rt.call_method(var_data_store, 'find_matching_product_variation', [var_variable_product.clone(), rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()])])
	mut var_variation := if rt.is_true(var_variation_id) { rt.call_method(var_variable_product, 'get_available_variation', [var_variation_id.clone()]) } else { rt.new_bool(false) }
	rt.call_function('wp_send_json', [var_variation.clone()])
}

fn Class_WC_AJAX.get_customer_location() {
	mut iife_temp_10 := Class_WC_Cache_Helper{}
	mut iife_result_10 := iife_temp_10.geolocation_ajax_get_location_hash()
	mut var_location_hash := iife_result_10
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'hash', val: var_location_hash }])])
}

fn Class_WC_AJAX.feature_product() {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')])) && rt.is_true(rt.call_function('check_admin_referer', [rt.new_string('woocommerce-feature-product')])) && rt.get_superglobal('_GET').array_isset(rt.new_string('product_id')) {
		mut var_product := rt.call_function('wc_get_product', [rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('product_id'))])])
		if rt.is_true(var_product) {
			rt.call_method(var_product, 'set_featured', [rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_featured', []rt.PhpVal{}))))])
			rt.call_method(var_product, 'save', []rt.PhpVal{})
		}
	}
	rt.call_function('wp_safe_redirect', [if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) { rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'trashed' }, rt.ArrayItem{ key: none, val: 'untrashed' }, rt.ArrayItem{ key: none, val: 'deleted' }, rt.ArrayItem{ key: none, val: 'ids' }]), rt.call_function('wp_get_referer', []rt.PhpVal{})]) } else { rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product')]) }])
	exit(0)
}

fn Class_WC_AJAX.mark_order_status() {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')])) && rt.is_true(rt.call_function('check_admin_referer', [rt.new_string('woocommerce-mark-order-status')])) && rt.get_superglobal('_GET').array_isset(rt.new_string('status')) && rt.get_superglobal('_GET').array_isset(rt.new_string('order_id')) {
		mut var_status := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('status'))])])
		mut var_order := rt.call_function('wc_get_order', [rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('order_id'))])])])
		if rt.is_true(rt.call_function('wc_is_order_status', [rt.new_string('wc-' + (var_status).str())])) && rt.is_true(var_order) {
			rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
			rt.call_method(var_order, 'update_status', [var_status.clone(), rt.new_string(''), rt.new_bool(true)])
			rt.call_function('do_action', [rt.new_string('woocommerce_order_edit_status'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_status.clone()])
		}
	}
	rt.call_function('wp_safe_redirect', [if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) { rt.call_function('wp_get_referer', []rt.PhpVal{}) } else { rt.call_function('admin_url', [rt.new_string('edit.php?post_type=shop_order')]) }])
	exit(0)
}

fn Class_WC_AJAX.get_order_details() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-preview-order'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('order_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_order := rt.call_function('wc_get_order', [rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('order_id'))])])
	if rt.is_true(var_order) {
		rt.include_file(@DIR + '/admin/list-tables/class-wc-admin-list-table-orders.php', '2')
		mut iife_temp_11 := Class_WC_Admin_List_Table_Orders{}
		mut iife_result_11 := iife_temp_11.order_preview_get_order_details(var_order.clone())
		mut iife_temp_12 := Class_WC_Admin_List_Table_Orders{}
		mut iife_result_12 := iife_temp_12.order_preview_get_order_details(var_order.clone())
		rt.call_function('wp_send_json_success', [iife_result_11])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.add_attribute() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('add-attribute'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('taxonomy')) && rt.get_superglobal('_POST').array_isset(rt.new_string('i')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_product_type := if rt.get_superglobal('_POST').array_isset(rt.new_string('product_type')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('product_type'))])]) } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() }
	mut var_i := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('i'))])
	mut var_metabox_class := rt.new_array()
	mut var_attribute := create_wc_product_attribute()
	rt.call_method(var_attribute, 'set_id', [rt.call_function('wc_attribute_taxonomy_id_by_name', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy'))])])])])
	rt.call_method(var_attribute, 'set_name', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy'))])])])
	rt.call_method(var_attribute, 'set_visible', [rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_default_visibility'), rt.new_int(1)])])
	rt.call_method(var_attribute, 'set_variation', [rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_default_is_variation'), rt.new_int(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_product_type)) { 1 } else { 0 }), var_product_type.clone()])])
	if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
		var_metabox_class << rt.new_string('taxonomy')
		var_metabox_class << rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})
	}
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-product-attribute.php', '1')
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.add_new_attribute() {
	rt.call_function('check_ajax_referer', [rt.new_string('add-attribute'), rt.new_string('security')])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_product_terms')])) && rt.get_superglobal('_POST').array_isset(rt.new_string('taxonomy')) && rt.get_superglobal('_POST').array_isset(rt.new_string('term')) {
		mut var_taxonomy := rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy'))])])
		mut var_term := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('term'))])])
		if rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()])) {
			mut var_result := rt.call_function('wp_insert_term', [var_term.clone(), var_taxonomy.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.call_function('wp_send_json', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}) }])])
			} else {
				var_term = rt.call_function('get_term_by', [rt.new_string('id'), var_result.array_get(rt.new_string('term_id')), var_taxonomy.clone()])
				rt.call_function('wp_send_json', [rt.create_array([rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') }])])
			}
		}
	}
	rt.call_function('wp_die', [rt.new_int(-1)])
}

fn Class_WC_AJAX.remove_variations() {
	rt.call_function('check_ajax_referer', [rt.new_string('delete-variations'), rt.new_string('security')])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')])) && rt.get_superglobal('_POST').array_isset(rt.new_string('variation_ids')) {
		mut var_variation_ids := rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('variation_ids'))]))])
		mut iter_3 := var_variation_ids.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_variation_id := item_3.val
			if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.call_function('get_post_type', [var_variation_id.clone()]))) {
				mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
				rt.call_method(var_variation, 'delete', [rt.new_bool(true)])
			}
		}
	}
	rt.call_function('wp_die', [rt.new_int(-1)])
}

fn Class_WC_AJAX.save_attributes() {
	mut var_data := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('save-attributes'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('data')) && rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	rt.call_function('parse_str', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('data'))]), var_data.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_product := Class_WC_AJAX.create_product_with_attributes(var_data.clone())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_attributes := rt.call_method(var_product, 'get_attributes', [rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_i := rt.new_int(-1)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_data.array_get(rt.new_string('attribute_names')))) {
		mut iter_4 := var_data.array_get(rt.new_string('attribute_names')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_attribute_name := item_4.val
			mut var_attribute := if var_attributes.array_isset(rt.call_function('sanitize_title', [var_attribute_name.clone()])) { var_attributes.array_get(rt.call_function('sanitize_title', [var_attribute_name.clone()])) } else { rt.new_bool(false) }
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute)))) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.pre_inc(var_i)
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_metabox_class := rt.new_array()
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
				var_metabox_class << rt.new_string('taxonomy')
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				var_metabox_class << rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.include_file(@DIR + '/admin/meta-boxes/views/html-product-attribute.php', '1')
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.add_attributes_and_variations() {
	mut var_data := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('add-attributes-and-variations'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('data')) && rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('parse_str', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('data'))]), var_data.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_product := Class_WC_AJAX.create_product_with_attributes(var_data.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	Class_WC_AJAX.create_all_product_variations(var_product.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('wp_die', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn Class_WC_AJAX.create_product_with_attributes(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('post_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut iife_temp_13 := Class_WC_Meta_Box_Product_Data{}
	mut iife_result_13 := iife_temp_13.prepare_attributes(var_data_mutated.clone())
	mut var_attributes := iife_result_13
	mut var_product_id := rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))])])
	mut var_product_type := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product_type')))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('product_type'))])]) } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() }
	mut iife_temp_14 := Class_WC_Product_Factory{}
	mut iife_result_14 := iife_temp_14.get_product_classname(var_product_id.clone(), var_product_type.clone())
	mut var_classname := iife_result_14
	mut var_product := rt.create_object_dynamically(var_classname, [var_product_id.clone()])
	rt.call_method(var_product, 'set_attributes', [var_attributes.clone()])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	return var_product.clone()
}

fn Class_WC_AJAX.create_all_product_variations(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_data_store := rt.call_method(var_product_mutated, 'get_data_store', []rt.PhpVal{})
	if !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_data_store }, rt.ArrayItem{ key: none, val: 'create_all_product_variations' }])])) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut iife_temp_15 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_15 := iife_temp_15.get_constant(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
	mut var_number := rt.call_method(var_data_store, 'create_all_product_variations', [var_product_mutated.clone(), iife_result_15])
	rt.call_method(var_data_store, 'sort_all_product_variations', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])
	return var_number.clone()
}

fn Class_WC_AJAX.add_variation() {
	rt.call_function('check_ajax_referer', [rt.new_string('add-variation'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('loop')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_post := rt.get_superglobal('post')
	mut var_product_id := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('post_id')).to_i64())
	var_post = rt.call_function('get_post', [var_product_id.clone()])
	mut var_loop := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('loop')).to_i64())
	mut var_product_object := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_product_id.clone()])
	mut var_variation_object := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])
	rt.call_method(var_variation_object, 'set_parent_id', [var_product_id.clone()])
	rt.call_method(var_variation_object, 'set_attributes', [rt.call_function('array_fill_keys', [rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.func_array_keys(rt.call_method(var_product_object, 'get_variation_attributes', []rt.PhpVal{}))]), rt.new_string('')])])
	rt.call_method(var_variation_object, 'save', []rt.PhpVal{})
	Class_WC_AJAX.render_variation_html(mut rt.cast_object_ptr[Class_WC_Product](var_product_object), mut rt.cast_object_ptr[Class_WC_Product](var_variation_object), mut rt.cast_object_ptr[Class_?float](var_loop), Class_WC_AJAX.base_cost_or_null(mut rt.cast_object_ptr[Class_WC_Product](var_product_object)))
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.link_all_variations() {
	rt.call_function('check_ajax_referer', [rt.new_string('link-variations'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_MAX_LINKED_VARIATIONS'), rt.new_int(50)])
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	mut var_post_id := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')) { rt.get_superglobal('_POST').array_get(rt.new_string('post_id')).to_i64() } else { 0 })
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	mut var_number_created := Class_WC_AJAX.create_all_product_variations(var_product.clone())
	rt.echo_val(rt.call_function('esc_html', [var_number_created.clone()]))
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.revoke_access_to_download() {
	rt.call_function('check_ajax_referer', [rt.new_string('revoke-access'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('download_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('product_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('permission_id')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_download_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('download_id'))])])
	mut var_product_id := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('product_id')).to_i64())
	mut var_order_id := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('order_id')).to_i64())
	mut var_permission_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('permission_id'))])
	mut iife_temp_16 := Class_WC_Data_Store{}
	mut iife_result_16 := iife_temp_16.load(rt.new_string('customer-download'))
	mut var_data_store := iife_result_16
	rt.call_method(var_data_store, 'delete_by_id', [var_permission_id.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_ajax_revoke_access_to_product_download'), var_download_id.clone(), var_product_id.clone(), var_order_id.clone(), var_permission_id.clone()])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.grant_access_to_download() {
	mut var_wpdb := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('grant-access'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('loop')) && rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('product_ids')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	mut var_order_id := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('order_id')).to_i64())
	mut var_product_ids := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('product_ids'))]))])])
	mut var_loop := rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('loop')).to_i64())
	mut var_file_counter := rt.new_int(0)
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_data := rt.new_array()
	mut var_items := rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	mut iter_5 := var_items.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_item := item_5.val
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{})) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_product_ids.clone(), rt.new_bool(true)])) && rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
			var_data.array_set(rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'files', val: rt.call_method(var_product, 'get_downloads', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_item', val: var_item }]))
		}
	}
	mut iter_6 := var_product_ids.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_product_id := item_6.val
		mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
		if var_data.array_isset(rt.call_method(var_product, 'get_id', []rt.PhpVal{})) {
		mut var_download_data := var_data.array_get(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))
		} else {
		var_download_data = rt.create_array([rt.ArrayItem{ key: 'files', val: rt.call_method(var_product, 'get_downloads', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'quantity', val: 1 }, rt.ArrayItem{ key: 'order_item', val: rt.new_null() }])
		}
		if !(!rt.is_true(var_download_data.array_get(rt.new_string('files')))) {
			mut iter_7 := var_download_data.array_get(rt.new_string('files')).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_file := item_7.val
				mut var_download_id := item_7.key
				mut var_inserted_id := rt.call_function('wc_downloadable_file_permission', [var_download_id.clone(), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_order.clone(), var_download_data.array_get(rt.new_string('quantity')), var_download_data.array_get(rt.new_string('order_item'))])
				if rt.is_true(var_inserted_id) {
					mut var_download := create_wc_customer_download(var_inserted_id.clone())
					rt.pre_inc(var_loop)
					rt.pre_inc(var_file_counter)
					if rt.is_true(rt.call_method(var_file, 'get_name', []rt.PhpVal{})) {
					mut var_file_count := rt.call_method(var_file, 'get_name', []rt.PhpVal{})
					} else {
					var_file_count = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File %d'), rt.new_string('woocommerce')]), var_file_counter.clone()])
					}
					rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-download-permission.php', '1')
				}
			}
		}
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.get_customer_details() {
	mut var_legacy_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('check_ajax_referer'), rt.new_string('get-customer-details'), rt.new_string('security')])
	mut var_user_id := rt.call_function('absint', [rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('filter_input'), rt.get_constant('INPUT_POST'), rt.new_string('user_id'), rt.get_constant('FILTER_VALIDATE_INT')])])
	mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_17 := iife_temp_17.get_user_in_current_site(var_user_id.clone())
	mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_18 := iife_temp_18.get_user_in_current_site(var_user_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || rt.is_true(rt.call_function('is_wp_error', [iife_result_17])) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_customer := create_wc_customer(var_user_id.clone())
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_found_customer_details')])) {
		rt.call_function('wc_deprecated_function', [rt.new_string('The woocommerce_found_customer_details filter'), rt.new_string('3.0'), rt.new_string('woocommerce_ajax_get_customer_details')])
	}
	mut var_data := var_customer.get_data()
	var_data.array_set('date_created', if rt.is_true(var_data.array_get(rt.new_string('date_created'))) { rt.call_method(var_data.array_get(rt.new_string('date_created')), 'getTimestamp', []rt.PhpVal{}) } else { rt.new_null() })
	var_data.array_set('date_modified', if rt.is_true(var_data.array_get(rt.new_string('date_modified'))) { rt.call_method(var_data.array_get(rt.new_string('date_modified')), 'getTimestamp', []rt.PhpVal{}) } else { rt.new_null() })
	var_data.array_unset(rt.new_string('meta_data'))
	mut var_customer_data := rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_get_customer_details'), var_data.clone(), var_customer, var_user_id.clone()])
	rt.call_function('wp_send_json', [var_customer_data.clone()])
}

fn Class_WC_AJAX.add_order_item() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
	}
	mut var_order_id := rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))])])
	mut var_items := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('items')))) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('items'))]) } else { rt.new_string('') }
	mut var_items_to_add := if rt.get_superglobal('_POST').array_isset(rt.new_string('data')) { rt.call_function('array_filter', [rt.call_function('wp_unslash', [rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('data')))])]) } else { rt.new_array() }
	mut var_response := Class_WC_AJAX.maybe_add_order_item(var_order_id.clone(), var_items.clone(), var_items_to_add.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn Class_WC_AJAX.maybe_add_order_item(var_order_id rt.PhpVal, var_items rt.PhpVal, var_items_to_add rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	mut var_items_mutated := var_items
	mut var_items_to_add_mutated := var_items_to_add
	mut var_order := rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if !(!rt.is_true(var_items_mutated)) {
		mut var_save_items := rt.new_array()
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_function('parse_str', [var_items_mutated.clone(), var_save_items.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_function('wc_save_order_items', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_save_items.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_order_notes := rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_added_items := rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut iter_8 := var_items_to_add_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		if (!(var_item.array_isset(rt.new_string('id')) && var_item.array_isset(rt.new_string('qty')))) || !rt.is_true(var_item.array_get(rt.new_string('id'))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_product_id := rt.call_function('absint', [var_item.array_get(rt.new_string('id'))])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_qty := rt.call_function('wc_stock_amount', [var_item.array_get(rt.new_string('qty'))])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception((rt.call_function('__', [rt.new_string('Invalid product ID'), rt.new_string('woocommerce')])).str() + ' ' + (var_product_id).str())))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is a variable product parent and cannot be added.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_name', []rt.PhpVal{})]))))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_validation_error := create_wp_error()
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_validation_error = rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_add_order_item_validation'), var_validation_error.clone(), var_product.clone(), var_order.clone(), var_qty.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.call_method(var_validation_error, 'get_error_code', []rt.PhpVal{})) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error: %s'), rt.new_string('woocommerce')]), rt.call_method(var_validation_error, 'get_error_message', []rt.PhpVal{})]))))
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_item_id := rt.call_method(var_order, 'add_product', [var_product.clone(), var_qty.clone(), rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }])])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_item = rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_order_item'), rt.call_method(var_order, 'get_item', [var_item_id.clone()]), var_item_id.clone(), var_order.clone(), var_product.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_added_items.array_set(var_item_id, var_item.clone())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_order_notes.array_set(var_item_id, rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{}))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_function('do_action', [rt.new_string('woocommerce_ajax_add_order_item_meta'), var_item_id.clone(), var_item.clone(), var_order.clone()])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_method(var_order, 'add_order_note', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Added line items: %s'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(', '), var_order_notes.clone()])]), rt.new_bool(false), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() }])])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_ajax_order_items_added'), var_added_items.clone(), var_order.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_data := rt.call_function('get_post_meta', [var_order_id_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	var_order = rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_items_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_notes := rt.call_function('wc_get_order_notes', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id_mutated }])])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-notes.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_notes_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	return rt.create_array([rt.ArrayItem{ key: 'html', val: var_items_html }, rt.ArrayItem{ key: 'notes_html', val: var_notes_html }])
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		rt.throw_exception(var_e)
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.new_null()
}

fn Class_WC_AJAX.add_order_fee() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_amount := if rt.get_superglobal('_POST').array_isset(rt.new_string('amount')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('amount'))])]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_calculate_tax_args := rt.create_array([rt.ArrayItem{ key: 'country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('country')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('country'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('state')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('state'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('postcode')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('postcode'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('city')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('city'))])])]) } else { rt.new_string('') } }])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	if rt.is_true(rt.call_function('strstr', [var_amount.clone(), rt.new_string('%')])) {
		rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		mut var_formatted_amount := var_amount.clone()
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		mut var_percent := rt.new_float(rt.new_string(var_amount.clone().to_string().trim_space()).to_f64())
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		var_amount = rt.mul(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.div(var_percent, rt.new_int(100)))
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	} else {
		var_amount = rt.new_float(var_amount.clone().to_f64())
		if rt.has_exception() { unsafe { goto catch_label_5 } }
		var_formatted_amount = rt.call_function('wc_price', [var_amount.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order, 'get_currency', []rt.PhpVal{}) }])])
		if rt.has_exception() { unsafe { goto catch_label_5 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_fee := create_wc_order_item_fee()
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_fee.set_amount(var_amount.clone())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_fee.set_total(var_amount.clone())
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_fee.set_name(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s fee'), rt.new_string('woocommerce')]), rt.call_function('wc_clean', [var_formatted_amount.clone()])]))
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_method(var_order, 'add_item', [var_fee])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_method(var_order, 'calculate_taxes', [var_calculate_tax_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_method(var_order, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_e := var_e_5.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.add_order_shipping() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_6 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_order_taxes := rt.call_method(var_order, 'get_taxes', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_shipping_methods := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})) { rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'load_shipping_methods', []rt.PhpVal{}) } else { rt.new_array() }
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_cogs_is_enabled := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_item := create_wc_order_item_shipping()
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.call_method(var_item, 'set_shipping_rate', [create_wc_shipping_rate()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.call_method(var_item, 'set_order_id', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_item_id := rt.call_method(var_item, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-shipping.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Exception') {
		mut var_e := var_e_6.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.add_order_tax() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_7 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_rate_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('rate_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('rate_id'))]) } else { rt.new_string('') }
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rate_id)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid rate'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_7 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_data := rt.call_function('get_post_meta', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_item := create_wc_order_item_tax()
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	rt.call_method(var_item, 'set_rate', [var_rate_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	rt.call_method(var_item, 'set_order_id', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	unsafe { goto end_label_7 }

catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Exception') {
		mut var_e := var_e_7.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_7 }
	}
	else {
		rt.throw_exception(var_e_7)
		unsafe { goto end_label_7 }
	}

end_label_7:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.add_coupon_discount() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Orders_CouponsController.class()]), 'add_coupon_discount_via_ajax', []rt.PhpVal{})
}

fn Class_WC_AJAX.remove_order_coupon() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut var_calculate_tax_args := rt.create_array([rt.ArrayItem{ key: 'country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('country')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('country'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('state')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('state'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('postcode')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('postcode'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('city')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('city'))])])]) } else { rt.new_string('') } }])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_8 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut iife_temp_19 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_19 := iife_temp_19.get_value_or_default(rt.get_superglobal('_POST').clone(), rt.new_string('coupon'))
	mut var_coupon := iife_result_19
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut iife_temp_20 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_20 := iife_temp_20.is_null_or_whitespace(var_coupon.clone())
	if rt.is_true(iife_result_20) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid coupon'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_8 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut var_code := rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [var_coupon.clone()])])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	if rt.is_true(rt.call_method(var_order, 'remove_coupon', [var_code.clone()])) {
		rt.call_method(var_order, 'add_order_note', [rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Coupon removed: "%s".'), rt.new_string('woocommerce')]), var_code.clone()])]), rt.new_int(0), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() }])])
		if rt.has_exception() { unsafe { goto catch_label_8 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.call_method(var_order, 'calculate_taxes', [var_calculate_tax_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	mut var_notes := rt.call_function('wc_get_order_notes', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-notes.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	var_response['notes_html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_8 } }
	unsafe { goto end_label_8 }

catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'Exception') {
		mut var_e := var_e_8.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_8 }
	}
	else {
		rt.throw_exception(var_e_8)
		unsafe { goto end_label_8 }
	}

end_label_8:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.remove_order_item() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('order_item_ids')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_9 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_item_ids'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid items'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_9 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_order_item_ids := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('order_item_ids'))])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_items := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('items')))) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('items'))]) } else { rt.new_string('') }
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_calculate_tax_args := rt.create_array([rt.ArrayItem{ key: 'country', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('country')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('country'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'state', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('state')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('state'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'postcode', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('postcode')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('postcode'))])])]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'city', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('city')) { rt.call_function('wc_strtoupper', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('city'))])])]) } else { rt.new_string('') } }])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	if rt.is_true(rt.new_bool(var_order_item_ids.clone().is_long() || var_order_item_ids.clone().is_double())) {
		var_order_item_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_order_item_ids }])
		if rt.has_exception() { unsafe { goto catch_label_9 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	if !(!rt.is_true(var_items)) {
		mut var_save_items := rt.new_array()
		if rt.has_exception() { unsafe { goto catch_label_9 } }
		rt.call_function('parse_str', [var_items.clone(), var_save_items.clone()])
		if rt.has_exception() { unsafe { goto catch_label_9 } }
		rt.call_function('wc_save_order_items', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_save_items.clone()])
		if rt.has_exception() { unsafe { goto catch_label_9 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	if !(!rt.is_true(var_order_item_ids)) {
		mut iter_9 := var_order_item_ids.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_item_id := item_9.val
			var_item_id = rt.call_function('absint', [var_item_id.clone()])
			if rt.has_exception() { unsafe { goto catch_label_9 } }
			mut var_item := rt.call_method(var_order, 'get_item', [var_item_id.clone()])
			if rt.has_exception() { unsafe { goto catch_label_9 } }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_9 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_9 } }
			if rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')])) {
				mut var_changed_stock := rt.call_function('wc_maybe_adjust_line_item_product_stock', [var_item.clone(), rt.new_int(0)])
				if rt.has_exception() { unsafe { goto catch_label_9 } }
				if rt.is_true(var_changed_stock) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.clone()]))))) {
					rt.call_method(var_order, 'add_order_note', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Deleted %1$s and adjusted stock (%2$s)'), rt.new_string('woocommerce')]), rt.call_method(var_item, 'get_name', []rt.PhpVal{}), rt.new_string((var_changed_stock.array_get(rt.new_string('from'))).str() + '&rarr;' + (var_changed_stock.array_get(rt.new_string('to'))).str())]), rt.new_bool(false), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock() }])])
					if rt.has_exception() { unsafe { goto catch_label_9 } }
				} else {
					rt.call_method(var_order, 'add_order_note', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Deleted %s'), rt.new_string('woocommerce')]), rt.call_method(var_item, 'get_name', []rt.PhpVal{})]), rt.new_bool(false), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() }])])
					if rt.has_exception() { unsafe { goto catch_label_9 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_9 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_9 } }
			rt.call_function('wc_delete_order_item', [var_item_id.clone()])
			if rt.has_exception() { unsafe { goto catch_label_9 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_9 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_method(var_order, 'calculate_taxes', [var_calculate_tax_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_ajax_order_items_removed'), if !(var_item_id).is_null() { var_item_id } else { rt.new_int(0) }, if !(var_item).is_null() { var_item } else { rt.new_bool(false) }, if !(var_changed_stock).is_null() { var_changed_stock } else { rt.new_bool(false) }, var_order.clone()])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_items_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_notes := rt.call_function('wc_get_order_notes', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-notes.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	mut var_notes_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'html', val: var_items_html }, rt.ArrayItem{ key: 'notes_html', val: var_notes_html }])])
	if rt.has_exception() { unsafe { goto catch_label_9 } }
	unsafe { goto end_label_9 }

catch_label_9:
	mut var_e_9 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_9, 'Exception') {
		mut var_e := var_e_9.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_9 }
	}
	else {
		rt.throw_exception(var_e_9)
		unsafe { goto end_label_9 }
	}

end_label_9:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.remove_order_tax() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('rate_id')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	mut var_order_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	mut var_rate_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('rate_id'))])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'is_editable', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Order not editable'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_10 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	rt.call_function('wc_delete_order_item', [var_rate_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	var_response['html'] = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_10 } }
	unsafe { goto end_label_10 }

catch_label_10:
	mut var_e_10 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_10, 'Exception') {
		mut var_e := var_e_10.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_10 }
	}
	else {
		rt.throw_exception(var_e_10)
		unsafe { goto end_label_10 }
	}

end_label_10:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.calc_line_taxes() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Orders_TaxesController.class()]), 'calc_line_taxes_via_ajax', []rt.PhpVal{})
}

fn Class_WC_AJAX.save_order_items() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('items')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('items')) {
		mut var_order_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))])
		mut var_items := rt.new_array()
		rt.call_function('parse_str', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('items'))]), var_items.clone()])
		rt.call_function('wc_save_order_items', [var_order_id.clone(), var_items.clone()])
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
		mut var_items_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_notes := rt.call_function('wc_get_order_notes', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }])])
		rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-notes.php', '1')
		mut var_notes_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'html', val: var_items_html }, rt.ArrayItem{ key: 'notes_html', val: var_notes_html }])])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.load_order_items() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_order_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))])
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-order-items.php', '1')
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.add_order_note() {
	rt.call_function('check_ajax_referer', [rt.new_string('add-order-note'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || (!(rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('note')) && rt.get_superglobal('_POST').array_isset(rt.new_string('note_type')))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_post_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))])
	mut var_note := rt.call_function('wp_kses_post', [rt.new_string(rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('note'))]).to_string().trim_space())])
	mut var_note_type := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('note_type'))])])
	mut var_is_customer_note := rt.new_int(if rt.is_true(rt.identical(rt.new_string('customer'), var_note_type)) { 1 } else { 0 })
	if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) {
		mut var_order := rt.call_function('wc_get_order', [var_post_id.clone()])
		mut var_comment_id := rt.call_method(var_order, 'add_order_note', [var_note.clone(), var_is_customer_note.clone(), rt.new_bool(true)])
		var_note = rt.call_function('wc_get_order_note', [var_comment_id.clone()])
		mut var_note_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'note' }])
		var_note_classes.array_push(if rt.is_true(var_is_customer_note) { 'customer-note' } else { '' })
		var_note_classes = rt.call_function('apply_filters', [rt.new_string('woocommerce_order_note_class'), rt.call_function('array_filter', [var_note_classes.clone()]), var_note.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [rt.get_property(var_note, 'id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_note_classes.clone()])]))
		// unsupported statement: Stmt_InlineHTML
		mut var_content := rt.call_function('wc_wptexturize_order_note', [rt.get_property(var_note, 'content')])
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('make_clickable', [var_content.clone()])])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_method(rt.get_property(var_note, 'date_created'), 'date', [rt.new_string('y-m-d h:i:s')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('added on %1$s at %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(rt.get_property(var_note, 'date_created'), 'date_i18n', [rt.call_function('wc_date_format', []rt.PhpVal{})])]), rt.call_function('esc_html', [rt.call_method(rt.get_property(var_note, 'date_created'), 'date_i18n', [rt.call_function('wc_time_format', []rt.PhpVal{})])])])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('system'), rt.get_property(var_note, 'added_by'))))) {
			rt.call_function('printf', [rt.new_string(' ' + (rt.call_function('esc_html__', [rt.new_string('by %s'), rt.new_string('woocommerce')])).str()), rt.call_function('esc_html', [rt.get_property(var_note, 'added_by')])])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Delete note'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.delete_order_note() {
	rt.call_function('check_ajax_referer', [rt.new_string('delete-order-note'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || !(rt.get_superglobal('_POST').array_isset(rt.new_string('note_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_note_id := rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('note_id'))).to_i64())
	if rt.is_true(rt.greater(var_note_id, rt.new_int(0))) {
		rt.call_function('wc_delete_order_note', [var_note_id.clone()])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.json_search_products(term string, include_variations bool) {
	mut term_mutated := term
	rt.call_function('check_ajax_referer', [rt.new_string('search-products'), rt.new_string('security')])
	if term_mutated == '' && rt.get_superglobal('_GET').array_isset(rt.new_string('term')) {
	term_mutated = (rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])])).str()
	}
	if term_mutated == '' {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('limit')))) {
	mut var_limit := rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('limit'))])
	} else {
	var_limit = rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_limit'), rt.new_int(30)])])
	}
	mut var_include_ids := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('include')))) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('include'))]))]) } else { rt.new_array() }
	mut var_exclude_ids := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('exclude')))) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('exclude'))]))]) } else { rt.new_array() }
	mut var_exclude_types := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('exclude_type')))) {
		var_exclude_types = rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('exclude_type'))])
		if !(var_exclude_types.clone().is_array()) {
		var_exclude_types = rt.call_function('explode', [rt.new_string(','), var_exclude_types.clone()])
		}
		mut iter_10 := var_exclude_types.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_exclude_type := item_10.val
		var_exclude_type = rt.new_string(var_exclude_type.clone().to_string().trim_space().to_lower())
		}
	var_exclude_types = rt.call_function('array_intersect', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variation() }]), rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{}))]), var_exclude_types.clone()])
	}
	mut iife_temp_21 := Class_WC_Data_Store{}
	mut iife_result_21 := iife_temp_21.load(rt.new_string('product'))
	mut var_data_store := iife_result_21
	mut var_ids := rt.call_method(var_data_store, 'search_products', [rt.new_string(term_mutated).clone(), rt.new_string(''), rt.new_bool(include_variations), rt.new_bool(false), var_limit.clone(), var_include_ids.clone(), var_exclude_ids.clone()])
	mut var_products := rt.new_array()
	mut iter_11 := var_ids.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_id := item_11.val
		mut var_product_object := rt.call_function('wc_get_product', [var_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_products_array_filter_readable', [var_product_object.clone()]))))) {
			continue
		}
		mut var_formatted_name := rt.call_method(var_product_object, 'get_formatted_name', []rt.PhpVal{})
		mut var_managing_stock := rt.call_method(var_product_object, 'managing_stock', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [rt.call_method(var_product_object, 'get_type', []rt.PhpVal{}), var_exclude_types.clone(), rt.new_bool(true)])) {
			continue
		}
		if rt.is_true(var_managing_stock) && !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('display_stock')))) {
			mut var_stock_amount := rt.call_method(var_product_object, 'get_stock_quantity', []rt.PhpVal{})
			var_formatted_name = rt.concat(var_formatted_name, rt.new_string(' &ndash; ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Stock: %d'), rt.new_string('woocommerce')]), rt.call_function('wc_format_stock_quantity_for_display', [var_stock_amount.clone(), var_product_object.clone()])])).str()))
		}
		var_products.array_set(rt.call_method(var_product_object, 'get_id', []rt.PhpVal{}), rt.call_function('rawurldecode', [rt.call_function('wp_strip_all_tags', [var_formatted_name.clone()])]))
	}
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_products'), var_products.clone()])])
}

fn Class_WC_AJAX.json_search_products_and_variations() {
	Class_WC_AJAX.json_search_products('', true)
}

fn Class_WC_AJAX.json_search_downloadable_products_and_variations() {
	rt.call_function('check_ajax_referer', [rt.new_string('search-products'), rt.new_string('security')])
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('limit')))) {
	mut var_limit := rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('limit'))])
	} else {
	var_limit = rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_limit'), rt.new_int(30)])])
	}
	mut var_include_ids := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('include')))) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('include'))]))]) } else { rt.new_array() }
	mut var_exclude_ids := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('exclude')))) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('exclude'))]))]) } else { rt.new_array() }
	mut var_term := rt.new_string((if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { (rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])])).str() } else { '' }).str())
	mut iife_temp_22 := Class_WC_Data_Store{}
	mut iife_result_22 := iife_temp_22.load(rt.new_string('product'))
	mut var_data_store := iife_result_22
	mut var_ids := rt.call_method(var_data_store, 'search_products', [var_term.clone(), rt.new_string('downloadable'), rt.new_bool(true), rt.new_bool(false), var_limit.clone()])
	rt.call_function('_prime_post_caches', [var_ids.clone()])
	mut var_product_objects := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_ids.clone()]), rt.new_string('wc_products_array_filter_readable')])
	mut var_products := rt.new_array()
	mut iter_12 := var_product_objects.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_product_object := item_12.val
		var_products.array_set(rt.call_method(var_product_object, 'get_id', []rt.PhpVal{}), rt.call_function('rawurldecode', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product_object, 'get_formatted_name', []rt.PhpVal{})])]))
	}
	rt.call_function('wp_send_json', [var_products.clone()])
}

fn Class_WC_AJAX.json_search_customers() {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_legacy_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	rt.call_method(var_legacy_proxy, 'call_function', [rt.new_string('check_ajax_referer'), rt.new_string('search-customers'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_term := rt.new_string((if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { (rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])])).str() } else { '' }).str())
	mut var_limit := rt.new_int(0)
	if !rt.is_true(var_term) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_ids := rt.new_array()
	if rt.is_true(rt.new_bool(var_term.clone().is_long() || var_term.clone().is_double())) {
		mut var_customer := create_wc_customer(rt.new_int(var_term.clone().to_i64()))
		mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_23 := iife_temp_23.get_user_in_current_site(var_customer.get_id())
		mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_24 := iife_temp_24.get_user_in_current_site(var_customer.get_id())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_customer.get_id())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [iife_result_23]))))) {
		var_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_customer.get_id() }])
		}
	}
	if !rt.is_true(var_ids) {
		mut iife_temp_25 := Class_WC_Data_Store{}
		mut iife_result_25 := iife_temp_25.load(rt.new_string('customer'))
		mut var_data_store := iife_result_25
		if 3 > var_term.clone().to_string().len {
		var_limit = rt.new_int(20)
		}
	var_ids = rt.call_method(var_data_store, 'search_customers', [var_term.clone(), var_limit.clone()])
	}
	mut var_found_customers := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('exclude')))) {
	var_ids = rt.call_function('array_diff', [var_ids.clone(), rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('exclude'))]))])])
	}
	mut iter_13 := var_ids.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_id := item_13.val
		var_customer = create_wc_customer(var_id.clone())
		var_found_customers.array_set(var_id, rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s &ndash; %3$s)'), rt.new_string('woocommerce')]), rt.new_string((var_customer.get_first_name()).str() + ' ' + (var_customer.get_last_name()).str()), var_customer.get_id(), var_customer.get_email()]))
	}
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_customers'), var_found_customers.clone()])])
}

fn Class_WC_AJAX.json_search_categories() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('search-categories'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_search_text := if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_search_text)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_show_empty := if rt.get_superglobal('_GET').array_isset(rt.new_string('show_empty')) { rt.call_function('wp_validate_boolean', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('show_empty'))])])]) } else { rt.new_bool(false) }
	mut var_found_categories := rt.new_array()
	mut var_args := { 'taxonomy': map[string]rt.PhpVal{}, 'orderby': rt.new_string('id'), 'order': rt.new_string('ASC'), 'hide_empty': rt.new_bool(!(rt.is_true(var_show_empty))), 'fields': rt.new_string('all'), 'name__like': var_search_text }
	mut var_terms := rt.call_function('get_terms', [rt.create_array_from_native_map(var_args)])
	if rt.is_true(var_terms) {
		mut iter_14 := var_terms.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_term := item_14.val
			rt.set_property(var_term, 'formatted_name', rt.new_string(''))
			mut var_ancestors := rt.new_array()
			if rt.is_true(rt.get_property(var_term, 'parent')) {
				var_ancestors = rt.call_function('array_reverse', [rt.call_function('get_ancestors', [rt.get_property(var_term, 'term_id'), rt.new_string('product_cat')])])
				mut iter_15 := var_ancestors.iterator()
				for {
					item_15 := iter_15.next() or { break }
					mut var_ancestor := item_15.val
					mut var_ancestor_term := rt.call_function('get_term', [var_ancestor.clone(), rt.new_string('product_cat')])
					if rt.is_true(var_ancestor_term) {
						rt.get_property(var_term, 'formatted_name') = rt.concat(rt.get_property(var_term, 'formatted_name'), rt.new_string((rt.get_property(var_ancestor_term, 'name')).str() + ' > '))
					}
				}
			}
			rt.set_property(var_term, 'parents', var_ancestors.clone())
			rt.get_property(var_term, 'formatted_name') = rt.concat(rt.get_property(var_term, 'formatted_name'), rt.new_string((rt.get_property(var_term, 'name')).str() + ' (' + (rt.get_property(var_term, 'count')).str() + ')'))
			var_found_categories.array_set(rt.get_property(var_term, 'term_id'), var_term.clone())
		}
	}
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_categories'), var_found_categories.clone()])])
}

fn Class_WC_AJAX.json_search_categories_tree() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('search-categories'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_search_text := if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])]) } else { rt.new_string('') }
	mut var_number := if rt.get_superglobal('_GET').array_isset(rt.new_string('number')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('number'))]) } else { rt.new_int(50) }
	mut var_args := { 'taxonomy': map[string]rt.PhpVal{}, 'orderby': rt.new_string('name'), 'order': rt.new_string('ASC'), 'hide_empty': rt.new_bool(false), 'fields': rt.new_string('all'), 'number': var_number, 'name__like': var_search_text }
	mut var_terms := rt.call_function('get_terms', [rt.create_array_from_native_map(var_args)])
	mut var_terms_map := rt.new_array()
	if rt.is_true(var_terms) {
		mut iter_16 := var_terms.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_term := item_16.val
			var_terms_map.array_set(rt.get_property(var_term, 'term_id'), var_term.clone())
			if rt.is_true(rt.get_property(var_term, 'parent')) {
				mut var_ancestors := rt.call_function('get_ancestors', [rt.get_property(var_term, 'term_id'), rt.new_string('product_cat')])
				mut var_current_child := var_term.clone()
				mut iter_17 := var_ancestors.iterator()
				for {
					item_17 := iter_17.next() or { break }
					mut var_ancestor := item_17.val
					if !(var_terms_map.array_isset(var_ancestor)) {
						mut var_ancestor_term := rt.call_function('get_term', [var_ancestor.clone(), rt.new_string('product_cat')])
						var_terms_map.array_set(var_ancestor, var_ancestor_term.clone())
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_terms_map.array_get(var_ancestor), 'children'))))) {
						rt.set_property(var_terms_map.array_get(var_ancestor), 'children', rt.new_array())
					}
					closure_27_fn := fn [var_current_child] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						return
						}
					closure_28_fn := fn [var_current_child] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						return
						}
					mut var_item_exists := rt.new_bool(rt.call_function('array_filter', [rt.get_property(var_terms_map.array_get(var_ancestor), 'children'), rt.new_closure(closure_27_fn)]).array_count() == 1)
					if rt.is_true(rt.new_bool(!(rt.is_true(var_item_exists)))) {
						rt.get_property(var_terms_map.array_get(var_ancestor), 'children').array_push(var_current_child.clone())
					}
				var_current_child = var_terms_map.array_get(var_ancestor)
				}
			}
		}
	}
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
		}
	mut var_parent_terms := rt.call_function('array_filter', [rt.call_function('array_values', [var_terms_map.clone()]), rt.new_closure(closure_29_fn)])
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_categories'), var_parent_terms.clone()])])
}

fn Class_WC_AJAX.json_search_taxonomy_terms() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('search-taxonomy-terms'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_search_text := if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])]) } else { rt.new_string('') }
	mut var_limit := if rt.get_superglobal('_GET').array_isset(rt.new_string('limit')) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('limit'))])]) } else { rt.new_null() }
	mut var_taxonomy := if rt.get_superglobal('_GET').array_isset(rt.new_string('taxonomy')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('taxonomy'))])]) } else { rt.new_string('') }
	mut var_orderby := if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))])]) } else { rt.new_string('name') }
	mut var_order := if rt.get_superglobal('_GET').array_isset(rt.new_string('order')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('order'))])]) } else { rt.new_string('ASC') }
	mut var_args := { 'taxonomy': var_taxonomy, 'orderby': var_orderby, 'order': var_order, 'hide_empty': rt.new_bool(false), 'fields': rt.new_string('all'), 'number': var_limit, 'name__like': var_search_text, 'suppress_filter': rt.new_bool(true) }
	mut var_terms := rt.call_function('get_terms', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_attribute_terms'), rt.create_array_from_native_map(var_args)])])
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_product_attribute_terms'), var_terms.clone(), var_taxonomy.clone()])])
}

fn Class_WC_AJAX.json_search_product_attributes() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('search-product-attributes'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_limit := if rt.get_superglobal('_GET').array_isset(rt.new_string('limit')) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('limit'))])]) } else { rt.new_int(100) }
	mut var_search_text := if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])]) } else { rt.new_string('') }
	mut var_attributes := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	mut var_found_product_categories := rt.new_array()
	mut iter_18 := var_attributes.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_attribute_obj := item_18.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_search_text)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.get_property(var_attribute_obj, 'attribute_label'), var_search_text.clone()]))))) {
			var_found_product_categories << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_int((rt.get_property(var_attribute_obj, 'attribute_id')).to_i64()) }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_attribute_obj, 'attribute_label') }, rt.ArrayItem{ key: 'slug', val: rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_attribute_obj, 'attribute_name')]) }, rt.ArrayItem{ key: 'type', val: rt.get_property(var_attribute_obj, 'attribute_type') }, rt.ArrayItem{ key: 'order_by', val: rt.get_property(var_attribute_obj, 'attribute_orderby') }, rt.ArrayItem{ key: 'has_archives', val: (rt.get_property(var_attribute_obj, 'attribute_public')).to_bool() }])
		}
		if rt.is_true(rt.greater_equal(rt.new_int(var_found_product_categories.len), var_limit)) {
			break
		}
	}
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_product_categories'), rt.create_array_from_list(var_found_product_categories), var_search_text.clone()])])
}

fn Class_WC_AJAX.json_search_pages() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('search-pages'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_search_text := if rt.get_superglobal('_GET').array_isset(rt.new_string('term')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('term'))])]) } else { rt.new_string('') }
	mut var_limit := if rt.get_superglobal('_GET').array_isset(rt.new_string('limit')) { rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('limit'))])]) } else { -1 }
	mut var_exclude_ids := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('exclude')))) { rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('exclude'))]))]) } else { rt.new_array() }
	mut var_args := { 'no_found_rows': rt.new_bool(true), 'update_post_meta_cache': rt.new_bool(false), 'update_post_term_cache': rt.new_bool(false), 'posts_per_page': var_limit, 'post_type': rt.new_string('page'), 'post_status': map[string]rt.PhpVal{}, 's': var_search_text, 'post__not_in': var_exclude_ids }
	mut var_search_results_query := create_wp_query(var_args.clone())
	mut var_pages_results := rt.new_array()
	mut iter_19 := var_search_results_query.get_posts().iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_post := item_19.val
		var_pages_results.array_set(rt.get_property(var_post, 'ID'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (ID: %2$s)'), rt.new_string('woocommerce')]), rt.call_function('get_the_title', [var_post.clone()]), rt.get_property(var_post, 'ID')]))
	}
	rt.call_function('wp_send_json', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_pages'), var_pages_results.clone()])])
}

fn Class_WC_AJAX.term_ordering() {
	rt.call_function('check_ajax_referer', [rt.new_string('term-ordering'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_id := rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	mut var_next_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('nextid')) && rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('nextid'))).to_i64())) { rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('nextid'))).to_i64()) } else { rt.new_null() }
	mut var_taxonomy := if rt.get_superglobal('_POST').array_isset(rt.new_string('thetaxonomy')) { rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('thetaxonomy'))])]) } else { rt.new_null() }
	mut var_term := rt.call_function('get_term_by', [rt.new_string('id'), var_id.clone(), var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	rt.call_function('wc_reorder_terms', [var_term.clone(), var_next_id.clone(), var_taxonomy.clone()])
	mut var_children := rt.call_function('get_terms', [var_taxonomy.clone(), rt.new_string("child_of=${var_id.to_string()}&menu_order=ASC&hide_empty=0")])
	mut var_children_count := rt.new_int(if rt.call_function('is_countable', [var_children.clone()]) { var_children.clone().array_count() } else { 0 })
	if rt.is_true(var_term) && rt.is_true(var_children_count) {
		print('children')
		rt.call_function('wp_die', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.product_ordering() {
	mut var_wpdb := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('product-ordering'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_sorting_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('id'))])
	mut var_previd := rt.call_function('absint', [if rt.get_superglobal('_POST').array_isset(rt.new_string('previd')) { rt.get_superglobal('_POST').array_get(rt.new_string('previd')) } else { rt.new_int(0) }])
	mut var_nextid := rt.call_function('absint', [if rt.get_superglobal('_POST').array_isset(rt.new_string('nextid')) { rt.get_superglobal('_POST').array_get(rt.new_string('nextid')) } else { rt.new_int(0) }])
	mut var_menu_orders := rt.call_function('wp_list_pluck', [rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT ID, menu_order FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'product\' ORDER BY menu_order ASC, post_title ASC'))]), rt.new_string('menu_order'), rt.new_string('ID')])
	mut var_index := rt.new_int(0)
	mut iter_20 := var_menu_orders.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_menu_order := item_20.val
		mut var_id := item_20.key
		var_id = rt.call_function('absint', [var_id.clone()])
		if rt.is_true(rt.identical(var_sorting_id, var_id)) {
			continue
		}
		if rt.is_true(rt.identical(var_nextid, var_id)) {
			rt.pre_inc(var_index)
		}
		rt.pre_inc(var_index)
		var_menu_orders.array_set(var_id, var_index.clone())
		if rt.is_true(rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'menu_order', val: var_index }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id }])])) {
			rt.call_function('clean_post_cache', [var_id.clone()])
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_after_single_product_ordering'), var_id.clone(), var_index.clone()])
	}
	if var_menu_orders.array_isset(var_previd) {
		var_menu_orders.array_set(var_sorting_id, rt.add(var_menu_orders.array_get(var_previd), rt.new_int(1)))
	} else if var_menu_orders.array_isset(var_nextid) {
		var_menu_orders.array_set(var_sorting_id, rt.sub(var_menu_orders.array_get(var_nextid), rt.new_int(1)))
	} else {
		var_menu_orders.array_set(var_sorting_id, 0)
	}
	if rt.is_true(rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'menu_order', val: var_menu_orders.array_get(var_sorting_id) }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_sorting_id }])])) {
		rt.call_function('clean_post_cache', [var_sorting_id.clone()])
	}
	mut iife_temp_29 := Class_WC_Post_Data{}
	mut iife_result_29 := iife_temp_29.delete_product_query_transients()
	rt.call_function('do_action', [rt.new_string('woocommerce_after_product_ordering'), var_sorting_id.clone(), var_menu_orders.clone()])
	rt.call_function('wp_send_json', [var_menu_orders.clone()])
}

fn Class_WC_AJAX.refund_line_items() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('order_id'))]) } else { rt.new_int(0) }
	mut var_refund_amount := if rt.get_superglobal('_POST').array_isset(rt.new_string('refund_amount')) { rt.call_function('wc_format_decimal', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('refund_amount'))])]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) } else { rt.new_int(0) }
	mut var_refunded_amount := if rt.get_superglobal('_POST').array_isset(rt.new_string('refunded_amount')) { rt.call_function('wc_format_decimal', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('refunded_amount'))])]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]) } else { rt.new_int(0) }
	mut var_refund_reason := if rt.get_superglobal('_POST').array_isset(rt.new_string('refund_reason')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('refund_reason'))])]) } else { rt.new_string('') }
	mut var_line_item_qtys := if rt.get_superglobal('_POST').array_isset(rt.new_string('line_item_qtys')) { rt.call_function('json_decode', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('line_item_qtys'))])]), rt.new_bool(true)]) } else { rt.new_array() }
	mut var_line_item_totals := if rt.get_superglobal('_POST').array_isset(rt.new_string('line_item_totals')) { rt.call_function('json_decode', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('line_item_totals'))])]), rt.new_bool(true)]) } else { rt.new_array() }
	mut var_line_item_tax_totals := if rt.get_superglobal('_POST').array_isset(rt.new_string('line_item_tax_totals')) { rt.call_function('json_decode', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('line_item_tax_totals'))])]), rt.new_bool(true)]) } else { rt.new_array() }
	mut var_api_refund := rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('api_refund')) && rt.is_true(rt.identical(rt.new_string('true'), rt.get_superglobal('_POST').array_get(rt.new_string('api_refund')))))
	mut var_restock_refunded_items := rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('restock_refunded_items')) && rt.is_true(rt.identical(rt.new_string('true'), rt.get_superglobal('_POST').array_get(rt.new_string('restock_refunded_items')))))
	mut var_refund := rt.new_bool(false)
	mut var_response := rt.new_array()
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut var_max_refund := rt.call_function('wc_format_decimal', [rt.sub(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{})), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	if ((rt.is_true(rt.new_bool(!(rt.is_true(var_refund_amount)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_format_decimal', [rt.new_int(0), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), var_refund_amount))))) || rt.is_true(rt.less(var_max_refund, var_refund_amount))) || rt.is_true(rt.greater(rt.new_int(0), var_refund_amount)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid refund amount'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wc_format_decimal', [rt.call_method(var_order, 'get_total_refunded', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]), var_refunded_amount)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Error processing refund. Please try again.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut var_line_items := rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut var_item_ids := rt.call_function('array_unique', [rt.call_function('array_merge', [rt.func_array_keys(var_line_item_qtys.clone()), rt.func_array_keys(var_line_item_totals.clone())])])
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut iter_21 := var_item_ids.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_item_id := item_21.val
		var_line_items.array_set(var_item_id, rt.create_array([rt.ArrayItem{ key: 'qty', val: 0 }, rt.ArrayItem{ key: 'refund_total', val: 0 }, rt.ArrayItem{ key: 'refund_tax', val: rt.new_array() }]))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut iter_22 := var_line_item_qtys.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_qty := item_22.val
		mut var_item_id := item_22.key
		var_line_items.array_get_mut(var_item_id).array_set('qty', rt.call_function('max', [var_qty.clone(), rt.new_int(0)]))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut iter_23 := var_line_item_totals.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_total := item_23.val
		mut var_item_id := item_23.key
		var_line_items.array_get_mut(var_item_id).array_set('refund_total', rt.call_function('wc_format_decimal', [var_total.clone()]))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	mut iter_24 := var_line_item_tax_totals.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_tax_totals := item_24.val
		mut var_item_id := item_24.key
		var_line_items.array_get_mut(var_item_id).array_set('refund_tax', rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_tax_totals.clone()])]))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	var_refund = rt.call_function('wc_create_refund', [rt.create_array([rt.ArrayItem{ key: 'amount', val: var_refund_amount }, rt.ArrayItem{ key: 'reason', val: var_refund_reason }, rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'line_items', val: var_line_items }, rt.ArrayItem{ key: 'refund_payment', val: var_api_refund }, rt.ArrayItem{ key: 'restock_items', val: var_restock_refunded_items }])])
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_refund, 'get_error_message', []rt.PhpVal{}))))
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	if rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_order_fully_refunded')])) {
		var_response['status'] = rt.new_string('fully_refunded')
		if rt.has_exception() { unsafe { goto catch_label_11 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_11 } }
	unsafe { goto end_label_11 }

catch_label_11:
	mut var_e_11 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_11, 'Exception') {
		mut var_e := var_e_11.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_11 }
	}
	else {
		rt.throw_exception(var_e_11)
		unsafe { goto end_label_11 }
	}

end_label_11:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.delete_refund() {
	rt.call_function('check_ajax_referer', [rt.new_string('order-item'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_shop_orders')]))))) || !(rt.get_superglobal('_POST').array_isset(rt.new_string('refund_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_refund_ids := rt.call_function('array_map', [rt.new_string('absint'), if rt.get_superglobal('_POST').array_get(rt.new_string('refund_id')).is_array() { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('refund_id'))]) } else { rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('refund_id'))]) }]) }])
	mut iter_25 := var_refund_ids.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_refund_id := item_25.val
		mut iife_temp_30 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_30 := iife_temp_30.get_order_type(var_refund_id.clone())
		if rt.is_true(var_refund_id) && rt.is_true(rt.identical(rt.new_string('shop_order_refund'), iife_result_30)) {
			mut var_refund := rt.call_function('wc_get_order', [var_refund_id.clone()])
			mut var_order_id := rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})
			rt.call_method(var_refund, 'delete', [rt.new_bool(true)])
			rt.call_function('do_action', [rt.new_string('woocommerce_refund_deleted'), var_refund_id.clone(), var_order_id.clone()])
		}
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.rated() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_admin_footer_text_rated'), rt.new_int(1)])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.update_api_key() {
	mut var_wpdb := rt.new_null()
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('update-api-key'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_response := rt.new_array()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('description'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Description is missing.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('user'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('User is missing.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('permissions'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Permissions is missing.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	mut var_key_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('key_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('key_id'))]) } else { rt.new_int(0) }
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	mut var_description := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('description'))])])
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	mut var_permissions := if rt.is_true(rt.call_function('in_array', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('permissions'))]), rt.create_array([rt.ArrayItem{ key: none, val: 'read' }, rt.ArrayItem{ key: none, val: 'write' }, rt.ArrayItem{ key: none, val: 'read_write' }]), rt.new_bool(true)])) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('permissions'))])]) } else { rt.new_string('read') }
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	mut var_user_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('user'))])
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	if rt.is_true(var_user_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), var_user_id.clone()]))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_user_id)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('You do not have permission to assign API Keys to the selected user.'), rt.new_string('woocommerce')]))))
			if rt.has_exception() { unsafe { goto catch_label_12 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	if rt.is_true(rt.less(rt.new_int(0), var_key_id)) {
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'permissions', val: var_permissions }])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		rt.call_method(var_wpdb, 'update', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'), var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'key_id', val: var_key_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response = var_data
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['consumer_key'] = rt.new_string('')
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['consumer_secret'] = rt.new_string('')
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['message'] = rt.call_function('__', [rt.new_string('API Key updated successfully.'), rt.new_string('woocommerce')])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	} else {
		mut var_consumer_key := rt.new_string('ck_' + (rt.call_function('wc_rand_hash', []rt.PhpVal{})).str())
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		mut var_consumer_secret := rt.new_string('cs_' + (rt.call_function('wc_rand_hash', []rt.PhpVal{})).str())
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_data = rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'permissions', val: var_permissions }, rt.ArrayItem{ key: 'consumer_key', val: rt.call_function('wc_api_hash', [var_consumer_key.clone()]) }, rt.ArrayItem{ key: 'consumer_secret', val: var_consumer_secret }, rt.ArrayItem{ key: 'truncated_key', val: rt.call_function('substr', [var_consumer_key.clone(), rt.new_int(-7)]) }])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'), var_data.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_wpdb, 'insert_id'))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('There was an error generating your API Key.'), rt.new_string('woocommerce')]))))
			if rt.has_exception() { unsafe { goto catch_label_12 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_key_id = rt.get_property(var_wpdb, 'insert_id')
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response = var_data
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['consumer_key'] = var_consumer_key.clone()
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['consumer_secret'] = var_consumer_secret.clone()
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['message'] = rt.call_function('__', [rt.new_string('API Key generated successfully. Make sure to copy your new keys now as the secret key will be hidden once you leave this page.'), rt.new_string('woocommerce')])
		if rt.has_exception() { unsafe { goto catch_label_12 } }
		var_response['revoke_url'] = '<a style="color: #a00; text-decoration: none;" href="' + (rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'revoke-key', val: var_key_id }]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=keys')])]), rt.new_string('revoke')])])).str() + '">' + (rt.call_function('__', [rt.new_string('Revoke key'), rt.new_string('woocommerce')])).str() + '</a>'
		if rt.has_exception() { unsafe { goto catch_label_12 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_12 } }
	unsafe { goto end_label_12 }

catch_label_12:
	mut var_e_12 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_12, 'Exception') {
		mut var_e := var_e_12.clone()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_12 }
	}
	else {
		rt.throw_exception(var_e_12)
		unsafe { goto end_label_12 }
	}

end_label_12:
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.load_variations() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('load-variations'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_post := rt.get_superglobal('post')
	mut var_loop := rt.new_int(0)
	mut var_product_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))])
	var_post = rt.call_function('get_post', [var_product_id.clone()])
	mut var_product_object := rt.call_function('wc_get_product', [var_product_id.clone()])
	mut var_per_page := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('per_page')))) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('per_page'))]) } else { rt.new_int(10) }
	mut var_page := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('page')))) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('page'))]) } else { rt.new_int(1) }
	mut var_variations := rt.call_function('wc_get_products', [rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'private' }, rt.ArrayItem{ key: none, val: 'publish' }]) }, rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Enums_ProductType.variation() }, rt.ArrayItem{ key: 'parent', val: var_product_id }, rt.ArrayItem{ key: 'limit', val: var_per_page }, rt.ArrayItem{ key: 'page', val: var_page }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'menu_order', val: 'ASC' }, rt.ArrayItem{ key: 'ID', val: 'DESC' }]) }, rt.ArrayItem{ key: 'return', val: 'objects' }])])
	if rt.is_true(var_variations) {
		rt.call_function('wc_render_invalid_variation_notice', [var_product_object.clone()])
		mut var_base_cost := Class_WC_AJAX.base_cost_or_null(mut rt.cast_object_ptr[Class_WC_Product](var_product_object))
		mut iter_26 := var_variations.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_variation_object := item_26.val
			Class_WC_AJAX.render_variation_html(mut rt.cast_object_ptr[Class_WC_Product](var_product_object), mut rt.cast_object_ptr[Class_WC_Product](var_variation_object), mut rt.cast_object_ptr[Class_?float](var_loop), var_base_cost.clone())
			rt.pre_inc(var_loop)
		}
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.save_variations() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('save-variations'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || !rt.is_true(rt.get_superglobal('_POST')) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_product_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))])
	rt.set_static_prop('WC_Admin_Meta_Boxes', 'meta_box_errors', rt.new_array())
	mut iife_temp_31 := Class_WC_Meta_Box_Product_Data{}
	mut iife_result_31 := iife_temp_31.save_variations(var_product_id.clone(), rt.call_function('get_post', [var_product_id.clone()]))
	rt.call_function('do_action', [rt.new_string('woocommerce_ajax_save_product_variations'), var_product_id.clone()])
	mut var_errors := rt.get_static_prop('WC_Admin_Meta_Boxes', 'meta_box_errors')
	if rt.is_true(var_errors) {
		print('<div class="error notice is-dismissible">')
		mut iter_27 := var_errors.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_error := item_27.val
			print('<p>' + (rt.call_function('wp_kses_post', [var_error.clone()])).str() + '</p>')
		}
		print('<button type="button" class="notice-dismiss"><span class="screen-reader-text">' + (rt.call_function('esc_html__', [rt.new_string('Dismiss this notice.'), rt.new_string('woocommerce')])).str() + '</span></button>')
		print('</div>')
		rt.call_function('delete_option', [Class_WC_Admin_Meta_Boxes.error_store()])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.variation_bulk_action_toggle_enabled(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	mut iter_28 := var_variations_mutated.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_variation_id := item_28.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		rt.call_method(var_variation, 'set_status', [if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.private(), rt.call_method(var_variation, 'get_status', [rt.new_string('edit')]))) { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() } else { Class_Automattic_WooCommerce_Enums_ProductStatus.private() }])
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_action_toggle_downloadable(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_toggle(var_variations_mutated.clone(), rt.new_string('downloadable'))
}

fn Class_WC_AJAX.variation_bulk_action_toggle_virtual(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_toggle(var_variations_mutated.clone(), rt.new_string('virtual'))
}

fn Class_WC_AJAX.variation_bulk_action_toggle_manage_stock(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_toggle(var_variations_mutated.clone(), rt.new_string('manage_stock'))
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('regular_price'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('sale_price'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_instock(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('stock_status'), Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock())
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_outofstock(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('stock_status'), Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_onbackorder(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('stock_status'), Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder())
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('value'))) {
		return
	}
	mut var_quantity := rt.call_function('wc_stock_amount', [rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))])])
	mut iter_29 := var_variations_mutated.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_variation_id := item_29.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		if rt.is_true(rt.call_method(var_variation, 'managing_stock', []rt.PhpVal{})) {
			rt.call_method(var_variation, 'set_stock_quantity', [var_quantity.clone()])
		} else {
			rt.call_method(var_variation, 'set_stock_quantity', [rt.new_null()])
		}
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_action_variable_low_stock_amount(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('value'))) {
		return
	}
	mut var_low_stock_amount := rt.call_function('wc_stock_amount', [rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))])])
	mut iter_30 := var_variations_mutated.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_variation_id := item_30.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		if rt.is_true(rt.call_method(var_variation, 'managing_stock', []rt.PhpVal{})) {
			rt.call_method(var_variation, 'set_low_stock_amount', [var_low_stock_amount.clone()])
		} else {
			rt.call_method(var_variation, 'set_low_stock_amount', [rt.new_string('')])
		}
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_action_variable_weight(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('weight'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_length(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('length'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_width(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('width'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_height(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('height'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_download_limit(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('download_limit'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_variable_download_expiry(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_set(var_variations_mutated.clone(), rt.new_string('download_expiry'), var_data_mutated.array_get(rt.new_string('value')))
}

fn Class_WC_AJAX.variation_bulk_action_delete_all(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('allowed')) && rt.is_true(rt.identical(rt.new_string('true'), var_data_mutated.array_get(rt.new_string('allowed')))) {
		mut iter_31 := var_variations_mutated.iterator()
		for {
			item_31 := iter_31.next() or { break }
			mut var_variation_id := item_31.val
			mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
			rt.call_method(var_variation, 'delete', [rt.new_bool(true)])
		}
	}
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_schedule(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('date_from'))) && !(var_data_mutated.array_isset(rt.new_string('date_to'))) {
		return
	}
	mut iter_32 := var_variations_mutated.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_variation_id := item_32.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('false'), var_data_mutated.array_get(rt.new_string('date_from')))))) {
			mut var_date_on_sale_from := rt.call_function('date', [rt.new_string('Y-m-d 00:00:00'), rt.call_function('strtotime', [rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('date_from'))])])])
			rt.call_method(var_variation, 'set_date_on_sale_from', [var_date_on_sale_from.clone()])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('false'), var_data_mutated.array_get(rt.new_string('date_to')))))) {
			mut var_date_on_sale_to := rt.call_function('date', [rt.new_string('Y-m-d 23:59:59'), rt.call_function('strtotime', [rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('date_to'))])])])
			rt.call_method(var_variation, 'set_date_on_sale_to', [var_date_on_sale_to.clone()])
		}
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price_increase(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_adjust_price(var_variations_mutated.clone(), rt.new_string('regular_price'), rt.new_string('+'), rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))]))
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price_decrease(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_adjust_price(var_variations_mutated.clone(), rt.new_string('regular_price'), rt.new_string('-'), rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))]))
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price_increase(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_adjust_price(var_variations_mutated.clone(), rt.new_string('sale_price'), rt.new_string('+'), rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))]))
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price_decrease(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	Class_WC_AJAX.variation_bulk_adjust_price(var_variations_mutated.clone(), rt.new_string('sale_price'), rt.new_string('-'), rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('value'))]))
}

fn Class_WC_AJAX.variation_bulk_action_variable_unset_cogs_value(var_variations rt.PhpVal, var_data rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{}))))) {
		return
	}
	mut iter_33 := var_variations_mutated.iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_variation_id := item_33.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		rt.call_method(var_variation, 'set_cogs_value', [rt.new_null()])
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_adjust_price(var_variations rt.PhpVal, var_field rt.PhpVal, var_operator rt.PhpVal, var_value rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut iter_34 := var_variations_mutated.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_variation_id := item_34.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		mut var_field_value := rt.call_method(var_variation, "get_${var_field.to_string()}", [rt.new_string('edit')])
		if rt.is_true(rt.identical(rt.new_string(''), var_field_value)) || rt.is_true(rt.identical(rt.new_null(), var_field_value)) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('%'), rt.call_function('substr', [var_value.clone(), rt.new_int(-1)]))) {
			mut var_percent := rt.call_function('wc_format_decimal', [rt.call_function('substr', [var_value.clone(), rt.new_int(0), rt.new_int(-1)])])
			mut iife_temp_32 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_32 := iife_temp_32.round(rt.mul(rt.div(var_field_value, rt.new_int(100)), var_percent), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
			var_field_value = rt.add(var_field_value, rt.mul(iife_result_32, rt.new_string("${var_operator.to_string()}1")))
		} else {
			var_field_value = rt.add(var_field_value, rt.mul(var_value, rt.new_string("${var_operator.to_string()}1")))
		}
		rt.call_method(var_variation, "set_${var_field.to_string()}", [var_field_value.clone()])
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_set(var_variations rt.PhpVal, var_field rt.PhpVal, var_value rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut iter_35 := var_variations_mutated.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_variation_id := item_35.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		rt.call_method(var_variation, "set_${var_field.to_string()}", [rt.call_function('wc_clean', [var_value.clone()])])
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.variation_bulk_toggle(var_variations rt.PhpVal, var_field rt.PhpVal) {
	mut var_variations_mutated := var_variations
	mut iter_36 := var_variations_mutated.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_variation_id := item_36.val
		mut var_variation := rt.call_function('wc_get_product', [var_variation_id.clone()])
		mut var_prev_value := rt.call_method(var_variation, "get_${var_field.to_string()}", [rt.new_string('edit')])
		rt.call_method(var_variation, "set_${var_field.to_string()}", [rt.new_bool(!(rt.is_true(var_prev_value)))])
		rt.call_method(var_variation, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_AJAX.bulk_edit_variations() {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('check_ajax_referer', [rt.new_string('bulk-edit-variations'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))) || !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('bulk_action'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_product_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('product_id'))])
	mut var_bulk_action := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('bulk_action'))])])
	mut var_data := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('data')))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('data'))])]) } else { rt.new_array() }
	mut var_variations := rt.new_array()
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_bulk_edit_variations_need_children'), rt.new_bool(true)])) {
	var_variations = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_product_id }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'product_variation' }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: 'private' }]) }])])
	}
	if rt.is_true(rt.call_function('method_exists', [rt.new_string(@STRUCT), rt.new_string("variation_bulk_action_${var_bulk_action.to_string()}")])) {
		rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: "variation_bulk_action_${var_bulk_action.to_string()}" }]), var_variations.clone(), var_data.clone()])
	} else {
		rt.call_function('do_action', [rt.new_string('woocommerce_bulk_edit_variations_default'), var_bulk_action.clone(), var_data.clone(), var_product_id.clone(), var_variations.clone()])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_bulk_edit_variations'), var_bulk_action.clone(), var_data.clone(), var_product_id.clone(), var_variations.clone()])
	mut iife_temp_33 := Class_WC_Product_Variable{}
	mut iife_result_33 := iife_temp_33.sync(var_product_id.clone())
	rt.call_function('wc_delete_product_transients', [var_product_id.clone()])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.tax_rates_save_changes() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_tax_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_current_class := if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('current_class')))) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('current_class'))]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_tax_nonce'))]), rt.new_string('wc_tax_nonce-class:' + (var_current_class).str())]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut iife_temp_34 := Class_WC_Tax{}
	mut iife_result_34 := iife_temp_34.format_tax_rate_class(var_current_class.clone())
	var_current_class = iife_result_34
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_changes := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('changes'))])
	mut iter_37 := var_changes.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_data := item_37.val
		mut var_tax_rate_id := item_37.key
		if var_data.array_isset(rt.new_string('deleted')) {
			if var_data.array_isset(rt.new_string('newRow')) {
				continue
			}
		mut iife_temp_35 := Class_WC_Tax{}
		mut iife_result_35 := iife_temp_35._delete_tax_rate(var_tax_rate_id.clone())
		}
		mut var_tax_rate := rt.call_function('array_intersect_key', [var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'tax_rate_country', val: 1 }, rt.ArrayItem{ key: 'tax_rate_state', val: 1 }, rt.ArrayItem{ key: 'tax_rate', val: 1 }, rt.ArrayItem{ key: 'tax_rate_name', val: 1 }, rt.ArrayItem{ key: 'tax_rate_priority', val: 1 }, rt.ArrayItem{ key: 'tax_rate_compound', val: 1 }, rt.ArrayItem{ key: 'tax_rate_shipping', val: 1 }, rt.ArrayItem{ key: 'tax_rate_order', val: 1 }])])
		if var_tax_rate.array_isset(rt.new_string('tax_rate')) {
			var_tax_rate.array_set('tax_rate', rt.call_function('wc_format_decimal', [var_tax_rate.array_get(rt.new_string('tax_rate'))]))
		}
		if var_data.array_isset(rt.new_string('newRow')) {
			var_tax_rate.array_set('tax_rate_class', var_current_class.clone())
		mut iife_temp_36 := Class_WC_Tax{}
		mut iife_result_36 := iife_temp_36._insert_tax_rate(var_tax_rate.clone())
		var_tax_rate_id = iife_result_36
		} else if !(!rt.is_true(var_tax_rate)) {
		mut iife_temp_37 := Class_WC_Tax{}
		mut iife_result_37 := iife_temp_37._update_tax_rate(var_tax_rate_id.clone(), var_tax_rate.clone())
		}
		if var_data.array_isset(rt.new_string('postcode')) {
		mut var_postcode := rt.call_function('array_map', [rt.new_string('wc_clean'), var_data.array_get(rt.new_string('postcode'))])
		var_postcode = rt.call_function('array_map', [rt.new_string('wc_normalize_postcode'), var_postcode.clone()])
		mut iife_temp_38 := Class_WC_Tax{}
		mut iife_result_38 := iife_temp_38._update_tax_rate_postcodes(var_tax_rate_id.clone(), var_postcode.clone())
		}
		if var_data.array_isset(rt.new_string('city')) {
		mut iife_temp_39 := Class_WC_Tax{}
		mut iife_result_39 := iife_temp_39._update_tax_rate_cities(var_tax_rate_id.clone(), rt.call_function('array_map', [rt.new_string('wc_clean'), rt.call_function('array_map', [rt.new_string('wp_unslash'), var_data.array_get(rt.new_string('city'))])]))
		}
	}
	mut iife_temp_40 := Class_WC_Cache_Helper{}
	mut iife_result_40 := iife_temp_40.invalidate_cache_group(rt.new_string('taxes'))
	mut iife_temp_41 := Class_WC_Cache_Helper{}
	mut iife_result_41 := iife_temp_41.get_transient_version(rt.new_string('shipping'), rt.new_bool(true))
	mut iife_temp_42 := Class_WC_Tax{}
	mut iife_result_42 := iife_temp_42.get_rates_for_tax_class(var_current_class.clone())
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'rates', val: iife_result_42 }])])
}

fn Class_WC_AJAX.shipping_zones_save_changes() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_zones_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_zones_nonce'))]), rt.new_string('wc_shipping_zones_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_changes := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('changes'))])
	mut iter_38 := var_changes.iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_data := item_38.val
		mut var_zone_id := item_38.key
		if var_data.array_isset(rt.new_string('deleted')) {
			if var_data.array_isset(rt.new_string('newRow')) {
				continue
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_zone' }, rt.ArrayItem{ key: 'action', val: 'delete' }])])
			mut iife_temp_43 := Class_WC_Shipping_Zones{}
			mut iife_result_43 := iife_temp_43.delete_zone(var_zone_id.clone())
			continue
		}
		mut var_zone_data := rt.call_function('array_intersect_key', [var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'zone_id', val: 1 }, rt.ArrayItem{ key: 'zone_order', val: 1 }])])
		if var_zone_data.array_isset(rt.new_string('zone_id')) {
			mut var_zone := create_wc_shipping_zone(var_zone_data.array_get(rt.new_string('zone_id')))
			if var_zone_data.array_isset(rt.new_string('zone_order')) {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_order' }])])
				rt.call_method(var_zone, 'set_zone_order', [var_zone_data.array_get(rt.new_string('zone_order'))])
			}
			rt.call_method(var_zone, 'save', []rt.PhpVal{})
		}
	}
	mut var_current_tab := rt.get_superglobal('current_tab')
	var_current_tab = rt.new_string('shipping')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	mut iife_temp_44 := Class_WC_Shipping_Zones{}
	mut iife_result_44 := iife_temp_44.get_zones(rt.new_string('json'))
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'zones', val: iife_result_44 }])])
}

fn Class_WC_AJAX.shipping_zone_add_method() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_zones_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('zone_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('method_id'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_zones_nonce'))]), rt.new_string('wc_shipping_zones_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_zone_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('zone_id'))])])
	mut var_zone := create_wc_shipping_zone(var_zone_id.clone())
	if rt.is_true(rt.identical(rt.new_string(''), var_zone_id)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_zone' }, rt.ArrayItem{ key: 'action', val: 'add' }])])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_method' }, rt.ArrayItem{ key: 'action', val: 'add' }])])
	mut var_instance_id := rt.call_method(var_zone, 'add_shipping_method', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('method_id'))])])])
	mut var_current_tab := rt.get_superglobal('current_tab')
	var_current_tab = rt.new_string('shipping')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'instance_id', val: var_instance_id }, rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'zone_name', val: rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'methods', val: rt.call_method(var_zone, 'get_shipping_methods', [rt.new_bool(false), rt.new_string('json')]) }])])
}

fn Class_WC_AJAX.shipping_zone_remove_method() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_zones_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('instance_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('zone_id'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_zones_nonce'))]), rt.new_string('wc_shipping_zones_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_zone_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('zone_id'))])])
	mut var_zone := create_wc_shipping_zone(var_zone_id.clone())
	mut var_instance_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('instance_id'))])])
	rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: var_instance_id }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_zone, 'delete_shipping_method', [var_instance_id.clone()]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_shipping_method_instance_id')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_current_tab := rt.get_superglobal('current_tab')
	var_current_tab = rt.new_string('shipping')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'instance_id', val: var_instance_id }, rt.ArrayItem{ key: 'methods', val: rt.call_method(var_zone, 'get_shipping_methods', [rt.new_bool(false), rt.new_string('json')]) }])])
}

fn Class_WC_AJAX.shipping_zone_methods_save_changes() {
	mut var_wpdb := rt.new_null()
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_zones_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('zone_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_zones_nonce'))]), rt.new_string('wc_shipping_zones_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_zone_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('zone_id'))])])
	mut var_zone := create_wc_shipping_zone(var_zone_id.clone())
	if rt.is_true(rt.identical(rt.new_string(''), var_zone_id)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_zone' }, rt.ArrayItem{ key: 'action', val: 'add' }])])
	}
	mut var_changes := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('changes'))])
	if var_changes.array_isset(rt.new_string('zone_name')) {
		rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_name' }])])
		rt.call_method(var_zone, 'set_zone_name', [rt.call_function('wc_clean', [var_changes.array_get(rt.new_string('zone_name'))])])
	}
	if var_changes.array_isset(rt.new_string('zone_locations')) {
		rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_locations' }])])
		rt.call_method(var_zone, 'clear_locations', [rt.create_array([rt.ArrayItem{ key: none, val: 'state' }, rt.ArrayItem{ key: none, val: 'country' }, rt.ArrayItem{ key: none, val: 'continent' }])])
		mut var_locations := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_clean'), rt.cast_array(var_changes.array_get(rt.new_string('zone_locations')))])])
		mut iter_39 := var_locations.iterator()
		for {
			item_39 := iter_39.next() or { break }
			mut var_location := item_39.val
			mut var_location_parts := rt.call_function('explode', [rt.new_string(':'), var_location.clone()])
			mut switch_val_1 := var_location_parts.array_get(rt.new_int(0))
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('state'))) {
				rt.call_method(var_zone, 'add_location', [rt.new_string((var_location_parts.array_get(rt.new_int(1))).str() + ':' + (var_location_parts.array_get(rt.new_int(2))).str()), rt.new_string('state')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('country'))) {
				rt.call_method(var_zone, 'add_location', [var_location_parts.array_get(rt.new_int(1)), rt.new_string('country')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('continent'))) {
				rt.call_method(var_zone, 'add_location', [var_location_parts.array_get(rt.new_int(1)), rt.new_string('continent')])
			}
		}
	}
	if var_changes.array_isset(rt.new_string('zone_postcodes')) {
		rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_postcodes' }])])
		rt.call_method(var_zone, 'clear_locations', [rt.new_string('postcode')])
		mut var_postcodes := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('strtoupper'), rt.call_function('array_map', [rt.new_string('wc_clean'), rt.call_function('explode', [rt.new_string('\n'), var_changes.array_get(rt.new_string('zone_postcodes'))])])])])
		mut iter_40 := var_postcodes.iterator()
		for {
			item_40 := iter_40.next() or { break }
			mut var_postcode := item_40.val
			rt.call_method(var_zone, 'add_location', [var_postcode.clone(), rt.new_string('postcode')])
		}
	}
	if var_changes.array_isset(rt.new_string('methods')) {
		mut iter_41 := var_changes.array_get(rt.new_string('methods')).iterator()
		for {
			item_41 := iter_41.next() or { break }
			mut var_data := item_41.val
			mut var_instance_id := item_41.key
			mut var_method_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT method_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods WHERE instance_id = %d')), var_instance_id.clone()])])
			if var_data.array_isset(rt.new_string('deleted')) {
				mut iife_temp_45 := Class_WC_Shipping_Zones{}
				mut iife_result_45 := iife_temp_45.get_shipping_method(var_instance_id.clone())
				mut var_shipping_method := iife_result_45
				mut var_option_key := rt.call_method(var_shipping_method, 'get_instance_option_key', []rt.PhpVal{})
				if rt.is_true(rt.call_method(var_wpdb, 'delete', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: var_instance_id }])])) {
					rt.call_function('delete_option', [var_option_key.clone()])
					rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_method' }, rt.ArrayItem{ key: 'action', val: 'delete' }])])
					rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_method_deleted'), var_instance_id.clone(), var_method_id.clone(), var_zone_id.clone()])
				}
				continue
			}
			mut var_method_data := rt.call_function('array_intersect_key', [var_data.clone(), rt.create_array([rt.ArrayItem{ key: 'method_order', val: 1 }, rt.ArrayItem{ key: 'enabled', val: 1 }])])
			if var_method_data.array_isset(rt.new_string('method_order')) {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_methods_order' }])])
				rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), rt.create_array([rt.ArrayItem{ key: 'method_order', val: rt.call_function('absint', [var_method_data.array_get(rt.new_string('method_order'))]) }]), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: rt.call_function('absint', [var_instance_id.clone()]) }])])
			}
			if var_method_data.array_isset(rt.new_string('enabled')) {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_methods_enabled' }])])
				mut var_is_enabled := rt.call_function('absint', [rt.identical(rt.new_string('yes'), var_method_data.array_get(rt.new_string('enabled')))])
				if rt.is_true(rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')), rt.create_array([rt.ArrayItem{ key: 'is_enabled', val: var_is_enabled }]), rt.create_array([rt.ArrayItem{ key: 'instance_id', val: rt.call_function('absint', [var_instance_id.clone()]) }])])) {
					rt.call_function('do_action', [rt.new_string('woocommerce_shipping_zone_method_status_toggled'), var_instance_id.clone(), var_method_id.clone(), var_zone_id.clone(), var_is_enabled.clone()])
				}
			}
		}
	}
	rt.call_method(var_zone, 'save', []rt.PhpVal{})
	mut var_current_tab := rt.get_superglobal('current_tab')
	var_current_tab = rt.new_string('shipping')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'zone_name', val: rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'methods', val: rt.call_method(var_zone, 'get_shipping_methods', [rt.new_bool(false), rt.new_string('json')]) }])])
}

fn Class_WC_AJAX.shipping_zone_methods_save_settings() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_zones_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('instance_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('data'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_zones_nonce'))]), rt.new_string('wc_shipping_zones_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_instance_id := rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('instance_id'))])
	mut iife_temp_46 := Class_WC_Shipping_Zones{}
	mut iife_result_46 := iife_temp_46.get_zone_by(rt.new_string('instance_id'), var_instance_id.clone())
	mut var_zone := iife_result_46
	mut iife_temp_47 := Class_WC_Shipping_Zones{}
	mut iife_result_47 := iife_temp_47.get_shipping_method(var_instance_id.clone())
	mut var_shipping_method := iife_result_47
	rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'zone_method_settings' }])])
	rt.call_method(var_shipping_method, 'set_post_data', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('data'))])])
	mut var_current_tab := rt.get_superglobal('current_tab')
	var_current_tab = rt.new_string('shipping')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	rt.call_method(var_shipping_method, 'process_admin_options', []rt.PhpVal{})
	mut iife_temp_48 := Class_WC_Cache_Helper{}
	mut iife_result_48 := iife_temp_48.get_transient_version(rt.new_string('shipping'), rt.new_bool(true))
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'zone_id', val: rt.call_method(var_zone, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'zone_name', val: rt.call_method(var_zone, 'get_zone_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'methods', val: rt.call_method(var_zone, 'get_shipping_methods', [rt.new_bool(false), rt.new_string('json')]) }, rt.ArrayItem{ key: 'errors', val: rt.call_method(var_shipping_method, 'get_errors', []rt.PhpVal{}) }])])
}

fn Class_WC_AJAX.shipping_classes_save_changes() {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_classes_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_classes_nonce'))]), rt.new_string('wc_shipping_classes_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_changes := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('changes'))])
	mut iter_42 := var_changes.iterator()
	for {
		item_42 := iter_42.next() or { break }
		mut var_data := item_42.val
		mut var_term_id := item_42.key
		var_term_id = rt.call_function('absint', [var_term_id.clone()])
		if var_data.array_isset(rt.new_string('deleted')) {
			if var_data.array_isset(rt.new_string('newRow')) {
				continue
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class' }, rt.ArrayItem{ key: 'action', val: 'delete' }])])
			rt.call_function('wp_delete_term', [var_term_id.clone(), rt.new_string('product_shipping_class')])
			continue
		}
		mut var_update_args := rt.new_array()
		if var_data.array_isset(rt.new_string('name')) {
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class_name' }])])
			var_update_args.array_set('name', rt.call_function('wc_clean', [var_data.array_get(rt.new_string('name'))]))
		}
		if var_data.array_isset(rt.new_string('slug')) {
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class_slug' }])])
			var_update_args.array_set('slug', rt.call_function('wc_clean', [var_data.array_get(rt.new_string('slug'))]))
		}
		if var_data.array_isset(rt.new_string('description')) {
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class_description' }])])
			var_update_args.array_set('description', rt.call_function('wc_clean', [var_data.array_get(rt.new_string('description'))]))
		}
		if var_data.array_isset(rt.new_string('newRow')) {
			var_update_args = rt.call_function('array_filter', [var_update_args.clone()])
			if !rt.is_true(var_update_args.array_get(rt.new_string('name'))) {
				continue
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class' }, rt.ArrayItem{ key: 'action', val: 'add' }])])
		mut var_inserted_term := rt.call_function('wp_insert_term', [var_update_args.array_get(rt.new_string('name')), rt.new_string('product_shipping_class'), var_update_args.clone()])
		var_term_id = if rt.is_true(rt.call_function('is_wp_error', [var_inserted_term.clone()])) { rt.new_int(0) } else { var_inserted_term.array_get(rt.new_string('term_id')) }
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'shipping_class' }])])
			rt.call_function('wp_update_term', [var_term_id.clone(), rt.new_string('product_shipping_class'), var_update_args.clone()])
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_shipping_classes_save_class'), var_term_id.clone(), var_data.clone()])
	}
	mut var_current_tab := rt.get_superglobal('current_tab')
	mut var_current_section := rt.get_superglobal('current_section')
	var_current_tab = rt.new_string('shipping')
	var_current_section = rt.new_string('classes')
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	mut iife_temp_49 := Class_WC_Shipping{}
	mut iife_result_49 := iife_temp_49.instance()
	mut var_wc_shipping := iife_result_49
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'shipping_classes', val: rt.call_method(var_wc_shipping, 'get_shipping_classes', []rt.PhpVal{}) }])])
}

fn Class_WC_AJAX.shipping_providers_save_changes() {
	mut iife_temp_50 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_50 := iife_temp_50.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_50)))) {
		rt.call_function('wp_send_json_error', [rt.new_string('feature_disabled')])
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('wc_shipping_providers_nonce')) && rt.get_superglobal('_POST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_fields')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('wc_shipping_providers_nonce'))]), rt.new_string('wc_shipping_providers_nonce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_capabilities')])
	}
	mut var_taxonomy := rt.new_string('wc_fulfillment_shipping_provider')
	mut var_changes := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('changes'))])
	if !(var_changes.clone().is_array()) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_changes')])
	}
	mut iife_temp_51 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
	mut iife_result_51 := iife_temp_51.get_shipping_providers()
	mut var_all_providers := iife_result_51
	mut var_built_in_keys := rt.new_array()
	mut iter_43 := var_all_providers.iterator()
	for {
		item_43 := iter_43.next() or { break }
		mut var_provider := item_43.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_provider, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider')))))) {
			var_built_in_keys << rt.call_method(var_provider, 'get_key', []rt.PhpVal{})
		}
	}
	mut var_reserved_slug_error := rt.new_string('')
	mut iter_44 := var_changes.iterator()
	for {
		item_44 := iter_44.next() or { break }
		mut var_data := item_44.val
		mut var_term_id := item_44.key
		if !(var_term_id.clone().is_long() || var_term_id.clone().is_double()) && !(var_data.array_isset(rt.new_string('newRow'))) {
			continue
		}
		var_term_id = rt.call_function('absint', [var_term_id.clone()])
		if var_data.array_isset(rt.new_string('deleted')) {
			if var_data.array_isset(rt.new_string('newRow')) {
				continue
			}
			mut var_term_to_delete := rt.call_function('get_term', [var_term_id.clone(), var_taxonomy.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_term_to_delete, 'WP_Term'))) && rt.is_true(Class_WC_AJAX.is_shipping_provider_in_use((rt.get_property(var_term_to_delete, 'slug')).str())) {
				var_reserved_slug_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot delete "%s" because it is used by existing fulfillments. Remove all fulfillments using this provider first.'), rt.new_string('woocommerce')]), rt.get_property(var_term_to_delete, 'name')])
				continue
			}
			mut var_delete_result := rt.call_function('wp_delete_term', [var_term_id.clone(), var_taxonomy.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_delete_result.clone()])) || rt.is_true(rt.identical(rt.new_bool(false), var_delete_result)) {
			var_reserved_slug_error = if rt.is_true(rt.call_function('is_wp_error', [var_delete_result.clone()])) { rt.call_method(var_delete_result, 'get_error_message', []rt.PhpVal{}) } else { rt.call_function('__', [rt.new_string('Failed to delete the shipping provider.'), rt.new_string('woocommerce')]) }
			}
			continue
		}
		mut var_update_args := rt.new_array()
		if var_data.array_isset(rt.new_string('name')) && var_data.array_get(rt.new_string('name')).is_string() {
			var_update_args.array_set('name', rt.call_function('sanitize_text_field', [var_data.array_get(rt.new_string('name'))]))
		}
		if var_data.array_isset(rt.new_string('newRow')) && var_data.array_isset(rt.new_string('slug')) && var_data.array_get(rt.new_string('slug')).is_string() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_data.array_get(rt.new_string('slug')))))) {
			mut var_candidate_slug := rt.call_function('sanitize_title', [var_data.array_get(rt.new_string('slug'))])
			if rt.is_true(rt.call_function('in_array', [var_candidate_slug.clone(), rt.create_array_from_list(var_built_in_keys), rt.new_bool(true)])) {
				var_reserved_slug_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The slug "%s" is already used by a built-in shipping provider. Please choose a different slug.'), rt.new_string('woocommerce')]), var_candidate_slug.clone()])
				continue
			}
			var_update_args.array_set('slug', var_candidate_slug.clone())
		}
		mut var_tracking_url_template := rt.new_null()
		if var_data.array_isset(rt.new_string('tracking_url_template')) && var_data.array_get(rt.new_string('tracking_url_template')).is_string() {
			if rt.is_true(rt.identical(rt.new_string(''), var_data.array_get(rt.new_string('tracking_url_template')))) {
			var_tracking_url_template = rt.new_string('')
			} else {
				mut var_testable_url := rt.call_function('str_replace', [rt.new_string('__PLACEHOLDER__'), rt.new_string('test'), var_data.array_get(rt.new_string('tracking_url_template'))])
				if rt.is_true(rt.call_function('filter_var', [var_testable_url.clone(), rt.get_constant('FILTER_VALIDATE_URL')])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#^https?://#i'), var_testable_url.clone()])) {
				var_tracking_url_template = rt.call_function('esc_url_raw', [var_data.array_get(rt.new_string('tracking_url_template')), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])])
				} else {
				var_reserved_slug_error = rt.call_function('__', [rt.new_string('The tracking URL template must be a valid HTTP or HTTPS URL.'), rt.new_string('woocommerce')])
				}
			}
		}
		mut var_icon_url := rt.new_null()
		if var_data.array_isset(rt.new_string('icon')) && var_data.array_get(rt.new_string('icon')).is_string() {
			if rt.is_true(rt.identical(rt.new_string(''), var_data.array_get(rt.new_string('icon')))) {
			var_icon_url = rt.new_string('')
			} else if rt.is_true(rt.call_function('filter_var', [var_data.array_get(rt.new_string('icon')), rt.get_constant('FILTER_VALIDATE_URL')])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#^https?://#i'), var_data.array_get(rt.new_string('icon'))])) {
			var_icon_url = rt.call_function('esc_url_raw', [var_data.array_get(rt.new_string('icon')), rt.create_array([rt.ArrayItem{ key: none, val: 'http' }, rt.ArrayItem{ key: none, val: 'https' }])])
			} else {
			var_reserved_slug_error = rt.call_function('__', [rt.new_string('The icon URL must be a valid HTTP or HTTPS URL.'), rt.new_string('woocommerce')])
			}
		}
		if var_data.array_isset(rt.new_string('newRow')) {
			mut var_provider_name := rt.new_string(if !(var_update_args.array_get(rt.new_string('name'))).is_null() { var_update_args.array_get(rt.new_string('name')) } else { rt.new_string('') }.to_string())
			var_update_args = rt.call_function('array_filter', [var_update_args.clone()])
			if !rt.is_true(var_provider_name) {
				continue
			}
			mut var_inserted_term := rt.call_function('wp_insert_term', [var_provider_name.clone(), var_taxonomy.clone(), var_update_args.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_inserted_term.clone()])) {
				var_reserved_slug_error = rt.call_method(var_inserted_term, 'get_error_message', []rt.PhpVal{})
				continue
			}
			var_term_id = var_inserted_term.array_get(rt.new_string('term_id'))
			mut var_new_term := rt.call_function('get_term', [var_term_id.clone(), var_taxonomy.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_new_term, 'WP_Term')))))) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [rt.get_property(var_new_term, 'slug'), rt.create_array_from_list(var_built_in_keys), rt.new_bool(true)])) {
				rt.call_function('wp_delete_term', [var_term_id.clone(), var_taxonomy.clone()])
				var_reserved_slug_error = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not create provider "%s" because its auto-generated slug conflicts with a built-in shipping provider. Please specify a different slug.'), rt.new_string('woocommerce')]), var_provider_name.clone()])
				continue
			}
		} else {
			mut var_update_result := rt.call_function('wp_update_term', [var_term_id.clone(), var_taxonomy.clone(), var_update_args.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_update_result.clone()])) {
				var_reserved_slug_error = rt.call_method(var_update_result, 'get_error_message', []rt.PhpVal{})
				continue
			}
		}
		if rt.is_true(var_term_id) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_tracking_url_template)))) {
				rt.call_function('update_term_meta', [var_term_id.clone(), rt.new_string('tracking_url_template'), var_tracking_url_template.clone()])
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_icon_url)))) {
				rt.call_function('update_term_meta', [var_term_id.clone(), rt.new_string('icon'), var_icon_url.clone()])
			}
		}
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
	mut var_shipping_providers := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()]))))) {
		mut iter_45 := var_terms.iterator()
		for {
			item_45 := iter_45.next() or { break }
			mut var_term := item_45.val
			var_shipping_providers << rt.create_array([rt.ArrayItem{ key: 'term_id', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') }, rt.ArrayItem{ key: 'tracking_url_template', val: rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('tracking_url_template'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'icon', val: rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'), rt.new_string('icon'), rt.new_bool(true)]) }])
		}
	}
	mut var_response := { 'shipping_providers': var_shipping_providers }
	if !(!rt.is_true(var_reserved_slug_error)) {
		var_response['error'] = var_reserved_slug_error.clone()
	}
	rt.call_function('wp_send_json_success', [rt.create_array_from_native_map(var_response)])
}

fn Class_WC_AJAX.is_shipping_provider_in_use(provider_slug string) bool {
	mut var_wpdb := rt.new_null()
	mut var_fulfillments_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillments')
	mut var_meta_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_fulfillment_meta')
	mut var_exists := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT 1 FROM ${var_fulfillments_table.to_string()} f\n\t\t\t\tINNER JOIN ${var_meta_table.to_string()} m ON f.fulfillment_id = m.fulfillment_id\n\t\t\t\tWHERE m.meta_key = '_shipment_provider'\n\t\t\t\tAND m.meta_value = %s\n\t\t\t\tAND f.date_deleted IS NULL\n\t\t\t\tAND m.date_deleted IS NULL\n\t\t\t\tLIMIT 1"), rt.call_function('wp_json_encode', [rt.new_string(provider_slug)])])])
	if rt.is_true(rt.get_property(var_wpdb, 'last_error')) {
		return true
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_exists)))
}

fn Class_WC_AJAX.toggle_gateway_enabled() {
	mut var_queries := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])) && rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('woocommerce-toggle-payment-gateway-enabled'), rt.new_string('security')])) && rt.get_superglobal('_POST').array_isset(rt.new_string('gateway_id')) {
		mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
		if rt.is_true(var_referer) {
			mut var_current_tab := rt.get_superglobal('current_tab')
			rt.call_function('parse_str', [rt.call_function('wp_parse_url', [var_referer.clone(), rt.get_constant('PHP_URL_QUERY')]), rt.create_array_from_native_map(var_queries)])
		var_current_tab = if !(var_queries.array_get(rt.new_string('tab'))).is_null() { var_queries.array_get(rt.new_string('tab')) } else { rt.new_string('') }
		}
		mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
		mut var_gateway_id := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('gateway_id'))])])
		mut iter_46 := var_payment_gateways.iterator()
		for {
			item_46 := iter_46.next() or { break }
			mut var_gateway := item_46.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_gateway_id.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_gateway, 'id') }, rt.ArrayItem{ key: none, val: rt.call_function('sanitize_title', [rt.call_function('get_class', [var_gateway.clone()])]) }]), rt.new_bool(true)]))))) {
				continue
			}
			mut var_enabled := rt.call_method(var_gateway, 'get_option', [rt.new_string('enabled'), rt.new_string('no')])
			mut var_option := { 'id': rt.call_method(var_gateway, 'get_option_key', []rt.PhpVal{}) }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [var_enabled.clone()]))))) {
				if rt.is_true(rt.call_method(var_gateway, 'needs_setup', []rt.PhpVal{})) {
					rt.call_function('wp_send_json_error', [rt.new_string('needs_setup')])
					rt.call_function('wp_die', []rt.PhpVal{})
				} else {
					rt.call_function('do_action', [rt.new_string('woocommerce_update_option'), rt.create_array_from_native_map(var_option)])
					rt.call_method(var_gateway, 'update_option', [rt.new_string('enabled'), rt.new_string('yes')])
				}
			} else {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_option'), rt.create_array_from_native_map(var_option)])
				rt.call_method(var_gateway, 'update_option', [rt.new_string('enabled'), rt.new_string('no')])
			}
			rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
			rt.call_function('wp_send_json_success', [rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [var_enabled.clone()]))))])
			rt.call_function('wp_die', []rt.PhpVal{})
		}
	}
	rt.call_function('wp_send_json_error', [rt.new_string('invalid_gateway_id')])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.load_status_widget() {
	rt.call_function('check_ajax_referer', [rt.new_string('wc-status-widget'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_woocommerce_reports')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_permissions')])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	rt.include_file(@DIR + '/admin/class-wc-admin-dashboard.php', '2')
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wc_admin_dashboard := create_wc_admin_dashboard()
	var_wc_admin_dashboard.status_widget_content()
	mut var_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'content', val: var_content }])])
}

fn Class_WC_AJAX.load_recent_reviews_widget() {
	rt.call_function('check_ajax_referer', [rt.new_string('wc-recent-reviews-widget'), rt.new_string('security')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_shop_orders')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_permissions')])
	}
	rt.include_file(@DIR + '/admin/class-wc-admin-dashboard.php', '2')
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wc_admin_dashboard := create_wc_admin_dashboard()
	var_wc_admin_dashboard.recent_reviews_content()
	mut var_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'content', val: var_content }])])
}

fn Class_WC_AJAX.order_add_meta() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox.class()]), 'add_meta_ajax', []rt.PhpVal{})
}

fn Class_WC_AJAX.order_delete_meta() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox.class()]), 'delete_meta_ajax', []rt.PhpVal{})
}

fn Class_WC_AJAX.json_search_order_metakeys() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_CustomMetaBox.class()]), 'search_metakeys_ajax', []rt.PhpVal{})
}

fn Class_WC_AJAX.order_refresh_lock(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class()]), 'refresh_lock_ajax', [var_response_mutated.clone(), var_data_mutated.clone()])
}

fn Class_WC_AJAX.check_locked_orders(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.class()]), 'check_locked_orders_ajax', [var_response_mutated.clone(), var_data_mutated.clone()])
}

fn Class_WC_AJAX.render_variation_html(mut var_product_object Class_WC_Product, mut var_variation_object Class_WC_Product, var_loop rt.PhpVal, mut var_base_cost Class_?float) {
	mut var_product_object_mutated := var_product_object
	mut var_variation_object_mutated := var_variation_object
	mut var_loop_mutated := var_loop
	mut var_base_cost_mutated := var_base_cost
	mut var_variation_id := rt.call_method(var_variation_object_mutated, 'get_id', []rt.PhpVal{})
	mut var_variation := rt.call_function('get_post', [var_variation_id.clone()])
	mut var_variation_data := rt.call_function('array_merge', [rt.call_function('get_post_custom', [var_variation_id.clone()]), rt.call_function('wc_get_product_variation_attributes', [var_variation_id.clone()])])
	rt.include_file(@DIR + '/admin/meta-boxes/views/html-variation-admin.php', '1')
}

fn Class_WC_AJAX.base_cost_or_null(mut var_product_object Class_WC_Product) f64 {
	mut var_product_object_mutated := var_product_object
	return (if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})) { if !(rt.call_method(var_product_object_mutated, 'get_cogs_value', []rt.PhpVal{})).is_null() { rt.call_method(var_product_object_mutated, 'get_cogs_value', []rt.PhpVal{}) } else { rt.new_int(0) } } else { rt.new_null() }).to_f64()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Admin_List_Table_Orders {
	rt.PhpObjectBase
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Meta_Box_Product_Data {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Rate {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Tax {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WC_Post_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variable {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zone {
	rt.PhpObjectBase
}

struct Class_WC_Shipping {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Dashboard {
	rt.PhpObjectBase
}

fn create_wc_ajax(_args ...rt.PhpVal) &Class_WC_AJAX {
	mut obj := &Class_WC_AJAX{
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

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
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

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_list_table_orders(_args ...rt.PhpVal) &Class_WC_Admin_List_Table_Orders {
	mut obj := &Class_WC_Admin_List_Table_Orders{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_meta_box_product_data(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Data {
	mut obj := &Class_WC_Meta_Box_Product_Data{
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

fn create_wc_customer_download(_args ...rt.PhpVal) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_Order_Item_Fee {
	mut obj := &Class_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_rate(_args ...rt.PhpVal) &Class_WC_Shipping_Rate {
	mut obj := &Class_WC_Shipping_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_tax(_args ...rt.PhpVal) &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_post_data(_args ...rt.PhpVal) &Class_WC_Post_Data {
	mut obj := &Class_WC_Post_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zone(_args ...rt.PhpVal) &Class_WC_Shipping_Zone {
	mut obj := &Class_WC_Shipping_Zone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping(_args ...rt.PhpVal) &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_dashboard(_args ...rt.PhpVal) &Class_WC_Admin_Dashboard {
	mut obj := &Class_WC_Admin_Dashboard{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_AJAX) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_AJAX.init()
			return rt.new_null()
		}
		'get_endpoint' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_AJAX.get_endpoint(dispatch_arg_0)
		}
		'set_wc_ajax_argument_in_query' {
			Class_WC_AJAX.set_wc_ajax_argument_in_query()
			return rt.new_null()
		}
		'define_ajax' {
			Class_WC_AJAX.define_ajax()
			return rt.new_null()
		}
		'wc_ajax_headers' {
			Class_WC_AJAX.wc_ajax_headers()
			return rt.new_null()
		}
		'do_wc_ajax' {
			Class_WC_AJAX.do_wc_ajax()
			return rt.new_null()
		}
		'add_ajax_events' {
			Class_WC_AJAX.add_ajax_events()
			return rt.new_null()
		}
		'get_refreshed_fragments' {
			Class_WC_AJAX.get_refreshed_fragments()
			return rt.new_null()
		}
		'apply_coupon' {
			Class_WC_AJAX.apply_coupon()
			return rt.new_null()
		}
		'remove_coupon' {
			Class_WC_AJAX.remove_coupon()
			return rt.new_null()
		}
		'update_shipping_method' {
			Class_WC_AJAX.update_shipping_method()
			return rt.new_null()
		}
		'get_cart_totals' {
			Class_WC_AJAX.get_cart_totals()
			return rt.new_null()
		}
		'update_order_review_expired' {
			Class_WC_AJAX.update_order_review_expired()
			return rt.new_null()
		}
		'update_order_review' {
			Class_WC_AJAX.update_order_review()
			return rt.new_null()
		}
		'add_to_cart' {
			Class_WC_AJAX.add_to_cart()
			return rt.new_null()
		}
		'remove_from_cart' {
			Class_WC_AJAX.remove_from_cart()
			return rt.new_null()
		}
		'checkout' {
			Class_WC_AJAX.checkout()
			return rt.new_null()
		}
		'get_variation' {
			Class_WC_AJAX.get_variation()
			return rt.new_null()
		}
		'get_customer_location' {
			Class_WC_AJAX.get_customer_location()
			return rt.new_null()
		}
		'feature_product' {
			Class_WC_AJAX.feature_product()
			return rt.new_null()
		}
		'mark_order_status' {
			Class_WC_AJAX.mark_order_status()
			return rt.new_null()
		}
		'get_order_details' {
			Class_WC_AJAX.get_order_details()
			return rt.new_null()
		}
		'add_attribute' {
			Class_WC_AJAX.add_attribute()
			return rt.new_null()
		}
		'add_new_attribute' {
			Class_WC_AJAX.add_new_attribute()
			return rt.new_null()
		}
		'remove_variations' {
			Class_WC_AJAX.remove_variations()
			return rt.new_null()
		}
		'save_attributes' {
			Class_WC_AJAX.save_attributes()
			return rt.new_null()
		}
		'add_attributes_and_variations' {
			Class_WC_AJAX.add_attributes_and_variations()
			return rt.new_null()
		}
		'create_product_with_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_AJAX.create_product_with_attributes(dispatch_arg_0)
		}
		'create_all_product_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_AJAX.create_all_product_variations(dispatch_arg_0)
		}
		'add_variation' {
			Class_WC_AJAX.add_variation()
			return rt.new_null()
		}
		'link_all_variations' {
			Class_WC_AJAX.link_all_variations()
			return rt.new_null()
		}
		'revoke_access_to_download' {
			Class_WC_AJAX.revoke_access_to_download()
			return rt.new_null()
		}
		'grant_access_to_download' {
			Class_WC_AJAX.grant_access_to_download()
			return rt.new_null()
		}
		'get_customer_details' {
			Class_WC_AJAX.get_customer_details()
			return rt.new_null()
		}
		'add_order_item' {
			Class_WC_AJAX.add_order_item()
			return rt.new_null()
		}
		'maybe_add_order_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_AJAX.maybe_add_order_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_order_fee' {
			Class_WC_AJAX.add_order_fee()
			return rt.new_null()
		}
		'add_order_shipping' {
			Class_WC_AJAX.add_order_shipping()
			return rt.new_null()
		}
		'add_order_tax' {
			Class_WC_AJAX.add_order_tax()
			return rt.new_null()
		}
		'add_coupon_discount' {
			Class_WC_AJAX.add_coupon_discount()
			return rt.new_null()
		}
		'remove_order_coupon' {
			Class_WC_AJAX.remove_order_coupon()
			return rt.new_null()
		}
		'remove_order_item' {
			Class_WC_AJAX.remove_order_item()
			return rt.new_null()
		}
		'remove_order_tax' {
			Class_WC_AJAX.remove_order_tax()
			return rt.new_null()
		}
		'calc_line_taxes' {
			Class_WC_AJAX.calc_line_taxes()
			return rt.new_null()
		}
		'save_order_items' {
			Class_WC_AJAX.save_order_items()
			return rt.new_null()
		}
		'load_order_items' {
			Class_WC_AJAX.load_order_items()
			return rt.new_null()
		}
		'add_order_note' {
			Class_WC_AJAX.add_order_note()
			return rt.new_null()
		}
		'delete_order_note' {
			Class_WC_AJAX.delete_order_note()
			return rt.new_null()
		}
		'json_search_products' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_WC_AJAX.json_search_products(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'json_search_products_and_variations' {
			Class_WC_AJAX.json_search_products_and_variations()
			return rt.new_null()
		}
		'json_search_downloadable_products_and_variations' {
			Class_WC_AJAX.json_search_downloadable_products_and_variations()
			return rt.new_null()
		}
		'json_search_customers' {
			Class_WC_AJAX.json_search_customers()
			return rt.new_null()
		}
		'json_search_categories' {
			Class_WC_AJAX.json_search_categories()
			return rt.new_null()
		}
		'json_search_categories_tree' {
			Class_WC_AJAX.json_search_categories_tree()
			return rt.new_null()
		}
		'json_search_taxonomy_terms' {
			Class_WC_AJAX.json_search_taxonomy_terms()
			return rt.new_null()
		}
		'json_search_product_attributes' {
			Class_WC_AJAX.json_search_product_attributes()
			return rt.new_null()
		}
		'json_search_pages' {
			Class_WC_AJAX.json_search_pages()
			return rt.new_null()
		}
		'term_ordering' {
			Class_WC_AJAX.term_ordering()
			return rt.new_null()
		}
		'product_ordering' {
			Class_WC_AJAX.product_ordering()
			return rt.new_null()
		}
		'refund_line_items' {
			Class_WC_AJAX.refund_line_items()
			return rt.new_null()
		}
		'delete_refund' {
			Class_WC_AJAX.delete_refund()
			return rt.new_null()
		}
		'rated' {
			Class_WC_AJAX.rated()
			return rt.new_null()
		}
		'update_api_key' {
			Class_WC_AJAX.update_api_key()
			return rt.new_null()
		}
		'load_variations' {
			Class_WC_AJAX.load_variations()
			return rt.new_null()
		}
		'save_variations' {
			Class_WC_AJAX.save_variations()
			return rt.new_null()
		}
		'variation_bulk_action_toggle_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_toggle_enabled(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_toggle_downloadable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_toggle_downloadable(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_toggle_virtual' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_toggle_virtual(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_toggle_manage_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_toggle_manage_stock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_regular_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_regular_price(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_sale_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_sale_price(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_stock_status_instock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_stock_status_instock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_stock_status_outofstock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_stock_status_outofstock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_stock_status_onbackorder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_stock_status_onbackorder(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_stock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_low_stock_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_low_stock_amount(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_weight' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_weight(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_length' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_length(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_width' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_width(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_height' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_height(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_download_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_download_limit(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_download_expiry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_download_expiry(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_delete_all' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_delete_all(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_sale_schedule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_sale_schedule(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_regular_price_increase' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_regular_price_increase(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_regular_price_decrease' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_regular_price_decrease(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_sale_price_increase' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_sale_price_increase(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_sale_price_decrease' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_sale_price_decrease(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_action_variable_unset_cogs_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_action_variable_unset_cogs_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'variation_bulk_adjust_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_adjust_price(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'variation_bulk_set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'variation_bulk_toggle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_AJAX.variation_bulk_toggle(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'bulk_edit_variations' {
			Class_WC_AJAX.bulk_edit_variations()
			return rt.new_null()
		}
		'tax_rates_save_changes' {
			Class_WC_AJAX.tax_rates_save_changes()
			return rt.new_null()
		}
		'shipping_zones_save_changes' {
			Class_WC_AJAX.shipping_zones_save_changes()
			return rt.new_null()
		}
		'shipping_zone_add_method' {
			Class_WC_AJAX.shipping_zone_add_method()
			return rt.new_null()
		}
		'shipping_zone_remove_method' {
			Class_WC_AJAX.shipping_zone_remove_method()
			return rt.new_null()
		}
		'shipping_zone_methods_save_changes' {
			Class_WC_AJAX.shipping_zone_methods_save_changes()
			return rt.new_null()
		}
		'shipping_zone_methods_save_settings' {
			Class_WC_AJAX.shipping_zone_methods_save_settings()
			return rt.new_null()
		}
		'shipping_classes_save_changes' {
			Class_WC_AJAX.shipping_classes_save_changes()
			return rt.new_null()
		}
		'shipping_providers_save_changes' {
			Class_WC_AJAX.shipping_providers_save_changes()
			return rt.new_null()
		}
		'is_shipping_provider_in_use' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WC_AJAX.is_shipping_provider_in_use(dispatch_arg_0))
		}
		'toggle_gateway_enabled' {
			Class_WC_AJAX.toggle_gateway_enabled()
			return rt.new_null()
		}
		'load_status_widget' {
			Class_WC_AJAX.load_status_widget()
			return rt.new_null()
		}
		'load_recent_reviews_widget' {
			Class_WC_AJAX.load_recent_reviews_widget()
			return rt.new_null()
		}
		'order_add_meta' {
			Class_WC_AJAX.order_add_meta()
			return rt.new_null()
		}
		'order_delete_meta' {
			Class_WC_AJAX.order_delete_meta()
			return rt.new_null()
		}
		'json_search_order_metakeys' {
			Class_WC_AJAX.json_search_order_metakeys()
			return rt.new_null()
		}
		'order_refresh_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_AJAX.order_refresh_lock(dispatch_arg_0, dispatch_arg_1)
		}
		'check_locked_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_AJAX.check_locked_orders(dispatch_arg_0, dispatch_arg_1)
		}
		'render_variation_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Product](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_?float](if args.len > 3 { args[3] } else { rt.new_null() })
			Class_WC_AJAX.render_variation_html(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'base_cost_or_null' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_float(Class_WC_AJAX.base_cost_or_null(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_AJAX) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_AJAX) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table_Orders) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table_Orders) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Meta_Box_Product_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Post_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Post_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Zone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Dashboard) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Dashboard) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Dashboard) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_AJAX', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_ajax()
		return rt.new_object('WC_AJAX', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_ArrayUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_arrayutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_ArrayUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_StringUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_stringutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_StringUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Coupon', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_coupon()
		return rt.new_object('WC_Coupon', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_List_Table_Orders', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_list_table_orders()
		return rt.new_object('WC_Admin_List_Table_Orders', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Attribute', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_attribute()
		return rt.new_object('WC_Product_Attribute', []string{}, obj)
	})
	rt.register_class_factory('WC_Meta_Box_Product_Data', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_meta_box_product_data()
		return rt.new_object('WC_Meta_Box_Product_Data', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Customer_Download', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_customer_download()
		return rt.new_object('WC_Customer_Download', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Utilities_Users', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_utilities_users()
		return rt.new_object('Automattic_WooCommerce_Internal_Utilities_Users', []string{}, obj)
	})
	rt.register_class_factory('WC_Customer', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_customer()
		return rt.new_object('WC_Customer', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WC_Order_Item_Fee', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_item_fee()
		return rt.new_object('WC_Order_Item_Fee', []string{}, obj)
	})
	rt.register_class_factory('WC_Order_Item_Shipping', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_item_shipping()
		return rt.new_object('WC_Order_Item_Shipping', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Rate', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_rate()
		return rt.new_object('WC_Shipping_Rate', []string{}, obj)
	})
	rt.register_class_factory('WC_Order_Item_Tax', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_item_tax()
		return rt.new_object('WC_Order_Item_Tax', []string{}, obj)
	})
	rt.register_class_factory('WP_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
	rt.register_class_factory('WC_Post_Data', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_post_data()
		return rt.new_object('WC_Post_Data', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_OrderUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_orderutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_OrderUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_NumberUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_numberutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_NumberUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Variable', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_variable()
		return rt.new_object('WC_Product_Variable', []string{}, obj)
	})
	rt.register_class_factory('WC_Tax', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tax()
		return rt.new_object('WC_Tax', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Zones', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zones()
		return rt.new_object('WC_Shipping_Zones', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Zone', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zone()
		return rt.new_object('WC_Shipping_Zone', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping()
		return rt.new_object('WC_Shipping', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Dashboard', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_dashboard()
		return rt.new_object('WC_Admin_Dashboard', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	Class_WC_AJAX.init()
}
