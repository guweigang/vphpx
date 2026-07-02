import rt

struct Class_WC_Cart_Session {
	rt.PhpObjectBase
pub mut:
	cart rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart_Session) construct(var_cart rt.PhpVal) {
	mut var_cart_mutated := var_cart
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_cart_mutated.clone(), rt.new_string('WC_Cart')])))))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('A valid WC_Cart object is required'))))
	}
	this.set_cart(mut rt.cast_object_ptr[Class_WC_Cart](var_cart_mutated))
}

fn (mut this Class_WC_Cart_Session) set_cart(mut var_cart Class_WC_Cart) {
	mut var_cart_mutated := var_cart
	this.cart = var_cart_mutated
}

fn (mut this Class_WC_Cart_Session) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_session_initialize'),
		rt.new_bool(true),
		rt.new_object('WC_Cart_Session', []string{}, &this),
	])))))
	{
		return
	}
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_cart_from_session' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_emptied'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'destroy_cart_session' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_calculate_totals'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_session' },
		]),
		rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('woocommerce_removed_coupon'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_session' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'persistent_cart_update' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_removed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'persistent_cart_update' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_restored'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'persistent_cart_update' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_set_quantity'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'persistent_cart_update' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' },
		])])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' },
		]),
		rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' },
		]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clean_up_removed_cart_contents' },
		])])
}

fn (mut this Class_WC_Cart_Session) get_cart_from_session() {
	rt.call_function('do_action', [rt.new_string('woocommerce_load_cart_from_session')])
	rt.call_method(this.cart, 'set_totals', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('cart_totals'),
			rt.new_null(),
		]),
	])
	rt.call_method(this.cart, 'set_applied_coupons', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('applied_coupons'),
			rt.new_array(),
		]),
	])
	rt.call_method(this.cart, 'set_coupon_discount_totals', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('coupon_discount_totals'),
			rt.new_array(),
		]),
	])
	rt.call_method(this.cart, 'set_coupon_discount_tax_totals', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('coupon_discount_tax_totals'),
			rt.new_array(),
		]),
	])
	rt.call_method(this.cart, 'set_removed_cart_contents', [
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
			rt.new_string('removed_cart_contents'),
			rt.new_array(),
		]),
	])
	mut var_update_cart_session := rt.new_bool(false)
	mut var_order_again := rt.new_bool(false)
	mut var_cart := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'),
		'get', [rt.new_string('cart'), rt.new_null()])
	mut var_merge_saved_cart := rt.new_bool((rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('_woocommerce_load_saved_cart_after_login'),
		rt.new_bool(true),
	])).to_bool())
	if var_cart.clone().is_null() || rt.is_true(var_merge_saved_cart) {
		mut var_saved_cart := this.get_saved_cart()
		var_cart = if var_cart.clone().is_null() { rt.new_array() } else { var_cart }
		var_cart = rt.call_function('array_merge', [var_saved_cart.clone(),
			var_cart.clone()])
		var_update_cart_session = rt.new_bool(true)
		rt.call_function('delete_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('_woocommerce_load_saved_cart_after_login'),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('order_again'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))]), rt.new_string('woocommerce-order_again')])) {
		var_cart = this.populate_cart_from_order(rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('order_again')),
		]), var_cart.clone())
		var_order_again = rt.new_bool(true)
		var_update_cart_session = rt.new_bool(true)
	}
	if !(!rt.is_true(var_cart)) {
		rt.call_function('_prime_post_caches', [
			rt.call_function('wp_list_pluck', [var_cart.clone(),
				rt.new_string('product_id')]),
		])
	}
	mut var_cart_contents := rt.new_array()
	mut iter_1 := var_cart.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_values := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})))))
			&& rt.is_true(rt.identical(rt.new_string('customize-preview'), var_key)) {
			continue
		}
		mut var_product := rt.call_function('wc_get_product', [if rt.is_true(var_values.array_get(rt.new_string('variation_id'))) {
			var_values.array_get(rt.new_string('variation_id'))
		} else {
			var_values.array_get(rt.new_string('product_id'))
		}])
		if !rt.is_true(var_product)
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{})))))
			|| rt.is_true(rt.greater_equal(rt.new_int(0), var_values.array_get(rt.new_string('quantity')))) {
			continue
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_pre_remove_cart_item_from_session'),
			rt.new_bool(false),
			var_key.clone(),
			var_values.clone(),
			var_product.clone(),
		]))
		{
			var_update_cart_session = rt.new_bool(true)
			rt.call_function('do_action', [
				rt.new_string('woocommerce_remove_cart_item_from_session'),
				var_key.clone(),
				var_values.clone(),
				var_product.clone(),
			])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_item_is_purchasable'),
			rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{}),
			var_key.clone(),
			var_values.clone(),
			var_product.clone(),
		])))))
		{
			var_update_cart_session = rt.new_bool(true)
			mut var_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%s has been removed from your cart because it can no longer be purchased. Please contact us if you need assistance.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			])
			var_message = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_item_removed_message'),
				var_message.clone(),
				var_product.clone(),
			])
			rt.call_function('wc_add_notice', [var_message.clone(),
				rt.new_string('error')])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_remove_cart_item_from_session'),
				var_key.clone(),
				var_values.clone(),
			])
		} else if !(!rt.is_true(var_values.array_get(rt.new_string('data_hash'))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_values.array_get(rt.new_string('data_hash')), rt.call_function('wc_get_cart_item_data_hash', [var_product.clone()])]))))) {
			var_update_cart_session = rt.new_bool(true)
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s has been removed from your cart because it has since been modified. You can add it back to your cart <a href="%2$s">here</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
			])
			var_message = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_item_removed_because_modified_message'),
				var_message.clone(),
				var_product.clone(),
			])
			rt.call_function('wc_add_notice', [var_message.clone(),
				rt.new_string('notice')])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_remove_cart_item_from_session'),
				var_key.clone(),
				var_values.clone(),
			])
		} else {
			mut var_session_data := rt.call_function('array_merge', [
				var_values.clone(), rt.create_array([
					rt.ArrayItem{ key: 'data', val: var_product },
				])])
			var_cart_contents.array_set(var_key, rt.call_function('apply_filters', [
				rt.new_string('woocommerce_get_cart_item_from_session'),
				var_session_data.clone(),
				var_values.clone(),
				var_key.clone(),
			]))
			if !(var_cart_contents.array_get(var_key).array_isset(rt.new_string('data')))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_cart_contents.array_get(var_key).array_get(rt.new_string('data')), 'WC_Product')))))) {
				rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
					rt.new_string('When filtering cart items with woocommerce_get_cart_item_from_session, each item must have a data key containing a product object.'),
					rt.new_string('9.8.0')])
				var_cart_contents.array_get_mut(var_key).array_set('data', var_product.clone())
			}
			rt.call_method(this.cart, 'set_cart_contents', [var_cart_contents.clone()])
		}
	}
	if !(!rt.is_true(var_cart_contents)) {
		rt.call_method(this.cart, 'set_cart_contents', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_contents_changed'),
				var_cart_contents.clone(),
			]),
		])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_loaded_from_session'),
		this.cart])
	if rt.is_true(var_update_cart_session)
		|| rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('cart_totals'), rt.new_null()]).is_null() {
		mut var_cart_for_session := this.get_cart_for_session()
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('cart'),
			if !rt.is_true(var_cart_for_session) { rt.new_null() } else { var_cart_for_session },
		])
		rt.call_method(this.cart, 'calculate_totals', []rt.PhpVal{})
		if rt.is_true(var_merge_saved_cart) || rt.is_true(var_update_cart_session) {
			this.persistent_cart_update()
		}
	}
	if rt.is_true(var_order_again) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Cart_Session) destroy_cart_session() {
	mut var_wc_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart_totals'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('applied_coupons'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_totals'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_tax_totals'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('removed_cart_contents'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('order_awaiting_payment'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('store_api_draft_order'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('shipping_method_counts'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('previous_shipping_methods'),
		rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('chosen_shipping_methods'),
		rt.new_null()])
	this.remove_shipping_for_package_from_session()
}

fn (mut this Class_WC_Cart_Session) maybe_set_cart_cookies() {
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.cart, 'is_empty', []rt.PhpVal{}))))) {
		this.set_cart_cookies(true)
	} else if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('woocommerce_items_in_cart')) {
		this.set_cart_cookies(false)
	}
	this.dedupe_cookies()
}

fn (mut this Class_WC_Cart_Session) dedupe_cookies() {
	mut var_cookie_value := rt.new_null()
	mut var_cookie_name := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_all_cookies := rt.call_function('array_filter', [
		rt.call_function('headers_list', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
	])
	mut var_final_cookies := rt.new_array()
	mut var_update_cookies := rt.new_bool(false)
	mut iter_2 := var_all_cookies.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_cookie := item_2.val
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
			var_cookie.clone(), rt.new_int(2)])
		var_cookie_value = list_tmp_1.array_get(1)
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string('='),
			rt.new_string(var_cookie_value.clone().to_string().trim_space()),
			rt.new_int(2)])
		var_cookie_name = list_tmp_2.array_get(0)
		var_cookie_value = list_tmp_2.array_get(1)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
			var_cookie_name.clone(),
			rt.new_string('woocommerce_'),
		]), rt.new_bool(false)))))
		{
			mut var_key := rt.new_bool(this.find_cookie_by_name(var_cookie_name.clone(),
				var_final_cookies.clone()))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
				var_update_cookies = rt.new_bool(true)
				var_final_cookies.array_unset(var_key)
			}
		}
		var_final_cookies.array_push(var_cookie.clone())
	}
	if rt.is_true(var_update_cookies) {
		rt.call_function('header_remove', [rt.new_string('Set-Cookie')])
		mut iter_3 := var_final_cookies.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_cookie := item_3.val
			rt.call_function('header', [var_cookie.clone(), rt.new_bool(false)])
		}
	}
}

fn (mut this Class_WC_Cart_Session) find_cookie_by_name(var_cookie_name rt.PhpVal, var_cookies rt.PhpVal) bool {
	mut iter_4 := var_cookies.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_cookie := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_cookie.clone(),
			var_cookie_name.clone(),
		]), rt.new_bool(false)))))
		{
			return var_key.to_bool()
		}
	}
	return false
}

fn (mut this Class_WC_Cart_Session) set_session() {
	mut var_wc_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	mut var_cart := this.get_cart_for_session()
	mut var_applied_coupons := rt.call_method(this.cart, 'get_applied_coupons', []rt.PhpVal{})
	mut var_coupon_discount_totals := rt.call_method(this.cart, 'get_coupon_discount_totals',
		[]rt.PhpVal{})
	mut var_coupon_discount_tax_totals := rt.call_method(this.cart,
		'get_coupon_discount_tax_totals', []rt.PhpVal{})
	mut var_removed_cart_contents := rt.call_method(this.cart, 'get_removed_cart_contents',
		[]rt.PhpVal{})
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart_totals'), if !rt.is_true(var_cart) {
		rt.new_null()
	} else {
		rt.call_method(this.cart, 'get_totals', []rt.PhpVal{})
	}])
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart'), if !rt.is_true(var_cart) {
		rt.new_null()
	} else {
		var_cart
	}])
	rt.call_method(var_wc_session, 'set', [rt.new_string('applied_coupons'), if !rt.is_true(var_applied_coupons) {
		rt.new_null()
	} else {
		var_applied_coupons
	}])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_totals'), if !rt.is_true(var_coupon_discount_totals) {
		rt.new_null()
	} else {
		var_coupon_discount_totals
	}])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_tax_totals'),
		if !rt.is_true(var_coupon_discount_tax_totals) {
			rt.new_null()
		} else {
			var_coupon_discount_tax_totals
		}])
	rt.call_method(var_wc_session, 'set', [rt.new_string('removed_cart_contents'), if !rt.is_true(var_removed_cart_contents) {
		rt.new_null()
	} else {
		var_removed_cart_contents
	}])
	if !(this.cart_has_shippable_products()) {
		rt.call_method(var_wc_session, 'set', [rt.new_string('shipping_method_counts'),
			rt.new_null()])
		rt.call_method(var_wc_session, 'set', [
			rt.new_string('previous_shipping_methods'),
			rt.new_null(),
		])
		rt.call_method(var_wc_session, 'set', [rt.new_string('chosen_shipping_methods'),
			rt.new_null()])
		this.remove_shipping_for_package_from_session()
	}
	if !rt.is_true(var_cart) {
		rt.call_method(var_wc_session, 'set', [rt.new_string('store_api_draft_order'),
			rt.new_null()])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_updated')])
}

fn (mut this Class_WC_Cart_Session) get_cart_for_session() rt.PhpVal {
	mut var_cart_session := rt.new_array()
	mut iter_5 := rt.call_method(this.cart, 'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_values := item_5.val
		mut var_key := item_5.key
		var_cart_session.array_set(var_key, var_values.clone())
		var_cart_session.array_get(var_key).array_unset(rt.new_string('data'))
	}
	return var_cart_session.clone()
}

fn (mut this Class_WC_Cart_Session) persistent_cart_update() {
	if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_persistent_cart_enabled'), rt.new_bool(true)])) {
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('_woocommerce_persistent_cart_' +
				(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: 'cart', val: this.get_cart_for_session() },
			]),
		])
	}
}

fn (mut this Class_WC_Cart_Session) persistent_cart_destroy() {
	if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_persistent_cart_enabled'), rt.new_bool(true)])) {
		rt.call_function('delete_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('_woocommerce_persistent_cart_' +
				(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()),
		])
	}
}

fn (mut this Class_WC_Cart_Session) set_cart_cookies(set bool) {
	if var_set {
		mut var_setcookies := {
			'woocommerce_items_in_cart': rt.new_string('1')
			'woocommerce_cart_hash':     rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'get_cart_hash', []rt.PhpVal{})
		}
		for var_name, var_value in var_setcookies {
			if !(rt.get_superglobal('_COOKIE').array_isset(rt.new_string(name)))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_COOKIE').array_get(rt.new_string(name)), var_value)))) {
				rt.call_function('wc_setcookie', [rt.new_string(name),
					var_value.clone()])
				rt.get_superglobal('_COOKIE').array_set(name, var_value.clone())
			}
		}
	} else {
		mut var_unsetcookies := ['woocommerce_items_in_cart', 'woocommerce_cart_hash']
		for var_name in var_unsetcookies {
			if rt.get_superglobal('_COOKIE').array_isset(rt.new_string(name)) {
				rt.call_function('wc_setcookie', [rt.new_string(name),
					rt.new_int(0),
					rt.sub(rt.call_function('time', []rt.PhpVal{}),
						rt.get_constant('HOUR_IN_SECONDS'))])
				rt.get_superglobal('_COOKIE').array_unset(rt.new_string(name))
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_set_cart_cookies'),
		rt.new_bool(set)])
}

fn (mut this Class_WC_Cart_Session) get_saved_cart() rt.PhpVal {
	mut var_saved_cart := rt.new_array()
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_persistent_cart_enabled'),
		rt.new_bool(true),
	]))
	{
		mut var_saved_cart_meta := rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('_woocommerce_persistent_cart_' +
				(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()),
			rt.new_bool(true),
		])
		if var_saved_cart_meta.clone().is_array()
			&& var_saved_cart_meta.array_isset(rt.new_string('cart')) {
			var_saved_cart = rt.call_function('array_filter', [
				rt.cast_array(var_saved_cart_meta.array_get(rt.new_string('cart'))),
			])
		}
	}
	return var_saved_cart.clone()
}

fn (mut this Class_WC_Cart_Session) populate_cart_from_order(var_order_id rt.PhpVal, var_cart rt.PhpVal) rt.PhpVal {
	mut var_cart_mutated := var_cart
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	mut var_valid_statuses := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_valid_order_statuses_for_order_again'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'has_status', [var_valid_statuses.clone()])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('order_again'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_empty_cart_when_order_again'),
		rt.new_bool(true),
	]))
	{
		var_cart_mutated = rt.new_array()
	}
	mut var_inital_cart_size := rt.new_int(var_cart_mutated.clone().array_count())
	mut var_order_items := rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	mut iter_6 := var_order_items.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		mut var_product_id := rt.new_int((rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_product_id'),
			rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}),
		])).to_i64())
		mut var_quantity := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
		mut var_variation_id := rt.new_int((rt.call_method(var_item, 'get_variation_id',
			[]rt.PhpVal{})).to_i64())
		mut var_variations := rt.new_array()
		mut var_cart_item_data := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_again_cart_item_data'),
			rt.new_array(),
			var_item.clone(),
			var_order.clone(),
		])
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_variation_id))))
			&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock',
			[]rt.PhpVal{})))))
		{
			continue
		}
		mut iter_7 := rt.call_method(var_item, 'get_meta_data', []rt.PhpVal{}).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_meta := item_7.val
			if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_meta, 'key')]))
				|| rt.is_true(rt.call_function('meta_is_product_attribute', [rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'), var_product_id.clone()])) {
				mut var_attribute_key := rt.new_string('attribute_' +
					(rt.call_function('sanitize_title', [rt.get_property(var_meta, 'key')])).str())
				if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
					rt.get_property(var_meta, 'key'),
				]))
				{
					var_variations.array_set(var_attribute_key, rt.call_function('sanitize_title', [
						rt.get_property(var_meta, 'value'),
					]))
				} else {
					var_variations.array_set(var_attribute_key, rt.call_function('html_entity_decode', [
						rt.call_function('wc_clean', [rt.get_property(var_meta, 'value')]),
						rt.get_constant('ENT_QUOTES'),
						rt.call_function('get_bloginfo', [rt.new_string('charset')]),
					]))
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_validation'),
			rt.new_bool(true),
			var_product_id.clone(),
			var_quantity.clone(),
			var_variation_id.clone(),
			var_variations.clone(),
			var_cart_item_data.clone(),
		])))))
		{
			continue
		}
		mut var_product_data := rt.call_function('wc_get_product', [if rt.is_true(var_variation_id) {
			var_variation_id
		} else {
			var_product_id
		}])
		if rt.is_true(rt.new_bool(rt.instance_of(var_product_data, 'WC_Product')))
			&& rt.is_true(rt.call_method(var_product_data, 'is_sold_individually', []rt.PhpVal{})) {
			var_quantity = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_add_to_cart_sold_individually_quantity'),
				rt.new_int(1),
				var_quantity.clone(),
				var_product_id.clone(),
				var_variation_id.clone(),
				var_cart_item_data.clone(),
			])
			mut var_cart_id := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'generate_cart_id', [var_product_id.clone(),
				var_variation_id.clone(), var_variations.clone(),
				var_cart_item_data.clone()])
			mut var_found_in_cart := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_add_to_cart_sold_individually_found_in_cart'),
				rt.new_bool(var_cart_mutated.array_isset(var_cart_id)
					&& var_cart_mutated.array_get(var_cart_id).array_isset(rt.new_string('quantity'))
					&& rt.is_true(rt.greater(var_cart_mutated.array_get(var_cart_id).array_get(rt.new_string('quantity')), rt.new_int(0)))),
				var_product_id.clone(),
				var_variation_id.clone(),
				var_cart_item_data.clone(),
				var_cart_id.clone(),
			])
			if rt.is_true(var_found_in_cart) {
				mut var_message := rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('You cannot add another "%s" to your cart.'),
						rt.new_string('woocommerce'),
					]),
					rt.call_method(var_product_data, 'get_name', []rt.PhpVal{}),
				])
				var_message = rt.call_function('apply_filters', [
					rt.new_string('woocommerce_cart_product_cannot_add_another_message'),
					var_message.clone(),
					var_product_data.clone(),
				])
				mut var_wp_button_class := rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
					rt.new_string('button'),
				]))
				{
					' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
				} else {
					''
				}).str())
				var_message = rt.call_function('sprintf', [
					rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'),
					var_message.clone(),
					rt.call_function('esc_url', [
						rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
					]),
					rt.call_function('esc_attr', [
						var_wp_button_class.clone(),
					]),
					rt.call_function('__', [
						rt.new_string('View cart'),
						rt.new_string('woocommerce'),
					]),
				])
				rt.call_function('wc_add_notice', [var_message.clone(),
					rt.new_string('error')])
				continue
			}
		}
		var_cart_id = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'generate_cart_id', [var_product_id.clone(), var_variation_id.clone(),
			var_variations.clone(), var_cart_item_data.clone()])
		var_product_data = rt.call_function('wc_get_product', [if rt.is_true(var_variation_id) {
			var_variation_id
		} else {
			var_product_id
		}])
		var_cart_mutated.array_set(var_cart_id, rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_order_again_cart_item'),
			rt.call_function('array_merge', [var_cart_item_data.clone(),
				rt.create_array([rt.ArrayItem{ key: 'key', val: var_cart_id },
					rt.ArrayItem{ key: 'product_id', val: var_product_id },
					rt.ArrayItem{ key: 'variation_id', val: var_variation_id },
					rt.ArrayItem{ key: 'variation', val: var_variations },
					rt.ArrayItem{ key: 'quantity', val: var_quantity },
					rt.ArrayItem{ key: 'data', val: var_product_data },
					rt.ArrayItem{ key: 'data_hash', val: rt.call_function('wc_get_cart_item_data_hash', [
						var_product_data.clone(),
					]) }])]),
			var_cart_id.clone(),
		]))
	}
	rt.call_function('do_action_ref_array', [rt.new_string('woocommerce_ordered_again'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_order_items },
			rt.ArrayItem{ key: none, val: var_cart_mutated },
		])])
	mut var_num_items_in_cart := rt.new_int(var_cart_mutated.clone().array_count())
	mut var_num_items_in_original_order := rt.new_int(var_order_items.clone().array_count())
	mut var_num_items_added := rt.sub(var_num_items_in_cart, var_inital_cart_size)
	if rt.is_true(rt.greater(var_num_items_in_original_order, var_num_items_added)) {
		rt.call_function('wc_add_notice', [
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('%d item from your previous order is currently unavailable and could not be added to your cart.'),
					rt.new_string('%d items from your previous order are currently unavailable and could not be added to your cart.'),
					rt.sub(var_num_items_in_original_order, var_num_items_added),
					rt.new_string('woocommerce'),
				]),
				rt.sub(var_num_items_in_original_order, var_num_items_added),
			]),
			rt.new_string('error'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_num_items_added)) {
		rt.call_function('wc_add_notice', [
			rt.call_function('__', [
				rt.new_string('The cart has been filled with the items from your previous order.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	return var_cart_mutated.clone()
}

fn (mut this Class_WC_Cart_Session) remove_shipping_for_package_from_session() {
	mut var_wc_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_wc_session.clone(), rt.new_string('WC_Session_Handler')])))))
	{
		return
	}
	mut iter_8 := rt.func_array_keys(rt.call_method(var_wc_session, 'get_session_data',
		[]rt.PhpVal{})).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_key := item_8.val
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			var_key.clone(), rt.new_string('shipping_for_package_')])))
		{
			rt.call_method(var_wc_session, 'set', [var_key.clone(),
				rt.new_null()])
		}
	}
}

fn (mut this Class_WC_Cart_Session) cart_has_shippable_products() bool {
	mut iter_9 := rt.call_method(this.cart, 'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_cart_item := item_9.val
		if rt.is_true(rt.call_method(var_cart_item.array_get(rt.new_string('data')),
			'needs_shipping', []rt.PhpVal{}))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Cart_Session) clean_up_removed_cart_contents() {
	mut var_is_page := rt.new_bool(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_archive', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_search', []rt.PhpVal{})))
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_is_page)))) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('removed_item')) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('undo_item')) {
		return
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('removed_cart_contents'),
		rt.new_null(),
	])
	rt.call_method(this.cart, 'set_removed_cart_contents', [rt.new_array()])
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_cart_session(arg_0 rt.PhpVal) &Class_WC_Cart_Session {
	mut obj := &Class_WC_Cart_Session{
		PhpObjectBase: rt.PhpObjectBase{}
		cart:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Cart_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Cart](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_cart(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_cart_from_session' {
			this.get_cart_from_session()
			return rt.new_null()
		}
		'destroy_cart_session' {
			this.destroy_cart_session()
			return rt.new_null()
		}
		'maybe_set_cart_cookies' {
			this.maybe_set_cart_cookies()
			return rt.new_null()
		}
		'dedupe_cookies' {
			this.dedupe_cookies()
			return rt.new_null()
		}
		'find_cookie_by_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.find_cookie_by_name(dispatch_arg_0, dispatch_arg_1))
		}
		'set_session' {
			this.set_session()
			return rt.new_null()
		}
		'get_cart_for_session' {
			return this.get_cart_for_session()
		}
		'persistent_cart_update' {
			this.persistent_cart_update()
			return rt.new_null()
		}
		'persistent_cart_destroy' {
			this.persistent_cart_destroy()
			return rt.new_null()
		}
		'set_cart_cookies' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_cart_cookies(dispatch_arg_0)
			return rt.new_null()
		}
		'get_saved_cart' {
			return this.get_saved_cart()
		}
		'populate_cart_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.populate_cart_from_order(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_shipping_for_package_from_session' {
			this.remove_shipping_for_package_from_session()
			return rt.new_null()
		}
		'cart_has_shippable_products' {
			return rt.new_bool(this.cart_has_shippable_products())
		}
		'clean_up_removed_cart_contents' {
			this.clean_up_removed_cart_contents()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Cart_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart' { return this.cart }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cart_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart' {
			this.cart = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
