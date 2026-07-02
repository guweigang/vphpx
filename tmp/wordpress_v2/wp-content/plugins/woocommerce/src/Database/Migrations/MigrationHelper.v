import rt

struct Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_database_migrations_migrationhelper() {
	rt.init_static_prop('Automattic_WooCommerce_Database_Migrations_MigrationHelper',
		'wpdb_placeholder_for_type', rt.create_array([
		rt.ArrayItem{ key: 'int', val: '%d' },
		rt.ArrayItem{ key: 'decimal', val: '%f' },
		rt.ArrayItem{ key: 'string', val: '%s' },
		rt.ArrayItem{ key: 'date', val: '%s' },
		rt.ArrayItem{ key: 'date_epoch', val: '%s' },
		rt.ArrayItem{ key: 'bool', val: '%d' },
	]))
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.escape_schema_for_backtick(mut var_schema_config Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	rt.call_function('array_walk', [var_schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Database_Migrations_Automattic_WooCommerce_Database_Migrations_MigrationHelper.class()
			},
			rt.ArrayItem{ key: none, val: 'escape_and_add_backtick' },
		])])
	rt.call_function('array_walk', [var_schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Database_Migrations_Automattic_WooCommerce_Database_Migrations_MigrationHelper.class()
			},
			rt.ArrayItem{ key: none, val: 'escape_and_add_backtick' },
		])])
	rt.call_function('array_walk', [var_schema_config.array_get(rt.new_string('destination')),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Database_Migrations_Automattic_WooCommerce_Database_Migrations_MigrationHelper.class()
			},
			rt.ArrayItem{ key: none, val: 'escape_and_add_backtick' },
		])])
	return rt.new_object('Automattic_WooCommerce_Database_Migrations_array', []string{},
		var_schema_config)
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.escape_and_add_backtick(var_identifier rt.PhpVal) string {
	return '`' +
		(rt.call_function('str_replace', [rt.new_string('`'), rt.new_string('``'), var_identifier.clone()])).str() +
		'`'
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.get_wpdb_placeholder_for_type(type string) string {
	return (rt.get_static_prop('Automattic_WooCommerce_Database_Migrations_MigrationHelper',
		'wpdb_placeholder_for_type').array_get(rt.new_string(type))).str()
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.generate_on_duplicate_statement_clause(mut var_columns Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_db_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class(),
	])
	return (rt.call_method(var_db_util, 'generate_on_duplicate_statement_clause', [
		var_columns,
	])).str()
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) bool {
	mut var_more_remaining := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_orders(country_code, mut
		var_old_to_new_states_mapping)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_more_remaining)))) {
		Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_misc_data(country_code, mut
			var_old_to_new_states_mapping)
	}
	return var_more_remaining.to_bool()
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_misc_data(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) {
	Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_shipping_locations(country_code, mut
		var_old_to_new_states_mapping)
	Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_tax_rates(country_code, mut
		var_old_to_new_states_mapping)
	Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_store_location(country_code, mut
		var_old_to_new_states_mapping)
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_shipping_locations(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_wpdb := rt.new_null()
	mut var_sql := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT location_id, location_code FROM '), rt.get_property(var_wpdb,
		'prefix')), rt.new_string("woocommerce_shipping_zone_locations WHERE location_code LIKE '")),
		rt.new_string(country_code)), rt.new_string(":%'"))).str())
	mut var_locations_data := rt.call_method(var_wpdb, 'get_results', [
		var_sql.clone(), rt.get_constant('ARRAY_A')])
	mut iter_1 := var_locations_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_location_data := item_1.val
		mut var_old_state_code := rt.call_function('substr', [
			var_location_data.array_get(rt.new_string('location_code')),
			rt.new_int(3),
		])
		if rt.is_true(rt.new_bool(var_old_to_new_states_mapping.array_isset(var_old_state_code.clone()))) {
			mut var_new_location_code := rt.new_string((rt.concat(rt.concat(rt.new_string(country_code),
				rt.new_string(':')), var_old_to_new_states_mapping.array_get(var_old_state_code))).str())
			mut var_update_query := rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')),
					rt.new_string('woocommerce_shipping_zone_locations SET location_code=%s WHERE location_id=%d')),
				var_new_location_code.clone(),
				var_location_data.array_get(rt.new_string('location_id')),
			])
			rt.call_method(var_wpdb, 'query', [var_update_query.clone()])
		}
	}
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_store_location(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_store_location := rt.call_function('get_option', [
		rt.new_string('woocommerce_default_country'),
		rt.new_string(''),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_0 := iife_temp_0.starts_with(var_store_location.clone(),
		rt.new_string('${var_country_code}:'))
	if rt.is_true(iife_result_0) {
		mut var_old_location_code := rt.call_function('substr', [
			var_store_location.clone(), rt.new_int(3)])
		if rt.is_true(rt.new_bool(var_old_to_new_states_mapping.array_isset(var_old_location_code.clone()))) {
			mut var_new_location_code := rt.new_string((rt.concat(rt.concat(rt.new_string(country_code),
				rt.new_string(':')), var_old_to_new_states_mapping.array_get(var_old_location_code))).str())
			rt.call_function('update_option', [
				rt.new_string('woocommerce_default_country'),
				var_new_location_code.clone(),
			])
		}
	}
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_orders(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) bool {
	mut var_wpdb := rt.new_null()
	mut var_limit := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_migrate_country_states_for_orders_batch_size'),
		rt.new_int(100),
		rt.new_string(country_code),
		var_old_to_new_states_mapping,
	])
	mut var_cot_exists := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class(),
	]), 'check_orders_table_exists', []rt.PhpVal{})
	mut iter_2 := var_old_to_new_states_mapping.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_new_state := item_2.val
		mut var_old_state := item_2.key
		if rt.is_true(var_cot_exists) {
			mut var_update_query := rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')),
					rt.new_string('wc_order_addresses SET state=%s WHERE country=%s AND state=%s LIMIT %d')),
				var_new_state.clone(),
				rt.new_string(country_code),
				var_old_state.clone(),
				var_limit.clone(),
			])
			rt.call_method(var_wpdb, 'query', [var_update_query.clone()])
		}
		mut var_select_meta_ids_query := rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('postmeta,\n\t\t\t\t\t(SELECT DISTINCT post_id FROM ')), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string("postmeta\n\t\t\t\t\tWHERE (meta_key = '_billing_country' OR meta_key='_shipping_country') AND meta_value=%s)\n\t\t\t\t\tAS states_in_country\n\t\t\t\tWHERE (meta_key='_billing_state' OR meta_key='_shipping_state')\n\t\t\t\tAND meta_value=%s\n\t\t\t\tAND ")), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string('.post_id = states_in_country.post_id\n\t\t\t\tLIMIT %d')),
			rt.new_string(country_code),
			var_old_state.clone(),
			var_limit.clone(),
		])
		mut var_meta_ids := rt.call_method(var_wpdb, 'get_results', [
			var_select_meta_ids_query.clone(), rt.get_constant('ARRAY_A')])
		if !(!rt.is_true(var_meta_ids)) {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
			mut iife_result_1 := iife_temp_1.select(var_meta_ids.clone(), rt.new_string('meta_id'))
			var_meta_ids = iife_result_1
			mut var_meta_ids_as_comma_separated := rt.new_string('(' +
				(rt.call_function('join', [rt.new_string(','), var_meta_ids.clone()])).str() + ')')
			var_update_query = rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('postmeta\n\t\t\t\t\tSET meta_value=%s\n\t\t\t\t\tWHERE meta_id IN ')),
					var_meta_ids_as_comma_separated),
				var_new_state.clone(),
			])
			rt.call_method(var_wpdb, 'query', [var_update_query.clone()])
		}
	}
	mut var_states_as_comma_separated := rt.new_string("('" +
		(rt.call_function('join', [rt.new_string("','"), rt.func_array_keys(var_old_to_new_states_mapping)])).str() +
		"')")
	mut var_posts_exist_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("postmeta\n\t\t\tWHERE (meta_key='_billing_state' OR meta_key='_shipping_state')\n\t\t\tAND meta_value IN ")),
			var_states_as_comma_separated),
			rt.new_string('\n\t\t\tAND post_id IN (\n\t\t\t\tSELECT post_id FROM ')), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("postmeta WHERE\n\t\t\t\t(meta_key = '_billing_country' OR meta_key='_shipping_country')\n\t\t\t\tAND meta_value=%s\n\t\t\t)")),
		rt.new_string(country_code),
	])
	if rt.is_true(var_cot_exists) {
		mut var_more_exist_query := rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT EXISTS(\n\t\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('wc_order_addresses\n\t\t\t\tWHERE country=%s AND state IN ')),
				var_states_as_comma_separated),
				rt.new_string('\n\t\t\t)\n\t\t\tOR EXISTS (\n\t\t\t  ')), var_posts_exist_query),
				rt.new_string('\n\t\t\t)')),
			rt.new_string(country_code),
		])
	} else {
		var_more_exist_query = rt.new_string('SELECT EXISTS (${var_posts_exist_query.to_string()})')
	}
	return rt.new_bool(rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		var_more_exist_query.clone()])).to_i64()) != 0)
	return false
}

fn Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_tax_rates(country_code string, mut var_old_to_new_states_mapping Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_wpdb := rt.new_null()
	mut iter_3 := var_old_to_new_states_mapping.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_new_state_code := item_3.val
		mut var_old_state_code := item_3.key
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')),
					rt.new_string('woocommerce_tax_rates SET tax_rate_state=%s WHERE tax_rate_country=%s AND tax_rate_state=%s')),
				var_new_state_code.clone(),
				rt.new_string(country_code),
				var_old_state_code.clone(),
			]),
		])
	}
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_migrationhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'escape_schema_for_backtick' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.escape_schema_for_backtick(mut dispatch_arg_0)
		}
		'escape_and_add_backtick' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.escape_and_add_backtick(dispatch_arg_0))
		}
		'get_wpdb_placeholder_for_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.get_wpdb_placeholder_for_type(dispatch_arg_0))
		}
		'generate_on_duplicate_statement_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.generate_on_duplicate_statement_clause(mut dispatch_arg_0))
		}
		'migrate_country_states' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'migrate_country_states_for_misc_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_misc_data(dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		'migrate_country_states_for_shipping_locations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_shipping_locations(dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		'migrate_country_states_for_store_location' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_store_location(dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		'migrate_country_states_for_orders' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_orders(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'migrate_country_states_for_tax_rates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper.migrate_country_states_for_tax_rates(dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
