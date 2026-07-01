import rt

struct Class_WC_Cart_Session {
	rt.PhpObjectBase
pub mut:
		cart rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart_Session) construct(var_cart rt.PhpVal)  {
	mut var_cart_mutated := var_cart
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_cart_mutated.dup(), rt.new_string('WC_Cart')]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('A valid WC_Cart object is required'))))
	}
	this.set_cart(mut rt.cast_object_ptr[Class_WC_Cart](var_cart_mutated))
}

fn (mut this Class_WC_Cart_Session) set_cart(mut var_cart Class_WC_Cart)  {
	mut var_cart_mutated := var_cart
	this.cart = var_cart_mutated.dup()
}

fn (mut this Class_WC_Cart_Session) init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_session_initialize'), rt.new_bool(true), rt.new_object('WC_Cart_Session', []string{}, &this)]))))) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_cart_from_session' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_emptied'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'destroy_cart_session' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_calculate_totals'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_session' }]), rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('woocommerce_removed_coupon'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_session' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'persistent_cart_update' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_removed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'persistent_cart_update' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_restored'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'persistent_cart_update' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_set_quantity'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'persistent_cart_update' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }])])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }]), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_cart_cookies' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Session', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'clean_up_removed_cart_contents' }])])
}

fn (mut this Class_WC_Cart_Session) get_cart_from_session()  {
	rt.call_function('do_action', [rt.new_string('woocommerce_load_cart_from_session')])
	rt.call_method(this.cart, 'set_totals', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('cart_totals'), rt.new_null()])])
	rt.call_method(this.cart, 'set_applied_coupons', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('applied_coupons'), rt.new_array()])])
	rt.call_method(this.cart, 'set_coupon_discount_totals', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('coupon_discount_totals'), rt.new_array()])])
	rt.call_method(this.cart, 'set_coupon_discount_tax_totals', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('coupon_discount_tax_totals'), rt.new_array()])])
	rt.call_method(this.cart, 'set_removed_cart_contents', [rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('removed_cart_contents'), rt.new_array()])])
	mut var_update_cart_session := rt.new_bool(rt.new_bool(false))
	mut var_order_again := rt.new_bool(rt.new_bool(false))
	mut var_cart := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('cart'), rt.new_null()])
	mut var_merge_saved_cart := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cart.dup().is_null())) || rt.is_true(var_merge_saved_cart))) {
		mut var_saved_cart := this.get_saved_cart()
		var_cart = if rt.is_true(rt.new_bool(var_cart.dup().is_null())) { rt.new_array() } else { var_cart }
		var_cart = rt.call_function('array_merge', [var_saved_cart.dup(), var_cart.dup()])
		var_update_cart_session = rt.new_bool(rt.new_bool(true))
		rt.call_function('delete_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('_woocommerce_load_saved_cart_after_login')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('order_again')) && rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce')) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('_wpnonce')]), rt.new_string('woocommerce-order_again')])))) {
		var_cart = this.populate_cart_from_order(rt.call_function('absint', [rt.get_superglobal('_GET').array_get('order_again')]), var_cart.dup())
		var_order_again = rt.new_bool(rt.new_bool(true))
		var_update_cart_session = rt.new_bool(rt.new_bool(true))
	}
	if !(!rt.is_true(var_cart)) {
		rt.call_function('_prime_post_caches', [rt.call_function('wp_list_pluck', [var_cart.dup(), rt.new_string('product_id')])])
	}
	mut var_cart_contents := rt.new_array()
	{
		mut iter_1 := var_cart.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) && rt.is_true(rt.identical(rt.new_string('customize-preview'), var_key)))) {
				continue
			}
			mut var_product := rt.call_function('wc_get_product', [if rt.is_true(var_values.array_get('variation_id')) { var_values.array_get('variation_id') } else { var_values.array_get('product_id') }])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_product) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{}))))))) || rt.is_true(rt.greater_equal(rt.new_int(0), var_values.array_get('quantity'))))) {
				continue
			}
			if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_pre_remove_cart_item_from_session'), rt.new_bool(false), var_key.dup(), var_values.dup(), var_product.dup()])) {
				var_update_cart_session = rt.new_bool(rt.new_bool(true))
				rt.call_function('do_action', [rt.new_string('woocommerce_remove_cart_item_from_session'), var_key.dup(), var_values.dup(), var_product.dup()])
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_is_purchasable'), rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{}), var_key.dup(), var_values.dup(), var_product.dup()]))))) {
				var_update_cart_session = rt.new_bool(rt.new_bool(true))
				mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s has been removed from your cart because it can no longer be purchased. Please contact us if you need assistance.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_name', []rt.PhpVal{})])
				var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_removed_message'), var_message.dup(), var_product.dup()])
				rt.call_function('wc_add_notice', [var_message.dup(), rt.new_string('error')])
				rt.call_function('do_action', [rt.new_string('woocommerce_remove_cart_item_from_session'), var_key.dup(), var_values.dup()])
			} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_values.array_get('data_hash'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [var_values.array_get('data_hash'), rt.call_function('wc_get_cart_item_data_hash', [var_product.dup()])]))))))) {
				var_update_cart_session = rt.new_bool(rt.new_bool(true))
				var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s has been removed from your cart because it has since been modified. You can add it back to your cart <a href="%2$s">here</a>.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_name', []rt.PhpVal{}), rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})])
				var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_item_removed_because_modified_message'), var_message.dup(), var_product.dup()])
				rt.call_function('wc_add_notice', [var_message.dup(), rt.new_string('notice')])
				rt.call_function('do_action', [rt.new_string('woocommerce_remove_cart_item_from_session'), var_key.dup(), var_values.dup()])
			} else {
				mut var_session_data := rt.call_function('array_merge', [var_values.dup(), rt.create_array([rt.ArrayItem{ key: 'data', val: var_product }])])
				var_cart_contents.array_set(var_key, rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cart_item_from_session'), var_session_data.dup(), var_values.dup(), var_key.dup()]))
				if rt.is_true(rt.new_bool(!(var_cart_contents.array_get(var_key).array_isset(rt.new_string('data'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_cart_contents.array_get(var_key).array_get('data'), 'WC_Product')))))))) {
					rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('When filtering cart items with woocommerce_get_cart_item_from_session, each item must have a data key containing a product object.'), rt.new_string('9.8.0')])
					var_cart_contents.array_get_mut(var_key).array_set('data', var_product.dup())
				}
				rt.call_method(this.cart, 'set_cart_contents', [var_cart_contents.dup()])
			}
		}
	}
	if !(!rt.is_true(var_cart_contents)) {
		rt.call_method(this.cart, 'set_cart_contents', [rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_contents_changed'), var_cart_contents.dup()])])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_loaded_from_session'), this.cart])
	if rt.is_true(rt.new_bool(rt.is_true(var_update_cart_session) || rt.is_true(rt.new_bool(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('cart_totals'), rt.new_null()]).is_null())))) {
		mut var_cart_for_session := this.get_cart_for_session()
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('cart'), if !rt.is_true(var_cart_for_session) { rt.new_null() } else { var_cart_for_session }])
		rt.call_method(this.cart, 'calculate_totals', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(var_merge_saved_cart) || rt.is_true(var_update_cart_session))) {
			this.persistent_cart_update()
		}
	}
	if rt.is_true(var_order_again) {
		rt.call_function('wp_safe_redirect', [rt.call_function('wc_get_cart_url', []rt.PhpVal{})])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_WC_Cart_Session) destroy_cart_session()  {
	mut var_wc_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('cart_totals'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('applied_coupons'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_totals'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('coupon_discount_tax_totals'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('removed_cart_contents'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('order_awaiting_payment'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('store_api_draft_order'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('shipping_method_counts'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('previous_shipping_methods'), rt.new_null()])
	rt.call_method(var_wc_session, 'set', [rt.new_string('chosen_shipping_methods'), rt.new_null()])
	this.remove_shipping_for_package_from_session()
}

fn (mut this Class_WC_Cart_Session) maybe_set_cart_cookies()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.cart, 'is_empty', []rt.PhpVal{}))))) {
		this.set_cart_cookies(true)
	} else if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('woocommerce_items_in_cart')) {
		this.set_cart_cookies(false)
	}
	this.dedupe_cookies()
}

fn (mut this Class_WC_Cart_Session) dedupe_cookies()  {
	mut var_cookie_value := rt.new_null()
	mut var_cookie_name := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_header := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	mut var_all_cookies := rt.call_function('array_filter', [rt.call_function('headers_list', []rt.PhpVal{}), rt.new_closure(closure_1_fn)])
	mut var_final_cookies := rt.new_array()
	mut var_update_cookies := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_all_cookies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cookie := item_1.val
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				mut var_key := rt.new_bool(this.find_cookie_by_name(var_cookie_name.dup(), var_final_cookies.dup()))
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_update_cookies = rt.new_bool(rt.new_bool(true))
					var_final_cookies.array_unset(var_key)
				}
			}
			var_final_cookies.array_push(var_cookie.dup())
		}
	}
	if rt.is_true(var_update_cookies) {
		
	}
}

fn (mut this Class_WC_Cart_Session) find_cookie_by_name(var_cookie_name rt.PhpVal, var_cookies rt.PhpVal) bool {
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cookie := item_1.val
			mut var_key := item_1.key
		}
	}
}

fn (mut this Class_WC_Cart_Session) set_session()  {
}

fn (mut this Class_WC_Cart_Session) get_cart_for_session() rt.PhpVal {
}

fn (mut this Class_WC_Cart_Session) persistent_cart_update()  {
}

fn (mut this Class_WC_Cart_Session) persistent_cart_destroy()  {
}

fn (mut this Class_WC_Cart_Session) set_cart_cookies(set bool)  {
}

fn (mut this Class_WC_Cart_Session) get_saved_cart() rt.PhpVal {
}

fn (mut this Class_WC_Cart_Session) populate_cart_from_order(var_order_id rt.PhpVal, var_cart rt.PhpVal) rt.PhpVal {
	mut var_cart_mutated := var_cart
}

fn (mut this Class_WC_Cart_Session) remove_shipping_for_package_from_session()  {
}

fn (mut this Class_WC_Cart_Session) cart_has_shippable_products() bool {
}

fn (mut this Class_WC_Cart_Session) clean_up_removed_cart_contents()  {
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

fn create_wc_cart_session(arg_0 rt.PhpVal) &Class_WC_Cart_Session {
	mut obj := &Class_WC_Cart_Session{
		PhpObjectBase: rt.PhpObjectBase{}
		cart: rt.new_null()
	}
	obj.construct(arg_0)
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

fn (mut this Class_WC_Cart_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Cart](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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
		'cart' { this.cart = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cart_session_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
