import rt

fn wc_log_order_step(message string, var_context rt.PhpVal, final_step bool, first_step bool) {
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	if message == '' {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_first_step {
		mut var_logging_active := true
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_logging_active) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	// unsupported statement: Stmt_Static
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	// unsupported statement: Stmt_Static
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_order_uid := if rt.is_true(var_order_uid) { var_order_uid } else { rt.call_function('wp_generate_uuid4', []rt.PhpVal{}) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_order_uid_short := if rt.is_true(var_order_uid_short) { var_order_uid_short } else { rt.call_function('substr', [var_order_uid.dup(), rt.new_int(0), rt.new_int(8)]) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_store_url := if rt.is_true(var_store_url) { var_store_url } else { rt.call_function('get_site_url', []rt.PhpVal{}) }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_context.array_set('order_uid', var_order_uid.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_context.array_set('source', 'place-order-debug-' + (var_order_uid_short).str())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_context.array_set('store_url', var_store_url.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.instance_of(if !(var_context.array_get('order_object')).is_null() { var_context.array_get('order_object') } else { rt.new_null() }, 'WC_Order'))) {
		mut var_order := var_context.array_get('order_object')
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_context = rt.call_function('array_merge', [extract_order_safe_data(var_order.dup()), var_context.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_context.array_unset(rt.new_string('order_object'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_order, 'add_meta_data', [rt.new_string('_debug_log_source'), var_context.array_get('source'), rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('error_get_last', []rt.PhpVal{}).is_null()))))) {
		var_context.array_set('last_error', rt.call_function('error_get_last', []rt.PhpVal{}))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_context.array_set('backtrace', rt.call_function('debug_backtrace', [rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'), rt.new_int(3)]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_context.array_set('remote-logging', false)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_steps.array_push(message)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_logger, 'log', [Class_WC_Log_Levels.debug(), rt.new_string(message), var_context.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if var_final_step {
		if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.call_function('array_unique', [var_steps.dup()]).array_count() == var_steps.dup().array_count())) {
			rt.call_method(var_order, 'delete_meta_data', [rt.new_string('_debug_log_source')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.unknown_orders_data_store_in_use() }()) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_logger, 'WC_Logger'))) {
					rt.call_method(var_logger, 'clear', [var_context.array_get('source')])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			} else {
				rt.call_method(var_order, 'add_meta_data', [rt.new_string('_debug_log_source_pending_deletion'), var_context.array_get('source'), rt.new_bool(true)])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_method(var_order, 'save', []rt.PhpVal{})
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController.class()]), 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_Logging_OrderLogsDeletionProcessor.class()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_order = rt.new_null()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_logging_active = false
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_steps := rt.new_array()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		// unsupported statement: Stmt_Nop
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn extract_order_safe_data(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_data := { 'order_id': rt.call_method(var_order, 'get_id', []rt.PhpVal{}), 'payment_method': rt.call_method(var_order, 'get_payment_method_title', []rt.PhpVal{}), 'billing': { 'country': rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{}), 'state': rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{}) }, 'shipping': { 'country': rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{}), 'state': rt.call_method(var_order, 'get_shipping_state', []rt.PhpVal{}) }, 'used_coupons': rt.call_method(var_order, 'get_coupon_codes', []rt.PhpVal{}), 'totals': { 'subtotal': rt.call_method(var_order, 'get_subtotal', []rt.PhpVal{}), 'shipping': rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), 'tax': rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{}), 'discount': rt.call_method(var_order, 'get_discount_total', []rt.PhpVal{}), 'total': rt.call_method(var_order, 'get_total', []rt.PhpVal{}) } }
	{
		mut iter_1 := rt.call_method(var_order, 'get_tax_totals', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			var_order_data.array_get_mut('totals').array_get_mut('tax_breakdown').array_set(rt.get_property(var_tax, 'label'), rt.get_property(var_tax, 'amount'))
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			var_order_data.array_get_mut('cart_items').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_item_id }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_id', val: rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }]))
		}
	}
	{
		mut iter_1 := rt.call_method(var_order, 'get_shipping_methods', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			var_order_data.array_get_mut('shipping_methods').array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_method, 'get_method_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'label', val: rt.call_method(var_method, 'get_method_title', []rt.PhpVal{}) }]))
		}
	}
	return var_order_data.dup()
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_order_step_logger_functions_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
