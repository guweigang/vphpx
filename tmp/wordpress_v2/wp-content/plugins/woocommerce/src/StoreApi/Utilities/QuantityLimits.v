import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) get_cart_item_quantity_limits(var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product := if !(var_cart_item.array_get(rt.new_string('data'))).is_null() {
		var_cart_item.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Utilities_WC_Product'))))))
	{
		return rt.create_array([rt.ArrayItem{ key: 'minimum', val: 1 },
			rt.ArrayItem{ key: 'maximum', val: 9999 }, rt.ArrayItem{ key: 'multiple_of', val: 1 },
			rt.ArrayItem{ key: 'editable', val: true }])
	}
	return rt.call_function('array_merge', [
		this.get_add_to_cart_limits(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product),
			var_cart_item.clone()),
		rt.create_array([
			rt.ArrayItem{ key: 'editable', val: this.filter_boolean_value(rt.new_bool(!(rt.is_true(rt.call_method(var_product,
				'is_sold_individually', []rt.PhpVal{})))), 'editable', mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](var_product),
				var_cart_item.clone()) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) get_add_to_cart_limits(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_args := rt.call_function('wc_get_quantity_input_args', [
		rt.new_array(), var_product_mutated])
	mut var_minimum := this.filter_numeric_value(var_args.array_get(rt.new_string('min_value')),
		'minimum', mut var_product_mutated, var_cart_item.clone())
	mut var_maximum := this.filter_numeric_value(this.adjust_product_quantity_limit(var_args.array_get(rt.new_string('max_value')), mut
		var_product_mutated, var_cart_item.clone()), 'maximum', mut var_product_mutated,
		var_cart_item.clone())
	mut var_multiple_of := this.filter_numeric_value(var_args.array_get(rt.new_string('step')),
		'multiple_of', mut var_product_mutated, var_cart_item.clone())
	var_minimum = rt.call_function('max', [var_multiple_of.clone(),
		rt.new_int(this.limit_to_multiple(var_minimum.clone(), var_multiple_of.clone(), 'ceil'))])
	var_maximum = rt.call_function('max', [var_minimum.clone(),
		rt.new_int(this.limit_to_multiple(var_maximum.clone(), var_multiple_of.clone(), 'floor'))])
	return rt.create_array([rt.ArrayItem{ key: 'minimum', val: var_minimum },
		rt.ArrayItem{ key: 'maximum', val: var_maximum }, rt.ArrayItem{
			key: 'multiple_of'
			val: var_multiple_of
		}])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) normalize_cart_item_quantity(var_quantity rt.PhpVal, mut var_cart_item Class_Automattic_WooCommerce_StoreApi_Utilities_array) rt.PhpVal {
	mut var_quantity_mutated := var_quantity
	mut var_product := if !(var_cart_item.array_get(rt.new_string('data'))).is_null() {
		var_cart_item.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Utilities_WC_Product'))))))
	{
		return rt.call_function('wc_stock_amount', [var_quantity_mutated.clone()])
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_0 := iife_temp_0.normalize(var_quantity_mutated.clone())
	var_quantity_mutated = iife_result_0
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_quantity_mutated)) {
		return rt.call_function('wc_stock_amount', [rt.new_int(0)])
	}
	mut var_limits := this.get_cart_item_quantity_limits(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_array',
		[]string{}, var_cart_item))
	mut var_new_quantity := rt.new_int(this.limit_to_multiple(var_quantity_mutated.clone(),
		var_limits.array_get(rt.new_string('multiple_of')), 'round'))
	if rt.is_true(rt.less(var_new_quantity, var_limits.array_get(rt.new_string('minimum')))) {
		var_new_quantity = var_limits.array_get(rt.new_string('minimum'))
	}
	if rt.is_true(rt.greater(var_new_quantity, var_limits.array_get(rt.new_string('maximum')))) {
		var_new_quantity = var_limits.array_get(rt.new_string('maximum'))
	}
	return rt.call_function('wc_stock_amount', [var_new_quantity.clone()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) limit_to_multiple(var_number rt.PhpVal, var_multiple_of rt.PhpVal, rounding_function string) i64 {
	mut var_number_mutated := var_number
	mut var_multiple_of_mutated := var_multiple_of
	mut rounding_function_mutated := rounding_function
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_1 := iife_temp_1.normalize(var_number_mutated.clone(), rt.new_null())
	var_number_mutated = iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_2 := iife_temp_2.normalize(var_multiple_of_mutated.clone(), rt.new_null())
	var_multiple_of_mutated = iife_result_2
	if var_multiple_of_mutated.clone().is_null() || var_number_mutated.clone().is_null() {
		return 0
	}
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_multiple_of_mutated))
		|| this.is_multiple_of(var_number_mutated.clone(), var_multiple_of_mutated.clone()) {
		return var_number_mutated.to_i64()
	}
	rounding_function_mutated = if rt.is_true(rt.call_function('in_array', [
		rt.new_string(rounding_function_mutated).clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'ceil' },
			rt.ArrayItem{ key: none, val: 'floor' },
			rt.ArrayItem{ key: none, val: 'round' },
		]),
		rt.new_bool(true)]))
	{ rounding_function_mutated } else { 'round' }
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_3 := iife_temp_3.normalize(rt.mul(rt.call_callable(rt.new_string(rounding_function_mutated), [
		rt.div(var_number_mutated, var_multiple_of_mutated),
	]), var_multiple_of_mutated))
	return iife_result_3.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) is_multiple_of(var_number rt.PhpVal, var_multiple_of rt.PhpVal) bool {
	mut var_number_mutated := var_number
	mut var_multiple_of_mutated := var_multiple_of
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_multiple_of_mutated)) {
		return false
	}
	mut var_division_result := rt.div(var_number_mutated, var_multiple_of_mutated)
	return (rt.less(rt.call_function('abs', [
		rt.sub(var_division_result, rt.call_function('round', [
			var_division_result.clone()])),
	]), rt.new_float(0.0001))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) validate_cart_item_quantity(var_quantity rt.PhpVal, var_cart_item rt.PhpVal) bool {
	mut var_quantity_mutated := var_quantity
	mut var_limits := this.get_cart_item_quantity_limits(var_cart_item.clone())
	mut var_product := if !(var_cart_item.array_get(rt.new_string('data'))).is_null() {
		var_cart_item.array_get(rt.new_string('data'))
	} else {
		rt.new_bool(false)
	}
	var_quantity_mutated = rt.call_function('wc_stock_amount', [
		var_quantity_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_StoreApi_Utilities_WC_Product'))))))
	{
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_limits.array_get(rt.new_string('editable'))))))
		&& rt.is_true(rt.greater(var_quantity_mutated, var_limits.array_get(rt.new_string('maximum')))) {
		return (create_automattic_woocommerce_storeapi_utilities_wp_error(rt.new_string('readonly_quantity'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The quantity of &quot;%1$s&quot; cannot be changed'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
		]))).to_bool()
	}
	if rt.is_true(rt.less(var_quantity_mutated, var_limits.array_get(rt.new_string('minimum')))) {
		return (create_automattic_woocommerce_storeapi_utilities_wp_error(rt.new_string('invalid_quantity'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The minimum quantity of &quot;%1$s&quot; allowed in the cart is %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			var_limits.array_get(rt.new_string('minimum')),
		]))).to_bool()
	}
	if rt.is_true(rt.greater(var_quantity_mutated, var_limits.array_get(rt.new_string('maximum')))) {
		return (create_automattic_woocommerce_storeapi_utilities_wp_error(rt.new_string('invalid_quantity'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The maximum quantity of &quot;%1$s&quot; allowed in the cart is %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			var_limits.array_get(rt.new_string('maximum')),
		]))).to_bool()
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_4 := iife_temp_4.normalize(var_limits.array_get(rt.new_string('multiple_of')))
	if !(this.is_multiple_of(var_quantity_mutated.clone(), iife_result_4)) {
		return (create_automattic_woocommerce_storeapi_utilities_wp_error(rt.new_string('invalid_quantity'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The quantity of &quot;%1$s&quot; must be a multiple of %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			var_limits.array_get(rt.new_string('multiple_of')),
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) adjust_product_quantity_limit(var_purchase_limit rt.PhpVal, mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_limits := rt.create_array([
		rt.ArrayItem{
			key: none
			val: if rt.is_true(rt.greater(var_purchase_limit, rt.new_int(0))) {
				var_purchase_limit
			} else {
				rt.new_int(9999)
			}
		},
	])
	if rt.is_true(rt.call_method(var_product_mutated, 'managing_stock', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'backorders_allowed', []rt.PhpVal{}))))) {
		var_limits.array_push(this.get_remaining_stock(mut var_product_mutated))
	}
	return this.filter_numeric_value(rt.call_function('min', [
		rt.call_function('array_filter', [var_limits.clone()]),
	]), 'limit', mut var_product_mutated, var_cart_item.clone())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) get_remaining_stock(mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(rt.call_method(var_product_mutated, 'get_stock_quantity',
		[]rt.PhpVal{}).is_null()))
	{
		return rt.new_null()
	}
	mut var_reserve_stock := create_automattic_woocommerce_checkout_helpers_reservestock()
	mut var_reserved_stock := var_reserve_stock.get_reserved_stock(rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_WC_Product',
		[]string{}, var_product_mutated), this.get_draft_order_id())
	return rt.call_function('wc_stock_amount', [
		rt.sub(rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}),
			var_reserved_stock),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) filter_numeric_value(var_value rt.PhpVal, value_type string, mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_filtered_value := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_store_api_product_quantity_' + value_type),
		var_value.clone(),
		var_product_mutated,
		var_cart_item.clone(),
	])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_5 := iife_temp_5.normalize(var_filtered_value.clone(), var_value.clone())
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_6 := iife_temp_6.normalize(var_filtered_value.clone(), var_value.clone())
	return rt.call_function('wc_stock_amount', [iife_result_5])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) filter_boolean_value(var_value rt.PhpVal, value_type string, mut var_product Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product, var_cart_item rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_filtered_value := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_store_api_product_quantity_' + value_type),
		var_value.clone(),
		var_product_mutated,
		var_cart_item.clone(),
	])
	return if var_filtered_value.clone().is_bool() {
		var_filtered_value
	} else {
		var_value.to_bool()
	}
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_quantitylimits(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_checkout_helpers_reservestock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cart_item_quantity_limits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_item_quantity_limits(dispatch_arg_0)
		}
		'get_add_to_cart_limits' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_add_to_cart_limits(mut dispatch_arg_0, dispatch_arg_1)
		}
		'normalize_cart_item_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.normalize_cart_item_quantity(dispatch_arg_0, mut dispatch_arg_1)
		}
		'limit_to_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_int(this.limit_to_multiple(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'is_multiple_of' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_multiple_of(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_cart_item_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_cart_item_quantity(dispatch_arg_0, dispatch_arg_1))
		}
		'adjust_product_quantity_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.adjust_product_quantity_limit(dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_remaining_stock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_remaining_stock(mut dispatch_arg_0)
		}
		'filter_numeric_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.filter_numeric_value(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2,
				dispatch_arg_3)
		}
		'filter_boolean_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Utilities_WC_Product](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.filter_boolean_value(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2,
				dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_QuantityLimits) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
