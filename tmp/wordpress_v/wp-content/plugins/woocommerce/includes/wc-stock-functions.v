import rt

fn wc_update_product_stock(var_product rt.PhpVal, var_stock_quantity rt.PhpVal, operation string, updating bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')]))))) {
		var_product = rt.call_function('wc_get_product', [var_product.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_stock_quantity.dup().is_null()))))) && rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})))) {
		mut var_product_id_with_stock := rt.call_method(var_product, 'get_stock_managed_by_id', []rt.PhpVal{})
		mut var_product_with_stock := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('wc_get_product', [var_product_id_with_stock.dup()]) } else { var_product }
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product'))
		if rt.is_true(rt.call_method(var_product_with_stock, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			rt.call_function('do_action', [rt.new_string('woocommerce_variation_before_set_stock'), var_product_with_stock.dup()])
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_product_before_set_stock'), var_product_with_stock.dup()])
		}
		mut var_new_stock := rt.call_method(var_data_store, 'update_product_stock', [var_product_id_with_stock.dup(), var_stock_quantity.dup(), rt.new_string(operation)])
		rt.call_method(var_data_store, 'read_stock_quantity', [var_product_with_stock.dup(), var_new_stock.dup()])
		if !(var_updating) {
			rt.call_method(var_product_with_stock, 'save', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_method(var_product_with_stock, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			rt.call_function('do_action', [rt.new_string('woocommerce_variation_set_stock'), var_product_with_stock.dup()])
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_product_set_stock'), var_product_with_stock.dup()])
		}
		return (rt.call_method(var_product_with_stock, 'get_stock_quantity', []rt.PhpVal{})).to_bool()
	}
	return (rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})).to_bool()
}

fn wc_update_product_stock_status(var_product_id rt.PhpVal, var_status rt.PhpVal) {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(var_product) {
		rt.call_method(var_product, 'set_stock_status', [var_status.dup()])
		rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
}

fn wc_maybe_reduce_stock_levels(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	mut var_stock_reduced := rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'get_stock_reduced', [var_order_id.dup()])
	mut var_trigger_reduce := rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_reduce_order_stock'), rt.new_bool(!(rt.is_true(var_stock_reduced))), var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_trigger_reduce)))) {
		return rt.new_null()
	}
	wc_reduce_stock_levels(var_order.dup())
	rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'set_stock_reduced', [var_order_id.dup(), rt.new_bool(true)])
}

fn wc_maybe_increase_stock_levels(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_null()
	}
	mut var_stock_reduced := rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'get_stock_reduced', [var_order_id.dup()])
	mut var_trigger_increase := // unsupported expression: Expr_Cast_Bool
	if rt.is_true(rt.new_bool(!(rt.is_true(var_trigger_increase)))) {
		return rt.new_null()
	}
	wc_increase_stock_levels(var_order.dup())
	rt.call_method(rt.call_method(var_order, 'get_data_store', []rt.PhpVal{}), 'set_stock_reduced', [var_order_id.dup(), rt.new_bool(false)])
}

fn wc_reduce_stock_levels(var_order_id rt.PhpVal) {
	if rt.is_true(rt.call_function('is_a', [var_order_id.dup(), rt.new_string('WC_Order')])) {
		mut var_order := var_order_id.dup()
		var_order_id = rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	} else {
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_can_reduce_order_stock'), rt.new_bool(true), var_order.dup()]))))))) {
		return rt.new_null()
	}
	mut var_changes := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')]))))) {
				continue
			}
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			mut var_item_stock_reduced := rt.call_method(var_item, 'get_meta', [rt.new_string('_reduced_stock'), rt.new_bool(true)])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_item_stock_reduced) || rt.is_true(rt.new_bool(!(rt.is_true(var_product)))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))))) {
				continue
			}
			mut var_qty := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_quantity'), rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}), var_order.dup(), var_item.dup()])
			mut var_item_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
			mut var_new_stock := wc_update_product_stock(var_product.dup(), var_qty.dup(), 'decrease')
			if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_new_stock).dup()])) {
				rt.call_method(var_order, 'add_order_note', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to reduce stock for item %s.'), rt.new_string('woocommerce')]), var_item_name.dup()]), rt.new_bool(false), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.error() }])])
				continue
			}
			rt.call_method(var_item, 'add_meta_data', [rt.new_string('_reduced_stock'), var_qty.dup(), rt.new_bool(true)])
			rt.call_method(var_item, 'save', []rt.PhpVal{})
			mut var_change := { 'product': var_product, 'from': var_new_stock + var_qty, 'to': rt.new_bool(var_new_stock) }
			var_changes << var_change.dup()
			rt.call_function('do_action', [rt.new_string('woocommerce_reduce_order_item_stock'), var_item.dup(), var_change.dup(), var_order.dup()])
		}
	}
	wc_trigger_stock_change_notifications(var_order.dup(), var_changes.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_reduce_order_stock'), var_order.dup()])
}

fn wc_trigger_stock_change_notifications(var_order rt.PhpVal, var_changes rt.PhpVal) {
	if !rt.is_true(var_changes) {
		return rt.new_null()
	}
	mut var_order_notes := []rt.PhpVal{}
	mut var_no_stock_amount := rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_no_stock_amount'), rt.new_int(0)])])
	for var_change in var_changes {
		var_order_notes << (rt.call_method(var_change.array_get('product'), 'get_name', []rt.PhpVal{})).str() + ' (' + (var_change.array_get('from')).str() + '&rarr;' + (var_change.array_get('to')).str() + ')'
		mut var_low_stock_amount := rt.call_function('absint', [wc_get_low_stock_amount(rt.call_function('wc_get_product', [rt.call_method(var_change.array_get('product'), 'get_id', []rt.PhpVal{})]))])
		if rt.is_true(rt.less_equal(var_change.array_get('to'), var_no_stock_amount)) {
			rt.call_function('do_action', [rt.new_string('woocommerce_no_stock'), rt.call_function('wc_get_product', [rt.call_method(var_change.array_get('product'), 'get_id', []rt.PhpVal{})])])
		} else if rt.is_true(rt.less_equal(var_change.array_get('to'), var_low_stock_amount)) {
			rt.call_function('do_action', [rt.new_string('woocommerce_low_stock'), rt.call_function('wc_get_product', [rt.call_method(var_change.array_get('product'), 'get_id', []rt.PhpVal{})])])
		}
		if rt.is_true(rt.less(var_change.array_get('to'), rt.new_int(0))) {
			rt.call_function('do_action', [rt.new_string('woocommerce_product_on_backorder'), rt.create_array([rt.ArrayItem{ key: 'product', val: rt.call_function('wc_get_product', [rt.call_method(var_change.array_get('product'), 'get_id', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'quantity', val: rt.call_function('abs', [rt.sub(var_change.array_get('from'), var_change.array_get('to'))]) }])])
		}
	}
	rt.call_method(var_order, 'add_order_note', [(rt.call_function('__', [rt.new_string('Stock levels reduced:'), rt.new_string('woocommerce')])).str() + ' ' + (rt.call_function('implode', [rt.new_string(', '), var_order_notes.dup()])).str(), rt.new_bool(false), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock() }])])
}

fn wc_trigger_stock_change_actions(var_product rt.PhpVal) {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_no_stock_amount := rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_no_stock_amount'), rt.new_int(0)])])
	mut var_low_stock_amount := rt.call_function('absint', [wc_get_low_stock_amount(var_product.dup())])
	mut var_stock_quantity := rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	if rt.is_true(rt.less_equal(var_stock_quantity, var_no_stock_amount)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_no_stock'), var_product.dup()])
	} else if rt.is_true(rt.less_equal(var_stock_quantity, var_low_stock_amount)) {
		rt.call_function('do_action', [rt.new_string('woocommerce_low_stock'), var_product.dup()])
	}
}

fn wc_increase_stock_levels(var_order_id rt.PhpVal) {
	if rt.is_true(rt.call_function('is_a', [var_order_id.dup(), rt.new_string('WC_Order')])) {
		mut var_order := var_order_id.dup()
		var_order_id = rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	} else {
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_can_restore_order_stock'), rt.new_bool(true), var_order.dup()]))))))) {
		return rt.new_null()
	}
	mut var_changes := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item, 'is_type', [rt.new_string('line_item')]))))) {
				continue
			}
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			mut var_item_stock_reduced := rt.call_method(var_item, 'get_meta', [rt.new_string('_reduced_stock'), rt.new_bool(true)])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true()))) || rt.is_true(rt.new_bool(!(rt.is_true()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(, 'managing_stock', []rt.PhpVal{}))))))) {
				continue
			}
			mut var_item_name := rt.call_method(, 'get_name', []rt.PhpVal{})
			mut var_new_stock := 
			
		}
	}
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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




pub fn init_wp_content_plugins_woocommerce_includes_wc_stock_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_complete'), rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold'), rt.new_string('wc_maybe_reduce_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_cancelled'), rt.new_string('wc_maybe_increase_stock_levels')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_pending'), rt.new_string('wc_maybe_increase_stock_levels')])
}
