import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) get_schema_config() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_0 := iife_temp_0.get_operational_data_table_name()
	return rt.create_array([
		rt.ArrayItem{ key: 'source', val: rt.create_array([
			rt.ArrayItem{ key: 'entity', val: rt.create_array([
				rt.ArrayItem{ key: 'table_name', val: rt.get_property(var_wpdb, 'posts') },
				rt.ArrayItem{ key: 'meta_rel_column', val: 'ID' },
				rt.ArrayItem{ key: 'destination_rel_column', val: 'ID' },
				rt.ArrayItem{ key: 'primary_key', val: 'ID' },
			]) },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'table_name', val: rt.get_property(var_wpdb, 'postmeta') },
				rt.ArrayItem{ key: 'meta_id_column', val: 'meta_id' },
				rt.ArrayItem{ key: 'meta_key_column', val: 'meta_key' },
				rt.ArrayItem{ key: 'meta_value_column', val: 'meta_value' },
				rt.ArrayItem{ key: 'entity_id_column', val: 'post_id' },
			]) },
		]) },
		rt.ArrayItem{ key: 'destination', val: rt.create_array([
			rt.ArrayItem{ key: 'table_name', val: iife_result_0 },
			rt.ArrayItem{ key: 'source_rel_column', val: 'order_id' },
			rt.ArrayItem{ key: 'primary_key', val: 'id' },
			rt.ArrayItem{ key: 'primary_key_type', val: 'int' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) get_core_column_mapping() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'ID', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'int' },
			rt.ArrayItem{ key: 'destination', val: 'order_id' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) get_meta_column_config() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '_created_via', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'created_via' },
		]) },
		rt.ArrayItem{ key: '_order_version', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'woocommerce_version' },
		]) },
		rt.ArrayItem{ key: '_prices_include_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'prices_include_tax' },
		]) },
		rt.ArrayItem{ key: '_recorded_coupon_usage_counts', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'coupon_usages_are_counted' },
		]) },
		rt.ArrayItem{ key: '_download_permissions_granted', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'download_permission_granted' },
		]) },
		rt.ArrayItem{ key: '_cart_hash', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'cart_hash' },
		]) },
		rt.ArrayItem{ key: '_new_order_email_sent', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'new_order_email_sent' },
		]) },
		rt.ArrayItem{ key: '_order_key', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'order_key' },
		]) },
		rt.ArrayItem{ key: '_order_stock_reduced', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'order_stock_reduced' },
		]) },
		rt.ArrayItem{ key: '_date_paid', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'date_epoch' },
			rt.ArrayItem{ key: 'destination', val: 'date_paid_gmt' },
		]) },
		rt.ArrayItem{ key: '_date_completed', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'date_epoch' },
			rt.ArrayItem{ key: 'destination', val: 'date_completed_gmt' },
		]) },
		rt.ArrayItem{ key: '_order_shipping_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'shipping_tax_amount' },
		]) },
		rt.ArrayItem{ key: '_order_shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'shipping_total_amount' },
		]) },
		rt.ArrayItem{ key: '_cart_discount_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'discount_tax_amount' },
		]) },
		rt.ArrayItem{ key: '_cart_discount', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'discount_total_amount' },
		]) },
		rt.ArrayItem{ key: '_recorded_sales', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'bool' },
			rt.ArrayItem{ key: 'destination', val: 'recorded_sales' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoorderoptablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_metatocustomtablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator{
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

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_schema_config' {
			return this.get_schema_config()
		}
		'get_core_column_mapping' {
			return this.get_core_column_mapping()
		}
		'get_meta_column_config' {
			return this.get_meta_column_config()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderOpTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
