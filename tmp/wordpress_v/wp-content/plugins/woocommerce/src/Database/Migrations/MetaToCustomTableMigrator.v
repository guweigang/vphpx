import rt

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	rt.PhpObjectBase
pub mut:
		schema_config rt.PhpVal = rt.new_null()
		meta_column_mapping rt.PhpVal = rt.new_null()
		core_column_mapping rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) construct()  {
	this.schema_config = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.escape_schema_for_backtick(arg_0) }(this.get_schema_config())
	this.meta_column_mapping = this.get_meta_column_config()
	this.core_column_mapping = this.get_core_column_mapping()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_schema_config()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_core_column_mapping()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_meta_column_config()  {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_insert_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_value_sql := rt.new_null()
	mut var_column_sql := rt.new_null()
	mut var_table := this.schema_config.array_get('destination').array_get('table_name')
	// unsupported assign target: Expr_List
	return "INSERT INTO ${var_table.to_string()} (`${var_column_sql.to_string()}`) VALUES ${var_value_sql.to_string()};"
	// unsupported statement: Stmt_Nop
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_update_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array, mut var_entity_row_mapping Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_value_sql := rt.new_null()
	mut var_column_sql := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_table := this.schema_config.array_get('destination').array_get('table_name')
	mut var_destination_primary_id_schema := this.get_destination_table_primary_id_schema()
	{
		mut iter_1 := var_batch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			mut var_entity_id := item_1.key
			var_batch.array_get_mut(var_entity_id).array_set(var_destination_primary_id_schema.array_get('destination_primary_key').array_get('destination'), rt.get_property(var_entity_row_mapping.array_get(var_entity_id), 'destination_id'))
		}
	}
	// unsupported assign target: Expr_List
	mut var_duplicate_update_key_statement := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.generate_on_duplicate_statement_clause(arg_0) }(var_columns.dup())
	return "INSERT INTO ${var_table.to_string()} (`${var_column_sql.to_string()}`) VALUES ${var_value_sql.to_string()} ${var_duplicate_update_key_statement.to_string()};"
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_destination_table_primary_id_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'destination_primary_key', val: rt.create_array([rt.ArrayItem{ key: 'destination', val: this.schema_config.array_get('destination').array_get('primary_key') }, rt.ArrayItem{ key: 'type', val: this.schema_config.array_get('destination').array_get('primary_key_type') }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_column_clauses(mut var_columns_schema Class_Automattic_WooCommerce_Database_Migrations_array, mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_columns := rt.new_array()
	mut var_placeholders := rt.new_array()
	{
		mut iter_1 := var_columns_schema.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schema := item_1.val
			mut var_prev_column := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_schema.array_get('destination'), var_columns.dup(), rt.new_bool(true)])) {
				continue
			}
			var_columns.array_push(var_schema.array_get('destination'))
			var_placeholders.array_push(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}; return temp.get_wpdb_placeholder_for_type(arg_0) }(var_schema.array_get('type')))
		}
	}
	mut var_values := rt.new_array()
	{
		mut iter_1 := rt.call_function('array_values', [var_batch]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			mut var_row_values := rt.new_array()
			{
				mut iter_2 := var_columns.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_column := item_2.val
					mut var_index := item_2.key
					if rt.is_true(rt.new_bool(!(var_row.array_isset(var_column)) || rt.is_true(rt.new_bool(var_row.array_get(var_column).is_null())))) {
						var_row_values.array_push('NULL')
					} else {
						var_row_values.array_push(rt.call_method(var_wpdb, 'prepare', [var_placeholders.array_get(var_index), var_row.array_get(var_column)]))
					}
				}
			}
			mut var_value_string := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_row_values.dup()])).str() + ')')
			var_values.array_push(var_value_string.dup())
		}
	}
	mut var_value_sql := rt.call_function('implode', [rt.new_string(','), var_values.dup()])
	mut var_column_sql := rt.call_function('implode', [rt.new_string('`, `'), var_columns.dup()])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_value_sql }, rt.ArrayItem{ key: none, val: var_column_sql }, rt.ArrayItem{ key: none, val: var_columns }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fetch_sanitized_migration_data(var_entity_ids rt.PhpVal) rt.PhpVal {
	mut var_entity_ids_mutated := var_entity_ids
	this.clear_errors()
	mut var_data := this.fetch_data_for_migration_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_ids_mutated))
	{
		mut iter_1 := var_data.array_get('errors').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_errors := item_1.val
			mut var_entity_id := item_1.key
			{
				mut iter_2 := var_errors.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_error_message := item_2.val
					mut var_column_name := item_2.key
					this.add_error(rt.new_string("Error importing data for post with id ${var_entity_id.to_string()}: column ${var_column_name.to_string()}: ${var_error_message.to_string()}"))
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data.array_get('data') }, rt.ArrayItem{ key: 'errors', val: this.get_errors() }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_migration_batch_for_ids_core(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array)  {
	mut var_entity_ids_mutated := var_entity_ids
	mut var_data := this.fetch_sanitized_migration_data(rt.new_object('Automattic_WooCommerce_Database_Migrations_array', []string{}, var_entity_ids_mutated))
	this.process_migration_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_data))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_migration_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_data_mutated := var_data
	this.clear_errors()
	mut var_exception := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_data_mutated.array_isset(rt.new_string('data'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.array_get('data').is_array()))))))) || var_data_mutated.array_get('data').array_count() == 0)) {
		return rt.create_array([rt.ArrayItem{ key: 'errors', val: this.get_errors() }, rt.ArrayItem{ key: 'exception', val: rt.new_null() }])
	}
	mut var_entity_ids := rt.func_array_keys(var_data_mutated.array_get('data'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_existing_records := this.get_already_existing_records(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_ids))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_to_insert := rt.call_function('array_diff_key', [var_data_mutated.array_get('data'), var_existing_records.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.process_insert_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_insert))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_to_update := rt.call_function('array_intersect_key', [var_data_mutated.array_get('data'), var_existing_records.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.process_update_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_update), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_existing_records))
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

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_insert_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array)  {
	if 0 == var_batch.array_count() {
		return rt.new_null()
	}
	mut var_queries := rt.new_string(this.generate_insert_sql_for_batch(mut var_batch))
	mut var_processed_rows_count := this.db_query(var_queries.dup())
	this.maybe_add_insert_or_update_error(rt.new_string('insert'), var_processed_rows_count.dup())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_update_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array, mut var_ids_mapping Class_Automattic_WooCommerce_Database_Migrations_array)  {
	if 0 == var_batch.array_count() {
		return rt.new_null()
	}
	mut var_queries := rt.new_string(this.generate_update_sql_for_batch(mut var_batch, mut var_ids_mapping))
	mut var_processed_rows_count := rt.div(this.db_query(var_queries.dup()), rt.new_int(2))
	this.maybe_add_insert_or_update_error(rt.new_string('update'), var_processed_rows_count.dup())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fetch_data_for_migration_for_ids(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_entity_ids_mutated := var_entity_ids
	if !rt.is_true(var_entity_ids_mutated) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() }, rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	}
	mut var_entity_table_query := rt.new_string(this.build_entity_table_query(mut var_entity_ids_mutated))
	mut var_entity_data := this.db_get_results(var_entity_table_query.dup())
	if !rt.is_true(var_entity_data) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() }, rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	}
	mut var_entity_meta_rel_ids := rt.call_function('array_column', [var_entity_data.dup(), rt.new_string('entity_meta_rel_id')])
	mut var_meta_table_query := rt.new_string(this.build_meta_data_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_meta_rel_ids)))
	mut var_meta_data := this.db_get_results(var_meta_table_query.dup())
	return this.process_and_sanitize_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_data), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_meta_data))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_already_existing_records(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	// unsupported statement: Stmt_Global
	mut var_source_table := this.schema_config.array_get('source').array_get('entity').array_get('table_name')
	mut var_source_destination_join_column := this.schema_config.array_get('source').array_get('entity').array_get('destination_rel_column')
	mut var_source_primary_key_column := this.schema_config.array_get('source').array_get('entity').array_get('primary_key')
	mut var_destination_table := this.schema_config.array_get('destination').array_get('table_name')
	mut var_destination_source_join_column := this.schema_config.array_get('destination').array_get('source_rel_column')
	mut var_destination_primary_key_column := this.schema_config.array_get('destination').array_get('primary_key')
	mut var_entity_id_placeholder := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_entity_ids_mutated.dup().array_count()), rt.new_string('%d')])])
	mut var_additional_where := rt.new_string(this.get_additional_where_clause_for_get_data_to_insert_or_update(mut var_entity_ids_mutated))
	mut var_already_migrated_entity_ids := this.db_get_results(rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT source.`${var_source_primary_key_column.to_string()}` as source_id, destination.`${var_destination_primary_key_column.to_string()}` as destination_id\nFROM `${var_destination_table.to_string()}` destination\nJOIN `${var_source_table.to_string()}` source ON source.`${var_source_destination_join_column.to_string()}` = destination.`${var_destination_source_join_column.to_string()}`\nWHERE source.`${var_source_primary_key_column.to_string()}` IN ( ${var_entity_id_placeholder.to_string()} ) ${var_additional_where.to_string()}\n"), var_entity_ids_mutated.dup()]))
	return rt.call_function('array_column', [var_already_migrated_entity_ids.dup(), rt.new_null(), rt.new_string('source_id')])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_additional_where_clause_for_get_data_to_insert_or_update(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_entity_ids_mutated := var_entity_ids
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_entity_table_query(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	// unsupported statement: Stmt_Global
	mut var_source_entity_table := this.schema_config.array_get('source').array_get('entity').array_get('table_name')
	mut var_source_meta_rel_id_column := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'), var_source_entity_table), rt.new_string('`.`')), this.schema_config.array_get('source').array_get('entity').array_get('meta_rel_column')), rt.new_string('`')))
	mut var_source_primary_key_column := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'), var_source_entity_table), rt.new_string('`.`')), this.schema_config.array_get('source').array_get('entity').array_get('primary_key')), rt.new_string('`')))
	mut var_where_clause := rt.new_string("${var_source_primary_key_column.to_string()} IN (" + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_entity_ids_mutated.dup().array_count()), rt.new_string('%d')])])).str() + ')')
	mut var_entity_keys := rt.new_array()
	{
		mut iter_1 := this.core_column_mapping.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_schema := item_1.val
			mut var_column_name := item_1.key
			if var_column_schema.array_isset(rt.new_string('select_clause')) {
				mut var_select_clause := var_column_schema.array_get('select_clause')
				var_entity_keys.array_push("${var_select_clause.to_string()} AS ${var_column_name.to_string()}")
			} else {
				var_entity_keys.array_push("${var_source_entity_table.to_string()}.${var_column_name.to_string()}")
			}
		}
	}
	mut var_entity_column_string := rt.call_function('implode', [rt.new_string(', '), var_entity_keys.dup()])
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.new_string("\nSELECT\n\t${var_source_meta_rel_id_column.to_string()} as entity_meta_rel_id,\n    ${var_source_primary_key_column.to_string()} as primary_key_id,\n\t${var_entity_column_string.to_string()}\nFROM `${var_source_entity_table.to_string()}`\nWHERE ${var_where_clause.to_string()};\n"), var_entity_ids_mutated.dup()])
	return (var_query).str()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_meta_data_query(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	// unsupported statement: Stmt_Global
	mut var_meta_table := .array_get()
	mut var_meta_keys := 
	
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_and_sanitize_data(mut var_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_meta_data Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_entity_data_mutated := var_entity_data
	mut var_meta_data_mutated := var_meta_data
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_and_sanitize_entity_data(mut var_sanitized_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_error_records Class_Automattic_WooCommerce_Database_Migrations_array, mut var_entity_data Class_Automattic_WooCommerce_Database_Migrations_array)  {
	mut var_sanitized_entity_data_mutated := var_sanitized_entity_data
	mut var_error_records_mutated := var_error_records
	mut var_entity_data_mutated := var_entity_data
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) processs_and_sanitize_meta_data(mut var_sanitized_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_error_records Class_Automattic_WooCommerce_Database_Migrations_array, mut var_meta_data Class_Automattic_WooCommerce_Database_Migrations_array)  {
	mut var_sanitized_entity_data_mutated := var_sanitized_entity_data
	mut var_error_records_mutated := var_error_records
	mut var_meta_data_mutated := var_meta_data
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) validate_data(var_value rt.PhpVal, type string) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_migrated_data(mut var_source_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_verification_query(var_source_ids rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fill_source_metadata(var_results rt.PhpVal, var_source_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_results_mutated := var_results
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_where_clause_for_verification(var_source_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_data(var_collected_data rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_entity_columns(var_row rt.PhpVal, var_failed_ids rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_failed_ids_mutated := var_failed_ids
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_meta_columns(var_row rt.PhpVal, var_failed_ids rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_failed_ids_mutated := var_failed_ids
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) pre_process_row(var_row rt.PhpVal, var_schema rt.PhpVal, var_alias rt.PhpVal, var_destination_alias rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_alias_mutated := var_alias
	mut var_destination_alias_mutated := var_destination_alias
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_type_defaults(var_type rt.PhpVal)  {
}

struct Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_metatocustomtablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
		schema_config: rt.new_null()
		meta_column_mapping: rt.new_null()
		core_column_mapping: rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_schema_config' {
			this.get_schema_config()
			return rt.new_null()
		}
		'get_core_column_mapping' {
			this.get_core_column_mapping()
			return rt.new_null()
		}
		'get_meta_column_config' {
			this.get_meta_column_config()
			return rt.new_null()
		}
		'generate_insert_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_insert_sql_for_batch(mut dispatch_arg_0))
		}
		'generate_update_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.generate_update_sql_for_batch(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_destination_table_primary_id_schema' {
			return this.get_destination_table_primary_id_schema()
		}
		'generate_column_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.generate_column_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
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
		'process_insert_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.process_insert_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_update_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.process_update_batch(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'fetch_data_for_migration_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.fetch_data_for_migration_for_ids(mut dispatch_arg_0)
		}
		'get_already_existing_records' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_already_existing_records(mut dispatch_arg_0)
		}
		'get_additional_where_clause_for_get_data_to_insert_or_update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_additional_where_clause_for_get_data_to_insert_or_update(mut dispatch_arg_0))
		}
		'build_entity_table_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.build_entity_table_query(mut dispatch_arg_0))
		}
		'build_meta_data_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.build_meta_data_query(mut dispatch_arg_0))
		}
		'process_and_sanitize_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.process_and_sanitize_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'process_and_sanitize_entity_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.process_and_sanitize_entity_data(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'processs_and_sanitize_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.processs_and_sanitize_meta_data(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'validate_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.validate_data(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_migrated_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.verify_migrated_data(mut dispatch_arg_0)
		}
		'build_verification_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.build_verification_query(dispatch_arg_0))
		}
		'fill_source_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.fill_source_metadata(dispatch_arg_0, dispatch_arg_1)
		}
		'get_where_clause_for_verification' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_where_clause_for_verification(dispatch_arg_0)
		}
		'verify_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.verify_data(dispatch_arg_0)
		}
		'verify_entity_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.verify_entity_columns(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_meta_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.verify_meta_columns(dispatch_arg_0, dispatch_arg_1)
		}
		'pre_process_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.pre_process_row(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_type_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_type_defaults(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema_config' { return this.schema_config }
		'meta_column_mapping' { return this.meta_column_mapping }
		'core_column_mapping' { return this.core_column_mapping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema_config' { this.schema_config = val; return true }
		'meta_column_mapping' { this.meta_column_mapping = val; return true }
		'core_column_mapping' { this.core_column_mapping = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_src_database_migrations_metatocustomtablemigrator_php() {
}
