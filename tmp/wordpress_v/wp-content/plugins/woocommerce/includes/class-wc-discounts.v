import rt

struct Class_WC_Discounts {
	rt.PhpObjectBase
pub mut:
		object rt.PhpVal = rt.new_null()
		items rt.PhpVal = rt.new_array()
		discounts rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Discounts) construct(var_object rt.PhpVal)  {
	if rt.is_true(rt.call_function('is_a', [var_object.dup(), rt.new_string('WC_Cart')])) {
		this.set_items_from_cart(var_object.dup())
	} else if rt.is_true(rt.call_function('is_a', [var_object.dup(), rt.new_string('WC_Order')])) {
		this.set_items_from_order(var_object.dup())
	}
}

fn (mut this Class_WC_Discounts) set_items(var_items rt.PhpVal)  {
	mut var_items_mutated := var_items
	this.items = var_items_mutated.dup()
	this.discounts = rt.new_array()
	rt.call_function('uasort', [this.items, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_by_price' }])])
}

fn (mut this Class_WC_Discounts) set_items_from_cart(var_cart rt.PhpVal)  {
	this.items = rt.new_array()
	this.discounts = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_cart.dup(), rt.new_string('WC_Cart')]))))) {
		return rt.new_null()
	}
	this.object = var_cart.dup()
	{
		mut iter_1 := rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cart_item := item_1.val
			mut var_key := item_1.key
			mut var_item := create_stdclass()
			rt.set_property(var_item, 'key', var_key.dup())
			rt.set_property(var_item, 'object', var_cart_item.dup())
			rt.set_property(var_item, 'product', var_cart_item.array_get('data'))
			rt.set_property(var_item, 'quantity', var_cart_item.array_get('quantity'))
			rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [rt.mul(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double)]))
			this.items.array_set(var_key, var_item.dup())
		}
	}
	rt.call_function('uasort', [this.items, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_by_price' }])])
}

fn (mut this Class_WC_Discounts) set_items_from_order(var_order rt.PhpVal)  {
	this.items = rt.new_array()
	this.discounts = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.dup(), rt.new_string('WC_Order')]))))) {
		return rt.new_null()
	}
	this.object = var_order.dup()
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_item := item_1.val
			mut var_item := create_stdclass()
			rt.set_property(var_item, 'key', rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}))
			rt.set_property(var_item, 'object', var_order_item.dup())
			rt.set_property(var_item, 'product', rt.call_method(var_order_item, 'get_product', []rt.PhpVal{}))
			rt.set_property(var_item, 'quantity', rt.call_method(var_order_item, 'get_quantity', []rt.PhpVal{}))
			rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [rt.call_method(var_order_item, 'get_subtotal', []rt.PhpVal{})]))
			if rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{})) {
				// unsupported expression: Expr_AssignOp_Plus
			}
			this.items.array_set(rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}), var_item.dup())
		}
	}
	rt.call_function('uasort', [this.items, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sort_by_price' }])])
}

fn (mut this Class_WC_Discounts) get_object() rt.PhpVal {
	return this.object
}

fn (mut this Class_WC_Discounts) get_items() rt.PhpVal {
	return this.items
}

fn (mut this Class_WC_Discounts) get_items_to_validate() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_get_items_to_validate'), this.get_items(), rt.new_object('WC_Discounts', []string{}, &this)])
}

fn (mut this Class_WC_Discounts) get_discount(var_key rt.PhpVal, in_cents bool) rt.PhpVal {
	mut var_item_discount_totals := this.get_discounts_by_item(in_cents)
	return if var_item_discount_totals.array_isset(var_key) { var_item_discount_totals.array_get(var_key) } else { rt.new_int(0) }
}

fn (mut this Class_WC_Discounts) get_discounts(in_cents bool) rt.PhpVal {
	mut var_discounts := this.discounts
	return if var_in_cents { var_discounts } else { rt.call_function('wc_remove_number_precision_deep', [var_discounts.dup()]) }
}

fn (mut this Class_WC_Discounts) get_discounts_by_item(in_cents bool) rt.PhpVal {
	mut var_discounts := this.discounts
	mut var_item_discount_totals := rt.cast_array(rt.call_function('array_shift', [var_discounts.dup()]))
	{
		mut iter_1 := var_discounts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item_discounts := item_1.val
			{
				mut iter_2 := var_item_discounts.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_item_discount := item_2.val
					mut var_item_key := item_2.key
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	return if var_in_cents { var_item_discount_totals } else { rt.call_function('wc_remove_number_precision_deep', [var_item_discount_totals.dup()]) }
}

fn (mut this Class_WC_Discounts) get_discounts_by_coupon(in_cents bool) rt.PhpVal {
	mut var_coupon_discount_totals := rt.call_function('array_map', [rt.new_string('array_sum'), this.discounts])
	return if var_in_cents { var_coupon_discount_totals } else { rt.call_function('wc_remove_number_precision_deep', [var_coupon_discount_totals.dup()]) }
}

fn (mut this Class_WC_Discounts) get_discounted_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.call_function('wc_remove_number_precision_deep', [this.get_discounted_price_in_cents(var_item_mutated)])
}

fn (mut this Class_WC_Discounts) get_discounted_price_in_cents(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.call_function('absint', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0) }(rt.sub(rt.get_property(var_item_mutated, 'price'), this.get_discount(rt.get_property(var_item_mutated, 'key'), true)))])
}

fn (mut this Class_WC_Discounts) apply_coupon(var_coupon rt.PhpVal, validate bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_coupon.dup(), rt.new_string('WC_Coupon')]))))) {
		return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_function('__', [rt.new_string('Invalid coupon'), rt.new_string('woocommerce')]))).to_bool()
	}
	mut var_is_coupon_valid := rt.new_bool(if var_validate { this.is_coupon_valid(var_coupon.dup()) } else { rt.new_bool(true) })
	if rt.is_true(rt.call_function('is_wp_error', [var_is_coupon_valid.dup()])) {
		return (var_is_coupon_valid).to_bool()
	}
	mut var_coupon_code := rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(this.discounts.array_isset(var_coupon_code)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.discounts.array_get(var_coupon_code).is_array()))))))) {
		this.discounts.array_set(var_coupon_code, rt.call_function('array_fill_keys', [rt.func_array_keys(this.items), rt.new_int(0)]))
	}
	mut var_items_to_apply := this.get_items_to_apply_coupon(var_coupon.dup())
	mut switch_val_1 := rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('percent'))) {
		this.apply_coupon_percent(var_coupon.dup(), var_items_to_apply.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_product'))) {
		this.apply_coupon_fixed_product(var_coupon.dup(), var_items_to_apply.dup(), rt.new_null())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_cart'))) {
		this.apply_coupon_fixed_cart(var_coupon.dup(), var_items_to_apply.dup(), rt.new_null())
	} else {
		this.apply_coupon_custom(var_coupon.dup(), var_items_to_apply.dup())
	}
	return true
}

fn (mut this Class_WC_Discounts) sort_by_price(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_price_1 := if rt.is_true(rt.greater(rt.get_property(var_a, 'quantity'), rt.new_int(1))) { rt.div(rt.get_property(var_a, 'price'), rt.get_property(var_a, 'quantity')) } else { rt.get_property(var_a, 'price') }
	mut var_price_2 := if rt.is_true(rt.greater(rt.get_property(var_b, 'quantity'), rt.new_int(1))) { rt.div(rt.get_property(var_b, 'price'), rt.get_property(var_b, 'quantity')) } else { rt.get_property(var_b, 'price') }
	if rt.is_true(rt.identical(var_price_1, var_price_2)) {
		return 0
	}
	return (if rt.is_true(rt.less(var_price_1, var_price_2)) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
}

fn (mut this Class_WC_Discounts) filter_products_with_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.greater(this.get_discounted_price_in_cents(var_item_mutated), rt.new_int(0))
}

fn (mut this Class_WC_Discounts) get_items_to_apply_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply := rt.new_array()
	{
		mut iter_1 := this.get_items_to_validate().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_to_apply := // unsupported expression: Expr_Clone
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), this.get_discounted_price_in_cents(var_item_to_apply.dup()))) || rt.is_true(rt.greater_equal(rt.new_int(0), rt.get_property(var_item_to_apply, 'quantity'))))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'is_valid_for_product', [rt.get_property(var_item_to_apply, 'product'), rt.get_property(var_item_to_apply, 'object')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'is_valid_for_cart', []rt.PhpVal{}))))))) {
				continue
			}
			var_items_to_apply.array_push(var_item_to_apply.dup())
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_get_items_to_apply'), var_items_to_apply.dup(), var_coupon.dup(), rt.new_object('WC_Discounts', []string{}, &this)])
}

fn (mut this Class_WC_Discounts) apply_coupon_percent(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_total_discount := rt.new_int(rt.new_int(0))
	mut var_cart_total := rt.new_int(rt.new_int(0))
	mut var_limit_usage_qty := rt.new_int(rt.new_int(0))
	mut var_applied_count := rt.new_int(rt.new_int(0))
	mut var_adjust_final_discount := rt.new_bool(rt.new_bool(true))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_limit_usage_qty = rt.call_method(var_coupon, 'get_limit_usage_to_x_items', []rt.PhpVal{})
	}
	mut var_coupon_amount := rt.call_method(var_coupon, 'get_amount', []rt.PhpVal{})
	{
		mut iter_1 := var_items_to_apply_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_discounted_price := this.get_discounted_price_in_cents(var_item.dup())
			mut var_price_to_discount := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_calc_discounts_sequentially'), rt.new_string('no')]))) { var_discounted_price } else { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0) }(rt.get_property(var_item, 'price')) }
			mut var_apply_quantity := if rt.is_true(rt.new_bool(rt.is_true(var_limit_usage_qty) && rt.is_true(rt.less(rt.sub(var_limit_usage_qty, var_applied_count), rt.get_property(var_item, 'quantity'))))) { rt.sub(var_limit_usage_qty, var_applied_count) } else { rt.get_property(var_item, 'quantity') }
			var_apply_quantity = rt.call_function('max', [rt.new_int(0), rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_get_apply_quantity'), var_apply_quantity.dup(), var_item.dup(), var_coupon.dup(), rt.new_object('WC_Discounts', []string{}, &this)])])
			var_price_to_discount = rt.mul(rt.div(var_price_to_discount, rt.get_property(var_item, 'quantity')), var_apply_quantity)
			mut var_discount := rt.call_function('floor', [rt.mul(var_price_to_discount, rt.div(var_coupon_amount, rt.new_int(100)))])
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_a', [this.object, rt.new_string('WC_Cart')])) && rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_coupon_get_discount_amount')])))) {
				mut var_filtered_discount := rt.call_function('wc_add_number_precision', [rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_get_discount_amount'), rt.call_function('wc_remove_number_precision', [var_discount.dup()]), rt.call_function('wc_remove_number_precision', [var_price_to_discount.dup()]), rt.get_property(var_item, 'object'), rt.new_bool(false), var_coupon.dup()])])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_discount = var_filtered_discount.dup()
					var_adjust_final_discount = rt.new_bool(rt.new_bool(false))
				}
			}
			var_discount = rt.call_function('wc_round_discount', [rt.call_function('min', [var_discounted_price.dup(), var_discount.dup()]), rt.new_int(0)])
			var_cart_total = rt.add(var_cart_total, var_price_to_discount)
			var_total_discount = rt.add(, )
			var_applied_count = 
			
		}
	}
}

fn (mut this Class_WC_Discounts) apply_coupon_fixed_product(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
}

fn (mut this Class_WC_Discounts) apply_coupon_fixed_cart(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
}

fn (mut this Class_WC_Discounts) apply_coupon_custom(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
}

fn (mut this Class_WC_Discounts) apply_coupon_remainder(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
}

fn (mut this Class_WC_Discounts) validate_coupon_exists(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_usage_limit(var_coupon rt.PhpVal) bool {
	return false
}

fn (mut this Class_WC_Discounts) validate_coupon_user_usage_limit(var_coupon rt.PhpVal, user_id i64) bool {
	mut user_id_mutated := user_id
}

fn (mut this Class_WC_Discounts) validate_coupon_expiry_date(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_minimum_amount(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_maximum_amount(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_product_ids(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_product_categories(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_sale_items(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_items(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_eligible_items(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_product_ids(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_product_categories(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) validate_coupon_allowed_emails(var_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Discounts) get_object_subtotal() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Discounts) is_coupon_valid(var_coupon rt.PhpVal) bool {
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_discounts(arg_0 rt.PhpVal) &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
		object: rt.new_null()
		items: rt.new_array()
		discounts: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items_from_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items_from_cart(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items_from_order(dispatch_arg_0)
			return rt.new_null()
		}
		'get_object' {
			return this.get_object()
		}
		'get_items' {
			return this.get_items()
		}
		'get_items_to_validate' {
			return this.get_items_to_validate()
		}
		'get_discount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_discount(dispatch_arg_0, dispatch_arg_1)
		}
		'get_discounts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts(dispatch_arg_0)
		}
		'get_discounts_by_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts_by_item(dispatch_arg_0)
		}
		'get_discounts_by_coupon' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts_by_coupon(dispatch_arg_0)
		}
		'get_discounted_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price(dispatch_arg_0)
		}
		'get_discounted_price_in_cents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price_in_cents(dispatch_arg_0)
		}
		'apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.apply_coupon(dispatch_arg_0, dispatch_arg_1))
		}
		'sort_by_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sort_by_price(dispatch_arg_0, dispatch_arg_1))
		}
		'filter_products_with_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_products_with_price(dispatch_arg_0)
		}
		'get_items_to_apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_to_apply_coupon(dispatch_arg_0)
		}
		'apply_coupon_percent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.apply_coupon_percent(dispatch_arg_0, dispatch_arg_1)
		}
		'apply_coupon_fixed_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_fixed_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_coupon_fixed_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_fixed_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_coupon_custom' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.apply_coupon_custom(dispatch_arg_0, dispatch_arg_1)
		}
		'apply_coupon_remainder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_remainder(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_coupon_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_exists(dispatch_arg_0))
		}
		'validate_coupon_usage_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_usage_limit(dispatch_arg_0))
		}
		'validate_coupon_user_usage_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.validate_coupon_user_usage_limit(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_coupon_expiry_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_expiry_date(dispatch_arg_0))
		}
		'validate_coupon_minimum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_minimum_amount(dispatch_arg_0))
		}
		'validate_coupon_maximum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_maximum_amount(dispatch_arg_0))
		}
		'validate_coupon_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_product_ids(dispatch_arg_0))
		}
		'validate_coupon_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_product_categories(dispatch_arg_0))
		}
		'validate_coupon_sale_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_sale_items(dispatch_arg_0))
		}
		'validate_coupon_excluded_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_items(dispatch_arg_0))
		}
		'validate_coupon_eligible_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_eligible_items(dispatch_arg_0))
		}
		'validate_coupon_excluded_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_product_ids(dispatch_arg_0))
		}
		'validate_coupon_excluded_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_product_categories(dispatch_arg_0))
		}
		'validate_coupon_allowed_emails' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_allowed_emails(dispatch_arg_0))
		}
		'get_object_subtotal' {
			return this.get_object_subtotal()
		}
		'is_coupon_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_coupon_valid(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object' { return this.object }
		'items' { return this.items }
		'discounts' { return this.discounts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object' { this.object = val; return true }
		'items' { this.items = val; return true }
		'discounts' { this.discounts = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_discounts_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
