import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner {
	rt.PhpObjectBase
pub mut:
		controller rt.PhpVal = rt.new_null()
		synchronizer rt.PhpVal = rt.new_null()
		post_to_cot_migrator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) init(mut var_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController, mut var_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer, mut var_posts_to_orders_migration_controller Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController)  {
	this.controller = var_controller.dup()
	this.synchronizer = var_synchronizer.dup()
	this.post_to_cot_migrator = var_posts_to_orders_migration_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) register_commands()  {
	mut var_legacy_commands := rt.create_array([rt.ArrayItem{ key: none, val: 'count_unmigrated' }, rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'verify_cot_data' }, rt.ArrayItem{ key: none, val: 'enable' }, rt.ArrayItem{ key: none, val: 'disable' }])
	{
		mut iter_1 := var_legacy_commands.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cmd := item_1.val
			mut var_new_cmd_name := if rt.is_true(rt.identical(rt.new_string('verify_cot_data'), var_cmd)) { rt.new_string('verify_data') } else { var_cmd }
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string("wc hpos ${var_new_cmd_name.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_cmd }]))
			closure_1_fn := fn [var_cmd, var_new_cmd_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_args := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_assoc_args := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string("Command `wc cot ${var_cmd.to_string()}` is deprecated since 8.9.0. Please use `wc hpos ${var_new_cmd_name.to_string()}` instead."))
	return rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_cmd }]), var_args.dup(), var_assoc_args.dup()])
	}
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string("wc cot ${var_cmd.to_string()}"), rt.new_closure(closure_1_fn))
		}
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos cleanup'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'cleanup_post_data' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'status' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos diff'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'diff' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos backfill'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'backfill' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos compatibility-info'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'compatibility_info' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos compatibility-mode enable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_compat_mode' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc hpos compatibility-mode disable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_compat_mode' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.add_command(arg_0, arg_1) }(rt.new_string('wc cot migrate'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'migrate' }]))
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) is_enabled(log bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))))) {
		if var_log {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Custom order table usage is not enabled. If you are testing, you can enable it by following the testing instructions in %s'), rt.new_string('woocommerce')]), rt.new_string('https://developer.woocommerce.com/docs/features/high-performance-order-storage/recipe-book/')]))
		}
	}
	return (rt.call_method(this.controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) free_in_memory_usage()  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_GLOBALS.array_get('wpdb'), 'flush', []rt.PhpVal{})
	rt.set_property(var_GLOBALS.array_get('wpdb'), 'queries', rt.new_array())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')])) && rt.is_true(rt.call_function('wp_cache_supports', [rt.new_string('flush_runtime')])))) {
		rt.call_function('wp_cache_flush_runtime', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) count_unmigrated(var_args rt.PhpVal, var_assoc_args rt.PhpVal) i64 {
	mut var_assoc_args_mutated := var_assoc_args
	mut var_order_count := rt.call_method(this.synchronizer, 'get_current_orders_pending_sync_count', []rt.PhpVal{})
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'log', val: true }])])
	if rt.is_true(rt.new_bool(var_assoc_args_mutated.array_isset(rt.new_string('log')) && rt.is_true(var_assoc_args_mutated.array_get('log')))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('There is %1$d order to be synced.'), rt.new_string('There are %1$d orders to be synced.'), var_order_count.dup(), rt.new_string('woocommerce')]), var_order_count.dup()]))
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) sync(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('Custom order tables does not exist, creating...'), rt.new_string('woocommerce')]))
		rt.call_method(this.synchronizer, 'create_database_tables', []rt.PhpVal{})
		if rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{})) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('__', [rt.new_string('Custom order tables were created successfully.'), rt.new_string('woocommerce')]))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Custom order tables could not be created.'), rt.new_string('woocommerce')]))
		}
	}
	mut var_order_count := rt.new_int(this.count_unmigrated(rt.new_null(), rt.new_null()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_count)))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('There are no orders to sync, aborting.'), rt.new_string('woocommerce')]))
	}
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'batch-size', val: 500 }])])
	mut var_batch_size := if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) { rt.new_int(500) } else { // unsupported expression: Expr_Cast_Int }
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Order Data Sync'), rt.div(var_order_count, var_batch_size)])
	mut var_processed := rt.new_int(rt.new_int(0))
	mut var_batch_count := rt.new_int(rt.new_int(1))
	mut var_total_time := rt.new_int(rt.new_int(0))
	mut var_orders_remaining := rt.new_bool(rt.new_bool(true))
	for rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_order_count, rt.new_int(0))) || rt.is_true(var_orders_remaining))) {
		mut var_remaining_count := var_order_count.dup()
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Beginning batch #%1$d (%2$d orders/batch).'), rt.new_string('woocommerce')]), var_batch_count.dup(), var_batch_size.dup()]))
		mut var_batch_start_time := rt.call_function('microtime', [rt.new_bool(true)])
		mut var_order_ids := rt.call_method(this.synchronizer, 'get_next_batch_to_process', [var_batch_size.dup()])
		if rt.is_true(rt.new_int(var_order_ids.dup().array_count())) {
			rt.call_method(this.synchronizer, 'process_batch', [var_order_ids.dup()])
		}
		// unsupported expression: Expr_AssignOp_Plus
		mut var_batch_total_time := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_batch_start_time)
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Batch %1$d (%2$d orders) completed in %3$d seconds'), rt.new_string('woocommerce')]), var_batch_count.dup(), rt.new_int(var_order_ids.dup().array_count()), var_batch_total_time.dup()]))
		rt.pre_inc(var_batch_count)
		// unsupported expression: Expr_AssignOp_Plus
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		var_orders_remaining = rt.new_bool(rt.new_bool(rt.call_method(this.synchronizer, 'get_next_batch_to_process', [rt.new_int(1)]).array_count() > 0))
		var_order_count = rt.sub(var_remaining_count, var_batch_size)
		this.free_in_memory_usage()
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processed)))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('No orders were synced.'), rt.new_string('woocommerce')]))
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('__', [rt.new_string('Sync completed.'), rt.new_string('woocommerce')]))
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.success(arg_0) }(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d order was synced in %2$d seconds.'), rt.new_string('%1$d orders were synced in %2$d seconds.'), var_processed.dup(), rt.new_string('woocommerce')]), var_processed.dup(), var_total_time.dup()]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) migrate(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_assoc_args_mutated := var_assoc_args
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.log(arg_0) }(rt.call_function('__', [rt.new_string('Migrate command is deprecated. Please use `sync` instead.'), rt.new_string('woocommerce')]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) verify_cot_data(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('__', [rt.new_string('Orders table does not exist.'), rt.new_string('woocommerce')]))
		return rt.new_null()
	}
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'batch-size', val: 500 }, rt.ArrayItem{ key: 'start-from', val: 0 }, rt.ArrayItem{ key: 'end-at', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'verbose', val: false }, rt.ArrayItem{ key: 'order-types', val: '' }, rt.ArrayItem{ key: 're-migrate', val: false }])])
	mut var_batch_count := rt.new_int(rt.new_int(1))
	mut var_total_time := rt.new_int(rt.new_int(0))
	mut var_failed_ids := rt.new_array()
	mut var_processed := rt.new_int(rt.new_int(0))
	mut var_order_id_start := // unsupported expression: Expr_Cast_Int
	mut var_order_id_end := // unsupported expression: Expr_Cast_Int
	var_order_id_end = if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_order_id_end)) { rt.get_constant('PHP_INT_MAX') } else { var_order_id_end }
	mut var_batch_size := if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) { rt.new_int(500) } else { // unsupported expression: Expr_Cast_Int }
	mut var_verbose := // unsupported expression: Expr_Cast_Bool
	mut var_order_types := rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])
	mut var_remigrate := // unsupported expression: Expr_Cast_Bool
	if !(!rt.is_true(var_assoc_args_mutated.array_get('order-types'))) {
		mut var_passed_order_types := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_assoc_args_mutated.array_get('order-types')])])
		var_order_types = rt.call_function('array_intersect', [var_order_types.dup(), var_passed_order_types.dup()])
	}
	if 0 == var_order_types.dup().array_count() {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.error(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Passed order type does not match any registered order types. Following order types are registered: %s'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(','), rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])])]))
	}
	mut var_order_types_pl := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_types.dup().array_count()), rt.new_string('%s')])])
	mut var_order_count := rt.new_int(this.get_verify_order_count((var_order_id_start).to_i64(), (var_order_id_end).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_order_types), false))
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Order Data Verification'), rt.div(var_order_count, var_batch_size)])
	mut var_error_processing := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_count)))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.warning(arg_0) }(rt.call_function('__', [rt.new_string('There are no orders to verify, aborting.'), rt.new_string('woocommerce')]))
	}
	for rt.is_true(rt.greater(var_order_count, rt.new_int(0))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_CLI{}; return temp.debug(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Beginning verification for batch #%1$d (%2$d orders/batch).'), rt.new_string('woocommerce')]), var_batch_count.dup(), var_batch_size.dup()]))
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(, ), ), ), ), rt.call_function('array_merge', [.dup(), ])])])
		mut var_batch_start_time := rt.call_function('microtime', [rt.new_bool(true)])
		mut var_failed_ids_in_current_batch := rt.call_method(, 'verify_migrated_orders', [.dup()])
		var_failed_ids_in_current_batch = 
		
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) get_verify_order_count(order_id_start i64, order_id_end i64, mut var_order_types Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, log bool) i64 {
	mut var_wpdb := rt.new_null()
	mut order_id_start_mutated := order_id_start
	mut order_id_end_mutated := order_id_end
	mut var_order_types_mutated := var_order_types
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) verify_meta_data(mut var_order_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_failed_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_failed_ids_mutated := var_failed_ids
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) normalize_raw_meta_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) enable(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_assoc_args_mutated := var_assoc_args
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) disable(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) cleanup_post_data(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) status(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_assoc_args_mutated := var_assoc_args
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) diff(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_assoc_args_mutated := var_assoc_args
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) backfill(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_{"nodeType":"Scalar_InterpolatedString","line":1186,"parts":[{"nodeType":"Expr_Variable","line":1186,"name":"datastore"}]} := rt.new_null()
	mut var_{"nodeType":"Scalar_InterpolatedString","line":1188,"parts":[{"nodeType":"Expr_Variable","line":1188,"name":"datastore"}]} := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) compatibility_info(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
	mut var_assoc_args_mutated := var_assoc_args
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) get_printable_plugin_names(mut var_plugins Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, display_filenames bool) rt.PhpVal {
	mut var_plugin_file := rt.new_null()
	mut display_filenames_mutated := display_filenames
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) print_plugin_names(mut var_plugins Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array)  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) log(text string)  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) enable_compat_mode()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) disable_compat_mode()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) toggle_compat_mode(enabled bool)  {
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_clirunner() &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		controller: rt.new_null()
		synchronizer: rt.new_null()
		post_to_cot_migrator: rt.new_null()
	}
	return obj
}

fn create_wp_cli() &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'register_commands' {
			this.register_commands()
			return rt.new_null()
		}
		'is_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_enabled(dispatch_arg_0))
		}
		'free_in_memory_usage' {
			this.free_in_memory_usage()
			return rt.new_null()
		}
		'count_unmigrated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.count_unmigrated(dispatch_arg_0, dispatch_arg_1))
		}
		'sync' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sync(dispatch_arg_0, dispatch_arg_1)
		}
		'migrate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.migrate(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'verify_cot_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.verify_cot_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_verify_order_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.get_verify_order_count(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'verify_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.verify_meta_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'normalize_raw_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.normalize_raw_meta_data(mut dispatch_arg_0)
		}
		'enable' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.enable(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'disable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.disable(dispatch_arg_0, dispatch_arg_1)
		}
		'cleanup_post_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.cleanup_post_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.status(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'diff' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.diff(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'backfill' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.backfill(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'compatibility_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.compatibility_info(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_printable_plugin_names' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_printable_plugin_names(mut dispatch_arg_0, dispatch_arg_1)
		}
		'print_plugin_names' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.print_plugin_names(mut dispatch_arg_0)
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.log(dispatch_arg_0)
			return rt.new_null()
		}
		'enable_compat_mode' {
			this.enable_compat_mode()
			return rt.new_null()
		}
		'disable_compat_mode' {
			this.disable_compat_mode()
			return rt.new_null()
		}
		'toggle_compat_mode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.toggle_compat_mode(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'controller' { return this.controller }
		'synchronizer' { return this.synchronizer }
		'post_to_cot_migrator' { return this.post_to_cot_migrator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'controller' { this.controller = val; return true }
		'synchronizer' { this.synchronizer = val; return true }
		'post_to_cot_migrator' { this.post_to_cot_migrator = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_database_migrations_customordertable_clirunner_php() {
}
