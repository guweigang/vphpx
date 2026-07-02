import rt

struct Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) get_table_name() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_stock_notificationmeta'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) get_meta_id_field() string {
	return 'id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) get_object_id_field() string {
	return 'notification_id'
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) delete_by_notification_id(var_notification_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_string(this.get_table_name())
	mut var_result := rt.call_method(var_wpdb, 'delete', [var_table.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'notification_id', val: var_notification_id },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		])])
	return if rt.is_true(rt.identical(rt.new_bool(false), var_result)) { false } else { true }
}

struct Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_datastores_stocknotifications_stocknotificationsmetadatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_custommetadatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_table_name' {
			return rt.new_string(this.get_table_name())
		}
		'get_meta_id_field' {
			return rt.new_string(this.get_meta_id_field())
		}
		'get_object_id_field' {
			return rt.new_string(this.get_object_id_field())
		}
		'delete_by_notification_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_by_notification_id(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsMetaDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_CustomMetaDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
