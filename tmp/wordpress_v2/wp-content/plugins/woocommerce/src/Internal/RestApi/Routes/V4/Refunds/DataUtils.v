import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) convert_line_items_to_internal_format(var_line_items rt.PhpVal, mut var_order Class_WC_Order) rt.PhpVal {
	mut var_prepared_line_items := rt.new_array()
	mut iter_1 := var_line_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_line_item := item_1.val
		if !(var_line_item.array_isset(rt.new_string('line_item_id'))
			&& var_line_item.array_isset(rt.new_string('quantity'))
			&& var_line_item.array_isset(rt.new_string('refund_total'))) {
			continue
		}
		if !(var_line_item.array_isset(rt.new_string('refund_tax'))) {
			mut var_original_item :=
				var_order.get_item(var_line_item.array_get(rt.new_string('line_item_id')))
			if rt.is_true(var_original_item) {
				mut var_original_taxes := rt.call_method(var_original_item, 'get_taxes',
					[]rt.PhpVal{})
				closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_amount := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_bool(var_amount.clone().is_long()
						|| var_amount.clone().is_double()
						&& rt.is_true(rt.greater(var_amount, rt.new_int(0))))
				}
				mut var_tax_totals := rt.call_function('array_filter', [if !(var_original_taxes.array_get(rt.new_string('total'))).is_null() {
					var_original_taxes.array_get(rt.new_string('total'))
				} else {
					rt.new_array()
				}, rt.new_closure(closure_1_fn)])
				mut var_tax_ids := rt.func_array_keys(var_tax_totals.clone())
				if !(!rt.is_true(var_tax_ids)) {
					mut var_tax_rates := this.build_tax_rates_array(mut var_order, mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](var_tax_ids))
					mut iife_temp_1 := Class_WC_Tax{}
					mut iife_result_1 := iife_temp_1.calc_inclusive_tax(rt.new_float((var_line_item.array_get(rt.new_string('refund_total'))).to_f64()),
						var_tax_rates.clone())
					mut var_calculated_taxes := iife_result_1
					mut var_price_decimals := rt.call_function('wc_get_price_decimals',
						[]rt.PhpVal{})
					closure_4_fn := fn [var_price_decimals] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_tax := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
						mut iife_result_3 := iife_temp_3.round(var_tax.clone(),
							var_price_decimals.clone())
						return iife_result_3
					}
					closure_6_fn := fn [var_price_decimals] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_tax := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
						mut iife_result_5 := iife_temp_5.round(var_tax.clone(),
							var_price_decimals.clone())
						return iife_result_5
					}
					var_calculated_taxes = rt.call_function('array_map', [
						rt.new_closure(closure_4_fn),
						var_calculated_taxes.clone(),
					])
					var_line_item.array_set('refund_tax',
						this.convert_proportional_taxes_to_schema_format(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](var_calculated_taxes)))
					mut var_total_tax := rt.call_function('array_sum', [
						var_calculated_taxes.clone()])
					mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
					mut iife_result_6 := iife_temp_6.round(rt.sub(var_line_item.array_get(rt.new_string('refund_total')),
						var_total_tax), var_price_decimals.clone())
					var_line_item.array_set('refund_total', iife_result_6)
				}
			}
		}
		var_prepared_line_items.array_set(var_line_item.array_get(rt.new_string('line_item_id')), rt.create_array([
			rt.ArrayItem{ key: 'qty', val: var_line_item.array_get(rt.new_string('quantity')) },
			rt.ArrayItem{
				key: 'refund_total'
				val: var_line_item.array_get(rt.new_string('refund_total'))
			},
			rt.ArrayItem{ key: 'refund_tax', val: this.convert_line_item_taxes_to_internal_format(if !(var_line_item.array_get(rt.new_string('refund_tax'))).is_null() {
				var_line_item.array_get(rt.new_string('refund_tax'))
			} else {
				rt.new_array()
			}) },
		]))
	}
	return var_prepared_line_items.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) convert_line_item_taxes_to_internal_format(var_line_item_taxes rt.PhpVal) rt.PhpVal {
	mut var_prepared_taxes := rt.new_array()
	mut iter_2 := var_line_item_taxes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_line_item_tax := item_2.val
		if !(var_line_item_tax.array_isset(rt.new_string('id'))
			&& var_line_item_tax.array_isset(rt.new_string('refund_total'))) {
			continue
		}
		var_prepared_taxes.array_set(var_line_item_tax.array_get(rt.new_string('id')),
			var_line_item_tax.array_get(rt.new_string('refund_total')))
	}
	return var_prepared_taxes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) calculate_refund_amount(mut var_line_items Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array) f64 {
	if !rt.is_true(var_line_items) {
		return (rt.new_null()).to_f64()
	}
	mut var_amount := rt.new_int(0)
	mut iter_3 := var_line_items.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_line_item := item_3.val
		if !(!rt.is_true(var_line_item.array_get(rt.new_string('refund_total'))))
			&& var_line_item.array_get(rt.new_string('refund_total')).is_long()
			|| var_line_item.array_get(rt.new_string('refund_total')).is_double() {
			var_amount = rt.add(var_amount, var_line_item.array_get(rt.new_string('refund_total')))
		}
		if !(!rt.is_true(var_line_item.array_get(rt.new_string('refund_tax'))))
			&& var_line_item.array_get(rt.new_string('refund_tax')).is_array() {
			mut iter_4 := var_line_item.array_get(rt.new_string('refund_tax')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_tax := item_4.val
				if !(!rt.is_true(var_tax.array_get(rt.new_string('refund_total'))))
					&& var_tax.array_get(rt.new_string('refund_total')).is_long()
					|| var_tax.array_get(rt.new_string('refund_total')).is_double() {
					var_amount = rt.add(var_amount,
						var_tax.array_get(rt.new_string('refund_total')))
				}
			}
		}
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_7 := iife_temp_7.round(var_amount.clone(), rt.call_function('wc_get_price_decimals',
		[]rt.PhpVal{}))
	return rt.new_float(iife_result_7.to_f64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) validate_line_items(var_line_items rt.PhpVal, mut var_order Class_WC_Order) bool {
	mut iter_5 := var_line_items.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_line_item := item_5.val
		mut var_line_item_id := if !(var_line_item.array_get(rt.new_string('line_item_id'))).is_null() {
			var_line_item.array_get(rt.new_string('line_item_id'))
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_line_item_id)))) {
			return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('__', [
				rt.new_string('Line item ID is required.'),
				rt.new_string('woocommerce'),
			]))).to_bool()
		}
		mut var_item := var_order.get_item(var_line_item_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_item, 'get_order_id', []rt.PhpVal{}), var_order.get_id())))) {
			return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('__', [
				rt.new_string('Line item not found.'),
				rt.new_string('woocommerce'),
			]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_WC_Order_Item_Product'))))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_WC_Order_Item_Fee'))))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_WC_Order_Item_Shipping')))))) {
			return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('__', [
				rt.new_string('Line item is not a product, fee, or shipping line.'),
				rt.new_string('woocommerce'),
			]))).to_bool()
		}
		if rt.is_true(rt.less(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
			var_line_item.array_get(rt.new_string('quantity'))))
		{
			return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Line item quantity cannot be greater than the item quantity (%s).'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
			]))).to_bool()
		}
		mut var_item_total_with_tax := rt.add(rt.call_method(var_item, 'get_total', []rt.PhpVal{}), rt.call_method(var_item,
			'get_total_tax', []rt.PhpVal{}))
		if rt.is_true(rt.less(var_item_total_with_tax,
			var_line_item.array_get(rt.new_string('refund_total'))))
		{
			return (create_wp_error(rt.new_string('invalid_refund_amount'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Refund total cannot be greater than the line item total including tax (%s).'),
					rt.new_string('woocommerce'),
				]),
				var_item_total_with_tax.clone(),
			]))).to_bool()
		}
		if var_line_item.array_isset(rt.new_string('refund_tax')) {
			mut var_item_taxes := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
			if rt.is_true(var_item_taxes) {
				mut var_allowed_tax_ids := rt.func_array_keys(if !(var_item_taxes.array_get(rt.new_string('total'))).is_null() {
					var_item_taxes.array_get(rt.new_string('total'))
				} else {
					rt.new_array()
				})
				mut iter_6 := var_line_item.array_get(rt.new_string('refund_tax')).iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_refund_tax := item_6.val
					if !(var_refund_tax.array_isset(rt.new_string('id'))
						&& var_refund_tax.array_isset(rt.new_string('refund_total'))) {
						return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('__', [
							rt.new_string('Tax id and refund_total are required.'),
							rt.new_string('woocommerce'),
						]))).to_bool()
					}
					mut var_tax_id := var_refund_tax.array_get(rt.new_string('id'))
					mut var_tax_refund_total :=
						var_refund_tax.array_get(rt.new_string('refund_total'))
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
						var_tax_id.clone(),
						var_allowed_tax_ids.clone(),
						rt.new_bool(true),
					])))))
					{
						return (create_wp_error(rt.new_string('invalid_line_item'), rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Line item tax not found. Must be: %s.'),
								rt.new_string('woocommerce'),
							]),
							rt.call_function('implode', [
								rt.new_string(', '),
								var_allowed_tax_ids.clone(),
							]),
						]))).to_bool()
					}
					if rt.is_true(rt.less(var_item_taxes.array_get(rt.new_string('total')).array_get(var_tax_id),
						var_tax_refund_total))
					{
						return (create_wp_error(rt.new_string('invalid_refund_amount'), rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Refund tax total cannot be greater than the line item tax total (%s).'),
								rt.new_string('woocommerce'),
							]),
							var_item_taxes.array_get(rt.new_string('total')).array_get(var_tax_id),
						]))).to_bool()
					}
				}
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) convert_proportional_taxes_to_schema_format(mut var_calculated_taxes Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array) rt.PhpVal {
	mut var_calculated_taxes_mutated := var_calculated_taxes
	mut var_result := rt.new_array()
	mut iter_7 := var_calculated_taxes_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_amount := item_7.val
		mut var_tax_id := item_7.key
		var_result.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.new_int(var_tax_id.to_i64()) },
			rt.ArrayItem{ key: 'refund_total', val: var_amount },
		]))
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) build_tax_rates_array(mut var_order Class_WC_Order, mut var_tax_ids Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array) rt.PhpVal {
	mut var_tax_ids_mutated := var_tax_ids
	mut var_tax_rates := rt.new_array()
	mut var_tax_items := var_order.get_items(Class_Automattic_WooCommerce_Enums_OrderItemType.tax())
	mut iter_8 := var_tax_ids_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_tax_id := item_8.val
		mut iter_9 := var_tax_items.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_tax_item := item_9.val
			if rt.is_true(rt.identical(rt.call_method(var_tax_item, 'get_rate_id', []rt.PhpVal{}),
				rt.new_int(var_tax_id.to_i64())))
			{
				var_tax_rates.array_set(var_tax_id, rt.create_array([
					rt.ArrayItem{ key: 'rate', val: rt.call_method(var_tax_item,
						'get_rate_percent', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'label', val: rt.call_method(var_tax_item, 'get_label',
						[]rt.PhpVal{}) },
					rt.ArrayItem{
						key: 'compound'
						val: if rt.is_true(rt.call_method(var_tax_item, 'is_compound',
							[]rt.PhpVal{}))
						{
							'yes'
						} else {
							'no'
						}
					},
				]))
				break
			}
		}
	}
	return var_tax_rates.clone()
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_refunds_datautils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils{
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

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convert_line_items_to_internal_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.convert_line_items_to_internal_format(dispatch_arg_0, mut dispatch_arg_1)
		}
		'convert_line_item_taxes_to_internal_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.convert_line_item_taxes_to_internal_format(dispatch_arg_0)
		}
		'calculate_refund_amount' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_float(this.calculate_refund_amount(mut dispatch_arg_0))
		}
		'validate_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.validate_line_items(dispatch_arg_0, mut dispatch_arg_1))
		}
		'convert_proportional_taxes_to_schema_format' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.convert_proportional_taxes_to_schema_format(mut dispatch_arg_0)
		}
		'build_tax_rates_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.build_tax_rates_array(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_DataUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
