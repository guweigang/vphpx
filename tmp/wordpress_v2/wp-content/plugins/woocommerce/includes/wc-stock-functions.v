import rt

fn wc_update_product_stock(var_product_arg rt.PhpVal, var_stock_quantity rt.PhpVal, operation string, updating bool) bool {
	mut var_operation := operation
	mut var_updating := updating
	mut var_product := var_product_arg
	mut var_product_id_with_stock := rt.new_null()
	mut var_product_with_stock := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_new_stock := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product.clone(), rt.new_string('WC_Product')])))))
	{
		var_product = rt.call_function('wc_get_product', [var_product.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return false
	}
	if !(var_stock_quantity.clone().is_null())
		&& rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})) {
		var_product_id_with_stock = rt.call_method(var_product, 'get_stock_managed_by_id',
			[]rt.PhpVal{})
		var_product_with_stock = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product_id_with_stock, rt.call_method(var_product, 'get_id', []rt.PhpVal{}))))) { rt.call_function('wc_get_product', [
				var_product_id_with_stock.clone(),
			]) } else { var_product }
		mut iife_temp_0 := Class_WC_Data_Store{}
		mut iife_result_0 := iife_temp_0.load(rt.new_string('product'))
		var_data_store = iife_result_0
		if rt.is_true(rt.call_method(var_product_with_stock, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_variation_before_set_stock'),
				var_product_with_stock.clone(),
			])
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_before_set_stock'),
				var_product_with_stock.clone(),
			])
		}
		var_new_stock = rt.call_method(var_data_store, 'update_product_stock', [
			var_product_id_with_stock.clone(),
			var_stock_quantity.clone(),
			rt.new_string(operation),
		])
		rt.call_method(var_data_store, 'read_stock_quantity', [
			var_product_with_stock.clone(), var_new_stock.clone()])
		if !var_updating {
			rt.call_method(var_product_with_stock, 'save', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_method(var_product_with_stock, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_variation_set_stock'),
				var_product_with_stock.clone(),
			])
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_set_stock'),
				var_product_with_stock.clone(),
			])
		}
		return (rt.call_method(var_product_with_stock, 'get_stock_quantity', []rt.PhpVal{})).to_bool()
	}
	return (rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})).to_bool()
}

fn wc_update_product_stock_status(var_product_id rt.PhpVal, var_status rt.PhpVal) {
	mut var_product := rt.new_null()
	var_product = rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(var_product) {
		rt.call_method(var_product, 'set_stock_status', [var_status.clone()])
		rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
}

fn wc_maybe_reduce_stock_levels(var_order_id rt.PhpVal) {
	mut var_order := rt.new_null()
	mut var_stock_reduced := rt.new_null()
	mut var_trigger_reduce := rt.new_null()
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return
	}
	var_stock_reduced = rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}),
		'get_stock_reduced', [var_order_id.clone()])
	var_trigger_reduce = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_complete_reduce_order_stock'),
		rt.new_bool(!(rt.is_true(var_stock_reduced))),
		var_order_id.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_trigger_reduce)))) {
		return
	}
	wc_reduce_stock_levels(var_order.clone())
	rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'set_stock_reduced', [
		var_order_id.clone(),
		rt.new_bool(true),
	])
}

fn wc_maybe_increase_stock_levels(var_order_id rt.PhpVal) {
	mut var_order := rt.new_null()
	mut var_stock_reduced := rt.new_null()
	mut var_trigger_increase := rt.new_null()
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return
	}
	var_stock_reduced = rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}),
		'get_stock_reduced', [var_order_id.clone()])
	var_trigger_increase = rt.new_bool(var_stock_reduced.to_bool())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_trigger_increase)))) {
		return
	}
	wc_increase_stock_levels(var_order.clone())
	rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'set_stock_reduced', [
		var_order_id.clone(),
		rt.new_bool(false),
	])
}

fn wc_reduce_stock_levels(var_order_id_arg rt.PhpVal) {
	mut var_order_id := var_order_id_arg
	mut var_order := rt.new_null()
	mut var_changes := []rt.PhpVal{}
	mut var_item := rt.new_null()
	mut var_product := rt.new_null()
	mut var_item_stock_reduced := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_item_name := rt.new_null()
	mut var_new_stock := false
	mut var_change := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('is_a', [var_order_id.clone(),
		rt.new_string('WC_Order')]))
	{
		var_order = var_order_id.clone()
		var_order_id = rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	} else {
		var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_can_reduce_order_stock'), rt.new_bool(true), var_order.clone()]))))) {
		return
	}
	var_changes = []rt.PhpVal{}
	mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item_shadow := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_shadow, 'is_type', [
			rt.new_string('line_item'),
		])))))
		{
			continue
		}
		var_product = rt.call_method(var_item_shadow, 'get_product', []rt.PhpVal{})
		var_item_stock_reduced = rt.call_method(var_item_shadow, 'get_meta', [
			rt.new_string('_reduced_stock'),
			rt.new_bool(true),
		])
		if rt.is_true(var_item_stock_reduced) || rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))) {
			continue
		}
		var_qty = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_quantity'),
			rt.call_method(var_item_shadow, 'get_quantity', []rt.PhpVal{}),
			var_order.clone(),
			var_item_shadow.clone(),
		])
		var_item_name = rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		var_new_stock = wc_update_product_stock(var_product.clone(), var_qty.clone(), 'decrease')
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_new_stock).clone()])) {
			rt.call_method(var_order, 'add_order_note', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Unable to reduce stock for item %s.'),
						rt.new_string('woocommerce'),
					]),
					var_item_name.clone(),
				]),
				rt.new_bool(false),
				rt.new_bool(false),
				rt.create_array([
					rt.ArrayItem{
						key: 'note_group'
						val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error()
					},
				]),
			])
			continue
		}
		rt.call_method(var_item_shadow, 'add_meta_data', [
			rt.new_string('_reduced_stock'),
			var_qty.clone(),
			rt.new_bool(true),
		])
		rt.call_method(var_item_shadow, 'save', []rt.PhpVal{})
		var_change = {
			'product': var_product
			'from':    var_new_stock + var_qty
			'to':      rt.new_bool(var_new_stock)
		}
		var_changes << var_change.clone()
		rt.call_function('do_action', [
			rt.new_string('woocommerce_reduce_order_item_stock'),
			var_item_shadow.clone(),
			rt.create_array_from_native_map(var_change),
			var_order.clone(),
		])
	}
	wc_trigger_stock_change_notifications(var_order.clone(), rt.create_array_from_list(var_changes))
	rt.call_function('do_action', [rt.new_string('woocommerce_reduce_order_stock'),
		var_order.clone()])
}

fn wc_trigger_stock_change_notifications(var_order rt.PhpVal, var_changes rt.PhpVal) {
	mut var_order_notes := []rt.PhpVal{}
	mut var_no_stock_amount := rt.new_null()
	mut var_change := map[string]rt.PhpVal{}
	mut var_low_stock_amount := rt.new_null()
	if !rt.is_true(var_changes) {
		return
	}
	var_order_notes = []rt.PhpVal{}
	var_no_stock_amount = rt.call_function('absint', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_notify_no_stock_amount'),
			rt.new_int(0),
		]),
	])
	for var_change_shadow in var_changes {
		var_order_notes <<
			(rt.call_method(var_change_shadow['product'], 'get_name', []rt.PhpVal{})).str() +
			' (' + (var_change_shadow['from']).str() + '&rarr;' + (var_change_shadow['to']).str() + ')'
		var_low_stock_amount = rt.call_function('absint', [
			rt.new_int(wc_get_low_stock_amount(rt.call_function('wc_get_product', [
				rt.call_method(var_change_shadow['product'], 'get_id', []rt.PhpVal{}),
			]))),
		])
		if rt.is_true(rt.less_equal(var_change_shadow['to'], var_no_stock_amount)) {
			rt.call_function('do_action', [rt.new_string('woocommerce_no_stock'),
				rt.call_function('wc_get_product', [
					rt.call_method(var_change_shadow['product'], 'get_id', []rt.PhpVal{}),
				])])
		} else if rt.is_true(rt.less_equal(var_change_shadow['to'], var_low_stock_amount)) {
			rt.call_function('do_action', [rt.new_string('woocommerce_low_stock'),
				rt.call_function('wc_get_product', [
					rt.call_method(var_change_shadow['product'], 'get_id', []rt.PhpVal{}),
				])])
		}
		if rt.is_true(rt.less(var_change_shadow['to'], rt.new_int(0))) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_on_backorder'),
				rt.create_array([
					rt.ArrayItem{ key: 'product', val: rt.call_function('wc_get_product', [
						rt.call_method(var_change_shadow['product'], 'get_id', []rt.PhpVal{}),
					]) },
					rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'quantity', val: rt.call_function('abs', [
						rt.sub(var_change_shadow['from'], var_change_shadow['to']),
					]) },
				]),
			])
		}
	}
	rt.call_method(var_order, 'add_order_note', [
		rt.new_string(
			(rt.call_function('__', [rt.new_string('Stock levels reduced:'), rt.new_string('woocommerce')])).str() +
			' ' +(rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_order_notes)])).str()),
		rt.new_bool(false),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{
			key: 'note_group'
			val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock()
		}]),
	])
}

fn wc_trigger_stock_change_actions(var_product rt.PhpVal) {
	mut var_no_stock_amount := rt.new_null()
	mut var_low_stock_amount := rt.new_null()
	mut var_stock_quantity := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.call_method(var_product,
		'get_manage_stock', []rt.PhpVal{})))))
	{
		return
	}
	var_no_stock_amount = rt.call_function('absint', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_notify_no_stock_amount'),
			rt.new_int(0),
		]),
	])
	var_low_stock_amount = rt.call_function('absint', [
		rt.new_int(wc_get_low_stock_amount(var_product.clone())),
	])
	var_stock_quantity = rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_stock_quantity, var_no_stock_amount)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_no_stock'),
			var_product.clone()])
	} else if rt.is_true(rt.less_equal(var_stock_quantity, var_low_stock_amount)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_low_stock'),
			var_product.clone()])
	}
}

fn wc_increase_stock_levels(var_order_id_arg rt.PhpVal) {
	mut var_order_id := var_order_id_arg
	mut var_order := rt.new_null()
	mut var_changes := []rt.PhpVal{}
	mut var_item := rt.new_null()
	mut var_product := rt.new_null()
	mut var_item_stock_reduced := rt.new_null()
	mut var_item_name := rt.new_null()
	mut var_new_stock := false
	mut var_old_stock := rt.new_null()
	if rt.is_true(rt.call_function('is_a', [var_order_id.clone(),
		rt.new_string('WC_Order')]))
	{
		var_order = var_order_id.clone()
		var_order_id = rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	} else {
		var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_can_restore_order_stock'), rt.new_bool(true), var_order.clone()]))))) {
		return
	}
	var_changes = []rt.PhpVal{}
	mut iter_2 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item_shadow := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item_shadow, 'is_type', [
			rt.new_string('line_item'),
		])))))
		{
			continue
		}
		var_product = rt.call_method(var_item_shadow, 'get_product', []rt.PhpVal{})
		var_item_stock_reduced = rt.call_method(var_item_shadow, 'get_meta', [
			rt.new_string('_reduced_stock'),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item_stock_reduced))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))) {
			continue
		}
		var_item_name = rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		var_new_stock = wc_update_product_stock(var_product.clone(),
			var_item_stock_reduced.clone(), 'increase')
		var_old_stock = rt.sub(rt.new_bool(var_new_stock), var_item_stock_reduced)
		if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_new_stock).clone()])) {
			rt.call_method(var_order, 'add_order_note', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Unable to restore stock for item %s.'),
						rt.new_string('woocommerce'),
					]),
					var_item_name.clone(),
				]),
				rt.new_bool(false),
				rt.new_bool(false),
				rt.create_array([
					rt.ArrayItem{
						key: 'note_group'
						val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error()
					},
				]),
			])
			continue
		}
		rt.call_method(var_item_shadow, 'delete_meta_data', [
			rt.new_string('_reduced_stock'),
		])
		rt.call_method(var_item_shadow, 'save', []rt.PhpVal{})
		var_changes << var_item_name.str() + ' (' + var_old_stock.str() + '&rarr;' +
			var_new_stock.str() + ')'
		rt.call_function('do_action', [
			rt.new_string('woocommerce_restore_order_item_stock'),
			var_item_shadow.clone(),
			rt.new_bool(var_new_stock).clone(),
			var_old_stock.clone(),
			var_order.clone(),
		])
	}
	if rt.is_true(var_changes) {
		rt.call_method(var_order, 'add_order_note', [
			rt.new_string(
				(rt.call_function('__', [rt.new_string('Stock levels increased:'), rt.new_string('woocommerce')])).str() +
				' ' +(rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_changes)])).str()),
			rt.new_bool(false),
			rt.new_bool(false),
			rt.create_array([
				rt.ArrayItem{
					key: 'note_group'
					val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock()
				},
			]),
		])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_restore_order_stock'),
		var_order.clone()])
}

fn wc_get_held_stock_quantity(var_product rt.PhpVal, exclude_order_id i64) i64 {
	mut var_exclude_order_id := exclude_order_id
	mut var_reserve_stock := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hold_stock_for_checkout'),
		rt.call_function('wc_string_to_bool', [
			rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock'),
				rt.new_string('yes')]),
		]),
	])))))
	{
		return 0
	}
	var_reserve_stock = create_automattic_woocommerce_checkout_helpers_reservestock()
	return (var_reserve_stock.get_reserved_stock(var_product.clone(), rt.new_int(exclude_order_id))).to_i64()
}

fn wc_reserve_stock_for_order(var_order_arg rt.PhpVal) {
	mut var_order := var_order_arg
	mut var_reserve_stock := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hold_stock_for_checkout'),
		rt.call_function('wc_string_to_bool', [
			rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock'),
				rt.new_string('yes')]),
		]),
	])))))
	{
		return
	}
	var_order = if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) { var_order } else { rt.call_function('wc_get_order', [
			var_order.clone(),
		]) }
	if rt.is_true(var_order) {
		var_reserve_stock = create_automattic_woocommerce_checkout_helpers_reservestock()
		var_reserve_stock.reserve_stock_for_order(var_order.clone())
	}
}

fn wc_release_stock_for_order(var_order_arg rt.PhpVal) {
	mut var_order := var_order_arg
	mut var_reserve_stock := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_hold_stock_for_checkout'),
		rt.call_function('wc_string_to_bool', [
			rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock'),
				rt.new_string('yes')]),
		]),
	])))))
	{
		return
	}
	var_order = if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) { var_order } else { rt.call_function('wc_get_order', [
			var_order.clone(),
		]) }
	if rt.is_true(var_order) {
		var_reserve_stock = create_automattic_woocommerce_checkout_helpers_reservestock()
		var_reserve_stock.release_stock_for_order(var_order.clone())
	}
}

fn wc_release_coupons_for_order(var_order_arg rt.PhpVal, save bool) {
	mut var_save := save
	mut var_order := var_order_arg
	var_order = if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) { var_order } else { rt.call_function('wc_get_order', [
			var_order.clone(),
		]) }
	if rt.is_true(var_order) {
		rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}),
			'release_held_coupons', [var_order.clone(), rt.new_bool(save)])
	}
}

fn wc_get_low_stock_amount(var_product_arg rt.PhpVal) i64 {
	mut var_product := var_product_arg
	mut var_low_stock_amount := rt.new_null()
	var_low_stock_amount = rt.call_method(var_product, 'get_low_stock_amount', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string(''), var_low_stock_amount))
		&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		var_product = rt.call_function('wc_get_product', [
			rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}),
		])
		var_low_stock_amount = rt.call_method(var_product, 'get_low_stock_amount', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_low_stock_amount)) {
		var_low_stock_amount = rt.call_function('get_option', [
			rt.new_string('woocommerce_notify_low_stock_amount'),
			rt.new_int(2),
		])
	}
	return rt.new_int(var_low_stock_amount.to_i64())
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	rt.PhpObjectBase
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_complete'),
		rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'),
		rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'),
		rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold'),
		rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_cancelled'),
		rt.new_string('wc_maybe_increase_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_pending'),
		rt.new_string('wc_maybe_increase_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_checkout_order_created'),
		rt.new_string('wc_reserve_stock_for_order')])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_checkout_order_exception'),
		rt.new_string('wc_release_stock_for_order'),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_complete'),
		rt.new_string('wc_release_stock_for_order'), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_cancelled'),
		rt.new_string('wc_release_stock_for_order'), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'),
		rt.new_string('wc_release_stock_for_order'), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'),
		rt.new_string('wc_release_stock_for_order'), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold'),
		rt.new_string('wc_release_stock_for_order'), rt.new_int(11)])
}
