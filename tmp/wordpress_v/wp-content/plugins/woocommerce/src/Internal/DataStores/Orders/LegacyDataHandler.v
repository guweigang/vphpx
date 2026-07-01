import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler {
	rt.PhpObjectBase
pub mut:
		data_store rt.PhpVal = rt.new_null()
		data_synchronizer rt.PhpVal = rt.new_null()
		posts_to_cot_migrator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) init(mut var_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer, mut var_posts_to_cot_migrator Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController)  {
	mut var_data_store_mutated := var_data_store
	this.data_store = var_data_store_mutated.dup()
	this.data_synchronizer = var_data_synchronizer.dup()
	this.posts_to_cot_migrator = var_posts_to_cot_migrator.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) count_orders_for_cleanup(var_order_ids rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (// unsupported expression: Expr_Cast_Int).to_i64()
	// unsupported statement: Stmt_Nop
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_orders_for_cleanup(var_order_ids rt.PhpVal, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_wpdb, 'get_col', [this.build_sql_query_for_cleanup(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_order_ids), 'ids', limit)])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) build_sql_query_for_cleanup(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, result string, limit i64) string {
	mut var_wpdb := rt.new_null()
	mut var_matches := rt.new_null()
	mut result_mutated := result
	// unsupported statement: Stmt_Global
	mut var_hpos_orders_table := rt.call_method(this.data_store, 'get_orders_table_name', []rt.PhpVal{})
	mut var_sql_where := rt.new_string(rt.new_string(''))
	if rt.is_true(var_order_ids) {
		mut var_where_ids := rt.new_array()
		mut var_where_ranges := rt.new_array()
		{
			mut iter_1 := var_order_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_arg := item_1.val
				if rt.is_true(rt.new_bool(var_arg.dup().is_long() || var_arg.dup().is_double())) {
					var_where_ids.array_push(rt.call_function('absint', [var_arg.dup()]))
				} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d+)-(\\d+)$/'), var_arg.dup(), var_matches.dup()])) {
					var_where_ranges.array_push(rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID >= %d AND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID <= %d)')), rt.call_function('absint', [var_matches.array_get(1)]), rt.call_function('absint', [var_matches.array_get(2)])]))
				}
			}
		}
		if rt.is_true(var_where_ids) {
			var_where_ranges.array_push(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID IN (')) + (rt.call_function('implode', [rt.new_string(','), var_where_ids.dup()])).str() + ')')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_where_ranges)))) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(result_mutated))) {
		mut var_sql_fields := rt.new_string(rt.new_string('COUNT(*)'))
		mut var_sql_limit := rt.new_string(rt.new_string(''))
	} else {
		var_sql_fields = rt.new_string(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID')))
		var_sql_limit = if limit > 0 { rt.call_method(var_wpdb, 'prepare', [rt.new_string('LIMIT %d'), rt.new_int(limit)]) } else { rt.new_string('') }
	}
	mut var_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_sql_fields), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' LEFT JOIN ')), var_hpos_orders_table), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), var_hpos_orders_table), rt.new_string('.id WHERE ')), var_sql_where), rt.new_string(' ')), var_sql_limit))
	return (var_sql).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) cleanup_post_data(order_id i64, skip_checks bool)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_type := rt.call_function('get_post_type', [rt.new_int(order_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.dup(), rt.call_function('array_merge', [rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')]), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":160,"var":{"nodeType":"Expr_Variable","line":160,"name":"this"},"name":"data_synchronizer"}.placeholder_order_post_type() }])]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d is not of a valid order type.'), rt.new_string('woocommerce')]), rt.new_int(order_id)])]))))
	}
	mut var_order_exists := rt.call_method(this.data_store, 'order_exists', [rt.new_int(order_id)])
	if rt.is_true(var_order_exists) {
		mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d is not a valid order ID.'), rt.new_string('woocommerce')]), rt.new_int(order_id)])]))))
		}
		if !(var_skip_checks) && !(this.is_order_newer_than_post(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Data in posts table appears to be more recent than in HPOS tables. Compare order data with `wp wc hpos diff %1$d` and use `wp wc hpos backfill %1$d --from=posts --to=hpos` to fix.'), rt.new_string('woocommerce')]), rt.new_int(order_id)])]))))
		}
	}
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'post_id', val: order_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	if rt.is_true(var_order_exists) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":187,"var":{"nodeType":"Expr_Variable","line":187,"name":"this"},"name":"data_synchronizer"}.placeholder_order_post_type() }, rt.ArrayItem{ key: 'post_status', val: 'draft' }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: order_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	} else {
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'ID', val: order_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	}
	rt.call_function('clean_post_cache', [rt.new_int(order_id)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) is_order_newer_than_post(mut var_order Class_WC_Abstract_Order) bool {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.call_method(rt.call_method(var_order_mutated, 'get_data_store', []rt.PhpVal{}), 'get_current_class_name', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class(), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html__', [rt.new_string('Order is not an HPOS order.'), rt.new_string('woocommerce')]))))
	}
	mut var_post := rt.call_function('get_post', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":214,"var":{"nodeType":"Expr_Variable","line":214,"name":"this"},"name":"data_synchronizer"}.placeholder_order_post_type(), rt.get_property(var_post, 'post_type'))))) {
		return true
	}
	mut var_order_modified_gmt := if !(rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{})).is_null() { rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{}) } else { rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}) }
	var_order_modified_gmt = if rt.is_true(var_order_modified_gmt) { rt.call_method(var_order_modified_gmt, 'getTimestamp', []rt.PhpVal{}) } else { rt.new_int(0) }
	mut var_post_modified_gmt := if !(rt.get_property(var_post, 'post_modified_gmt')).is_null() { rt.get_property(var_post, 'post_modified_gmt') } else { rt.get_property(var_post, 'post_date_gmt') }
	var_post_modified_gmt = if rt.is_true(rt.new_bool(rt.is_true(var_post_modified_gmt) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { rt.call_function('wc_string_to_timestamp', [var_post_modified_gmt.dup()]) } else { rt.new_int(0) }
	return (rt.greater_equal(var_order_modified_gmt, var_post_modified_gmt)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_diff_for_order(order_id i64) rt.PhpVal {
	mut var_diff := rt.new_array()
	mut var_hpos_order := this.get_order_from_datastore(order_id, 'hpos')
	mut var_cpt_order := this.get_order_from_datastore(order_id, 'posts')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_diff.array_set('type', rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_hpos_order, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_cpt_order, 'get_type', []rt.PhpVal{}) }]))
	}
	mut var_hpos_meta := this.order_meta_to_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](var_hpos_order))
	mut var_cpt_meta := this.order_meta_to_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](var_cpt_order))
	mut var_all_keys := rt.call_function('array_unique', [rt.call_function('array_diff', [rt.call_function('array_merge', [this.get_order_base_props(), rt.func_array_keys(var_hpos_meta.dup()), rt.func_array_keys(var_cpt_meta.dup())]), rt.call_method(this.data_synchronizer, 'get_ignored_order_props', []rt.PhpVal{})])])
	{
		mut iter_1 := var_all_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			mut var_val1 := if rt.is_true(rt.call_function('in_array', [var_key.dup(), this.get_order_base_props(), rt.new_bool(true)])) { rt.call_method(var_hpos_order, "get_${var_key.to_string()}", []rt.PhpVal{}) } else { if !(var_hpos_meta.array_get(var_key)).is_null() { var_hpos_meta.array_get(var_key) } else { rt.new_null() } }
			mut var_val2 := if rt.is_true(rt.call_function('in_array', [var_key.dup(), this.get_order_base_props(), rt.new_bool(true)])) { rt.call_method(var_cpt_order, "get_${var_key.to_string()}", []rt.PhpVal{}) } else { if !(var_cpt_meta.array_get(var_key)).is_null() { var_cpt_meta.array_get(var_key) } else { rt.new_null() } }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_val2)))) && rt.is_true(rt.call_function('in_array', [var_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '_billing_address_index' }, rt.ArrayItem{ key: none, val: '_shipping_address_index' }]), rt.new_bool(true)])))) {
				var_val2 = rt.call_function('get_post_meta', [rt.new_int(order_id), var_key.dup(), rt.new_bool(true)])
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
				var_diff.array_set(var_key, rt.create_array([rt.ArrayItem{ key: none, val: var_val1 }, rt.ArrayItem{ key: none, val: var_val2 }]))
			}
		}
	}
	return var_diff.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_order_from_datastore(order_id i64, data_store_id string) rt.PhpVal {
	mut var_data_store := if rt.is_true(rt.identical(rt.new_string('hpos'), rt.new_string(data_store_id))) { this.data_store } else { rt.call_method(this.data_store, 'get_cpt_data_store_instance', []rt.PhpVal{}) }
	rt.call_function('wp_cache_delete', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order{}; return temp.generate_meta_cache_key(arg_0, arg_1) }(rt.new_int(order_id), rt.new_string('orders')), rt.new_string('orders')])
	if rt.is_true(rt.call_function('method_exists', [var_data_store.dup(), rt.new_string('prime_caches_for_orders')])) {
		rt.call_method(var_data_store, 'prime_caches_for_orders', [rt.create_array([rt.ArrayItem{ key: none, val: order_id }]), rt.new_array()])
	}
	mut var_order_type := rt.call_function('wc_get_order_type', [rt.call_method(var_data_store, 'get_order_type', [rt.new_int(order_id)])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_type)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d is not an order or has an invalid order type.'), rt.new_string('woocommerce')]), rt.new_int(order_id)])]))))
	}
	mut var_classname := var_order_type.array_get('class_name')
	mut var_order := rt.create_object_dynamically(var_classname, []rt.PhpVal{})
	rt.call_method(var_order, 'set_id', [rt.new_int(order_id)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_data_store := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_data_store_wrapper := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order'))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_data_store := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.dispatch_set_prop('current_class_name', // unsupported expression: Expr_Cast_String)
	this.dispatch_set_prop('instance', var_data_store.dup())
	return rt.new_null()
	}
	rt.call_method(rt.new_closure(closure_2_fn), 'call', [var_data_store_wrapper.dup(), var_data_store.dup()])
	this.data_store = var_data_store_wrapper.dup()
	return rt.new_null()
	}
	mut var_update_data_store_func := rt.new_closure(closure_2_fn)
	rt.call_method(var_update_data_store_func, 'call', [var_order.dup(), var_data_store.dup()])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.new_bool(false)
	}
	mut var_prevent_sync_on_read := rt.new_closure(closure_3_fn)
	rt.call_function('add_filter', [rt.new_string('woocommerce_hpos_enable_sync_on_read'), var_prevent_sync_on_read.dup(), rt.new_int(999)])
	rt.call_method(var_data_store, 'read', [var_order.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
	rt.call_function('remove_filter', [rt.new_string('woocommerce_hpos_enable_sync_on_read'), var_prevent_sync_on_read.dup(), rt.new_int(999)])
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return var_order.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) backfill_order_to_datastore(order_id i64, source_data_store string, destination_data_store string, mut var_fields Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_prop_name := rt.new_null()
	mut var_fields_mutated := var_fields
	mut var_valid_data_stores := rt.create_array([rt.ArrayItem{ key: none, val: 'posts' }, rt.ArrayItem{ key: none, val: 'hpos' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(source_data_store), var_valid_data_stores.dup(), rt.new_bool(true)]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(destination_data_store), var_valid_data_stores.dup(), rt.new_bool(true)]))))))) || rt.is_true(rt.identical(rt.new_string(destination_data_store), rt.new_string(source_data_store))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.new_string('Invalid datastore arguments: %1$s -> %2$s.'), rt.new_string(source_data_store), rt.new_string(destination_data_store)])]))))
	}
	var_fields_mutated = rt.call_function('array_filter', [var_fields_mutated.dup()])
	mut var_src_order := this.get_order_from_datastore(order_id, source_data_store)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields_mutated)))) {
		if rt.is_true(rt.identical(rt.new_string('posts'), rt.new_string(destination_data_store))) {
			rt.call_method(rt.call_method(, 'get_data_store', []rt.PhpVal{}), 'backfill_post_record', [var_src_order.dup()])
		} else if rt.is_true(rt.identical(rt.new_string('hpos'), rt.new_string(destination_data_store))) {
			rt.call_method(, 'migrate_orders', [])
		}
		return rt.new_null()
	}
	this.validate_backfill_fields(mut , mut rt.cast_object_ptr[Class_WC_Abstract_Order]())
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) order_meta_to_array(mut var_order Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_order_base_props() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) limit_hpos_update_to_props(mut var_rows Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_props Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) validate_backfill_fields(mut var_fields Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_order Class_WC_Abstract_Order)  {
	mut var_fields_mutated := var_fields
	mut var_order_mutated := var_order
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_legacydatahandler() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler{
		PhpObjectBase: rt.PhpObjectBase{}
		data_store: rt.new_null()
		data_synchronizer: rt.new_null()
		posts_to_cot_migrator: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_order() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_data_store() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'count_orders_for_cleanup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.count_orders_for_cleanup(dispatch_arg_0))
		}
		'get_orders_for_cleanup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_orders_for_cleanup(dispatch_arg_0, dispatch_arg_1)
		}
		'build_sql_query_for_cleanup' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.build_sql_query_for_cleanup(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'cleanup_post_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.cleanup_post_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_order_newer_than_post' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_order_newer_than_post(mut dispatch_arg_0))
		}
		'get_diff_for_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_diff_for_order(dispatch_arg_0)
		}
		'get_order_from_datastore' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_order_from_datastore(dispatch_arg_0, dispatch_arg_1)
		}
		'backfill_order_to_datastore' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 3 { args[3] } else { rt.new_null() })
			this.backfill_order_to_datastore(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'order_meta_to_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.order_meta_to_array(mut dispatch_arg_0)
		}
		'get_order_base_props' {
			return this.get_order_base_props()
		}
		'limit_hpos_update_to_props' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.limit_hpos_update_to_props(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_backfill_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.validate_backfill_fields(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store' { return this.data_store }
		'data_synchronizer' { return this.data_synchronizer }
		'posts_to_cot_migrator' { return this.posts_to_cot_migrator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store' { this.data_store = val; return true }
		'data_synchronizer' { this.data_synchronizer = val; return true }
		'posts_to_cot_migrator' { this.posts_to_cot_migrator = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_legacydatahandler()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_exception()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_order()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_data_store()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_legacydatahandler_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
