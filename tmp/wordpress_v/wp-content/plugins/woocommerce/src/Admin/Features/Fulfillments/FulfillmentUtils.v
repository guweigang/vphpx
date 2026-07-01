import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_pending_items(mut var_order Class_WC_Order, var_fulfillments rt.PhpVal, without_refunds bool) rt.PhpVal {
	mut var_items_in_fulfillments := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_all_items_of_fulfillments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](var_fulfillments))
	closure_2_fn := fn [var_order, var_without_refunds] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_order, var_without_refunds] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'item', val: var_item }, rt.ArrayItem{ key: 'qty', val: rt.add(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), if var_without_refunds { var_order.get_qty_refunded_for_item(rt.call_method(var_item, 'get_id', []rt.PhpVal{})) } else { rt.new_int(0) }) }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'item', val: var_item }, rt.ArrayItem{ key: 'qty', val: rt.add(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), if var_without_refunds { var_order.get_qty_refunded_for_item(rt.call_method(var_item, 'get_id', []rt.PhpVal{})) } else { rt.new_int(0) }) }])
	}
	mut var_order_items := rt.call_function('array_map', [rt.new_closure(closure_1_fn), if !(var_order.get_items()).is_null() { var_order.get_items() } else { rt.new_array() }])
	if !(!rt.is_true(var_items_in_fulfillments)) {
		{
			mut iter_1 := var_order_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				mut var_item_id := item_1.key
				if var_items_in_fulfillments.array_isset(var_item_id) {
					var_item.array_set('qty', rt.sub(var_item.array_get('qty'), var_items_in_fulfillments.array_get(var_item_id)))
				}
			}
		}
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.greater(var_item.array_get('qty'), rt.new_int(0))
	// unsupported statement: Stmt_Nop
	return rt.new_null()
	}
	return rt.call_function('array_filter', [var_order_items.dup(), rt.new_closure(closure_3_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_refunded_items(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_items_refunded := rt.new_array()
	{
		mut iter_1 := var_order.get_items().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			var_items_refunded.array_set(rt.call_method(var_item, 'get_id', []rt.PhpVal{}), rt.mul(// unsupported expression: Expr_UnaryMinus, var_order.get_qty_refunded_for_item(rt.call_method(var_item, 'get_id', []rt.PhpVal{}))))
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_qty := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.greater(var_qty, rt.new_int(0))
	// unsupported statement: Stmt_Nop
	return rt.new_null()
	}
	return rt.call_function('array_filter', [var_items_refunded.dup(), rt.new_closure(closure_4_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_fulfillment_items(mut var_order Class_WC_Order, mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) rt.PhpVal {
	mut var_fulfillment_items := rt.call_function('array_combine', [rt.call_function('array_column', [var_fulfillment.get_items(), rt.new_string('item_id')]), rt.call_function('array_column', [var_fulfillment.get_items(), rt.new_string('qty')])])
	closure_6_fn := fn [var_order] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_order] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'item', val: var_item }, rt.ArrayItem{ key: 'qty', val: rt.sub(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_order.get_qty_refunded_for_item(var_item.dup())) }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'item', val: var_item }, rt.ArrayItem{ key: 'qty', val: rt.sub(rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_order.get_qty_refunded_for_item(var_item.dup())) }])
	}
	mut var_order_items := rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_order.get_items()])
	closure_9_fn := fn [var_fulfillment_items] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn [var_fulfillment_items] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn [var_fulfillment_items] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_item.array_set('qty', var_fulfillment_items.array_get(var_item.array_get('item_id')))
	return var_item.dup()
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_fulfillment_items.array_isset(var_item.array_get('item_id')))
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	var_item.array_set('qty', var_fulfillment_items.array_get(var_item.array_get('item_id')))
	return var_item.dup()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_7_fn), rt.call_function('array_filter', [var_order_items.dup(), rt.new_closure(closure_8_fn)])])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.has_pending_items(mut var_order Class_WC_Order, mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) bool {
	mut var_pending_items := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_pending_items(mut var_order, var_fulfillments)
	return !(!rt.is_true(var_pending_items))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.calculate_order_fulfillment_status(mut var_order Class_WC_Order, var_fulfillments rt.PhpVal) string {
	mut var_has_fulfillments := rt.new_bool(rt.new_bool(!(!rt.is_true(var_fulfillments))))
	if rt.is_true(var_has_fulfillments) {
		mut var_pending_items := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_pending_items(mut var_order, (var_fulfillments).to_bool())
		mut var_all_fulfilled := rt.new_bool(rt.new_bool(true))
		mut var_some_fulfilled := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_fulfillments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_fulfillment := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_fulfillment, 'get_is_fulfilled', []rt.PhpVal{}))))) {
					var_all_fulfilled = rt.new_bool(rt.new_bool(false))
				} else {
					var_some_fulfilled = rt.new_bool(rt.new_bool(true))
				}
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_all_fulfilled) && !rt.is_true(var_pending_items))) {
			mut var_status := rt.new_string(rt.new_string('fulfilled'))
		} else if rt.is_true(var_some_fulfilled) {
			var_status = rt.new_string(rt.new_string('partially_fulfilled'))
		} else {
			var_status = rt.new_string(rt.new_string('unfulfilled'))
		}
	} else {
		var_status = rt.new_string(rt.new_string('no_fulfillments'))
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_calculate_order_fulfillment_status'), var_status.dup(), var_order, var_fulfillments.dup()])).str()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_all_items_of_fulfillments(mut var_fulfillments Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array) rt.PhpVal {
	mut var_items := rt.new_array()
	{
		mut iter_1 := var_fulfillments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fulfillment := item_1.val
			mut var_fulfillment_items := rt.call_method(var_fulfillment, 'get_items', []rt.PhpVal{})
			{
				mut iter_2 := var_fulfillment_items.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_item := item_2.val
					if !(var_items.array_isset(var_item.array_get('item_id'))) {
						var_items.array_set(var_item.array_get('item_id'), 0)
						// unsupported statement: Stmt_Nop
					}
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	return var_items.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_tracking_info_html(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) string {
	mut var_tracking_html := rt.new_string(rt.new_string(''))
	mut var_tracking_url := var_fulfillment.get_tracking_url()
	mut var_tracking_number := var_fulfillment.get_tracking_number()
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else if !(!rt.is_true(var_tracking_number)) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return (var_tracking_html).str()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status(mut var_order Class_WC_Order) string {
	if !(true) {
		return 'no_fulfillments'
	}
	return (if rt.is_true(var_order.meta_exists(rt.new_string('_fulfillment_status'))) { var_order.get_meta(rt.new_string('_fulfillment_status'), rt.new_bool(true)) } else { rt.new_string('no_fulfillments') }).str()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status_text(mut var_order Class_WC_Order) string {
	if !(true) {
		return ''
	}
	mut var_fulfillment_status := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status(mut var_order)
	mut var_fulfillment_status_text := rt.new_string(rt.new_string(''))
	mut switch_val_1 := var_fulfillment_status
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('fulfilled'))) {
		var_fulfillment_status_text = rt.new_string(' ' + (rt.call_function('__', [rt.new_string('It has been <mark class="fulfillment-status">Fulfilled</mark>.'), rt.new_string('woocommerce')])).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('partially_fulfilled'))) {
		var_fulfillment_status_text = rt.new_string(' ' + (rt.call_function('__', [rt.new_string('It has been <mark class="fulfillment-status">Partially fulfilled</mark>.'), rt.new_string('woocommerce')])).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('unfulfilled'))) {
		var_fulfillment_status_text = rt.new_string(' ' + (rt.call_function('__', [rt.new_string('It is currently <mark class="fulfillment-status">Unfulfilled</mark>.'), rt.new_string('woocommerce')])).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('no_fulfillments'))) {
		var_fulfillment_status_text = rt.new_string(' ' + (rt.call_function('__', [rt.new_string('It has <mark class="fulfillment-status">no fulfillments</mark> yet.'), rt.new_string('woocommerce')])).str())
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_order_fulfillment_status_text'), var_fulfillment_status_text.dup(), var_fulfillment_status.dup(), var_order])).str()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status_meta_query(var_statuses rt.PhpVal) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
	if rt.is_true(rt.new_bool(var_statuses_mutated.dup().is_string())) {
		var_statuses_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_statuses_mutated }])
	}
	mut var_valid_statuses := rt.call_function('array_filter', [var_statuses_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.class() }, rt.ArrayItem{ key: none, val: 'is_valid_order_fulfillment_status' }])])
	if !rt.is_true(var_valid_statuses) {
		return rt.new_array()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('no_fulfillments'), var_valid_statuses.dup(), rt.new_bool(true)])) {
		return rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_fulfillment_status' }, rt.ArrayItem{ key: 'value', val: var_valid_statuses }, rt.ArrayItem{ key: 'compare', val: 'IN' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_fulfillment_status' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'key', val: '_fulfillment_status' }, rt.ArrayItem{ key: 'value', val: var_valid_statuses }, rt.ArrayItem{ key: 'compare', val: 'IN' }])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.is_valid_order_fulfillment_status(mut var_status Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string) bool {
	mut var_status_mutated := var_status
	if rt.is_true(rt.new_bool(var_status_mutated.dup().is_null())) {
		return false
	}
	mut var_order_fulfillment_statuses := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_statuses()
	return (rt.call_function('in_array', [var_status_mutated.dup(), rt.func_array_keys(var_order_fulfillment_statuses.dup()), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.is_valid_fulfillment_status(mut var_status Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string) bool {
	mut var_status_mutated := var_status
	if rt.is_true(rt.new_bool(var_status_mutated.dup().is_null())) {
		return false
	}
	mut var_fulfillment_statuses := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_fulfillment_statuses()
	return (rt.call_function('in_array', [var_status_mutated.dup(), rt.func_array_keys(var_fulfillment_statuses.dup()), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_order_fulfillment_statuses'), Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_order_fulfillment_statuses()])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_fulfillment_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_fulfillment_statuses'), Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_fulfillment_statuses()])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_shipping_providers() rt.PhpVal {
	mut var_raw_providers := rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillment_shipping_providers'), rt.new_array()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_raw_providers.dup().is_array()))))) {
		return rt.new_array()
	}
	mut var_resolved := rt.new_array()
	{
		mut iter_1 := var_raw_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_provider, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider'))) {
				var_resolved.array_set(rt.call_method(var_provider, 'get_key', []rt.PhpVal{}), var_provider.dup())
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_provider.dup().is_string())) && rt.is_true(rt.call_function('class_exists', [var_provider.dup()])))) && rt.is_true(rt.call_function('is_subclass_of', [var_provider.dup(), Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider.class()])))) {
				mut var_instance := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [var_provider.dup()])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				unsafe { goto end_label_1 }

catch_label_1:
				mut var_e_1 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
					mut var_e := var_e_1.dup()
					continue
					unsafe { goto end_label_1 }
				}
				else {
					rt.throw_exception(var_e_1)
					unsafe { goto end_label_1 }
				}

end_label_1:
				var_resolved.array_set(rt.call_method(var_instance, 'get_key', []rt.PhpVal{}), var_instance.dup())
			}
		}
	}
	return var_resolved.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_order_fulfillment_statuses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'fulfilled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Fulfilled'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'background_color', val: '#C6E1C6' }, rt.ArrayItem{ key: 'text_color', val: '#13550F' }]) }, rt.ArrayItem{ key: 'partially_fulfilled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Partially fulfilled'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'background_color', val: '#C8D7E1' }, rt.ArrayItem{ key: 'text_color', val: '#003D66' }]) }, rt.ArrayItem{ key: 'unfulfilled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Unfulfilled'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'background_color', val: '#FBE5E5' }, rt.ArrayItem{ key: 'text_color', val: '#CC1818' }]) }, rt.ArrayItem{ key: 'no_fulfillments', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('No fulfillments'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'background_color', val: '#F0F0F0' }, rt.ArrayItem{ key: 'text_color', val: '#2F2F2F' }]) }])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_fulfillment_statuses() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'fulfilled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'is_fulfilled', val: true }, rt.ArrayItem{ key: 'background_color', val: '#C6E1C6' }, rt.ArrayItem{ key: 'text_color', val: '#13550F' }]) }, rt.ArrayItem{ key: 'unfulfilled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'is_fulfilled', val: false }, rt.ArrayItem{ key: 'background_color', val: '#FBE5E5' }, rt.ArrayItem{ key: 'text_color', val: '#CC1818' }]) }])
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.check_s10_upu_format(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[A-Z]{2}\\d{9}[A-Z]{2}$/'), rt.new_string(tracking_number_mutated).dup()])) {
		tracking_number_mutated = ().str()
	} else if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return 
	}
	
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_ups_1z_check_digit(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod7_check_digit(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod10_check_digit(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod11_check_digit(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_fedex_check_digit(tracking_number string) bool {
	mut tracking_number_mutated := tracking_number
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.resolve_provider_name(mut var_fulfillment Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) string {
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_pending_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_pending_items(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_refunded_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_refunded_items(mut dispatch_arg_0)
		}
		'get_fulfillment_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_fulfillment_items(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'has_pending_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.has_pending_items(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'calculate_order_fulfillment_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.calculate_order_fulfillment_status(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_all_items_of_fulfillments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_all_items_of_fulfillments(mut dispatch_arg_0)
		}
		'get_tracking_info_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_tracking_info_html(mut dispatch_arg_0))
		}
		'get_order_fulfillment_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status(mut dispatch_arg_0))
		}
		'get_order_fulfillment_status_text' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status_text(mut dispatch_arg_0))
		}
		'get_order_fulfillment_status_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_status_meta_query(dispatch_arg_0)
		}
		'is_valid_order_fulfillment_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.is_valid_order_fulfillment_status(mut dispatch_arg_0))
		}
		'is_valid_fulfillment_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.is_valid_fulfillment_status(mut dispatch_arg_0))
		}
		'get_order_fulfillment_statuses' {
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_order_fulfillment_statuses()
		}
		'get_fulfillment_statuses' {
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_fulfillment_statuses()
		}
		'get_shipping_providers' {
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_shipping_providers()
		}
		'get_default_order_fulfillment_statuses' {
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_order_fulfillment_statuses()
		}
		'get_default_fulfillment_statuses' {
			return Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.get_default_fulfillment_statuses()
		}
		'check_s10_upu_format' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.check_s10_upu_format(dispatch_arg_0))
		}
		'validate_ups_1z_check_digit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_ups_1z_check_digit(dispatch_arg_0))
		}
		'validate_mod7_check_digit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod7_check_digit(dispatch_arg_0))
		}
		'validate_mod10_check_digit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod10_check_digit(dispatch_arg_0))
		}
		'validate_mod11_check_digit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_mod11_check_digit(dispatch_arg_0))
		}
		'validate_fedex_check_digit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.validate_fedex_check_digit(dispatch_arg_0))
		}
		'resolve_provider_name' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils.resolve_provider_name(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentutils_php() {
	// unsupported statement: Stmt_Declare
}
