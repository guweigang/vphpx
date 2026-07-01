import rt

struct Class_WC_Query {
	rt.PhpObjectBase
pub mut:
		query_vars rt.PhpVal = rt.new_array()
		product_query rt.PhpVal = rt.new_null()
		chosen_attributes rt.PhpVal = rt.new_null()
		filterer rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Query) construct()  {
	this.filterer = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer.class()])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_endpoints' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_errors' }]), rt.new_int(20)])
		rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_vars' }]), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('parse_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'parse_request' }]), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'pre_get_posts' }])])
		rt.call_function('add_filter', [rt.new_string('get_pagenum_link'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_add_to_cart_pagination' }]), rt.new_int(10), rt.new_int(1)])
	}
	this.init_query_vars()
}

fn Class_WC_Query.reset_chosen_attributes()  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Query) get_errors()  {
	mut var_error := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wc_error'))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wc_error')])]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(var_error) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_has_notice', [var_error.dup(), rt.new_string('error')]))))))) {
		rt.call_function('wc_add_notice', [var_error.dup(), rt.new_string('error')])
	}
}

fn (mut this Class_WC_Query) init_query_vars()  {
	this.query_vars = rt.create_array([rt.ArrayItem{ key: 'order-pay', val: rt.call_function('get_option', [rt.new_string('woocommerce_checkout_pay_endpoint'), rt.new_string('order-pay')]) }, rt.ArrayItem{ key: 'order-received', val: rt.call_function('get_option', [rt.new_string('woocommerce_checkout_order_received_endpoint'), rt.new_string('order-received')]) }, rt.ArrayItem{ key: 'orders', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_orders_endpoint'), rt.new_string('orders')]) }, rt.ArrayItem{ key: 'view-order', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_view_order_endpoint'), rt.new_string('view-order')]) }, rt.ArrayItem{ key: 'downloads', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_downloads_endpoint'), rt.new_string('downloads')]) }, rt.ArrayItem{ key: 'edit-account', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_edit_account_endpoint'), rt.new_string('edit-account')]) }, rt.ArrayItem{ key: 'edit-address', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_edit_address_endpoint'), rt.new_string('edit-address')]) }, rt.ArrayItem{ key: 'payment-methods', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_payment_methods_endpoint'), rt.new_string('payment-methods')]) }, rt.ArrayItem{ key: 'lost-password', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_lost_password_endpoint'), rt.new_string('lost-password')]) }, rt.ArrayItem{ key: 'customer-logout', val: rt.call_function('get_option', [rt.new_string('woocommerce_logout_endpoint'), rt.new_string('customer-logout')]) }, rt.ArrayItem{ key: 'add-payment-method', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_add_payment_method_endpoint'), rt.new_string('add-payment-method')]) }, rt.ArrayItem{ key: 'delete-payment-method', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_delete_payment_method_endpoint'), rt.new_string('delete-payment-method')]) }, rt.ArrayItem{ key: 'set-default-payment-method', val: rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_set_default_payment_method_endpoint'), rt.new_string('set-default-payment-method')]) }])
}

fn (mut this Class_WC_Query) get_endpoint_title(var_endpoint rt.PhpVal, action string) rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut switch_val_1 := var_endpoint
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-pay'))) {
		mut var_title := rt.call_function('__', [rt.new_string('Pay for order'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-received'))) {
		var_title = rt.call_function('__', [rt.new_string('Order received'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('orders'))) {
		if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('orders'))) {
			var_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Orders (page %d)'), rt.new_string('woocommerce')]), rt.new_int(rt.get_property(var_wp, 'query_vars').array_get('orders').to_i64())])
		} else {
			var_title = rt.call_function('__', [rt.new_string('Orders'), rt.new_string('woocommerce')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('view-order'))) {
		mut var_order := rt.call_function('wc_get_order', [rt.get_property(var_wp, 'query_vars').array_get('view-order')])
		var_title = if rt.is_true(var_order) { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order #%s'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('downloads'))) {
		var_title = rt.call_function('__', [rt.new_string('Downloads'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-account'))) {
		var_title = rt.call_function('__', [rt.new_string('Account details'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-address'))) {
		var_title = rt.call_function('__', [rt.new_string('Addresses'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('payment-methods'))) {
		var_title = rt.call_function('__', [rt.new_string('Payment methods'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-payment-method'))) {
		var_title = rt.call_function('__', [rt.new_string('Add payment method'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('lost-password'))) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string(action), rt.create_array([rt.ArrayItem{ key: none, val: 'rp' }, rt.ArrayItem{ key: none, val: 'resetpass' }, rt.ArrayItem{ key: none, val: 'newaccount' }]), rt.new_bool(true)])) {
			var_title = rt.call_function('__', [rt.new_string('Set password'), rt.new_string('woocommerce')])
		} else {
			var_title = rt.call_function('__', [rt.new_string('Lost password'), rt.new_string('woocommerce')])
		}
	} else {
		var_title = rt.new_string(rt.new_string(''))
	}
	return rt.call_function('apply_filters', ['woocommerce_endpoint_' + (var_endpoint).str() + '_title', var_title.dup(), var_endpoint.dup(), rt.new_string(action)])
}

fn (mut this Class_WC_Query) get_endpoints_mask() i64 {
	if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) {
		mut var_page_on_front := rt.call_function('get_option', [rt.new_string('page_on_front')])
		mut var_myaccount_page_id := rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_page_id')])
		mut var_checkout_page_id := rt.call_function('get_option', [rt.new_string('woocommerce_checkout_page_id')])
		if rt.is_true(rt.call_function('in_array', [var_page_on_front.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_myaccount_page_id }, rt.ArrayItem{ key: none, val: var_checkout_page_id }]), rt.new_bool(true)])) {
			return rt.bitwise_or(rt.get_constant('EP_ROOT'), rt.get_constant('EP_PAGES'))
		}
	}
	return (rt.get_constant('EP_PAGES')).to_i64()
}

fn (mut this Class_WC_Query) add_endpoints()  {
	mut var_mask := rt.new_int(this.get_endpoints_mask())
	{
		mut iter_1 := this.get_query_vars().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_var := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_var)) {
				rt.call_function('add_rewrite_endpoint', [var_var.dup(), var_mask.dup()])
			}
		}
	}
}

fn (mut this Class_WC_Query) add_query_vars(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	{
		mut iter_1 := this.get_query_vars().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_var := item_1.val
			mut var_key := item_1.key
			var_vars_mutated.array_push(var_key.dup())
		}
	}
	return var_vars_mutated.dup()
}

fn (mut this Class_WC_Query) get_query_vars() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_query_vars'), this.query_vars])
}

fn (mut this Class_WC_Query) get_current_endpoint() string {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := this.get_query_vars().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.get_property(var_wp, 'query_vars').array_isset(var_key) {
				return (var_key).str()
			}
		}
	}
	return ''
}

fn (mut this Class_WC_Query) parse_request()  {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := this.get_query_vars().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_var := item_1.val
			mut var_key := item_1.key
			if rt.get_superglobal('_GET').array_isset(var_var) {
				rt.get_property(var_wp, 'query_vars').array_set(var_key, rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_var)])]))
			} else if rt.get_property(var_wp, 'query_vars').array_isset(var_var) {
				rt.get_property(var_wp, 'query_vars').array_set(var_key, rt.get_property(var_wp, 'query_vars').array_get(var_var))
			}
		}
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Query) is_showing_page_on_front(var_q rt.PhpVal) bool {
	mut var_q_mutated := var_q
	return rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_q_mutated, 'is_home', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_q_mutated, 'is_posts_page'))))))) && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
}

fn (mut this Class_WC_Query) page_on_front_is(var_page_id rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('page_on_front')])]), rt.call_function('absint', [var_page_id.dup()]))
}

fn (mut this Class_WC_Query) filter_out_valid_front_page_query_vars(var_query rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(this.is_query_var_valid_on_front_page(var_key.dup())))
	}
	return rt.call_function('array_filter', [var_query.dup(), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
}

fn (mut this Class_WC_Query) is_query_var_valid_on_front_page(var_query_var rt.PhpVal) bool {
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_query_var.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'preview' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paged' }, rt.ArrayItem{ key: none, val: 'cpage' }, rt.ArrayItem{ key: none, val: 'orderby' }]), rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [var_query_var.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'min_price' }, rt.ArrayItem{ key: none, val: 'max_price' }, rt.ArrayItem{ key: none, val: 'rating_filter' }]), rt.new_bool(true)])))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_query_var.dup(), rt.new_string('filter_')]))))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_query_var.dup(), rt.new_string('query_type_')])))
}

fn (mut this Class_WC_Query) pre_get_posts(var_q rt.PhpVal)  {
	mut var_wp_post_types := rt.new_null()
	mut var_q_mutated := var_q
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_main_query', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if this.is_showing_page_on_front(var_q_mutated.dup()) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.page_on_front_is(rt.call_method(var_q_mutated, 'get', [rt.new_string('page_id')])))))) {
			mut var__query := rt.call_function('wp_parse_args', [rt.get_property(var_q_mutated, 'query')])
			if rt.is_true(rt.new_bool(!(!rt.is_true(var__query)) && rt.is_true(rt.call_function('array_intersect', [rt.func_array_keys(var__query.dup()), rt.func_array_keys(this.get_query_vars())])))) {
				rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
				rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
				rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
				rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'), // unsupported expression: Expr_Cast_Int])
				rt.call_function('add_filter', [rt.new_string('redirect_canonical'), rt.new_string('__return_false')])
			}
		}
		if rt.is_true(this.page_on_front_is(rt.call_function('wc_get_page_id', [rt.new_string('shop')]))) {
			var__query = this.filter_out_valid_front_page_query_vars(rt.call_function('wp_parse_args', [rt.get_property(var_q_mutated, 'query')]))
			if !rt.is_true(var__query) {
				rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'), // unsupported expression: Expr_Cast_Int])
				rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
				rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
				if rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse', []rt.PhpVal{})) {
					rt.call_method(var_q_mutated, 'set', [rt.new_string('post_type'), rt.new_string('product')])
				} else {
					rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
				}
			}
		} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get('orderby'))) {
			rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'), // unsupported expression: Expr_Cast_Int])
			rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
			rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
			rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_q_mutated, 'is_feed', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_q_mutated, 'is_post_type_archive', [rt.new_string('product')])))) {
		rt.set_property(var_q_mutated, 'is_comment_feed', rt.new_bool(false))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_q_mutated, 'is_page', []rt.PhpVal{})))) && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))))) && rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_q_mutated, 'get', [rt.new_string('page_id')])]), rt.call_function('wc_get_page_id', [rt.new_string('shop')]))))) {
		rt.call_method(var_q_mutated, 'set', [rt.new_string('post_type'), rt.new_string('product')])
		rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'), rt.new_string('')])
		if rt.get_property(var_q_mutated, 'query').array_isset(rt.new_string('paged')) {
			rt.call_method(var_q_mutated, 'set', [rt.new_string('paged'), rt.get_property(var_q_mutated, 'query').array_get('paged')])
		}
		rt.call_function('wc_maybe_define_constant', [rt.new_string('SHOP_IS_ON_FRONT'), rt.new_bool(true)])
		// unsupported statement: Stmt_Global
		mut var_shop_page := rt.call_function('get_post', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])
		rt.set_property(var_wp_post_types.array_get('product'), 'ID', rt.get_property(var_shop_page, 'ID'))
		rt.set_property(var_wp_post_types.array_get('product'), 'post_title', rt.get_property(var_shop_page, 'post_title'))
		rt.set_property(var_wp_post_types.array_get('product'), 'post_name', rt.get_property(var_shop_page, 'post_name'))
		rt.set_property(var_wp_post_types.array_get('product'), 'post_type', rt.get_property(var_shop_page, 'post_type'))
		rt.set_property(var_wp_post_types.array_get('product'), 'ancestors', rt.call_function('get_ancestors', [rt.get_property(var_shop_page, 'ID'), rt.get_property(var_shop_page, 'post_type')]))
		rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(false))
		rt.set_property(var_q_mutated, 'is_post_type_archive', rt.new_bool(true))
		rt.set_property(var_q_mutated, 'is_archive', rt.new_bool(true))
		rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
		rt.call_function('add_filter', [rt.new_string('post_type_archive_title'), rt.new_string('__return_empty_string'), rt.new_int(5)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WPSEO_Meta')])) {
			rt.call_function('add_filter', [rt.new_string('wpseo_metadesc'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wpseo_metadesc' }])])
			rt.call_function('add_filter', [rt.new_string('wpseo_metakey'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wpseo_metakey' }])])
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_post_type_archive', [rt.new_string('product')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_tax', [rt.call_function('get_object_taxonomies', [])]))))))) {
		if rt.is_true(rt.call_method(var_q_mutated, 'is_search', []rt.PhpVal{})) {
			mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
			mut var_exclude_term_id := 
			if rt.is_true() {
			}
		}
		return rt.new_null()
	}
	this.product_query(.dup())
}

fn (mut this Class_WC_Query) handle_get_posts(var_posts rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if rt.is_true() {
	}
	
}

fn (mut this Class_WC_Query) prime_thumbnail_caches(var_posts rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Query) remove_product_query_filters(var_posts rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Query) adjust_posts_count(var_count rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Query) get_layered_nav_chosen_attributes_inst() rt.PhpVal {
}

fn (mut this Class_WC_Query) get_current_posts() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WC_Query) wpseo_metadesc() rt.PhpVal {
}

fn (mut this Class_WC_Query) wpseo_metakey() rt.PhpVal {
}

fn (mut this Class_WC_Query) product_query(var_q rt.PhpVal)  {
	mut var_q_mutated := var_q
}

fn (mut this Class_WC_Query) product_query_post_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) remove_product_query()  {
}

fn (mut this Class_WC_Query) remove_ordering_args()  {
}

fn (mut this Class_WC_Query) has_positive_search_terms() bool {
	mut var_term := rt.new_null()
}

fn (mut this Class_WC_Query) get_catalog_ordering_args(orderby string, order string) rt.PhpVal {
	mut orderby_mutated := orderby
	mut order_mutated := order
}

fn (mut this Class_WC_Query) price_filter_post_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) order_by_price_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) order_by_price_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) order_by_popularity_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) order_by_rating_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Query) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_sql_mutated := var_sql
}

fn (mut this Class_WC_Query) get_meta_query(var_meta_query rt.PhpVal, main_query bool) rt.PhpVal {
	mut var_meta_query_mutated := var_meta_query
}

fn (mut this Class_WC_Query) get_tax_query(var_tax_query rt.PhpVal, main_query bool) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
}

fn Class_WC_Query.get_main_query() rt.PhpVal {
}

fn Class_WC_Query.get_main_tax_query() rt.PhpVal {
}

fn Class_WC_Query.get_main_meta_query() rt.PhpVal {
}

fn Class_WC_Query.get_main_search_query_sql() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Query.get_layered_nav_chosen_attributes() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Query) remove_add_to_cart_pagination(var_url rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Query) rating_filter_meta_query() rt.PhpVal {
}

fn (mut this Class_WC_Query) visibility_meta_query(compare string) rt.PhpVal {
}

fn (mut this Class_WC_Query) stock_status_meta_query(var_status rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Query) layered_nav_init()  {
}

fn (mut this Class_WC_Query) get_products_in_view()  {
}

fn (mut this Class_WC_Query) layered_nav_query(var_deprecated rt.PhpVal)  {
}

fn (mut this Class_WC_Query) search_post_excerpt(where string) rt.PhpVal {
}

fn (mut this Class_WC_Query) remove_posts_where()  {
}

fn create_wc_query() &Class_WC_Query {
	mut obj := &Class_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query_vars: rt.new_array()
		product_query: rt.new_null()
		chosen_attributes: rt.new_null()
		filterer: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'reset_chosen_attributes' {
			Class_WC_Query.reset_chosen_attributes()
			return rt.new_null()
		}
		'get_errors' {
			this.get_errors()
			return rt.new_null()
		}
		'init_query_vars' {
			this.init_query_vars()
			return rt.new_null()
		}
		'get_endpoint_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_endpoint_title(dispatch_arg_0, dispatch_arg_1)
		}
		'get_endpoints_mask' {
			return rt.new_int(this.get_endpoints_mask())
		}
		'add_endpoints' {
			this.add_endpoints()
			return rt.new_null()
		}
		'add_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_query_vars(dispatch_arg_0)
		}
		'get_query_vars' {
			return this.get_query_vars()
		}
		'get_current_endpoint' {
			return rt.new_string(this.get_current_endpoint())
		}
		'parse_request' {
			this.parse_request()
			return rt.new_null()
		}
		'is_showing_page_on_front' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_showing_page_on_front(dispatch_arg_0))
		}
		'page_on_front_is' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.page_on_front_is(dispatch_arg_0)
		}
		'filter_out_valid_front_page_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_out_valid_front_page_query_vars(dispatch_arg_0)
		}
		'is_query_var_valid_on_front_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_query_var_valid_on_front_page(dispatch_arg_0))
		}
		'pre_get_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pre_get_posts(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_get_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.handle_get_posts(dispatch_arg_0, dispatch_arg_1)
		}
		'prime_thumbnail_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prime_thumbnail_caches(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_product_query_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_product_query_filters(dispatch_arg_0)
		}
		'adjust_posts_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.adjust_posts_count(dispatch_arg_0, dispatch_arg_1)
		}
		'get_layered_nav_chosen_attributes_inst' {
			return this.get_layered_nav_chosen_attributes_inst()
		}
		'get_current_posts' {
			return this.get_current_posts()
		}
		'wpseo_metadesc' {
			return this.wpseo_metadesc()
		}
		'wpseo_metakey' {
			return this.wpseo_metakey()
		}
		'product_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.product_query(dispatch_arg_0)
			return rt.new_null()
		}
		'product_query_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.product_query_post_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_product_query' {
			this.remove_product_query()
			return rt.new_null()
		}
		'remove_ordering_args' {
			this.remove_ordering_args()
			return rt.new_null()
		}
		'has_positive_search_terms' {
			return rt.new_bool(this.has_positive_search_terms())
		}
		'get_catalog_ordering_args' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_catalog_ordering_args(dispatch_arg_0, dispatch_arg_1)
		}
		'price_filter_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.price_filter_post_clauses(dispatch_arg_0, dispatch_arg_1)
		}
		'order_by_price_asc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_price_asc_post_clauses(dispatch_arg_0)
		}
		'order_by_price_desc_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_price_desc_post_clauses(dispatch_arg_0)
		}
		'order_by_popularity_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_popularity_post_clauses(dispatch_arg_0)
		}
		'order_by_rating_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.order_by_rating_post_clauses(dispatch_arg_0)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_product_sorting_table_join(dispatch_arg_0)
		}
		'get_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_meta_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tax_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_tax_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_main_query' {
			return Class_WC_Query.get_main_query()
		}
		'get_main_tax_query' {
			return Class_WC_Query.get_main_tax_query()
		}
		'get_main_meta_query' {
			return Class_WC_Query.get_main_meta_query()
		}
		'get_main_search_query_sql' {
			return Class_WC_Query.get_main_search_query_sql()
		}
		'get_layered_nav_chosen_attributes' {
			return Class_WC_Query.get_layered_nav_chosen_attributes()
		}
		'remove_add_to_cart_pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_add_to_cart_pagination(dispatch_arg_0)
		}
		'rating_filter_meta_query' {
			return this.rating_filter_meta_query()
		}
		'visibility_meta_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.visibility_meta_query(dispatch_arg_0)
		}
		'stock_status_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.stock_status_meta_query(dispatch_arg_0)
		}
		'layered_nav_init' {
			this.layered_nav_init()
			return rt.new_null()
		}
		'get_products_in_view' {
			this.get_products_in_view()
			return rt.new_null()
		}
		'layered_nav_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.layered_nav_query(dispatch_arg_0)
			return rt.new_null()
		}
		'search_post_excerpt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.search_post_excerpt(dispatch_arg_0)
		}
		'remove_posts_where' {
			this.remove_posts_where()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_vars' { return this.query_vars }
		'product_query' { return this.product_query }
		'chosen_attributes' { return this.chosen_attributes }
		'filterer' { return this.filterer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_vars' { this.query_vars = val; return true }
		'product_query' { this.product_query = val; return true }
		'chosen_attributes' { this.chosen_attributes = val; return true }
		'filterer' { this.filterer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('WC_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_query()
		return rt.new_object('WC_Query', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_query_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
