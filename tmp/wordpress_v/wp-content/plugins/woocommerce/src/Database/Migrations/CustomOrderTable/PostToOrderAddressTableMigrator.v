import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) construct(var_type rt.PhpVal) {
	mut var_type_mutated := var_type
	this.prop_type = var_type_mutated.dup()
	this.Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator.construct()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) get_schema_config() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
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
			rt.ArrayItem{ key: 'table_name', val: fn () rt.PhpVal {
				mut temp :=
					Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
				return temp.get_addresses_table_name()
			}() },
			rt.ArrayItem{ key: 'source_rel_column', val: 'order_id' },
			rt.ArrayItem{ key: 'primary_key', val: 'id' },
			rt.ArrayItem{ key: 'primary_key_type', val: 'int' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) get_core_column_mapping() rt.PhpVal {
	mut var_type := this.prop_type
	return rt.create_array([
		rt.ArrayItem{ key: 'ID', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'int' },
			rt.ArrayItem{ key: 'destination', val: 'order_id' },
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'address_type' },
			rt.ArrayItem{ key: 'select_clause', val: "'${var_type.to_string()}'" },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) get_meta_column_config() rt.PhpVal {
	mut var_type := this.prop_type
	return rt.create_array([
		rt.ArrayItem{ key: '_${var_type.to_string()}_first_name', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'first_name' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_last_name', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'last_name' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_company', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'company' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_address_1', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'address_1' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_address_2', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'address_2' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_city', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'city' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_state', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'state' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_postcode', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'postcode' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_country', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'country' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_email', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'email' },
		]) },
		rt.ArrayItem{ key: '_${var_type.to_string()}_phone', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'phone' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) get_additional_where_clause_for_get_data_to_insert_or_update(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array) string {
	return rt.concat(rt.concat(rt.new_string("AND destination.`address_type` = '"), this.prop_type),
		rt.new_string("'"))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) get_where_clause_for_verification(var_source_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query :=
		this.Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator.get_where_clause_for_verification(var_source_ids.dup())
	return rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(var_query, rt.new_string(' AND ')), rt.get_property(rt.new_object('Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator', [
			'Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator',
		], &this), 'schema_config').array_get('destination').array_get('table_name')),
			rt.new_string('.address_type = %s')),
		this.prop_type,
	])
}

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoorderaddresstablemigrator(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_database_migrations_metatocustomtablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator{
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

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_schema_config' {
			return this.get_schema_config()
		}
		'get_core_column_mapping' {
			return this.get_core_column_mapping()
		}
		'get_meta_column_config' {
			return this.get_meta_column_config()
		}
		'get_additional_where_clause_for_get_data_to_insert_or_update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_additional_where_clause_for_get_data_to_insert_or_update(mut dispatch_arg_0))
		}
		'get_where_clause_for_verification' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_where_clause_for_verification(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderAddressTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_src_database_migrations_customordertable_posttoorderaddresstablemigrator_php() {
}
