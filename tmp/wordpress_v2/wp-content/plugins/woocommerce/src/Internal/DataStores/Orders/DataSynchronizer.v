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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) construct() {
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
		rt.call_function('add_action', [rt.new_string('deactivate_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str()), rt.new_closure(closure_1_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) init(mut var_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore, mut var_database_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil, mut var_posts_to_cot_migrator Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostsToOrdersMigrationController, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_order_cache_controller Class_Automattic_WooCommerce_Caches_OrderCacheController, mut var_batch_processing_controller Class_Automattic_WooCommerce_Internal_DataStores_Orders_BatchProcessingController) {
	mut var_data_store_mutated := var_data_store
	this.data_store = var_data_store_mutated
	this.database_util = var_database_util
	this.posts_to_cot_migrator = var_posts_to_cot_migrator
	this.legacy_proxy = var_legacy_proxy
	this.error_logger = var_legacy_proxy.call_function(rt.new_string('wc_get_logger'))
	this.order_cache_controller = var_order_cache_controller
	this.batch_processing_controller = var_batch_processing_controller
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) check_orders_table_exists() bool {
	mut var_missing_tables := rt.call_method(this.database_util, 'get_missing_tables', [rt.call_method(this.data_store, 'get_database_schema', []rt.PhpVal{})])
	if var_missing_tables.clone().array_count() == 0 {
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
		var_missing_tables = rt.call_function('implode', [rt.new_string(', '), var_missing_tables.clone()])
		rt.call_method(this.error_logger, 'error', [rt.new_string("HPOS tables are missing in the database and couldn't be created. The missing tables are: ${var_missing_tables.to_string()}")])
	}
	return var_success.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_database_tables() {
	mut var_table_names := rt.call_method(this.data_store, 'get_all_table_names', []rt.PhpVal{})
	mut iter_1 := var_table_names.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_table_name := item_1.val
		rt.call_method(this.database_util, 'drop_database_table', [var_table_name.clone()])
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
	return (rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option(), var_default.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) background_sync_is_enabled() bool {
	mut var_enabled_modes := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_continuous() }])
	mut var_mode := rt.new_string(this.get_background_sync_mode())
	return (rt.call_function('in_array', [var_mode.clone(), var_enabled_modes.clone(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_updated_option(var_option_key rt.PhpVal, var_old_value rt.PhpVal, var_new_value rt.PhpVal) {
	mut var_sync_option_keys := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option() }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_option_key.clone(), var_sync_option_keys.clone(), rt.new_bool(true)]))))) || rt.is_true(rt.identical(var_new_value, var_old_value)) {
		return
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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_added_option(var_option_key rt.PhpVal, var_value rt.PhpVal) {
	this.process_updated_option(var_option_key.clone(), rt.new_bool(false), var_value.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_deleted_option(var_option_key rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_option(), var_option_key)))) {
		return
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
	var_ignored_props = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('array_filter', [var_ignored_props.clone(), rt.new_string('is_string')])])])
	return rt.call_function('array_merge', [var_ignored_props.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '_paid_date' }, rt.ArrayItem{ key: none, val: '_completed_date' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_Orders_EditLock.meta_key_name() }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) schedule_background_sync() {
	mut var_interval := rt.new_int(this.get_background_sync_interval())
	rt.call_function('as_schedule_recurring_action', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_interval), var_interval.clone(), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook(), rt.new_array(), rt.new_string(''), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) unschedule_background_sync() {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'cancel_all', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_event_hook()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_interval_background_sync() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_interval(), this.get_background_sync_mode())))) {
		this.unschedule_background_sync()
		return
	}
	mut var_pending_count := rt.new_int(this.get_total_pending_count())
	if rt.is_true(rt.greater(var_pending_count, rt.new_int(0))) {
		rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_continuous_background_sync() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.background_sync_mode_continuous(), this.get_background_sync_mode())))) {
		rt.call_method(this.batch_processing_controller, 'remove_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
		return
	}
	rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_sync_status() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('9.0.0'), rt.new_string('get_current_orders_pending_sync_count()')])
	return rt.create_array([rt.ArrayItem{ key: 'initial_pending_count', val: 0 }, rt.ArrayItem{ key: 'current_pending_count', val: this.get_total_pending_count() }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_orders_pending_sync_count_cached() i64 {
	return this.get_current_orders_pending_sync_count(true)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_orders_pending_sync_count(use_cache bool) i64 {
	if var_use_cache {
		mut var_pending_count := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_hpos_pending_sync_count'), rt.new_string('counts')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pending_count)))) {
			return rt.new_int((var_pending_count).to_i64())
		}
	}
	var_pending_count = rt.new_int(this.query_orders_pending_sync_count(false))
	rt.call_function('wp_cache_set', [rt.new_string('woocommerce_hpos_pending_sync_count'), var_pending_count.clone(), rt.new_string('counts')])
	return (var_pending_count).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) has_orders_pending_sync(use_cache bool) bool {
	if var_use_cache {
		mut var_has_pending_sync := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_hpos_has_orders_pending_sync'), rt.new_string('counts')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_has_pending_sync)))) {
			return (var_has_pending_sync).to_bool()
		}
		mut var_pending_count := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_hpos_pending_sync_count'), rt.new_string('counts')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pending_count)))) {
			return rt.new_bool(rt.new_int((var_pending_count).to_i64()) > 0)
		}
	}
	var_has_pending_sync = rt.new_bool(this.query_orders_pending_sync_count(false) > 0)
	rt.call_function('wp_cache_set', [rt.new_string('woocommerce_hpos_has_orders_pending_sync'), var_has_pending_sync.clone(), rt.new_string('counts')])
	return (var_has_pending_sync).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) query_orders_pending_sync_count(full_count bool) i64 {
	mut var_wpdb := rt.new_null()
	mut var_order_post_types := rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])
	mut var_order_post_type_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_post_types.clone().array_count()), rt.new_string('%s')])])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"}{}
	mut iife_result_1 := iife_temp_1.get_orders_table_name()
	mut var_orders_table := iife_result_1
	mut var_count_clause := rt.new_string((if var_full_count { 'COUNT(1)' } else { '1' }).str())
	mut var_limit_clause := rt.new_string((if var_full_count { '' } else { 'LIMIT 1' }).str())
	if !rt.is_true(var_order_post_types) {
		rt.call_method(this.error_logger, 'debug', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s was called but no order types were registered: it may have been called too early.'), rt.new_string('woocommerce')]), rt.new_string(@METHOD)])])
		return 0
	}
	if !(this.get_table_exists()) {
		mut var_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_count_clause), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' where post_type in ( ')), var_order_post_type_placeholder), rt.new_string(' )')), var_order_post_types.clone()])])
		return (var_count).to_i64()
	}
	if this.custom_orders_table_is_authoritative() {
	mut var_missing_orders_count_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT '), var_count_clause), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\nRIGHT JOIN ')), var_orders_table), rt.new_string(' orders ON posts.ID=orders.id\nWHERE (posts.post_type IS NULL OR posts.post_type = \'')) + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type()).str() + "')\n AND orders.status NOT IN ( 'auto-draft' )\n AND orders.type IN (${var_order_post_type_placeholder.to_string()})\n${var_limit_clause.to_string()}").str()), var_order_post_types.clone()])
	mut var_operator := rt.new_string('>')
	} else {
	var_missing_orders_count_sql = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT '), var_count_clause), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\nLEFT JOIN ')), var_orders_table), rt.new_string(' orders ON posts.ID=orders.id\nWHERE\n  posts.post_type in (')), var_order_post_type_placeholder), rt.new_string(')\n  AND posts.post_status != \'auto-draft\'\n  AND orders.id IS NULL\n')), var_limit_clause), var_order_post_types.clone()])
	var_operator = rt.new_string('<')
	}
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT(\n\t('), var_missing_orders_count_sql), rt.new_string(')\n\t+\n\t(SELECT COUNT(1) FROM (\n\t\tSELECT orders.id FROM ')), var_orders_table), rt.new_string(' orders\n\t\tJOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts on posts.ID = orders.id\n\t\tWHERE\n\t\t  posts.post_type IN (')), var_order_post_type_placeholder), rt.new_string(')\n\t\t  AND orders.date_updated_gmt ')), var_operator), rt.new_string(' posts.post_modified_gmt\n\t) x)\n) count')), var_order_post_types.clone()])
	mut var_pending_count := rt.new_int((rt.call_method(var_wpdb, 'get_var', [var_sql.clone()])).to_i64())
	mut var_deleted_from_table := this.get_current_deletion_record_meta_value()
	mut var_deleted_count := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_count_clause), rt.new_string(' FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta WHERE meta_key=%s AND meta_value=%s')), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key() }, rt.ArrayItem{ key: none, val: var_deleted_from_table }])])])
	var_pending_count = rt.add(var_pending_count, var_deleted_count)
	return (var_pending_count).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_current_deletion_record_meta_value() rt.PhpVal {
	return if this.custom_orders_table_is_authoritative() { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_orders_meta_value() } else { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_posts_meta_value() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) custom_orders_table_is_authoritative() bool {
	return (rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option()])])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_ids_of_orders_pending_sync(type i64, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if limit < 1 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('$limit must be at least 1'))))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"}{}
	mut iife_result_2 := iife_temp_2.get_orders_table_name()
	mut var_orders_table := iife_result_2
	mut var_order_post_types := rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])
	mut var_order_post_type_placeholders := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_post_types.clone().array_count()), rt.new_string('%s')])])
	mut switch_val_3 := rt.new_int(type)
	if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_orders_table())) {
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT posts.ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\nLEFT JOIN ')), var_orders_table), rt.new_string(' orders ON posts.ID = orders.id\nWHERE\n  posts.post_type IN (')), var_order_post_type_placeholders), rt.new_string(')\n  AND posts.post_status != \'auto-draft\'\n  AND orders.id IS NULL\nORDER BY posts.ID ASC')), var_order_post_types.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_posts_table())) {
	var_sql = rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT orders.id FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\nRIGHT JOIN ')), var_orders_table), rt.new_string(' orders ON posts.ID=orders.id\nWHERE (posts.post_type IS NULL OR posts.post_type = \'')) + (Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type()).str() + "')\nAND orders.status NOT IN ( 'auto-draft' )\nAND orders.type IN (${var_order_post_type_placeholders.to_string()})\nORDER BY posts.ID ASC").str()), var_order_post_types.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_different_update_date())) {
	mut var_operator := rt.new_string((if this.custom_orders_table_is_authoritative() { '>' } else { '<' }).str())
	var_sql = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT orders.id FROM '), var_orders_table), rt.new_string(' orders\nJOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts on posts.ID = orders.id\nWHERE\n  posts.post_type IN (')), var_order_post_type_placeholders), rt.new_string(')\n  AND orders.date_updated_gmt ')), var_operator), rt.new_string(' posts.post_modified_gmt\nORDER BY orders.id ASC\n')), var_order_post_types.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_orders_table())) {
		return this.get_deleted_order_ids(true, limit)
	} else if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_posts_table())) {
		return this.get_deleted_order_ids(false, limit)
	} else {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Invalid $type, must be one of the ID_TYPE_... constants.'))))
	}
	return rt.call_function('array_map', [rt.new_string('intval'), rt.call_method(var_wpdb, 'get_col', [rt.new_string((var_sql).str() + " LIMIT ${var_limit.str()}")])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_deleted_order_ids(deleted_from_orders_table bool, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_deleted_from_table := this.get_current_deletion_record_meta_value()
	mut var_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT(order_id) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta WHERE meta_key=%s AND meta_value=%s LIMIT ')), rt.new_int(limit)), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key(), var_deleted_from_table.clone()])])
	return rt.call_function('array_map', [rt.new_string('absint'), var_order_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) cleanup_synchronization_state() {
	rt.call_function('delete_option', [rt.new_string('woocommerce_initial_orders_pending_sync_count')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_batch(mut var_batch Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_batch_mutated := var_batch
	if !rt.is_true(var_batch_mutated) {
		return
	}
	var_batch_mutated = rt.call_function('array_map', [rt.new_string('absint'), var_batch_mutated])
	rt.call_method(this.order_cache_controller, 'temporarily_disable_orders_cache_usage', []rt.PhpVal{})
	mut var_custom_orders_table_is_authoritative := rt.new_bool(this.custom_orders_table_is_authoritative())
	mut var_deleted_order_ids := this.process_deleted_orders(mut var_batch_mutated, (var_custom_orders_table_is_authoritative).to_bool())
	var_batch_mutated = rt.call_function('array_diff', [var_batch_mutated, var_deleted_order_ids.clone()])
	if !(!rt.is_true(var_batch_mutated)) {
		if rt.is_true(var_custom_orders_table_is_authoritative) {
			mut iter_2 := var_batch_mutated.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_id := item_2.val
				mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
					rt.call_method(this.error_logger, 'error', [rt.new_string("Order ${var_id.to_string()} not found during batch process, skipping.")])
					continue
				}
				mut var_data_store := rt.call_method(var_order, 'get_data_store', []rt.PhpVal{})
				rt.call_method(var_data_store, 'backfill_post_record', [var_order.clone()])
			}
		} else {
			rt.call_method(this.posts_to_cot_migrator, 'migrate_orders', [var_batch_mutated])
		}
	}
	if 0 == this.get_total_pending_count() {
		this.cleanup_synchronization_state()
		rt.call_method(this.order_cache_controller, 'maybe_restore_orders_cache_usage', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) process_deleted_orders(mut var_batch Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, custom_orders_table_is_authoritative bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_batch_mutated := var_batch
	mut custom_orders_table_is_authoritative_mutated := custom_orders_table_is_authoritative
	mut var_deleted_from_table_name := this.get_current_deletion_record_meta_value()
	mut var_data_store_for_deletion := if rt.is_true(rt.new_bool(custom_orders_table_is_authoritative_mutated)) { create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt() } else { rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class()]) }
	mut var_order_ids_as_sql_list := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_batch_mutated])).str() + ')')
	mut var_deleted_order_ids := rt.new_array()
	mut var_meta_ids_to_delete := rt.new_array()
	mut var_deletion_data := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT id, order_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta WHERE meta_key=%s AND meta_value=%s AND order_id IN ')), var_order_ids_as_sql_list), rt.new_string(' ORDER BY order_id DESC')), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key(), var_deleted_from_table_name.clone()]), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_deletion_data) {
		return rt.new_array()
	}
	mut iter_3 := var_deletion_data.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item := item_3.val
		mut var_meta_id := var_item.array_get(rt.new_string('id'))
		mut var_order_id := var_item.array_get(rt.new_string('order_id'))
		if var_deleted_order_ids.array_isset(var_order_id) {
			var_meta_ids_to_delete.array_push(var_meta_id.clone())
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_store_for_deletion, 'order_exists', [var_order_id.clone()]))))) {
			rt.call_method(this.error_logger, 'warning', [rt.new_string("Order ${var_order_id.to_string()} doesn't exist in the backup table, thus it can't be deleted")])
			var_deleted_order_ids.array_push(var_order_id.clone())
			var_meta_ids_to_delete.array_push(var_meta_id.clone())
			continue
		}
		mut var_order := create_automattic_woocommerce_internal_datastores_orders_wc_order()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_order, 'set_id', [var_order_id.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_data_store_for_deletion, 'read', [var_order.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_data_store_for_deletion, 'delete', [var_order.clone(), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: true }, rt.ArrayItem{ key: 'suppress_filters', val: true }])])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_DataStores_Orders_Exception') {
			mut var_ex := var_e_1.clone()
			rt.call_method(this.error_logger, 'error', [rt.concat(rt.concat(rt.concat(rt.new_string('Couldn\'t delete order '), var_order_id), rt.new_string(' from the backup table: ')), rt.call_method(var_ex, 'getMessage', []rt.PhpVal{}))])
			continue
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		var_deleted_order_ids.array_push(var_order_id.clone())
		var_meta_ids_to_delete.array_push(var_meta_id.clone())
	}
	if !(!rt.is_true(var_meta_ids_to_delete)) {
		mut var_order_id_rows_as_sql_list := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_meta_ids_to_delete.clone()])).str() + ')')
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta WHERE id IN ')), var_order_id_rows_as_sql_list)])
	}
	return var_deleted_order_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_total_pending_count() i64 {
	return this.get_current_orders_pending_sync_count(false)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_next_batch_to_process(size i64) rt.PhpVal {
	mut var_orders_table_is_authoritative := rt.new_bool(this.custom_orders_table_is_authoritative())
	mut var_order_ids := this.get_ids_of_orders_pending_sync((if rt.is_true(var_orders_table_is_authoritative) { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_posts_table() } else { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_missing_in_orders_table() }).to_i64(), size)
	if var_order_ids.clone().array_count() >= size {
		return var_order_ids.clone()
	}
	mut var_updated_order_ids := this.get_ids_of_orders_pending_sync((Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_different_update_date()).to_i64(), size - var_order_ids.clone().array_count())
	var_order_ids = rt.call_function('array_merge', [var_order_ids.clone(), var_updated_order_ids.clone()])
	if var_order_ids.clone().array_count() >= size {
		return var_order_ids.clone()
	}
	mut var_deleted_order_ids := this.get_ids_of_orders_pending_sync((if rt.is_true(var_orders_table_is_authoritative) { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_orders_table() } else { Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.id_type_deleted_from_posts_table() }).to_i64(), size - var_order_ids.clone().array_count())
	var_order_ids = rt.call_function('array_merge', [var_order_ids.clone(), var_deleted_order_ids.clone()])
	return rt.call_function('array_map', [rt.new_string('absint'), var_order_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_default_batch_size() i64 {
	mut var_batch_size := Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_sync_batch_size()
	if this.custom_orders_table_is_authoritative() {
	var_batch_size = rt.add(rt.call_function('absint', [rt.div(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_sync_batch_size(), rt.new_int(10))]), rt.new_int(1))
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_orders_cot_and_posts_sync_step_size'), var_batch_size.clone()])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_name() string {
	return 'Order synchronizer'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) get_description() string {
	return 'Synchronizes orders between posts and custom order tables.'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) maybe_prevent_deletion_of_post(var_delete rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_delete_mutated := var_delete
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), rt.get_property(var_post, 'post_type'))))) && this.custom_orders_table_is_authoritative() && rt.is_true(rt.call_method(this.data_store, 'order_exists', [rt.get_property(var_post, 'ID')])) {
	var_delete_mutated = rt.new_bool(false)
	}
	return var_delete_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_deleted_post(var_postid rt.PhpVal, var_post rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_post_types := rt.call_function('wc_get_order_types', [rt.new_string('cot-migration')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), var_order_post_types.clone(), rt.new_bool(true)]))))) {
		return
	}
	if !(this.get_table_exists()) {
		return
	}
	if this.data_sync_is_enabled() {
		rt.call_method(this.data_store, 'delete_order_data_from_custom_order_tables', [var_postid.clone()])
	} else if this.custom_orders_table_is_authoritative() {
		return
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"}{}
	mut iife_result_3 := iife_temp_3.get_orders_table_name()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"}{}
	mut iife_result_4 := iife_temp_4.get_meta_table_name()
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT EXISTS (SELECT id FROM '), iife_result_3), rt.new_string(' WHERE ID=%d)\n\t\t\t\t\t\tAND NOT EXISTS (SELECT order_id FROM ')), iife_result_4), rt.new_string(' WHERE order_id=%d AND meta_key=%s AND meta_value=%s)')), var_postid.clone(), var_postid.clone(), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key(), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_posts_meta_value()])])) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"}{}
		mut iife_result_5 := iife_temp_5.get_meta_table_name()
		rt.call_method(var_wpdb, 'insert', [iife_result_5, rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_postid }, rt.ArrayItem{ key: 'meta_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key() }, rt.ArrayItem{ key: 'meta_value', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_posts_meta_value() }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) handle_updated_order(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	if !(this.custom_orders_table_is_authoritative()) && this.data_sync_is_enabled() {
		rt.call_method(this.posts_to_cot_migrator, 'migrate_orders', [rt.create_array([rt.ArrayItem{ key: none, val: var_order_id_mutated }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_auto_draft_orders() {
	if !(this.custom_orders_table_is_authoritative()) {
		return
	}
	mut var_to_delete := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'date_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'column', val: 'date_created' }, rt.ArrayItem{ key: 'before', val: '-1 week' }]) }]) }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'status', val: 'auto-draft' }])])
	mut iter_4 := var_to_delete.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_order := item_4.val
		rt.call_method(var_order, 'delete', [rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_scheduled_auto_draft_delete')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer) delete_trashed_orders() {
	if !(this.custom_orders_table_is_authoritative()) {
		return
	}
	mut var_delete_timestamp := rt.sub(rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('time')]), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.get_constant('EMPTY_TRASH_DAYS')))
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'status', val: 'trash' }, rt.ArrayItem{ key: 'limit', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_sync_batch_size() }, rt.ArrayItem{ key: 'date_modified', val: '<' + (var_delete_timestamp).str() }])
	mut var_orders := rt.call_function('wc_get_orders', [var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_orders)))) || !(var_orders.clone().is_array()) {
		return
	}
	mut iter_5 := var_orders.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_order := item_5.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_status', []rt.PhpVal{}), rt.new_string('trash'))))) {
			continue
		}
		if rt.is_true(rt.greater_equal(rt.call_method(rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{}), var_delete_timestamp)) {
			continue
		}
		rt.call_method(var_order, 'delete', [rt.new_bool(true)])
	}
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"} {
	rt.PhpObjectBase
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

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":534,"var":{"nodetype":"expr_variable","line":534,"name":"this"},"name":"data_store"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":668,"var":{"nodetype":"expr_variable","line":668,"name":"this"},"name":"data_store"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT{
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

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":1020,"var":{"nodetype":"expr_variable","line":1020,"name":"this"},"name":"data_store"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":1021,"var":{"nodetype":"expr_variable","line":1021,"name":"this"},"name":"data_store"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_propertyfetch","line":1030,"var":{"nodetype":"expr_variable","line":1030,"name":"this"},"name":"data_store"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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
			return rt.new_bool(this.has_orders_pending_sync(dispatch_arg_0))
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":534,"var":{"nodeType":"Expr_Variable","line":534,"name":"this"},"name":"data_store"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":668,"var":{"nodeType":"Expr_Variable","line":668,"name":"this"},"name":"data_store"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1020,"var":{"nodeType":"Expr_Variable","line":1020,"name":"this"},"name":"data_store"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1021,"var":{"nodeType":"Expr_Variable","line":1021,"name":"this"},"name":"data_store"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_PropertyFetch","line":1030,"var":{"nodeType":"Expr_Variable","line":1030,"name":"this"},"name":"data_store"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
