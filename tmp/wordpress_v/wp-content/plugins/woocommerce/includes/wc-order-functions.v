import rt

fn wc_get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_map_legacy := { 'numberposts': 'limit', 'post_type': 'type', 'post_status': 'status', 'post_parent': 'parent', 'author': 'customer', 'email': 'billing_email', 'posts_per_page': 'limit', 'paged': 'page' }
	for var_from, var_to in var_map_legacy {
		if var_args.array_isset(rt.new_string(from)) {
			var_args.array_set(to, var_args.array_get(from))
		}
	}
	mut var_date_before := rt.new_bool(rt.new_bool(false))
	mut var_date_after := rt.new_bool(rt.new_bool(false))
	if !(!rt.is_true(var_args.array_get('date_before'))) {
		mut var_datetime := rt.call_function('wc_string_to_datetime', [var_args.array_get('date_before')])
		var_date_before = if rt.is_true(rt.call_function('strpos', [var_args.array_get('date_before'), rt.new_string(':')])) { rt.call_method(var_datetime, 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.call_method(var_datetime, 'date', [rt.new_string('Y-m-d')]) }
	}
	if !(!rt.is_true(var_args.array_get('date_after'))) {
		var_datetime = rt.call_function('wc_string_to_datetime', [var_args.array_get('date_after')])
		var_date_after = if rt.is_true(rt.call_function('strpos', [var_args.array_get('date_after'), rt.new_string(':')])) { rt.call_method(var_datetime, 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.call_method(var_datetime, 'date', [rt.new_string('Y-m-d')]) }
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_date_before) && rt.is_true(var_date_after))) {
		var_args.array_set('date_created', (var_date_after).str() + '...' + (var_date_before).str())
	} else if rt.is_true(var_date_before) {
		var_args.array_set('date_created', '<' + (var_date_before).str())
	} else if rt.is_true(var_date_after) {
		var_args.array_set('date_created', '>' + (var_date_after).str())
	}
	mut var_query := create_wc_order_query(var_args.dup())
	return var_query.get_orders()
}

fn wc_get_order(the_order bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_post_type')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.new_string('wc_get_order should not be called before post types are registered (woocommerce_after_register_post_type action)'), rt.new_string('2.5')])
		return false
	}
	return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'order_factory'), 'get_order', [rt.new_bool(the_order)])).to_bool()
}

fn wc_get_order_statuses() rt.PhpVal {
	mut var_order_statuses := rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending(), val: rt.call_function('_x', [rt.new_string('Pending payment'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing(), val: rt.call_function('_x', [rt.new_string('Processing'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold(), val: rt.call_function('_x', [rt.new_string('On hold'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed(), val: rt.call_function('_x', [rt.new_string('Completed'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.cancelled(), val: rt.call_function('_x', [rt.new_string('Cancelled'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded(), val: rt.call_function('_x', [rt.new_string('Refunded'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.failed(), val: rt.call_function('_x', [rt.new_string('Failed'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }])
	return rt.call_function('apply_filters', [rt.new_string('wc_order_statuses'), var_order_statuses.dup()])
}

fn wc_is_order_status(var_maybe_status rt.PhpVal) rt.PhpVal {
	mut var_order_statuses := wc_get_order_statuses()
	return rt.new_bool(var_order_statuses.array_isset(var_maybe_status))
}

fn wc_get_is_paid_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_paid_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }])])
}

fn wc_get_is_pending_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_pending_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }])])
}

fn wc_get_order_status_name(var_status rt.PhpVal) rt.PhpVal {
	mut var_special_statuses := rt.create_array([rt.ArrayItem{ key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()).str(), val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.trash()).str(), val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])
	mut var_statuses := rt.call_function('array_merge', [var_special_statuses.dup(), wc_get_order_statuses()])
	mut var_unprefixed := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.remove_status_prefix(arg_0) }(// unsupported expression: Expr_Cast_String)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_status.dup().is_string()))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('An invalid order status slug was supplied.'), rt.new_string('woocommerce')]), rt.new_string('9.6')])
	}
	return if !(var_statuses.array_get('wc-' + (var_unprefixed).str())).is_null() { var_statuses.array_get('wc-' + (var_unprefixed).str()) } else { var_unprefixed }
}

fn wc_generate_order_key(key string) string {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(key))) {
		key = (rt.call_function('wp_generate_password', [rt.new_int(13), rt.new_bool(false)])).str()
	}
	return 'wc_' + (rt.call_function('apply_filters', [rt.new_string('woocommerce_generate_order_key'), 'order_' + key])).str()
}

fn wc_get_order_id_by_order_key(var_order_key rt.PhpVal) rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order'))
	return rt.call_method(var_data_store, 'get_order_id_by_order_key', [var_order_key.dup()])
}

fn wc_get_order_types(for string) rt.PhpVal {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wc_order_types.dup().is_array()))))) {
		mut var_wc_order_types := rt.new_array()
	}
	mut var_order_types := rt.new_array()
	mut switch_val_1 := rt.new_string(for)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-count'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('exclude_from_order_count'))))) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-meta-boxes'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(var_args.array_get('add_order_meta_boxes')) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('view-orders'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('exclude_from_order_views'))))) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reports'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('exclude_from_order_reports'))))) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sales-reports'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('exclude_from_order_sales_reports'))))) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-webhooks'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('exclude_from_order_webhooks'))))) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cot-migration'))) {
		{
			mut iter_1 := var_wc_order_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_type := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_order_types.array_push(var_type.dup())
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('admin-menu'))) {
		var_order_types = rt.call_function('array_intersect', [rt.func_array_keys(var_wc_order_types.dup()), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'show_in_menu', val: 'woocommerce' }])])])
	} else {
		var_order_types = rt.func_array_keys(var_wc_order_types.dup())
	}
	return rt.call_function('apply_filters', [rt.new_string('wc_order_types'), var_order_types.dup(), rt.new_string(for)])
}

fn wc_get_order_type(var_type rt.PhpVal) bool {
	mut var_wc_order_types := rt.new_null()
	// unsupported statement: Stmt_Global
	if var_wc_order_types.array_isset(var_type) {
		return (var_wc_order_types.array_get(var_type)).to_bool()
	}
	return false
}

fn wc_register_order_type(var_type rt.PhpVal, var_args rt.PhpVal) bool {
	if rt.is_true(rt.call_function('post_type_exists', [var_type.dup()])) {
		return false
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wc_order_types.dup().is_array()))))) {
		mut var_wc_order_types := rt.new_array()
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.call_function('register_post_type', [var_type.dup(), var_args.dup()])])) {
		return false
	}
	mut var_order_type_args := { 'add_order_meta_boxes': rt.new_bool(true), 'exclude_from_order_count': rt.new_bool(false), 'exclude_from_order_views': rt.new_bool(false), 'exclude_from_order_webhooks': rt.new_bool(false), 'exclude_from_order_reports': rt.new_bool(false), 'exclude_from_order_sales_reports': rt.new_bool(false), 'class_name': rt.new_string('WC_Order') }
	var_args = rt.call_function('array_intersect_key', [var_args.dup(), var_order_type_args.dup()])
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_order_type_args.dup()])
	var_wc_order_types.array_set(var_type, var_args.dup())
	return true
}

fn wc_processing_order_count() rt.PhpVal {
	return rt.new_int(wc_orders_count(Class_Automattic_WooCommerce_Enums_OrderStatus.processing()))
}

fn wc_orders_count(var_status rt.PhpVal, type string) i64 {
	mut var_count := 0
	mut var_legacy_statuses := [Class_Automattic_WooCommerce_Enums_OrderStatus.draft(), Class_Automattic_WooCommerce_Enums_OrderStatus.trash()]
	var_status = if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.dup(), var_legacy_statuses.dup(), rt.new_bool(true)]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { 'wc-' + (var_status).str() } else { var_status }
	mut var_valid_types := wc_get_order_types('order-count')
	type = type.trim_space()
	mut var_types_for_count := if var_type.len > 0 && var_type != '0' {  } else {  }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_order_count_cache := 
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type_shadow := item_1.val
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return 0
}

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_order_query() &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Order_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_query()
		return rt.new_object('WC_Order_Query', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_OrderUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_orderutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_OrderUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_order_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
