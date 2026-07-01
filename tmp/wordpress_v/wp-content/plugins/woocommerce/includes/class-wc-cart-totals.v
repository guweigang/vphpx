import rt

struct Class_WC_Cart_Totals {
	rt.PhpObjectBase
pub mut:
		cart rt.PhpVal = rt.new_null()
		items rt.PhpVal = rt.new_array()
		fees rt.PhpVal = rt.new_array()
		shipping rt.PhpVal = rt.new_array()
		coupons rt.PhpVal = rt.new_array()
		coupon_discount_totals rt.PhpVal = rt.new_array()
		coupon_discount_tax_totals rt.PhpVal = rt.new_array()
		calculate_tax bool
		totals rt.PhpVal = rt.new_array()
		item_tax_rates rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart_Totals) construct(var_cart rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_cart.dup(), rt.new_string('WC_Cart')]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('A valid WC_Cart object is required'))))
	}
	mut var_customer := rt.call_method(var_cart, 'get_customer', []rt.PhpVal{})
	mut var_is_customer_vat_exempt := rt.new_bool(rt.new_bool(rt.is_true(var_customer) && rt.is_true(rt.call_method(var_customer, 'get_is_vat_exempt', []rt.PhpVal{}))))
	this.cart = var_cart.dup()
	this.calculate_tax = rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_customer_vat_exempt))))
	this.calculate()
}

fn (mut this Class_WC_Cart_Totals) calculate()  {
	this.calculate_item_totals()
	this.calculate_shipping_totals()
	this.calculate_fee_totals()
	this.calculate_totals()
}

fn (mut this Class_WC_Cart_Totals) get_default_item_props() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Object
}

fn (mut this Class_WC_Cart_Totals) get_default_fee_props() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Object
}

fn (mut this Class_WC_Cart_Totals) get_default_shipping_props() rt.PhpVal {
	return // unsupported expression: Expr_Cast_Object
}

fn (mut this Class_WC_Cart_Totals) get_items_from_cart()  {
	this.items = rt.new_array()
	{
		mut iter_1 := rt.call_method(this.cart, 'get_cart', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_cart_item_key := item_1.key
			mut var_item := this.get_default_item_props()
			rt.set_property(var_item, 'key', var_cart_item_key.dup())
			rt.set_property(var_item, 'object', var_cart_item.dup())
			rt.set_property(var_item, 'tax_class', rt.call_method(var_cart_item.array_get('data'), 'get_tax_class', []rt.PhpVal{}))
			rt.set_property(var_item, 'taxable', rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), rt.call_method(var_cart_item.array_get('data'), 'get_tax_status', []rt.PhpVal{})))
			rt.set_property(var_item, 'price_includes_tax', rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))
			rt.set_property(var_item, 'quantity', var_cart_item.array_get('quantity'))
			rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [rt.mul(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double)]))
			rt.set_property(var_item, 'product', var_cart_item.array_get('data'))
			rt.set_property(var_item, 'tax_rates', this.get_item_tax_rates(var_item.dup()))
			this.items.array_set(var_cart_item_key, var_item.dup())
		}
	}
}

fn (mut this Class_WC_Cart_Totals) get_tax_class_costs() rt.PhpVal {
	mut var_item_tax_classes := rt.call_function('wp_list_pluck', [this.items, rt.new_string('tax_class')])
	mut var_shipping_tax_classes := rt.call_function('wp_list_pluck', [this.shipping, rt.new_string('tax_class')])
	mut var_fee_tax_classes := rt.call_function('wp_list_pluck', [this.fees, rt.new_string('tax_class')])
	mut var_costs := rt.call_function('array_fill_keys', [rt.add(rt.add(var_item_tax_classes, var_shipping_tax_classes), var_fee_tax_classes), rt.new_int(0)])
	var_costs.array_set('non-taxable', 0)
	{
		mut iter_1 := rt.add(rt.add(this.items, this.fees), this.shipping).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_item, 'total'))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item, 'taxable'))))) {
				// unsupported expression: Expr_AssignOp_Plus
			} else if rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_item, 'tax_class'))) {
				// unsupported expression: Expr_AssignOp_Plus
			} else {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return rt.call_function('array_filter', [var_costs.dup()])
}

fn (mut this Class_WC_Cart_Totals) get_fees_from_cart()  {
	this.fees = rt.new_array()
	rt.call_method(this.cart, 'calculate_fees', []rt.PhpVal{})
	mut var_fee_running_total := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := rt.call_method(this.cart, 'get_fees', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fee_object := item_1.val
			mut var_fee_key := item_1.key
			mut var_fee := this.get_default_fee_props()
			rt.set_property(var_fee, 'object', var_fee_object.dup())
			rt.set_property(var_fee, 'tax_class', rt.get_property(rt.get_property(var_fee, 'object'), 'tax_class'))
			rt.set_property(var_fee, 'taxable', rt.get_property(rt.get_property(var_fee, 'object'), 'taxable'))
			rt.set_property(var_fee, 'total', rt.call_function('wc_add_number_precision_deep', [rt.get_property(rt.get_property(var_fee, 'object'), 'amount')]))
			if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_fee, 'total'))) {
				mut var_max_discount := rt.mul(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0) }(rt.add(rt.add(this.get_total('items_total', true), var_fee_running_total), this.get_total('shipping_total', true))), // unsupported expression: Expr_UnaryMinus)
				if rt.is_true(rt.less(rt.get_property(var_fee, 'total'), var_max_discount)) {
					rt.set_property(var_fee, 'total', var_max_discount.dup())
				}
			}
			// unsupported expression: Expr_AssignOp_Plus
			if rt.is_true(this.calculate_tax) {
				if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_fee, 'total'))) {
					mut var_tax_class_costs := this.get_tax_class_costs()
					mut var_total_cost := rt.call_function('array_sum', [var_tax_class_costs.dup()])
					if rt.is_true(var_total_cost) {
						{
							mut iter_2 := var_tax_class_costs.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_tax_class_cost := item_2.val
								mut var_tax_class := item_2.key
								if rt.is_true(rt.identical(rt.new_string('non-taxable'), var_tax_class)) {
									continue
								}
								mut var_proportion := rt.div(var_tax_class_cost, var_total_cost)
								mut var_cart_discount_proportion := rt.mul(rt.get_property(var_fee, 'total'), var_proportion)
								rt.set_property(var_fee, 'taxes', rt.call_function('wc_array_merge_recursive_numeric', [rt.get_property(var_fee, 'taxes'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1) }(rt.mul(rt.get_property(var_fee, 'total'), var_proportion), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_rates(arg_0) }(var_tax_class.dup()))]))
							}
						}
					}
				} else if rt.is_true(rt.get_property(rt.get_property(var_fee, 'object'), 'taxable')) {
					rt.set_property(var_fee, 'taxes', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.calc_tax(arg_0, arg_1, arg_2) }(rt.get_property(var_fee, 'total'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_rates(arg_0, arg_1) }(rt.get_property(var_fee, 'tax_class'), rt.call_method(this.cart, 'get_customer', []rt.PhpVal{})), rt.new_bool(false)))
				}
			}
			rt.set_property(var_fee, 'taxes', rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_totals_get_fees_from_cart_taxes'), rt.get_property(var_fee, 'taxes'), var_fee.dup(), rt.new_object('WC_Cart_Totals', []string{}, &this)]))
			rt.set_property(var_fee, 'total_tax', rt.call_function('array_sum', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'round_line_tax' }]), rt.get_property(var_fee, 'taxes')])]))
			rt.set_property(rt.get_property(var_fee, 'object'), 'total', rt.call_function('wc_remove_number_precision_deep', [rt.get_property(var_fee, 'total')]))
			rt.set_property(rt.get_property(var_fee, 'object'), 'tax_data', rt.call_function('wc_remove_number_precision_deep', [rt.get_property(var_fee, 'taxes')]))
			rt.set_property(rt.get_property(var_fee, 'object'), 'tax', rt.call_function('wc_remove_number_precision_deep', [rt.get_property(var_fee, 'total_tax')]))
			this.fees.array_set(var_fee_key, var_fee.dup())
		}
	}
}

fn (mut this Class_WC_Cart_Totals) get_shipping_from_cart()  {
	mut var_default_shipping_props := this.get_default_shipping_props()
	closure_2_fn := fn [var_default_shipping_props] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_default_shipping_props] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_shipping_object := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_shipping_line := // unsupported expression: Expr_Clone
	rt.set_property(var_shipping_line, 'object', var_shipping_object.dup())
	rt.set_property(var_shipping_line, 'tax_class', rt.call_function('get_option', [rt.new_string('woocommerce_shipping_tax_class'), rt.new_string('inherit')]))
	rt.set_property(var_shipping_line, 'taxable', rt.new_bool(true))
	rt.set_property(var_shipping_line, 'total', rt.call_function('wc_add_number_precision_deep', [rt.get_property(var_shipping_object, 'cost')]))
	rt.set_property(var_shipping_line, 'taxes', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'round_item_subtotal' }]), rt.call_function('wc_add_number_precision_deep', [rt.get_property(var_shipping_object, 'taxes'), rt.new_bool(false)])]))
	rt.set_property(var_shipping_line, 'total_tax', rt.call_function('array_sum', [rt.get_property(var_shipping_line, 'taxes')]))
	return var_shipping_line.dup()
	}
	mut var_shipping_object := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_shipping_line := // unsupported expression: Expr_Clone
	rt.set_property(var_shipping_line, 'object', var_shipping_object.dup())
	rt.set_property(var_shipping_line, 'tax_class', rt.call_function('get_option', [rt.new_string('woocommerce_shipping_tax_class'), rt.new_string('inherit')]))
	rt.set_property(var_shipping_line, 'taxable', rt.new_bool(true))
	rt.set_property(var_shipping_line, 'total', rt.call_function('wc_add_number_precision_deep', [rt.get_property(var_shipping_object, 'cost')]))
	rt.set_property(var_shipping_line, 'taxes', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'round_item_subtotal' }]), rt.call_function('wc_add_number_precision_deep', [rt.get_property(var_shipping_object, 'taxes'), rt.new_bool(false)])]))
	rt.set_property(var_shipping_line, 'total_tax', rt.call_function('array_sum', [rt.get_property(var_shipping_line, 'taxes')]))
	return var_shipping_line.dup()
	}
	this.shipping = rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.call_method(this.cart, 'calculate_shipping', []rt.PhpVal{})])
}

fn (mut this Class_WC_Cart_Totals) get_coupons_from_cart()  {
	this.coupons = rt.call_method(this.cart, 'get_coupons', []rt.PhpVal{})
	{
		mut iter_1 := this.coupons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_coupon := item_1.val
			mut switch_val_1 := rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{})
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_product'))) {
				rt.set_property(var_coupon, 'sort', rt.new_int(1))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('percent'))) {
				rt.set_property(var_coupon, 'sort', rt.new_int(2))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_cart'))) {
				rt.set_property(var_coupon, 'sort', rt.new_int(3))
			} else {
				rt.set_property(var_coupon, 'sort', rt.new_int(0))
			}
			rt.set_property(var_coupon, 'sort', rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_sort'), rt.get_property(var_coupon, 'sort'), var_coupon.dup()]))
		}
	}
	rt.call_function('uasort', [this.coupons, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_coupons_callback' }])])
}

fn (mut this Class_WC_Cart_Totals) sort_coupons_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.get_property(var_a, 'sort'), rt.get_property(var_b, 'sort'))) {
		if rt.is_true(rt.identical(rt.call_method(var_a, 'get_limit_usage_to_x_items', []rt.PhpVal{}), rt.call_method(var_b, 'get_limit_usage_to_x_items', []rt.PhpVal{}))) {
			if rt.is_true(rt.identical(rt.call_method(var_a, 'get_amount', []rt.PhpVal{}), rt.call_method(var_b, 'get_amount', []rt.PhpVal{}))) {
				return rt.sub(rt.call_method(, 'get_id', []rt.PhpVal{}), rt.call_method(, 'get_id', []rt.PhpVal{}))
			}
			return if rt.is_true(rt.less(, )) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }
		}
		return if rt.is_true(rt.less(, )) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }
	}
	return if rt.is_true(rt.less(, )) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }
}

fn (mut this Class_WC_Cart_Totals) remove_item_base_taxes(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		if rt.is_true() {
		} else {
		}
		
	}
	return .dup()
}

fn (mut this Class_WC_Cart_Totals) adjust_non_base_location_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Cart_Totals) get_discounted_price_in_cents(var_item_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) get_item_tax_rates(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Cart_Totals) get_item_costs_by_tax_class() rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) get_total(key string, in_cents bool) rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) set_total(var_key rt.PhpVal, var_total rt.PhpVal)  {
}

fn (mut this Class_WC_Cart_Totals) get_totals(in_cents bool) rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) get_values_for_total(var_field rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) get_merged_taxes(in_cents bool, var_types rt.PhpVal) rt.PhpVal {
	mut var_types_mutated := var_types
}

fn (mut this Class_WC_Cart_Totals) round_merged_taxes(var_taxes rt.PhpVal) rt.PhpVal {
	mut var_taxes_mutated := var_taxes
}

fn (mut this Class_WC_Cart_Totals) combine_item_taxes(var_item_taxes rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart_Totals) calculate_item_totals()  {
}

fn (mut this Class_WC_Cart_Totals) calculate_item_subtotals()  {
}

fn (mut this Class_WC_Cart_Totals) calculate_discounts()  {
}

fn (mut this Class_WC_Cart_Totals) calculate_fee_totals()  {
}

fn (mut this Class_WC_Cart_Totals) calculate_shipping_totals()  {
}

fn (mut this Class_WC_Cart_Totals) calculate_totals()  {
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

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_cart_totals(arg_0 rt.PhpVal) &Class_WC_Cart_Totals {
	mut obj := &Class_WC_Cart_Totals{
		PhpObjectBase: rt.PhpObjectBase{}
		cart: rt.new_null()
		items: rt.new_array()
		fees: rt.new_array()
		shipping: rt.new_array()
		coupons: rt.new_array()
		coupon_discount_totals: rt.new_array()
		coupon_discount_tax_totals: rt.new_array()
		calculate_tax: false
		totals: rt.new_array()
		item_tax_rates: rt.new_null()
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

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cart_Totals) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'calculate' {
			this.calculate()
			return rt.new_null()
		}
		'get_default_item_props' {
			return this.get_default_item_props()
		}
		'get_default_fee_props' {
			return this.get_default_fee_props()
		}
		'get_default_shipping_props' {
			return this.get_default_shipping_props()
		}
		'get_items_from_cart' {
			this.get_items_from_cart()
			return rt.new_null()
		}
		'get_tax_class_costs' {
			return this.get_tax_class_costs()
		}
		'get_fees_from_cart' {
			this.get_fees_from_cart()
			return rt.new_null()
		}
		'get_shipping_from_cart' {
			this.get_shipping_from_cart()
			return rt.new_null()
		}
		'get_coupons_from_cart' {
			this.get_coupons_from_cart()
			return rt.new_null()
		}
		'sort_coupons_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sort_coupons_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_item_base_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_item_base_taxes(dispatch_arg_0)
		}
		'adjust_non_base_location_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_non_base_location_price(dispatch_arg_0)
		}
		'get_discounted_price_in_cents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price_in_cents(dispatch_arg_0)
		}
		'get_item_tax_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_tax_rates(dispatch_arg_0)
		}
		'get_item_costs_by_tax_class' {
			return this.get_item_costs_by_tax_class()
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_total(dispatch_arg_0, dispatch_arg_1)
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_total(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_totals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_totals(dispatch_arg_0)
		}
		'get_values_for_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_values_for_total(dispatch_arg_0)
		}
		'get_merged_taxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_merged_taxes(dispatch_arg_0, dispatch_arg_1)
		}
		'round_merged_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.round_merged_taxes(dispatch_arg_0)
		}
		'combine_item_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.combine_item_taxes(dispatch_arg_0)
		}
		'calculate_item_totals' {
			this.calculate_item_totals()
			return rt.new_null()
		}
		'calculate_item_subtotals' {
			this.calculate_item_subtotals()
			return rt.new_null()
		}
		'calculate_discounts' {
			this.calculate_discounts()
			return rt.new_null()
		}
		'calculate_fee_totals' {
			this.calculate_fee_totals()
			return rt.new_null()
		}
		'calculate_shipping_totals' {
			this.calculate_shipping_totals()
			return rt.new_null()
		}
		'calculate_totals' {
			this.calculate_totals()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Cart_Totals) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart' { return this.cart }
		'items' { return this.items }
		'fees' { return this.fees }
		'shipping' { return this.shipping }
		'coupons' { return this.coupons }
		'coupon_discount_totals' { return this.coupon_discount_totals }
		'coupon_discount_tax_totals' { return this.coupon_discount_tax_totals }
		'calculate_tax' { return rt.new_bool(this.calculate_tax) }
		'totals' { return this.totals }
		'item_tax_rates' { return this.item_tax_rates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cart_Totals) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart' { this.cart = val; return true }
		'items' { this.items = val; return true }
		'fees' { this.fees = val; return true }
		'shipping' { this.shipping = val; return true }
		'coupons' { this.coupons = val; return true }
		'coupon_discount_totals' { this.coupon_discount_totals = val; return true }
		'coupon_discount_tax_totals' { this.coupon_discount_tax_totals = val; return true }
		'calculate_tax' { this.calculate_tax = (val).to_bool(); return true }
		'totals' { this.totals = val; return true }
		'item_tax_rates' { this.item_tax_rates = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cart_totals_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
