import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController {
	rt.PhpObjectBase
pub mut:
	provides rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) register() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_data_stores'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_data_stores' },
		])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'initialize_fulfillments' },
		]),
		rt.new_int(10), rt.new_int(0)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) register_data_stores(var_data_stores rt.PhpVal) rt.PhpVal {
	mut var_data_stores_mutated := var_data_stores
	if !(var_data_stores_mutated.clone().is_array()) {
		return var_data_stores_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_feature_fulfillments_enabled'),
		rt.new_string('no'),
	])))))
	{
		return var_data_stores_mutated.clone()
	}
	var_data_stores_mutated.array_set('order-fulfillment',
		Class_Automattic_WooCommerce_Admin_Features_Fulfillments_DataStore_FulfillmentsDataStore.class())
	return var_data_stores_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) initialize_fulfillments() {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_features_controller := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_features_controller,
		'feature_is_enabled', [rt.new_string('fulfillments')])))))
	{
		return
	}
	this.maybe_create_db_tables()
	this.register_custom_shipping_providers_taxonomy()
	mut iter_1 := this.provides.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_class := item_1.val
		var_class = rt.call_method(var_container, 'get', [var_class.clone()])
		if rt.is_true(rt.call_function('method_exists', [var_class.clone(),
			rt.new_string('register')]))
		{
			rt.call_method(var_class, 'register', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) register_custom_shipping_providers_taxonomy() {
	if rt.is_true(rt.call_function('taxonomy_exists', [
		rt.new_string('wc_fulfillment_shipping_provider'),
	]))
	{
		return
	}
	rt.call_function('register_taxonomy', [
		rt.new_string('wc_fulfillment_shipping_provider'),
		rt.new_array(),
		rt.create_array([
			rt.ArrayItem{ key: 'labels', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
					rt.new_string('Shipping providers'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
					rt.new_string('Shipping provider'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
					rt.new_string('Add new shipping provider'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
					rt.new_string('Edit shipping provider'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'public', val: false },
			rt.ArrayItem{ key: 'show_ui', val: false },
			rt.ArrayItem{ key: 'hierarchical', val: false },
			rt.ArrayItem{ key: 'show_in_rest', val: false },
			rt.ArrayItem{ key: 'show_admin_column', val: false },
			rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
			rt.ArrayItem{ key: 'show_tagcloud', val: false },
			rt.ArrayItem{ key: 'query_var', val: false },
			rt.ArrayItem{ key: 'rewrite', val: false },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) maybe_create_db_tables() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_function('get_option', [
		rt.new_string('woocommerce_fulfillments_db_tables_created'),
		rt.new_bool(false),
	]))
	{
		mut var_table_exists := rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.new_string("SHOW TABLES LIKE '"), rt.get_property(var_wpdb,
				'prefix')), rt.new_string("wc_order_fulfillments'")),
		])
		if rt.is_true(var_table_exists) {
			return
		}
	}
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('DROP TABLE IF EXISTS '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_fulfillments')),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('DROP TABLE IF EXISTS '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('wc_order_fulfillment_meta')),
	])
	this.bulk_delete_order_fulfillment_status_meta(rt.new_null())
	mut var_collate := rt.new_string('')
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_database_util := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class(),
	])
	mut var_max_index_length := rt.call_method(var_database_util, 'get_max_index_length',
		[]rt.PhpVal{})
	if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [rt.new_string('collation')])) {
		var_collate = rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	}
	mut var_schema := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string('wc_order_fulfillments (\n\t\t\tfulfillment_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\t\t\tentity_type varchar(255) NOT NULL,\n\t\t\tentity_id bigint(20) unsigned NOT NULL,\n\t\t\tstatus varchar(255) NOT NULL,\n\t\t\tis_fulfilled tinyint(1) NOT NULL DEFAULT 0,\n\t\t\tdate_updated datetime NOT NULL,\n\t\t\tdate_deleted datetime NULL,\n\t\t\tPRIMARY KEY (fulfillment_id),\n\t\t\tKEY entity_type_id (entity_type(')),
		var_max_index_length), rt.new_string('), entity_id)\n\t\t) ')), var_collate),
		rt.new_string(';\n\t\tCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')),
		rt.new_string('wc_order_fulfillment_meta (\n\t\t\tmeta_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\t\t\tfulfillment_id bigint(20) unsigned NOT NULL,\n\t\t\tmeta_key varchar(255) NULL,\n\t\t\tmeta_value longtext NULL,\n\t\t\tdate_updated datetime NOT NULL,\n\t\t\tdate_deleted datetime NULL,\n\t\t\tPRIMARY KEY (meta_id),\n\t\t\tKEY meta_key (meta_key(')),
		var_max_index_length),
		rt.new_string(')),\n\t\t\tKEY fulfillment_id (fulfillment_id)\n\t\t) ')), var_collate),
		rt.new_string(';'))).str())
	rt.call_method(var_database_util, 'dbdelta', [var_schema.clone()])
	rt.call_function('update_option', [
		rt.new_string('woocommerce_fulfillments_db_tables_created'),
		rt.new_bool(true),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) bulk_delete_order_fulfillment_status_meta(var_order_ids rt.PhpVal) {
	this.delete_legacy_order_fulfillment_meta(var_order_ids.clone())
	this.delete_hpos_order_fulfillment_meta(var_order_ids.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) delete_legacy_order_fulfillment_meta(var_order_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if !(!rt.is_true(var_order_ids)) {
		mut var_order_params := rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: '_fulfillment_status' }]),
			var_order_ids.clone(),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string((
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE pm FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(" p ON pm.post_id = p.ID\n\t\t\t\t\tWHERE p.post_type = 'shop_order'\n\t\t\t\t\tAND pm.meta_key = %s\n\t\t\t\t\tAND pm.post_id IN (")) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_ids.clone().array_count()), rt.new_string('%d')])])).str() +
					')').str()),
				var_order_params.clone(),
			]),
		])
	} else {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE pm FROM '), rt.get_property(var_wpdb,
					'postmeta')), rt.new_string(' pm\n\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" p ON pm.post_id = p.ID\n\t\t\t\t\tWHERE p.post_type = 'shop_order'\n\t\t\t\t\tAND pm.meta_key = %s")),
				rt.new_string('_fulfillment_status'),
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) delete_hpos_order_fulfillment_meta(var_order_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_orders_meta')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
			var_table_name.clone()]),
	]), var_table_name))))
	{
		return
	}
	if !(!rt.is_true(var_order_ids)) {
		mut var_order_params := rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: '_fulfillment_status' }]),
			var_order_ids.clone(),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string((
					rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_orders_meta\n\t\t\t\t\tWHERE meta_key = %s\n\t\t\t\t\tAND order_id IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_order_ids.clone().array_count()), rt.new_string('%d')])])).str() +
					')').str()),
				var_order_params.clone(),
			]),
		])
	} else {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('wc_orders_meta\n\t\t\t\t\tWHERE meta_key = %s')),
				rt.new_string('_fulfillment_status'),
			]),
		])
	}
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController{
		PhpObjectBase: rt.PhpObjectBase{}
		provides:      rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'register_data_stores' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_data_stores(dispatch_arg_0)
		}
		'initialize_fulfillments' {
			this.initialize_fulfillments()
			return rt.new_null()
		}
		'register_custom_shipping_providers_taxonomy' {
			this.register_custom_shipping_providers_taxonomy()
			return rt.new_null()
		}
		'maybe_create_db_tables' {
			this.maybe_create_db_tables()
			return rt.new_null()
		}
		'bulk_delete_order_fulfillment_status_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bulk_delete_order_fulfillment_status_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_legacy_order_fulfillment_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_legacy_order_fulfillment_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_hpos_order_fulfillment_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_hpos_order_fulfillment_meta(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'provides' { return this.provides }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'provides' {
			this.provides = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
