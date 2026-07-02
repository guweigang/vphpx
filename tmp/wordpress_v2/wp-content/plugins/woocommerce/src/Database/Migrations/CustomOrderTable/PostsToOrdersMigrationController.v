import rt

pub fn Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController.logs_source_name() string {
	return 'posts-to-orders-migration'
}
struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController {
	rt.PhpObjectBase
pub mut:
		error_logger rt.PhpVal = rt.new_null()
		all_migrators rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) construct() {
	this.all_migrators = rt.new_array()
	this.all_migrators.array_set('order', create_automattic_woocommerce_database_migrations_customordertable_posttoordertablemigrator())
	this.all_migrators.array_set('order_address_billing', create_automattic_woocommerce_database_migrations_customordertable_posttoorderaddresstablemigrator(rt.new_string('billing')))
	this.all_migrators.array_set('order_address_shipping', create_automattic_woocommerce_database_migrations_customordertable_posttoorderaddresstablemigrator(rt.new_string('shipping')))
	this.all_migrators.array_set('order_operational_data', create_automattic_woocommerce_database_migrations_customordertable_posttoorderoptablemigrator())
	this.all_migrators.array_set('order_meta', create_automattic_woocommerce_database_migrations_customordertable_postmetatoordermetamigrator(this.get_migrated_meta_keys()))
	this.error_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) get_migrated_meta_keys() rt.PhpVal {
	mut var_migrated_meta_keys := rt.new_array()
	mut iter_1 := this.all_migrators.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_migrator := item_1.val
		mut var_name := item_1.key
		if rt.is_true(rt.call_function('method_exists', [var_migrator.clone(), rt.new_string('get_meta_column_config')])) {
		var_migrated_meta_keys = rt.call_function('array_merge', [var_migrated_meta_keys.clone(), rt.call_method(var_migrator, 'get_meta_column_config', []rt.PhpVal{})])
		}
	}
	return rt.func_array_keys(var_migrated_meta_keys.clone())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) migrate_orders(mut var_order_post_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	this.error_logger = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_logger')])
	mut var_data := rt.new_array()
	mut iter_2 := this.all_migrators.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_migrator := item_2.val
		mut var_name := item_2.key
		var_data.array_set(var_name, rt.call_method(var_migrator, 'fetch_sanitized_migration_data', [var_order_post_ids]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if !(!rt.is_true(var_data.array_get(var_name).array_get(rt.new_string('errors')))) {
			this.handle_migration_error(mut var_order_post_ids, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_data.array_get(var_name).array_get(rt.new_string('errors'))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?Exception](rt.new_null()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?bool](rt.new_null()), (var_name).str())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			return
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception') {
		mut var_e := var_e_1.clone()
		this.handle_migration_error(mut var_order_post_ids, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_data), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?Exception](var_e), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?bool](rt.new_null()), 'Fetching data')
		return
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	mut var_using_transactions := rt.new_bool(this.maybe_start_transaction())
	mut iter_3 := this.all_migrators.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_migrator := item_3.val
		mut var_name := item_3.key
		mut var_results := rt.call_method(var_migrator, 'process_migration_data', [var_data.array_get(var_name)])
		mut var_errors := rt.call_function('array_unique', [var_results.array_get(rt.new_string('errors'))])
		mut var_exception := var_results.array_get(rt.new_string('exception'))
		if rt.is_true(rt.identical(rt.new_null(), var_exception)) && !rt.is_true(var_errors) {
			continue
		}
		this.handle_migration_error(mut var_order_post_ids, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](var_errors), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?Exception](var_exception), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?bool](var_using_transactions), (var_name).str())
		return
	}
	if rt.is_true(var_using_transactions) {
		this.commit_transaction()
	}
	this.maybe_clear_order_datastore_cache_for_ids(mut var_order_post_ids)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) handle_migration_error(mut var_order_post_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_errors Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array, mut var_exception Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?Exception, mut var_using_transactions Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?bool, name string) {
	mut var_errors_mutated := var_errors
	mut var_exception_mutated := var_exception
	mut var_using_transactions_mutated := var_using_transactions
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_0 := iife_temp_0.to_ranges_string(rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array', []string{}, var_order_post_ids))
	mut var_batch := iife_result_0
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_exception_mutated)))) {
		mut var_exception_class := rt.call_function('get_class', [var_exception_mutated])
		rt.call_method(this.error_logger, 'error', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(name), rt.new_string(': when processing ids ')), var_batch), rt.new_string(': (')), var_exception_class), rt.new_string(') ')), rt.call_method(var_exception_mutated, 'getMessage', []rt.PhpVal{})), rt.new_string(', ')), rt.call_method(var_exception_mutated, 'getTraceAsString', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController.logs_source_name() }, rt.ArrayItem{ key: 'ids', val: var_order_post_ids }, rt.ArrayItem{ key: 'exception', val: var_exception_mutated }])])
	}
	mut iter_4 := var_errors_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_error := item_4.val
		rt.call_method(this.error_logger, 'error', [rt.new_string("${var_name}: when processing ids ${var_batch.to_string()}: ${var_error.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController.logs_source_name() }, rt.ArrayItem{ key: 'ids', val: var_order_post_ids }, rt.ArrayItem{ key: 'error', val: var_error }])])
	}
	if rt.is_true(var_using_transactions_mutated) {
		this.rollback_transaction()
	} else {
		this.maybe_clear_order_datastore_cache_for_ids(mut var_order_post_ids)
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) maybe_clear_order_datastore_cache_for_ids(mut var_order_post_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.custom_orders_table_datastore_cache_enabled()
	if rt.is_true(iife_result_1) {
		mut var_orders_table_datastore := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class()])
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_orders_table_datastore }, rt.ArrayItem{ key: none, val: 'clear_cached_data' }])])) {
			rt.call_method(var_orders_table_datastore, 'clear_cached_data', [var_order_post_ids])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) maybe_start_transaction() bool {
	mut var_use_transactions := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.use_db_transactions_option(), rt.new_string('yes')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), var_use_transactions)))) {
		return (rt.new_null()).to_bool()
	}
	mut var_transaction_isolation_level := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.db_transactions_isolation_level_option(), Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.default_db_transactions_isolation_level()])
	mut var_valid_transaction_isolation_levels := rt.create_array([rt.ArrayItem{ key: none, val: 'READ UNCOMMITTED' }, rt.ArrayItem{ key: none, val: 'READ COMMITTED' }, rt.ArrayItem{ key: none, val: 'REPEATABLE READ' }, rt.ArrayItem{ key: none, val: 'SERIALIZABLE' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_transaction_isolation_level.clone(), var_valid_transaction_isolation_levels.clone(), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception', []string{}, create_automattic_woocommerce_database_migrations_customordertable_exception(rt.new_string("Invalid database transaction isolation level name ${var_transaction_isolation_level.to_string()}"))))
	}
	mut var_set_transaction_isolation_level_command := rt.new_string("SET TRANSACTION ISOLATION LEVEL ${var_transaction_isolation_level.to_string()}")
	if !(this.db_query((var_set_transaction_isolation_level_command).str(), true)) {
		return (rt.new_null()).to_bool()
	}
	return (if this.db_query('START TRANSACTION', false) { rt.new_bool(true) } else { rt.new_null() }).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) commit_transaction() bool {
	return this.db_query('COMMIT', false)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) rollback_transaction() bool {
	return this.db_query('ROLLBACK', false)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) db_query(query string, supress_errors bool) bool {
	mut var_wpdb := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_global', [rt.new_string('wpdb')])
	if var_supress_errors {
		mut var_suppress := rt.call_method(var_wpdb, 'suppress_errors', [rt.new_bool(true)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_wpdb, 'query', [rt.new_string(query)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_supress_errors {
		rt.call_method(var_wpdb, 'suppress_errors', [var_suppress.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception') {
		mut var_exception := var_e_2.clone()
		mut var_exception_class := rt.call_function('get_class', [var_exception.clone()])
		rt.call_method(this.error_logger, 'error', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('PostsToOrdersMigrationController: when executing '), rt.new_string(query)), rt.new_string(': (')), var_exception_class), rt.new_string(') ')), rt.call_method(var_exception, 'getMessage', []rt.PhpVal{})), rt.new_string(', ')), rt.call_method(var_exception, 'getTraceAsString', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController.logs_source_name() }, rt.ArrayItem{ key: 'exception', val: var_exception }])])
		return false
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	mut var_error := rt.get_property(var_wpdb, 'last_error')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_error)))) {
		rt.call_method(this.error_logger, 'error', [rt.new_string("PostsToOrdersMigrationController: when executing ${var_query}: ${var_error.to_string()}"), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController.logs_source_name() }, rt.ArrayItem{ key: 'error', val: var_error }])])
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) verify_migrated_orders(mut var_order_post_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) rt.PhpVal {
	mut var_errors := rt.new_array()
	mut iter_5 := this.all_migrators.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_migrator := item_5.val
		if rt.is_true(rt.call_function('method_exists', [var_migrator.clone(), rt.new_string('verify_migrated_data')])) {
		var_errors = rt.add(var_errors, rt.call_method(var_migrator, 'verify_migrated_data', [var_order_post_ids]))
		}
	}
	return var_errors.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) migrate_order(order_post_id i64) {
	this.migrate_orders(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](rt.create_array([rt.ArrayItem{ key: none, val: order_post_id }])))
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_poststoordersmigrationcontroller() &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController{
		PhpObjectBase: rt.PhpObjectBase{}
		error_logger: rt.new_null()
		all_migrators: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoordertablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoorderaddresstablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoorderoptablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_postmetatoordermetamigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator{
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

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_customordertable_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_migrated_meta_keys' {
			return this.get_migrated_meta_keys()
		}
		'migrate_orders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.migrate_orders(mut dispatch_arg_0)
			return rt.new_null()
		}
		'handle_migration_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?Exception](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_?bool](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			this.handle_migration_error(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'maybe_clear_order_datastore_cache_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.maybe_clear_order_datastore_cache_for_ids(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_start_transaction' {
			return rt.new_bool(this.maybe_start_transaction())
		}
		'commit_transaction' {
			return rt.new_bool(this.commit_transaction())
		}
		'rollback_transaction' {
			return rt.new_bool(this.rollback_transaction())
		}
		'db_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.db_query(dispatch_arg_0, dispatch_arg_1))
		}
		'verify_migrated_orders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.verify_migrated_orders(mut dispatch_arg_0)
		}
		'migrate_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.migrate_order(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error_logger' { return this.error_logger }
		'all_migrators' { return this.all_migrators }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error_logger' { this.error_logger = val; return true }
		'all_migrators' { this.all_migrators = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
