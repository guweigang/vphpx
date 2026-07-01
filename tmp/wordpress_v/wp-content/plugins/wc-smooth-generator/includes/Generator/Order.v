import rt

pub fn Class_WC_SmoothGenerator_Generator_Order.second_refund_probability() i64 {
	return 25
}
pub fn Class_WC_SmoothGenerator_Generator_Order.max_partial_refund_ratio() f64 {
	return 0.5
}
pub fn Class_WC_SmoothGenerator_Generator_Order.first_refund_max_days() i64 {
	return 60
}
pub fn Class_WC_SmoothGenerator_Generator_Order.second_refund_max_days() i64 {
	return 30
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_none() i64 {
	return 0
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_full() i64 {
	return 1
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_partial() i64 {
	return 2
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_multi() i64 {
	return 3
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_distribution_full_ratio() f64 {
	return 0.5
}
pub fn Class_WC_SmoothGenerator_Generator_Order.refund_distribution_partial_ratio() f64 {
	return 0.25
}
struct Class_WC_SmoothGenerator_Generator_Order {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Order.generate(save bool, var_assoc_args rt.PhpVal, var_date rt.PhpVal, var_include_coupon rt.PhpVal, var_refund_type rt.PhpVal) bool {
	mut var_date_mutated := var_date
	mut var_include_coupon_mutated := var_include_coupon
	mut var_refund_type_mutated := var_refund_type
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_order := create_wc_smoothgenerator_generator_wc_order()
	mut var_customer := Class_WC_SmoothGenerator_Generator_Order.get_customer()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_customer, 'WC_SmoothGenerator_Generator_WC_Customer')))))) {
		rt.call_function('error_log', [rt.new_string('Order generation failed: Could not generate or retrieve customer')])
		return false
	}
	mut var_products := Class_WC_SmoothGenerator_Generator_Order.get_random_products(1, 10)
	if !rt.is_true(var_products) {
		rt.call_function('error_log', [rt.new_string('Order generation failed: No products available to add to order')])
		return false
	}
	{
		mut iter_1 := var_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product := item_1.val
			mut var_quantity := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [rt.new_int(1), rt.new_int(10)])
			rt.call_method(var_order, 'add_product', [var_product.dup(), var_quantity.dup()])
		}
	}
	rt.call_method(var_order, 'set_customer_id', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_created_via', [rt.new_string('smooth-generator')])
	rt.call_method(var_order, 'set_currency', [rt.call_function('get_woocommerce_currency', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_first_name', [rt.call_method(var_customer, 'get_billing_first_name', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_last_name', [rt.call_method(var_customer, 'get_billing_last_name', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_address_1', [rt.call_method(var_customer, 'get_billing_address_1', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_address_2', [rt.call_method(var_customer, 'get_billing_address_2', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_email', [rt.call_method(var_customer, 'get_billing_email', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_phone', [rt.call_method(var_customer, 'get_billing_phone', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_city', [rt.call_method(var_customer, 'get_billing_city', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_postcode', [rt.call_method(var_customer, 'get_billing_postcode', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_state', [rt.call_method(var_customer, 'get_billing_state', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_country', [rt.call_method(var_customer, 'get_billing_country', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_billing_company', [rt.call_method(var_customer, 'get_billing_company', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_first_name', [rt.call_method(var_customer, 'get_shipping_first_name', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_last_name', [rt.call_method(var_customer, 'get_shipping_last_name', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_address_1', [rt.call_method(var_customer, 'get_shipping_address_1', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_address_2', [rt.call_method(var_customer, 'get_shipping_address_2', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_city', [rt.call_method(var_customer, 'get_shipping_city', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_postcode', [rt.call_method(var_customer, 'get_shipping_postcode', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_state', [rt.call_method(var_customer, 'get_shipping_state', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_country', [rt.call_method(var_customer, 'get_shipping_country', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_shipping_company', [rt.call_method(var_customer, 'get_shipping_company', []rt.PhpVal{})])
	if rt.is_true(rt.less_equal(rt.call_function('rand', [rt.new_int(0), rt.new_int(100)]), rt.new_int(20))) {
		mut var_country_code := rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{})
		mut var_calculate_tax_for := rt.create_array([rt.ArrayItem{ key: 'country', val: var_country_code }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'city', val: '' }])
		mut var_fee := create_wc_smoothgenerator_generator_wc_order_item_fee()
		mut var_randomAmount := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomFloat', [rt.new_int(2), rt.new_float(0.05), rt.new_int(100)])
		var_fee.set_name(rt.new_string('Extra Fee'))
		var_fee.set_amount(var_randomAmount.dup())
		var_fee.set_tax_class(rt.new_string(''))
		var_fee.set_tax_status(rt.new_string('taxable'))
		var_fee.set_total(var_randomAmount.dup())
		var_fee.calculate_taxes(var_calculate_tax_for.dup())
		rt.call_method(var_order, 'add_item', [var_fee])
	}
	mut var_status := Class_WC_SmoothGenerator_Generator_Order.get_status(var_assoc_args.dup())
	rt.call_method(var_order, 'set_status', [var_status.dup()])
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_date_mutated)) {
		var_date_mutated = Class_WC_SmoothGenerator_Generator_Order.get_date_created(var_assoc_args.dup())
	}
	// unsupported expression: Expr_AssignOp_Concat
	rt.call_method(var_order, 'set_date_created', [var_date_mutated.dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_include_coupon_mutated)) {
		var_include_coupon_mutated = rt.new_bool(rt.new_bool(!(!rt.is_true(var_assoc_args.array_get('coupons')))))
	}
	if rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('coupon-ratio')) && rt.is_true(rt.identical(rt.new_null(), var_include_coupon_mutated)))) {
		mut var_coupon_ratio := rt.new_float(rt.new_float(var_assoc_args.array_get('coupon-ratio').to_f64()))
		if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_coupon_ratio, rt.new_float(0))) || rt.is_true(rt.greater(var_coupon_ratio, rt.new_float(1))))) {
			var_coupon_ratio = rt.call_function('max', [rt.new_float(0), rt.call_function('min', [rt.new_float(1), var_coupon_ratio.dup()])])
		}
		if rt.is_true(rt.greater_equal(var_coupon_ratio, rt.new_float(1))) {
			var_include_coupon_mutated = rt.new_bool(rt.new_bool(true))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_coupon_ratio, rt.new_int(0))) && rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), rt.mul(var_coupon_ratio, rt.new_int(100)))))) {
			var_include_coupon_mutated = rt.new_bool(rt.new_bool(true))
		} else {
			var_include_coupon_mutated = rt.new_bool(rt.new_bool(false))
		}
	}
	if rt.is_true(var_include_coupon_mutated) {
		mut var_coupon := Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon()
		if rt.is_true(var_coupon) {
			mut var_apply_result := rt.call_method(var_order, 'apply_coupon', [var_coupon.dup()])
			if rt.is_true(rt.call_function('is_wp_error', [var_apply_result.dup()])) {
				rt.call_function('error_log', ['Coupon application failed: ' + (rt.call_method(var_apply_result, 'get_error_message', []rt.PhpVal{})).str() + ' (Coupon: ' + (rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).str() + ')'])
			} else {
				rt.call_method(var_order, 'calculate_totals', [rt.new_bool(true)])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.less(rt.call_function('strtotime', [var_date_mutated.dup()]), rt.call_function('strtotime', [rt.new_string('2024-01-09')])))))) {
		mut var_attribution_result := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_OrderAttribution{}; return temp.add_order_attribution_meta(arg_0, arg_1) }(var_order.dup(), var_assoc_args.dup())
		if rt.is_true(rt.new_bool(rt.is_true(var_attribution_result) && rt.is_true(rt.call_function('is_wp_error', [var_attribution_result.dup()])))) {
			rt.call_function('error_log', ['Order attribution meta addition failed: ' + (rt.call_method(var_attribution_result, 'get_error_message', []rt.PhpVal{})).str()])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('completed'), var_status)) || rt.is_true(rt.identical(rt.new_string('processing'), var_status)))) {
		mut var_date_paid := rt.call_function('date', [rt.new_string('Y-m-d H:i:s'), rt.add(rt.call_function('strtotime', [var_date_mutated.dup()]), rt.mul(rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(36)]), rt.get_constant('HOUR_IN_SECONDS')))])
		rt.call_method(var_order, 'set_date_paid', [var_date_paid.dup()])
		if rt.is_true(rt.identical(rt.new_string('completed'), var_status)) {
			mut var_date_completed := rt.call_function('date', [rt.new_string('Y-m-d H:i:s'), rt.add(rt.call_function('strtotime', [var_date_paid.dup()]), rt.mul(rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(36)]), rt.get_constant('HOUR_IN_SECONDS')))])
			rt.call_method(var_order, 'set_date_completed', [var_date_completed.dup()])
		}
	}
	if var_save {
		mut var_save_result := rt.call_method(var_order, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_save_result.dup()])) {
			rt.call_function('error_log', ['Order save failed: ' + (rt.call_method(var_save_result, 'get_error_message', []rt.PhpVal{})).str()])
			return false
		}
		if rt.is_true(rt.new_bool(var_assoc_args.array_isset(rt.new_string('refund-ratio')) && rt.is_true(rt.identical(rt.new_string('completed'), var_status)))) {
			if rt.is_true(rt.identical(rt.new_null(), var_refund_type_mutated)) {
				mut var_refund_ratio := rt.new_float(rt.new_float(var_assoc_args.array_get('refund-ratio').to_f64()))
				if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_refund_ratio, rt.new_float(0))) || rt.is_true(rt.greater(var_refund_ratio, rt.new_float(1))))) {
					var_refund_ratio = rt.call_function('max', [rt.new_float(0), rt.call_function('min', [rt.new_float(1), var_refund_ratio.dup()])])
				}
				var_refund_type_mutated = Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_none()
				if rt.is_true(rt.greater_equal(var_refund_ratio, rt.new_float(1))) {
					var_refund_type_mutated = Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full()
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_refund_ratio, rt.new_int(0))) && rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), rt.mul(var_refund_ratio, rt.new_int(100)))))) {
					var_refund_type_mutated = if rt.is_true(rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(1)])) { Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full() } else { Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial() }
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial(), var_refund_type_mutated)) && rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.second_refund_probability())))) {
						var_refund_type_mutated = Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi()
					}
				}
			}
			if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full(), var_refund_type_mutated)) {
				Class_WC_SmoothGenerator_Generator_Order.create_refund((var_order).to_bool(), rt.new_bool(false), rt.new_null(), rt.new_bool(true))
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial(), var_refund_type_mutated)) {
				Class_WC_SmoothGenerator_Generator_Order.create_refund((var_order).to_bool(), rt.new_bool(true), rt.new_null(), rt.new_bool(false))
				// unsupported statement: Stmt_Nop
			} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi(), var_refund_type_mutated)) {
				mut var_first_refund := Class_WC_SmoothGenerator_Generator_Order.create_refund((var_order).to_bool(), rt.new_bool(true), rt.new_null(), rt.new_bool(false))
				if rt.is_true(rt.new_bool(rt.is_true(var_first_refund) && rt.is_true(rt.new_bool(var_first_refund.dup().is_object())))) {
					Class_WC_SmoothGenerator_Generator_Order.create_refund((var_order).to_bool(), rt.new_bool(true), var_first_refund.dup(), rt.new_bool(false))
					// unsupported statement: Stmt_Nop
				}
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('smoothgenerator_order_generated'), var_order.dup()])
	return (var_order).to_bool()
}

fn Class_WC_SmoothGenerator_Generator_Order.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	var_amount_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Order{}; return temp.validate_batch_amount(arg_0) }(var_amount_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.dup()])) {
		rt.call_function('error_log', ['Batch generation failed: ' + (rt.call_method(var_amount_mutated, 'get_error_message', []rt.PhpVal{})).str()])
		return var_amount_mutated.dup()
	}
	mut var_coupons_remaining := rt.new_int(rt.new_int(0))
	if var_args.array_isset(rt.new_string('coupon-ratio')) {
		mut var_coupon_ratio := rt.new_float(rt.new_float(var_args.array_get('coupon-ratio').to_f64()))
		var_coupon_ratio = rt.call_function('max', [rt.new_float(0), rt.call_function('min', [rt.new_float(1), var_coupon_ratio.dup()])])
		var_coupons_remaining = // unsupported expression: Expr_Cast_Int
	}
	mut var_full_remaining := rt.new_int(rt.new_int(0))
	mut var_partial_remaining := rt.new_int(rt.new_int(0))
	mut var_multi_remaining := rt.new_int(rt.new_int(0))
	if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('refund-ratio')) && rt.is_true(rt.identical(, )))) {
		mut var_refund_ratio := rt.new_float()
		
	}
	
}

fn Class_WC_SmoothGenerator_Generator_Order.get_customer() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_date_created(var_assoc_args rt.PhpVal) rt.PhpVal {
}

fn Class_WC_SmoothGenerator_Generator_Order.get_status(var_assoc_args rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_random_products(min_amount i64, max_amount i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon() bool {
}

fn Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order rt.PhpVal, force_partial bool, var_previous_refund rt.PhpVal, var_force_full rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut force_partial_mutated := force_partial
	mut var_force_full_mutated := var_force_full
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refunded_quantities(var_existing_refunds rt.PhpVal) rt.PhpVal {
	mut var_existing_refunds_mutated := var_existing_refunds
}

fn Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item rt.PhpVal, var_refund_qty rt.PhpVal, var_original_qty rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_refund_qty_mutated := var_refund_qty
	mut var_original_qty_mutated := var_original_qty
}

fn Class_WC_SmoothGenerator_Generator_Order.build_full_refund_items(var_order rt.PhpVal, var_refunded_qty_by_item rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_refunded_qty_by_item_mutated := var_refunded_qty_by_item
}

fn Class_WC_SmoothGenerator_Generator_Order.build_partial_refund_items(var_order rt.PhpVal, var_refunded_qty_by_item rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_refunded_qty_by_item_mutated := var_refunded_qty_by_item
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(var_line_items rt.PhpVal) rt.PhpVal {
	mut var_line_items_mutated := var_line_items
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refund_date(var_order rt.PhpVal, var_previous_refund rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn Class_WC_SmoothGenerator_Generator_Order.generate_batch_dates(var_count rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Order {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_OrderAttribution {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_order() &Class_WC_SmoothGenerator_Generator_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator() &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_order() &Class_WC_SmoothGenerator_Generator_WC_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_order_item_fee() &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_orderattribution() &Class_WC_SmoothGenerator_Generator_OrderAttribution {
	mut obj := &Class_WC_SmoothGenerator_Generator_OrderAttribution{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.generate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Order.batch(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_customer' {
			return Class_WC_SmoothGenerator_Generator_Order.get_customer()
		}
		'get_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.get_date_created(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.get_status(dispatch_arg_0)
		}
		'get_random_products' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Order.get_random_products(dispatch_arg_0, dispatch_arg_1)
		}
		'get_or_create_coupon' {
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon())
		}
		'create_refund' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.create_refund(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'calculate_refunded_quantities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refunded_quantities(dispatch_arg_0)
		}
		'build_refund_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'build_full_refund_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_full_refund_items(dispatch_arg_0, dispatch_arg_1)
		}
		'build_partial_refund_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_partial_refund_items(dispatch_arg_0, dispatch_arg_1)
		}
		'calculate_refund_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(dispatch_arg_0)
		}
		'calculate_refund_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refund_date(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_batch_dates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.generate_batch_dates(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_order_php() {
}
