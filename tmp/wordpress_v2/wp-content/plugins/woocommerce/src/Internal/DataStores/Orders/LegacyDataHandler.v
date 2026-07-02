import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler {
	rt.PhpObjectBase
pub mut:
	data_store            rt.PhpVal = rt.new_null()
	data_synchronizer     rt.PhpVal = rt.new_null()
	posts_to_cot_migrator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) init(mut var_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer, mut var_posts_to_cot_migrator Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) {
	mut var_data_store_mutated := var_data_store
	this.data_store = var_data_store_mutated
	this.data_synchronizer = var_data_synchronizer
	this.posts_to_cot_migrator = var_posts_to_cot_migrator
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) count_orders_for_cleanup(var_order_ids rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.new_string(this.build_sql_query_for_cleanup(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_order_ids),
			'count', 0)),
	])).to_i64())
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_orders_for_cleanup(var_order_ids rt.PhpVal, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_method(var_wpdb, 'get_col', [
			rt.new_string(this.build_sql_query_for_cleanup(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_order_ids),
				'ids', limit)),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) build_sql_query_for_cleanup(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, result string, limit i64) string {
	mut var_wpdb := rt.new_null()
	mut var_matches := rt.new_null()
	mut result_mutated := result
	mut var_hpos_orders_table := rt.call_method(this.data_store, 'get_orders_table_name',
		[]rt.PhpVal{})
	mut var_sql_where := rt.new_string('')
	if rt.is_true(var_order_ids) {
		mut var_where_ids := rt.new_array()
		mut var_where_ranges := rt.new_array()
		mut iter_1 := var_order_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			if rt.is_true(rt.new_bool(var_arg.clone().is_long() || var_arg.clone().is_double())) {
				var_where_ids.array_push(rt.call_function('absint', [
					var_arg.clone()]))
			} else if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^(\\d+)-(\\d+)$/'),
				var_arg.clone(),
				var_matches.clone(),
			]))
			{
				var_where_ranges.array_push(rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb,
						'posts')), rt.new_string('.ID >= %d AND ')), rt.get_property(var_wpdb,
						'posts')), rt.new_string('.ID <= %d)')),
					rt.call_function('absint', [var_matches.array_get(rt.new_int(1))]),
					rt.call_function('absint', [var_matches.array_get(rt.new_int(2))]),
				]))
			}
		}
		if rt.is_true(var_where_ids) {
			var_where_ranges.array_push(
				rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID IN (')) + (rt.call_function('implode', [rt.new_string(','), var_where_ids.clone()])).str() +
				')')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_where_ranges)))) {
			var_sql_where = rt.concat(var_sql_where, rt.new_string('1=0'))
		} else {
			var_sql_where = rt.concat(var_sql_where, rt.new_string('(' +
				(rt.call_function('implode', [rt.new_string(' OR '), var_where_ranges.clone()])).str() +
				')'))
		}
	}
	var_sql_where = rt.concat(var_sql_where, if rt.is_true(var_sql_where) { ' AND ' } else { '' })
	var_sql_where = rt.concat(var_sql_where, rt.new_string('('))
	var_sql_where = rt.concat(var_sql_where, rt.new_string(
		rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string(".post_type IN ('")) + (rt.call_function('implode', [rt.new_string("', '"), rt.call_function('esc_sql', [rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])])])).str() +
		"')"))
	var_sql_where = rt.concat(var_sql_where, rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' OR (post_type = %s AND ( '),
			var_hpos_orders_table), rt.new_string('.id IS NULL OR EXISTS(SELECT 1 FROM ')), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' WHERE post_id = ')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string('.ID)) )')),
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_{
			nodeType: 'Expr_PropertyFetch'
			line:     129
			var:      {
				'nodeType': 'Expr_Variable'
				'line':     129
				'name':     'this'
			}
			name:     'data_synchronizer'
		}.placeholder_order_post_type(),
	]))
	var_sql_where = rt.concat(var_sql_where, rt.new_string(')'))
	var_sql_where = rt.concat(var_sql_where, rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')),
			rt.new_string('.post_status != %s')),
		rt.new_string('auto-draft'),
	]))
	if rt.is_true(rt.identical(rt.new_string('count'), rt.new_string(result_mutated))) {
		mut var_sql_fields := rt.new_string('COUNT(*)')
		mut var_sql_limit := rt.new_string('')
	} else {
		var_sql_fields = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'),
			rt.new_string('.ID'))).str())
		var_sql_limit = if limit > 0 { rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('LIMIT %d'),
				rt.new_int(limit),
			]) } else { rt.new_string('') }
	}
	mut var_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '),
		var_sql_fields), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')),
		rt.new_string(' LEFT JOIN ')), var_hpos_orders_table), rt.new_string(' ON ')), rt.get_property(var_wpdb,
		'posts')), rt.new_string('.ID = ')), var_hpos_orders_table), rt.new_string('.id WHERE ')),
		var_sql_where), rt.new_string(' ')), var_sql_limit)).str())
	return var_sql.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) cleanup_post_data(order_id i64, skip_checks bool) {
	mut var_wpdb := rt.new_null()
	mut var_post_type := rt.call_function('get_post_type', [rt.new_int(order_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_post_type.clone(),
		rt.call_function('array_merge', [
			rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')]),
			rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_{
				nodeType: 'Expr_PropertyFetch'
				line:     160
				var:      {
					'nodeType': 'Expr_Variable'
					'line':     160
					'name':     'this'
				}
				name:     'data_synchronizer'
			}.placeholder_order_post_type() }]),
		]),
		rt.new_bool(true)])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%d is not of a valid order type.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_int(order_id),
			]),
		]))))
	}
	mut var_order_exists := rt.call_method(this.data_store, 'order_exists', [
		rt.new_int(order_id),
	])
	if rt.is_true(var_order_exists) {
		mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
				[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%d is not a valid order ID.'),
						rt.new_string('woocommerce')]),
					rt.new_int(order_id),
				]),
			]))))
		}
		if !var_skip_checks
			&& !(this.is_order_newer_than_post(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
				[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Data in posts table appears to be more recent than in HPOS tables. Compare order data with `wp wc hpos diff %1$d` and use `wp wc hpos backfill %1$d --from=posts --to=hpos` to fix.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_int(order_id),
				]),
			]))))
		}
	}
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'postmeta'),
		rt.create_array([rt.ArrayItem{ key: 'post_id', val: order_id }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	if rt.is_true(var_order_exists) {
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([
				rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_{
					nodeType: 'Expr_PropertyFetch'
					line:     187
					var:      {
						'nodeType': 'Expr_Variable'
						'line':     187
						'name':     'this'
					}
					name:     'data_synchronizer'
				}.placeholder_order_post_type() },
				rt.ArrayItem{ key: 'post_status', val: 'draft' },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: order_id },
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%s' },
				rt.ArrayItem{ key: none, val: '%s' },
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '%d' },
			])])
	} else {
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([rt.ArrayItem{ key: 'ID', val: order_id }]),
			rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	}
	rt.call_function('clean_post_cache', [rt.new_int(order_id)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) is_order_newer_than_post(mut var_order Class_WC_Abstract_Order) bool {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		rt.call_method(rt.call_method(var_order_mutated, 'get_data_store', []rt.PhpVal{}),
			'get_current_class_name', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class(),
		rt.new_bool(true),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html__', [
			rt.new_string('Order is not an HPOS order.'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_post := rt.call_function('get_post', [
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_{
		nodeType: 'Expr_PropertyFetch'
		line:     214
		var:      {
			'nodeType': 'Expr_Variable'
			'line':     214
			'name':     'this'
		}
		name:     'data_synchronizer'
	}.placeholder_order_post_type(), rt.get_property(var_post, 'post_type'))) {
		return true
	}
	mut var_order_modified_gmt := if !(rt.call_method(var_order_mutated, 'get_date_modified',
		[]rt.PhpVal{})).is_null() {
		rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{})
	} else {
		rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{})
	}
	var_order_modified_gmt = if rt.is_true(var_order_modified_gmt) {
		rt.call_method(var_order_modified_gmt, 'getTimestamp', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}
	mut var_post_modified_gmt := if !(rt.get_property(var_post, 'post_modified_gmt')).is_null() {
		rt.get_property(var_post, 'post_modified_gmt')
	} else {
		rt.get_property(var_post, 'post_date_gmt')
	}
	var_post_modified_gmt = if rt.is_true(var_post_modified_gmt) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_post_modified_gmt)))) { rt.call_function('wc_string_to_timestamp', [
			var_post_modified_gmt.clone(),
		]) } else { rt.new_int(0) }
	return (rt.greater_equal(var_order_modified_gmt, var_post_modified_gmt)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_diff_for_order(order_id i64) rt.PhpVal {
	mut var_diff := rt.new_array()
	mut var_hpos_order := this.get_order_from_datastore(order_id, 'hpos')
	mut var_cpt_order := this.get_order_from_datastore(order_id, 'posts')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_hpos_order, 'get_type',
		[]rt.PhpVal{}), rt.call_method(var_cpt_order, 'get_type', []rt.PhpVal{})))))
	{
		var_diff.array_set('type', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(var_hpos_order, 'get_type', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_method(var_cpt_order, 'get_type', []rt.PhpVal{}) },
		]))
	}
	mut var_hpos_meta :=
		this.order_meta_to_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](var_hpos_order))
	mut var_cpt_meta :=
		this.order_meta_to_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](var_cpt_order))
	mut var_all_keys := rt.call_function('array_unique', [
		rt.call_function('array_diff', [
			rt.call_function('array_merge', [this.get_order_base_props(),
				rt.func_array_keys(var_hpos_meta.clone()), rt.func_array_keys(var_cpt_meta.clone())]),
			rt.call_method(this.data_synchronizer, 'get_ignored_order_props', []rt.PhpVal{}),
		]),
	])
	mut iter_2 := var_all_keys.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		mut var_val1 := if rt.is_true(rt.call_function('in_array', [
			var_key.clone(), this.get_order_base_props(), rt.new_bool(true)]))
		{
			rt.call_method(var_hpos_order, 'get_${var_key.to_string()}', []rt.PhpVal{})
		} else {
			if !(var_hpos_meta.array_get(var_key)).is_null() {
				var_hpos_meta.array_get(var_key)
			} else {
				rt.new_null()
			}
		}
		mut var_val2 := if rt.is_true(rt.call_function('in_array', [
			var_key.clone(), this.get_order_base_props(), rt.new_bool(true)]))
		{
			rt.call_method(var_cpt_order, 'get_${var_key.to_string()}', []rt.PhpVal{})
		} else {
			if !(var_cpt_meta.array_get(var_key)).is_null() {
				var_cpt_meta.array_get(var_key)
			} else {
				rt.new_null()
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_val2))))
			&& rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: '_billing_address_index'
		}, rt.ArrayItem{ key: none, val: '_shipping_address_index' }]), rt.new_bool(true)])) {
			var_val2 = rt.call_function('get_post_meta', [rt.new_int(order_id),
				var_key.clone(), rt.new_bool(true)])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_val1, var_val2)))) {
			var_diff.array_set(var_key, rt.create_array([
				rt.ArrayItem{ key: none, val: var_val1 },
				rt.ArrayItem{ key: none, val: var_val2 },
			]))
		}
	}
	return var_diff.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_order_from_datastore(order_id i64, data_store_id string) rt.PhpVal {
	mut var_data_store := if rt.is_true(rt.identical(rt.new_string('hpos'),
		rt.new_string(data_store_id)))
	{
		this.data_store
	} else {
		rt.call_method(this.data_store, 'get_cpt_data_store_instance', []rt.PhpVal{})
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order{}
	mut iife_result_0 := iife_temp_0.generate_meta_cache_key(rt.new_int(order_id),
		rt.new_string('orders'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order{}
	mut iife_result_1 := iife_temp_1.generate_meta_cache_key(rt.new_int(order_id),
		rt.new_string('orders'))
	rt.call_function('wp_cache_delete', [iife_result_0, rt.new_string('orders')])
	if rt.is_true(rt.call_function('method_exists', [var_data_store.clone(),
		rt.new_string('prime_caches_for_orders')]))
	{
		rt.call_method(var_data_store, 'prime_caches_for_orders', [
			rt.create_array([rt.ArrayItem{ key: none, val: order_id }]),
			rt.new_array(),
		])
	}
	mut var_order_type := rt.call_function('wc_get_order_type', [
		rt.call_method(var_data_store, 'get_order_type', [rt.new_int(order_id)]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_type)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%d is not an order or has an invalid order type.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_int(order_id),
			]),
		]))))
	}
	mut var_classname := var_order_type.array_get(rt.new_string('class_name'))
	mut var_order := rt.create_object_dynamically(var_classname, []rt.PhpVal{})
	rt.call_method(var_order, 'set_id', [rt.new_int(order_id)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_data_store := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store{}
		mut iife_result_3 := iife_temp_3.load(rt.new_string('order'))
		mut var_data_store_wrapper := iife_result_3
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_data_store := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			this.dispatch_set_prop('current_class_name', (rt.call_function('get_class', [
				var_data_store.clone(),
			])).str())
			this.dispatch_set_prop('instance', var_data_store.clone())
			return rt.new_null()
		}
		rt.call_method(rt.new_closure(closure_5_fn), 'call', [
			var_data_store_wrapper.clone(), var_data_store.clone()])
		this.data_store = var_data_store_wrapper.clone()
		return rt.new_null()
	}
	mut var_update_data_store_func := rt.new_closure(closure_5_fn)
	rt.call_method(var_update_data_store_func, 'call', [var_order.clone(),
		var_data_store.clone()])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(false)
	}
	mut var_prevent_sync_on_read := rt.new_closure(closure_6_fn)
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_hpos_enable_sync_on_read'),
		var_prevent_sync_on_read.clone(),
		rt.new_int(999),
	])
	rt.call_method(var_data_store, 'read', [var_order.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

	finally_label_1:
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_hpos_enable_sync_on_read'),
		var_prevent_sync_on_read.clone(),
		rt.new_int(999),
	])
	if rt.has_exception() { return rt.new_null() }

	end_label_1:
	return var_order.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) backfill_order_to_datastore(order_id i64, source_data_store string, destination_data_store string, mut var_fields Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_prop_name := rt.new_null()
	mut var_fields_mutated := var_fields
	mut var_valid_data_stores := rt.create_array([
		rt.ArrayItem{ key: none, val: 'posts' },
		rt.ArrayItem{ key: none, val: 'hpos' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(source_data_store), var_valid_data_stores.clone(), rt.new_bool(true)])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(destination_data_store), var_valid_data_stores.clone(), rt.new_bool(true)])))))
		|| rt.is_true(rt.identical(rt.new_string(destination_data_store), rt.new_string(source_data_store))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.new_string('Invalid datastore arguments: %1$s -> %2$s.'),
				rt.new_string(source_data_store),
				rt.new_string(destination_data_store),
			]),
		]))))
	}
	var_fields_mutated = rt.call_function('array_filter', [var_fields_mutated])
	mut var_src_order := this.get_order_from_datastore(order_id, source_data_store)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields_mutated)))) {
		if rt.is_true(rt.identical(rt.new_string('posts'), rt.new_string(destination_data_store))) {
			rt.call_method(rt.call_method(var_src_order, 'get_data_store', []rt.PhpVal{}),
				'backfill_post_record', [var_src_order.clone()])
		} else if rt.is_true(rt.identical(rt.new_string('hpos'),
			rt.new_string(destination_data_store)))
		{
			rt.call_method(this.posts_to_cot_migrator, 'migrate_orders', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.call_method(var_src_order, 'get_id',
						[]rt.PhpVal{}) },
				]),
			])
		}
		return
	}
	this.validate_backfill_fields(mut var_fields_mutated, mut
		rt.cast_object_ptr[Class_WC_Abstract_Order](var_src_order))
	mut var_dest_order := this.get_order_from_datastore((rt.call_method(var_src_order, 'get_id',
		[]rt.PhpVal{})).to_i64(), destination_data_store)
	if rt.is_true(rt.identical(rt.new_string('posts'), rt.new_string(destination_data_store))) {
		mut var_datastore := rt.call_method(this.data_store, 'get_cpt_data_store_instance',
			[]rt.PhpVal{})
	} else if rt.is_true(rt.identical(rt.new_string('hpos'), rt.new_string(destination_data_store))) {
		var_datastore = this.data_store
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_datastore))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_datastore.clone(), rt.new_string('update_order_from_object')]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html__', [
			rt.new_string('The backup datastore does not support updating orders.'),
			rt.new_string('woocommerce'),
		]))))
	}
	if !(!rt.is_true(var_fields_mutated.array_get(rt.new_string('meta_keys')))) {
		mut iter_3 := var_fields_mutated.array_get(rt.new_string('meta_keys')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_meta_key := item_3.val
			rt.call_method(var_dest_order, 'delete_meta_data', [
				var_meta_key.clone()])
			mut iter_4 := rt.call_method(var_src_order, 'get_meta', [
				var_meta_key.clone(), rt.new_bool(false), rt.new_string('edit')]).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_meta := item_4.val
				rt.call_method(var_dest_order, 'add_meta_data', [
					var_meta_key.clone(), rt.get_property(var_meta, 'value')])
			}
		}
	}
	if !(!rt.is_true(var_fields_mutated.array_get(rt.new_string('props')))) {
		closure_7_fn := fn [var_src_order] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_prop_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_src_order, 'get_${var_prop_name.to_string()}', []rt.PhpVal{})
		}
		closure_8_fn := fn [var_src_order] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_prop_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_src_order, 'get_${var_prop_name.to_string()}', []rt.PhpVal{})
		}
		mut var_new_values := rt.call_function('array_combine', [
			var_fields_mutated.array_get(rt.new_string('props')),
			rt.call_function('array_map', [rt.new_closure(closure_7_fn),
				var_fields_mutated.array_get(rt.new_string('props'))]),
		])
		rt.call_method(var_dest_order, 'set_props', [var_new_values.clone()])
		if rt.is_true(rt.identical(rt.new_string('hpos'), rt.new_string(destination_data_store))) {
			rt.call_method(var_dest_order, 'apply_changes', []rt.PhpVal{})
			closure_9_fn := fn [var_dest_order, var_fields] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_rows := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_order := if args.len > 1 { args[1].clone() } else { rt.new_null() }
				if rt.is_true(rt.identical(rt.call_method(var_dest_order, 'get_id', []rt.PhpVal{}), rt.call_method(var_order,
					'get_id', []rt.PhpVal{})))
				{
					var_rows = this.limit_hpos_update_to_props(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_rows), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_fields_mutated.array_get(rt.new_string('props'))))
				}
				return
			}
			mut var_limit_cb := rt.new_closure(closure_9_fn)
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_orders_table_datastore_db_rows_for_order'),
				var_limit_cb.clone(),
				rt.new_int(10),
				rt.new_int(2),
			])
		}
	}
	rt.call_method(var_datastore, 'update_order_from_object', [
		var_dest_order.clone()])
	if rt.is_true(rt.identical(rt.new_string('hpos'), rt.new_string(destination_data_store)))
		&& !var_limit_cb.is_null() {
		rt.call_function('remove_filter', [
			rt.new_string('woocommerce_orders_table_datastore_db_rows_for_order'),
			var_limit_cb.clone(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) order_meta_to_array(mut var_order Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_result := rt.new_array()
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_9 := iife_temp_9.select(rt.call_method(var_order_mutated, 'get_meta_data',
		[]rt.PhpVal{}), rt.new_string('get_data'),
		Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut iter_5 := iife_result_9.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta := item_5.val
		if rt.is_true(rt.new_bool(var_result.clone().array_isset(var_meta.array_get(rt.new_string('key'))))) {
			var_result.array_set(var_meta.array_get(rt.new_string('key')), rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_result.array_get(var_meta.array_get(rt.new_string('key')))
				},
			]))
			var_result.array_get_mut(var_meta.array_get(rt.new_string('key'))).array_push(var_meta.array_get(rt.new_string('value')))
		} else {
			var_result.array_set(var_meta.array_get(rt.new_string('key')),
				var_meta.array_get(rt.new_string('value')))
		}
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) get_order_base_props() rt.PhpVal {
	mut var_base_props := rt.new_array()
	mut iter_6 :=
		rt.call_method(this.data_store, 'get_all_order_column_mappings', []rt.PhpVal{}).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_mapping := item_6.val
		var_base_props = rt.call_function('array_merge', [var_base_props.clone(),
			rt.call_function('array_column', [var_mapping.clone(),
				rt.new_string('name')])])
	}
	return var_base_props.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) limit_hpos_update_to_props(mut var_rows Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_props Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_allowed_columns := rt.new_array()
	mut iter_7 :=
		rt.call_method(this.data_store, 'get_all_order_column_mappings', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_mapping := item_7.val
		mut iter_8 := var_mapping.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_column_data := item_8.val
			mut var_column_name := item_8.key
			if !(var_column_data.array_isset(rt.new_string('name')))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_column_data.array_get(rt.new_string('name')), var_props, rt.new_bool(true)]))))) {
				continue
			}
			var_allowed_columns.array_set(var_column_data.array_get(rt.new_string('name')),
				var_column_name.clone())
		}
	}
	mut iter_9 := var_rows.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_db_update := item_9.val
		mut var_i := item_9.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_intersect_key', [
			var_db_update.array_get(rt.new_string('data')),
			rt.call_function('array_flip', [var_allowed_columns.clone()]),
		])))))
		{
			var_rows.array_unset(var_i)
			continue
		}
		mut var_allowed_column_names_with_ids := rt.call_function('array_merge', [
			var_allowed_columns.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
				rt.ArrayItem{ key: none, val: 'order_id' }, rt.ArrayItem{
					key: none
					val: 'address_type'
				}]),
		])
		var_db_update.array_set('data', rt.call_function('array_intersect_key', [
			var_db_update.array_get(rt.new_string('data')),
			rt.call_function('array_flip', [var_allowed_column_names_with_ids.clone()]),
		]))
		var_db_update.array_set('format', rt.call_function('array_intersect_key', [
			var_db_update.array_get(rt.new_string('format')),
			rt.call_function('array_flip', [var_allowed_column_names_with_ids.clone()]),
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{},
		var_rows)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) validate_backfill_fields(mut var_fields Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_order Class_WC_Abstract_Order) {
	mut var_fields_mutated := var_fields
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fields_mutated)))) {
		return
	}
	if !(!rt.is_true(var_fields_mutated.array_get(rt.new_string('meta_keys')))) {
		mut var_internal_meta_keys := rt.call_function('array_unique', [
			rt.call_function('array_merge', [
				rt.call_method(this.data_store, 'get_internal_meta_keys', []rt.PhpVal{}),
				rt.call_method(rt.call_method(this.data_store, 'get_cpt_data_store_instance',
					[]rt.PhpVal{}), 'get_internal_meta_keys', []rt.PhpVal{}),
			]),
		])
		mut var_possibly_internal_keys := rt.call_function('array_intersect', [
			var_internal_meta_keys.clone(),
			var_fields_mutated.array_get(rt.new_string('meta_keys')),
		])
		if !(!rt.is_true(var_possibly_internal_keys)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
				[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s is an internal meta key. Use --props to set it.'),
						rt.new_string('%s are internal meta keys. Use --props to set them.'),
						rt.new_int(var_possibly_internal_keys.clone().array_count()),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('implode', [
						rt.new_string(', '),
						var_possibly_internal_keys.clone(),
					]),
				]),
			]))))
		}
	}
	if !(!rt.is_true(var_fields_mutated.array_get(rt.new_string('props')))) {
		closure_11_fn := fn [var_order] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_prop_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		mut var_invalid_props := rt.call_function('array_filter', [
			var_fields_mutated.array_get(rt.new_string('props')),
			rt.new_closure(closure_11_fn),
		])
		if !(!rt.is_true(var_invalid_props)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
				[]string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s is not a valid order property.'),
						rt.new_string('%s are not valid order properties.'),
						rt.new_int(var_invalid_props.clone().array_count()),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('implode', [
						rt.new_string(', '),
						var_invalid_props.clone(),
					]),
				]),
			]))))
		}
	}
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

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_legacydatahandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler{
		PhpObjectBase:         rt.PhpObjectBase{}
		data_store:            rt.new_null()
		data_synchronizer:     rt.new_null()
		posts_to_cot_migrator: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_order(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.build_sql_query_for_cleanup(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'cleanup_post_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.cleanup_post_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_order_newer_than_post' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.backfill_order_to_datastore(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
			return rt.new_null()
		}
		'order_meta_to_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.order_meta_to_array(mut dispatch_arg_0)
		}
		'get_order_base_props' {
			return this.get_order_base_props()
		}
		'limit_hpos_update_to_props' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.limit_hpos_update_to_props(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'validate_backfill_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.validate_backfill_fields(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
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
		'data_store' {
			this.data_store = val
			return true
		}
		'data_synchronizer' {
			this.data_synchronizer = val
			return true
		}
		'posts_to_cot_migrator' {
			this.posts_to_cot_migrator = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_legacydatahandler()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_exception()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_order()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_data_store()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_ArrayUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_arrayutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_ArrayUtil', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
