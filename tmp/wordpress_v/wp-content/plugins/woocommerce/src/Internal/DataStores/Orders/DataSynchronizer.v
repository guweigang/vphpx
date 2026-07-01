import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option() string {
	return 'woocommerce_custom_orders_table_data_sync_enabled'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type() string {
	return 'shop_order_placehold'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key() string {
	return '_deleted_from'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_posts_meta_value() string {
	return 'posts_table'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_orders_meta_value() string {
	return 'orders_table'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created() string {
	return 'woocommerce_custom_orders_table_created'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_sync_batch_size() i64 {
	return 250
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_orders_table() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_posts_table() i64 {
	return 1
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_different_update_date() i64 {
	return 2
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_orders_table() i64 {
	return 3
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_posts_table() i64 {
	return 4
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option() string {
	return 'woocommerce_custom_orders_table_background_sync_mode'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_interval_option() string {
	return 'woocommerce_custom_orders_table_background_sync_interval'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval() string {
	return 'interval'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_continuous() string {
	return 'continuous'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_off() string {
	return 'off'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook() string {
	return 'woocommerce_custom_orders_table_background_sync'
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer {
	rt.PhpObjectBase
pub mut:
		data_store rt.PhpVal = rt.new_null()
		database_util rt.PhpVal = rt.new_null()
		posts_to_cot_migrator rt.PhpVal = rt.new_null()
		error_logger rt.PhpVal = rt.new_null()
		legacy_proxy rt.PhpVal = rt.new_null()
		order_cache_controller rt.PhpVal = rt.new_null()
		batch_processing_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) construct()  {
	rt.call_function('add_filter', [rt.new_string('pre_delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_prevent_deletion_of_post' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('deleted_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_deleted_post' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_updated_order' }]), rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('woocommerce_refund_created'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_updated_order' }]), rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_order'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_updated_order' }]), rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_order_refund'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_updated_order' }]), rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('wp_scheduled_auto_draft_delete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'delete_auto_draft_orders' }]), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('wp_scheduled_delete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'delete_trashed_orders' }]), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('updated_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'process_updated_option' }]), rt.new_int(999), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('added_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'process_added_option' }]), rt.new_int(999), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('deleted_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'process_deleted_option' }]), rt.new_int(999)])
	rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_interval_background_sync' }])])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_continuous(), this.get_background_sync_mode())) {
		rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer', ['BatchProcessorInterface'], &this) }, rt.ArrayItem{ key: none, val: 'handle_continuous_background_sync' }])])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WC_PLUGIN_BASENAME')])) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	this.unschedule_background_sync()
	return rt.new_null()
	}
		rt.call_function('add_action', ['deactivate_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str(), rt.new_closure(closure_1_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) init(mut var_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore, mut var_database_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil, mut var_posts_to_cot_migrator Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_order_cache_controller Class_Automattic_WooCommerce_Caches_OrderCacheController, mut var_batch_processing_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_BatchProcessingController)  {
	mut var_data_store_mutated := var_data_store
	this.data_store = var_data_store_mutated.dup()
	this.database_util = var_database_util.dup()
	this.posts_to_cot_migrator = var_posts_to_cot_migrator.dup()
	this.legacy_proxy = var_legacy_proxy.dup()
	this.error_logger = var_legacy_proxy.call_function(rt.new_string('wc_get_logger'))
	this.order_cache_controller = var_order_cache_controller.dup()
	this.batch_processing_controller = var_batch_processing_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) check_orders_table_exists() bool {
	mut var_missing_tables := rt.call_method(this.database_util, 'get_missing_tables', [rt.call_method(this.data_store, 'get_database_schema', []rt.PhpVal{})])
	if var_missing_tables.dup().array_count() == 0 {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created(), rt.new_string('yes')])
		return true
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created(), rt.new_string('no')])
		return false
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_table_exists() bool {
	mut var_table_exists := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created()])
	mut switch_val_1 := var_table_exists
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('no'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('yes'))) {
		return (rt.identical(rt.new_string('yes'), var_table_exists)).to_bool()
	} else {
		return this.check_orders_table_exists()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) create_database_tables() rt.PhpVal {
	rt.call_method(this.database_util, 'dbdelta', [rt.call_method(this.data_store, 'get_database_schema', []rt.PhpVal{})])
	mut var_success := rt.new_bool(this.check_orders_table_exists())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		mut var_missing_tables := rt.call_method(this.database_util, 'get_missing_tables', [rt.call_method(this.data_store, 'get_database_schema', []rt.PhpVal{})])
		var_missing_tables = rt.call_function('implode', [rt.new_string(', '), var_missing_tables.dup()])
		rt.call_method(this.error_logger, 'error', [rt.new_string("HPOS tables are missing in the database and couldn't be created. The missing tables are: ${var_missing_tables.to_string()}")])
	}
	return var_success.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_database_tables()  {
	mut var_table_names := rt.call_method(this.data_store, 'get_all_table_names', []rt.PhpVal{})
	{
		mut iter_1 := var_table_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_table_name := item_1.val
			rt.call_method(this.database_util, 'drop_database_table', [var_table_name.dup()])
		}
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.data_store }, rt.ArrayItem{ key: none, val: 'clear_all_cached_data' }])])) {
		rt.call_method(this.data_store, 'clear_all_cached_data', []rt.PhpVal{})
	}
	rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) data_sync_is_enabled() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option()]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_background_sync_mode() string {
	mut var_default := if this.data_sync_is_enabled() { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval() } else { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_off() }
	return (rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option(), var_default.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) background_sync_is_enabled() bool {
	mut var_enabled_modes := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_continuous() }])
	mut var_mode := rt.new_string(this.get_background_sync_mode())
	return (rt.call_function('in_array', [var_mode.dup(), var_enabled_modes.dup(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_updated_option(var_option_key rt.PhpVal, var_old_value rt.PhpVal, var_new_value rt.PhpVal)  {
	mut var_sync_option_keys := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option() }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_option_key.dup(), var_sync_option_keys.dup(), rt.new_bool(true)]))))) || rt.is_true(rt.identical(var_new_value, var_old_value)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option(), var_option_key)) {
		mut var_mode := var_new_value
	} else {
		var_mode = rt.new_string(this.get_background_sync_mode())
	}
	mut switch_val_2 := var_mode
	if rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval())) {
		this.schedule_background_sync()
	} else {
		this.unschedule_background_sync()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option(), var_option_key)) {
		if !(this.check_orders_table_exists()) {
			this.create_database_tables()
		}
		if this.data_sync_is_enabled() {
			rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup.class()]), 'toggle_flag', [rt.new_bool(false)])
			rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
		} else {
			rt.call_method(this.batch_processing_controller, 'remove_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_added_option(var_option_key rt.PhpVal, var_value rt.PhpVal)  {
	this.process_updated_option(var_option_key.dup(), rt.new_bool(false), var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_deleted_option(var_option_key rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	this.unschedule_background_sync()
	rt.call_method(this.batch_processing_controller, 'remove_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_background_sync_interval() i64 {
	mut var_interval := rt.call_function('filter_var', [rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_interval_option(), rt.get_constant('HOUR_IN_SECONDS')]), rt.get_constant('FILTER_VALIDATE_INT'), rt.create_array([rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'default', val: rt.get_constant('HOUR_IN_SECONDS') }]) }])])
	return (var_interval).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_ignored_order_props() rt.PhpVal {
	mut var_ignored_props := rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_sync_ignored_order_props'), rt.new_array()])
	var_ignored_props = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('array_filter', [var_ignored_props.dup(), rt.new_string('is_string')])])])
	return rt.call_function('array_merge', [var_ignored_props.dup(), rt.create_array([rt.ArrayItem{ key: none, val: '_paid_date' }, rt.ArrayItem{ key: none, val: '_completed_date' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name() }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) schedule_background_sync()  {
	mut var_interval := rt.new_int(this.get_background_sync_interval())
	rt.call_function('as_schedule_recurring_action', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_interval), var_interval.dup(), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook(), rt.new_array(), rt.new_string(''), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) unschedule_background_sync()  {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'cancel_all', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_interval_background_sync()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.unschedule_background_sync()
		return rt.new_null()
	}
	mut var_pending_count := rt.new_int(this.get_total_pending_count())
	if rt.is_true(rt.greater(var_pending_count, rt.new_int(0))) {
		rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_continuous_background_sync()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(this.batch_processing_controller, 'remove_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
		return rt.new_null()
	}
	rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_sync_status() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('9.0.0'), rt.new_string('get_current_orders_pending_sync_count()')])
	return rt.create_array([rt.ArrayItem{ key: 'initial_pending_count', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'current_pending_count', val: this.get_total_pending_count() }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_orders_pending_sync_count_cached() i64 {
	return this.get_current_orders_pending_sync_count(true)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_orders_pending_sync_count(use_cache bool) i64 {
	if var_use_cache {
		mut var_pending_count := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_hpos_pending_sync_count'), rt.new_string('counts')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return (// unsupported expression: Expr_Cast_Int).to_i64()
		}
	}
	var_pending_count = rt.new_int(this.query_orders_pending_sync_count(false))
	rt.call_function('wp_cache_set', [rt.new_string('woocommerce_hpos_pending_sync_count'), var_pending_count.dup(), rt.new_string('counts')])
	return (var_pending_count).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) has_orders_pending_sync(use_cache bool) rt.PhpVal {
	if var_use_cache {
		mut var_has_pending_sync := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_hpos_has_orders_pending_sync'), rt.new_string('counts')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return // unsupported expression: Expr_Cast_Bool
		}
		mut var_pending_count := 
		if rt.is_true() {
		}
	}
	var_has_pending_sync = rt.new_bool()
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) query_orders_pending_sync_count(full_count bool) i64 {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_deletion_record_meta_value() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) custom_orders_table_is_authoritative() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_ids_of_orders_pending_sync(type i64, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_deleted_order_ids(deleted_from_orders_table bool, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) cleanup_synchronization_state()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_batch(mut var_batch Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_batch_mutated := var_batch
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_deleted_orders(mut var_batch Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, custom_orders_table_is_authoritative bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_batch_mutated := var_batch
	mut custom_orders_table_is_authoritative_mutated := custom_orders_table_is_authoritative
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_total_pending_count() i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_next_batch_to_process(size i64) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_default_batch_size() i64 {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_name() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_description() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) maybe_prevent_deletion_of_post(var_delete rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_delete_mutated := var_delete
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_deleted_post(var_postid rt.PhpVal, var_post rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_updated_order(var_order_id rt.PhpVal)  {
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_auto_draft_orders()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_trashed_orders()  {
}

fn create_automattic_woocommerce_internal_datastores_orders_datasynchronizer() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer{
		PhpObjectBase: rt.PhpObjectBase{}
		data_store: rt.new_null()
		database_util: rt.new_null()
		posts_to_cot_migrator: rt.new_null()
		error_logger: rt.new_null()
		legacy_proxy: rt.new_null()
		order_cache_controller: rt.new_null()
		batch_processing_controller: rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_OrderCacheController](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_BatchProcessingController](if args.len > 5 { args[5] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'check_orders_table_exists' {
			return rt.new_bool(this.check_orders_table_exists())
		}
		'get_table_exists' {
			return rt.new_bool(this.get_table_exists())
		}
		'create_database_tables' {
			return this.create_database_tables()
		}
		'delete_database_tables' {
			this.delete_database_tables()
			return rt.new_null()
		}
		'data_sync_is_enabled' {
			return rt.new_bool(this.data_sync_is_enabled())
		}
		'get_background_sync_mode' {
			return rt.new_string(this.get_background_sync_mode())
		}
		'background_sync_is_enabled' {
			return rt.new_bool(this.background_sync_is_enabled())
		}
		'process_updated_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.process_updated_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'process_added_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.process_added_option(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_deleted_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.process_deleted_option(dispatch_arg_0)
			return rt.new_null()
		}
		'get_background_sync_interval' {
			return rt.new_int(this.get_background_sync_interval())
		}
		'get_ignored_order_props' {
			return this.get_ignored_order_props()
		}
		'schedule_background_sync' {
			this.schedule_background_sync()
			return rt.new_null()
		}
		'unschedule_background_sync' {
			this.unschedule_background_sync()
			return rt.new_null()
		}
		'handle_interval_background_sync' {
			this.handle_interval_background_sync()
			return rt.new_null()
		}
		'handle_continuous_background_sync' {
			this.handle_continuous_background_sync()
			return rt.new_null()
		}
		'get_sync_status' {
			return this.get_sync_status()
		}
		'get_current_orders_pending_sync_count_cached' {
			return rt.new_int(this.get_current_orders_pending_sync_count_cached())
		}
		'get_current_orders_pending_sync_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.get_current_orders_pending_sync_count(dispatch_arg_0))
		}
		'has_orders_pending_sync' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.has_orders_pending_sync(dispatch_arg_0)
		}
		'query_orders_pending_sync_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.query_orders_pending_sync_count(dispatch_arg_0))
		}
		'get_current_deletion_record_meta_value' {
			return this.get_current_deletion_record_meta_value()
		}
		'custom_orders_table_is_authoritative' {
			return rt.new_bool(this.custom_orders_table_is_authoritative())
		}
		'get_ids_of_orders_pending_sync' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_ids_of_orders_pending_sync(dispatch_arg_0, dispatch_arg_1)
		}
		'get_deleted_order_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_deleted_order_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'cleanup_synchronization_state' {
			this.cleanup_synchronization_state()
			return rt.new_null()
		}
		'process_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_deleted_orders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.process_deleted_orders(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_total_pending_count' {
			return rt.new_int(this.get_total_pending_count())
		}
		'get_next_batch_to_process' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_next_batch_to_process(dispatch_arg_0)
		}
		'get_default_batch_size' {
			return rt.new_int(this.get_default_batch_size())
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'maybe_prevent_deletion_of_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.maybe_prevent_deletion_of_post(dispatch_arg_0, dispatch_arg_1)
		}
		'handle_deleted_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.handle_deleted_post(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_updated_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_updated_order(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_auto_draft_orders' {
			this.delete_auto_draft_orders()
			return rt.new_null()
		}
		'delete_trashed_orders' {
			this.delete_trashed_orders()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store' { return this.data_store }
		'database_util' { return this.database_util }
		'posts_to_cot_migrator' { return this.posts_to_cot_migrator }
		'error_logger' { return this.error_logger }
		'legacy_proxy' { return this.legacy_proxy }
		'order_cache_controller' { return this.order_cache_controller }
		'batch_processing_controller' { return this.batch_processing_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store' { this.data_store = val; return true }
		'database_util' { this.database_util = val; return true }
		'posts_to_cot_migrator' { this.posts_to_cot_migrator = val; return true }
		'error_logger' { this.error_logger = val; return true }
		'legacy_proxy' { this.legacy_proxy = val; return true }
		'order_cache_controller' { this.order_cache_controller = val; return true }
		'batch_processing_controller' { this.batch_processing_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_datasynchronizer_php() {
	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
