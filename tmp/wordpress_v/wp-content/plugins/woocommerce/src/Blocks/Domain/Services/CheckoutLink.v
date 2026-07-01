import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) init()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_checkout_link_endpoint' }])])
	rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_vars' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_checkout_link_endpoint' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) add_checkout_link_endpoint()  {
	mut var_rules := rt.call_function('get_option', [rt.new_string('rewrite_rules'), rt.new_array()])
	mut var_regex := rt.new_string(rt.new_string('^checkout-link$'))
	rt.call_function('add_rewrite_rule', [var_regex.dup(), rt.new_string('index.php?checkout-link=true'), rt.new_string('top')])
	if !(var_rules.array_isset(var_regex)) {
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) add_query_vars(var_vars rt.PhpVal) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push('checkout-link')
	return var_vars_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) handle_checkout_link_endpoint()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_query_var', [rt.new_string('checkout-link')]))))) {
		return rt.new_null()
	}
	if !(this.validate_checkout_link()) {
		mut var_redirect := rt.call_function('add_query_arg', [rt.new_string('wc_error'), rt.call_function('rawurlencode', [rt.call_function('__', [rt.new_string('The provided checkout link was out of date or invalid. No products were added to the cart.'), rt.new_string('woocommerce')])]), rt.call_function('wc_get_cart_url', []rt.PhpVal{})])
	} else {
		rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'empty_cart', []rt.PhpVal{})
		var_redirect = this.get_checkout_link()
	}
	rt.call_function('wp_safe_redirect', [var_redirect.dup()])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) validate_checkout_link() bool {
	mut var_products := this.get_products_from_checkout_link()
	return !(!rt.is_true(var_products))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) get_products_from_checkout_link() rt.PhpVal {
	mut var_raw_products := rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(','), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get('products')).is_null() { rt.get_superglobal('_GET').array_get('products') } else { rt.new_string('') }])])])])
	mut var_products := rt.new_array()
	{
		mut iter_1 := var_raw_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_id_qty := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported assign target: Expr_List
			} else {
				mut var_product_id := var_product_id_qty
				mut var_qty := rt.new_int(rt.new_int(1))
			}
			var_product_id = rt.call_function('absint', [var_product_id.dup()])
			var_qty = rt.call_function('absint', [var_qty.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_qty)))))) {
				continue
			}
			var_products.array_set(var_product_id, var_qty.dup())
		}
	}
	return var_products.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) add_error_notices(mut var_errors Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error)  {
	mut var_errors_mutated := var_errors
	{
		mut iter_1 := var_errors_mutated.get_error_messages().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_message := item_1.val
			rt.call_function('wc_add_notice', [var_message.dup(), rt.new_string('error')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) get_checkout_link() rt.PhpVal {
	mut var_controller := create_automattic_woocommerce_storeapi_utilities_cartcontroller()
	mut var_products := this.get_products_from_checkout_link()
	mut var_errors := create_automattic_woocommerce_blocks_domain_services_wp_error()
	{
		mut iter_1 := var_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_qty := item_1.val
			mut var_product_id := item_1.key
			var_controller.add_to_cart(rt.create_array([rt.ArrayItem{ key: 'id', val: var_product_id }, rt.ArrayItem{ key: 'quantity', val: var_qty }]))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Domain_Services_Exception') {
				mut var_e := var_e_1.dup()
				var_errors.add(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	if rt.is_true(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})) {
		var_errors.add(rt.new_string('error'), rt.call_function('__', [rt.new_string('The provided checkout link was out of date or invalid. No products were added to the cart.'), rt.new_string('woocommerce')]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'session'), 'has_session', []rt.PhpVal{}))))) {
			return rt.call_function('add_query_arg', [rt.new_string('wc_error'), rt.call_function('rawurlencode', [var_errors.get_error_message()]), rt.call_function('wc_get_cart_url', []rt.PhpVal{})])
		} else {
			this.add_error_notices(mut var_errors)
		}
		return rt.call_function('wc_get_cart_url', []rt.PhpVal{})
	}
	mut var_coupon := rt.call_function('wc_format_coupon_code', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get('coupon')).is_null() { rt.get_superglobal('_GET').array_get('coupon') } else { rt.new_string('') }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{})) && !(!rt.is_true(var_coupon)))) {
		var_controller.apply_coupon(var_coupon.dup())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		unsafe { goto end_label_2 }

catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Blocks_Domain_Services_Exception') {
			mut var_e := var_e_2.dup()
			var_errors.add(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
			unsafe { goto end_label_2 }
		}
		else {
			rt.throw_exception(var_e_2)
			unsafe { goto end_label_2 }
		}

end_label_2:
	}
	this.add_error_notices(mut var_errors)
	mut var_redirect_url := rt.call_function('wc_get_checkout_url', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('QUERY_STRING'))) {
		var_redirect_url = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'products' }, rt.ArrayItem{ key: none, val: 'coupon' }, rt.ArrayItem{ key: none, val: 'checkout-link' }]), rt.call_function('add_query_arg', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('QUERY_STRING')]), rt.new_string(''), var_redirect_url.dup()])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		mut var_session_token := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{}; return temp.get_cart_token(arg_0) }(// unsupported expression: Expr_Cast_String)
		var_redirect_url = rt.call_function('add_query_arg', [rt.new_string('session'), var_session_token.dup(), var_redirect_url.dup()])
	}
	return var_redirect_url.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutlink() &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_cartcontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_wp_error() &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_carttokenutils() &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_checkout_link_endpoint' {
			this.add_checkout_link_endpoint()
			return rt.new_null()
		}
		'add_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_query_vars(dispatch_arg_0)
		}
		'handle_checkout_link_endpoint' {
			this.handle_checkout_link_endpoint()
			return rt.new_null()
		}
		'validate_checkout_link' {
			return rt.new_bool(this.validate_checkout_link())
		}
		'get_products_from_checkout_link' {
			return this.get_products_from_checkout_link()
		}
		'add_error_notices' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_error_notices(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_checkout_link' {
			return this.get_checkout_link()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutLink) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_CartTokenUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_checkoutlink_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
