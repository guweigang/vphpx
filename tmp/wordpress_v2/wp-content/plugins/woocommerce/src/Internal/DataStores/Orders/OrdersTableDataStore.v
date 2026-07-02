import rt

pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_order_column_mapping() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }, rt.ArrayItem{ key: 'name', val: 'id' }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'status' }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'type' }]) }, rt.ArrayItem{ key: 'currency', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'currency' }]) }, rt.ArrayItem{ key: 'tax_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'cart_tax' }]) }, rt.ArrayItem{ key: 'total_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'total' }]) }, rt.ArrayItem{ key: 'customer_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }, rt.ArrayItem{ key: 'name', val: 'customer_id' }]) }, rt.ArrayItem{ key: 'billing_email', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_email' }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date' }, rt.ArrayItem{ key: 'name', val: 'date_created' }]) }, rt.ArrayItem{ key: 'date_updated_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date' }, rt.ArrayItem{ key: 'name', val: 'date_modified' }]) }, rt.ArrayItem{ key: 'parent_order_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }, rt.ArrayItem{ key: 'name', val: 'parent_id' }]) }, rt.ArrayItem{ key: 'payment_method', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'payment_method' }]) }, rt.ArrayItem{ key: 'payment_method_title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'payment_method_title' }]) }, rt.ArrayItem{ key: 'ip_address', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'customer_ip_address' }]) }, rt.ArrayItem{ key: 'transaction_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'transaction_id' }]) }, rt.ArrayItem{ key: 'user_agent', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'customer_user_agent' }]) }, rt.ArrayItem{ key: 'customer_note', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'customer_note' }]) }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_billing_address_column_mapping() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'address_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_first_name' }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_last_name' }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_company' }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_address_1' }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_address_2' }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_city' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_state' }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_postcode' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_country' }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_email' }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'billing_phone' }]) }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_shipping_address_column_mapping() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'address_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_first_name' }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_last_name' }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_company' }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_address_1' }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_address_2' }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_city' }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_state' }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_postcode' }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_country' }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'shipping_phone' }]) }])
}
pub fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_operational_data_column_mapping() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'int' }]) }, rt.ArrayItem{ key: 'created_via', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'created_via' }]) }, rt.ArrayItem{ key: 'woocommerce_version', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'version' }]) }, rt.ArrayItem{ key: 'prices_include_tax', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'prices_include_tax' }]) }, rt.ArrayItem{ key: 'coupon_usages_are_counted', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'recorded_coupon_usage_counts' }]) }, rt.ArrayItem{ key: 'download_permission_granted', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'download_permissions_granted' }]) }, rt.ArrayItem{ key: 'cart_hash', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'cart_hash' }]) }, rt.ArrayItem{ key: 'new_order_email_sent', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'new_order_email_sent' }]) }, rt.ArrayItem{ key: 'order_key', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'name', val: 'order_key' }]) }, rt.ArrayItem{ key: 'order_stock_reduced', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'order_stock_reduced' }]) }, rt.ArrayItem{ key: 'date_paid_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date' }, rt.ArrayItem{ key: 'name', val: 'date_paid' }]) }, rt.ArrayItem{ key: 'date_completed_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date' }, rt.ArrayItem{ key: 'name', val: 'date_completed' }]) }, rt.ArrayItem{ key: 'shipping_tax_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'shipping_tax' }]) }, rt.ArrayItem{ key: 'shipping_total_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'shipping_total' }]) }, rt.ArrayItem{ key: 'discount_tax_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'discount_tax' }]) }, rt.ArrayItem{ key: 'discount_total_amount', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'decimal' }, rt.ArrayItem{ key: 'name', val: 'discount_total' }]) }, rt.ArrayItem{ key: 'recorded_sales', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'bool' }, rt.ArrayItem{ key: 'name', val: 'recorded_sales' }]) }])
}
struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
pub mut:
		internal_meta_keys rt.PhpVal = rt.new_array()
		ephemeral_meta_keys rt.PhpVal = rt.new_array()
		data_store_meta rt.PhpVal = rt.new_null()
		database_util rt.PhpVal = rt.new_null()
		cpt_data_store rt.PhpVal = rt.new_null()
		error_logger rt.PhpVal = rt.new_null()
		orders_table_name rt.PhpVal = rt.new_null()
		legacy_proxy rt.PhpVal = rt.new_null()
		order_column_mapping rt.PhpVal = rt.new_null()
		billing_address_column_mapping rt.PhpVal = rt.new_null()
		shipping_address_column_mapping rt.PhpVal = rt.new_null()
		operational_data_column_mapping rt.PhpVal = rt.new_null()
		all_order_column_mapping rt.PhpVal = rt.new_null()
		all_order_column_mapping_for_cache rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'reading_order_ids', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'sync_on_read_order_ids', rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init(mut var_data_store_meta Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta, mut var_database_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy) {
	this.data_store_meta = var_data_store_meta
	this.database_util = var_database_util
	this.legacy_proxy = var_legacy_proxy
	this.error_logger = var_legacy_proxy.call_function(rt.new_string('wc_get_logger'))
	this.internal_meta_keys = this.get_internal_meta_keys()
	this.orders_table_name = Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_addresses_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_addresses'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_operational_data'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders_meta'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_all_table_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: this.get_orders_table_name() }, rt.ArrayItem{ key: none, val: this.get_addresses_table_name() }, rt.ArrayItem{ key: none, val: this.get_operational_data_table_name() }, rt.ArrayItem{ key: none, val: this.get_meta_table_name() }])
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_all_table_names_with_id() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.create_array([rt.ArrayItem{ key: 'orders', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name() }, rt.ArrayItem{ key: 'addresses', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_addresses_table_name() }, rt.ArrayItem{ key: 'operational_data', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name() }, rt.ArrayItem{ key: 'meta', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name() }, rt.ArrayItem{ key: 'items', val: (rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items' }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_all_order_column_mappings() rt.PhpVal {
	if !(!(this.all_order_column_mapping).is_null()) {
		this.all_order_column_mapping = rt.create_array([rt.ArrayItem{ key: 'orders', val: this.order_column_mapping }, rt.ArrayItem{ key: 'billing_address', val: this.billing_address_column_mapping }, rt.ArrayItem{ key: 'shipping_address', val: this.shipping_address_column_mapping }, rt.ArrayItem{ key: 'operational_data', val: this.operational_data_column_mapping }])
	}
	return this.all_order_column_mapping
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_all_order_column_mappings_for_cache() rt.PhpVal {
	if !(!(this.all_order_column_mapping_for_cache).is_null()) {
		this.all_order_column_mapping_for_cache = rt.create_array([rt.ArrayItem{ key: 'orders', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_order_column_mapping() }, rt.ArrayItem{ key: 'billing_address', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_billing_address_column_mapping() }, rt.ArrayItem{ key: 'shipping_address', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_shipping_address_column_mapping() }, rt.ArrayItem{ key: 'operational_data', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.base_operational_data_column_mapping() }])
	}
	return this.all_order_column_mapping_for_cache
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_cache_group() string {
	return 'orders_data'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) clear_cached_data(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_order_ids_mutated := var_order_ids
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.custom_orders_table_datastore_cache_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return rt.call_function('array_fill_keys', [var_order_ids_mutated, rt.new_bool(true)])
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_cache_group := rt.new_string(this.get_cache_group())
	mut var_return_values := rt.new_array()
	mut iter_1 := var_order_ids_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order_id := item_1.val
		var_return_values.array_set(var_order_id, rt.call_method(var_cache_engine, 'delete_cached_object', [var_order_id.clone(), var_cache_group.clone()]))
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.data_store_meta }, rt.ArrayItem{ key: none, val: 'clear_cached_data' }])])) {
		mut var_successfully_deleted_cache_order_ids := rt.func_array_keys(rt.call_function('array_filter', [var_return_values.clone()]))
		mut var_cache_deletion_results := rt.call_method(this.data_store_meta, 'clear_cached_data', [var_successfully_deleted_cache_order_ids.clone()])
		mut iter_2 := var_cache_deletion_results.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta_cache_was_deleted := item_2.val
			mut var_order_id := item_2.key
			var_return_values.array_set(var_order_id, rt.is_true(var_return_values.array_get(var_order_id)) && rt.is_true(var_meta_cache_was_deleted))
		}
	}
	return var_return_values.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) clear_all_cached_data() bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.custom_orders_table_datastore_cache_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return true
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_orders_invalidated := rt.call_method(var_cache_engine, 'delete_cache_group', [rt.new_string(this.get_cache_group())])
	mut var_meta_invalidated := rt.new_bool(true)
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.data_store_meta }, rt.ArrayItem{ key: none, val: 'clear_cached_data' }])])) {
	var_meta_invalidated = rt.call_method(this.data_store_meta, 'clear_all_cached_data', []rt.PhpVal{})
	}
	return rt.is_true(var_orders_invalidated) && rt.is_true(var_meta_invalidated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_table_alias() string {
	return 'o'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_op_table_alias() string {
	return 'p'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_address_table_alias(type string) string {
	mut type_mutated := type
	return if rt.is_true(rt.identical(rt.new_string('billing'), rt.new_string(type_mutated))) { 'b' } else { 's' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_cpt_data_store_instance() rt.PhpVal {
	if !(!(this.cpt_data_store).is_null()) {
		this.cpt_data_store = this.get_post_data_store_for_backfill()
	}
	return this.cpt_data_store
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_post_data_store_for_backfill() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT', []string{}, create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) backfill_post_record(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_cpt_data_store := this.get_post_data_store_for_backfill()
	if var_cpt_data_store.clone().is_null() || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_cpt_data_store.clone(), rt.new_string('update_order_from_object')]))))) {
		return
	}
	rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	if rt.is_true(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})) && rt.call_function('get_post', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]).is_null() {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.maybe_create_backup_post(var_order_mutated.clone(), 'backfill'))))) {
			rt.call_method(this.error_logger, 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to create backup post for order %d.'), rt.new_string('woocommerce')]), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])
			return
		}
	}
	this.update_order_meta_from_object(var_order_mutated.clone())
	mut var_order_class := rt.call_function('get_class', [var_order_mutated.clone()])
	mut var_post_order := rt.create_object_dynamically(var_order_class, []rt.PhpVal{})
	rt.call_method(var_post_order, 'set_id', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.call_method(var_cpt_data_store, 'order_exists', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])) {
		rt.call_method(var_cpt_data_store, 'read', [var_post_order.clone()])
	}
	rt.call_method(var_post_order, 'set_props', [rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{})])
	rt.call_method(var_cpt_data_store, 'update_order_from_object', [var_post_order.clone()])
	mut iter_3 := rt.call_method(var_cpt_data_store, 'get_internal_data_store_key_getters', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_getter_name := item_3.val
		mut var_key := item_3.key
		if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_cpt_data_store }, rt.ArrayItem{ key: none, val: "set_${var_getter_name.to_string()}" }])]) && rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this) }, rt.ArrayItem{ key: none, val: "get_${var_getter_name.to_string()}" }])]) {
			rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: var_cpt_data_store }, rt.ArrayItem{ key: none, val: "set_${var_getter_name.to_string()}" }]), rt.create_array([rt.ArrayItem{ key: none, val: var_order_mutated }, rt.ArrayItem{ key: none, val: rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this), "get_${var_getter_name.to_string()}", [var_order_mutated.clone()]) }])])
		}
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])]))
	rt.call_function('do_action', [rt.new_string('woocommerce_hpos_post_record_backfilled'), var_order_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_order_from_object(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_hpos_order := create_wc_order()
	var_hpos_order.set_id(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	this.read(rt.new_object('WC_Order', []string{}, var_hpos_order))
	var_hpos_order.set_props(rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}))
	mut iter_4 := var_hpos_order.get_meta_data().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_meta := item_4.val
		var_hpos_order.delete_meta_data(rt.get_property(var_meta, 'key'))
	}
	mut iter_5 := rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{}).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta := item_5.val
		var_hpos_order.add_meta_data(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'))
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_orders_table_datastore_should_save_after_meta_change'), rt.new_string('__return_false')])
	var_hpos_order.save_meta_data()
	rt.call_function('remove_filter', [rt.new_string('woocommerce_orders_table_datastore_should_save_after_meta_change'), rt.new_string('__return_false')])
	mut var_db_rows := this.get_db_rows_for_order(mut var_hpos_order, 'update', true)
	mut iter_6 := var_db_rows.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_db_update := item_6.val
		rt.call_function('ksort', [var_db_update.array_get(rt.new_string('data'))])
		rt.call_function('ksort', [var_db_update.array_get(rt.new_string('format'))])
		this.persist_db_row(var_db_update.clone())
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_db_row(var_update rt.PhpVal) rt.PhpVal {
	if var_update.array_isset(rt.new_string('where')) {
	mut var_row_updated := rt.call_method(this.database_util, 'insert_or_update', [var_update.array_get(rt.new_string('table')), var_update.array_get(rt.new_string('data')), var_update.array_get(rt.new_string('where')), var_update.array_get(rt.new_string('format')), var_update.array_get(rt.new_string('where_format'))])
	mut var_result := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_row_updated)))
	} else {
	var_result = rt.call_method(this.database_util, 'insert_on_duplicate_key_update', [var_update.array_get(rt.new_string('table')), var_update.array_get(rt.new_string('data')), rt.call_function('array_values', [var_update.array_get(rt.new_string('format'))])])
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_download_permissions_granted(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_order_id := if var_order_mutated.clone().is_long() { var_order_mutated } else { rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }
	var_order_mutated = rt.call_function('wc_get_order', [var_order_id.clone()])
	return rt.call_method(var_order_mutated, 'get_download_permissions_granted', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_download_permissions_granted(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_download_permissions_granted', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_recorded_sales(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_order_id := if var_order_mutated.clone().is_long() { var_order_mutated } else { rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }
	var_order_mutated = rt.call_function('wc_get_order', [var_order_id.clone()])
	return rt.call_method(var_order_mutated, 'get_recorded_sales', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_recorded_sales(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_recorded_sales', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_recorded_coupon_usage_counts(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_order_id := if var_order_mutated.clone().is_long() { var_order_mutated } else { rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }
	var_order_mutated = rt.call_function('wc_get_order', [var_order_id.clone()])
	return rt.is_true(var_order_mutated) && rt.is_true(rt.call_method(var_order_mutated, 'get_recorded_coupon_usage_counts', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_recorded_coupon_usage_counts(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_recorded_coupon_usage_counts', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_order_id := if var_order_mutated.clone().is_long() { var_order_mutated } else { rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }
	var_order_mutated = rt.call_function('wc_get_order', [var_order_id.clone()])
	return rt.call_method(var_order_mutated, 'get_new_order_email_sent', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_email_sent(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_new_order_email_sent', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_new_order_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return this.get_email_sent(var_order_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_new_order_email_sent(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_new_order_email_sent', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_order_id := if var_order_mutated.clone().is_long() { var_order_mutated } else { rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }
	var_order_mutated = rt.call_function('wc_get_order', [var_order_id.clone()])
	return rt.call_method(var_order_mutated, 'get_order_stock_reduced', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(var_order_mutated.clone().is_long())) {
	var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.clone()])
	}
	rt.call_method(var_order_mutated, 'set_order_stock_reduced', [var_set.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return this.get_stock_reduced(var_order_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	this.set_stock_reduced(var_order_mutated.clone(), var_set.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_payment_token_ids(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_payment_tokens := rt.call_method(this.data_store_meta, 'get_metadata_by_key', [var_order_mutated.clone(), rt.new_string('_payment_tokens')])
	if rt.is_true(var_payment_tokens) {
	var_payment_tokens = rt.get_property(var_payment_tokens.array_get(rt.new_int(0)), 'meta_value')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_tokens)))) && rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order_mutated, 'get_version', []rt.PhpVal{}), rt.new_string('8.0.0'), rt.new_string('<')])) {
	var_payment_tokens = rt.call_function('get_post_meta', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.new_string('_payment_tokens'), rt.new_bool(true)])
	}
	return rt.call_function('array_filter', [rt.cast_array(var_payment_tokens)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_payment_token_ids(var_order rt.PhpVal, var_token_ids rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_meta := create_automattic_woocommerce_internal_datastores_orders_wc_meta_data()
	rt.set_property(var_meta, 'key', rt.new_string('_payment_tokens'))
	rt.set_property(var_meta, 'value', var_token_ids.clone())
	mut var_existing_meta := rt.call_method(this.data_store_meta, 'get_metadata_by_key', [var_order_mutated.clone(), rt.new_string('_payment_tokens')])
	if rt.is_true(var_existing_meta) {
		var_existing_meta = var_existing_meta.array_get(rt.new_int(0))
		rt.set_property(var_meta, 'id', rt.get_property(var_existing_meta, 'id'))
		rt.call_method(this.data_store_meta, 'update_meta', [var_order_mutated.clone(), var_meta])
	} else {
		rt.call_method(this.data_store_meta, 'add_meta', [var_order_mutated.clone(), var_meta])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_total_refunded(var_order rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	mut var_order_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	mut var_total := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT SUM( total_amount ) FROM ${var_order_table.to_string()}\nWHERE\n    type = %s AND\n    parent_order_id = %d\n;\n"), rt.new_string('shop_order_refund'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])
	return rt.mul(-1, if !(var_total).is_null() { var_total } else { rt.new_int(0) })
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_orders_join_clause(order_id i64) string {
	mut var_wpdb := rt.new_null()
	mut order_id_mutated := order_id
	return (rt.call_method(var_wpdb, 'prepare', [rt.new_string('%i AS refunds ON ( refunds.type = %s AND refunds.parent_order_id = %d )'), Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name(), rt.new_string('shop_order_refund'), rt.new_int(order_id_mutated).clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_id_by_order_key(var_order_key rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_orders_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	mut var_op_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name()
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT ${var_orders_table.to_string()}.id FROM ${var_orders_table.to_string()}\n\t\t\t\tINNER JOIN ${var_op_table.to_string()} ON ${var_op_table.to_string()}.order_id = ${var_orders_table.to_string()}.id\n\t\t\t\tWHERE ${var_op_table.to_string()}.order_key = %s AND ${var_op_table.to_string()}.order_key != ''"), var_order_key.clone()])])).to_i64())
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_count(var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	mut var_orders_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	return rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT COUNT(*) FROM ${var_orders_table.to_string()} WHERE type = %s AND status = %s"), rt.new_string('shop_order'), var_status_mutated.clone()])])])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('3.1.0'), rt.new_string('Use wc_get_orders instead.')])
	return rt.call_function('wc_get_orders', [var_args_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_unpaid_orders(var_date rt.PhpVal) rt.PhpVal {
	mut var_timezone_offset := rt.call_function('wc_timezone_offset', []rt.PhpVal{})
	mut var_gmt_timestamp := rt.sub(var_date, var_timezone_offset)
	return this.get_unpaid_orders_gmt(rt.call_function('absint', [var_gmt_timestamp.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_unpaid_orders_gmt(var_gmt_timestamp rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_gmt_timestamp_mutated := var_gmt_timestamp
	mut var_orders_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	mut var_order_types_sql := rt.new_string('(\'' + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('wc_get_order_types', []rt.PhpVal{})])).str() + '\')')
	return rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT id FROM ${var_orders_table.to_string()} WHERE\n\t\t\t\t${var_orders_table.to_string()}.type IN ${var_order_types_sql.to_string()}\n\t\t\t\tAND ${var_orders_table.to_string()}.status = %s\n\t\t\t\tAND ${var_orders_table.to_string()}.date_updated_gmt < %s"), Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending(), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_function('absint', [var_gmt_timestamp_mutated.clone()])])])])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) search_orders(var_term rt.PhpVal) rt.PhpVal {
	mut var_order_ids := rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 's', val: var_term }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	return rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_cot_shop_order_search_results'), var_order_ids.clone(), var_term.clone()]))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_orders_type(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	if !rt.is_true(var_order_ids_mutated) {
		return rt.new_array()
	}
	mut var_order_types := rt.new_array()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.custom_orders_table_datastore_cache_enabled()
	if rt.is_true(iife_result_2) {
		if !(var_order_ids_mutated.clone().is_array()) {
		var_order_ids_mutated = rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int((var_order_ids_mutated).to_i64()) }])
		}
		mut var_orders_data := this.get_order_data_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_order_ids_mutated))
		mut iter_7 := var_orders_data.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_order_data := item_7.val
			mut var_order_id := item_7.key
			if !(!rt.is_true(rt.get_property(var_order_data, 'type'))) {
				var_order_types.array_set(var_order_id, rt.get_property(var_order_data, 'type'))
			}
		}
		return var_order_types.clone()
	}
	mut var_orders_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	mut var_order_ids_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_ids_mutated.clone().array_count()), rt.new_string('%d')])])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT id, type FROM ${var_orders_table.to_string()} WHERE id IN ( ${var_order_ids_placeholder.to_string()} )"), var_order_ids_mutated.clone()])])
	mut iter_8 := var_results.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_row := item_8.val
		var_order_types.array_set(rt.get_property(var_row, 'id'), rt.get_property(var_row, 'type'))
	}
	return var_order_types.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_type(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	mut var_type := this.get_orders_type(rt.create_array([rt.ArrayItem{ key: none, val: var_order_id_mutated }]))
	return if !(var_type.array_get(var_order_id_mutated)).is_null() { var_type.array_get(var_order_id_mutated) } else { rt.new_string('') }
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) order_exists(var_order_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
	mut var_exists := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT EXISTS (SELECT id FROM '), this.orders_table_name), rt.new_string(' WHERE id=%d)')), var_order_id_mutated.clone()])])
	return (var_exists).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_orders_array := rt.create_array([rt.ArrayItem{ key: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), val: var_order_mutated }])
	this.read_multiple(var_orders_array.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_multiple(var_orders rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_orders_mutated := var_orders
	mut var_order_ids := rt.func_array_keys(var_orders_mutated.clone())
	mut var_data := this.get_order_data_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_order_ids))
	if rt.is_true(rt.new_bool(var_data.clone().array_count() != var_order_ids.clone().array_count())) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Invalid order IDs in call to read_multiple()'), rt.new_string('woocommerce')]))))
	}
	mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_data_synchronizer, 'Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer')))))) {
		return
	}
	mut var_data_sync_enabled := rt.new_bool(rt.is_true(rt.call_method(var_data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_deliver_webhook_async')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('wc-admin_import_orders')]))))))
	if rt.is_true(var_data_sync_enabled) {
	var_data_sync_enabled = rt.call_function('apply_filters', [rt.new_string('woocommerce_hpos_enable_sync_on_read'), rt.new_bool(false)])
	}
	mut var_load_posts_for := rt.call_function('array_diff', [var_order_ids.clone(), rt.call_function('array_merge', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'reading_order_ids'), rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids')])])
	mut var_post_orders := rt.new_array()
	if rt.is_true(var_data_sync_enabled) {
		if rt.is_true(var_load_posts_for) {
		mut var_order_ids_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_load_posts_for.clone().array_count()), rt.new_string('%d')])])
		var_load_posts_for = rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID IN ( ')), var_order_ids_placeholder), rt.new_string(' )')), var_load_posts_for.clone()])])])
		}
	var_post_orders = this.get_post_orders_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.call_function('array_intersect_key', [var_orders_mutated.clone(), rt.call_function('array_flip', [var_load_posts_for.clone()])])))
	}
	mut var_cogs_is_enabled := this.cogs_is_enabled()
	mut iter_9 := var_data.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_order_data := item_9.val
		mut var_order_id := rt.call_function('absint', [rt.get_property(var_order_data, 'id')])
		mut var_order := var_orders_mutated.array_get(var_order_id)
		this.init_order_record(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order), (var_order_id).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass](var_order_data))
		if rt.is_true(var_cogs_is_enabled) && rt.is_true(rt.call_method(var_order, 'has_cogs', []rt.PhpVal{})) {
			this.read_cogs_data(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.get_property(var_order_data, 'meta_data')))
		}
		if rt.is_true(var_data_sync_enabled) && var_post_orders.array_isset(var_order_id) && this.should_sync_order(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order)) {
			rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'reading_order_ids').array_push(var_order_id.clone())
			this.maybe_sync_order(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order), mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_post_orders.array_get(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_cogs_data(mut var_order Class_WC_Abstract_Order, mut var_meta_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_meta := rt.new_null()
	mut var_order_mutated := var_order
	mut var_meta_data_mutated := var_meta_data
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('_cogs_total_value'), rt.get_property(var_meta, 'meta_key'))
		}
	mut var_meta_entry := rt.call_function('array_filter', [var_meta_data_mutated, rt.new_closure(closure_4_fn)])
	mut var_cogs_value := if rt.is_true(rt.identical(rt.new_array(), var_meta_entry)) { rt.new_int(0) } else { rt.new_float((rt.get_property(rt.call_function('current', [var_meta_entry.clone()]), 'meta_value')).to_f64()) }
	var_cogs_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_load_order_cogs_value'), var_cogs_value.clone(), var_order_mutated])
	rt.call_method(var_order_mutated, 'set_cogs_total_value', [rt.new_float((var_cogs_value).to_f64())])
	rt.call_method(var_order_mutated, 'apply_changes', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_sync_order(mut var_order Class_WC_Abstract_Order) bool {
	mut var_order_mutated := var_order
	mut var_draft_order := rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'auto-draft' }]), rt.new_bool(true)])
	mut var_already_synced := rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'reading_order_ids'), rt.new_bool(true)])
	return rt.is_true(rt.new_bool(!(rt.is_true(var_draft_order)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_already_synced))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init_order_record(mut var_order Class_WC_Abstract_Order, order_id i64, mut var_order_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass) {
	mut var_order_mutated := var_order
	mut order_id_mutated := order_id
	mut var_order_data_mutated := var_order_data
	rt.call_method(var_order_mutated, 'set_defaults', []rt.PhpVal{})
	rt.call_method(var_order_mutated, 'set_id', [rt.new_int(order_id_mutated).clone()])
	mut var_filtered_meta_data := this.filter_raw_meta_data(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), rt.get_property(var_order_data_mutated, 'meta_data'))
	rt.call_method(var_order_mutated, 'init_meta_data', [var_filtered_meta_data.clone()])
	this.set_order_props_from_data(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_stdClass', []string{}, var_order_data_mutated))
	rt.call_method(var_order_mutated, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) filter_raw_meta_data(var_object rt.PhpVal, var_raw_meta_data rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data_mutated := var_raw_meta_data
	mut var_filtered_meta_data := this.Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT.filter_raw_meta_data(var_object.clone(), var_raw_meta_data_mutated.clone())
	mut var_allowed_keys := rt.create_array([rt.ArrayItem{ key: none, val: '_billing_address_index' }, rt.ArrayItem{ key: none, val: '_shipping_address_index' }])
	closure_5_fn := fn [var_allowed_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_meta := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [rt.get_property(var_meta, 'meta_key'), var_allowed_keys.clone(), rt.new_bool(true)])
		}
	mut var_allowed_meta := rt.call_function('array_filter', [var_raw_meta_data_mutated.clone(), rt.new_closure(closure_5_fn)])
	return rt.call_function('array_merge', [var_allowed_meta.clone(), var_filtered_meta_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_sync_order(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order) {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
	if !(this.is_post_different_from_order(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), rt.new_object('WC_Abstract_Order', []string{}, var_post_order_mutated))) {
		return
	}
	mut var_order_modified_date := if !(rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{})).is_null() { rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{}) } else { rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}) }
	var_order_modified_date = if var_order_modified_date.clone().is_null() { rt.new_int(0) } else { rt.call_method(var_order_modified_date, 'getTimestamp', []rt.PhpVal{}) }
	mut var_post_order_modified_date := if !(rt.call_method(var_post_order_mutated, 'get_date_modified', []rt.PhpVal{})).is_null() { rt.call_method(var_post_order_mutated, 'get_date_modified', []rt.PhpVal{}) } else { rt.call_method(var_post_order_mutated, 'get_date_created', []rt.PhpVal{}) }
	var_post_order_modified_date = if var_post_order_modified_date.clone().is_null() { rt.new_int(0) } else { rt.call_method(var_post_order_modified_date, 'getTimestamp', []rt.PhpVal{}) }
	if rt.is_true(rt.greater_equal(var_post_order_modified_date, var_order_modified_date)) {
		this.migrate_post_record(mut var_order_mutated, mut var_post_order_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_cpt_order(var_post rt.PhpVal) rt.PhpVal {
	mut var_cpt_order := create_wc_order()
	rt.call_method(var_cpt_order, 'set_id', [rt.get_property(var_post, 'ID')])
	mut var_cpt_data_store := this.get_cpt_data_store_instance()
	rt.call_method(var_cpt_data_store, 'read', [var_cpt_order.clone()])
	return var_cpt_order.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_post_orders_for_ids(mut var_orders Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_orders_mutated := var_orders
	mut var_order_ids := rt.func_array_keys(var_orders_mutated)
	mut iter_10 := var_order_ids.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_order_id := item_10.val
		mut var_post_type := rt.call_function('get_post_type', [var_order_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), var_post_type)) {
			var_orders_mutated.array_unset(var_order_id)
			continue
		}
		mut iife_temp_5 := Class_WC_Order{}
		mut iife_result_5 := iife_temp_5.generate_meta_cache_key(var_order_id.clone(), rt.new_string('orders'))
		mut iife_temp_6 := Class_WC_Order{}
		mut iife_result_6 := iife_temp_6.generate_meta_cache_key(var_order_id.clone(), rt.new_string('orders'))
		rt.call_function('wp_cache_delete', [iife_result_5, rt.new_string('orders')])
	}
	mut var_cpt_stores := rt.new_array()
	mut var_cpt_store_orders := rt.new_array()
	mut iter_11 := var_orders_mutated.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_order := item_11.val
		mut var_order_id := item_11.key
		mut var_table_data_store := rt.call_method(var_order, 'get_data_store', []rt.PhpVal{})
		mut var_cpt_data_store := rt.call_method(var_table_data_store, 'get_cpt_data_store_instance', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_cpt_data_store)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.new_string('No CPT data store found for order %d.'), rt.call_function('absint', [var_order_id.clone()])]))))
		}
		mut var_cpt_store_class_name := rt.call_function('get_class', [var_cpt_data_store.clone()])
		if !(var_cpt_stores.array_isset(var_cpt_store_class_name)) {
			var_cpt_stores.array_set(var_cpt_store_class_name, var_cpt_data_store.clone())
			var_cpt_store_orders.array_set(var_cpt_store_class_name, rt.new_array())
		}
		var_cpt_store_orders.array_get_mut(var_cpt_store_class_name).array_set(var_order_id, var_order.clone())
	}
	mut var_cpt_orders := rt.new_array()
	mut iter_12 := var_cpt_stores.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_cpt_store := item_12.val
		mut var_cpt_store_name := item_12.key
		if rt.is_true(rt.call_function('method_exists', [var_cpt_store.clone(), rt.new_string('prime_caches_for_orders')])) {
			rt.call_method(var_cpt_store, 'prime_caches_for_orders', [rt.func_array_keys(var_cpt_store_orders.array_get(var_cpt_store_name)), rt.new_array()])
		}
		mut iter_13 := var_cpt_store_orders.array_get(var_cpt_store_name).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_order := item_13.val
			mut var_order_id := item_13.key
			mut var_cpt_order_class_name := rt.call_function('wc_get_order_type', [rt.call_method(var_order, 'get_type', []rt.PhpVal{})]).array_get(rt.new_string('class_name'))
			mut var_cpt_order := rt.create_object_dynamically(var_cpt_order_class_name, []rt.PhpVal{})
			rt.call_method(var_cpt_order, 'set_id', [var_order_id.clone()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.call_method(var_cpt_store, 'read', [var_cpt_order.clone()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_cpt_orders.array_set(var_order_id, var_cpt_order.clone())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.clone()
				rt.call_method(this.error_logger, 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to load the post record for order %1$d'), rt.new_string('woocommerce')]), var_order_id.clone()]), rt.create_array([rt.ArrayItem{ key: 'exception_code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'exception_msg', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'origin', val: @METHOD }])])
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	return var_cpt_orders.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) is_post_different_from_order(var_order rt.PhpVal, var_post_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_7 := iife_temp_7.deep_compare_array_diff(rt.call_method(var_order_mutated, 'get_base_data', []rt.PhpVal{}), rt.call_method(var_post_order_mutated, 'get_base_data', []rt.PhpVal{}), rt.new_bool(false))
	if rt.is_true(iife_result_7) {
		return true
	}
	mut var_meta_diff := this.get_diff_meta_data_between_orders(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_post_order_mutated), false)
	if !(!rt.is_true(var_meta_diff)) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) migrate_meta_data_from_post_order(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
	mut var_diff := this.get_diff_meta_data_between_orders(mut var_order_mutated, mut var_post_order_mutated, true)
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	return var_diff.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_diff_meta_data_between_orders(mut var_order1 Class_WC_Abstract_Order, mut var_order2 Class_WC_Abstract_Order, sync bool) rt.PhpVal {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_8 := iife_temp_8.select(var_order1.get_meta_data(), rt.new_string('get_data'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut var_order1_meta := iife_result_8
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_9 := iife_temp_9.select(var_order2.get_meta_data(), rt.new_string('get_data'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut var_order2_meta := iife_result_9
	mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_10 := iife_temp_10.select_as_assoc(var_order1_meta.clone(), rt.new_string('key'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key())
	mut var_order1_meta_by_key := iife_result_10
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_11 := iife_temp_11.select_as_assoc(var_order2_meta.clone(), rt.new_string('key'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key())
	mut var_order2_meta_by_key := iife_result_11
	mut var_diff := rt.new_array()
	mut iter_14 := var_order1_meta_by_key.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_value := item_14.val
		mut var_key := item_14.key
		if rt.is_true(rt.call_function('in_array', [var_key.clone(), this.internal_meta_keys, rt.new_bool(true)])) {
			continue
		}
		mut iife_temp_12 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_12 := iife_temp_12.select(var_value.clone(), rt.new_string('value'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key())
		mut var_order1_values := iife_result_12
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_order2_meta_by_key.clone().array_isset(var_key.clone())))))) {
			rt.new_bool(var_sync && rt.is_true(var_order1.delete_meta_data(var_key.clone())))
			var_diff.array_set(var_key, var_order1_values.clone())
			var_order2_meta_by_key.array_unset(var_key)
			continue
		}
		mut iife_temp_13 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_13 := iife_temp_13.select(var_order2_meta_by_key.array_get(var_key), rt.new_string('value'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key())
		mut var_order2_values := iife_result_13
		mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_14 := iife_temp_14.deep_assoc_array_diff(var_order1_values.clone(), var_order2_values.clone())
		mut var_new_diff := iife_result_14
		if !(!rt.is_true(var_new_diff)) && var_sync {
			if var_order2_values.clone().array_count() > 1 {
				var_order1.delete_meta_data(var_key.clone())
				mut iter_15 := var_order2_values.iterator()
				for {
					item_15 := iter_15.next() or { break }
					mut var_post_order_value := item_15.val
					var_order1.add_meta_data(var_key.clone(), var_post_order_value.clone(), rt.new_bool(false))
				}
			} else {
				var_order1.update_meta_data(var_key.clone(), var_order2_values.array_get(rt.new_int(0)))
			}
			var_diff.array_set(var_key, var_new_diff.clone())
			var_order2_meta_by_key.array_unset(var_key)
		}
	}
	mut iter_16 := var_order2_meta_by_key.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_value := item_16.val
		mut var_key := item_16.key
		if rt.is_true(rt.new_bool(var_order1_meta_by_key.clone().array_isset(var_key.clone()))) || rt.is_true(rt.call_function('in_array', [var_key.clone(), this.internal_meta_keys, rt.new_bool(true)])) {
			continue
		}
		mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_15 := iife_temp_15.select(var_value.clone(), rt.new_string('value'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_array_key())
		mut var_order2_values := iife_result_15
		mut iter_17 := var_order2_values.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_meta_value := item_17.val
			rt.new_bool(var_sync && rt.is_true(var_order1.add_meta_data(var_key.clone(), var_meta_value.clone())))
		}
		var_diff.array_set(var_key, var_order2_values.clone())
	}
	return var_diff.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) migrate_post_record(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order) {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
	rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'sync_on_read_order_ids').array_set(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), true)
	mut var_diff := this.migrate_meta_data_from_post_order(mut var_order_mutated, mut var_post_order_mutated)
	mut var_post_order_base_data := rt.call_method(var_post_order_mutated, 'get_base_data', []rt.PhpVal{})
	mut iter_18 := var_post_order_base_data.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_value := item_18.val
		mut var_key := item_18.key
		if rt.is_true(rt.identical(rt.new_string('cogs_total_value'), var_key)) && rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{})) && rt.is_true(this.cogs_is_enabled()) {
			mut var_hpos_cogs := rt.call_method(var_order_mutated, 'get_cogs_total_value', [rt.new_string('edit')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_float(0), var_hpos_cogs)))) && 0 == rt.new_float((var_value).to_f64()) {
				continue
			}
		}
		this.set_order_prop(mut var_order_mutated, (var_key).str(), var_value.clone())
	}
	this.persist_updates(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), false)
	rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'sync_on_read_order_ids').array_unset(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	rt.call_function('do_action', [rt.new_string('woocommerce_hpos_post_record_migrated_on_read'), var_order_mutated, var_diff.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_props_from_data(var_order rt.PhpVal, var_order_data rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_order_data_mutated := var_order_data
	mut iter_19 := this.get_all_order_column_mappings().iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_column_mapping := item_19.val
		mut var_table_name := item_19.key
		mut iter_20 := var_column_mapping.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_prop_details := item_20.val
			mut var_column_name := item_20.key
			if !(var_prop_details.array_isset(rt.new_string('name'))) || !(var_prop_details.array_get(rt.new_string('name')).is_string()) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_order_data_mutated.clone(), var_prop_details.array_get(rt.new_string('name'))]))))) {
				rt.call_method(this.error_logger, 'debug', [rt.call_function('sprintf', [rt.new_string('Property \'%1$s\' (column \'%2$s\' from table group \'%3$s\') missing from data for order %4$d. Order will use default value for this property.'), var_prop_details.array_get(rt.new_string('name')), var_column_name.clone(), var_table_name.clone(), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'hpos-data-cache' }])])
				continue
			}
			mut var_prop_value := rt.get_property(var_order_data_mutated, '{"nodeType":"Expr_ArrayDimFetch","line":1786,"var":{"nodeType":"Expr_Variable","line":1786,"name":"prop_details"},"dim":{"nodeType":"Scalar_String","line":1786,"value":"name"}}')
			if rt.is_true(rt.new_bool(var_prop_value.clone().is_null())) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('date'), var_prop_details.array_get(rt.new_string('type')))) {
				var_prop_value = this.string_to_timestamp(var_prop_value.clone())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			this.set_order_prop(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), (var_prop_details.array_get(rt.new_string('name'))).str(), var_prop_value.clone())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Exception') {
				mut var_e := var_e_2.clone()
				mut var_order_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
				rt.call_method(this.error_logger, 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error when setting property \'%1$s\' for order %2$d: %3$s'), rt.new_string('woocommerce')]), var_prop_details.array_get(rt.new_string('name')), var_order_id.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'exception_code', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'exception_msg', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'origin', val: @METHOD }, rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'property_name', val: var_prop_details.array_get(rt.new_string('name')) }])])
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_prop(mut var_order Class_WC_Abstract_Order, prop_name string, var_prop_value rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_prop_value_mutated := var_prop_value
	mut var_prop_setter_function_name := rt.new_string("set_${var_prop_name}")
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order_mutated }, rt.ArrayItem{ key: none, val: var_prop_setter_function_name }])])) {
		return (rt.call_method(var_order_mutated, var_prop_setter_function_name, [var_prop_value_mutated.clone()])).to_bool()
	} else if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this) }, rt.ArrayItem{ key: none, val: var_prop_setter_function_name }])])) {
		return (rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this), var_prop_setter_function_name, [var_order_mutated, var_prop_value_mutated.clone(), rt.new_bool(false)])).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
	if !rt.is_true(var_ids_mutated) {
		return rt.new_array()
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_16 := iife_temp_16.custom_orders_table_datastore_cache_enabled()
	mut var_using_datastore_cache := iife_result_16
	mut var_order_data := rt.new_array()
	if rt.is_true(var_using_datastore_cache) {
	var_order_data = this.get_order_data_for_ids_from_cache(mut var_ids_mutated)
	var_ids_mutated = rt.call_function('array_diff', [var_ids_mutated, rt.func_array_keys(var_order_data.clone())])
	}
	if var_ids_mutated.array_count() > 0 {
		mut var_db_order_data := this.get_order_data_for_ids_from_db(mut var_ids_mutated)
		var_order_data = rt.add(var_db_order_data, var_order_data)
		if var_db_order_data.clone().array_count() > 0 && rt.is_true(var_using_datastore_cache) {
			this.set_order_data_in_cache(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_db_order_data))
		}
	}
	var_order_data = rt.call_function('array_filter', [var_order_data.clone()])
	mut var_meta_data := rt.call_method(this.data_store_meta, 'get_meta_data_for_object_ids', [rt.func_array_keys(var_order_data.clone())])
	mut iter_21 := var_meta_data.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_order_meta := item_21.val
		mut var_order_id := item_21.key
		rt.set_property(var_order_data.array_get(var_order_id), 'meta_data', var_order_meta.clone())
	}
	return var_order_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids_from_db(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_ids_mutated := var_ids
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ids_mutated)))) || !rt.is_true(var_ids_mutated) {
		return rt.new_array()
	}
	mut var_table_aliases := rt.create_array([rt.ArrayItem{ key: 'orders', val: this.get_order_table_alias() }, rt.ArrayItem{ key: 'billing_address', val: this.get_address_table_alias('billing') }, rt.ArrayItem{ key: 'shipping_address', val: this.get_address_table_alias('shipping') }, rt.ArrayItem{ key: 'operational_data', val: this.get_op_table_alias() }])
	mut var_order_table_alias := var_table_aliases.array_get(rt.new_string('orders'))
	mut var_order_table_query := rt.new_string(this.get_order_table_select_statement())
	mut var_id_placeholder := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_ids_mutated.array_count()), rt.new_string('%d')])])
	mut var_table_data := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("${var_order_table_query.to_string()} WHERE ${var_order_table_alias.to_string()}.id in ( ${var_id_placeholder.to_string()} )"), var_ids_mutated])])
	mut var_order_data := rt.new_array()
	mut iter_22 := var_table_data.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_table_datum := item_22.val
		mut var_id := rt.get_property(var_table_datum, '{"nodeType":"Scalar_InterpolatedString","line":1913,"parts":[{"nodeType":"Expr_Variable","line":1913,"name":"order_table_alias"},{"nodeType":"InterpolatedStringPart","line":1913,"value":"_id"}]}')
		var_order_data.array_set(var_id, create_automattic_woocommerce_internal_datastores_orders_stdclass())
		mut iter_23 := this.get_all_order_column_mappings_for_cache().iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_column_mappings := item_23.val
			mut var_table_name := item_23.key
			mut var_table_alias := var_table_aliases.array_get(var_table_name)
			mut iter_24 := var_column_mappings.iterator()
			for {
				item_24 := iter_24.next() or { break }
				mut var_map := item_24.val
				mut var_field := item_24.key
				mut var_field_name := if !(var_map.array_get(rt.new_string('name'))).is_null() { var_map.array_get(rt.new_string('name')) } else { rt.new_string("${var_table_name.to_string()}_${var_field.to_string()}") }
				if rt.is_true(rt.call_function('property_exists', [var_table_datum.clone(), var_field_name.clone()])) {
				mut var_field_value := rt.get_property(var_table_datum, '{"nodeType":"Expr_Variable","line":1921,"name":"field_name"}')
				} else if rt.is_true(rt.call_function('property_exists', [var_table_datum.clone(), rt.new_string("${var_table_alias.to_string()}_${var_field.to_string()}")])) {
				var_field_value = rt.get_property(var_table_datum, '{"nodeType":"Scalar_InterpolatedString","line":1923,"parts":[{"nodeType":"Expr_Variable","line":1923,"name":"table_alias"},{"nodeType":"InterpolatedStringPart","line":1923,"value":"_"},{"nodeType":"Expr_Variable","line":1923,"name":"field"}]}')
				} else {
				var_field_value = rt.get_property(var_table_datum, '{"nodeType":"Expr_Variable","line":1925,"name":"field"}')
				}
				rt.set_property(var_order_data.array_get(var_id), '{"nodeType":"Expr_Variable","line":1927,"name":"field_name"}', var_field_value.clone())
			}
		}
		rt.set_property(var_order_data.array_get(var_id), 'id', var_id.clone())
		rt.set_property(var_order_data.array_get(var_id), 'meta_data', rt.new_array())
	}
	return var_order_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids_from_cache(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	return rt.call_function('array_filter', [rt.call_method(var_cache_engine, 'get_cached_objects', [var_ids_mutated, rt.new_string(this.get_cache_group())])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_data_in_cache(mut var_order_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_order_data_mutated := var_order_data
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	rt.call_method(var_cache_engine, 'cache_objects', [var_order_data_mutated, rt.new_int(0), rt.new_string(this.get_cache_group())])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_table_select_statement() string {
	mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}{}
	mut iife_result_17 := iife_temp_17.get_orders_table_name()
	mut var_order_table := iife_result_17
	mut var_order_table_alias := rt.new_string(this.get_order_table_alias())
	mut var_billing_address_table_alias := rt.new_string(this.get_address_table_alias('billing'))
	mut var_shipping_address_table_alias := rt.new_string(this.get_address_table_alias('shipping'))
	mut var_op_data_table_alias := rt.new_string(this.get_op_table_alias())
	mut var_billing_address_clauses := this.join_billing_address_table_to_order_query(var_order_table_alias.clone(), var_billing_address_table_alias.clone())
	mut var_shipping_address_clauses := this.join_shipping_address_table_to_order_query(var_order_table_alias.clone(), var_shipping_address_table_alias.clone())
	mut var_operational_data_clauses := this.join_operational_data_table_to_order_query(var_order_table_alias.clone(), var_op_data_table_alias.clone())
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT '), var_order_table_alias), rt.new_string('.id as o_id, ')), var_op_data_table_alias), rt.new_string('.id as p_id, ')), var_order_table_alias), rt.new_string('.*, ')), var_billing_address_clauses.array_get(rt.new_string('select'))), rt.new_string(', ')), var_shipping_address_clauses.array_get(rt.new_string('select'))), rt.new_string(', ')), var_op_data_table_alias), rt.new_string('.*\nFROM ')), var_order_table), rt.new_string(' ')), var_order_table_alias), rt.new_string('\nLEFT JOIN ')), var_billing_address_clauses.array_get(rt.new_string('join'))), rt.new_string('\nLEFT JOIN ')), var_shipping_address_clauses.array_get(rt.new_string('join'))), rt.new_string('\nLEFT JOIN ')), var_operational_data_clauses.array_get(rt.new_string('join'))), rt.new_string('\n'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_meta_select_statement() string {
	mut var_order_meta_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name()
	return "\nSELECT ${var_order_meta_table.to_string()}.id, ${var_order_meta_table.to_string()}.order_id, ${var_order_meta_table.to_string()}.meta_key, ${var_order_meta_table.to_string()}.meta_value\nFROM ${var_order_meta_table.to_string()}\n\t\t"
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_billing_address_table_to_order_query(var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
	return this.join_address_table_order_query(rt.new_string('billing'), var_order_table_alias_mutated.clone(), var_address_table_alias.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_shipping_address_table_to_order_query(var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
	return this.join_address_table_order_query(rt.new_string('shipping'), var_order_table_alias_mutated.clone(), var_address_table_alias.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_address_table_order_query(var_address_type rt.PhpVal, var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_table_alias_mutated := var_order_table_alias
	mut iife_temp_18 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}{}
	mut iife_result_18 := iife_temp_18.get_addresses_table_name()
	mut var_address_table := iife_result_18
	mut var_column_props_map := if rt.is_true(rt.identical(rt.new_string('billing'), var_address_type)) { this.billing_address_column_mapping } else { this.shipping_address_column_mapping }
	mut var_clauses := this.generate_select_and_join_clauses(var_order_table_alias_mutated.clone(), var_address_table.clone(), var_address_table_alias.clone(), var_column_props_map.clone())
	var_clauses.array_set('join', rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(var_clauses.array_get(rt.new_string('join')), rt.new_string(' AND ')), var_address_table_alias), rt.new_string('.address_type = %s')), var_address_type.clone()]))
	return rt.create_array([rt.ArrayItem{ key: 'select', val: var_clauses.array_get(rt.new_string('select')) }, rt.ArrayItem{ key: 'join', val: var_clauses.array_get(rt.new_string('join')) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_operational_data_table_to_order_query(var_order_table_alias rt.PhpVal, var_operational_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
	mut iife_temp_19 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}{}
	mut iife_result_19 := iife_temp_19.get_operational_data_table_name()
	mut var_operational_data_table := iife_result_19
	return this.generate_select_and_join_clauses(var_order_table_alias_mutated.clone(), var_operational_data_table.clone(), var_operational_table_alias.clone(), this.operational_data_column_mapping)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) generate_select_and_join_clauses(var_order_table_alias rt.PhpVal, var_table rt.PhpVal, var_table_alias rt.PhpVal, var_column_props_map rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
	mut var_table_alias_mutated := var_table_alias
	mut var_column_props_map_mutated := var_column_props_map
	mut var_select_clause := this.generate_select_clause_for_props(var_table_alias_mutated.clone(), var_column_props_map_mutated.clone())
	mut var_join_clause := rt.new_string("${var_table.to_string()} ${var_table_alias.to_string()} ON ${var_table_alias.to_string()}.order_id = ${var_order_table_alias.to_string()}.id")
	return rt.create_array([rt.ArrayItem{ key: 'select', val: var_select_clause }, rt.ArrayItem{ key: 'join', val: var_join_clause }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) generate_select_clause_for_props(var_table_alias rt.PhpVal, var_props rt.PhpVal) rt.PhpVal {
	mut var_table_alias_mutated := var_table_alias
	mut var_select_clauses := rt.new_array()
	mut iter_25 := var_props.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_prop_details := item_25.val
		mut var_column_name := item_25.key
		var_select_clauses.array_push(if var_prop_details.array_isset(rt.new_string('name')) { rt.concat(rt.concat(rt.concat(rt.concat(var_table_alias_mutated, rt.new_string('.')), var_column_name), rt.new_string(' as ')), var_prop_details.array_get(rt.new_string('name'))) } else { "${var_table_alias.to_string()}.${var_column_name.to_string()} as ${var_table_alias.to_string()}_${var_column_name.to_string()}" })
	}
	return rt.call_function('implode', [rt.new_string(', '), var_select_clauses.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_order_to_db(var_order rt.PhpVal, force_all_fields bool) {
	mut var_order_mutated := var_order
	mut var_context := rt.new_string((if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('absint', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]))) { 'create' } else { 'update' }).str())
	if rt.is_true(rt.identical(rt.new_string('create'), var_context)) {
		mut var_post_id := rt.new_int(this.maybe_create_backup_post(var_order_mutated.clone(), 'create'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Could not create order in posts table.'), rt.new_string('woocommerce')]))))
		}
		rt.call_method(var_order_mutated, 'set_id', [var_post_id.clone()])
	}
	mut var_only_changes := rt.new_bool(!(var_force_all_fields) && rt.is_true(rt.identical(rt.new_string('update'), var_context)))
	mut var_db_updates := this.get_db_rows_for_order(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), (var_context).str(), (var_only_changes).to_bool())
	mut iter_26 := var_db_updates.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_update := item_26.val
		rt.call_function('ksort', [var_update.array_get(rt.new_string('data'))])
		rt.call_function('ksort', [var_update.array_get(rt.new_string('format'))])
		mut var_result := this.persist_db_row(var_update.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not persist order to database table "%s".'), rt.new_string('woocommerce')]), var_update.array_get(rt.new_string('table'))])]))))
		}
	}
	mut var_changes := rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})
	this.update_address_index_meta(var_order_mutated.clone(), var_changes.clone())
	mut var_default_taxonomies := this.init_default_taxonomies(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.new_array()))
	this.set_custom_taxonomies(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_default_taxonomies))
	if rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{})) && rt.is_true(this.cogs_is_enabled()) {
		this.save_cogs_data(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated), rt.is_true(rt.new_bool(!(rt.is_true(var_only_changes)))) || rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('cogs_total_value')))))
	}
	this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) save_cogs_data(mut var_order Class_WC_Abstract_Order, cogs_value_changed bool) {
	mut var_order_mutated := var_order
	mut var_cogs_value_original := rt.call_method(var_order_mutated, 'get_cogs_total_value', []rt.PhpVal{})
	mut var_cogs_value := rt.call_function('apply_filters', [rt.new_string('woocommerce_save_order_cogs_value'), var_cogs_value_original.clone(), var_order_mutated])
	if rt.is_true(rt.identical(rt.new_null(), var_cogs_value)) {
		return
	}
	mut var_sync_meta := rt.new_bool(var_cogs_value_changed || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cogs_value_original, rt.new_float((var_cogs_value).to_f64()))))))
	if rt.is_true(var_sync_meta) {
		mut var_existing_meta := rt.call_method(this.data_store_meta, 'get_metadata_by_key', [var_order_mutated, rt.new_string('_cogs_total_value')])
		if rt.is_true(rt.identical(rt.new_float(0), var_cogs_value)) && rt.is_true(var_existing_meta) {
			var_existing_meta = rt.call_function('current', [var_existing_meta.clone()])
			rt.call_method(this.data_store_meta, 'delete_meta', [var_order_mutated, var_existing_meta.clone()])
		} else if rt.is_true(var_existing_meta) {
			var_existing_meta = rt.call_function('current', [var_existing_meta.clone()])
			rt.set_property(var_existing_meta, 'key', rt.new_string('_cogs_total_value'))
			rt.set_property(var_existing_meta, 'value', var_cogs_value.clone())
			rt.call_method(this.data_store_meta, 'update_meta', [var_order_mutated, var_existing_meta.clone()])
		} else {
			mut var_meta := create_automattic_woocommerce_internal_datastores_orders_wc_meta_data()
			rt.set_property(var_meta, 'key', rt.new_string('_cogs_total_value'))
			rt.set_property(var_meta, 'value', var_cogs_value.clone())
			rt.call_method(this.data_store_meta, 'add_meta', [var_order_mutated, var_meta])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_create_backup_post(var_order rt.PhpVal, context string) i64 {
	mut var_order_mutated := var_order
	mut context_mutated := context
	mut var_data_sync := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'post_type', val: if rt.is_true(rt.call_method(var_data_sync, 'data_sync_is_enabled', []rt.PhpVal{})) { rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2218,"name":"data_sync"}.placeholder_order_post_type() } }, rt.ArrayItem{ key: 'post_status', val: 'draft' }, rt.ArrayItem{ key: 'post_parent', val: if !(rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{}).array_get(rt.new_string('parent_id'))).is_null() { rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{}).array_get(rt.new_string('parent_id')) } else { if !(rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}).array_get(rt.new_string('parent_id'))).is_null() { rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}).array_get(rt.new_string('parent_id')) } else { rt.new_int(0) } } }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) }])
	if rt.is_true(rt.identical(rt.new_string('backfill'), rt.new_string(context_mutated))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))))) {
			return 0
		}
		var_data.array_set('import_id', rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	}
	return (rt.call_function('wp_insert_post', [var_data.clone()])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init_default_taxonomies(mut var_order Class_WC_Abstract_Order, mut var_sanitized_tax_input Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_sanitized_tax_input_mutated := var_sanitized_tax_input
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}))) {
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_sanitized_tax_input_mutated)
	}
	mut iter_27 := rt.call_function('get_object_taxonomies', [rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}), rt.new_string('object')]).iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_tax_object := item_27.val
		mut var_taxonomy := item_27.key
		if !rt.is_true(rt.get_property(var_tax_object, 'default_term')) {
			return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_sanitized_tax_input_mutated)
		}
		if var_sanitized_tax_input_mutated.array_isset(var_taxonomy) && var_sanitized_tax_input_mutated.array_get(var_taxonomy).is_array() {
			var_sanitized_tax_input_mutated.array_set(var_taxonomy, rt.call_function('array_filter', [var_sanitized_tax_input_mutated.array_get(var_taxonomy)]))
		}
		mut var_terms := rt.call_function('wp_get_object_terms', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_taxonomy.clone(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
		if !(!rt.is_true(var_terms)) && !rt.is_true(var_sanitized_tax_input_mutated.array_get(var_taxonomy)) {
			var_sanitized_tax_input_mutated.array_set(var_taxonomy, var_terms.clone())
		}
		if !rt.is_true(var_sanitized_tax_input_mutated.array_get(var_taxonomy)) {
			mut var_default_term_id := rt.call_function('get_option', [rt.new_string('default_term_' + (var_taxonomy).str())])
			if !(!rt.is_true(var_default_term_id)) {
				var_sanitized_tax_input_mutated.array_set(var_taxonomy, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int((var_default_term_id).to_i64()) }]))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_sanitized_tax_input_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_custom_taxonomies(mut var_order Class_WC_Abstract_Order, mut var_sanitized_tax_input Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_order_mutated := var_order
	mut var_sanitized_tax_input_mutated := var_sanitized_tax_input
	if !rt.is_true(var_sanitized_tax_input_mutated) {
		return
	}
	mut iter_28 := var_sanitized_tax_input_mutated.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_tags := item_28.val
		mut var_taxonomy := item_28.key
		mut var_taxonomy_obj := rt.call_function('get_taxonomy', [var_taxonomy.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_obj)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid taxonomy: %s.'), rt.new_string('woocommerce')]), var_taxonomy.clone()])]), rt.new_string('7.9.0')])
			continue
		}
		if rt.is_true(rt.new_bool(var_tags.clone().is_array())) {
		var_tags = rt.call_function('array_filter', [var_tags.clone()])
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_obj, 'cap'), 'assign_terms')])) {
			rt.call_function('wp_set_post_terms', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_tags.clone(), var_taxonomy.clone()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_db_rows_for_order(mut var_order Class_WC_Abstract_Order, context string, only_changes bool) rt.PhpVal {
	mut var_order_mutated := var_order
	mut context_mutated := context
	mut only_changes_mutated := only_changes
	mut var_result := rt.new_array()
	mut var_row := this.get_db_row_from_order(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), this.order_column_mapping, only_changes_mutated)
	if rt.is_true(rt.identical(rt.new_string('create'), rt.new_string(context_mutated))) && rt.is_true(rt.new_bool(!(rt.is_true(var_row)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('No data for new record.'))))
	}
	if rt.is_true(var_row) {
		var_result.array_push(rt.create_array([rt.ArrayItem{ key: 'table', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name() }, rt.ArrayItem{ key: 'data', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('data')), rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{}) }])]) }, rt.ArrayItem{ key: 'format', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('format')), rt.create_array([rt.ArrayItem{ key: 'id', val: '%d' }, rt.ArrayItem{ key: 'type', val: '%s' }])]) }]))
	}
	var_row = this.get_db_row_from_order(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), this.operational_data_column_mapping, only_changes_mutated)
	if rt.is_true(var_row) {
		var_result.array_push(rt.create_array([rt.ArrayItem{ key: 'table', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name() }, rt.ArrayItem{ key: 'data', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('data')), rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])]) }, rt.ArrayItem{ key: 'format', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('format')), rt.create_array([rt.ArrayItem{ key: 'order_id', val: '%d' }])]) }]))
	}
	mut iter_29 := rt.create_array([rt.ArrayItem{ key: none, val: 'billing' }, rt.ArrayItem{ key: none, val: 'shipping' }]).iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_address_type := item_29.val
		var_row = this.get_db_row_from_order(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this), '{"nodeType":"Expr_BinaryOp_Concat","line":2364,"left":{"nodeType":"Expr_Variable","line":2364,"name":"address_type"},"right":{"nodeType":"Scalar_String","line":2364,"value":"_address_column_mapping"}}'), only_changes_mutated)
		if rt.is_true(var_row) {
			var_result.array_push(rt.create_array([rt.ArrayItem{ key: 'table', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_addresses_table_name() }, rt.ArrayItem{ key: 'data', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('data')), rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'address_type', val: var_address_type }])]) }, rt.ArrayItem{ key: 'format', val: rt.call_function('array_merge', [var_row.array_get(rt.new_string('format')), rt.create_array([rt.ArrayItem{ key: 'order_id', val: '%d' }, rt.ArrayItem{ key: 'address_type', val: '%s' }])]) }, rt.ArrayItem{ key: 'where', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'address_type', val: var_address_type }]) }, rt.ArrayItem{ key: 'where_format', val: rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }]) }]))
		}
	}
	mut var_ext_rows := rt.call_function('apply_filters', [rt.new_string('woocommerce_orders_table_datastore_extra_db_rows_for_order'), rt.new_array(), var_order_mutated, rt.new_string(context_mutated).clone()])
	var_result = rt.call_function('apply_filters', [rt.new_string('woocommerce_orders_table_datastore_db_rows_for_order'), rt.call_function('array_merge', [var_result.clone(), var_ext_rows.clone()]), var_order_mutated, rt.new_string(context_mutated).clone()])
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_db_row_from_order(var_order rt.PhpVal, var_column_mapping rt.PhpVal, only_changes bool) rt.PhpVal {
	mut var_order_mutated := var_order
	mut only_changes_mutated := only_changes
	mut var_changes := if rt.is_true(rt.new_bool(only_changes_mutated)) { rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{}) } else { rt.call_function('array_merge', [rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}), rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})]) }
	if rt.is_true(rt.new_bool(var_column_mapping.clone().array_isset(rt.new_string('status')))) && rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('status')))) {
		var_changes.array_set('status', this.get_post_status(var_order_mutated.clone()))
	}
	mut var_row := rt.new_array()
	mut var_row_format := rt.new_array()
	mut iter_30 := var_column_mapping.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_details := item_30.val
		mut var_column := item_30.key
		if !(var_details.array_isset(rt.new_string('name'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_changes.clone().array_isset(var_details.array_get(rt.new_string('name')))))))) {
			continue
		}
		var_row.array_set(var_column, rt.call_method(this.database_util, 'format_object_value_for_db', [var_changes.array_get(var_details.array_get(rt.new_string('name'))), var_details.array_get(rt.new_string('type'))]))
		var_row_format.array_set(var_column, rt.call_method(this.database_util, 'get_wpdb_format_for_type', [var_details.array_get(rt.new_string('type'))]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_row)))) {
		return rt.new_bool(false)
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_row }, rt.ArrayItem{ key: 'format', val: var_row_format }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete(var_order rt.PhpVal, var_args rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_args_mutated := var_args
	mut var_order_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false }, rt.ArrayItem{ key: 'suppress_filters', val: false }])])
	mut var_do_filters := rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('suppress_filters')))))
	if rt.is_true(var_args_mutated.array_get(rt.new_string('force_delete'))) {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_before_delete_order'), var_order_id.clone(), var_order_mutated.clone()])
		}
		this.upshift_or_delete_child_orders(var_order_mutated.clone())
		this.delete_order_data_from_custom_order_tables(var_order_id.clone())
		this.delete_items(var_order_mutated.clone())
		rt.call_method(var_order_mutated, 'set_id', [rt.new_int(0)])
		mut var_orders_table_is_authoritative := rt.identical(rt.call_method(rt.call_method(var_order_mutated, 'get_data_store', []rt.PhpVal{}), 'get_current_class_name', []rt.PhpVal{}), Class_Automattic_WooCommerce_Internal_DataStores_Orders_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.class())
		if rt.is_true(var_orders_table_is_authoritative) {
			mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
			if rt.is_true(rt.call_method(var_data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) {
				rt.call_function('wp_delete_post', [var_order_id.clone()])
			} else {
				this.handle_order_deletion_with_sync_disabled(var_order_id.clone())
			}
		}
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_delete_order'), var_order_id.clone()])
		}
	} else {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_before_trash_order'), var_order_id.clone(), var_order_mutated.clone()])
		}
		this.trash_order(var_order_mutated.clone())
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_trash_order'), var_order_id.clone()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) handle_order_deletion_with_sync_disabled(var_order_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
	mut var_post_type := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_type FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID=%d')), var_order_id_mutated.clone()])])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), var_post_type)) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID=%d OR post_parent=%d')), var_order_id_mutated.clone(), var_order_id_mutated.clone()])])
		rt.call_function('clean_post_cache', [var_order_id_mutated.clone()])
	} else {
		rt.call_method(var_wpdb, 'insert', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name(), rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id_mutated }, rt.ArrayItem{ key: 'meta_key', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_record_meta_key() }, rt.ArrayItem{ key: 'meta_value', val: Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.deleted_from_orders_meta_value() }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) upshift_or_delete_child_orders(var_order rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	mut var_order_table := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
	mut var_order_parent_id := rt.call_method(var_order_mutated, 'get_parent_id', []rt.PhpVal{})
	mut var_child_order_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT id FROM ${var_order_table.to_string()} WHERE parent_order_id=%d"), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])
	if !rt.is_true(var_child_order_ids) {
		return
	}
	if rt.is_true(rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('is_post_type_hierarchical'), rt.call_method(var_order_mutated, 'get_type', []rt.PhpVal{})])) {
		rt.call_method(var_wpdb, 'update', [var_order_table.clone(), rt.create_array([rt.ArrayItem{ key: 'parent_order_id', val: var_order_parent_id }]), rt.create_array([rt.ArrayItem{ key: 'parent_order_id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
		this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_child_order_ids))
	} else {
		mut iter_31 := var_child_order_ids.iterator()
		for {
			item_31 := iter_31.next() or { break }
			mut var_child_order_id := item_31.val
			mut var_child_order := rt.call_function('wc_get_order', [var_child_order_id.clone()])
			if rt.is_true(var_child_order) {
				rt.call_method(var_child_order, 'delete', [rt.new_bool(true)])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) trash_order(var_order rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')]))) {
		return
	}
	mut var_trash_metadata := rt.create_array([rt.ArrayItem{ key: '_wp_trash_meta_status', val: 'wc-' + (rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])).str() }, rt.ArrayItem{ key: '_wp_trash_meta_time', val: rt.call_function('time', []rt.PhpVal{}) }])
	rt.call_method(var_wpdb, 'update', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name(), rt.create_array([rt.ArrayItem{ key: 'status', val: 'trash' }, rt.ArrayItem{ key: 'date_updated_gmt', val: rt.call_function('current_time', [rt.new_string('Y-m-d H:i:s'), rt.new_bool(true)]) }]), rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
	rt.call_method(var_order_mutated, 'set_status', [rt.new_string('trash')])
	mut iter_32 := var_trash_metadata.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_meta_value := item_32.val
		mut var_meta_key := item_32.key
		this.add_meta(var_order_mutated.clone(), rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'key', val: var_meta_key }, rt.ArrayItem{ key: 'value', val: var_meta_value }]))))
	}
	mut var_data_synchronizer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	if rt.is_true(rt.call_method(var_data_synchronizer, 'data_sync_is_enabled', []rt.PhpVal{})) {
		rt.call_function('wp_trash_post', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	}
	this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) untrash_order(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
	mut var_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	mut var_status := rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), var_status)))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order %1$d cannot be restored from the trash: it has already been restored to status "%2$s".'), rt.new_string('woocommerce')]), var_id.clone(), var_status.clone()])])
		return false
	}
	mut var_previous_status := rt.call_method(var_order_mutated, 'get_meta', [rt.new_string('_wp_trash_meta_status')])
	mut var_valid_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut var_previous_state_is_invalid := rt.new_bool(!(rt.is_true(rt.new_bool(var_valid_statuses.clone().array_isset(var_previous_status.clone())))))
	mut var_pending_is_valid_status := rt.new_bool(var_valid_statuses.clone().array_isset(Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending()))
	if rt.is_true(var_previous_state_is_invalid) && rt.is_true(var_pending_is_valid_status) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The previous status of order %1$d ("%2$s") is invalid. It has been restored to "pending" status instead.'), rt.new_string('woocommerce')]), var_id.clone(), var_previous_status.clone()])])
	var_previous_status = rt.new_string('pending')
	} else if rt.is_true(var_previous_state_is_invalid) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The previous status of order %1$d ("%2$s") is invalid. It could not be restored.'), rt.new_string('woocommerce')]), var_id.clone(), var_previous_status.clone()])])
		return false
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_untrash_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_previous_status.clone()])
	rt.call_method(var_order_mutated, 'set_status', [var_previous_status.clone()])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	if rt.is_true(rt.identical('wc-' + (rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{})).str(), var_previous_status)) {
		rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_wp_trash_meta_status')])
		rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_wp_trash_meta_time')])
		rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_wp_trash_meta_comments_status')])
		rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
		return true
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Something went wrong when trying to restore order %d from the trash. It could not be restored.'), rt.new_string('woocommerce')]), var_id.clone()])])
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete_order_data_from_custom_order_tables(var_order_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
	mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
	mut iter_33 := this.get_all_table_names().iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_table := item_33.val
		rt.call_method(var_wpdb, 'delete', [var_table.clone(), if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name(), var_table)) { rt.create_array([rt.ArrayItem{ key: 'id', val: var_order_id_mutated }]) } else { rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id_mutated }]) }, rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
		rt.call_method(var_order_cache, 'remove', [var_order_id_mutated.clone()])
	}
	this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: var_order_id_mutated }])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) create(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{}))) {
		rt.call_method(var_order_mutated, 'set_order_key', [rt.call_function('wc_generate_order_key', []rt.PhpVal{})])
	}
	this.persist_save(var_order_mutated.clone(), false, false)
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')]), rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' }, rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'checkout-draft' }]), rt.new_bool(true)])) {
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_save(var_order rt.PhpVal, force_all_fields bool, backfill bool) {
	mut var_order_mutated := var_order
	mut iife_temp_20 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_20 := iife_temp_20.get_constant(rt.new_string('WC_VERSION'))
	rt.call_method(var_order_mutated, 'set_version', [iife_result_20])
	rt.call_method(var_order_mutated, 'set_currency', [if rt.is_true(rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{})) { rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{}) } else { rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')]))))) {
		rt.call_method(var_order_mutated, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_modified', [rt.new_string('edit')]))))) {
		rt.call_method(var_order_mutated, 'set_date_modified', [rt.call_function('current_time', [rt.new_string('mysql')])])
	}
	this.persist_order_to_db(var_order_mutated.clone(), force_all_fields)
	this.update_order_meta(var_order_mutated.clone())
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_order_mutated, 'apply_changes', []rt.PhpVal{})
	if var_backfill {
		rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
		mut var_r_order := rt.call_function('wc_get_order', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
		this.maybe_backfill_post_record(var_r_order.clone())
		rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])]))
	}
	this.clear_caches(var_order_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iife_temp_21 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_21 := iife_temp_21.get_value_or_default(rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}), rt.new_string('status'), rt.new_string('new'))
	mut var_previous_status := iife_result_21
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_paid', [rt.new_string('edit')]))))) && rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order_mutated, 'get_version', [rt.new_string('edit')]), rt.new_string('3.0'), rt.new_string('<')])) && rt.is_true(rt.call_method(var_order_mutated, 'has_status', [rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), rt.new_string((if rt.is_true(rt.call_method(var_order_mutated, 'needs_processing', []rt.PhpVal{})) { 'processing' } else { 'completed' }).str()), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.clone()])])) {
		rt.call_method(var_order_mutated, 'set_date_paid', [rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')])])
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')]))) {
		rt.call_method(var_order_mutated, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut iife_temp_22 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_22 := iife_temp_22.get_constant(rt.new_string('WC_VERSION'))
	rt.call_method(var_order_mutated, 'set_version', [iife_result_22])
	mut var_changes := rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})
	mut var_should_backfill := rt.new_bool(!(rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'sync_on_read_order_ids').array_isset(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))))
	this.persist_updates(var_order_mutated.clone(), (var_should_backfill).to_bool())
	if rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('billing_email')))) || rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('customer_id')))) {
		mut iife_temp_23 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store{}
		mut iife_result_23 := iife_temp_23.load(rt.new_string('customer-download'))
		mut var_data_store := iife_result_23
		rt.call_method(var_data_store, 'update_user_by_order_id', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}), rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})])
	}
	if rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('customer_id')))) {
		rt.call_function('wc_update_user_last_active', [rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})])
	}
	rt.call_method(var_order_mutated, 'apply_changes', []rt.PhpVal{})
	this.clear_caches(var_order_mutated.clone())
	mut var_draft_statuses := rt.create_array([rt.ArrayItem{ key: none, val: 'new' }, rt.ArrayItem{ key: none, val: 'auto-draft' }, rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'checkout-draft' }])
	if !(!rt.is_true(var_changes.array_get(rt.new_string('status')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_changes.array_get(rt.new_string('status')), var_previous_status)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_changes.array_get(rt.new_string('status')), var_draft_statuses.clone(), rt.new_bool(true)]))))) && rt.is_true(rt.call_function('in_array', [var_previous_status.clone(), var_draft_statuses.clone(), rt.new_bool(true)])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_new_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.clone()])
		return
	}
	if (!(!rt.is_true(var_changes.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('in_array', [rt.new_string('trash'), rt.create_array([rt.ArrayItem{ key: none, val: var_changes.array_get(rt.new_string('status')) }, rt.ArrayItem{ key: none, val: var_previous_status }]), rt.new_bool(true)]))) || (!(!rt.is_true(var_changes)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_diff_key', [var_changes.clone(), rt.call_function('array_flip', [rt.call_method(this.get_post_data_store_for_backfill(), 'get_internal_data_store_key_getters', []rt.PhpVal{})])])))))) {
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_post_meta(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	this.update_order_meta(var_order_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_updates(var_order rt.PhpVal, backfill bool) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_changes := rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})
	if !(var_changes.array_isset(rt.new_string('date_modified'))) {
		rt.call_method(var_order_mutated, 'set_date_modified', [rt.call_function('current_time', [rt.new_string('mysql')])])
	}
	this.persist_order_to_db(var_order_mutated.clone(), false)
	this.update_order_meta(var_order_mutated.clone())
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	if var_backfill {
		rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
		this.clear_caches(var_order_mutated.clone())
		mut var_r_order := rt.call_function('wc_get_order', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
		this.maybe_backfill_post_record(var_r_order.clone())
		rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])]))
	}
	return var_changes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_backfill_post_record() rt.PhpVal {
	mut var_data_sync := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	return rt.call_method(var_data_sync, 'data_sync_is_enabled', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_backfill_post_record(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(this.should_backfill_post_record()) {
		this.backfill_post_record(var_order_mutated.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_order_meta(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_changes := rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})
	this.update_address_index_meta(var_order_mutated.clone(), var_changes.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_address_index_meta(var_order rt.PhpVal, var_changes rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_changes_mutated := var_changes
	mut iter_34 := rt.create_array([rt.ArrayItem{ key: none, val: 'billing' }, rt.ArrayItem{ key: none, val: 'shipping' }]).iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_address_type := item_34.val
		mut var_index_meta_key := rt.new_string("_${var_address_type.to_string()}_address_index")
		if var_changes_mutated.array_isset(var_address_type) || (rt.is_true(rt.call_function('is_a', [var_order_mutated.clone(), rt.new_string('WC_Order')])) && !rt.is_true(rt.call_method(var_order_mutated, 'get_meta', [var_index_meta_key.clone()]))) {
			rt.call_method(var_order_mutated, 'update_meta_data', [var_index_meta_key.clone(), rt.call_function('implode', [rt.new_string(' '), rt.call_method(var_order_mutated, 'get_address', [var_address_type.clone()])])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_coupon_held_keys(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_held_keys := rt.call_method(var_order_mutated, 'get_meta', [rt.new_string('_coupon_held_keys')])
	if rt.is_true(var_coupon_id) {
		return if var_held_keys.array_isset(var_coupon_id) { var_held_keys.array_get(var_coupon_id) } else { rt.new_null() }
	}
	return var_held_keys.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_coupon_held_keys_for_users(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_held_keys_for_user := rt.call_method(var_order_mutated, 'get_meta', [rt.new_string('_coupon_held_keys_for_users')])
	if rt.is_true(var_coupon_id) {
		return if var_held_keys_for_user.array_isset(var_coupon_id) { var_held_keys_for_user.array_get(var_coupon_id) } else { rt.new_null() }
	}
	return var_held_keys_for_user.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_coupon_held_keys(var_order rt.PhpVal, var_held_keys rt.PhpVal, var_held_keys_for_user rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_held_keys_mutated := var_held_keys
	mut var_held_keys_for_user_mutated := var_held_keys_for_user
	if var_held_keys_mutated.clone().is_array() && 0 < var_held_keys_mutated.clone().array_count() {
		rt.call_method(var_order_mutated, 'update_meta_data', [rt.new_string('_coupon_held_keys'), var_held_keys_mutated.clone()])
	}
	if var_held_keys_for_user_mutated.clone().is_array() && 0 < var_held_keys_for_user_mutated.clone().array_count() {
		rt.call_method(var_order_mutated, 'update_meta_data', [rt.new_string('_coupon_held_keys_for_users'), var_held_keys_for_user_mutated.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) release_held_coupons(var_order rt.PhpVal, save bool) {
	mut var_order_mutated := var_order
	mut var_coupon_held_keys := this.get_coupon_held_keys(var_order_mutated.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(var_coupon_held_keys.clone().is_array())) {
		mut iter_35 := var_coupon_held_keys.iterator()
		for {
			item_35 := iter_35.next() or { break }
			mut var_meta_key := item_35.val
			mut var_coupon_id := item_35.key
			mut var_coupon := create_automattic_woocommerce_internal_datastores_orders_wc_coupon(var_coupon_id.clone())
			var_coupon.delete_meta_data(var_meta_key.clone())
			var_coupon.save_meta_data()
		}
	}
	rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_coupon_held_keys')])
	mut var_coupon_held_keys_for_users := this.get_coupon_held_keys_for_users(var_order_mutated.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(var_coupon_held_keys_for_users.clone().is_array())) {
		mut iter_36 := var_coupon_held_keys_for_users.iterator()
		for {
			item_36 := iter_36.next() or { break }
			mut var_meta_key := item_36.val
			mut var_coupon_id := item_36.key
			mut var_coupon := create_automattic_woocommerce_internal_datastores_orders_wc_coupon(var_coupon_id.clone())
			var_coupon.delete_meta_data(var_meta_key.clone())
			var_coupon.save_meta_data()
		}
	}
	rt.call_method(var_order_mutated, 'delete_meta_data', [rt.new_string('_coupon_held_keys_for_users')])
	if var_save {
		rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	if !(var_query_vars_mutated.array_isset(rt.new_string('paginate'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate')))))) {
		var_query_vars_mutated.array_set('no_found_rows', true)
	}
	if var_query_vars_mutated.array_isset(rt.new_string('anonymized')) {
		var_query_vars_mutated.array_set('meta_query', if !(var_query_vars_mutated.array_get(rt.new_string('meta_query'))).is_null() { var_query_vars_mutated.array_get(rt.new_string('meta_query')) } else { rt.new_array() })
		if rt.is_true(var_query_vars_mutated.array_get(rt.new_string('anonymized'))) {
			var_query_vars_mutated.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_anonymized' }, rt.ArrayItem{ key: 'value', val: 'yes' }]))
		} else {
			var_query_vars_mutated.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_anonymized' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]))
		}
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('fulfillment_status')))) {
		mut iife_temp_24 := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_24 := iife_temp_24.get_order_fulfillment_status_meta_query(var_query_vars_mutated.array_get(rt.new_string('fulfillment_status')))
		var_query_vars_mutated.array_get_mut('meta_query').array_push(iife_result_24)
	}
	var_query_vars_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_orders_table_datastore_get_orders_query'), var_query_vars_mutated.clone(), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this)])
	mut var_query := create_automattic_woocommerce_internal_datastores_orders_orderstablequery(var_query_vars_mutated.clone())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		var_query = rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'orders', val: rt.new_array() }, rt.ArrayItem{ key: 'found_orders', val: 0 }, rt.ArrayItem{ key: 'max_num_pages', val: 0 }]))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	if var_query_vars_mutated.array_isset(rt.new_string('return')) && rt.is_true(rt.identical(rt.new_string('ids'), var_query_vars_mutated.array_get(rt.new_string('return')))) {
	mut var_orders := rt.get_property(var_query, 'orders')
	} else {
		var_orders = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'order_factory'), 'get_orders', [rt.get_property(var_query, 'orders')])
		this.prime_caches_for_orders(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.get_property(var_query, 'orders')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](var_query_vars_mutated))
	}
	if var_query_vars_mutated.array_isset(rt.new_string('paginate')) && rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate'))) {
		return mut rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'orders', val: var_orders }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_query, 'found_orders') }, rt.ArrayItem{ key: 'max_num_pages', val: rt.get_property(var_query, 'max_num_pages') }]))
	}
	return mut rt.cast_object_ptr[Class_stdClass](var_orders)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) prime_caches_for_orders(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_query_vars Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
	this.prime_order_item_caches_for_orders(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_order_ids_mutated), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_query_vars_mutated))
	mut var_order_type := if !(var_query_vars_mutated.array_get(rt.new_string('type'))).is_null() { var_query_vars_mutated.array_get(rt.new_string('type')) } else { if !(var_query_vars_mutated.array_get(rt.new_string('post_type'))).is_null() { var_query_vars_mutated.array_get(rt.new_string('post_type')) } else { rt.new_string('') } }
	var_order_type = if var_order_type.clone().is_array() { var_order_type } else { rt.create_array([rt.ArrayItem{ key: none, val: var_order_type }]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('shop_order'), var_order_type.clone(), rt.new_bool(true)]))))) {
		return
	}
	this.prime_refund_caches_for_orders(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_order_ids_mutated), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_query_vars_mutated))
	this.prime_refund_total_caches_for_orders(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_order_ids_mutated), rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_array', []string{}, var_query_vars_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_orders_batch_join_clause(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_id_list := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('absint'), var_order_ids_mutated])])
	return (rt.call_method(var_wpdb, 'prepare', [rt.new_string("%i AS refunds ON ( refunds.type = %s AND refunds.parent_order_id IN ( ${var_id_list.to_string()} ) )"), Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name(), rt.new_string('shop_order_refund')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_parent_column() string {
	return 'refunds.parent_order_id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_batch_refund_totals(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_id_list := rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('absint'), var_order_ids_mutated])])
	mut var_refund_totals := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT parent_order_id AS order_id, SUM( total_amount ) AS total\n\t\t\t\tFROM %i\n\t\t\t\tWHERE type = 'shop_order_refund' AND parent_order_id IN ( ${var_id_list.to_string()} )\n\t\t\t\tGROUP BY parent_order_id"), Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()])])
	mut var_totals_by_order := rt.new_array()
	mut iter_37 := var_refund_totals.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_row := item_37.val
		var_totals_by_order.array_set(rt.get_property(var_row, 'order_id'), -1 * rt.get_property(var_row, 'total').to_f64())
	}
	return var_totals_by_order.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_database_schema() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_collate := if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [rt.new_string('collation')])) { rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_orders_table_name := rt.new_string(this.get_orders_table_name())
	mut var_addresses_table_name := rt.new_string(this.get_addresses_table_name())
	mut var_operational_data_table_name := rt.new_string(this.get_operational_data_table_name())
	mut var_meta_table := rt.new_string(this.get_meta_table_name())
	mut var_max_index_length := rt.call_method(this.database_util, 'get_max_index_length', []rt.PhpVal{})
	mut var_composite_meta_value_index_length := rt.call_function('max', [rt.sub(rt.sub(rt.sub(var_max_index_length, rt.new_int(8)), rt.new_int(100)), rt.new_int(1)), rt.new_int(20)])
	mut var_composite_customer_id_email_length := rt.call_function('max', [rt.sub(var_max_index_length, rt.new_int(20)), rt.new_int(20)])
	mut var_sql := rt.new_string("\nCREATE TABLE ${var_orders_table_name.to_string()} (\n\tid bigint(20) unsigned,\n\tstatus varchar(20) null,\n\tcurrency varchar(10) null,\n\ttype varchar(20) null,\n\ttax_amount decimal(26,8) null,\n\ttotal_amount decimal(26,8) null,\n\tcustomer_id bigint(20) unsigned null,\n\tbilling_email varchar(320) null,\n\tdate_created_gmt datetime null,\n\tdate_updated_gmt datetime null,\n\tparent_order_id bigint(20) unsigned null,\n\tpayment_method varchar(100) null,\n\tpayment_method_title text null,\n\ttransaction_id varchar(100) null,\n\tip_address varchar(100) null,\n\tuser_agent text null,\n\tcustomer_note text null,\n\tPRIMARY KEY (id),\n\tKEY status (status),\n\tKEY date_created (date_created_gmt),\n\tKEY customer_id_billing_email (customer_id, billing_email(${var_composite_customer_id_email_length.to_string()})),\n\tKEY customer_id_status (customer_id, status),\n\tKEY billing_email (billing_email(${var_max_index_length.to_string()})),\n\tKEY transaction_id (transaction_id(20)),\n\tKEY type_status_date (type, status, date_created_gmt),\n\tKEY parent_order_id (parent_order_id),\n\tKEY date_updated (date_updated_gmt)\n) ${var_collate.to_string()};\nCREATE TABLE ${var_addresses_table_name.to_string()} (\n\tid bigint(20) unsigned auto_increment primary key,\n\torder_id bigint(20) unsigned NOT NULL,\n\taddress_type varchar(20) null,\n\tfirst_name text null,\n\tlast_name text null,\n\tcompany text null,\n\taddress_1 text null,\n\taddress_2 text null,\n\tcity text null,\n\tstate text null,\n\tpostcode text null,\n\tcountry text null,\n\temail varchar(320) null,\n\tphone varchar(100) null,\n\tKEY order_id (order_id),\n\tUNIQUE KEY address_type_order_id (address_type, order_id),\n\tKEY email (email(${var_max_index_length.to_string()})),\n\tKEY phone (phone)\n) ${var_collate.to_string()};\nCREATE TABLE ${var_operational_data_table_name.to_string()} (\n\tid bigint(20) unsigned auto_increment primary key,\n\torder_id bigint(20) unsigned NULL,\n\tcreated_via varchar(100) NULL,\n\twoocommerce_version varchar(20) NULL,\n\tprices_include_tax tinyint(1) NULL,\n\tcoupon_usages_are_counted tinyint(1) NULL,\n\tdownload_permission_granted tinyint(1) NULL,\n\tcart_hash varchar(100) NULL,\n\tnew_order_email_sent tinyint(1) NULL,\n\torder_key varchar(100) NULL,\n\torder_stock_reduced tinyint(1) NULL,\n\tdate_paid_gmt datetime NULL,\n\tdate_completed_gmt datetime NULL,\n\tshipping_tax_amount decimal(26,8) NULL,\n\tshipping_total_amount decimal(26,8) NULL,\n\tdiscount_tax_amount decimal(26,8) NULL,\n\tdiscount_total_amount decimal(26,8) NULL,\n\trecorded_sales tinyint(1) NULL,\n\tUNIQUE KEY order_id (order_id),\n\tKEY order_key (order_key)\n) ${var_collate.to_string()};\nCREATE TABLE ${var_meta_table.to_string()} (\n\tid bigint(20) unsigned auto_increment primary key,\n\torder_id bigint(20) unsigned null,\n\tmeta_key varchar(255),\n\tmeta_value text null,\n\tKEY meta_key_value (meta_key(50), meta_value(20)),\n\tKEY order_id_meta_key_meta_value (order_id, meta_key(100), meta_value(${var_composite_meta_value_index_length.to_string()}))\n) ${var_collate.to_string()};\n")
	return var_sql.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_meta(var_object rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data := rt.call_method(this.data_store_meta, 'read_meta', [var_object.clone()])
	return this.filter_raw_meta_data(var_object.clone(), var_raw_meta_data.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_meta_mutated := var_meta
	if rt.is_true(this.should_backfill_post_record()) && !(rt.get_property(var_meta_mutated, 'id')).is_null() {
		mut var_db_meta := rt.call_method(this.data_store_meta, 'get_metadata_by_id', [rt.get_property(var_meta_mutated, 'id')])
		if rt.is_true(var_db_meta) {
			rt.set_property(var_meta_mutated, 'key', rt.get_property(var_db_meta, 'meta_key'))
			rt.set_property(var_meta_mutated, 'value', rt.get_property(var_db_meta, 'meta_value'))
		}
	}
	mut var_delete_meta := rt.call_method(this.data_store_meta, 'delete_meta', [var_object.clone(), var_meta_mutated.clone()])
	mut var_changes_applied := rt.new_bool(this.after_meta_change(var_object.clone(), var_meta_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changes_applied)))) && rt.is_true(rt.new_bool(rt.instance_of(var_object, 'WC_Abstract_Order'))) && rt.is_true(this.should_backfill_post_record()) && !(rt.get_property(var_meta_mutated, 'key')).is_null() {
		rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
		if rt.get_property(var_meta_mutated, 'value').is_object() && rt.is_true(rt.identical(rt.new_string('__PHP_Incomplete_Class'), rt.call_function('get_class', [rt.get_property(var_meta_mutated, 'value')]))) {
			mut var_meta_value := rt.call_function('maybe_serialize', [rt.get_property(var_meta_mutated, 'value')])
			rt.call_method(var_wpdb, 'delete', [rt.call_function('_get_meta_table', [rt.new_string('post')]), rt.create_array([rt.ArrayItem{ key: 'post_id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta_mutated, 'key') }, rt.ArrayItem{ key: 'meta_value', val: var_meta_value }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
			rt.call_function('wp_cache_delete', [rt.call_method(var_object, 'get_id', []rt.PhpVal{}), rt.new_string('post_meta')])
			mut var_logger := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [rt.new_string('wc_get_logger')])
			rt.call_method(var_logger, 'warning', [rt.call_function('sprintf', [rt.new_string('encountered an order meta value of type __PHP_Incomplete_Class during `delete_meta` in order with ID %d: "%s"'), rt.call_method(var_object, 'get_id', []rt.PhpVal{}), rt.call_function('var_export', [var_meta_value.clone(), rt.new_bool(true)])])])
		} else {
			rt.call_function('delete_post_meta', [rt.call_method(var_object, 'get_id', []rt.PhpVal{}), rt.get_property(var_meta_mutated, 'key'), rt.get_property(var_meta_mutated, 'value')])
		}
		rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])]))
	}
	return var_delete_meta.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) add_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_meta_mutated := var_meta
	mut var_add_meta := rt.call_method(this.data_store_meta, 'add_meta', [var_object.clone(), var_meta_mutated.clone()])
	rt.set_property(var_meta_mutated, 'id', var_add_meta.clone())
	mut var_changes_applied := rt.new_bool(this.after_meta_change(var_object.clone(), var_meta_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changes_applied)))) && rt.is_true(rt.new_bool(rt.instance_of(var_object, 'WC_Abstract_Order'))) && rt.is_true(this.should_backfill_post_record()) {
		rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
		rt.call_function('add_post_meta', [rt.call_method(var_object, 'get_id', []rt.PhpVal{}), rt.get_property(var_meta_mutated, 'key'), rt.get_property(var_meta_mutated, 'value')])
		rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])]))
	}
	return var_add_meta.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_meta_mutated := var_meta
	mut var_update_meta := rt.call_method(this.data_store_meta, 'update_meta', [var_object.clone(), var_meta_mutated.clone()])
	mut var_changes_applied := rt.new_bool(this.after_meta_change(var_object.clone(), var_meta_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changes_applied)))) && rt.is_true(rt.new_bool(rt.instance_of(var_object, 'WC_Abstract_Order'))) && rt.is_true(this.should_backfill_post_record()) {
		rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids').array_push(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
		rt.call_function('update_post_meta', [rt.call_method(var_object, 'get_id', []rt.PhpVal{}), rt.get_property(var_meta_mutated, 'key'), rt.get_property(var_meta_mutated, 'value')])
		rt.set_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids', rt.call_function('array_diff', [rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'backfilling_order_ids'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }])]))
	}
	return var_update_meta.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) after_meta_change(var_order rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_meta_mutated := var_meta
	rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_meta_mutated.clone(), rt.new_string('apply_changes')])) && rt.is_true(var_meta_mutated.apply_changes()))
	if rt.is_true(this.should_save_after_meta_change(var_order_mutated.clone(), var_meta_mutated.clone())) {
		rt.call_method(var_order_mutated, 'set_date_modified', [rt.call_function('current_time', [rt.new_string('mysql')])])
		rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
		return true
	} else {
		mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
		rt.call_method(var_order_cache, 'remove', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
		this.clear_cached_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }])))
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_save_after_meta_change(var_order rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_meta_mutated := var_meta
	mut var_current_time := rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('current_time'), rt.new_string('mysql'), rt.new_int(1)])
	mut var_current_date_time := create_automattic_woocommerce_internal_datastores_orders_wc_datetime(var_current_time.clone(), create_automattic_woocommerce_internal_datastores_orders_datetimezone(rt.new_string('GMT')))
	mut var_should_save := rt.new_bool(rt.is_true(rt.greater(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.new_int(0))) && !(rt.get_static_prop('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', 'sync_on_read_order_ids').array_isset(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))) && rt.is_true(rt.less(rt.call_method(var_order_mutated, 'get_date_modified', []rt.PhpVal{}), var_current_date_time)) && !rt.is_true(rt.call_method(var_order_mutated, 'get_changes', []rt.PhpVal{})) && !(var_meta_mutated.clone().is_object()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta_mutated, 'key'), this.ephemeral_meta_keys, rt.new_bool(true)]))))))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_orders_table_datastore_should_save_after_meta_change'), var_should_save.clone()])
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"} {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
		ephemeral_meta_keys: rt.new_array()
		data_store_meta: rt.new_null()
		database_util: rt.new_null()
		cpt_data_store: rt.new_null()
		error_logger: rt.new_null()
		orders_table_name: rt.new_null()
		legacy_proxy: rt.new_null()
		order_column_mapping: rt.new_null()
		billing_address_column_mapping: rt.new_null()
		shipping_address_column_mapping: rt.new_null()
		operational_data_column_mapping: rt.new_null()
		all_order_column_mapping: rt.new_null()
		all_order_column_mapping_for_cache: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_abstract_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT{
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

fn create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_meta_data(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_stdclass(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":1968,"name":"this"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":2038,"name":"this"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":2063,"name":"this"}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn create_automattic_woocommerce_internal_datastores_orders_wc_coupon(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstablequery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_wc_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_datetimezone(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_orders_table_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name())
		}
		'get_addresses_table_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_addresses_table_name())
		}
		'get_operational_data_table_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name())
		}
		'get_meta_table_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name())
		}
		'get_all_table_names' {
			return this.get_all_table_names()
		}
		'get_all_table_names_with_id' {
			return Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_all_table_names_with_id()
		}
		'get_all_order_column_mappings' {
			return this.get_all_order_column_mappings()
		}
		'get_all_order_column_mappings_for_cache' {
			return this.get_all_order_column_mappings_for_cache()
		}
		'get_cache_group' {
			return rt.new_string(this.get_cache_group())
		}
		'clear_cached_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.clear_cached_data(mut dispatch_arg_0)
		}
		'clear_all_cached_data' {
			return rt.new_bool(this.clear_all_cached_data())
		}
		'get_order_table_alias' {
			return rt.new_string(this.get_order_table_alias())
		}
		'get_op_table_alias' {
			return rt.new_string(this.get_op_table_alias())
		}
		'get_address_table_alias' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_address_table_alias(dispatch_arg_0))
		}
		'get_cpt_data_store_instance' {
			return this.get_cpt_data_store_instance()
		}
		'get_post_data_store_for_backfill' {
			return this.get_post_data_store_for_backfill()
		}
		'backfill_post_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.backfill_post_record(dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_order_from_object(dispatch_arg_0))
		}
		'persist_db_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.persist_db_row(dispatch_arg_0)
		}
		'get_download_permissions_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download_permissions_granted(dispatch_arg_0)
		}
		'set_download_permissions_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_download_permissions_granted(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_recorded_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recorded_sales(dispatch_arg_0)
		}
		'set_recorded_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_recorded_sales(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_recorded_coupon_usage_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_recorded_coupon_usage_counts(dispatch_arg_0))
		}
		'set_recorded_coupon_usage_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_recorded_coupon_usage_counts(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_sent(dispatch_arg_0)
		}
		'set_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_email_sent(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_new_order_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_new_order_email_sent(dispatch_arg_0)
		}
		'set_new_order_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_new_order_email_sent(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_reduced(dispatch_arg_0)
		}
		'set_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_stock_reduced(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_stock_reduced(dispatch_arg_0)
		}
		'set_order_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_order_stock_reduced(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_payment_token_ids(dispatch_arg_0)
		}
		'update_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_payment_token_ids(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_total_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_refunded(dispatch_arg_0)
		}
		'get_refund_orders_join_clause' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_refund_orders_join_clause(dispatch_arg_0))
		}
		'get_order_id_by_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_order_id_by_order_key(dispatch_arg_0))
		}
		'get_order_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_count(dispatch_arg_0)
		}
		'get_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_orders(dispatch_arg_0)
		}
		'get_unpaid_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_unpaid_orders(dispatch_arg_0)
		}
		'get_unpaid_orders_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_unpaid_orders_gmt(dispatch_arg_0)
		}
		'search_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_orders(dispatch_arg_0)
		}
		'get_orders_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_orders_type(dispatch_arg_0)
		}
		'get_order_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_type(dispatch_arg_0)
		}
		'order_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.order_exists(dispatch_arg_0))
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'read_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_multiple(dispatch_arg_0)
			return rt.new_null()
		}
		'read_cogs_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.read_cogs_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'should_sync_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.should_sync_order(mut dispatch_arg_0))
		}
		'init_order_record' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init_order_record(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'filter_raw_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_raw_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_sync_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.maybe_sync_order(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_cpt_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cpt_order(dispatch_arg_0)
		}
		'get_post_orders_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_post_orders_for_ids(mut dispatch_arg_0)
		}
		'is_post_different_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_post_different_from_order(dispatch_arg_0, dispatch_arg_1))
		}
		'migrate_meta_data_from_post_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.migrate_meta_data_from_post_order(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_diff_meta_data_between_orders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_diff_meta_data_between_orders(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'migrate_post_record' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.migrate_post_record(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_order_props_from_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_order_props_from_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_order_prop' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.set_order_prop(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_order_data_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_order_data_for_ids(mut dispatch_arg_0)
		}
		'get_order_data_for_ids_from_db' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_order_data_for_ids_from_db(mut dispatch_arg_0)
		}
		'get_order_data_for_ids_from_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_order_data_for_ids_from_cache(mut dispatch_arg_0)
		}
		'set_order_data_in_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_order_data_in_cache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_order_table_select_statement' {
			return rt.new_string(this.get_order_table_select_statement())
		}
		'get_order_meta_select_statement' {
			return rt.new_string(this.get_order_meta_select_statement())
		}
		'join_billing_address_table_to_order_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.join_billing_address_table_to_order_query(dispatch_arg_0, dispatch_arg_1)
		}
		'join_shipping_address_table_to_order_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.join_shipping_address_table_to_order_query(dispatch_arg_0, dispatch_arg_1)
		}
		'join_address_table_order_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.join_address_table_order_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'join_operational_data_table_to_order_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.join_operational_data_table_to_order_query(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_select_and_join_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.generate_select_and_join_clauses(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'generate_select_clause_for_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_select_clause_for_props(dispatch_arg_0, dispatch_arg_1)
		}
		'persist_order_to_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.persist_order_to_db(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_cogs_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.save_cogs_data(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_create_backup_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(this.maybe_create_backup_post(dispatch_arg_0, dispatch_arg_1))
		}
		'init_default_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.init_default_taxonomies(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'set_custom_taxonomies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_custom_taxonomies(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_db_rows_for_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_db_rows_for_order(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_db_row_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_db_row_from_order(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_order_deletion_with_sync_disabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_order_deletion_with_sync_disabled(dispatch_arg_0)
			return rt.new_null()
		}
		'upshift_or_delete_child_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.upshift_or_delete_child_orders(dispatch_arg_0)
			return rt.new_null()
		}
		'trash_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.trash_order(dispatch_arg_0)
			return rt.new_null()
		}
		'untrash_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.untrash_order(mut dispatch_arg_0))
		}
		'delete_order_data_from_custom_order_tables' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_order_data_from_custom_order_tables(dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'persist_save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.persist_save(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'persist_updates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.persist_updates(dispatch_arg_0, dispatch_arg_1)
		}
		'should_backfill_post_record' {
			return this.should_backfill_post_record()
		}
		'maybe_backfill_post_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_backfill_post_record(dispatch_arg_0)
			return rt.new_null()
		}
		'update_order_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_order_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'update_address_index_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_address_index_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_coupon_held_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_coupon_held_keys(dispatch_arg_0, dispatch_arg_1)
		}
		'get_coupon_held_keys_for_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_coupon_held_keys_for_users(dispatch_arg_0, dispatch_arg_1)
		}
		'set_coupon_held_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_coupon_held_keys(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'release_held_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.release_held_coupons(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		'prime_caches_for_orders' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.prime_caches_for_orders(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_refund_orders_batch_join_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_refund_orders_batch_join_clause(mut dispatch_arg_0))
		}
		'get_refund_parent_column' {
			return rt.new_string(this.get_refund_parent_column())
		}
		'get_batch_refund_totals' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DataStores_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_batch_refund_totals(mut dispatch_arg_0)
		}
		'get_database_schema' {
			return this.get_database_schema()
		}
		'read_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_meta(dispatch_arg_0)
		}
		'delete_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.delete_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'add_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'update_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'after_meta_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.after_meta_change(dispatch_arg_0, dispatch_arg_1))
		}
		'should_save_after_meta_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.should_save_after_meta_change(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		'ephemeral_meta_keys' { return this.ephemeral_meta_keys }
		'data_store_meta' { return this.data_store_meta }
		'database_util' { return this.database_util }
		'cpt_data_store' { return this.cpt_data_store }
		'error_logger' { return this.error_logger }
		'orders_table_name' { return this.orders_table_name }
		'legacy_proxy' { return this.legacy_proxy }
		'order_column_mapping' { return this.order_column_mapping }
		'billing_address_column_mapping' { return this.billing_address_column_mapping }
		'shipping_address_column_mapping' { return this.shipping_address_column_mapping }
		'operational_data_column_mapping' { return this.operational_data_column_mapping }
		'all_order_column_mapping' { return this.all_order_column_mapping }
		'all_order_column_mapping_for_cache' { return this.all_order_column_mapping_for_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'ephemeral_meta_keys' { this.ephemeral_meta_keys = val; return true }
		'data_store_meta' { this.data_store_meta = val; return true }
		'database_util' { this.database_util = val; return true }
		'cpt_data_store' { this.cpt_data_store = val; return true }
		'error_logger' { this.error_logger = val; return true }
		'orders_table_name' { this.orders_table_name = val; return true }
		'legacy_proxy' { this.legacy_proxy = val; return true }
		'order_column_mapping' { this.order_column_mapping = val; return true }
		'billing_address_column_mapping' { this.billing_address_column_mapping = val; return true }
		'shipping_address_column_mapping' { this.shipping_address_column_mapping = val; return true }
		'operational_data_column_mapping' { this.operational_data_column_mapping = val; return true }
		'all_order_column_mapping' { this.all_order_column_mapping = val; return true }
		'all_order_column_mapping_for_cache' { this.all_order_column_mapping_for_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_abstract_wc_order_data_store_cpt()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_OrderUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_orderutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_OrderUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT', []string{}, obj)
	})
	rt.register_class_factory('WC_Order', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order()
		return rt.new_object('WC_Order', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_meta_data()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Meta_Data', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_ArrayUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_arrayutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_ArrayUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_stdClass', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_stdclass()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_stdClass', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":1968,"name":"this"}()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":1968,"name":"this"}', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":2038,"name":"this"}()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2038,"name":"this"}', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_{"nodetype":"expr_variable","line":2063,"name":"this"}()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_{"nodeType":"Expr_Variable","line":2063,"name":"this"}', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_data_store()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_coupon()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_Coupon', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_orderstablequery()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableQuery', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_wc_datetime()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_WC_DateTime', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_datastores_orders_datetimezone()
		return rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_DateTimeZone', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
