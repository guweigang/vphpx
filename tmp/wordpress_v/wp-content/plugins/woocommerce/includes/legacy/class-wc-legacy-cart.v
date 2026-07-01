import rt

struct Class_WC_Legacy_Cart {
	rt.PhpObjectBase
pub mut:
	cart_session_data    rt.PhpVal = rt.new_array()
	coupon_applied_count rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Legacy_Cart) magic_isset(var_name rt.PhpVal) bool {
	mut var_legacy_keys := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'dp' },
			rt.ArrayItem{ key: none, val: 'prices_include_tax' },
			rt.ArrayItem{ key: none, val: 'round_at_subtotal' },
			rt.ArrayItem{ key: none, val: 'cart_contents_total' },
			rt.ArrayItem{ key: none, val: 'total' }, rt.ArrayItem{ key: none, val: 'subtotal' },
			rt.ArrayItem{ key: none, val: 'subtotal_ex_tax' },
			rt.ArrayItem{ key: none, val: 'tax_total' }, rt.ArrayItem{ key: none, val: 'fee_total' },
			rt.ArrayItem{ key: none, val: 'discount_cart' }, rt.ArrayItem{
				key: none
				val: 'discount_cart_tax'
			}, rt.ArrayItem{ key: none, val: 'shipping_total' },
			rt.ArrayItem{ key: none, val: 'shipping_tax_total' },
			rt.ArrayItem{ key: none, val: 'display_totals_ex_tax' },
			rt.ArrayItem{ key: none, val: 'display_cart_ex_tax' },
			rt.ArrayItem{ key: none, val: 'cart_contents_weight' },
			rt.ArrayItem{ key: none, val: 'cart_contents_count' },
			rt.ArrayItem{ key: none, val: 'coupons' }, rt.ArrayItem{ key: none, val: 'taxes' },
			rt.ArrayItem{ key: none, val: 'shipping_taxes' },
			rt.ArrayItem{ key: none, val: 'coupon_discount_amounts' },
			rt.ArrayItem{ key: none, val: 'coupon_discount_tax_amounts' },
			rt.ArrayItem{ key: none, val: 'fees' }, rt.ArrayItem{ key: none, val: 'tax' },
			rt.ArrayItem{ key: none, val: 'discount_total' },
			rt.ArrayItem{ key: none, val: 'tax_display_cart' }]),
		if rt.is_true(rt.new_bool(this.cart_session_data.is_array())) {
			rt.func_array_keys(this.cart_session_data)
		} else {
			rt.new_array()
		},
	])
	if rt.is_true(rt.call_function('in_array', [var_name.dup(),
		var_legacy_keys.dup(), rt.new_bool(true)]))
	{
		return true
	}
	return false
}

fn (mut this Class_WC_Legacy_Cart) magic_get(var_name rt.PhpVal) rt.PhpVal {
	mut var_value := rt.new_string(rt.new_string(''))
	mut switch_val_1 := var_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('dp'))) {
		var_value = rt.call_function('wc_get_price_decimals', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('prices_include_tax'))) {
		var_value = rt.call_function('wc_prices_include_tax', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('round_at_subtotal'))) {
		var_value = rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_round_at_subtotal'),
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cart_contents_total'))) {
		var_value = this.get_cart_contents_total()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total'))) {
		var_value = this.get_total(rt.new_string('edit'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('subtotal'))) {
		var_value = rt.add(this.get_subtotal(), this.get_subtotal_tax())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('subtotal_ex_tax'))) {
		var_value = this.get_subtotal()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_total'))) {
		var_value = rt.add(this.get_fee_tax(), this.get_cart_contents_tax())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fee_total'))) {
		var_value = this.get_fee_total()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('discount_cart'))) {
		var_value = this.get_discount_total()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('discount_cart_tax'))) {
		var_value = this.get_discount_tax()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_total'))) {
		var_value = this.get_shipping_total()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_tax_total'))) {
		var_value = this.get_shipping_tax()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('display_totals_ex_tax')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('display_cart_ex_tax'))) {
		var_value = rt.new_bool(rt.new_bool(!(rt.is_true(this.display_prices_including_tax()))))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cart_contents_weight'))) {
		var_value = this.get_cart_contents_weight()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cart_contents_count'))) {
		var_value = this.get_cart_contents_count()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupons'))) {
		var_value = this.get_coupons()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('taxes'))) {
		rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart->taxes'),
			rt.new_string('3.2'),
			rt.call_function('sprintf', [
				rt.new_string('getters (%s) and setters (%s)'),
				rt.new_string('WC_Cart::get_cart_contents_taxes()'),
				rt.new_string('WC_Cart::set_cart_contents_taxes()'),
			])])
		// unsupported expression: Expr_AssignRef
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_taxes'))) {
		rt.call_function('wc_deprecated_function', [
			rt.new_string('WC_Cart->shipping_taxes'),
			rt.new_string('3.2'),
			rt.call_function('sprintf', [rt.new_string('getters (%s) and setters (%s)'),
				rt.new_string('WC_Cart::get_shipping_taxes()'),
				rt.new_string('WC_Cart::set_shipping_taxes()')]),
		])
		// unsupported expression: Expr_AssignRef
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_discount_amounts'))) {
		// unsupported expression: Expr_AssignRef
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_discount_tax_amounts'))) {
		// unsupported expression: Expr_AssignRef
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fees'))) {
		rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart->fees'),
			rt.new_string('3.2'),
			rt.call_function('sprintf', [
				rt.new_string('the fees API (%s)'),
				rt.new_string('WC_Cart::get_fees'),
			])])
		mut var_new_fees := rt.call_method(this.fees_api(), 'get_fees', []rt.PhpVal{})
		this.dispatch_set_prop('fees', var_new_fees.dup())
		// unsupported expression: Expr_AssignRef
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax'))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('WC_Cart->tax'),
			rt.new_string('2.3'), rt.new_string('Use WC_Tax directly')])
		this.dispatch_set_prop('tax', create_wc_tax())
		var_value = rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'tax')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('discount_total'))) {
		rt.call_function('wc_deprecated_argument', [
			rt.new_string('WC_Cart->discount_total'),
			rt.new_string('2.3'),
			rt.new_string('After tax coupons are no longer supported. For more information see: https://woocommerce.wordpress.com/2014/12/upcoming-coupon-changes-in-woocommerce-2-3/'),
		])
		var_value = rt.new_int(rt.new_int(0))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_display_cart'))) {
		rt.call_function('wc_deprecated_argument', [
			rt.new_string('WC_Cart->tax_display_cart'),
			rt.new_string('4.4'),
			rt.new_string('Use WC_Cart->get_tax_price_display_mode() instead.'),
		])
		var_value = this.get_tax_price_display_mode()
	}
	return var_value.dup()
}

fn (mut this Class_WC_Legacy_Cart) magic_set(var_name rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut switch_val_2 := var_name
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('cart_contents_total'))) {
		this.set_cart_contents_total(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('total'))) {
		this.set_total(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('subtotal'))) {
		this.set_subtotal(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('subtotal_ex_tax'))) {
		this.set_subtotal(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('tax_total'))) {
		this.set_cart_contents_tax(var_value_mutated.dup())
		this.set_fee_tax(rt.new_int(0))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('taxes'))) {
		this.set_cart_contents_taxes(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_taxes'))) {
		this.set_shipping_taxes(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('fee_total'))) {
		this.set_fee_total(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('discount_cart'))) {
		this.set_discount_total(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('discount_cart_tax'))) {
		this.set_discount_tax(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_total'))) {
		this.set_shipping_total(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shipping_tax_total'))) {
		this.set_shipping_tax(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('coupon_discount_amounts'))) {
		this.set_coupon_discount_totals(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('coupon_discount_tax_amounts'))) {
		this.set_coupon_discount_tax_totals(var_value_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('fees'))) {
		rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart->fees'),
			rt.new_string('3.2'),
			rt.call_function('sprintf', [
				rt.new_string('the fees API (%s)'),
				rt.new_string('WC_Cart::add_fee'),
			])])
		this.dispatch_set_prop('fees', var_value_mutated.dup())
	} else {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":267,"name":"name"}',
			var_value_mutated.dup())
	}
}

fn (mut this Class_WC_Legacy_Cart) get_cart_from_session() {
	rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'session'),
		'get_cart_from_session', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) maybe_set_cart_cookies() {
	rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'session'),
		'maybe_set_cart_cookies', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) set_session() {
	rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'session'),
		'set_session', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) get_cart_for_session() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this),
		'session'), 'get_cart_for_session', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) persistent_cart_update() {
	rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'session'),
		'persistent_cart_update', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) persistent_cart_destroy() {
	rt.call_method(rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this), 'session'),
		'persistent_cart_destroy', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) get_cart_discount_total() rt.PhpVal {
	return this.get_discount_total()
}

fn (mut this Class_WC_Legacy_Cart) get_cart_discount_tax_total() rt.PhpVal {
	return this.get_discount_tax()
}

fn (mut this Class_WC_Legacy_Cart) add_discount(var_coupon_code rt.PhpVal) rt.PhpVal {
	return this.apply_coupon(var_coupon_code.dup())
}

fn (mut this Class_WC_Legacy_Cart) remove_taxes() {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::remove_taxes'),
		rt.new_string('3.2'), rt.new_string('')])
}

fn (mut this Class_WC_Legacy_Cart) init() {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::init'),
		rt.new_string('3.2'), rt.new_string('')])
	this.get_cart_from_session()
}

fn (mut this Class_WC_Legacy_Cart) get_discounted_price(var_values rt.PhpVal, var_price rt.PhpVal, add_totals bool) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Cart::get_discounted_price'),
		rt.new_string('3.2'),
		rt.new_string(''),
	])
	mut var_cart_item_key := var_values.array_get('key')
	mut var_cart_item := rt.get_property(rt.new_object('WC_Legacy_Cart', []string{}, &this),
		'cart_contents').array_get(var_cart_item_key)
	return var_cart_item.array_get('line_total')
}

fn (mut this Class_WC_Legacy_Cart) get_cart_url() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::get_cart_url'),
		rt.new_string('2.5'), rt.new_string('wc_get_cart_url')])
	return rt.call_function('wc_get_cart_url', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) get_checkout_url() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Cart::get_checkout_url'),
		rt.new_string('2.5'),
		rt.new_string('wc_get_checkout_url'),
	])
	return rt.call_function('wc_get_checkout_url', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) ship_to_billing_address_only() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Cart::ship_to_billing_address_only'),
		rt.new_string('2.5'),
		rt.new_string('wc_ship_to_billing_address_only'),
	])
	return rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) coupons_enabled() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Legacy_Cart::coupons_enabled'),
		rt.new_string('2.5.0'),
		rt.new_string('wc_coupons_enabled'),
	])
	return rt.call_function('wc_coupons_enabled', []rt.PhpVal{})
}

fn (mut this Class_WC_Legacy_Cart) get_discounts_before_tax() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('get_discounts_before_tax'),
		rt.new_string('2.3'),
		rt.new_string('get_total_discount'),
	])
	if rt.is_true(this.get_cart_discount_total()) {
		mut var_discounts_before_tax := rt.call_function('wc_price', [
			this.get_cart_discount_total(),
		])
	} else {
		var_discounts_before_tax = rt.new_bool(rt.new_bool(false))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_discounts_before_tax'),
		var_discounts_before_tax.dup(),
		rt.new_object('WC_Legacy_Cart', []string{}, &this),
	])
}

fn (mut this Class_WC_Legacy_Cart) get_order_discount_total() i64 {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('get_order_discount_total'),
		rt.new_string('2.3'),
	])
	return 0
}

fn (mut this Class_WC_Legacy_Cart) apply_cart_discounts_after_tax(var_values rt.PhpVal, var_price rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('apply_cart_discounts_after_tax'),
		rt.new_string('2.3'),
	])
}

fn (mut this Class_WC_Legacy_Cart) apply_product_discounts_after_tax(var_values rt.PhpVal, var_price rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('apply_product_discounts_after_tax'),
		rt.new_string('2.3'),
	])
}

fn (mut this Class_WC_Legacy_Cart) get_discounts_after_tax() {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_discounts_after_tax'),
		rt.new_string('2.3')])
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_legacy_cart() &Class_WC_Legacy_Cart {
	mut obj := &Class_WC_Legacy_Cart{
		PhpObjectBase:        rt.PhpObjectBase{}
		cart_session_data:    rt.new_array()
		coupon_applied_count: rt.new_array()
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Legacy_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_cart_from_session' {
			this.get_cart_from_session()
			return rt.new_null()
		}
		'maybe_set_cart_cookies' {
			this.maybe_set_cart_cookies()
			return rt.new_null()
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
		'get_cart_discount_total' {
			return this.get_cart_discount_total()
		}
		'get_cart_discount_tax_total' {
			return this.get_cart_discount_tax_total()
		}
		'add_discount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_discount(dispatch_arg_0)
		}
		'remove_taxes' {
			this.remove_taxes()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_discounted_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_discounted_price(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_cart_url' {
			return this.get_cart_url()
		}
		'get_checkout_url' {
			return this.get_checkout_url()
		}
		'ship_to_billing_address_only' {
			return this.ship_to_billing_address_only()
		}
		'coupons_enabled' {
			return this.coupons_enabled()
		}
		'get_discounts_before_tax' {
			return this.get_discounts_before_tax()
		}
		'get_order_discount_total' {
			return rt.new_int(this.get_order_discount_total())
		}
		'apply_cart_discounts_after_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.apply_cart_discounts_after_tax(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'apply_product_discounts_after_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.apply_product_discounts_after_tax(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_discounts_after_tax' {
			this.get_discounts_after_tax()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Legacy_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart_session_data' { return this.cart_session_data }
		'coupon_applied_count' { return this.coupon_applied_count }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Legacy_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart_session_data' {
			this.cart_session_data = val
			return true
		}
		'coupon_applied_count' {
			this.coupon_applied_count = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_includes_legacy_class_wc_legacy_cart_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
