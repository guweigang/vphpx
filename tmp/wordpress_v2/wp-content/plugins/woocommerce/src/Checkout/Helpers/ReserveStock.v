import rt

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	rt.PhpObjectBase
pub mut:
	enabled bool
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) construct() {
	this.enabled = rt.greater_equal(rt.call_function('get_option', [
		rt.new_string('woocommerce_schema_version'),
		rt.new_int(0),
	]), rt.new_int(430))
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) is_enabled() bool {
	return this.enabled
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) get_reserved_stock(var_product rt.PhpVal, exclude_order_id i64) i64 {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	if !(this.is_enabled()) {
		return 0
	}
	return (rt.call_function('wc_stock_amount', [
		rt.call_method(var_wpdb, 'get_var', [
			this.get_query_for_reserved_stock(rt.call_method(var_product_mutated,
				'get_stock_managed_by_id', []rt.PhpVal{}), exclude_order_id),
		]),
	])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) reserve_stock_for_order(var_order rt.PhpVal, minutes i64) {
	mut minutes_mutated := minutes
	minutes_mutated = if rt.is_true(rt.new_int(minutes_mutated)) { minutes_mutated } else { rt.new_int((rt.call_function('get_option', [
			rt.new_string('woocommerce_hold_stock_minutes'),
			rt.new_int(60),
		])).to_i64()) }
	minutes_mutated = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_hold_stock_minutes'),
		rt.new_int(minutes_mutated).clone(),
		var_order.clone(),
	])).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(minutes_mutated))))) || !(this.is_enabled()) {
		return
	}
	mut var_held_stock_notes := rt.new_array()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_items := rt.call_function('array_filter', [
		rt.call_method(var_order, 'get_items', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_rows := rt.new_array()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock',
			[]rt.PhpVal{})))))
		{
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Checkout_Helpers_ReserveStockException',
				[]string{}, create_automattic_woocommerce_checkout_helpers_reservestockexception(rt.new_string('woocommerce_product_out_of_stock'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('&quot;%s&quot; is out of stock and cannot be purchased.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			]), rt.new_int(403))))
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
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})) {
			continue
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
		mut var_managed_by_id := rt.call_method(var_product, 'get_stock_managed_by_id',
			[]rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_item_quantity := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_order_item_quantity'),
			rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}),
			var_order.clone(),
			var_item.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_rows.array_set(var_managed_by_id, if var_rows.array_isset(var_managed_by_id) {
			rt.add(var_rows.array_get(var_managed_by_id), var_item_quantity)
		} else {
			var_item_quantity
		})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if var_held_stock_notes.clone().array_count() < 5 {
			var_held_stock_notes.array_push(rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('- %1$s &times; %2$d'),
					rt.new_string('held stock note'), rt.new_string('woocommerce')]),
				rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{}),
				var_rows.array_get(var_managed_by_id),
			]))
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
	if !(!rt.is_true(var_rows)) {
		mut iter_2 := var_rows.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_quantity := item_2.val
			mut var_product_id := item_2.key
			this.reserve_stock_for_product(var_product_id.clone(), var_quantity.clone(),
				var_order.clone(), rt.new_int(minutes_mutated))
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
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Checkout_Helpers_ReserveStockException') {
		mut var_e := var_e_1.clone()
		this.release_stock_for_order(var_order.clone())
		rt.throw_exception(var_e)
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
	if !(!rt.is_true(var_held_stock_notes)) {
		mut var_remaining_count :=
			rt.new_int(var_rows.clone().array_count() - var_held_stock_notes.clone().array_count())
		if rt.is_true(rt.greater(var_remaining_count, rt.new_int(0))) {
			var_held_stock_notes.array_push(rt.call_function('sprintf', [
				rt.call_function('_nx', [rt.new_string('- ...and %d more item.'),
					rt.new_string('- ... and %d more items.'),
					var_remaining_count.clone(), rt.new_string('held stock note'),
					rt.new_string('woocommerce')]),
				var_remaining_count.clone(),
			]))
		}
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('_x', [
					rt.new_string('Stock hold of %1$s minutes applied to: %2$s'),
					rt.new_string('held stock note'),
					rt.new_string('woocommerce'),
				]),
				rt.new_int(minutes_mutated).clone(),
				rt.new_string('<br>' +(rt.call_function('implode', [rt.new_string('<br>'), var_held_stock_notes.clone()])).str()),
			]),
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
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) release_stock_for_order(var_order rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if !(this.is_enabled()) {
		return
	}
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'wc_reserved_stock'),
		rt.create_array([
			rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) reserve_stock_for_product(var_product_id rt.PhpVal, var_stock_quantity rt.PhpVal, var_order rt.PhpVal, var_minutes rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_minutes_mutated := var_minutes
	mut iife_temp_1 := Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('product'))
	mut var_product_data_store := iife_result_1
	mut var_query_for_stock := rt.call_method(var_product_data_store, 'get_query_for_stock', [
		var_product_id.clone(),
	])
	mut var_query_for_reserved_stock := this.get_query_for_reserved_stock(var_product_id.clone(), (rt.call_method(var_order,
		'get_id', []rt.PhpVal{})).to_i64())
	mut var_result := rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tINSERT INTO '), rt.get_property(var_wpdb,
				'wc_reserved_stock')),
				rt.new_string(' ( `order_id`, `product_id`, `stock_quantity`, `timestamp`, `expires` )\n\t\t\t\tSELECT %d, %d, %d, NOW(), ( NOW() + INTERVAL %d MINUTE ) FROM DUAL\n\t\t\t\tWHERE ( ')),
				var_query_for_stock), rt.new_string(' FOR UPDATE ) - ( ')),
				var_query_for_reserved_stock),
				rt.new_string(' FOR UPDATE ) >= %d\n\t\t\t\tON DUPLICATE KEY UPDATE `expires` = VALUES( `expires` ), `stock_quantity` = VALUES( `stock_quantity` )\n\t\t\t\t')),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			var_product_id.clone(),
			var_stock_quantity.clone(),
			var_minutes_mutated.clone(),
			var_stock_quantity.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Checkout_Helpers_ReserveStockException',
			[]string{}, create_automattic_woocommerce_checkout_helpers_reservestockexception(rt.new_string('woocommerce_product_not_enough_stock'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Not enough units of %s are available in stock to fulfil this order.'),
				rt.new_string('woocommerce'),
			]),
			if rt.is_true(var_product) {
				rt.call_method(var_product, 'get_name', []rt.PhpVal{})
			} else {
				'#' + var_product_id.str()
			},
		]), rt.new_int(403))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) get_query_for_reserved_stock(var_product_id rt.PhpVal, exclude_order_id i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_join := rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'),
		rt.new_string(' posts ON stock_table.`order_id` = posts.ID'))).str())
	mut var_where_status := rt.new_string(
		"posts.post_status IN ( 'wc-checkout-draft', '" + (Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending()).str() + "' )")
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_2) {
		var_join = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'prefix'),
			rt.new_string('wc_orders orders ON stock_table.`order_id` = orders.id'))).str())
		var_where_status = rt.new_string(
			"orders.status IN ( 'wc-checkout-draft', '" + (Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending()).str() + "' )")
	}
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COALESCE( SUM( stock_table.`stock_quantity` ), 0 ) FROM '), rt.get_property(var_wpdb,
			'wc_reserved_stock')), rt.new_string(' stock_table\n\t\t\tLEFT JOIN ')), var_join),
			rt.new_string('\n\t\t\tWHERE ')), var_where_status),
			rt.new_string('\n\t\t\tAND stock_table.`expires` > NOW()\n\t\t\tAND stock_table.`product_id` = %d\n\t\t\tAND stock_table.`order_id` != %d\n\t\t\t')),
		var_product_id.clone(),
		rt.new_int(exclude_order_id),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_query_for_reserved_stock'),
		var_query.clone(),
		var_product_id.clone(),
		rt.new_int(exclude_order_id),
	])
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_checkout_helpers_reservestock() &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock{
		PhpObjectBase: rt.PhpObjectBase{}
		enabled:       false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_checkout_helpers_reservestockexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_checkout_helpers_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_enabled' {
			return rt.new_bool(this.is_enabled())
		}
		'get_reserved_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.get_reserved_stock(dispatch_arg_0, dispatch_arg_1))
		}
		'reserve_stock_for_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.reserve_stock_for_order(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'release_stock_for_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.release_stock_for_order(dispatch_arg_0)
			return rt.new_null()
		}
		'reserve_stock_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.reserve_stock_for_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'get_query_for_reserved_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_query_for_reserved_stock(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enabled' { return rt.new_bool(this.enabled) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enabled' {
			this.enabled = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_ReserveStockException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Checkout_Helpers_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
