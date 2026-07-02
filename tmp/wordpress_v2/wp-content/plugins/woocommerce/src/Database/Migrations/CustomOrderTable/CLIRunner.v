import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner {
	rt.PhpObjectBase
pub mut:
		controller rt.PhpVal = rt.new_null()
		synchronizer rt.PhpVal = rt.new_null()
		post_to_cot_migrator rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) init(mut var_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController, mut var_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer, mut var_posts_to_orders_migration_controller Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) {
	this.controller = var_controller
	this.synchronizer = var_synchronizer
	this.post_to_cot_migrator = var_posts_to_orders_migration_controller
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) register_commands() {
	mut var_legacy_commands := rt.create_array([rt.ArrayItem{ key: none, val: 'count_unmigrated' }, rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'verify_cot_data' }, rt.ArrayItem{ key: none, val: 'enable' }, rt.ArrayItem{ key: none, val: 'disable' }])
	mut iter_1 := var_legacy_commands.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cmd := item_1.val
	mut var_new_cmd_name := if rt.is_true(rt.identical(rt.new_string('verify_cot_data'), var_cmd)) { rt.new_string('verify_data') } else { var_cmd }
	mut iife_temp_0 := Class_WP_CLI{}
	mut iife_result_0 := iife_temp_0.add_command(rt.new_string("wc hpos ${var_new_cmd_name.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_cmd }]))
	closure_3_fn := fn [var_cmd, var_new_cmd_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_args := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_assoc_args := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_2 := Class_WP_CLI{}
		mut iife_result_2 := iife_temp_2.warning(rt.new_string("Command `wc cot ${var_cmd.to_string()}` is deprecated since 8.9.0. Please use `wc hpos ${var_new_cmd_name.to_string()}` instead."))
		return
		}
	mut iife_temp_3 := Class_WP_CLI{}
	mut iife_result_3 := iife_temp_3.add_command(rt.new_string("wc cot ${var_cmd.to_string()}"), rt.new_closure(closure_3_fn))
	}
mut iife_temp_4 := Class_WP_CLI{}
mut iife_result_4 := iife_temp_4.add_command(rt.new_string('wc hpos cleanup'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'cleanup_post_data' }]))
mut iife_temp_5 := Class_WP_CLI{}
mut iife_result_5 := iife_temp_5.add_command(rt.new_string('wc hpos status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'status' }]))
mut iife_temp_6 := Class_WP_CLI{}
mut iife_result_6 := iife_temp_6.add_command(rt.new_string('wc hpos diff'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'diff' }]))
mut iife_temp_7 := Class_WP_CLI{}
mut iife_result_7 := iife_temp_7.add_command(rt.new_string('wc hpos backfill'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'backfill' }]))
mut iife_temp_8 := Class_WP_CLI{}
mut iife_result_8 := iife_temp_8.add_command(rt.new_string('wc hpos compatibility-info'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'compatibility_info' }]))
mut iife_temp_9 := Class_WP_CLI{}
mut iife_result_9 := iife_temp_9.add_command(rt.new_string('wc hpos compatibility-mode enable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_compat_mode' }]))
mut iife_temp_10 := Class_WP_CLI{}
mut iife_result_10 := iife_temp_10.add_command(rt.new_string('wc hpos compatibility-mode disable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'disable_compat_mode' }]))
mut iife_temp_11 := Class_WP_CLI{}
mut iife_result_11 := iife_temp_11.add_command(rt.new_string('wc cot migrate'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'migrate' }]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) is_enabled(log bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))))) {
		if var_log {
		mut iife_temp_12 := Class_WP_CLI{}
		mut iife_result_12 := iife_temp_12.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Custom order table usage is not enabled. If you are testing, you can enable it by following the testing instructions in %s'), rt.new_string('woocommerce')]), rt.new_string('https://developer.woocommerce.com/docs/features/high-performance-order-storage/recipe-book/')]))
		}
	}
	return (rt.call_method(this.controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) free_in_memory_usage() {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'flush', []rt.PhpVal{})
	rt.set_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'queries', rt.new_array())
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')])) && rt.is_true(rt.call_function('wp_cache_supports', [rt.new_string('flush_runtime')])) {
		rt.call_function('wp_cache_flush_runtime', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) count_unmigrated(var_args rt.PhpVal, var_assoc_args rt.PhpVal) i64 {
	mut var_assoc_args_mutated := var_assoc_args
	mut var_order_count := rt.call_method(this.synchronizer, 'get_current_orders_pending_sync_count', []rt.PhpVal{})
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'log', val: true }])])
	if var_assoc_args_mutated.array_isset(rt.new_string('log')) && rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('log'))) {
	mut iife_temp_13 := Class_WP_CLI{}
	mut iife_result_13 := iife_temp_13.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('There is %1$d order to be synced.'), rt.new_string('There are %1$d orders to be synced.'), var_order_count.clone(), rt.new_string('woocommerce')]), var_order_count.clone()]))
	}
	return rt.new_int((var_order_count).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) sync(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		mut iife_temp_14 := Class_WP_CLI{}
		mut iife_result_14 := iife_temp_14.warning(rt.call_function('__', [rt.new_string('Custom order tables does not exist, creating...'), rt.new_string('woocommerce')]))
		rt.call_method(this.synchronizer, 'create_database_tables', []rt.PhpVal{})
		if rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{})) {
		mut iife_temp_15 := Class_WP_CLI{}
		mut iife_result_15 := iife_temp_15.success(rt.call_function('__', [rt.new_string('Custom order tables were created successfully.'), rt.new_string('woocommerce')]))
		} else {
		mut iife_temp_16 := Class_WP_CLI{}
		mut iife_result_16 := iife_temp_16.error(rt.call_function('__', [rt.new_string('Custom order tables could not be created.'), rt.new_string('woocommerce')]))
		}
	}
	mut var_order_count := rt.new_int(this.count_unmigrated(rt.new_null(), rt.new_null()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_count)))) {
		mut iife_temp_17 := Class_WP_CLI{}
		mut iife_result_17 := iife_temp_17.warning(rt.call_function('__', [rt.new_string('There are no orders to sync, aborting.'), rt.new_string('woocommerce')]))
		return iife_result_17
	}
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'batch-size', val: 500 }])])
	mut var_batch_size := rt.new_int(if rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('batch-size'))).to_i64()) == 0 { 500 } else { rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('batch-size'))).to_i64()) })
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Order Data Sync'), rt.div(var_order_count, var_batch_size)])
	mut var_processed := rt.new_int(0)
	mut var_batch_count := rt.new_int(1)
	mut var_total_time := rt.new_int(0)
	mut var_orders_remaining := rt.new_bool(true)
	for rt.is_true(rt.greater(var_order_count, rt.new_int(0))) || rt.is_true(var_orders_remaining) {
		mut var_remaining_count := var_order_count.clone()
		mut iife_temp_18 := Class_WP_CLI{}
		mut iife_result_18 := iife_temp_18.debug(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Beginning batch #%1$d (%2$d orders/batch).'), rt.new_string('woocommerce')]), var_batch_count.clone(), var_batch_size.clone()]))
		mut var_batch_start_time := rt.call_function('microtime', [rt.new_bool(true)])
		mut var_order_ids := rt.call_method(this.synchronizer, 'get_next_batch_to_process', [var_batch_size.clone()])
		if rt.is_true(rt.new_int(var_order_ids.clone().array_count())) {
			rt.call_method(this.synchronizer, 'process_batch', [var_order_ids.clone()])
		}
		var_processed = rt.add(var_processed, rt.new_int(var_order_ids.clone().array_count()))
		mut var_batch_total_time := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_batch_start_time)
		mut iife_temp_19 := Class_WP_CLI{}
		mut iife_result_19 := iife_temp_19.debug(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Batch %1$d (%2$d orders) completed in %3$d seconds'), rt.new_string('woocommerce')]), var_batch_count.clone(), rt.new_int(var_order_ids.clone().array_count()), var_batch_total_time.clone()]))
		rt.pre_inc(var_batch_count)
		var_total_time = rt.add(var_total_time, var_batch_total_time)
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		var_orders_remaining = rt.new_bool(rt.call_method(this.synchronizer, 'get_next_batch_to_process', [rt.new_int(1)]).array_count() > 0)
		var_order_count = rt.sub(var_remaining_count, var_batch_size)
		this.free_in_memory_usage()
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processed)))) {
		mut iife_temp_20 := Class_WP_CLI{}
		mut iife_result_20 := iife_temp_20.warning(rt.call_function('__', [rt.new_string('No orders were synced.'), rt.new_string('woocommerce')]))
		return iife_result_20
	}
	mut iife_temp_21 := Class_WP_CLI{}
	mut iife_result_21 := iife_temp_21.log(rt.call_function('__', [rt.new_string('Sync completed.'), rt.new_string('woocommerce')]))
	mut iife_temp_22 := Class_WP_CLI{}
	mut iife_result_22 := iife_temp_22.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d order was synced in %2$d seconds.'), rt.new_string('%1$d orders were synced in %2$d seconds.'), var_processed.clone(), rt.new_string('woocommerce')]), var_processed.clone(), var_total_time.clone()]))
	return iife_result_22
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) migrate(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_assoc_args_mutated := var_assoc_args
mut iife_temp_23 := Class_WP_CLI{}
mut iife_result_23 := iife_temp_23.log(rt.call_function('__', [rt.new_string('Migrate command is deprecated. Please use `sync` instead.'), rt.new_string('woocommerce')]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) verify_cot_data(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		mut iife_temp_24 := Class_WP_CLI{}
		mut iife_result_24 := iife_temp_24.error(rt.call_function('__', [rt.new_string('Orders table does not exist.'), rt.new_string('woocommerce')]))
		return rt.new_null()
	}
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'batch-size', val: 500 }, rt.ArrayItem{ key: 'start-from', val: 0 }, rt.ArrayItem{ key: 'end-at', val: -1 }, rt.ArrayItem{ key: 'verbose', val: false }, rt.ArrayItem{ key: 'order-types', val: '' }, rt.ArrayItem{ key: 're-migrate', val: false }])])
	mut var_batch_count := rt.new_int(1)
	mut var_total_time := rt.new_int(0)
	mut var_failed_ids := rt.new_array()
	mut var_processed := rt.new_int(0)
	mut var_order_id_start := rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('start-from'))).to_i64())
	mut var_order_id_end := rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('end-at'))).to_i64())
	var_order_id_end = if rt.is_true(rt.identical(-1, var_order_id_end)) { rt.get_constant('PHP_INT_MAX') } else { var_order_id_end }
	mut var_batch_size := rt.new_int(if rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('batch-size'))).to_i64()) == 0 { 500 } else { rt.new_int((var_assoc_args_mutated.array_get(rt.new_string('batch-size'))).to_i64()) })
	mut var_verbose := rt.new_bool((var_assoc_args_mutated.array_get(rt.new_string('verbose'))).to_bool())
	mut var_order_types := rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])
	mut var_remigrate := rt.new_bool((var_assoc_args_mutated.array_get(rt.new_string('re-migrate'))).to_bool())
	if !(!rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('order-types')))) {
	mut var_passed_order_types := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_assoc_args_mutated.array_get(rt.new_string('order-types'))])])
	var_order_types = rt.call_function('array_intersect', [var_order_types.clone(), var_passed_order_types.clone()])
	}
	if 0 == var_order_types.clone().array_count() {
		mut iife_temp_25 := Class_WP_CLI{}
		mut iife_result_25 := iife_temp_25.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Passed order type does not match any registered order types. Following order types are registered: %s'), rt.new_string('woocommerce')]), rt.call_function('implode', [rt.new_string(','), rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])])]))
		return iife_result_25
	}
	mut var_order_types_pl := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_types.clone().array_count()), rt.new_string('%s')])])
	mut var_order_count := rt.new_int(this.get_verify_order_count((var_order_id_start).to_i64(), (var_order_id_end).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_order_types), false))
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.new_string('Order Data Verification'), rt.div(var_order_count, var_batch_size)])
	mut var_error_processing := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_count)))) {
		mut iife_temp_26 := Class_WP_CLI{}
		mut iife_result_26 := iife_temp_26.warning(rt.call_function('__', [rt.new_string('There are no orders to verify, aborting.'), rt.new_string('woocommerce')]))
		return iife_result_26
	}
	for rt.is_true(rt.greater(var_order_count, rt.new_int(0))) {
		mut iife_temp_27 := Class_WP_CLI{}
		mut iife_result_27 := iife_temp_27.debug(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Beginning verification for batch #%1$d (%2$d orders/batch).'), rt.new_string('woocommerce')]), var_batch_count.clone(), var_batch_size.clone()]))
		mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type in ( ')), var_order_types_pl), rt.new_string(' ) AND ID >= %d AND ID <= %d ORDER BY ID ASC LIMIT %d')), rt.call_function('array_merge', [var_order_types.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_order_id_start }, rt.ArrayItem{ key: none, val: var_order_id_end }, rt.ArrayItem{ key: none, val: var_batch_size }])])])])
		mut var_batch_start_time := rt.call_function('microtime', [rt.new_bool(true)])
		mut var_failed_ids_in_current_batch := rt.call_method(this.post_to_cot_migrator, 'verify_migrated_orders', [var_order_ids.clone()])
		var_failed_ids_in_current_batch = this.verify_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_order_ids), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_failed_ids_in_current_batch))
		var_failed_ids = if rt.is_true(var_verbose) { rt.new_array() } else { rt.add(var_failed_ids, var_failed_ids_in_current_batch) }
		var_error_processing = rt.new_bool(rt.is_true(var_error_processing) || !(!rt.is_true(var_failed_ids_in_current_batch)))
		var_processed = rt.add(var_processed, rt.new_int(var_order_ids.clone().array_count()))
		mut var_batch_total_time := rt.sub(rt.call_function('microtime', [rt.new_bool(true)]), var_batch_start_time)
		rt.pre_inc(var_batch_count)
		var_total_time = rt.add(var_total_time, var_batch_total_time)
		if var_failed_ids_in_current_batch.clone().array_count() > 0 {
			if rt.is_true(var_verbose) {
			mut var_errors := rt.call_function('wp_json_encode', [var_failed_ids_in_current_batch.clone(), rt.get_constant('JSON_PRETTY_PRINT')])
			mut iife_temp_28 := Class_WP_CLI{}
			mut iife_result_28 := iife_temp_28.warning(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d error found: %2$s. Please review the error above.'), rt.new_string('%1$d errors found: %2$s. Please review the errors above.'), rt.new_int(var_failed_ids_in_current_batch.clone().array_count()), rt.new_string('woocommerce')]), rt.new_int(var_failed_ids_in_current_batch.clone().array_count()), var_errors.clone()]))
			}
			if rt.is_true(var_remigrate) {
				var_failed_ids = if rt.is_true(var_failed_ids) { rt.call_function('array_diff_key', [var_failed_ids.clone(), var_failed_ids_in_current_batch.clone()]) } else { rt.new_array() }
				var_error_processing = rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_verbose)))) && rt.is_true(var_failed_ids))
				mut iife_temp_29 := Class_WP_CLI{}
				mut iife_result_29 := iife_temp_29.warning(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Attempting to remigrate...'), rt.new_string('woocommerce')])]))
				rt.new_bool(rt.is_true(var_verbose) && rt.is_true(iife_result_29))
				mut var_failed_ids_in_current_batch_keys := rt.func_array_keys(var_failed_ids_in_current_batch.clone())
				rt.call_method(this.synchronizer, 'process_batch', [var_failed_ids_in_current_batch_keys.clone()])
				mut var_errors_in_remigrate_batch := rt.call_method(this.post_to_cot_migrator, 'verify_migrated_orders', [var_failed_ids_in_current_batch_keys.clone()])
				var_errors_in_remigrate_batch = this.verify_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_failed_ids_in_current_batch_keys), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_errors_in_remigrate_batch))
				if var_errors_in_remigrate_batch.clone().array_count() > 0 {
					var_error_processing = rt.new_bool(true)
					mut var_formatted_errors := rt.call_function('wp_json_encode', [var_errors_in_remigrate_batch.clone(), rt.get_constant('JSON_PRETTY_PRINT')])
					if rt.is_true(var_verbose) {
					mut iife_temp_30 := Class_WP_CLI{}
					mut iife_result_30 := iife_temp_30.warning(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d error found: %2$s when re-migrating order. Please review the error above.'), rt.new_string('%1$d errors found: %2$s when re-migrating orders. Please review the errors above.'), rt.new_int(var_errors_in_remigrate_batch.clone().array_count()), rt.new_string('woocommerce')]), rt.new_int(var_errors_in_remigrate_batch.clone().array_count()), var_formatted_errors.clone()]))
					} else {
						closure_32_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
							mut var_errors_for_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
							var_errors_for_order.array_push(rt.create_array([rt.ArrayItem{ key: 'remigrate_failed', val: true }]))
							return rt.new_null()
							}
						rt.call_function('array_walk', [var_errors_in_remigrate_batch.clone(), rt.new_closure(closure_32_fn)])
					var_failed_ids = rt.add(var_failed_ids, var_errors_in_remigrate_batch)
					}
				} else {
					mut iife_temp_32 := Class_WP_CLI{}
					mut iife_result_32 := iife_temp_32.warning(rt.new_string('Re-migration successful.'), rt.new_string('woocommerce'))
					rt.new_bool(rt.is_true(var_verbose) && rt.is_true(iife_result_32))
				}
			}
		}
		rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		mut iife_temp_33 := Class_WP_CLI{}
		mut iife_result_33 := iife_temp_33.debug(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Batch %1$d (%2$d orders) completed in %3$d seconds.'), rt.new_string('woocommerce')]), var_batch_count.clone(), rt.new_int(var_order_ids.clone().array_count()), var_batch_total_time.clone()]))
		var_order_id_start = rt.add(rt.call_function('max', [var_order_ids.clone()]), rt.new_int(1))
		mut var_remaining_count := rt.new_int(this.get_verify_order_count((var_order_id_start).to_i64(), (var_order_id_end).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_order_types), false))
		if rt.is_true(rt.identical(var_remaining_count, var_order_count)) {
			mut iife_temp_34 := Class_WP_CLI{}
			mut iife_result_34 := iife_temp_34.error(rt.call_function('__', [rt.new_string('Infinite loop detected, aborting. No errors found.'), rt.new_string('woocommerce')]))
			return iife_result_34
		}
	var_order_count = var_remaining_count.clone()
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	mut iife_temp_35 := Class_WP_CLI{}
	mut iife_result_35 := iife_temp_35.log(rt.call_function('__', [rt.new_string('Verification completed.'), rt.new_string('woocommerce')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_error_processing)))) {
		mut iife_temp_36 := Class_WP_CLI{}
		mut iife_result_36 := iife_temp_36.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d order was verified in %2$d seconds.'), rt.new_string('%1$d orders were verified in %2$d seconds.'), var_processed.clone(), rt.new_string('woocommerce')]), var_processed.clone(), var_total_time.clone()]))
		return iife_result_36
	} else {
		mut iife_temp_37 := Class_WP_CLI{}
		mut iife_result_37 := iife_temp_37.error(rt.call_function('sprintf', [rt.new_string('%1$s %2$s'), rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d order was verified in %2$d seconds.'), rt.new_string('%1$d orders were verified in %2$d seconds.'), var_processed.clone(), rt.new_string('woocommerce')]), var_processed.clone(), var_total_time.clone()]), if rt.is_true(var_failed_ids) { rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%1$d error found: %2$s. Please review the error above.'), rt.new_string('%1$d errors found: %2$s. Please review the errors above.'), rt.new_int(var_failed_ids.clone().array_count()), rt.new_string('woocommerce')]), rt.new_int(var_failed_ids.clone().array_count()), rt.call_function('wp_json_encode', [var_failed_ids.clone(), rt.get_constant('JSON_PRETTY_PRINT')])]) } else { rt.call_function('__', [rt.new_string('Please review the errors above.'), rt.new_string('woocommerce')]) }]))
		return iife_result_37
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) get_verify_order_count(order_id_start i64, order_id_end i64, mut var_order_types Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, log bool) i64 {
	mut var_wpdb := rt.new_null()
	mut order_id_start_mutated := order_id_start
	mut order_id_end_mutated := order_id_end
	mut var_order_types_mutated := var_order_types
	mut var_order_types_placeholder := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_types_mutated.array_count()), rt.new_string('%s')])])
	mut var_order_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type in (')), var_order_types_placeholder), rt.new_string(') AND ID >= %d AND ID <= %d')), rt.call_function('array_merge', [var_order_types_mutated, rt.create_array([rt.ArrayItem{ key: none, val: order_id_start_mutated }, rt.ArrayItem{ key: none, val: order_id_end_mutated }])])])])).to_i64())
	if var_log {
	mut iife_temp_38 := Class_WP_CLI{}
	mut iife_result_38 := iife_temp_38.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('There is %1$d order to be verified.'), rt.new_string('There are %1$d orders to be verified.'), var_order_count.clone(), rt.new_string('woocommerce')]), var_order_count.clone()]))
	}
	return (var_order_count).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) verify_meta_data(mut var_order_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_failed_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_failed_ids_mutated := var_failed_ids
	mut var_meta_keys_to_ignore := rt.call_method(this.synchronizer, 'get_ignored_order_props', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_order_ids_mutated.array_count()))))) {
		return rt.new_array()
	}
	mut var_excluded_columns := rt.call_function('array_merge', [rt.call_method(this.post_to_cot_migrator, 'get_migrated_meta_keys', []rt.PhpVal{}), var_meta_keys_to_ignore.clone()])
	mut var_excluded_columns_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_excluded_columns.clone().array_count()), rt.new_string('%s')])])
	mut var_order_ids_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_ids_mutated.array_count()), rt.new_string('%d')])])
	mut iife_temp_39 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_39 := iife_temp_39.get_meta_table_name()
	mut var_meta_table := iife_result_39
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id as entity_id, ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key, ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_value\nFROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\nWHERE\n      ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id in ( ')), var_order_ids_placeholder), rt.new_string(' ) AND\n      ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key not in ( ')), var_excluded_columns_placeholder), rt.new_string(' )\nORDER BY ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id ASC, ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key ASC;\n')), rt.call_function('array_merge', [var_order_ids_mutated, var_excluded_columns.clone()])])
	mut var_source_data := rt.call_method(var_wpdb, 'get_results', [var_query.clone(), rt.get_constant('ARRAY_A')])
	mut var_normalized_source_data := this.normalize_raw_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_source_data))
	mut var_migrated_query := rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT ${var_meta_table.to_string()}.order_id as entity_id, ${var_meta_table.to_string()}.meta_key, ${var_meta_table.to_string()}.meta_value\nFROM ${var_meta_table.to_string()}\nWHERE\n\t${var_meta_table.to_string()}.order_id in ( ${var_order_ids_placeholder.to_string()} )\nORDER BY ${var_meta_table.to_string()}.order_id ASC, ${var_meta_table.to_string()}.meta_key ASC;\n"), var_order_ids_mutated])
	mut var_migrated_data := rt.call_method(var_wpdb, 'get_results', [var_migrated_query.clone(), rt.get_constant('ARRAY_A')])
	mut var_normalized_migrated_meta_data := this.normalize_raw_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_migrated_data))
	mut iter_2 := var_normalized_source_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_meta := item_2.val
		mut var_order_id := item_2.key
		mut iter_3 := var_meta.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_values := item_3.val
			mut var_meta_key := item_3.key
			mut var_migrated_meta_values := if var_normalized_migrated_meta_data.array_get(var_order_id).array_isset(var_meta_key) { var_normalized_migrated_meta_data.array_get(var_order_id).array_get(var_meta_key) } else { rt.new_array() }
			mut var_diff := rt.call_function('array_diff', [var_values.clone(), var_migrated_meta_values.clone()])
			if rt.is_true(rt.new_int(var_diff.clone().array_count())) {
				if !(var_failed_ids_mutated.array_isset(var_order_id)) {
					var_failed_ids_mutated.array_set(var_order_id, rt.new_array())
				}
				var_failed_ids_mutated.array_get_mut(var_order_id).array_push(rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'meta_key', val: var_meta_key }, rt.ArrayItem{ key: 'orig_meta_values', val: var_values }, rt.ArrayItem{ key: 'new_meta_values', val: var_migrated_meta_values }]))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array', []string{}, var_failed_ids_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) normalize_raw_meta_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_clubbed_data := rt.new_array()
	mut iter_4 := var_data.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_row := item_4.val
		if !(var_clubbed_data.array_isset(var_row.array_get(rt.new_string('entity_id')))) {
			var_clubbed_data.array_set(var_row.array_get(rt.new_string('entity_id')), rt.new_array())
		}
		if !(var_clubbed_data.array_get(var_row.array_get(rt.new_string('entity_id'))).array_isset(var_row.array_get(rt.new_string('meta_key')))) {
			var_clubbed_data.array_get_mut(var_row.array_get(rt.new_string('entity_id'))).array_set(var_row.array_get(rt.new_string('meta_key')), rt.new_array())
		}
		var_clubbed_data.array_get_mut(var_row.array_get(rt.new_string('entity_id'))).array_get_mut(var_row.array_get(rt.new_string('meta_key'))).array_push(var_row.array_get(rt.new_string('meta_value')))
	}
	return var_clubbed_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) enable(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_assoc_args_mutated := var_assoc_args
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated, rt.create_array([rt.ArrayItem{ key: 'for-new-shop', val: false }, rt.ArrayItem{ key: 'with-sync', val: false }, rt.ArrayItem{ key: 'ignore-plugin-compatibility', val: false }])])
	mut var_enable_hpos := rt.new_bool(true)
	mut iife_temp_40 := Class_WP_CLI{}
	mut iife_result_40 := iife_temp_40.log(rt.call_function('__', [rt.new_string('Running pre-enable checks...'), rt.new_string('woocommerce')]))
	mut iife_temp_41 := Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install{}
	mut iife_result_41 := iife_temp_41.is_new_install()
	mut var_is_new_shop := iife_result_41
	if rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('for-new-shop'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_new_shop)))) {
	mut iife_temp_42 := Class_WP_CLI{}
	mut iife_result_42 := iife_temp_42.error(rt.call_function('__', [rt.new_string('[Failed] This is not a new shop, but --for-new-shop flag was passed.'), rt.new_string('woocommerce')]))
	}
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_feature_controller := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('ignore-plugin-compatibility')))))) {
		mut var_compatibility_info := rt.call_method(var_feature_controller, 'get_compatible_plugins_for_feature', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
		mut var_plugin_util := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Utilities_PluginUtil.class()])
		mut var_incompatibles := rt.call_method(var_plugin_util, 'get_items_considered_incompatible', [rt.new_string('custom_order_tables'), var_compatibility_info.clone()])
		if var_incompatibles.clone().array_count() > 0 {
		mut iife_temp_43 := Class_WP_CLI{}
		mut iife_result_43 := iife_temp_43.warning(rt.call_function('__', [rt.new_string('[Failed] Some installed plugins are incompatible. Please review the plugins by going to WooCommerce > Settings > Advanced > Features and see the "Order data storage" section.'), rt.new_string('woocommerce')]))
		var_enable_hpos = rt.new_bool(false)
		}
	}
	mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	mut var_pending_orders := rt.call_method(var_data_synchronizer, 'get_total_pending_count', []rt.PhpVal{})
	mut var_table_exists := rt.call_method(var_data_synchronizer, 'check_orders_table_exists', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_table_exists)))) {
		mut iife_temp_44 := Class_WP_CLI{}
		mut iife_result_44 := iife_temp_44.warning(rt.call_function('__', [rt.new_string('Orders table does not exist. Creating...'), rt.new_string('woocommerce')]))
		if rt.is_true(var_is_new_shop) || rt.is_true(rt.identical(rt.new_int(0), var_pending_orders)) {
			rt.call_method(var_data_synchronizer, 'create_database_tables', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_data_synchronizer, 'check_orders_table_exists', []rt.PhpVal{})) {
			mut iife_temp_45 := Class_WP_CLI{}
			mut iife_result_45 := iife_temp_45.log(rt.call_function('__', [rt.new_string('Orders table created.'), rt.new_string('woocommerce')]))
			var_table_exists = rt.new_bool(true)
			} else {
			mut iife_temp_46 := Class_WP_CLI{}
			mut iife_result_46 := iife_temp_46.warning(rt.call_function('__', [rt.new_string('[Failed] Orders table could not be created.'), rt.new_string('woocommerce')]))
			var_enable_hpos = rt.new_bool(false)
			}
		} else {
		mut iife_temp_47 := Class_WP_CLI{}
		mut iife_result_47 := iife_temp_47.warning(rt.call_function('__', [rt.new_string('[Failed] The orders table does not exist and this is not a new shop. Please create the table by going to WooCommerce > Settings > Advanced > Features and enabling sync.'), rt.new_string('woocommerce')]))
		var_enable_hpos = rt.new_bool(false)
		}
	}
	if rt.is_true(rt.greater(var_pending_orders, rt.new_int(0))) {
	mut iife_temp_48 := Class_WP_CLI{}
	mut iife_result_48 := iife_temp_48.warning(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[Failed] There are orders pending sync. Please run `%s` to sync pending orders.'), rt.new_string('woocommerce')]), rt.new_string('wp wc hpos sync')]))
	var_enable_hpos = rt.new_bool(false)
	}
	if rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('with-sync'))) && rt.is_true(var_table_exists) {
		this.toggle_compat_mode(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_enable_hpos)))) {
		mut iife_temp_49 := Class_WP_CLI{}
		mut iife_result_49 := iife_temp_49.error(rt.call_function('__', [rt.new_string('HPOS pre-checks failed, please see the errors above'), rt.new_string('woocommerce')]))
		return
	}
	mut var_cot_status := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()])
	if rt.is_true(rt.call_method(var_cot_status, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})) {
	mut iife_temp_50 := Class_WP_CLI{}
	mut iife_result_50 := iife_temp_50.warning(rt.call_function('__', [rt.new_string('HPOS is already enabled.'), rt.new_string('woocommerce')]))
	} else {
		rt.call_method(var_feature_controller, 'change_feature_enable', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
		if rt.is_true(rt.call_method(var_cot_status, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})) {
		mut iife_temp_51 := Class_WP_CLI{}
		mut iife_result_51 := iife_temp_51.success(rt.call_function('__', [rt.new_string('HPOS enabled.'), rt.new_string('woocommerce')]))
		} else {
		mut iife_temp_52 := Class_WP_CLI{}
		mut iife_result_52 := iife_temp_52.error(rt.call_function('__', [rt.new_string('HPOS could not be enabled.'), rt.new_string('woocommerce')]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) disable(var_args rt.PhpVal, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	var_assoc_args_mutated = rt.call_function('wp_parse_args', [var_assoc_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'with-sync', val: false }])])
	mut iife_temp_53 := Class_WP_CLI{}
	mut iife_result_53 := iife_temp_53.log(rt.call_function('__', [rt.new_string('Running pre-disable checks...'), rt.new_string('woocommerce')]))
	mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	mut var_pending_orders := rt.call_method(var_data_synchronizer, 'get_total_pending_count', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_pending_orders, rt.new_int(0))) {
		mut iife_temp_54 := Class_WP_CLI{}
		mut iife_result_54 := iife_temp_54.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('[Failed] There are orders pending sync. Please run `%s` to sync pending orders.'), rt.new_string('woocommerce')]), rt.new_string('wp wc hpos sync')]))
		return iife_result_54
	}
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	mut var_cot_status := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cot_status, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{}))))) {
	mut iife_temp_55 := Class_WP_CLI{}
	mut iife_result_55 := iife_temp_55.warning(rt.call_function('__', [rt.new_string('HPOS is already disabled.'), rt.new_string('woocommerce')]))
	} else {
		rt.call_method(var_feature_controller, 'change_feature_enable', [rt.new_string('custom_order_tables'), rt.new_bool(false)])
		if rt.is_true(rt.call_method(var_cot_status, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})) {
			mut iife_temp_56 := Class_WP_CLI{}
			mut iife_result_56 := iife_temp_56.warning(rt.call_function('__', [rt.new_string('HPOS could not be disabled.'), rt.new_string('woocommerce')]))
			return iife_result_56
		} else {
		mut iife_temp_57 := Class_WP_CLI{}
		mut iife_result_57 := iife_temp_57.success(rt.call_function('__', [rt.new_string('HPOS disabled.'), rt.new_string('woocommerce')]))
		}
	}
	if rt.is_true(var_assoc_args_mutated.array_get(rt.new_string('with-sync'))) {
		this.toggle_compat_mode(false)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) cleanup_post_data(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_assoc_args_mutated := var_assoc_args
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'custom_orders_table_is_authoritative', []rt.PhpVal{}))))) || rt.is_true(rt.call_method(this.synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) {
	mut iife_temp_58 := Class_WP_CLI{}
	mut iife_result_58 := iife_temp_58.error(rt.call_function('__', [rt.new_string('Cleanup can only be performed when HPOS is active and compatibility mode is disabled.'), rt.new_string('woocommerce')]))
	}
	mut var_handler := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler.class()])
	mut var_all_orders := rt.identical(rt.new_string('all'), var_args.array_get(rt.new_int(0)))
	mut var_force := rt.new_bool((if !(var_assoc_args_mutated.array_get(rt.new_string('force'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('force')) } else { rt.new_bool(false) }).to_bool())
	mut var_q_order_ids := if rt.is_true(var_all_orders) { rt.new_array() } else { var_args }
	mut var_q_limit := if rt.is_true(var_all_orders) { rt.call_function('absint', [if !(var_assoc_args_mutated.array_get(rt.new_string('batch-size'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('batch-size')) } else { rt.new_int(500) }]) } else { rt.new_int(0) }
	mut var_order_count := rt.call_method(var_handler, 'count_orders_for_cleanup', [var_q_order_ids.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_count)))) {
		mut iife_temp_59 := Class_WP_CLI{}
		mut iife_result_59 := iife_temp_59.warning(rt.call_function('__', [rt.new_string('No orders to cleanup.'), rt.new_string('woocommerce')]))
		return rt.new_null()
	}
	mut var_progress := rt.call_function('WP_CLI\Utils\make_progress_bar', [rt.call_function('__', [rt.new_string('HPOS cleanup'), rt.new_string('woocommerce')]), var_order_count.clone()])
	mut var_count := rt.new_int(0)
	mut var_failed_ids := rt.new_array()
	mut iife_temp_60 := Class_WP_CLI{}
	mut iife_result_60 := iife_temp_60.log(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Starting cleanup for %d order...'), rt.new_string('Starting cleanup for %d orders...'), var_order_count.clone(), rt.new_string('woocommerce')]), var_order_count.clone()]))
	for {
		mut var_failed_ids_in_batch := rt.new_array()
		mut var_order_ids := rt.call_method(var_handler, 'get_orders_for_cleanup', [var_q_order_ids.clone(), var_q_limit.clone()])
		if rt.is_true(var_failed_ids) && !rt.is_true(rt.call_function('array_diff', [var_order_ids.clone(), var_failed_ids.clone()])) {
			break
		}
		var_order_ids = rt.call_function('array_diff', [var_order_ids.clone(), var_failed_ids.clone()])
		mut iter_5 := var_order_ids.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_order_id := item_5.val
			rt.call_method(var_handler, 'cleanup_post_data', [var_order_id.clone(), var_force.clone()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.pre_inc(var_count)
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut iife_temp_61 := Class_WP_CLI{}
			mut iife_result_61 := iife_temp_61.debug(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cleanup completed for order %d.'), rt.new_string('woocommerce')]), var_order_id.clone()]))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception') {
				mut var_e := var_e_1.clone()
				mut iife_temp_62 := Class_WP_CLI{}
				mut iife_result_62 := iife_temp_62.warning(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error occurred while cleaning up order %1$d: %2$s'), rt.new_string('woocommerce')]), var_order_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]))
				var_failed_ids_in_batch.array_push(var_order_id.clone())
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			rt.call_method(var_progress, 'tick', []rt.PhpVal{})
		}
		var_failed_ids = rt.call_function('array_merge', [var_failed_ids.clone(), var_failed_ids_in_batch.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_all_orders)))) {
			break
		}
		if rt.is_true(var_failed_ids_in_batch) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_diff', [var_order_ids.clone(), var_failed_ids_in_batch.clone()]))))) {
			mut iife_temp_63 := Class_WP_CLI{}
			mut iife_result_63 := iife_temp_63.warning(rt.call_function('__', [rt.new_string('Failed to clean up all orders in a batch. Aborting.'), rt.new_string('woocommerce')]))
			break
		}
		this.free_in_memory_usage()
		if !(rt.is_true(var_order_ids)) {
			break
		}
	}
	rt.call_method(var_progress, 'finish', []rt.PhpVal{})
	if rt.is_true(var_failed_ids) {
		mut iife_temp_64 := Class_WP_CLI{}
		mut iife_result_64 := iife_temp_64.error(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Cleanup completed for %d order. Review errors above.'), rt.new_string('Cleanup completed for %d orders. Review errors above.'), var_count.clone(), rt.new_string('woocommerce')]), var_count.clone()]))
		return iife_result_64
	}
	mut iife_temp_65 := Class_WP_CLI{}
	mut iife_result_65 := iife_temp_65.success(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Cleanup completed for %d order.'), rt.new_string('Cleanup completed for %d orders.'), var_count.clone(), rt.new_string('woocommerce')]), var_count.clone()]))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) status(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_assoc_args_mutated := var_assoc_args
mut var_legacy_handler := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler.class()])
mut iife_temp_66 := Class_WP_CLI{}
mut iife_result_66 := iife_temp_66.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('HPOS enabled?: %s'), rt.new_string('woocommerce')]), rt.call_function('wc_bool_to_string', [rt.call_method(this.controller, 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})])]))
mut iife_temp_67 := Class_WP_CLI{}
mut iife_result_67 := iife_temp_67.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Compatibility mode enabled?: %s'), rt.new_string('woocommerce')]), rt.call_function('wc_bool_to_string', [rt.call_method(this.synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})])]))
mut iife_temp_68 := Class_WP_CLI{}
mut iife_result_68 := iife_temp_68.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unsynced orders: %d'), rt.new_string('woocommerce')]), rt.call_method(this.synchronizer, 'get_current_orders_pending_sync_count', []rt.PhpVal{})]))
mut iife_temp_69 := Class_WP_CLI{}
mut iife_result_69 := iife_temp_69.log(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Orders subject to cleanup: %d'), rt.new_string('woocommerce')]), if rt.is_true(rt.call_method(this.synchronizer, 'custom_orders_table_is_authoritative', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'data_sync_is_enabled', []rt.PhpVal{}))))) { rt.call_method(var_legacy_handler, 'count_orders_for_cleanup', []rt.PhpVal{}) } else { rt.new_int(0) }]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) diff(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_assoc_args_mutated := var_assoc_args
	mut var_id := rt.call_function('absint', [var_args.array_get(rt.new_int(0))])
	mut var_diff := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler.class()]), 'get_diff_for_order', [var_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception') {
		mut var_e := var_e_2.clone()
		mut iife_temp_70 := Class_WP_CLI{}
		mut iife_result_70 := iife_temp_70.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error occurred while computing a diff for order %1$d: %2$s'), rt.new_string('woocommerce')]), var_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(rt.new_bool(!(rt.is_true(var_diff)))) {
		mut iife_temp_71 := Class_WP_CLI{}
		mut iife_result_71 := iife_temp_71.success(rt.call_function('__', [rt.new_string('No differences found.'), rt.new_string('woocommerce')]))
		return
	}
	closure_73_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_hpos_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_cpt_value := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		var_hpos_value = if rt.is_true(rt.call_function('is_a', [var_hpos_value.clone(), Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_DateTime.class()])) { rt.call_method(var_hpos_value, 'format', [rt.get_constant('DATE_ATOM')]) } else { var_hpos_value }
		var_cpt_value = if rt.is_true(rt.call_function('is_a', [var_cpt_value.clone(), Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_DateTime.class()])) { rt.call_method(var_cpt_value, 'format', [rt.get_constant('DATE_ATOM')]) } else { var_cpt_value }
		var_hpos_value = if var_hpos_value.clone().is_null() { rt.new_string('') } else { var_hpos_value }
		var_cpt_value = if var_cpt_value.clone().is_null() { rt.new_string('') } else { var_cpt_value }
		return
		}
	closure_74_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_hpos_value := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_cpt_value := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		var_hpos_value = if rt.is_true(rt.call_function('is_a', [var_hpos_value.clone(), Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_DateTime.class()])) { rt.call_method(var_hpos_value, 'format', [rt.get_constant('DATE_ATOM')]) } else { var_hpos_value }
		var_cpt_value = if rt.is_true(rt.call_function('is_a', [var_cpt_value.clone(), Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_DateTime.class()])) { rt.call_method(var_cpt_value, 'format', [rt.get_constant('DATE_ATOM')]) } else { var_cpt_value }
		var_hpos_value = if var_hpos_value.clone().is_null() { rt.new_string('') } else { var_hpos_value }
		var_cpt_value = if var_cpt_value.clone().is_null() { rt.new_string('') } else { var_cpt_value }
		return
		}
	var_diff = rt.call_function('array_map', [rt.new_closure(closure_73_fn), rt.func_array_keys(var_diff.clone()), rt.call_function('array_column', [var_diff.clone(), rt.new_int(0)]), rt.call_function('array_column', [var_diff.clone(), rt.new_int(1)])])
	mut iife_temp_74 := Class_WP_CLI{}
	mut iife_result_74 := iife_temp_74.warning(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Differences found for order %d:'), rt.new_string('woocommerce')]), var_id.clone()]))
	rt.call_function('WP_CLI\Utils\format_items', [if !(var_assoc_args_mutated.array_get(rt.new_string('format'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('format')) } else { rt.new_string('table') }, var_diff.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'property' }, rt.ArrayItem{ key: none, val: 'hpos' }, rt.ArrayItem{ key: none, val: 'post' }])])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) backfill(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_{"nodeType":"Scalar_InterpolatedString","line":1186,"parts":[{"nodeType":"Expr_Variable","line":1186,"name":"datastore"}]} := rt.new_null()
	mut var_{"nodeType":"Scalar_InterpolatedString","line":1188,"parts":[{"nodeType":"Expr_Variable","line":1188,"name":"datastore"}]} := rt.new_null()
	mut var_assoc_args_mutated := var_assoc_args
	mut var_legacy_handler := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataHandler.class()])
	mut var_from := if !(var_assoc_args_mutated.array_get(rt.new_string('from'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('from')) } else { rt.new_string('') }
	mut var_to := if !(var_assoc_args_mutated.array_get(rt.new_string('to'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('to')) } else { rt.new_string('') }
	mut var_order_id := rt.call_function('absint', [var_args.array_get(rt.new_int(0))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
	mut iife_temp_75 := Class_WP_CLI{}
	mut iife_result_75 := iife_temp_75.error(rt.call_function('__', [rt.new_string('Please provide a valid order ID.'), rt.new_string('woocommerce')]))
	}
	mut iter_6 := rt.create_array([rt.ArrayItem{ key: none, val: 'from' }, rt.ArrayItem{ key: none, val: 'to' }]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_datastore := item_6.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_{"nodeType":"Scalar_InterpolatedString","line":1186,"parts":[{"nodeType":"Expr_Variable","line":1186,"name":"datastore"}]}.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'posts' }, rt.ArrayItem{ key: none, val: 'hpos' }]), rt.new_bool(true)]))))) {
		mut iife_temp_76 := Class_WP_CLI{}
		mut iife_result_76 := iife_temp_76.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('\'%s\' is not a valid datastore.'), rt.new_string('woocommerce')]), var_{"nodeType":"Scalar_InterpolatedString","line":1188,"parts":[{"nodeType":"Expr_Variable","line":1188,"name":"datastore"}]}.clone()]))
		}
	}
	if rt.is_true(rt.identical(var_from, var_to)) {
	mut iife_temp_77 := Class_WP_CLI{}
	mut iife_result_77 := iife_temp_77.error(rt.call_function('__', [rt.new_string('Please use different source (--from) and destination (--to) datastores.'), rt.new_string('woocommerce')]))
	}
	mut var_fields := rt.call_function('array_intersect_key', [var_assoc_args_mutated, rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'meta_keys' }, rt.ArrayItem{ key: none, val: 'props' }])])])
	mut iter_7 := var_fields.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_field_names := item_7.val
	var_field_names = if var_field_names.clone().is_string() { rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_field_names.clone()])]) } else { var_field_names }
	var_field_names = rt.call_function('array_unique', [rt.call_function('array_filter', [rt.call_function('array_filter', [var_field_names.clone(), rt.new_string('is_string')])])])
	}
	rt.call_method(var_legacy_handler, 'backfill_order_to_datastore', [var_order_id.clone(), var_from.clone(), var_to.clone(), var_fields.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception') {
		mut var_e := var_e_3.clone()
		mut iife_temp_78 := Class_WP_CLI{}
		mut iife_result_78 := iife_temp_78.error(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An error occurred while backfilling order %1$d from %2$s to %3$s: %4$s'), rt.new_string('woocommerce')]), var_order_id.clone(), var_from.clone(), var_to.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
mut iife_temp_79 := Class_WP_CLI{}
mut iife_result_79 := iife_temp_79.success(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order %1$d backfilled from %2$s to %3$s.'), rt.new_string('woocommerce')]), var_order_id.clone(), var_from.clone(), var_to.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) compatibility_info(mut var_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_assoc_args Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut var_assoc_args_mutated := var_assoc_args
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_feature_controller := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	mut var_plugin_info := rt.call_method(var_feature_controller, 'get_compatible_plugins_for_feature', [rt.new_string('custom_order_tables'), rt.new_bool(!(rt.is_true((if !(var_assoc_args_mutated.array_get(rt.new_string('include-inactive'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('include-inactive')) } else { rt.new_null() }).to_bool())))])
	mut var_display_filenames := rt.new_bool((if !(var_assoc_args_mutated.array_get(rt.new_string('display-filenames'))).is_null() { var_assoc_args_mutated.array_get(rt.new_string('display-filenames')) } else { rt.new_null() }).to_bool())
	mut var_compatibles := this.get_printable_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_plugin_info.array_get(rt.new_string('compatible'))), (var_display_filenames).to_bool())
	mut var_compatibles_count := rt.new_int(var_compatibles.clone().array_count())
	this.log((rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('\n%%C%1$d%%n compatible plugin found%2$s'), rt.new_string('\n%%C%1$d%%n compatible plugins found%2$s'), var_compatibles_count.clone(), rt.new_string('woocommerce')]), var_compatibles_count.clone(), rt.new_string((if rt.is_true(rt.greater(var_compatibles_count, rt.new_int(0))) { ':\n' } else { '' }).str())])).str())
	this.print_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_compatibles))
	mut var_incompatibles := this.get_printable_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_plugin_info.array_get(rt.new_string('incompatible'))), (var_display_filenames).to_bool())
	mut var_incompatibles_count := rt.new_int(var_incompatibles.clone().array_count())
	this.log((rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('\n%%C%1$d%%n incompatible plugin found%2$s'), rt.new_string('\n%%C%1$d%%n incompatible plugins found%2$s'), var_incompatibles_count.clone(), rt.new_string('woocommerce')]), var_incompatibles_count.clone(), rt.new_string((if rt.is_true(rt.greater(var_incompatibles_count, rt.new_int(0))) { ':\n' } else { '' }).str())])).str())
	this.print_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_incompatibles))
	mut var_uncertain := this.get_printable_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_plugin_info.array_get(rt.new_string('uncertain'))), (var_display_filenames).to_bool())
	mut var_uncertain_count := rt.new_int(var_uncertain.clone().array_count())
	this.log((rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('\n%%C%1$d%%n uncertain plugin found%2$s'), rt.new_string('\n%%C%1$d%%n uncertain plugins found%2$s'), var_uncertain_count.clone(), rt.new_string('woocommerce')]), var_uncertain_count.clone(), rt.new_string((if rt.is_true(rt.greater(var_uncertain_count, rt.new_int(0))) { ':\n' } else { '' }).str())])).str())
	this.print_plugin_names(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_uncertain))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) get_printable_plugin_names(mut var_plugins Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, display_filenames bool) rt.PhpVal {
	mut var_plugin_file := rt.new_null()
	mut display_filenames_mutated := display_filenames
	if rt.is_true(rt.new_bool(display_filenames_mutated)) {
		rt.call_function('sort', [var_plugins])
		return rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array', []string{}, var_plugins)
	}
	closure_81_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if !(rt.call_function('get_plugin_data', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_plugin_file).str()), rt.new_bool(false)]).array_get(rt.new_string('Name'))).is_null() { rt.call_function('get_plugin_data', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_plugin_file).str()), rt.new_bool(false)]).array_get(rt.new_string('Name')) } else { var_plugin_file }
		}
	closure_82_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return if !(rt.call_function('get_plugin_data', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_plugin_file).str()), rt.new_bool(false)]).array_get(rt.new_string('Name'))).is_null() { rt.call_function('get_plugin_data', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (var_plugin_file).str()), rt.new_bool(false)]).array_get(rt.new_string('Name')) } else { var_plugin_file }
		}
	mut var_plugin_names := rt.call_function('array_map', [rt.new_closure(closure_81_fn), var_plugins])
	rt.call_function('sort', [var_plugin_names.clone()])
	return var_plugin_names.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) print_plugin_names(mut var_plugins Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut iter_8 := var_plugins.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_plugin_file := item_8.val
		this.log('  ' + (var_plugin_file).str())
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) log(text string) {
mut iife_temp_82 := Class_WP_CLI{}
mut iife_result_82 := iife_temp_82.colorize(rt.new_string(text))
mut iife_temp_83 := Class_WP_CLI{}
mut iife_result_83 := iife_temp_83.log(iife_result_82)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) enable_compat_mode() {
	this.toggle_compat_mode(true)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) disable_compat_mode() {
	this.toggle_compat_mode(false)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner) toggle_compat_mode(enabled bool) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		if var_enabled {
			rt.call_method(this.synchronizer, 'create_database_tables', []rt.PhpVal{})
		} else {
		mut iife_temp_84 := Class_WP_CLI{}
		mut iife_result_84 := iife_temp_84.error(rt.call_function('__', [rt.new_string('HPOS tables do not exist.'), rt.new_string('woocommerce')]))
		}
	}
	mut var_currently_enabled := rt.call_method(this.synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_currently_enabled, rt.new_bool(enabled))) {
		if var_enabled {
		mut iife_temp_85 := Class_WP_CLI{}
		mut iife_result_85 := iife_temp_85.warning(rt.call_function('__', [rt.new_string('Compatibility mode is already enabled.'), rt.new_string('woocommerce')]))
		} else {
		mut iife_temp_86 := Class_WP_CLI{}
		mut iife_result_86 := iife_temp_86.warning(rt.call_function('__', [rt.new_string('Compatibility mode is already disabled.'), rt.new_string('woocommerce')]))
		}
		return
	}
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_{"nodeType":"Expr_PropertyFetch","line":1372,"var":{"nodeType":"Expr_Variable","line":1372,"name":"this"},"name":"synchronizer"}.orders_data_sync_enabled_option(), rt.call_function('wc_bool_to_string', [rt.new_bool(enabled)])])
	if var_enabled {
	mut iife_temp_87 := Class_WP_CLI{}
	mut iife_result_87 := iife_temp_87.success(rt.call_function('__', [rt.new_string('Compatibility mode enabled.'), rt.new_string('woocommerce')]))
	} else {
	mut iife_temp_88 := Class_WP_CLI{}
	mut iife_result_88 := iife_temp_88.success(rt.call_function('__', [rt.new_string('Compatibility mode disabled.'), rt.new_string('woocommerce')]))
	}
}

struct Class_WP_CLI {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_clirunner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_CLIRunner{
		PhpObjectBase: rt.PhpObjectBase{}
		controller: rt.new_null()
		synchronizer: rt.new_null()
		post_to_cot_migrator: rt.new_null()
	}
	return obj
}

fn create_wp_cli(_args ...rt.PhpVal) &Class_WP_CLI {
	mut obj := &Class_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_wc_install(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install{
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
