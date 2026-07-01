import rt

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator {
	rt.PhpObjectBase
pub mut:
		schema_config rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) get_meta_config()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) construct()  {
	this.schema_config = this.get_meta_config()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) fetch_sanitized_migration_data(var_entity_ids rt.PhpVal) rt.PhpVal {
	this.clear_errors()
	mut var_to_migrate := this.fetch_data_for_migration_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_ids))
	if !rt.is_true(var_to_migrate) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() }, rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	}
	mut var_already_migrated := this.get_already_migrated_records(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](rt.func_array_keys(var_to_migrate.dup())))
	return rt.create_array([rt.ArrayItem{ key: 'data', val: this.classify_update_insert_records(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_migrate), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_already_migrated)) }, rt.ArrayItem{ key: 'errors', val: this.get_errors() }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) process_migration_batch_for_ids_core(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array)  {
	mut var_sanitized_data := this.fetch_sanitized_migration_data(rt.new_object('Automattic_WooCommerce_Database_Migrations_array', []string{}, var_entity_ids))
	this.process_migration_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_sanitized_data))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) process_migration_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('data')) {
		var_data_mutated = var_data_mutated.array_get('data')
	}
	this.clear_errors()
	mut var_exception := rt.new_null()
	mut var_to_insert := var_data_mutated.array_get(0)
	mut var_to_update := var_data_mutated.array_get(1)
	mut var_to_delete := if !(var_data_mutated.array_get(2)).is_null() { var_data_mutated.array_get(2) } else { rt.new_array() }
	if !(!rt.is_true(var_to_delete)) {
		mut var_delete_queries := rt.new_string(this.generate_delete_sql_for_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_delete)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(var_delete_queries) {
			mut var_processed_rows_count := this.db_query(var_delete_queries.dup())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.maybe_add_insert_or_update_error(rt.new_string('delete'), var_processed_rows_count.dup())
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_to_insert)) {
		mut var_insert_queries := rt.new_string(this.generate_insert_sql_for_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_insert)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_processed_rows_count = this.db_query(var_insert_queries.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.maybe_add_insert_or_update_error(rt.new_string('insert'), var_processed_rows_count.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_to_update)) {
		mut var_update_queries := rt.new_string(this.generate_update_sql_for_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_update)))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_processed_rows_count = this.db_query(var_update_queries.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.maybe_add_insert_or_update_error(rt.new_string('update'), var_processed_rows_count.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Database_Migrations_Exception') {
		mut var_e := var_e_1.dup()
		var_exception = var_e
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: this.get_errors() }, rt.ArrayItem{ key: 'exception', val: var_exception }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) generate_delete_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := this.schema_config.array_get('destination').array_get('meta').array_get('table_name')
	mut var_meta_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_id_column')
	mut var_entity_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_column')
	mut var_entity_id_placeholder := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.get_wpdb_placeholder_for_type(arg_0) }(this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_type'))
	mut var_clauses := rt.new_array()
	{
		mut iter_1 := var_batch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_metas := item_1.val
			mut var_entity_id := item_1.key
			mut var_meta_ids := rt.call_function('array_column', [rt.call_function('array_reduce', [var_metas.dup(), rt.new_string('array_merge'), rt.new_array()]), var_meta_id_column.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_ids)))) {
				continue
			}
			mut var_meta_id_placeholders := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_meta_ids.dup().array_count()), rt.new_string('%d')])])
			var_clauses.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string("( %i = ${var_entity_id_placeholder.to_string()} AND %i IN (${var_meta_id_placeholders.to_string()}) )"), var_entity_id_column.dup(), var_entity_id.dup(), var_meta_id_column.dup(), var_meta_ids.dup()]))
			// unsupported statement: Stmt_Nop
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_clauses)))) {
		return ''
	}
	mut var_clauses_sql := rt.call_function('implode', [rt.new_string(' OR '), var_clauses.dup()])
	return "DELETE FROM ${var_table.to_string()} WHERE ${var_clauses_sql.to_string()}"
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) generate_update_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := this.schema_config.array_get('destination').array_get('meta').array_get('table_name')
	mut var_meta_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_id_column')
	mut var_meta_key_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_key_column')
	mut var_meta_value_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_value_column')
	mut var_entity_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_column')
	mut var_columns := rt.create_array([rt.ArrayItem{ key: none, val: var_meta_id_column }, rt.ArrayItem{ key: none, val: var_entity_id_column }, rt.ArrayItem{ key: none, val: var_meta_key_column }, rt.ArrayItem{ key: none, val: var_meta_value_column }])
	mut var_columns_sql := rt.call_function('implode', [rt.new_string('`, `'), var_columns.dup()])
	mut var_entity_id_column_placeholder := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.get_wpdb_placeholder_for_type(arg_0) }(this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_type'))
	mut var_placeholder_string := rt.new_string(rt.new_string("%d, ${var_entity_id_column_placeholder.to_string()}, %s, %s"))
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_batch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rows := item_1.val
			mut var_entity_id := item_1.key
			{
				mut iter_2 := var_rows.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_meta_details := item_2.val
					mut var_meta_key := item_2.key
					var_values.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string("( ${var_placeholder_string.to_string()} )"), rt.create_array([rt.ArrayItem{ key: none, val: var_meta_details.array_get('id') }, rt.ArrayItem{ key: none, val: var_entity_id }, rt.ArrayItem{ key: none, val: var_meta_key }, rt.ArrayItem{ key: none, val: var_meta_details.array_get('meta_value') }])]))
					// unsupported statement: Stmt_Nop
				}
			}
		}
	}
	mut var_value_sql := rt.call_function('implode', [rt.new_string(','), var_values.dup()])
	mut var_on_duplicate_key_clause := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.generate_on_duplicate_statement_clause(arg_0) }(var_columns.dup())
	return "INSERT INTO ${var_table.to_string()} ( `${var_columns_sql.to_string()}` ) VALUES ${var_value_sql.to_string()} ${var_on_duplicate_key_clause.to_string()}"
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) generate_insert_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_table := this.schema_config.array_get('destination').array_get('meta').array_get('table_name')
	mut var_meta_key_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_key_column')
	mut var_meta_value_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_value_column')
	mut var_entity_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_column')
	mut var_column_sql := rt.new_string(rt.new_string("(`${var_entity_id_column.to_string()}`, `${var_meta_key_column.to_string()}`, `${var_meta_value_column.to_string()}`)"))
	mut var_entity_id_column_placeholder := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.get_wpdb_placeholder_for_type(arg_0) }(this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_type'))
	mut var_placeholder_string := rt.new_string(rt.new_string("${var_entity_id_column_placeholder.to_string()}, %s, %s"))
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_batch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rows := item_1.val
			mut var_entity_id := item_1.key
			{
				mut iter_2 := var_rows.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_meta_values := item_2.val
					mut var_meta_key := item_2.key
					{
						mut iter_3 := var_meta_values.iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_meta_value := item_3.val
							mut var_query_params := rt.create_array([rt.ArrayItem{ key: none, val: var_entity_id }, rt.ArrayItem{ key: none, val: var_meta_key }, rt.ArrayItem{ key: none, val: var_meta_value }])
							mut var_value_sql := rt.call_method(var_wpdb, 'prepare', [rt.new_string("${var_placeholder_string.to_string()}"), var_query_params.dup()])
							var_values.array_push(var_value_sql.dup())
						}
					}
				}
			}
		}
	}
	mut var_values_sql := rt.call_function('implode', [rt.new_string('), ('), var_values.dup()])
	return "INSERT IGNORE INTO ${var_table.to_string()} ${var_column_sql.to_string()} VALUES (${var_values_sql.to_string()})"
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) fetch_data_for_migration_for_ids(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_to_migrate := rt.new_null()
	if !rt.is_true(var_entity_ids) {
		return rt.new_array()
	}
	mut var_meta_query := rt.new_string(this.build_meta_table_query(mut var_entity_ids))
	mut var_meta_data_rows := this.db_get_results(var_meta_query.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_meta_data_rows.dup().is_array()))))) || !rt.is_true(var_meta_data_rows))) {
		return rt.new_array()
	}
	{
		mut iter_1 := var_meta_data_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_migrate_row := item_1.val
			if !(var_to_migrate.array_isset(rt.get_property(var_migrate_row, 'entity_id'))) {
				var_to_migrate.array_set(rt.get_property(var_migrate_row, 'entity_id'), rt.new_array())
			}
			if !(var_to_migrate.array_get(rt.get_property(var_migrate_row, 'entity_id')).array_isset(rt.get_property(var_migrate_row, 'meta_key'))) {
				var_to_migrate.array_get_mut(rt.get_property(var_migrate_row, 'entity_id')).array_set(rt.get_property(var_migrate_row, 'meta_key'), rt.new_array())
			}
			var_to_migrate.array_get_mut(rt.get_property(var_migrate_row, 'entity_id')).array_get_mut(rt.get_property(var_migrate_row, 'meta_key')).array_push(rt.get_property(var_migrate_row, 'meta_value'))
		}
	}
	return var_to_migrate.dup()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) get_already_migrated_records(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_destination_table_name := this.schema_config.array_get('destination').array_get('meta').array_get('table_name')
	mut var_destination_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_id_column')
	mut var_destination_entity_id_column := this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_column')
	mut var_destination_meta_key_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_key_column')
	mut var_destination_meta_value_column := this.schema_config.array_get('destination').array_get('meta').array_get('meta_value_column')
	mut var_entity_id_type_placeholder := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.get_wpdb_placeholder_for_type(arg_0) }(this.schema_config.array_get('destination').array_get('meta').array_get('entity_id_type'))
	mut var_entity_ids_placeholder := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_entity_ids.array_count()), var_entity_id_type_placeholder.dup()])])
	mut var_data_already_migrated := this.db_get_results(rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT\n\t   ${var_destination_id_column.to_string()} meta_id,\n       ${var_destination_entity_id_column.to_string()} entity_id,\n       ${var_destination_meta_key_column.to_string()} meta_key,\n       ${var_destination_meta_value_column.to_string()} meta_value\nFROM ${var_destination_table_name.to_string()} destination\nWHERE destination.${var_destination_entity_id_column.to_string()} in ( ${var_entity_ids_placeholder.to_string()} ) ORDER BY destination.${var_destination_entity_id_column.to_string()}\n"), var_entity_ids]))
	mut var_already_migrated := rt.new_array()
	{
		mut iter_1 := var_data_already_migrated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_migrate_row := item_1.val
			if !(var_already_migrated.array_isset(rt.get_property(, 'entity_id'))) {
				
			}
			if !(.array_isset()) {
			}
			
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) classify_update_insert_records(mut var_to_migrate Class_Automattic_WooCommerce_Database_Migrations_array, mut var_already_migrated Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_to_migrate_mutated := var_to_migrate
	mut var_already_migrated_mutated := var_already_migrated
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) build_meta_table_query(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	return ''
}

struct Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_metatometatablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_config: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_database_migrations_tablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_migrationhelper() &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_meta_config' {
			this.get_meta_config()
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'fetch_sanitized_migration_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_sanitized_migration_data(dispatch_arg_0)
		}
		'process_migration_batch_for_ids_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_migration_batch_for_ids_core(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_migration_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.process_migration_data(mut dispatch_arg_0)
		}
		'generate_delete_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_delete_sql_for_batch(mut dispatch_arg_0))
		}
		'generate_update_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_update_sql_for_batch(mut dispatch_arg_0))
		}
		'generate_insert_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_insert_sql_for_batch(mut dispatch_arg_0))
		}
		'fetch_data_for_migration_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.fetch_data_for_migration_for_ids(mut dispatch_arg_0)
		}
		'get_already_migrated_records' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_already_migrated_records(mut dispatch_arg_0)
		}
		'classify_update_insert_records' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.classify_update_insert_records(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'build_meta_table_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.build_meta_table_query(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_config' { return this.schema_config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToMetaTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_config' { this.schema_config = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_TableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_database_migrations_metatometatablemigrator_php() {
}
