import rt

fn wc_log_order_step(message string, var_context_arg rt.PhpVal, final_step bool, first_step bool) {
	mut var_message := message
	mut var_final_step := final_step
	mut var_first_step := first_step
	mut var_context := var_context_arg
	mut var_logging_active := false
	mut var_order_uid := rt.new_null()
	mut var_order_uid_short := rt.new_null()
	mut var_store_url := rt.new_null()
	mut var_order := rt.new_null()
	mut var_logger := rt.new_null()
	mut var_steps := rt.new_null()
	mut var_e := rt.new_null()
	if message == '' {
		return if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_first_step {
		var_logging_active = true
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !var_logging_active {
		return if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_order_uid = if rt.is_true(var_order_uid) {
		var_order_uid
	} else {
		rt.call_function('wp_generate_uuid4', []rt.PhpVal{})
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_order_uid_short = if rt.is_true(var_order_uid_short) { var_order_uid_short } else { rt.call_function('substr', [
			var_order_uid.clone(),
			rt.new_int(0),
			rt.new_int(8),
		]) }
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_store_url = if rt.is_true(var_store_url) {
		var_store_url
	} else {
		rt.call_function('get_site_url', []rt.PhpVal{})
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_context.array_set('order_uid', var_order_uid.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_context.array_set('source', 'place-order-debug-' + var_order_uid_short.str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_context.array_set('store_url', var_store_url.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(if !(var_context.array_get(rt.new_string('order_object'))).is_null() {
		var_context.array_get(rt.new_string('order_object'))
	} else {
		rt.new_null()
	}, 'WC_Order')))
	{
		var_order = var_context.array_get(rt.new_string('order_object'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_context = rt.call_function('array_merge', [
			extract_order_safe_data(var_order.clone()),
			var_context.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_context.array_unset(rt.new_string('order_object'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_order, 'add_meta_data', [rt.new_string('_debug_log_source'),
			var_context.array_get(rt.new_string('source')), rt.new_bool(true)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(rt.call_function('error_get_last', []rt.PhpVal{}).is_null()) {
		var_context.array_set('last_error', rt.call_function('error_get_last', []rt.PhpVal{}))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_context.array_set('backtrace', rt.call_function('debug_backtrace', [
		rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
		rt.new_int(3),
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_context.array_set('remote-logging', false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_steps.array_push(message)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_logger, 'log', [Class_WC_Log_Levels.debug(),
		rt.new_string(message), var_context.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_final_step {
		if rt.is_true(var_order)
			&& rt.call_function('array_unique', [var_steps.clone()]).array_count() == var_steps.clone().array_count() {
			rt.call_method(var_order, 'delete_meta_data', [
				rt.new_string('_debug_log_source'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			mut iife_result_0 := iife_temp_0.unknown_orders_data_store_in_use()
			if rt.is_true(iife_result_0) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_logger, 'WC_Logger'))) {
					rt.call_method(var_logger, 'clear', [
						var_context.array_get(rt.new_string('source')),
					])
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			} else {
				rt.call_method(var_order, 'add_meta_data', [
					rt.new_string('_debug_log_source_pending_deletion'),
					var_context.array_get(rt.new_string('source')),
					rt.new_bool(true),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
					'get', [
					Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class(),
				]), 'enqueue_processor', [
					Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor.class(),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_order = rt.new_null()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_logging_active = false
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_steps = rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		var_e = var_e_1.clone()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn extract_order_safe_data(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_data := map[string]rt.PhpVal{}
	mut var_tax := rt.new_null()
	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_method := rt.new_null()
	var_order_data = {
		'order_id':       rt.call_method(var_order, 'get_id', []rt.PhpVal{})
		'payment_method': rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{})
		'billing':        {
			'country': rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})
			'state':   rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{})
		}
		'shipping':       {
			'country': rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{})
			'state':   rt.call_method(var_order, 'get_shipping_state', []rt.PhpVal{})
		}
		'used_coupons':   rt.call_method(var_order, 'get_coupon_codes', []rt.PhpVal{})
		'totals':         {
			'subtotal': rt.call_method(var_order, 'get_subtotal', []rt.PhpVal{})
			'shipping': rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{})
			'tax':      rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{})
			'discount': rt.call_method(var_order, 'get_discount_total', []rt.PhpVal{})
			'total':    rt.call_method(var_order, 'get_total', []rt.PhpVal{})
		}
	}
	mut iter_1 := rt.call_method(var_order, 'get_tax_totals', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax_shadow := item_1.val
		var_order_data.array_get_mut('totals').array_get_mut('tax_breakdown').array_set(rt.get_property(var_tax_shadow,
			'label'), rt.get_property(var_tax_shadow, 'amount'))
	}
	mut iter_2 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item_shadow := item_2.val
		mut var_item_id_shadow := item_2.key
		var_order_data.array_get_mut('cart_items').array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_item_id_shadow },
			rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_item_shadow, 'get_product_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'variation_id', val: rt.call_method(var_item_shadow,
				'get_variation_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_item_shadow, 'get_quantity',
				[]rt.PhpVal{}) },
		]))
	}
	mut iter_3 := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_method_shadow := item_3.val
		var_order_data.array_get_mut('shipping_methods').array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.call_method(var_method_shadow, 'get_method_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'label', val: rt.call_method(var_method_shadow, 'get_method_title',
				[]rt.PhpVal{}) },
		]))
	}
	return var_order_data.clone()
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
