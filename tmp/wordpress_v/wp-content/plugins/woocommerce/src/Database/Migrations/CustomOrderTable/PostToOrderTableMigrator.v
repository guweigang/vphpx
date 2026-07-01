import rt

struct Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) get_schema_config() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table_names := rt.create_array([
		rt.ArrayItem{ key: 'orders', val: (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders' },
		rt.ArrayItem{ key: 'addresses', val: (rt.get_property(var_wpdb, 'prefix')).str() +
			'wc_order_addresses' },
		rt.ArrayItem{ key: 'op_data', val: (rt.get_property(var_wpdb, 'prefix')).str() +
			'wc_order_operational_data' },
		rt.ArrayItem{ key: 'meta', val: (rt.get_property(var_wpdb, 'prefix')).str() +
			'wc_orders_meta' },
	])
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
			rt.ArrayItem{ key: 'table_name', val: var_table_names.array_get('orders') },
			rt.ArrayItem{ key: 'source_rel_column', val: 'id' },
			rt.ArrayItem{ key: 'primary_key', val: 'id' },
			rt.ArrayItem{ key: 'primary_key_type', val: 'int' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) get_core_column_mapping() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'ID', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'int' },
			rt.ArrayItem{ key: 'destination', val: 'id' },
		]) },
		rt.ArrayItem{ key: 'post_status', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'status' },
		]) },
		rt.ArrayItem{ key: 'post_date_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'date' },
			rt.ArrayItem{ key: 'destination', val: 'date_created_gmt' },
		]) },
		rt.ArrayItem{ key: 'post_modified_gmt', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'date' },
			rt.ArrayItem{ key: 'destination', val: 'date_updated_gmt' },
		]) },
		rt.ArrayItem{ key: 'post_parent', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'int' },
			rt.ArrayItem{ key: 'destination', val: 'parent_order_id' },
		]) },
		rt.ArrayItem{ key: 'post_type', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'type' },
		]) },
		rt.ArrayItem{ key: 'post_excerpt', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'customer_note' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) get_meta_column_config() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '_order_currency', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'currency' },
		]) },
		rt.ArrayItem{ key: '_order_tax', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'tax_amount' },
		]) },
		rt.ArrayItem{ key: '_order_total', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'decimal' },
			rt.ArrayItem{ key: 'destination', val: 'total_amount' },
		]) },
		rt.ArrayItem{ key: '_customer_user', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'int' },
			rt.ArrayItem{ key: 'destination', val: 'customer_id' },
		]) },
		rt.ArrayItem{ key: '_billing_email', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'billing_email' },
		]) },
		rt.ArrayItem{ key: '_payment_method', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'payment_method' },
		]) },
		rt.ArrayItem{ key: '_payment_method_title', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'payment_method_title' },
		]) },
		rt.ArrayItem{ key: '_customer_ip_address', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'ip_address' },
		]) },
		rt.ArrayItem{ key: '_customer_user_agent', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'user_agent' },
		]) },
		rt.ArrayItem{ key: '_transaction_id', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'destination', val: 'transaction_id' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_customordertable_posttoordertablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_metatocustomtablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_CustomOrderTable_PostToOrderTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_database_migrations_customordertable_posttoordertablemigrator_php() {
}
