import rt

struct Class_WC_Query {
	rt.PhpObjectBase
pub mut:
	query_vars rt.PhpVal = rt.new_array()
	filterer   rt.PhpVal = rt.new_null()
}

fn init_static_wc_query() {
	rt.init_static_prop('WC_Query', 'product_query', rt.new_null())
	rt.init_static_prop('WC_Query', 'chosen_attributes', rt.new_null())
}

fn (mut this Class_WC_Query) construct() {
	this.filterer = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer.class(),
	])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_endpoints' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('wp_loaded'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_errors' },
			]),
			rt.new_int(20)])
		rt.call_function('add_filter', [rt.new_string('query_vars'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_query_vars' },
			]),
			rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('parse_request'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'parse_request' },
			]),
			rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('pre_get_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'pre_get_posts' },
			])])
		rt.call_function('add_filter', [rt.new_string('get_pagenum_link'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'remove_add_to_cart_pagination' },
			]),
			rt.new_int(10), rt.new_int(1)])
	}
	this.init_query_vars()
}

fn Class_WC_Query.reset_chosen_attributes() {
	rt.set_static_prop('WC_Query', 'chosen_attributes', rt.new_null())
}

fn (mut this Class_WC_Query) get_errors() {
	mut var_error := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wc_error')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('wc_error'))]),
		]) } else { rt.new_string('') }
	if rt.is_true(var_error)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_has_notice', [var_error.clone(), rt.new_string('error')]))))) {
		rt.call_function('wc_add_notice', [var_error.clone(),
			rt.new_string('error')])
	}
}

fn (mut this Class_WC_Query) init_query_vars() {
	this.query_vars = rt.create_array([
		rt.ArrayItem{ key: 'order-pay', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_checkout_pay_endpoint'),
			rt.new_string('order-pay'),
		]) },
		rt.ArrayItem{ key: 'order-received', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_checkout_order_received_endpoint'),
			rt.new_string('order-received'),
		]) },
		rt.ArrayItem{ key: 'orders', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_orders_endpoint'),
			rt.new_string('orders'),
		]) },
		rt.ArrayItem{ key: 'view-order', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_view_order_endpoint'),
			rt.new_string('view-order'),
		]) },
		rt.ArrayItem{ key: 'downloads', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_downloads_endpoint'),
			rt.new_string('downloads'),
		]) },
		rt.ArrayItem{ key: 'edit-account', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_edit_account_endpoint'),
			rt.new_string('edit-account'),
		]) },
		rt.ArrayItem{ key: 'edit-address', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_edit_address_endpoint'),
			rt.new_string('edit-address'),
		]) },
		rt.ArrayItem{ key: 'payment-methods', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_payment_methods_endpoint'),
			rt.new_string('payment-methods'),
		]) },
		rt.ArrayItem{ key: 'lost-password', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_lost_password_endpoint'),
			rt.new_string('lost-password'),
		]) },
		rt.ArrayItem{ key: 'customer-logout', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_logout_endpoint'),
			rt.new_string('customer-logout'),
		]) },
		rt.ArrayItem{ key: 'add-payment-method', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_add_payment_method_endpoint'),
			rt.new_string('add-payment-method'),
		]) },
		rt.ArrayItem{ key: 'delete-payment-method', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_delete_payment_method_endpoint'),
			rt.new_string('delete-payment-method'),
		]) },
		rt.ArrayItem{ key: 'set-default-payment-method', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_set_default_payment_method_endpoint'),
			rt.new_string('set-default-payment-method'),
		]) },
	])
}

fn (mut this Class_WC_Query) get_endpoint_title(var_endpoint rt.PhpVal, action string) rt.PhpVal {
	mut var_wp := rt.new_null()
	mut switch_val_1 := var_endpoint
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-pay'))) {
		mut var_title := rt.call_function('__', [rt.new_string('Pay for order'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-received'))) {
		var_title = rt.call_function('__', [rt.new_string('Order received'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('orders'))) {
		if !(!rt.is_true(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('orders')))) {
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Orders (page %d)'),
					rt.new_string('woocommerce')]),
				rt.new_int(rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('orders')).to_i64()),
			])
		} else {
			var_title = rt.call_function('__', [rt.new_string('Orders'),
				rt.new_string('woocommerce')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('view-order'))) {
		mut var_order := rt.call_function('wc_get_order', [
			rt.get_property(var_wp, 'query_vars').array_get(rt.new_string('view-order')),
		])
		var_title = if rt.is_true(var_order) { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Order #%s'),
					rt.new_string('woocommerce')]),
				rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('downloads'))) {
		var_title = rt.call_function('__', [rt.new_string('Downloads'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-account'))) {
		var_title = rt.call_function('__', [rt.new_string('Account details'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit-address'))) {
		var_title = rt.call_function('__', [rt.new_string('Addresses'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('payment-methods'))) {
		var_title = rt.call_function('__', [rt.new_string('Payment methods'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-payment-method'))) {
		var_title = rt.call_function('__', [rt.new_string('Add payment method'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('lost-password'))) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string(action),
			rt.create_array([rt.ArrayItem{ key: none, val: 'rp' },
				rt.ArrayItem{ key: none, val: 'resetpass' }, rt.ArrayItem{
					key: none
					val: 'newaccount'
				}]),
			rt.new_bool(true)]))
		{
			var_title = rt.call_function('__', [rt.new_string('Set password'),
				rt.new_string('woocommerce')])
		} else {
			var_title = rt.call_function('__', [rt.new_string('Lost password'),
				rt.new_string('woocommerce')])
		}
	} else {
		var_title = rt.new_string('')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_endpoint_' + var_endpoint.str() + '_title'),
		var_title.clone(),
		var_endpoint.clone(),
		rt.new_string(action),
	])
}

fn (mut this Class_WC_Query) get_endpoints_mask() i64 {
	if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [
		rt.new_string('show_on_front'),
	])))
	{
		mut var_page_on_front := rt.call_function('get_option', [
			rt.new_string('page_on_front'),
		])
		mut var_myaccount_page_id := rt.call_function('get_option', [
			rt.new_string('woocommerce_myaccount_page_id'),
		])
		mut var_checkout_page_id := rt.call_function('get_option', [
			rt.new_string('woocommerce_checkout_page_id'),
		])
		if rt.is_true(rt.call_function('in_array', [var_page_on_front.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_myaccount_page_id },
				rt.ArrayItem{ key: none, val: var_checkout_page_id }]),
			rt.new_bool(true)]))
		{
			return rt.bitwise_or(rt.get_constant('EP_ROOT'), rt.get_constant('EP_PAGES'))
		}
	}
	return (rt.get_constant('EP_PAGES')).to_i64()
}

fn (mut this Class_WC_Query) add_endpoints() {
	mut var_mask := rt.new_int(this.get_endpoints_mask())
	mut iter_1 := this.get_query_vars().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_var := item_1.val
		mut var_key := item_1.key
		if !(!rt.is_true(var_var)) {
			rt.call_function('add_rewrite_endpoint', [var_var.clone(),
				var_mask.clone()])
		}
	}
}

fn (mut this Class_WC_Query) add_query_vars(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	mut iter_2 := this.get_query_vars().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_var := item_2.val
		mut var_key := item_2.key
		var_vars_mutated.array_push(var_key.clone())
	}
	return var_vars_mutated.clone()
}

fn (mut this Class_WC_Query) get_query_vars() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_query_vars'),
		this.query_vars,
	])
}

fn (mut this Class_WC_Query) get_current_endpoint() string {
	mut var_wp := rt.new_null()
	mut iter_3 := this.get_query_vars().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if rt.get_property(var_wp, 'query_vars').array_isset(var_key) {
			return var_key.str()
		}
	}
	return ''
}

fn (mut this Class_WC_Query) parse_request() {
	mut var_wp := rt.new_null()
	mut iter_4 := this.get_query_vars().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_var := item_4.val
		mut var_key := item_4.key
		if rt.get_superglobal('_GET').array_isset(var_var) {
			rt.get_property(var_wp, 'query_vars').array_set(var_key, rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_var)]),
			]))
		} else if rt.get_property(var_wp, 'query_vars').array_isset(var_var) {
			rt.get_property(var_wp, 'query_vars').array_set(var_key, rt.get_property(var_wp,
				'query_vars').array_get(var_var))
		}
	}
}

fn (mut this Class_WC_Query) is_showing_page_on_front(var_q rt.PhpVal) bool {
	mut var_q_mutated := var_q
	return rt.is_true(rt.call_method(var_q_mutated, 'is_home', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_q_mutated, 'is_posts_page')))))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
}

fn (mut this Class_WC_Query) page_on_front_is(var_page_id rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_function('absint', [
		rt.call_function('get_option', [rt.new_string('page_on_front')]),
	]), rt.call_function('absint', [var_page_id.clone()]))
}

fn (mut this Class_WC_Query) filter_out_valid_front_page_query_vars(var_query rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(this.is_query_var_valid_on_front_page(var_key.clone())))
	}
	return rt.call_function('array_filter', [var_query.clone(),
		rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
}

fn (mut this Class_WC_Query) is_query_var_valid_on_front_page(var_query_var rt.PhpVal) bool {
	return
		rt.is_true(rt.call_function('in_array', [var_query_var.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'preview'
	}, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paged' }, rt.ArrayItem{
		key: none
		val: 'cpage'
	}, rt.ArrayItem{ key: none, val: 'orderby' }]), rt.new_bool(true)]))
		|| rt.is_true(rt.call_function('in_array', [var_query_var.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'min_price'
	}, rt.ArrayItem{ key: none, val: 'max_price' }, rt.ArrayItem{ key: none, val: 'rating_filter' }]), rt.new_bool(true)]))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_query_var.clone(), rt.new_string('filter_')])))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_query_var.clone(), rt.new_string('query_type_')])))
}

fn (mut this Class_WC_Query) pre_get_posts(var_q rt.PhpVal) {
	mut var_wp_post_types := rt.new_null()
	mut var_q_mutated := var_q
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_main_query',
		[]rt.PhpVal{})))))
	{
		return
	}
	if this.is_showing_page_on_front(var_q_mutated.clone()) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.page_on_front_is(rt.call_method(var_q_mutated,
			'get', [rt.new_string('page_id')]))))))
		{
			mut var__query := rt.call_function('wp_parse_args', [
				rt.get_property(var_q_mutated, 'query'),
			])
			if !(!rt.is_true(var__query))
				&& rt.is_true(rt.call_function('array_intersect', [rt.func_array_keys(var__query.clone()), rt.func_array_keys(this.get_query_vars())])) {
				rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
				rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
				rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
				rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'),
					rt.new_int((rt.call_function('get_option', [
						rt.new_string('page_on_front'),
					])).to_i64())])
				rt.call_function('add_filter', [rt.new_string('redirect_canonical'),
					rt.new_string('__return_false')])
			}
		}
		if rt.is_true(this.page_on_front_is(rt.call_function('wc_get_page_id', [
			rt.new_string('shop'),
		])))
		{
			var__query = this.filter_out_valid_front_page_query_vars(rt.call_function('wp_parse_args', [
				rt.get_property(var_q_mutated, 'query'),
			]))
			if !rt.is_true(var__query) {
				rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'),
					rt.new_int((rt.call_function('get_option', [
						rt.new_string('page_on_front'),
					])).to_i64())])
				rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
				rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
				if rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse',
					[]rt.PhpVal{}))
				{
					rt.call_method(var_q_mutated, 'set', [rt.new_string('post_type'),
						rt.new_string('product')])
				} else {
					rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
				}
			}
		} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('orderby')))) {
			rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'),
				rt.new_int((rt.call_function('get_option', [
					rt.new_string('page_on_front'),
				])).to_i64())])
			rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
			rt.set_property(var_q_mutated, 'is_home', rt.new_bool(false))
			rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(true))
		}
	}
	if rt.is_true(rt.call_method(var_q_mutated, 'is_feed', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_q_mutated, 'is_post_type_archive', [rt.new_string('product')])) {
		rt.set_property(var_q_mutated, 'is_comment_feed', rt.new_bool(false))
	}
	if rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_q_mutated, 'is_page', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
		&& rt.is_true(rt.identical(rt.call_function('absint', [rt.call_method(var_q_mutated, 'get', [rt.new_string('page_id')])]), rt.call_function('wc_get_page_id', [rt.new_string('shop')]))) {
		rt.call_method(var_q_mutated, 'set', [rt.new_string('post_type'),
			rt.new_string('product')])
		rt.call_method(var_q_mutated, 'set', [rt.new_string('page_id'),
			rt.new_string('')])
		if rt.get_property(var_q_mutated, 'query').array_isset(rt.new_string('paged')) {
			rt.call_method(var_q_mutated, 'set', [rt.new_string('paged'),
				rt.get_property(var_q_mutated, 'query').array_get(rt.new_string('paged'))])
		}
		rt.call_function('wc_maybe_define_constant', [rt.new_string('SHOP_IS_ON_FRONT'),
			rt.new_bool(true)])
		mut var_shop_page := rt.call_function('get_post', [
			rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
		])
		rt.set_property(var_wp_post_types.array_get(rt.new_string('product')), 'ID', rt.get_property(var_shop_page,
			'ID'))
		rt.set_property(var_wp_post_types.array_get(rt.new_string('product')), 'post_title', rt.get_property(var_shop_page,
			'post_title'))
		rt.set_property(var_wp_post_types.array_get(rt.new_string('product')), 'post_name', rt.get_property(var_shop_page,
			'post_name'))
		rt.set_property(var_wp_post_types.array_get(rt.new_string('product')), 'post_type', rt.get_property(var_shop_page,
			'post_type'))
		rt.set_property(var_wp_post_types.array_get(rt.new_string('product')), 'ancestors', rt.call_function('get_ancestors', [
			rt.get_property(var_shop_page, 'ID'),
			rt.get_property(var_shop_page, 'post_type'),
		]))
		rt.set_property(var_q_mutated, 'is_singular', rt.new_bool(false))
		rt.set_property(var_q_mutated, 'is_post_type_archive', rt.new_bool(true))
		rt.set_property(var_q_mutated, 'is_archive', rt.new_bool(true))
		rt.set_property(var_q_mutated, 'is_page', rt.new_bool(true))
		rt.call_function('add_filter', [rt.new_string('post_type_archive_title'),
			rt.new_string('__return_empty_string'), rt.new_int(5)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WPSEO_Meta')])) {
			rt.call_function('add_filter', [rt.new_string('wpseo_metadesc'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'wpseo_metadesc' },
				])])
			rt.call_function('add_filter', [rt.new_string('wpseo_metakey'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'wpseo_metakey' },
				])])
		}
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_post_type_archive', [rt.new_string('product')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_q_mutated, 'is_tax', [rt.call_function('get_object_taxonomies', [rt.new_string('product')])]))))) {
		if rt.is_true(rt.call_method(var_q_mutated, 'is_search', []rt.PhpVal{})) {
			mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
				[]rt.PhpVal{})
			mut var_exclude_term_id := rt.new_int(if var_product_visibility_terms.array_isset(rt.new_string('exclude-from-search')) {
				rt.new_int((var_product_visibility_terms.array_get(rt.new_string('exclude-from-search'))).to_i64())
			} else {
				0
			})
			if rt.is_true(rt.greater(var_exclude_term_id, rt.new_int(0))) {
				mut var_existing_tax_query := rt.call_method(var_q_mutated, 'get', [
					rt.new_string('tax_query'),
				])
				var_existing_tax_query = if var_existing_tax_query.clone().is_array() {
					var_existing_tax_query
				} else {
					rt.new_array()
				}
				var_existing_tax_query.array_push(rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
					rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
					rt.ArrayItem{ key: 'terms', val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_exclude_term_id },
					]) },
					rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
				]))
				rt.call_method(var_q_mutated, 'set', [rt.new_string('tax_query'),
					var_existing_tax_query.clone()])
			}
		}
		return
	}
	this.product_query(var_q_mutated.clone())
}

fn (mut this Class_WC_Query) handle_get_posts(var_posts rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_query'), rt.call_method(var_query,
		'get', [rt.new_string('wc_query')])))))
	{
		return var_posts.clone()
	}
	this.remove_product_query_filters(var_posts.clone())
	return var_posts.clone()
}

fn (mut this Class_WC_Query) prime_thumbnail_caches(var_posts rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('product_query'), rt.call_method(var_query, 'get', [
		rt.new_string('wc_query'),
	])))
	{
		rt.call_function('update_post_thumbnail_cache', [var_query.clone()])
	}
	return var_posts.clone()
}

fn (mut this Class_WC_Query) remove_product_query_filters(var_posts rt.PhpVal) rt.PhpVal {
	this.remove_ordering_args()
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'price_filter_post_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	return var_posts.clone()
}

fn (mut this Class_WC_Query) adjust_posts_count(var_count rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	return var_count.clone()
}

fn (mut this Class_WC_Query) get_layered_nav_chosen_attributes_inst() rt.PhpVal {
	return Class_WC_Query.get_layered_nav_chosen_attributes()
}

fn (mut this Class_WC_Query) get_current_posts() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	return rt.get_property(var_GLOBALS.array_get(rt.new_string('wp_query')), 'posts')
}

fn (mut this Class_WC_Query) wpseo_metadesc() rt.PhpVal {
	mut iife_temp_1 := Class_WPSEO_Meta{}
	mut iife_result_1 := iife_temp_1.get_value(rt.new_string('metadesc'), rt.call_function('wc_get_page_id', [
		rt.new_string('shop'),
	]))
	return iife_result_1
}

fn (mut this Class_WC_Query) wpseo_metakey() rt.PhpVal {
	mut iife_temp_2 := Class_WPSEO_Meta{}
	mut iife_result_2 := iife_temp_2.get_value(rt.new_string('metakey'), rt.call_function('wc_get_page_id', [
		rt.new_string('shop'),
	]))
	return iife_result_2
}

fn (mut this Class_WC_Query) product_query(var_q rt.PhpVal) {
	mut var_q_mutated := var_q
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))))) {
		mut var_ordering := this.get_catalog_ordering_args('', '')
		rt.call_method(var_q_mutated, 'set', [rt.new_string('orderby'),
			var_ordering.array_get(rt.new_string('orderby'))])
		rt.call_method(var_q_mutated, 'set', [rt.new_string('order'),
			var_ordering.array_get(rt.new_string('order'))])
		if var_ordering.array_isset(rt.new_string('meta_key')) {
			rt.call_method(var_q_mutated, 'set', [rt.new_string('meta_key'),
				var_ordering.array_get(rt.new_string('meta_key'))])
		}
	}
	rt.call_method(var_q_mutated, 'set', [rt.new_string('meta_query'),
		this.get_meta_query(rt.call_method(var_q_mutated, 'get', [
			rt.new_string('meta_query'),
		]), true)])
	rt.call_method(var_q_mutated, 'set', [rt.new_string('tax_query'),
		this.get_tax_query(rt.call_method(var_q_mutated, 'get', [
			rt.new_string('tax_query'),
		]), true)])
	rt.call_method(var_q_mutated, 'set', [rt.new_string('wc_query'),
		rt.new_string('product_query')])
	rt.call_method(var_q_mutated, 'set', [rt.new_string('post__in'),
		rt.call_function('array_unique', [
			rt.cast_array(rt.call_function('apply_filters', [
				rt.new_string('loop_shop_post_in'),
				rt.new_array(),
			])),
		])])
	rt.call_method(var_q_mutated, 'set', [rt.new_string('posts_per_page'), if rt.is_true(rt.call_method(var_q_mutated, 'get', [
		rt.new_string('posts_per_page'),
	]))
	{ rt.call_method(var_q_mutated, 'get', [
			rt.new_string('posts_per_page'),
		]) } else { rt.call_function('apply_filters', [
			rt.new_string('loop_shop_per_page'),
			rt.mul(rt.call_function('wc_get_default_products_per_row', []rt.PhpVal{}), rt.call_function('wc_get_default_product_rows_per_page', []rt.PhpVal{})),
		]) }])
	rt.set_static_prop('WC_Query', 'product_query', var_q_mutated.clone())
	rt.call_function('add_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_query_post_clauses' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('the_posts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_get_posts' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('the_posts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'prime_thumbnail_caches' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_query'),
		var_q_mutated.clone(), rt.new_object('WC_Query', []string{}, &this)])
}

fn (mut this Class_WC_Query) product_query_post_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = this.price_filter_post_clauses(var_args_mutated.clone(),
		var_wp_query.clone())
	var_args_mutated = rt.call_method(this.filterer, 'filter_by_attribute_post_clauses', [
		var_args_mutated.clone(),
		var_wp_query.clone(),
		Class_WC_Query.get_layered_nav_chosen_attributes(),
	])
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) remove_product_query() {
	rt.call_function('remove_action', [rt.new_string('pre_get_posts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'pre_get_posts' },
		])])
}

fn (mut this Class_WC_Query) remove_ordering_args() {
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_by_price_asc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_by_price_desc_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_by_popularity_post_clauses' },
		])])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'order_by_rating_post_clauses' },
		])])
}

fn (mut this Class_WC_Query) has_positive_search_terms() bool {
	mut var_term := rt.new_null()
	mut var_search_string := rt.call_function('get_query_var', [
		rt.new_string('s')])
	var_search_string = rt.new_string((if var_search_string.clone().is_array() {
		''
	} else {
		var_search_string.str().trim_space()
	}).str())
	if rt.is_true(rt.identical(rt.new_string(''), var_search_string)) {
		return false
	}
	mut var_search_query := rt.create_object_dynamically(rt.new_null(), [
		rt.create_array([rt.ArrayItem{ key: 's', val: var_search_string }]),
	])
	mut var_search_terms := if !(rt.get_property(var_search_query, 'query_vars').array_get(rt.new_string('search_terms'))).is_null() {
		rt.get_property(var_search_query, 'query_vars').array_get(rt.new_string('search_terms'))
	} else {
		rt.new_array()
	}
	if !rt.is_true(var_search_terms) {
		return false
	}
	mut var_exclusion_prefix := rt.new_string((rt.call_function('apply_filters', [
		rt.new_string('wp_query_search_exclusion_prefix'),
		rt.new_string('-'),
	])).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_exclusion_prefix)))) {
		closure_4_fn := fn [var_exclusion_prefix] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
				var_term.clone(),
				var_exclusion_prefix.clone(),
			]))))
		}
		var_search_terms = rt.call_function('array_filter', [
			var_search_terms.clone(), rt.new_closure(closure_4_fn)])
	}
	return !(!rt.is_true(var_search_terms))
}

fn (mut this Class_WC_Query) get_catalog_ordering_args(orderby string, order string) rt.PhpVal {
	mut orderby_mutated := orderby
	mut order_mutated := order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(orderby_mutated))))) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
			mut var_orderby_value := rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))]),
			])
			if rt.is_true(rt.new_bool(var_orderby_value.clone().is_array())) {
				var_orderby_value = var_orderby_value.array_get(rt.new_int(0))
			}
		} else {
			var_orderby_value = rt.call_function('wc_clean', [
				rt.call_function('get_query_var', [rt.new_string('orderby')]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_orderby_value)))) {
			if rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))
				&& this.has_positive_search_terms() {
				var_orderby_value = rt.new_string('relevance')
			} else {
				var_orderby_value = rt.call_function('apply_filters', [
					rt.new_string('woocommerce_default_catalog_orderby'),
					rt.call_function('get_option', [
						rt.new_string('woocommerce_default_catalog_orderby'),
						rt.new_string('menu_order'),
					]),
				])
			}
		}
		var_orderby_value = if var_orderby_value.clone().is_array() { var_orderby_value } else { rt.call_function('explode', [
				rt.new_string('-'),
				var_orderby_value.clone(),
			]) }
		orderby_mutated = (rt.call_function('esc_attr',
			[var_orderby_value.array_get(rt.new_int(0))])).str()
		order_mutated = (if !(!rt.is_true(var_orderby_value.array_get(rt.new_int(1)))) {
			var_orderby_value.array_get(rt.new_int(1))
		} else {
			rt.new_string(order_mutated)
		}).str()
	}
	orderby_mutated = if rt.new_string(orderby_mutated).clone().is_array() { (rt.call_function('current', [
			rt.new_string(orderby_mutated).clone(),
		])).str() } else { orderby_mutated }.to_lower()
	orderby_mutated = (rt.call_function('str_replace', [rt.new_string(' id'),
		rt.new_string(' ID'), rt.new_string(orderby_mutated).clone()])).str()
	order_mutated = if rt.new_string(order_mutated).clone().is_array() { (rt.call_function('current', [
			rt.new_string(order_mutated).clone(),
		])).str() } else { order_mutated }.to_upper()
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'orderby', val: orderby_mutated },
		rt.ArrayItem{
			key: 'order'
			val: if rt.is_true(rt.identical(rt.new_string('DESC'), rt.new_string(order_mutated))) {
				'DESC'
			} else {
				'ASC'
			}
		},
		rt.ArrayItem{ key: 'meta_key', val: '' },
	])
	mut switch_val_2 := rt.new_string(orderby_mutated)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('id'))) {
		var_args.array_set('orderby', 'ID')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('menu_order'))) {
		var_args.array_set('orderby', 'menu_order title')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('title'))) {
		var_args.array_set('orderby', 'title')
		var_args.array_set('order', if rt.is_true(rt.identical(rt.new_string('DESC'),
			rt.new_string(order_mutated)))
		{
			'DESC'
		} else {
			'ASC'
		})
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('relevance'))) {
		var_args.array_set('orderby', 'relevance')
		var_args.array_set('order', 'DESC')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('rand'))) {
		var_args.array_set('orderby', 'rand')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('modified')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('date'))) {
		var_args.array_set('orderby', orderby_mutated + ' ID')
		var_args.array_set('order', if rt.is_true(rt.identical(rt.new_string('ASC'),
			rt.new_string(order_mutated)))
		{
			'ASC'
		} else {
			'DESC'
		})
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('price'))) {
		mut var_callback := rt.new_string((if rt.is_true(rt.identical(rt.new_string('DESC'),
			rt.new_string(order_mutated)))
		{
			'order_by_price_desc_post_clauses'
		} else {
			'order_by_price_asc_post_clauses'
		}).str())
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: var_callback },
			])])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('popularity'))) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'order_by_popularity_post_clauses' },
			])])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('rating'))) {
		rt.call_function('add_filter', [rt.new_string('posts_clauses'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Query', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'order_by_rating_post_clauses' },
			])])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_catalog_ordering_args'),
		var_args.clone(),
		rt.new_string(orderby_mutated).clone(),
		rt.new_string(order_mutated).clone(),
	])
}

fn (mut this Class_WC_Query) price_filter_post_clauses(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_enable_filtering := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_enable_post_clause_filtering'),
		rt.call_method(var_wp_query, 'is_main_query', []rt.PhpVal{}),
		var_wp_query.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_enable_filtering))))
		|| (!(rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')))) {
		return var_args_mutated.clone()
	}
	mut var_current_min_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) { rt.new_float(rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('min_price')),
		]).to_f64()) } else { rt.new_int(0) }
	mut var_current_max_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) { rt.new_float(rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('max_price')),
		]).to_f64()) } else { rt.get_constant('PHP_INT_MAX') }
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('incl'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))))) {
		mut var_tax_class := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_price_filter_widget_tax_class'),
			rt.new_string(''),
		])
		mut iife_temp_4 := Class_WC_Tax{}
		mut iife_result_4 := iife_temp_4.get_rates(var_tax_class.clone())
		mut var_tax_rates := iife_result_4
		if rt.is_true(var_tax_rates) {
			mut iife_temp_5 := Class_WC_Tax{}
			mut iife_result_5 := iife_temp_5.calc_inclusive_tax(var_current_min_price.clone(),
				var_tax_rates.clone())
			mut iife_temp_6 := Class_WC_Tax{}
			mut iife_result_6 := iife_temp_6.get_tax_total(iife_result_5)
			var_current_min_price = rt.sub(var_current_min_price, iife_result_6)
			mut iife_temp_7 := Class_WC_Tax{}
			mut iife_result_7 := iife_temp_7.calc_inclusive_tax(var_current_max_price.clone(),
				var_tax_rates.clone())
			mut iife_temp_8 := Class_WC_Tax{}
			mut iife_result_8 := iife_temp_8.get_tax_total(iife_result_7)
			var_current_max_price = rt.sub(var_current_max_price, iife_result_8)
		}
	}
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_get(rt.new_string('where')) = rt.concat(var_args_mutated.array_get(rt.new_string('where')), rt.call_method(var_wpdb,
		'prepare', [
		rt.new_string(' AND NOT (%f<wc_product_meta_lookup.min_price OR %f>wc_product_meta_lookup.max_price ) '),
		var_current_max_price.clone(),
		var_current_min_price.clone(),
	]))
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) order_by_price_asc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.min_price ASC, wc_product_meta_lookup.product_id ASC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) order_by_price_desc_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.max_price DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) order_by_popularity_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.total_sales DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) order_by_rating_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated.array_set('join',
		this.append_product_sorting_table_join(var_args_mutated.array_get(rt.new_string('join'))))
	var_args_mutated.array_set('orderby',
		' wc_product_meta_lookup.average_rating DESC, wc_product_meta_lookup.rating_count DESC, wc_product_meta_lookup.product_id DESC ')
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Query) append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_sql_mutated := var_sql
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
		var_sql_mutated.clone(), rt.new_string('wc_product_meta_lookup')])))))
	{
		var_sql_mutated = rt.concat(var_sql_mutated, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup ON ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id ')))
	}
	return var_sql_mutated.clone()
}

fn (mut this Class_WC_Query) get_meta_query(var_meta_query rt.PhpVal, main_query bool) rt.PhpVal {
	mut var_meta_query_mutated := var_meta_query
	if !(var_meta_query_mutated.clone().is_array()) {
		var_meta_query_mutated = rt.new_array()
	}
	return rt.call_function('array_filter', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_query_meta_query'),
			var_meta_query_mutated.clone(),
			rt.new_object('WC_Query', []string{}, &this),
		]),
	])
}

fn (mut this Class_WC_Query) get_tax_query(var_tax_query rt.PhpVal, main_query bool) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	if !(var_tax_query_mutated.clone().is_array()) {
		var_tax_query_mutated = rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'AND' },
		])
	}
	if var_main_query
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.filterer, 'filtering_via_lookup_table_is_active', []rt.PhpVal{}))))) {
		mut iter_5 := Class_WC_Query.get_layered_nav_chosen_attributes().iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_data := item_5.val
			mut var_taxonomy := item_5.key
			var_tax_query_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: var_data.array_get(rt.new_string('terms')) },
				rt.ArrayItem{
					key: 'operator'
					val: if rt.is_true(rt.identical(rt.new_string('and'),
						var_data.array_get(rt.new_string('query_type'))))
					{
						'AND'
					} else {
						'IN'
					}
				},
				rt.ArrayItem{ key: 'include_children', val: false },
			]))
		}
	}
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	mut var_product_visibility_not_in := [if
		rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) && var_main_query {
		var_product_visibility_terms.array_get(rt.new_string('exclude-from-search'))
	} else {
		var_product_visibility_terms.array_get(rt.new_string('exclude-from-catalog'))
	}]
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))
	{
		var_product_visibility_not_in << var_product_visibility_terms.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')) {
		mut var_rating_filter := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.call_function('explode', [rt.new_string(','),
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('rating_filter')),
					])])]),
		])
		mut var_rating_terms := rt.new_array()
		mut var_i := rt.new_int(1)
		for {
			if !(rt.is_true(rt.less_equal(var_i, rt.new_int(5)))) { break
			 }
			if rt.is_true(rt.call_function('in_array', [var_i.clone(), var_rating_filter.clone(), rt.new_bool(true)]))
				&& var_product_visibility_terms.array_isset('rated-' + var_i.str()) {
				var_rating_terms << var_product_visibility_terms.array_get(rt.new_string('rated-' +
					var_i.str()))
			}
			rt.post_inc(var_i)
		}
		if !(!rt.is_true(var_rating_terms)) {
			var_tax_query_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'terms', val: var_rating_terms },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
				rt.ArrayItem{ key: 'rating_filter', val: true },
			]))
		}
	}
	if !(!rt.is_true(var_product_visibility_not_in)) {
		var_tax_query_mutated.array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
			rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
			rt.ArrayItem{ key: 'terms', val: var_product_visibility_not_in },
			rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
		]))
	}
	return rt.call_function('array_filter', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_query_tax_query'),
			var_tax_query_mutated.clone(),
			rt.new_object('WC_Query', []string{}, &this),
		]),
	])
}

fn Class_WC_Query.get_main_query() rt.PhpVal {
	return rt.get_static_prop('WC_Query', 'product_query')
}

fn Class_WC_Query.get_main_tax_query() rt.PhpVal {
	mut var_tax_query := if
		!(rt.get_property(rt.get_static_prop('WC_Query', 'product_query'), 'tax_query')).is_null()
		&& !(rt.get_property(rt.get_property(rt.get_static_prop('WC_Query', 'product_query'), 'tax_query'), 'queries')).is_null() {
		rt.get_property(rt.get_property(rt.get_static_prop('WC_Query', 'product_query'),
			'tax_query'), 'queries')
	} else {
		rt.new_array()
	}
	return var_tax_query.clone()
}

fn Class_WC_Query.get_main_meta_query() rt.PhpVal {
	mut var_args := rt.get_property(rt.get_static_prop('WC_Query', 'product_query'), 'query_vars')
	mut var_meta_query := if var_args.array_isset(rt.new_string('meta_query')) {
		var_args.array_get(rt.new_string('meta_query'))
	} else {
		rt.new_array()
	}
	return var_meta_query.clone()
}

fn Class_WC_Query.get_main_search_query_sql() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args := rt.get_property(rt.get_static_prop('WC_Query', 'product_query'), 'query_vars')
	mut var_search_terms := if var_args.array_isset(rt.new_string('search_terms')) {
		var_args.array_get(rt.new_string('search_terms'))
	} else {
		rt.new_array()
	}
	mut var_sql := rt.new_array()
	mut iter_6 := var_search_terms.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_term := item_6.val
		mut var_include := rt.new_bool(!rt.is_true(rt.identical(rt.new_string('-'), rt.call_function('substr', [
			var_term.clone(),
			rt.new_int(0),
			rt.new_int(1),
		]))))
		if rt.is_true(var_include) {
			mut var_like_op := rt.new_string('LIKE')
			mut var_andor_op := rt.new_string('OR')
		} else {
			var_like_op = rt.new_string('NOT LIKE')
			var_andor_op = rt.new_string('AND')
			var_term = rt.call_function('substr', [var_term.clone(),
				rt.new_int(1)])
		}
		mut var_like := rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_term.clone()])).str() + '%')
		var_sql << rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('(('), rt.get_property(var_wpdb,
				'posts')), rt.new_string('.post_title ')), var_like_op), rt.new_string(' %s) ')),
				var_andor_op), rt.new_string(' (')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string('.post_excerpt ')), var_like_op), rt.new_string(' %s) ')),
				var_andor_op), rt.new_string(' (')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string('.post_content ')), var_like_op), rt.new_string(' %s))')),
			var_like.clone(),
			var_like.clone(),
			var_like.clone(),
		])
	}
	if !(!rt.is_true(var_sql))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		var_sql << rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb, 'posts')),
			rt.new_string(".post_password = '')"))
	}
	return rt.call_function('implode', [rt.new_string(' AND '),
		rt.create_array_from_list(var_sql)])
}

fn Class_WC_Query.get_layered_nav_chosen_attributes() rt.PhpVal {
	if !(rt.get_static_prop('WC_Query', 'chosen_attributes').is_array()) {
		rt.set_static_prop('WC_Query', 'chosen_attributes', rt.new_array())
		if !(!rt.is_true(rt.get_superglobal('_GET'))) {
			mut iter_7 := rt.get_superglobal('_GET').iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_value := item_7.val
				mut var_key := item_7.key
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
					var_key.clone(),
					rt.new_string('filter_'),
				])))
				{
					if !(var_value.clone().is_string()) {
						continue
					}
					mut var_attribute := rt.call_function('wc_sanitize_taxonomy_name', [
						rt.call_function('str_replace', [rt.new_string('filter_'),
							rt.new_string(''), var_key.clone()]),
					])
					mut var_taxonomy := rt.call_function('wc_attribute_taxonomy_name', [
						var_attribute.clone(),
					])
					mut var_filter_terms := if !(!rt.is_true(var_value)) { rt.call_function('explode', [
							rt.new_string(','),
							rt.call_function('wc_clean', [
								rt.call_function('wp_unslash', [
									var_value.clone()]),
							]),
						]) } else { rt.new_array() }
					if !rt.is_true(var_filter_terms)
						|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()])))))
						|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute.clone()]))))) {
						continue
					}
					mut var_query_type := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('query_type_' + var_attribute.str())))) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get(rt.new_string('query_type_' + var_attribute.str())), rt.create_array([rt.ArrayItem{
						key: none
						val: 'and'
					}, rt.ArrayItem{ key: none, val: 'or' }]), rt.new_bool(true)])) { rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [
								rt.get_superglobal('_GET').array_get(rt.new_string('query_type_' + var_attribute.str())),
							]),
						]) } else { rt.new_string('') }
					rt.get_static_prop('WC_Query', 'chosen_attributes').array_get_mut(var_taxonomy).array_set('terms', rt.call_function('array_map', [
						rt.new_string('sanitize_title'),
						var_filter_terms.clone(),
					]))
					rt.get_static_prop('WC_Query', 'chosen_attributes').array_get_mut(var_taxonomy).array_set('query_type', if rt.is_true(var_query_type) { var_query_type } else { rt.call_function('apply_filters', [
							rt.new_string('woocommerce_layered_nav_default_query_type'),
							rt.new_string('and'),
						]) })
				}
			}
		}
	}
	return rt.get_static_prop('WC_Query', 'chosen_attributes')
	return rt.new_null()
}

fn (mut this Class_WC_Query) remove_add_to_cart_pagination(var_url rt.PhpVal) rt.PhpVal {
	return rt.call_function('remove_query_arg', [rt.new_string('add-to-cart'),
		var_url.clone()])
}

fn (mut this Class_WC_Query) rating_filter_meta_query() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Query) visibility_meta_query(compare string) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Query) stock_status_meta_query(var_status rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_Query) layered_nav_init() {
	rt.call_function('wc_deprecated_function', [rt.new_string('layered_nav_init'),
		rt.new_string('2.6')])
}

fn (mut this Class_WC_Query) get_products_in_view() {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_products_in_view'),
		rt.new_string('2.6')])
}

fn (mut this Class_WC_Query) layered_nav_query(var_deprecated rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('layered_nav_query'),
		rt.new_string('2.6')])
}

fn (mut this Class_WC_Query) search_post_excerpt(where string) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Query::search_post_excerpt'),
		rt.new_string('3.2.0'),
		rt.new_string('Excerpt added to search query by default since WordPress 4.5.'),
	])
	return rt.new_string(where)
}

fn (mut this Class_WC_Query) remove_posts_where() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Query::remove_posts_where'),
		rt.new_string('3.2.0'),
		rt.new_string('Nothing to remove anymore because search_post_excerpt() is deprecated.'),
	])
}

struct Class_WPSEO_Meta {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_query() &Class_WC_Query {
	mut obj := &Class_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query_vars:    rt.new_array()
		filterer:      rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wpseo_meta(_args ...rt.PhpVal) &Class_WPSEO_Meta {
	mut obj := &Class_WPSEO_Meta{
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_vars' { return this.query_vars }
		'filterer' { return this.filterer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_vars' {
			this.query_vars = val
			return true
		}
		'filterer' {
			this.filterer = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WPSEO_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WPSEO_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WPSEO_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn init_registry() {
	rt.register_class_factory('WC_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_query()
		return rt.new_object('WC_Query', []string{}, obj)
	})
	rt.register_class_factory('WPSEO_Meta', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wpseo_meta()
		return rt.new_object('WPSEO_Meta', []string{}, obj)
	})
	rt.register_class_factory('WC_Tax', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tax()
		return rt.new_object('WC_Tax', []string{}, obj)
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
}
