import rt

struct Class_WC_AJAX {
	rt.PhpObjectBase
}

fn Class_WC_AJAX.init()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'define_ajax' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'do_wc_ajax' }]), rt.new_int(0)])
	Class_WC_AJAX.add_ajax_events()
}

fn Class_WC_AJAX.get_endpoint(request string) rt.PhpVal {
	return rt.call_function('esc_url_raw', [rt.call_function('apply_filters', [rt.new_string('woocommerce_ajax_get_endpoint'), rt.call_function('add_query_arg', [rt.new_string('wc-ajax'), rt.new_string(request), rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'remove_item' }, rt.ArrayItem{ key: none, val: 'add-to-cart' }, rt.ArrayItem{ key: none, val: 'added-to-cart' }, rt.ArrayItem{ key: none, val: 'order_again' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('home_url', [rt.new_string('/'), rt.new_string('relative')])])]), rt.new_string(request)])])
}

fn Class_WC_AJAX.set_wc_ajax_argument_in_query()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc-ajax'))) && !rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')])) {
		rt.call_method(var_wp_query, 'set', [rt.new_string('wc-ajax'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc-ajax')])])])
	}
	// unsupported statement: Stmt_Nop
}

fn Class_WC_AJAX.define_ajax()  {
	mut var_wp_query := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Global
	Class_WC_AJAX.set_wc_ajax_argument_in_query()
	if !(!rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')]))) {
		rt.call_function('wc_maybe_define_constant', [rt.new_string('DOING_AJAX'), rt.new_bool(true)])
		rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_DOING_AJAX'), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) || rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('WP_DEBUG')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))))))))) {
			rt.call_function('ini_set', [rt.new_string('display_errors'), rt.new_int(0)])
			// unsupported statement: Stmt_Nop
		}
		rt.call_method(var_GLOBALS.array_get('wpdb'), 'hide_errors', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_Nop
}

fn Class_WC_AJAX.wc_ajax_headers()  {
	mut var_file := rt.new_null()
	mut var_line := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('send_origin_headers', []rt.PhpVal{})
		rt.call_function('send_nosniff_header', []rt.PhpVal{})
		rt.call_function('wc_nocache_headers', []rt.PhpVal{})
		rt.call_function('header', ['Content-Type: text/html; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str()])
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
		rt.call_function('status_header', [rt.new_int(200)])
	} else if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WP_DEBUG'))) {
		rt.call_function('headers_sent', [var_file.dup(), var_line.dup()])
		rt.call_function('trigger_error', [rt.new_string("wc_ajax_headers cannot set headers - headers already sent by ${var_file.to_string()} on line ${var_line.to_string()}"), rt.get_constant('E_USER_NOTICE')])
		// unsupported statement: Stmt_Nop
	}
}

fn Class_WC_AJAX.do_wc_ajax()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	Class_WC_AJAX.set_wc_ajax_argument_in_query()
	mut var_action := rt.call_method(var_wp_query, 'get', [rt.new_string('wc-ajax')])
	if rt.is_true(var_action) {
		Class_WC_AJAX.wc_ajax_headers()
		var_action = rt.call_function('sanitize_text_field', [var_action.dup()])
		rt.call_function('do_action', ['wc_ajax_' + (var_action).str()])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_Nop
}

fn Class_WC_AJAX.add_ajax_events()  {
	mut var_ajax_events_nopriv := ['get_refreshed_fragments', 'apply_coupon', 'remove_coupon', 'update_shipping_method', 'get_cart_totals', 'update_order_review', 'add_to_cart', 'remove_from_cart', 'checkout', 'get_variation', 'get_customer_location']
	for var_ajax_event in var_ajax_events_nopriv {
		rt.call_function('add_action', ['wp_ajax_woocommerce_' + ajax_event, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
		rt.call_function('add_action', ['wp_ajax_nopriv_woocommerce_' + ajax_event, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
		rt.call_function('add_action', ['wc_ajax_' + ajax_event, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
	}
	mut var_ajax_events := ['feature_product', 'mark_order_status', 'get_order_details', 'add_attribute', 'add_new_attribute', 'remove_variations', 'save_attributes', 'add_attributes_and_variations', 'add_variation', 'link_all_variations', 'revoke_access_to_download', 'grant_access_to_download', 'get_customer_details', 'add_order_item', 'add_order_fee', 'add_order_shipping', 'add_order_tax', 'add_coupon_discount', 'remove_order_coupon', 'remove_order_item', 'remove_order_tax', 'calc_line_taxes', 'save_order_items', 'load_order_items', 'add_order_note', 'delete_order_note', 'json_search_order_metakeys', 'json_search_products', 'json_search_products_and_variations', 'json_search_downloadable_products_and_variations', 'json_search_customers', 'json_search_categories', 'json_search_categories_tree', 'json_search_taxonomy_terms', 'json_search_product_attributes', 'json_search_pages', 'term_ordering', 'product_ordering', 'refund_line_items', 'delete_refund', 'rated', 'update_api_key', 'load_variations', 'save_variations', 'bulk_edit_variations', 'tax_rates_save_changes', 'shipping_zones_save_changes', 'shipping_zone_add_method', 'shipping_zone_remove_method', 'shipping_zone_methods_save_changes', 'shipping_zone_methods_save_settings', 'shipping_classes_save_changes', 'shipping_providers_save_changes', 'toggle_gateway_enabled', 'load_status_widget', 'load_recent_reviews_widget']
	for var_ajax_event in var_ajax_events {
		rt.call_function('add_action', ['wp_ajax_woocommerce_' + ajax_event, rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: ajax_event }])])
	}
	mut var_ajax_private_events := ['order_add_meta', 'order_delete_meta']
	for var_ajax_event in var_ajax_private_events {
		closure_1_fn := fn [var_ajax_event] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: rt.new_string(var_ajax_event) }])])
	return rt.new_null()
	}
		rt.call_function('add_action', ['wp_ajax_woocommerce_' + ajax_event, rt.new_closure(closure_1_fn)])
	}
	mut var_ajax_heartbeat_callbacks := ['order_refresh_lock', 'check_locked_orders']
	for var_ajax_callback in var_ajax_heartbeat_callbacks {
		closure_2_fn := fn [var_ajax_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_response := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_data := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: rt.new_string(var_ajax_callback) }]), rt.call_function('func_get_args', []rt.PhpVal{})])
	}
		rt.call_function('add_filter', [rt.new_string('heartbeat_received'), rt.new_closure(closure_2_fn), rt.new_int(11), rt.new_int(2)])
	}
}

fn Class_WC_AJAX.get_refreshed_fragments()  {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_mini_cart', []rt.PhpVal{})
	mut var_mini_cart := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'fragments', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_fragments'), rt.create_array([rt.ArrayItem{ key: 'div.widget_shopping_cart_content', val: '<div class="widget_shopping_cart_content">' + (var_mini_cart).str() + '</div>' }])]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_cart_hash', []rt.PhpVal{}) }])
	rt.call_function('wp_send_json', [var_data.dup()])
}

fn Class_WC_AJAX.apply_coupon()  {
	rt.call_function('check_ajax_referer', [rt.new_string('apply-coupon'), rt.new_string('security')])
	mut var_coupon_code := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.get_value_or_default(arg_0, arg_1) }(rt.get_superglobal('_POST').dup(), rt.new_string('coupon_code'))
	mut var_billing_email := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.get_value_or_default(arg_0, arg_1) }(rt.get_superglobal('_POST').dup(), rt.new_string('billing_email'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_billing_email.dup().is_string())) && rt.is_true(rt.call_function('is_email', [var_billing_email.dup()])))) {
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'customer'), 'set_billing_email', [var_billing_email.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.is_null_or_whitespace(arg_0) }(var_coupon_code.dup()))))) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'add_discount', [rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [var_coupon_code.dup()])])])
		// unsupported statement: Stmt_Nop
	} else {
		rt.call_function('wc_add_notice', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Coupon{}; return temp.get_generic_coupon_error(arg_0) }(Class_WC_Coupon.e_wc_coupon_please_enter()), rt.new_string('error')])
	}
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.remove_coupon()  {
	rt.call_function('check_ajax_referer', [rt.new_string('remove-coupon'), rt.new_string('security')])
	mut var_coupon := if rt.get_superglobal('_POST').array_isset(rt.new_string('coupon')) { rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('coupon')])]) } else { rt.new_bool(false) }
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.is_null_or_whitespace(arg_0) }(var_coupon.dup())) {
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('Sorry there was a problem removing this coupon.'), rt.new_string('woocommerce')]), rt.new_string('error')])
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'remove_coupon', [var_coupon.dup()])
		rt.call_function('wc_add_notice', [rt.call_function('__', [rt.new_string('Coupon has been removed.'), rt.new_string('woocommerce')])])
	}
	rt.call_function('wc_print_notices', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.update_shipping_method()  {
	rt.call_function('check_ajax_referer', [rt.new_string('update-shipping-method'), rt.new_string('security')])
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'), rt.new_bool(true)])
	mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')])
	mut var_posted_shipping_methods := if rt.get_superglobal('_POST').array_isset(rt.new_string('shipping_method')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('shipping_method')])]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(var_posted_shipping_methods.dup().is_array())) {
		{
			mut iter_1 := var_posted_shipping_methods.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_i := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_string()))))) {
					continue
				}
				var_chosen_shipping_methods.array_set(var_i, var_value.dup())
			}
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('chosen_shipping_methods'), var_chosen_shipping_methods.dup()])
	Class_WC_AJAX.get_cart_totals()
}

fn Class_WC_AJAX.get_cart_totals()  {
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WOOCOMMERCE_CART'), rt.new_bool(true)])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'calculate_totals', []rt.PhpVal{})
	rt.call_function('woocommerce_cart_totals', []rt.PhpVal{})
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_AJAX.update_order_review_expired()  {
	
}

fn Class_WC_AJAX.update_order_review()  {
}

fn Class_WC_AJAX.add_to_cart()  {
}

fn Class_WC_AJAX.remove_from_cart()  {
}

fn Class_WC_AJAX.checkout()  {
}

fn Class_WC_AJAX.get_variation()  {
}

fn Class_WC_AJAX.get_customer_location()  {
}

fn Class_WC_AJAX.feature_product()  {
}

fn Class_WC_AJAX.mark_order_status()  {
}

fn Class_WC_AJAX.get_order_details()  {
}

fn Class_WC_AJAX.add_attribute()  {
}

fn Class_WC_AJAX.add_new_attribute()  {
}

fn Class_WC_AJAX.remove_variations()  {
}

fn Class_WC_AJAX.save_attributes()  {
	mut var_data := rt.new_null()
}

fn Class_WC_AJAX.add_attributes_and_variations()  {
	mut var_data := rt.new_null()
}

fn Class_WC_AJAX.create_product_with_attributes(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.create_all_product_variations(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn Class_WC_AJAX.add_variation()  {
}

fn Class_WC_AJAX.link_all_variations()  {
}

fn Class_WC_AJAX.revoke_access_to_download()  {
}

fn Class_WC_AJAX.grant_access_to_download()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_AJAX.get_customer_details()  {
}

fn Class_WC_AJAX.add_order_item()  {
}

fn Class_WC_AJAX.maybe_add_order_item(var_order_id rt.PhpVal, var_items rt.PhpVal, var_items_to_add rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	mut var_items_mutated := var_items
	mut var_items_to_add_mutated := var_items_to_add
	return rt.new_null()
}

fn Class_WC_AJAX.add_order_fee()  {
}

fn Class_WC_AJAX.add_order_shipping()  {
}

fn Class_WC_AJAX.add_order_tax()  {
}

fn Class_WC_AJAX.add_coupon_discount()  {
}

fn Class_WC_AJAX.remove_order_coupon()  {
}

fn Class_WC_AJAX.remove_order_item()  {
}

fn Class_WC_AJAX.remove_order_tax()  {
}

fn Class_WC_AJAX.calc_line_taxes()  {
}

fn Class_WC_AJAX.save_order_items()  {
}

fn Class_WC_AJAX.load_order_items()  {
}

fn Class_WC_AJAX.add_order_note()  {
}

fn Class_WC_AJAX.delete_order_note()  {
}

fn Class_WC_AJAX.json_search_products(term string, include_variations bool)  {
	mut term_mutated := term
}

fn Class_WC_AJAX.json_search_products_and_variations()  {
}

fn Class_WC_AJAX.json_search_downloadable_products_and_variations()  {
}

fn Class_WC_AJAX.json_search_customers()  {
}

fn Class_WC_AJAX.json_search_categories()  {
}

fn Class_WC_AJAX.json_search_categories_tree()  {
}

fn Class_WC_AJAX.json_search_taxonomy_terms()  {
}

fn Class_WC_AJAX.json_search_product_attributes()  {
}

fn Class_WC_AJAX.json_search_pages()  {
}

fn Class_WC_AJAX.term_ordering()  {
}

fn Class_WC_AJAX.product_ordering()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_AJAX.refund_line_items()  {
}

fn Class_WC_AJAX.delete_refund()  {
}

fn Class_WC_AJAX.rated()  {
}

fn Class_WC_AJAX.update_api_key()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_AJAX.load_variations()  {
}

fn Class_WC_AJAX.save_variations()  {
}

fn Class_WC_AJAX.variation_bulk_action_toggle_enabled(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_toggle_downloadable(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_toggle_virtual(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_toggle_manage_stock(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_instock(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_outofstock(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock_status_onbackorder(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_stock(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_low_stock_amount(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_weight(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_length(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_width(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_height(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_download_limit(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_download_expiry(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_delete_all(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_schedule(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price_increase(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_regular_price_decrease(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price_increase(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_sale_price_decrease(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_action_variable_unset_cogs_value(var_variations rt.PhpVal, var_data rt.PhpVal)  {
	mut var_variations_mutated := var_variations
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.variation_bulk_adjust_price(var_variations rt.PhpVal, var_field rt.PhpVal, var_operator rt.PhpVal, var_value rt.PhpVal)  {
	mut var_variations_mutated := var_variations
}

fn Class_WC_AJAX.variation_bulk_set(var_variations rt.PhpVal, var_field rt.PhpVal, var_value rt.PhpVal)  {
	mut var_variations_mutated := var_variations
}

fn Class_WC_AJAX.variation_bulk_toggle(var_variations rt.PhpVal, var_field rt.PhpVal)  {
	mut var_variations_mutated := var_variations
}

fn Class_WC_AJAX.bulk_edit_variations()  {
}

fn Class_WC_AJAX.tax_rates_save_changes()  {
}

fn Class_WC_AJAX.shipping_zones_save_changes()  {
}

fn Class_WC_AJAX.shipping_zone_add_method()  {
}

fn Class_WC_AJAX.shipping_zone_remove_method()  {
}

fn Class_WC_AJAX.shipping_zone_methods_save_changes()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_AJAX.shipping_zone_methods_save_settings()  {
}

fn Class_WC_AJAX.shipping_classes_save_changes()  {
}

fn Class_WC_AJAX.shipping_providers_save_changes()  {
}

fn Class_WC_AJAX.is_shipping_provider_in_use(provider_slug string) bool {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_AJAX.toggle_gateway_enabled()  {
	mut var_queries := map[string]rt.PhpVal{}
}

fn Class_WC_AJAX.load_status_widget()  {
}

fn Class_WC_AJAX.load_recent_reviews_widget()  {
}

fn Class_WC_AJAX.order_add_meta()  {
}

fn Class_WC_AJAX.order_delete_meta()  {
}

fn Class_WC_AJAX.json_search_order_metakeys()  {
}

fn Class_WC_AJAX.order_refresh_lock(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.check_locked_orders(var_response rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
}

fn Class_WC_AJAX.render_variation_html(mut var_product_object Class_WC_Product, mut var_variation_object Class_WC_Product, var_loop rt.PhpVal, mut var_base_cost Class_?float)  {
	mut var_product_object_mutated := var_product_object
	mut var_variation_object_mutated := var_variation_object
	mut var_loop_mutated := var_loop
	mut var_base_cost_mutated := var_base_cost
}

fn Class_WC_AJAX.base_cost_or_null(mut var_product_object Class_WC_Product) f64 {
	mut var_product_object_mutated := var_product_object
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

fn create_wc_ajax() &Class_WC_AJAX {
	mut obj := &Class_WC_AJAX{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon() &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
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
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_ajax_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
