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
		reading_order_ids rt.PhpVal = rt.new_array()
		backfilling_order_ids rt.PhpVal = rt.new_array()
		sync_on_read_order_ids rt.PhpVal = rt.new_array()
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

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init(mut var_data_store_meta Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStoreMeta, mut var_database_util Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.data_store_meta = var_data_store_meta.dup()
	this.database_util = var_database_util.dup()
	this.legacy_proxy = var_legacy_proxy.dup()
	this.error_logger = var_legacy_proxy.call_function(rt.new_string('wc_get_logger'))
	this.internal_meta_keys = this.get_internal_meta_keys()
	this.orders_table_name = Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name()
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_orders_table_name() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_addresses_table_name() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_addresses'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_operational_data_table_name() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_operational_data'
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_meta_table_name() string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders_meta'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_all_table_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: this.get_orders_table_name() }, rt.ArrayItem{ key: none, val: this.get_addresses_table_name() }, rt.ArrayItem{ key: none, val: this.get_operational_data_table_name() }, rt.ArrayItem{ key: none, val: this.get_meta_table_name() }])
}

fn Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore.get_all_table_names_with_id() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
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
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_datastore_cache_enabled() }())))) {
		return rt.call_function('array_fill_keys', [var_order_ids_mutated.dup(), rt.new_bool(true)])
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_cache_group := rt.new_string(this.get_cache_group())
	mut var_return_values := rt.new_array()
	{
		mut iter_1 := var_order_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_id := item_1.val
			var_return_values.array_set(var_order_id, rt.call_method(var_cache_engine, 'delete_cached_object', [var_order_id.dup(), var_cache_group.dup()]))
		}
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: this.data_store_meta }, rt.ArrayItem{ key: none, val: 'clear_cached_data' }])])) {
		mut var_successfully_deleted_cache_order_ids := rt.func_array_keys(rt.call_function('array_filter', [var_return_values.dup()]))
		mut var_cache_deletion_results := rt.call_method(this.data_store_meta, 'clear_cached_data', [var_successfully_deleted_cache_order_ids.dup()])
		{
			mut iter_1 := var_cache_deletion_results.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta_cache_was_deleted := item_1.val
				mut var_order_id := item_1.key
				var_return_values.array_set(var_order_id, rt.is_true(var_return_values.array_get(var_order_id)) && rt.is_true(var_meta_cache_was_deleted))
			}
		}
	}
	return var_return_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) clear_all_cached_data() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_datastore_cache_enabled() }())))) {
		return true
	}
	mut var_cache_engine := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caching_WPCacheEngine.class()])
	mut var_orders_invalidated := rt.call_method(var_cache_engine, 'delete_cache_group', [this.get_cache_group()])
	mut var_meta_invalidated := rt.new_bool(rt.new_bool(true))
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
	return create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) backfill_post_record(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_cpt_data_store := this.get_post_data_store_for_backfill()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cpt_data_store.dup().is_null())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_cpt_data_store.dup(), rt.new_string('update_order_from_object')]))))))) {
		return rt.new_null()
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_push(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})) && rt.is_true(rt.new_bool(rt.call_function('get_post', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]).is_null())))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.maybe_create_backup_post(var_order_mutated.dup(), 'backfill'))))) {
			rt.call_method(this.error_logger, 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to create backup post for order %d.'), rt.new_string('woocommerce')]), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])
			return rt.new_null()
		}
	}
	this.update_order_meta_from_object(var_order_mutated.dup())
	mut var_order_class := rt.call_function('get_class', [var_order_mutated.dup()])
	mut var_post_order := rt.create_object_dynamically(var_order_class, []rt.PhpVal{})
	rt.call_method(var_post_order, 'set_id', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.call_method(var_cpt_data_store, 'order_exists', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])) {
		rt.call_method(var_cpt_data_store, 'read', [var_post_order.dup()])
	}
	rt.call_method(var_post_order, 'set_props', [rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{})])
	rt.call_method(var_cpt_data_store, 'update_order_from_object', [var_post_order.dup()])
	{
		mut iter_1 := rt.call_method(var_cpt_data_store, 'get_internal_data_store_key_getters', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_getter_name := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_cpt_data_store }, rt.ArrayItem{ key: none, val: "set_${var_getter_name.to_string()}" }])])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this) }, rt.ArrayItem{ key: none, val: "get_${var_getter_name.to_string()}" }])])))) {
				rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: var_cpt_data_store }, rt.ArrayItem{ key: none, val: "set_${var_getter_name.to_string()}" }]), rt.create_array([rt.ArrayItem{ key: none, val: var_order_mutated }, rt.ArrayItem{ key: none, val: rt.call_method(rt.new_object('Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore', ['Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this), "get_${var_getter_name.to_string()}", [var_order_mutated.dup()]) }])])
			}
		}
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_function('do_action', [rt.new_string('woocommerce_hpos_post_record_backfilled'), var_order_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_order_from_object(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_hpos_order := create_wc_order()
	var_hpos_order.set_id(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}))
	this.read(rt.new_object('WC_Order', []string{}, var_hpos_order))
	var_hpos_order.set_props(rt.call_method(var_order_mutated, 'get_data', []rt.PhpVal{}))
	{
		mut iter_1 := var_hpos_order.get_meta_data().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			var_hpos_order.delete_meta_data(rt.get_property(var_meta, 'key'))
		}
	}
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_meta_data', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			var_hpos_order.add_meta_data(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'))
		}
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_orders_table_datastore_should_save_after_meta_change'), rt.new_string('__return_false')])
	var_hpos_order.save_meta_data()
	rt.call_function('remove_filter', [rt.new_string('woocommerce_orders_table_datastore_should_save_after_meta_change'), rt.new_string('__return_false')])
	mut var_db_rows := this.get_db_rows_for_order(mut var_hpos_order, 'update', true)
	{
		mut iter_1 := var_db_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_db_update := item_1.val
			rt.call_function('ksort', [var_db_update.array_get('data')])
			rt.call_function('ksort', [var_db_update.array_get('format')])
			this.persist_db_row(var_db_update.dup())
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_db_row(var_update rt.PhpVal) rt.PhpVal {
	if var_update.array_isset(rt.new_string('where')) {
		mut var_row_updated := rt.call_method(, 'insert_or_update', [, , , , ])
		mut var_result := 
	} else {
		
	}
	return .dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_download_permissions_granted(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_download_permissions_granted(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_recorded_sales(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_recorded_sales(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_recorded_coupon_usage_counts(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_recorded_coupon_usage_counts(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_email_sent(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_new_order_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_new_order_email_sent(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_payment_token_ids(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_payment_token_ids(var_order rt.PhpVal, var_token_ids rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_total_refunded(var_order rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_orders_join_clause(order_id i64) string {
	mut var_wpdb := rt.new_null()
	mut order_id_mutated := order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_id_by_order_key(var_order_key rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_count(var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_unpaid_orders(var_date rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_unpaid_orders_gmt(var_gmt_timestamp rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_gmt_timestamp_mutated := var_gmt_timestamp
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) search_orders(var_term rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_orders_type(var_order_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_type(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) order_exists(var_order_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_multiple(var_orders rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_orders_mutated := var_orders
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_cogs_data(mut var_order Class_WC_Abstract_Order, mut var_meta_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_meta := rt.new_null()
	mut var_order_mutated := var_order
	mut var_meta_data_mutated := var_meta_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_sync_order(mut var_order Class_WC_Abstract_Order) bool {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init_order_record(mut var_order Class_WC_Abstract_Order, order_id i64, mut var_order_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_stdClass)  {
	mut var_order_mutated := var_order
	mut order_id_mutated := order_id
	mut var_order_data_mutated := var_order_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) filter_raw_meta_data(var_object rt.PhpVal, var_raw_meta_data rt.PhpVal) rt.PhpVal {
	mut var_raw_meta_data_mutated := var_raw_meta_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_sync_order(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order)  {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_cpt_order(var_post rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_post_orders_for_ids(mut var_orders Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_orders_mutated := var_orders
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) is_post_different_from_order(var_order rt.PhpVal, var_post_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) migrate_meta_data_from_post_order(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_diff_meta_data_between_orders(mut var_order1 Class_WC_Abstract_Order, mut var_order2 Class_WC_Abstract_Order, sync bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) migrate_post_record(mut var_order Class_WC_Abstract_Order, mut var_post_order Class_WC_Abstract_Order)  {
	mut var_order_mutated := var_order
	mut var_post_order_mutated := var_post_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_props_from_data(var_order rt.PhpVal, var_order_data rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_order_data_mutated := var_order_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_prop(mut var_order Class_WC_Abstract_Order, prop_name string, var_prop_value rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_prop_value_mutated := var_prop_value
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids_from_db(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_data_for_ids_from_cache(mut var_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_order_data_in_cache(mut var_order_data Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_order_data_mutated := var_order_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_table_select_statement() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_order_meta_select_statement() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_billing_address_table_to_order_query(var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_shipping_address_table_to_order_query(var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_address_table_order_query(var_address_type rt.PhpVal, var_order_table_alias rt.PhpVal, var_address_table_alias rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_table_alias_mutated := var_order_table_alias
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) join_operational_data_table_to_order_query(var_order_table_alias rt.PhpVal, var_operational_table_alias rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) generate_select_and_join_clauses(var_order_table_alias rt.PhpVal, var_table rt.PhpVal, var_table_alias rt.PhpVal, var_column_props_map rt.PhpVal) rt.PhpVal {
	mut var_order_table_alias_mutated := var_order_table_alias
	mut var_table_alias_mutated := var_table_alias
	mut var_column_props_map_mutated := var_column_props_map
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) generate_select_clause_for_props(var_table_alias rt.PhpVal, var_props rt.PhpVal) rt.PhpVal {
	mut var_table_alias_mutated := var_table_alias
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_order_to_db(var_order rt.PhpVal, force_all_fields bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) save_cogs_data(mut var_order Class_WC_Abstract_Order, cogs_value_changed bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_create_backup_post(var_order rt.PhpVal, context string) i64 {
	mut var_order_mutated := var_order
	mut context_mutated := context
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) init_default_taxonomies(mut var_order Class_WC_Abstract_Order, mut var_sanitized_tax_input Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_sanitized_tax_input_mutated := var_sanitized_tax_input
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_custom_taxonomies(mut var_order Class_WC_Abstract_Order, mut var_sanitized_tax_input Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_order_mutated := var_order
	mut var_sanitized_tax_input_mutated := var_sanitized_tax_input
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_db_rows_for_order(mut var_order Class_WC_Abstract_Order, context string, only_changes bool) rt.PhpVal {
	mut var_order_mutated := var_order
	mut context_mutated := context
	mut only_changes_mutated := only_changes
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_db_row_from_order(var_order rt.PhpVal, var_column_mapping rt.PhpVal, only_changes bool) rt.PhpVal {
	mut var_order_mutated := var_order
	mut only_changes_mutated := only_changes
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete(var_order rt.PhpVal, var_args rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) handle_order_deletion_with_sync_disabled(var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) upshift_or_delete_child_orders(var_order rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) trash_order(var_order rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) untrash_order(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete_order_data_from_custom_order_tables(var_order_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) create(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_save(var_order rt.PhpVal, force_all_fields bool, backfill bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_post_meta(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) persist_updates(var_order rt.PhpVal, backfill bool) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_backfill_post_record() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) maybe_backfill_post_record(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_order_meta(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_address_index_meta(var_order rt.PhpVal, var_changes rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_changes_mutated := var_changes
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_coupon_held_keys(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_coupon_held_keys_for_users(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) set_coupon_held_keys(var_order rt.PhpVal, var_held_keys rt.PhpVal, var_held_keys_for_user rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_held_keys_mutated := var_held_keys
	mut var_held_keys_for_user_mutated := var_held_keys_for_user
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) release_held_coupons(var_order rt.PhpVal, save bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) prime_caches_for_orders(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array, mut var_query_vars Class_Automattic_WooCommerce_Internal_DataStores_Orders_array)  {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_orders_batch_join_clause(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) string {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_refund_parent_column() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_batch_refund_totals(mut var_order_ids Class_Automattic_WooCommerce_Internal_DataStores_Orders_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) get_database_schema() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) read_meta(var_object rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) delete_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_meta_mutated := var_meta
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) add_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_meta_mutated := var_meta
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) update_meta(var_object rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_meta_mutated := var_meta
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) after_meta_change(var_order rt.PhpVal, var_meta rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_meta_mutated := var_meta
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) should_save_after_meta_change(var_order rt.PhpVal, var_meta rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_meta_mutated := var_meta
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

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
		reading_order_ids: rt.new_array()
		backfilling_order_ids: rt.new_array()
		sync_on_read_order_ids: rt.new_array()
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

fn create_automattic_woocommerce_internal_datastores_orders_abstract_wc_order_data_store_cpt() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_Abstract_WC_Order_Data_Store_CPT{
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

fn create_automattic_woocommerce_internal_datastores_orders_wc_order_data_store_cpt() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
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
			return this.get_order_id_by_order_key(dispatch_arg_0)
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
		'reading_order_ids' { return this.reading_order_ids }
		'backfilling_order_ids' { return this.backfilling_order_ids }
		'sync_on_read_order_ids' { return this.sync_on_read_order_ids }
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
		'reading_order_ids' { this.reading_order_ids = val; return true }
		'backfilling_order_ids' { this.backfilling_order_ids = val; return true }
		'sync_on_read_order_ids' { this.sync_on_read_order_ids = val; return true }
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
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_datastores_orders_orderstabledatastore_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
