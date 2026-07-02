import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.sync_query_arg() string {
	return 'wc_hpos_sync_now'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.stop_sync_query_arg() string {
	return 'wc_hpos_stop_sync'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option() string {
	return 'woocommerce_custom_orders_table_enabled'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.use_db_transactions_option() string {
	return 'woocommerce_use_db_transactions_for_custom_orders_table_data_sync'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.db_transactions_isolation_level_option() string {
	return 'woocommerce_db_transactions_isolation_level_for_custom_orders_table_data_sync'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.default_db_transactions_isolation_level() string {
	return 'READ UNCOMMITTED'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option() string {
	return 'woocommerce_hpos_fts_index_enabled'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option() string {
	return 'woocommerce_hpos_address_fts_index_created'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_order_item_index_created_option() string {
	return 'woocommerce_hpos_order_item_fts_index_created'
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option() string {
	return 'woocommerce_hpos_datastore_caching_enabled'
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController {
	rt.PhpObjectBase
pub mut:
		data_store rt.PhpVal = rt.new_null()
		refund_data_store rt.PhpVal = rt.new_null()
		data_synchronizer rt.PhpVal = rt.new_null()
		data_cleanup rt.PhpVal = rt.new_null()
		batch_processing_controller rt.PhpVal = rt.new_null()
		features_controller rt.PhpVal = rt.new_null()
		order_cache rt.PhpVal = rt.new_null()
		order_cache_controller rt.PhpVal = rt.new_null()
		plugin_util rt.PhpVal = rt.new_null()
		db_util rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) construct() {
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) init_hooks() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_data_store'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_orders_data_store' }]), rt.new_int(999), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order-refund_data_store'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_refunds_data_store' }]), rt.new_int(999), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_hpos_tools' }]), rt.new_int(999)])
	rt.call_function('add_filter', [rt.new_string('updated_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_updated_option' }]), rt.new_int(999), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('updated_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_updated_option_fts_index' }]), rt.new_int(999), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('pre_update_option'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'process_pre_update_option' }]), rt.new_int(999), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_register_post_type'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_post_type_for_order_placeholders' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_sections_advanced'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sync_now' }])])
	rt.call_function('add_filter', [rt.new_string('removable_query_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_removable_query_arg' }])])
	rt.call_function('add_filter', [rt.new_string('get_edit_post_link'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_rewrite_order_edit_link' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('before_woocommerce_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_order_cache_group_as_non_persistent' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) init(mut var_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore, mut var_data_synchronizer Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer, mut var_data_cleanup Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup, mut var_refund_data_store Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore, mut var_batch_processing_controller Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController, mut var_features_controller Class_Automattic_WooCommerce_Internal_Features_FeaturesController, mut var_order_cache Class_Automattic_WooCommerce_Caches_OrderCache, mut var_order_cache_controller Class_Automattic_WooCommerce_Caches_OrderCacheController, mut var_plugin_util Class_Automattic_WooCommerce_Utilities_PluginUtil, mut var_db_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil) {
	this.data_store = var_data_store
	this.data_synchronizer = var_data_synchronizer
	this.data_cleanup = var_data_cleanup
	this.batch_processing_controller = var_batch_processing_controller
	this.refund_data_store = var_refund_data_store
	this.features_controller = var_features_controller
	this.order_cache = var_order_cache
	this.order_cache_controller = var_order_cache_controller
	this.plugin_util = var_plugin_util
	this.db_util = var_db_util
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) custom_orders_table_usage_is_enabled() bool {
	return (rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option()]), rt.new_string('yes'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) hpos_data_caching_is_enabled() bool {
	return rt.is_true(rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option()]), rt.new_string('yes'))) && this.custom_orders_table_usage_is_enabled()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) get_orders_data_store(var_default_data_store rt.PhpVal) rt.PhpVal {
	return this.get_data_store_instance(var_default_data_store.clone(), 'order')
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) get_refunds_data_store(var_default_data_store rt.PhpVal) rt.PhpVal {
	return this.get_data_store_instance(var_default_data_store.clone(), 'order_refund')
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) get_data_store_instance(var_default_data_store rt.PhpVal, type string) rt.PhpVal {
	if this.custom_orders_table_usage_is_enabled() {
		mut switch_val_1 := rt.new_string(type)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('order_refund'))) {
			return this.refund_data_store
		} else {
			return this.data_store
		}
	} else {
		return var_default_data_store.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) add_hpos_tools(mut var_tools_array Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_tools_array_mutated := var_tools_array
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_tools_array_mutated)
	}
	var_tools_array_mutated = rt.call_function('array_merge', [var_tools_array_mutated, rt.call_method(this.data_cleanup, 'get_tools_entries', []rt.PhpVal{})])
	if this.custom_orders_table_usage_is_enabled() || rt.is_true(rt.call_method(this.data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) || rt.is_true(rt.call_method(this.batch_processing_controller, 'is_enqueued', [rt.call_function('get_class', [this.data_synchronizer])])) {
	mut var_disabled := rt.new_bool(true)
	mut var_message := rt.call_function('__', [rt.new_string('This will delete the custom orders tables. The tables can be deleted only if the "High-Performance order storage" is not authoritative and sync is disabled (via Settings > Advanced > Features).'), rt.new_string('woocommerce')])
	} else {
	var_disabled = rt.new_bool(false)
	var_message = rt.call_function('__', [rt.new_string('This will delete the custom orders tables. To create them again enable the "High-Performance order storage" feature (via Settings > Advanced > Features).'), rt.new_string('woocommerce')])
	}
	closure_1_fn := fn [var_disabled] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(var_disabled) {
			return rt.new_null()
		}
		rt.call_method(this.features_controller, 'change_feature_enable', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option(), rt.new_bool(false)])
		this.delete_custom_orders_tables()
		return rt.call_function('__', [rt.new_string('Custom orders tables have been deleted.'), rt.new_string('woocommerce')])
		}
	var_tools_array_mutated.array_set('delete_custom_orders_table', rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Delete the custom orders tables'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), var_message.clone()]) }, rt.ArrayItem{ key: 'requires_refresh', val: true }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Delete'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'disabled', val: var_disabled }]))
	return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_tools_array_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) delete_custom_orders_tables() {
	if this.custom_orders_table_usage_is_enabled() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('Can\'t delete the custom orders tables: they are currently in use (via Settings > Advanced > Features).'))))
	}
	rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option()])
	rt.call_method(this.data_synchronizer, 'delete_database_tables', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) process_updated_option(var_option rt.PhpVal, var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option(), var_option)) && rt.is_true(rt.identical(rt.new_string('no'), var_value)) {
		rt.call_method(this.data_synchronizer, 'cleanup_synchronization_state', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option(), var_option)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_value, var_value)))) && rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
		rt.call_method(this.data_store, 'clear_all_cached_data', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) process_updated_option_fts_index(var_option rt.PhpVal, var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option(), var_option)))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), var_value)))) {
		return
	}
	if !(this.custom_orders_table_usage_is_enabled()) {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_index_option(), rt.new_string('no'), rt.new_bool(true)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings')])) {
		mut iife_temp_1 := Class_WC_Admin_Settings{}
		mut iife_result_1 := iife_temp_1.add_error(rt.call_function('__', [rt.new_string('Failed to create FTS index on orders table. This feature is only available when High-performance order storage is enabled.'), rt.new_string('woocommerce')]))
		}
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_address_table_exists', []rt.PhpVal{}))))) {
		rt.call_method(this.db_util, 'create_fts_index_order_address_table', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_address_table_exists', []rt.PhpVal{})) {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option(), rt.new_string('yes'), rt.new_bool(false)])
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option(), rt.new_string('no'), rt.new_bool(false)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings ')])) {
		mut iife_temp_2 := Class_WC_Admin_Settings{}
		mut iife_result_2 := iife_temp_2.add_error(rt.call_function('__', [rt.new_string('Failed to create FTS index on address table'), rt.new_string('woocommerce')]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_item_table_exists', []rt.PhpVal{}))))) {
		rt.call_method(this.db_util, 'create_fts_index_order_item_table', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_item_table_exists', []rt.PhpVal{})) {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_order_item_index_created_option(), rt.new_string('yes'), rt.new_bool(false)])
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_order_item_index_created_option(), rt.new_string('no'), rt.new_bool(false)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings ')])) {
		mut iife_temp_3 := Class_WC_Admin_Settings{}
		mut iife_result_3 := iife_temp_3.add_error(rt.call_function('__', [rt.new_string('Failed to create FTS index on order item table'), rt.new_string('woocommerce')]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) recreate_order_address_fts_index() rt.PhpVal {
	rt.call_method(this.db_util, 'drop_fts_index_order_address_table', []rt.PhpVal{})
	if rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_address_table_exists', []rt.PhpVal{})) {
		return rt.create_array([rt.ArrayItem{ key: 'status', val: false }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Failed to modify existing FTS index. Please go to WooCommerce > Status > Tools and run the "Re-create Order Address FTS index" tool.'), rt.new_string('woocommerce')]) }])
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option(), rt.new_string('no'), rt.new_bool(false)])
	}
	rt.call_method(this.db_util, 'create_fts_index_order_address_table', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.db_util, 'fts_index_on_order_address_table_exists', []rt.PhpVal{}))))) {
		return rt.create_array([rt.ArrayItem{ key: 'status', val: false }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Failed to create FTS index on order address table. Please go to WooCommerce > Status > Tools and run the "Re-create Order Address FTS index" tool.'), rt.new_string('woocommerce')]) }])
	} else {
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option(), rt.new_string('yes'), rt.new_bool(false)])
		return rt.create_array([rt.ArrayItem{ key: 'status', val: true }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('FTS index recreated.'), rt.new_string('woocommerce')]) }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) process_pre_update_option(var_value rt.PhpVal, var_option rt.PhpVal, var_old_value rt.PhpVal) string {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option(), var_option)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, var_old_value)))) {
		rt.call_method(this.order_cache, 'flush', []rt.PhpVal{})
		return (var_value).str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option(), var_option)))) {
		return (var_value).str()
	}
	if rt.is_true(rt.identical(var_old_value, var_value)) {
		return (var_value).str()
	}
	rt.call_method(this.order_cache, 'flush', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) {
		rt.call_method(this.data_synchronizer, 'create_database_tables', []rt.PhpVal{})
	}
	mut var_tables_created := rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_table_created()]), rt.new_string('yes'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tables_created)))) {
		return 'no'
	}
	if !(this.changing_data_source_with_sync_pending_is_allowed()) && rt.is_true(rt.call_method(this.data_synchronizer, 'has_orders_pending_sync', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Exception', []string{}, create_automattic_woocommerce_internal_datastores_orders_exception(rt.new_string('The authoritative table for orders storage can\'t be changed while there are orders out of sync'))))
	}
	return (var_value).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) sync_now() {
	mut var_section := rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), rt.new_string('section')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('features'), var_section)))) {
		return
	}
	if rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.sync_query_arg(), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])) {
	mut var_action := rt.new_string('sync-now')
	} else if rt.is_true(rt.call_function('filter_input', [rt.get_constant('INPUT_GET'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.stop_sync_query_arg(), rt.get_constant('FILTER_VALIDATE_BOOLEAN')])) {
	var_action = rt.new_string('stop-sync')
	} else {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')) } else { rt.new_string('') }])]), rt.new_string("hpos-${var_action.to_string()}")]))))) {
		mut iife_temp_4 := Class_WC_Admin_Settings{}
		mut iife_result_4 := iife_temp_4.add_error(if rt.is_true(rt.identical(rt.new_string('sync-now'), var_action)) { rt.call_function('esc_html__', [rt.new_string('Unable to start synchronization. The link you followed may have expired.'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_html__', [rt.new_string('Unable to stop synchronization. The link you followed may have expired.'), rt.new_string('woocommerce')]) })
		return
	}
	rt.call_method(this.data_cleanup, 'toggle_flag', [rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_string('sync-now'), var_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'check_orders_table_exists', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'create_database_tables', []rt.PhpVal{}))))) {
			mut iife_temp_5 := Class_WC_Admin_Settings{}
			mut iife_result_5 := iife_temp_5.add_error(rt.call_function('__', [rt.new_string('Unable to create HPOS tables for synchronization.'), rt.new_string('woocommerce')]))
			return
		}
		rt.call_method(this.batch_processing_controller, 'enqueue_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	} else {
		rt.call_method(this.batch_processing_controller, 'remove_processor', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) register_removable_query_arg(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_push(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.sync_query_arg())
	var_query_args_mutated.array_push(Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.stop_sync_query_arg())
	return var_query_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) register_post_type_for_order_placeholders() {
	rt.call_function('wc_register_order_type', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), rt.create_array([rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'exclude_from_search', val: true }, rt.ArrayItem{ key: 'publicly_queryable', val: false }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: 'show_in_menu', val: false }, rt.ArrayItem{ key: 'show_in_nav_menus', val: false }, rt.ArrayItem{ key: 'show_in_admin_bar', val: false }, rt.ArrayItem{ key: 'show_in_rest', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'can_export', val: false }, rt.ArrayItem{ key: 'supports', val: rt.new_array() }, rt.ArrayItem{ key: 'capabilities', val: rt.new_array() }, rt.ArrayItem{ key: 'exclude_from_order_count', val: true }, rt.ArrayItem{ key: 'exclude_from_order_views', val: true }, rt.ArrayItem{ key: 'exclude_from_order_reports', val: true }, rt.ArrayItem{ key: 'exclude_from_order_sales_reports', val: true }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) add_feature_definition(var_features_controller rt.PhpVal) {
	mut var_definition := rt.create_array([rt.ArrayItem{ key: 'option_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option() }, rt.ArrayItem{ key: 'is_experimental', val: false }, rt.ArrayItem{ key: 'enabled_by_default', val: false }, rt.ArrayItem{ key: 'order', val: 50 }, rt.ArrayItem{ key: 'setting', val: this.get_hpos_setting_for_feature() }, rt.ArrayItem{ key: 'default_plugin_compatibility', val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() }, rt.ArrayItem{ key: 'additional_settings', val: rt.create_array([rt.ArrayItem{ key: none, val: this.get_hpos_setting_for_sync() }]) }])
	rt.call_method(var_features_controller, 'add_feature_definition', [rt.new_string('custom_order_tables'), rt.call_function('__', [rt.new_string('High-Performance order storage'), rt.new_string('woocommerce')]), var_definition.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) get_hpos_setting_for_feature() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_transient', [rt.new_string('wc_installing')]))) {
		return rt.new_array()
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_string((if this.custom_orders_table_usage_is_enabled() { 'yes' } else { 'no' }).str())
		}
	mut var_get_value := rt.new_closure(closure_7_fn)
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_compatibility := rt.call_method(this.features_controller, 'get_compatible_plugins_for_feature', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
		return rt.call_method(this.plugin_util, 'generate_incompatible_plugin_feature_warning', [rt.new_string('custom_order_tables'), var_plugin_compatibility.clone()])
		}
	mut var_get_desc := rt.new_closure(closure_8_fn)
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_compatibility_info := rt.call_method(this.features_controller, 'get_compatible_plugins_for_feature', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
		mut var_sync_complete := rt.new_bool(!(rt.is_true(rt.call_method(this.data_synchronizer, 'has_orders_pending_sync', []rt.PhpVal{}))))
		mut var_disabled := rt.new_array()
		mut var_incompatible_plugins := rt.call_method(this.plugin_util, 'get_items_considered_incompatible', [rt.new_string('custom_order_tables'), var_compatibility_info.clone()])
		var_incompatible_plugins = rt.call_function('array_diff', [var_incompatible_plugins.clone(), rt.call_method(this.plugin_util, 'get_plugins_excluded_from_compatibility_ui', []rt.PhpVal{})])
		if var_incompatible_plugins.clone().array_count() > 0 {
		var_disabled = rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sync_complete)))) && !(this.changing_data_source_with_sync_pending_is_allowed()) {
		var_disabled = rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'no' }])
		}
		return var_disabled.clone()
		}
	mut var_get_disabled := rt.new_closure(closure_9_fn)
	return rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option() }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Order data storage'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'radio' }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'no', val: rt.call_function('__', [rt.new_string('WordPress posts storage (legacy)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'yes', val: rt.call_function('__', [rt.new_string('High-performance order storage (recommended)'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'value', val: var_get_value }, rt.ArrayItem{ key: 'disabled', val: var_get_disabled }, rt.ArrayItem{ key: 'desc', val: var_get_desc }, rt.ArrayItem{ key: 'desc_at_end', val: true }, rt.ArrayItem{ key: 'row_class', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.custom_orders_table_usage_enabled_option() }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) get_hpos_setting_for_sync() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_transient', [rt.new_string('wc_installing')]))) {
		return rt.new_array()
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option()])
		}
	mut var_get_value := rt.new_closure(closure_10_fn)
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sync_in_progress := rt.call_method(this.batch_processing_controller, 'is_enqueued', [rt.call_function('get_class', [this.data_synchronizer])])
		mut var_sync_enabled := rt.call_method(this.data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})
		mut var_sync_is_pending := rt.call_method(this.data_synchronizer, 'has_orders_pending_sync', [rt.new_bool(true)])
		mut var_sync_message := rt.new_array()
		mut var_is_dangerous := rt.new_bool(rt.is_true(var_sync_is_pending) && this.changing_data_source_with_sync_pending_is_allowed())
		if rt.is_true(var_is_dangerous) {
			var_sync_message.array_push(rt.call_function('wp_kses_data', [rt.new_string((rt.call_function('__', [rt.new_string('There are orders pending sync.'), rt.new_string('woocommerce')])).str() + '<strong>' + (rt.call_function('__', [rt.new_string('Switching data storage while sync is incomplete is dangerous and can lead to order data corruption or loss!'), rt.new_string('woocommerce')])).str() + '</strong>')]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sync_enabled)))) && rt.is_true(rt.call_method(this.data_synchronizer, 'background_sync_is_enabled', []rt.PhpVal{})) {
			var_sync_message.array_push(rt.call_function('__', [rt.new_string('Background sync is enabled.'), rt.new_string('woocommerce')]))
		}
		if rt.is_true(var_sync_in_progress) && rt.is_true(var_sync_is_pending) {
			mut var_orders_pending_sync_count := rt.call_method(this.data_synchronizer, 'get_current_orders_pending_sync_count', [rt.new_bool(true)])
			var_sync_message.array_push(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Currently syncing orders... %s pending'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [var_orders_pending_sync_count.clone()])]))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_sync_enabled)))) {
				mut var_stop_sync_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.stop_sync_query_arg(), val: true }]), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()]), 'get_features_page_url', []rt.PhpVal{})]), rt.new_string('hpos-stop-sync')])
				var_sync_message.array_push(rt.call_function('sprintf', [rt.new_string('<a href="%1$s" class="button-link">%2$s</a>'), rt.call_function('esc_url', [var_stop_sync_url.clone()]), rt.call_function('__', [rt.new_string('Stop sync'), rt.new_string('woocommerce')])]))
			}
		} else if rt.is_true(var_sync_is_pending) {
			mut var_sync_now_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.sync_query_arg(), val: true }]), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()]), 'get_features_page_url', []rt.PhpVal{})]), rt.new_string('hpos-sync-now')])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dangerous)))) {
				var_sync_message.array_push(rt.call_function('wp_kses_data', [rt.call_function('__', [rt.new_string('You can switch order data storage <strong>only when the posts and orders tables are in sync</strong>. There are currently orders out of sync.'), rt.new_string('woocommerce')])]))
			}
			var_sync_message.array_push(rt.call_function('sprintf', [rt.new_string('<a href="%1$s" class="button-link">%2$s</a>'), rt.call_function('esc_url', [var_sync_now_url.clone()]), rt.call_function('__', [rt.new_string('Sync orders now'), rt.new_string('woocommerce')])]))
		}
		return rt.call_function('implode', [rt.new_string('<br />'), var_sync_message.clone()])
		}
	mut var_get_sync_message := rt.new_closure(closure_11_fn)
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_sync_is_pending := rt.call_method(this.data_synchronizer, 'has_orders_pending_sync', []rt.PhpVal{})
		return rt.new_bool(rt.is_true(var_sync_is_pending) && this.changing_data_source_with_sync_pending_is_allowed())
		}
	mut var_get_description_is_error := rt.new_closure(closure_12_fn)
	return rt.create_array([rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option() }, rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Enable compatibility mode (Synchronize orders between High-performance order storage and WordPress posts storage).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: var_get_value }, rt.ArrayItem{ key: 'desc_tip', val: var_get_sync_message }, rt.ArrayItem{ key: 'description_is_error', val: var_get_description_is_error }, rt.ArrayItem{ key: 'row_class', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.orders_data_sync_enabled_option() }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) changing_data_source_with_sync_pending_is_allowed() bool {
	return (rt.call_function('apply_filters', [rt.new_string('wc_allow_changing_orders_storage_while_sync_is_pending'), rt.new_bool(false)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) maybe_rewrite_order_edit_link(var_link rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_link_mutated := var_link
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), rt.call_function('get_post_type', [var_post_id.clone()]))) {
	mut iife_temp_12 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_12 := iife_temp_12.get_order_admin_edit_url(var_post_id.clone())
	var_link_mutated = iife_result_12
	}
	return var_link_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) maybe_set_order_cache_group_as_non_persistent() {
	mut iife_temp_13 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_13 := iife_temp_13.custom_orders_table_datastore_cache_enabled()
	if rt.is_true(iife_result_13) {
		rt.call_function('wp_cache_add_non_persistent_groups', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(this.order_cache, 'get_object_type', []rt.PhpVal{}) }])])
	}
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_customorderstablecontroller() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController{
		PhpObjectBase: rt.PhpObjectBase{}
		data_store: rt.new_null()
		refund_data_store: rt.new_null()
		data_synchronizer: rt.new_null()
		data_cleanup: rt.new_null()
		batch_processing_controller: rt.new_null()
		features_controller: rt.new_null()
		order_cache: rt.new_null()
		order_cache_controller: rt.new_null()
		plugin_util: rt.new_null()
		db_util: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_LegacyDataCleanup](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableRefundDataStore](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_BatchProcessing_BatchProcessingController](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_FeaturesController](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_OrderCache](if args.len > 6 { args[6] } else { rt.new_null() })
			mut dispatch_arg_7 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_OrderCacheController](if args.len > 7 { args[7] } else { rt.new_null() })
			mut dispatch_arg_8 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_PluginUtil](if args.len > 8 { args[8] } else { rt.new_null() })
			mut dispatch_arg_9 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil](if args.len > 9 { args[9] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6, mut dispatch_arg_7, mut dispatch_arg_8, mut dispatch_arg_9)
			return rt.new_null()
		}
		'custom_orders_table_usage_is_enabled' {
			return rt.new_bool(this.custom_orders_table_usage_is_enabled())
		}
		'hpos_data_caching_is_enabled' {
			return rt.new_bool(this.hpos_data_caching_is_enabled())
		}
		'get_orders_data_store' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_orders_data_store(dispatch_arg_0)
		}
		'get_refunds_data_store' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_refunds_data_store(dispatch_arg_0)
		}
		'get_data_store_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_data_store_instance(dispatch_arg_0, dispatch_arg_1)
		}
		'add_hpos_tools' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_hpos_tools(mut dispatch_arg_0)
		}
		'delete_custom_orders_tables' {
			this.delete_custom_orders_tables()
			return rt.new_null()
		}
		'process_updated_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.process_updated_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'process_updated_option_fts_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.process_updated_option_fts_index(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'recreate_order_address_fts_index' {
			return this.recreate_order_address_fts_index()
		}
		'process_pre_update_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.process_pre_update_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'sync_now' {
			this.sync_now()
			return rt.new_null()
		}
		'register_removable_query_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_removable_query_arg(dispatch_arg_0)
		}
		'register_post_type_for_order_placeholders' {
			this.register_post_type_for_order_placeholders()
			return rt.new_null()
		}
		'add_feature_definition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_feature_definition(dispatch_arg_0)
			return rt.new_null()
		}
		'get_hpos_setting_for_feature' {
			return this.get_hpos_setting_for_feature()
		}
		'get_hpos_setting_for_sync' {
			return this.get_hpos_setting_for_sync()
		}
		'changing_data_source_with_sync_pending_is_allowed' {
			return rt.new_bool(this.changing_data_source_with_sync_pending_is_allowed())
		}
		'maybe_rewrite_order_edit_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.maybe_rewrite_order_edit_link(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_set_order_cache_group_as_non_persistent' {
			this.maybe_set_order_cache_group_as_non_persistent()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store' { return this.data_store }
		'refund_data_store' { return this.refund_data_store }
		'data_synchronizer' { return this.data_synchronizer }
		'data_cleanup' { return this.data_cleanup }
		'batch_processing_controller' { return this.batch_processing_controller }
		'features_controller' { return this.features_controller }
		'order_cache' { return this.order_cache }
		'order_cache_controller' { return this.order_cache_controller }
		'plugin_util' { return this.plugin_util }
		'db_util' { return this.db_util }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store' { this.data_store = val; return true }
		'refund_data_store' { this.refund_data_store = val; return true }
		'data_synchronizer' { this.data_synchronizer = val; return true }
		'data_cleanup' { this.data_cleanup = val; return true }
		'batch_processing_controller' { this.batch_processing_controller = val; return true }
		'features_controller' { this.features_controller = val; return true }
		'order_cache' { this.order_cache = val; return true }
		'order_cache_controller' { this.order_cache_controller = val; return true }
		'plugin_util' { this.plugin_util = val; return true }
		'db_util' { this.db_util = val; return true }
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


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
