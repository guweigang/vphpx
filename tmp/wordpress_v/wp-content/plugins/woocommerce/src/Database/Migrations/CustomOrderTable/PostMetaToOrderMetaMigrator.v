import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator {
	rt.PhpObjectBase
pub mut:
	excluded_columns rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) construct(var_excluded_columns rt.PhpVal) {
	this.excluded_columns = var_excluded_columns.dup()
	this.Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator.construct()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) get_meta_config() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.create_array([
		rt.ArrayItem{ key: 'source', val: rt.create_array([
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'table_name', val: rt.get_property(var_wpdb, 'postmeta') },
				rt.ArrayItem{ key: 'entity_id_column', val: 'post_id' },
				rt.ArrayItem{ key: 'meta_id_column', val: 'meta_id' },
				rt.ArrayItem{ key: 'meta_key_column', val: 'meta_key' },
				rt.ArrayItem{ key: 'meta_value_column', val: 'meta_value' },
			]) },
			rt.ArrayItem{ key: 'entity', val: rt.create_array([
				rt.ArrayItem{ key: 'table_name', val: rt.get_property(var_wpdb, 'posts') },
				rt.ArrayItem{ key: 'source_id_column', val: 'ID' },
				rt.ArrayItem{ key: 'id_column', val: 'ID' },
			]) },
			rt.ArrayItem{ key: 'excluded_keys', val: this.excluded_columns },
		]) },
		rt.ArrayItem{ key: 'destination', val: rt.create_array([
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'table_name', val: fn () rt.PhpVal {
					mut temp :=
						Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
					return temp.get_meta_table_name()
				}() },
				rt.ArrayItem{ key: 'entity_id_column', val: 'order_id' },
				rt.ArrayItem{ key: 'meta_key_column', val: 'meta_key' },
				rt.ArrayItem{ key: 'meta_value_column', val: 'meta_value' },
				rt.ArrayItem{ key: 'entity_id_type', val: 'int' },
				rt.ArrayItem{ key: 'meta_id_column', val: 'id' },
			]) },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_postmetatoordermetamigrator(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator{
		PhpObjectBase:    rt.PhpObjectBase{}
		excluded_columns: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_database_migrations_metatometatablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore() &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_meta_config' {
			return this.get_meta_config()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'excluded_columns' { return this.excluded_columns }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostMetaToOrderMetaMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'excluded_columns' {
			this.excluded_columns = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_database_migrations_customordertable_postmetatoordermetamigrator_php() {
}
