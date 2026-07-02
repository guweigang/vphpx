import rt

struct Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	rt.PhpObjectBase
pub mut:
	schema_config       rt.PhpVal = rt.new_null()
	meta_column_mapping rt.PhpVal = rt.new_null()
	core_column_mapping rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}
	mut iife_result_0 := iife_temp_0.escape_schema_for_backtick(this.get_schema_config())
	this.schema_config = iife_result_0
	this.meta_column_mapping = this.get_meta_column_config()
	this.core_column_mapping = this.get_core_column_mapping()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_schema_config() {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_core_column_mapping() {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_meta_column_config() {
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_insert_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_value_sql := rt.new_null()
	mut var_column_sql := rt.new_null()
	mut var_table :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name'))
	mut list_tmp_1 := this.generate_column_clauses(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](rt.call_function('array_merge', [
		this.core_column_mapping,
		this.meta_column_mapping,
	])), mut var_batch)
	var_value_sql = list_tmp_1.array_get(0)
	var_column_sql = list_tmp_1.array_get(1)
	return 'INSERT INTO ${var_table.to_string()} (`${var_column_sql.to_string()}`) VALUES ${var_value_sql.to_string()};'
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_update_sql_for_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array, mut var_entity_row_mapping Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_value_sql := rt.new_null()
	mut var_column_sql := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_table :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name'))
	mut var_destination_primary_id_schema := this.get_destination_table_primary_id_schema()
	mut iter_1 := var_batch.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		mut var_entity_id := item_1.key
		var_batch.array_get_mut(var_entity_id).array_set(var_destination_primary_id_schema.array_get(rt.new_string('destination_primary_key')).array_get(rt.new_string('destination')), rt.get_property(var_entity_row_mapping.array_get(var_entity_id),
			'destination_id'))
	}
	mut list_tmp_2 := this.generate_column_clauses(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](rt.call_function('array_merge', [
		var_destination_primary_id_schema.clone(),
		this.core_column_mapping,
		this.meta_column_mapping,
	])), mut var_batch)
	var_value_sql = list_tmp_2.array_get(0)
	var_column_sql = list_tmp_2.array_get(1)
	var_columns = list_tmp_2.array_get(2)
	mut iife_temp_1 := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}
	mut iife_result_1 := iife_temp_1.generate_on_duplicate_statement_clause(var_columns.clone())
	mut var_duplicate_update_key_statement := iife_result_1
	return 'INSERT INTO ${var_table.to_string()} (`${var_column_sql.to_string()}`) VALUES ${var_value_sql.to_string()} ${var_duplicate_update_key_statement.to_string()};'
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_destination_table_primary_id_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'destination_primary_key', val: rt.create_array([
			rt.ArrayItem{
				key: 'destination'
				val: this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('primary_key'))
			},
			rt.ArrayItem{
				key: 'type'
				val: this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('primary_key_type'))
			},
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) generate_column_clauses(mut var_columns_schema Class_Automattic_WooCommerce_Database_Migrations_array, mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_columns := rt.new_array()
	mut var_placeholders := rt.new_array()
	mut iter_2 := var_columns_schema.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_schema := item_2.val
		mut var_prev_column := item_2.key
		if rt.is_true(rt.call_function('in_array', [
			var_schema.array_get(rt.new_string('destination')),
			var_columns.clone(),
			rt.new_bool(true),
		]))
		{
			continue
		}
		var_columns.array_push(var_schema.array_get(rt.new_string('destination')))
		mut iife_temp_2 := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}
		mut iife_result_2 :=
			iife_temp_2.get_wpdb_placeholder_for_type(var_schema.array_get(rt.new_string('type')))
		var_placeholders.array_push(iife_result_2)
	}
	mut var_values := rt.new_array()
	mut iter_3 := rt.call_function('array_values', [var_batch]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_row := item_3.val
		mut var_row_values := rt.new_array()
		mut iter_4 := var_columns.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_column := item_4.val
			mut var_index := item_4.key
			if !(var_row.array_isset(var_column)) || var_row.array_get(var_column).is_null() {
				var_row_values.array_push('NULL')
			} else {
				var_row_values.array_push(rt.call_method(var_wpdb, 'prepare', [
					var_placeholders.array_get(var_index),
					var_row.array_get(var_column),
				]))
			}
		}
		mut var_value_string := rt.new_string('(' +
			(rt.call_function('implode', [rt.new_string(','), var_row_values.clone()])).str() + ')')
		var_values.array_push(var_value_string.clone())
	}
	mut var_value_sql := rt.call_function('implode', [rt.new_string(','),
		var_values.clone()])
	mut var_column_sql := rt.call_function('implode', [rt.new_string('`, `'),
		var_columns.clone()])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_value_sql },
		rt.ArrayItem{ key: none, val: var_column_sql }, rt.ArrayItem{ key: none, val: var_columns }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fetch_sanitized_migration_data(var_entity_ids rt.PhpVal) rt.PhpVal {
	mut var_entity_ids_mutated := var_entity_ids
	this.clear_errors()
	mut var_data :=
		this.fetch_data_for_migration_for_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_ids_mutated))
	mut iter_5 := var_data.array_get(rt.new_string('errors')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_errors := item_5.val
		mut var_entity_id := item_5.key
		mut iter_6 := var_errors.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_error_message := item_6.val
			mut var_column_name := item_6.key
			this.add_error(rt.new_string('Error importing data for post with id ${var_entity_id.to_string()}: column ${var_column_name.to_string()}: ${var_error_message.to_string()}'))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'data', val: var_data.array_get(rt.new_string('data')) },
		rt.ArrayItem{ key: 'errors', val: this.get_errors() },
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_migration_batch_for_ids_core(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_entity_ids_mutated := var_entity_ids
	mut var_data := this.fetch_sanitized_migration_data(rt.new_object('Automattic_WooCommerce_Database_Migrations_array',
		[]string{}, var_entity_ids_mutated))
	this.process_migration_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_data))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_migration_data(mut var_data Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_data_mutated := var_data
	this.clear_errors()
	mut var_exception := rt.new_null()
	if !(var_data_mutated.array_isset(rt.new_string('data')))
		|| !(var_data_mutated.array_get(rt.new_string('data')).is_array())
		|| var_data_mutated.array_get(rt.new_string('data')).array_count() == 0 {
		return rt.create_array([rt.ArrayItem{ key: 'errors', val: this.get_errors() },
			rt.ArrayItem{ key: 'exception', val: rt.new_null() }])
	}
	mut var_entity_ids := rt.func_array_keys(var_data_mutated.array_get(rt.new_string('data')))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_existing_records :=
		this.get_already_existing_records(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_ids))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_to_insert := rt.call_function('array_diff_key', [
		var_data_mutated.array_get(rt.new_string('data')),
		var_existing_records.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.process_insert_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_insert))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_to_update := rt.call_function('array_intersect_key', [
		var_data_mutated.array_get(rt.new_string('data')),
		var_existing_records.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.process_update_batch(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_to_update), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_existing_records))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Database_Migrations_Exception') {
		mut var_e := var_e_1.clone()
		var_exception = var_e
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.create_array([rt.ArrayItem{ key: 'errors', val: this.get_errors() },
		rt.ArrayItem{ key: 'exception', val: var_exception }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_insert_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array) {
	if 0 == var_batch.array_count() {
		return
	}
	mut var_queries := rt.new_string(this.generate_insert_sql_for_batch(mut var_batch))
	mut var_processed_rows_count := this.db_query(var_queries.clone())
	this.maybe_add_insert_or_update_error(rt.new_string('insert'), var_processed_rows_count.clone())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_update_batch(mut var_batch Class_Automattic_WooCommerce_Database_Migrations_array, mut var_ids_mapping Class_Automattic_WooCommerce_Database_Migrations_array) {
	if 0 == var_batch.array_count() {
		return
	}
	mut var_queries := rt.new_string(this.generate_update_sql_for_batch(mut var_batch, mut
		var_ids_mapping))
	mut var_processed_rows_count := rt.div(this.db_query(var_queries.clone()), rt.new_int(2))
	this.maybe_add_insert_or_update_error(rt.new_string('update'), var_processed_rows_count.clone())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fetch_data_for_migration_for_ids(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_entity_ids_mutated := var_entity_ids
	if !rt.is_true(var_entity_ids_mutated) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() },
			rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	}
	mut var_entity_table_query :=
		rt.new_string(this.build_entity_table_query(mut var_entity_ids_mutated))
	mut var_entity_data := this.db_get_results(var_entity_table_query.clone())
	if !rt.is_true(var_entity_data) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() },
			rt.ArrayItem{ key: 'errors', val: rt.new_array() }])
	}
	mut var_entity_meta_rel_ids := rt.call_function('array_column', [
		var_entity_data.clone(), rt.new_string('entity_meta_rel_id')])
	mut var_meta_table_query :=
		rt.new_string(this.build_meta_data_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_meta_rel_ids)))
	mut var_meta_data := this.db_get_results(var_meta_table_query.clone())
	return this.process_and_sanitize_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_entity_data), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_meta_data))
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_already_existing_records(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	mut var_source_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name'))
	mut var_source_destination_join_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('destination_rel_column'))
	mut var_source_primary_key_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key'))
	mut var_destination_table :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name'))
	mut var_destination_source_join_column :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('source_rel_column'))
	mut var_destination_primary_key_column :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('primary_key'))
	mut var_entity_id_placeholder := rt.call_function('implode', [
		rt.new_string(','),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_entity_ids_mutated.array_count()),
			rt.new_string('%d')])])
	mut var_additional_where :=
		rt.new_string(this.get_additional_where_clause_for_get_data_to_insert_or_update(mut var_entity_ids_mutated))
	mut var_already_migrated_entity_ids := this.db_get_results(rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('\nSELECT source.`${var_source_primary_key_column.to_string()}` as source_id, destination.`${var_destination_primary_key_column.to_string()}` as destination_id\nFROM `${var_destination_table.to_string()}` destination\nJOIN `${var_source_table.to_string()}` source ON source.`${var_source_destination_join_column.to_string()}` = destination.`${var_destination_source_join_column.to_string()}`\nWHERE source.`${var_source_primary_key_column.to_string()}` IN ( ${var_entity_id_placeholder.to_string()} ) ${var_additional_where.to_string()}\n'),
		var_entity_ids_mutated,
	]))
	return rt.call_function('array_column', [var_already_migrated_entity_ids.clone(),
		rt.new_null(), rt.new_string('source_id')])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_additional_where_clause_for_get_data_to_insert_or_update(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_entity_ids_mutated := var_entity_ids
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_entity_table_query(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	mut var_source_entity_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name'))
	mut var_source_meta_rel_id_column := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'),
		var_source_entity_table), rt.new_string('`.`')),
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('meta_rel_column'))),
		rt.new_string('`'))).str())
	mut var_source_primary_key_column := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('`'),
		var_source_entity_table), rt.new_string('`.`')),
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key'))),
		rt.new_string('`'))).str())
	mut var_where_clause := rt.new_string(
		'${var_source_primary_key_column.to_string()} IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_entity_ids_mutated.array_count()), rt.new_string('%d')])])).str() +
		')')
	mut var_entity_keys := rt.new_array()
	mut iter_7 := this.core_column_mapping.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_column_schema := item_7.val
		mut var_column_name := item_7.key
		if var_column_schema.array_isset(rt.new_string('select_clause')) {
			mut var_select_clause := var_column_schema.array_get(rt.new_string('select_clause'))
			var_entity_keys.array_push('${var_select_clause.to_string()} AS ${var_column_name.to_string()}')
		} else {
			var_entity_keys.array_push('${var_source_entity_table.to_string()}.${var_column_name.to_string()}')
		}
	}
	mut var_entity_column_string := rt.call_function('implode', [
		rt.new_string(', '), var_entity_keys.clone()])
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('\nSELECT\n\t${var_source_meta_rel_id_column.to_string()} as entity_meta_rel_id,\n    ${var_source_primary_key_column.to_string()} as primary_key_id,\n\t${var_entity_column_string.to_string()}\nFROM `${var_source_entity_table.to_string()}`\nWHERE ${var_where_clause.to_string()};\n'),
		var_entity_ids_mutated,
	])
	return var_query.str()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_meta_data_query(mut var_entity_ids Class_Automattic_WooCommerce_Database_Migrations_array) string {
	mut var_wpdb := rt.new_null()
	mut var_entity_ids_mutated := var_entity_ids
	mut var_meta_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('table_name'))
	mut var_meta_keys := rt.func_array_keys(this.meta_column_mapping)
	mut var_meta_key_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('meta_key_column'))
	mut var_meta_value_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('meta_value_column'))
	mut var_meta_table_relational_key :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('entity_id_column'))
	mut var_meta_column_string := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_meta_keys.clone().array_count()), rt.new_string('%s')])])
	mut var_entity_id_string := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_entity_ids_mutated.array_count()),
			rt.new_string('%d')])])
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('\nSELECT `${var_meta_table_relational_key.to_string()}` as entity_id, `${var_meta_key_column.to_string()}` as meta_key, `${var_meta_value_column.to_string()}` as meta_value\nFROM `${var_meta_table.to_string()}`\nWHERE\n\t`${var_meta_table_relational_key.to_string()}` IN ( ${var_entity_id_string.to_string()} )\n\tAND `${var_meta_key_column.to_string()}` IN ( ${var_meta_column_string.to_string()} );\n'),
		rt.call_function('array_merge', [var_entity_ids_mutated, var_meta_keys.clone()]),
	])
	return var_query.str()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_and_sanitize_data(mut var_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_meta_data Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_entity_data_mutated := var_entity_data
	mut var_meta_data_mutated := var_meta_data
	mut var_sanitized_entity_data := rt.new_array()
	mut var_error_records := rt.new_array()
	this.process_and_sanitize_entity_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_sanitized_entity_data), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_error_records), mut
		var_entity_data_mutated)
	this.processs_and_sanitize_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_sanitized_entity_data), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](var_error_records), mut
		var_meta_data_mutated)
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_sanitized_entity_data },
		rt.ArrayItem{ key: 'errors', val: var_error_records }])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) process_and_sanitize_entity_data(mut var_sanitized_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_error_records Class_Automattic_WooCommerce_Database_Migrations_array, mut var_entity_data Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_sanitized_entity_data_mutated := var_sanitized_entity_data
	mut var_error_records_mutated := var_error_records
	mut var_entity_data_mutated := var_entity_data
	mut iter_8 := var_entity_data_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_entity := item_8.val
		mut var_row_data := rt.new_array()
		mut iter_9 := this.core_column_mapping.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_schema := item_9.val
			mut var_column_name := item_9.key
			mut var_custom_table_column_name := if !(var_schema.array_get(rt.new_string('destination'))).is_null() {
				var_schema.array_get(rt.new_string('destination'))
			} else {
				var_column_name
			}
			mut var_value := rt.get_property(var_entity,
				'{"nodeType":"Expr_Variable","line":538,"name":"column_name"}')
			var_value = this.validate_data(var_value.clone(),
				(var_schema.array_get(rt.new_string('type'))).str())
			if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
				var_error_records_mutated.array_get_mut(rt.get_property(var_entity,
					'primary_key_id')).array_set(var_custom_table_column_name, rt.call_method(var_value,
					'get_error_code', []rt.PhpVal{}))
			} else {
				var_row_data.array_set(var_custom_table_column_name, var_value.clone())
			}
		}
		var_sanitized_entity_data_mutated.array_set(rt.get_property(var_entity,
			'entity_meta_rel_id'), var_row_data.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) processs_and_sanitize_meta_data(mut var_sanitized_entity_data Class_Automattic_WooCommerce_Database_Migrations_array, mut var_error_records Class_Automattic_WooCommerce_Database_Migrations_array, mut var_meta_data Class_Automattic_WooCommerce_Database_Migrations_array) {
	mut var_sanitized_entity_data_mutated := var_sanitized_entity_data
	mut var_error_records_mutated := var_error_records
	mut var_meta_data_mutated := var_meta_data
	mut iter_10 := var_meta_data_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_datum := item_10.val
		mut var_column_schema := this.meta_column_mapping.array_get(rt.get_property(var_datum,
			'meta_key'))
		if var_sanitized_entity_data_mutated.array_get(rt.get_property(var_datum, 'entity_id')).array_isset(var_column_schema.array_get(rt.new_string('destination'))) {
			continue
		}
		mut var_value := this.validate_data(rt.get_property(var_datum, 'meta_value'),
			(var_column_schema.array_get(rt.new_string('type'))).str())
		if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
			var_error_records_mutated.array_get_mut(rt.get_property(var_datum, 'entity_id')).array_set(var_column_schema.array_get(rt.new_string('destination')), rt.concat(rt.concat(rt.call_method(var_value,
				'get_error_code', []rt.PhpVal{}), rt.new_string(': ')), rt.call_method(var_value,
				'get_error_message', []rt.PhpVal{})))
		} else {
			var_sanitized_entity_data_mutated.array_get_mut(rt.get_property(var_datum, 'entity_id')).array_set(var_column_schema.array_get(rt.new_string('destination')),
				var_value.clone())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) validate_data(var_value rt.PhpVal, type string) rt.PhpVal {
	mut var_value_mutated := var_value
	mut switch_val_1 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal'))) {
		var_value_mutated = rt.call_function('wc_format_decimal', [
			rt.new_float(var_value_mutated.clone().to_f64()),
			rt.new_bool(false),
			rt.new_bool(true),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		var_value_mutated = rt.new_int(var_value_mutated.to_i64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bool'))) {
		var_value_mutated = rt.call_function('wc_string_to_bool', [
			var_value_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date'))) {
		if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
			var_value_mutated = rt.new_null()
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		} else {
			var_value_mutated = rt.call_method(create_automattic_woocommerce_database_migrations_datetime(var_value_mutated.clone()),
				'format', [rt.new_string('Y-m-d H:i:s')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Database_Migrations_Exception') {
			mut var_e := var_e_2.clone()
			return rt.new_object('Automattic_WooCommerce_Database_Migrations_WP_Error', []string{}, create_automattic_woocommerce_database_migrations_wp_error(rt.call_method(var_e,
				'getMessage', []rt.PhpVal{})))
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_epoch'))) {
		if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
			var_value_mutated = rt.new_null()
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
		} else {
			var_value_mutated = rt.call_method(create_automattic_woocommerce_database_migrations_datetime(rt.new_string('@${var_value.to_string()}')),
				'format', [rt.new_string('Y-m-d H:i:s')])
			if rt.has_exception() {
				unsafe {
					goto catch_label_3
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		unsafe {
			goto end_label_3
		}
		catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Automattic_WooCommerce_Database_Migrations_Exception') {
			var_e = var_e_3.clone()
			return rt.new_object('Automattic_WooCommerce_Database_Migrations_WP_Error', []string{}, create_automattic_woocommerce_database_migrations_wp_error(rt.call_method(var_e,
				'getMessage', []rt.PhpVal{})))
			unsafe {
				goto end_label_3
			}
		} else {
			rt.throw_exception(var_e_3)
			unsafe {
				goto end_label_3
			}
		}

		end_label_3:
	}
	return var_value_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_migrated_data(mut var_source_ids Class_Automattic_WooCommerce_Database_Migrations_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.new_string(this.build_verification_query(rt.new_object('Automattic_WooCommerce_Database_Migrations_array',
		[]string{}, var_source_ids)))
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		var_query.clone(), rt.get_constant('ARRAY_A')])
	var_results = this.fill_source_metadata(var_results.clone(), rt.new_object('Automattic_WooCommerce_Database_Migrations_array',
		[]string{}, var_source_ids))
	return this.verify_data(var_results.clone())
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) build_verification_query(var_source_ids rt.PhpVal) string {
	mut var_source_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name'))
	mut var_destination_table :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name'))
	mut var_destination_source_rel_column :=
		this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('source_rel_column'))
	mut var_source_destination_rel_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('destination_rel_column'))
	mut var_source_destination_join_clause :=
		rt.new_string('${var_destination_table.to_string()} ON ${var_destination_table.to_string()}.${var_destination_source_rel_column.to_string()} = ${var_source_table.to_string()}.${var_source_destination_rel_column.to_string()}')
	mut var_meta_select_clauses := rt.new_array()
	mut var_source_select_clauses := rt.new_array()
	mut var_destination_select_clauses := rt.new_array()
	mut iter_11 := this.core_column_mapping.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_schema := item_11.val
		mut var_column_name := item_11.key
		mut var_source_select_column := if var_schema.array_isset(rt.new_string('select_clause')) {
			var_schema.array_get(rt.new_string('select_clause'))
		} else {
			rt.new_string('${var_source_table.to_string()}.${var_column_name.to_string()}')
		}
		var_source_select_clauses.array_push('${var_source_select_column.to_string()} as ${var_source_table.to_string()}_${var_column_name.to_string()}')
		var_destination_select_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_destination_table,
			rt.new_string('.')), var_schema.array_get(rt.new_string('destination'))),
			rt.new_string(' as ')), var_destination_table), rt.new_string('_')),
			var_schema.array_get(rt.new_string('destination'))))
	}
	mut iter_12 := this.meta_column_mapping.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_schema := item_12.val
		mut var_meta_key := item_12.key
		var_destination_select_clauses.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_destination_table,
			rt.new_string('.')), var_schema.array_get(rt.new_string('destination'))),
			rt.new_string(' as ')), var_destination_table), rt.new_string('_')),
			var_schema.array_get(rt.new_string('destination'))))
	}
	mut var_select_clause := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_merge', [var_source_select_clauses.clone(),
			var_meta_select_clauses.clone(), var_destination_select_clauses.clone()])])
	mut var_where_clause := this.get_where_clause_for_verification(var_source_ids.clone())
	return '\nSELECT ${var_select_clause.to_string()}\nFROM ${var_source_table.to_string()}\n    LEFT JOIN ${var_source_destination_join_clause.to_string()}\nWHERE ${var_where_clause.to_string()}\n'
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) fill_source_metadata(var_results rt.PhpVal, var_source_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_results_mutated := var_results
	mut var_meta_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('table_name'))
	mut var_meta_entity_id_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('entity_id_column'))
	mut var_meta_key_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('meta_key_column'))
	mut var_meta_value_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('meta_value_column'))
	mut var_meta_id_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('meta')).array_get(rt.new_string('meta_id_column'))
	mut var_meta_columns := rt.func_array_keys(this.meta_column_mapping)
	mut var_meta_columns_placeholder := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_meta_columns.clone().array_count()),
			rt.new_string('%s')])])
	mut var_source_ids_placeholder := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_source_ids.clone().array_count()),
			rt.new_string('%d')])])
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SELECT ${var_meta_entity_id_column.to_string()} as entity_id, ${var_meta_key_column.to_string()} as meta_key, ${var_meta_value_column.to_string()} as meta_value\n\t\t\tFROM ${var_meta_table.to_string()}\n\t\t\tWHERE ${var_meta_entity_id_column.to_string()} IN (${var_source_ids_placeholder.to_string()})\n\t\t\tAND ${var_meta_key_column.to_string()} IN (${var_meta_columns_placeholder.to_string()})\n\t\t\tORDER BY ${var_meta_id_column.to_string()} ASC'),
		rt.call_function('array_merge', [var_source_ids.clone(),
			var_meta_columns.clone()]),
	])
	mut var_meta_data := rt.call_method(var_wpdb, 'get_results', [
		var_query.clone(), rt.get_constant('ARRAY_A')])
	mut var_source_metadata_rows := rt.new_array()
	mut iter_13 := var_meta_data.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_meta_datum := item_13.val
		if !(var_source_metadata_rows.array_isset(var_meta_datum.array_get(rt.new_string('entity_id')))) {
			var_source_metadata_rows.array_set(var_meta_datum.array_get(rt.new_string('entity_id')),
				rt.new_array())
		}
		mut var_destination_column :=
			this.meta_column_mapping.array_get(var_meta_datum.array_get(rt.new_string('meta_key'))).array_get(rt.new_string('destination'))
		mut var_alias := rt.new_string('meta_source_${var_destination_column.to_string()}')
		if var_source_metadata_rows.array_get(var_meta_datum.array_get(rt.new_string('entity_id'))).array_isset(var_alias) {
			continue
		}
		var_source_metadata_rows.array_get_mut(var_meta_datum.array_get(rt.new_string('entity_id'))).array_set(var_alias,
			var_meta_datum.array_get(rt.new_string('meta_value')))
	}
	mut iter_14 := var_results_mutated.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_result_row := item_14.val
		mut var_index := item_14.key
		mut var_source_id := var_result_row.array_get(rt.new_string(
			(this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name'))).str() +
			'_' +(this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key'))).str()))
		var_results_mutated.array_set(var_index, rt.call_function('array_merge', [
			var_result_row.clone(),
			if !(var_source_metadata_rows.array_get(var_source_id)).is_null() {
				var_source_metadata_rows.array_get(var_source_id)
			} else {
				rt.new_array()
			},
		]))
	}
	return var_results_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_where_clause_for_verification(var_source_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_source_primary_id_column :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key'))
	mut var_source_table :=
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name'))
	mut var_source_ids_placeholder := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_source_ids.clone().array_count()),
			rt.new_string('%d')])])
	return rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('${var_source_table.to_string()}.${var_source_primary_id_column.to_string()} IN (${var_source_ids_placeholder.to_string()})'),
		var_source_ids.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_data(var_collected_data rt.PhpVal) rt.PhpVal {
	mut var_failed_ids := rt.new_array()
	mut iter_15 := var_collected_data.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_row := item_15.val
		var_failed_ids = this.verify_entity_columns(var_row.clone(), var_failed_ids.clone())
		var_failed_ids = this.verify_meta_columns(var_row.clone(), var_failed_ids.clone())
	}
	return var_failed_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_entity_columns(var_row rt.PhpVal, var_failed_ids rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_failed_ids_mutated := var_failed_ids
	mut var_primary_key_column := rt.new_string((rt.concat(rt.concat(this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name')),
		rt.new_string('_')),
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key')))).str())
	mut iter_16 := this.core_column_mapping.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_schema := item_16.val
		mut var_column_name := item_16.key
		mut var_source_alias := rt.new_string((rt.concat(rt.concat(this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name')),
			rt.new_string('_')), var_column_name)).str())
		mut var_destination_alias := rt.new_string((rt.concat(rt.concat(this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name')),
			rt.new_string('_')), var_schema.array_get(rt.new_string('destination')))).str())
		var_row_mutated = this.pre_process_row(var_row_mutated.clone(), var_schema.clone(),
			var_source_alias.clone(), var_destination_alias.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_row_mutated.array_get(var_source_alias),
			var_row_mutated.array_get(var_destination_alias)))))
		{
			if !(var_failed_ids_mutated.array_isset(var_row_mutated.array_get(var_primary_key_column))) {
				var_failed_ids_mutated.array_set(var_row_mutated.array_get(var_primary_key_column),
					rt.new_array())
			}
			var_failed_ids_mutated.array_get_mut(var_row_mutated.array_get(var_primary_key_column)).array_push(rt.create_array([
				rt.ArrayItem{ key: 'column', val: var_column_name },
				rt.ArrayItem{
					key: 'original_value'
					val: var_row_mutated.array_get(var_source_alias)
				},
				rt.ArrayItem{
					key: 'new_value'
					val: var_row_mutated.array_get(var_destination_alias)
				},
			]))
		}
	}
	return var_failed_ids_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) verify_meta_columns(var_row rt.PhpVal, var_failed_ids rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_failed_ids_mutated := var_failed_ids
	mut var_primary_key_column := rt.new_string((rt.concat(rt.concat(this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('table_name')),
		rt.new_string('_')),
		this.schema_config.array_get(rt.new_string('source')).array_get(rt.new_string('entity')).array_get(rt.new_string('primary_key')))).str())
	mut iter_17 := this.meta_column_mapping.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_schema := item_17.val
		mut var_meta_key := item_17.key
		mut var_meta_alias := rt.new_string((rt.concat(rt.new_string('meta_source_'),
			var_schema.array_get(rt.new_string('destination')))).str())
		mut var_destination_alias := rt.new_string((rt.concat(rt.concat(this.schema_config.array_get(rt.new_string('destination')).array_get(rt.new_string('table_name')),
			rt.new_string('_')), var_schema.array_get(rt.new_string('destination')))).str())
		var_row_mutated = this.pre_process_row(var_row_mutated.clone(), var_schema.clone(),
			var_meta_alias.clone(), var_destination_alias.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_row_mutated.array_get(var_meta_alias),
			var_row_mutated.array_get(var_destination_alias)))))
		{
			if !(var_failed_ids_mutated.array_isset(var_row_mutated.array_get(var_primary_key_column))) {
				var_failed_ids_mutated.array_set(var_row_mutated.array_get(var_primary_key_column),
					rt.new_array())
			}
			var_failed_ids_mutated.array_get_mut(var_row_mutated.array_get(var_primary_key_column)).array_push(rt.create_array([
				rt.ArrayItem{ key: 'column', val: var_meta_key },
				rt.ArrayItem{ key: 'original_value', val: var_row_mutated.array_get(var_meta_alias) },
				rt.ArrayItem{
					key: 'new_value'
					val: var_row_mutated.array_get(var_destination_alias)
				},
			]))
		}
	}
	return var_failed_ids_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) pre_process_row(var_row rt.PhpVal, var_schema rt.PhpVal, var_alias rt.PhpVal, var_destination_alias rt.PhpVal) rt.PhpVal {
	mut var_row_mutated := var_row
	mut var_alias_mutated := var_alias
	mut var_destination_alias_mutated := var_destination_alias
	if !(var_row_mutated.array_isset(var_alias_mutated)) {
		var_row_mutated.array_set(var_alias_mutated,
			this.get_type_defaults(var_schema.array_get(rt.new_string('type'))))
	}
	if rt.is_true(rt.new_bool(var_row_mutated.array_get(var_destination_alias_mutated).is_null())) {
		var_row_mutated.array_set(var_destination_alias_mutated,
			this.get_type_defaults(var_schema.array_get(rt.new_string('type'))))
	}
	if rt.is_true(rt.call_function('in_array', [var_schema.array_get(rt.new_string('type')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'int' },
			rt.ArrayItem{ key: none, val: 'decimal' }, rt.ArrayItem{ key: none, val: 'float' }]),
		rt.new_bool(true)]))
	{
		if rt.is_true(rt.identical(rt.new_string(''), var_row_mutated.array_get(var_alias_mutated)))
			|| rt.is_true(rt.identical(rt.new_null(), var_row_mutated.array_get(var_alias_mutated))) {
			var_row_mutated.array_set(var_alias_mutated, 0)
		}
		var_row_mutated.array_set(var_alias_mutated, rt.call_function('wc_format_decimal', [
			rt.new_float(var_row_mutated.array_get(var_alias_mutated).to_f64()),
			rt.new_bool(false),
			rt.new_bool(true),
		]))
		var_row_mutated.array_set(var_destination_alias_mutated, rt.call_function('wc_format_decimal', [
			rt.new_float(var_row_mutated.array_get(var_destination_alias_mutated).to_f64()),
			rt.new_bool(false),
			rt.new_bool(true),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('bool'), var_schema.array_get(rt.new_string('type')))) {
		var_row_mutated.array_set(var_alias_mutated, rt.call_function('wc_string_to_bool', [
			var_row_mutated.array_get(var_alias_mutated),
		]))
		var_row_mutated.array_set(var_destination_alias_mutated, rt.call_function('wc_string_to_bool', [
			var_row_mutated.array_get(var_destination_alias_mutated),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('date_epoch'),
		var_schema.array_get(rt.new_string('type'))))
	{
		if rt.is_true(rt.identical(rt.new_string(''), var_row_mutated.array_get(var_alias_mutated)))
			|| rt.is_true(rt.identical(rt.new_null(), var_row_mutated.array_get(var_alias_mutated))) {
			var_row_mutated.array_set(var_alias_mutated, rt.new_null())
		} else {
			var_row_mutated.array_set(var_alias_mutated, rt.call_method(create_automattic_woocommerce_database_migrations_datetime(rt.concat(rt.new_string('@'),
				var_row_mutated.array_get(var_alias_mutated))), 'format', [
				rt.new_string('Y-m-d H:i:s'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'),
			var_row_mutated.array_get(var_destination_alias_mutated)))
		{
			var_row_mutated.array_set(var_destination_alias_mutated, rt.new_null())
		}
	}
	return var_row_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator) get_type_defaults(var_type rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('float')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('int')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('decimal'))) {
		return rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('string'))) {
		return rt.new_string('')
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_database_migrations_metatocustomtablemigrator() &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MetaToCustomTableMigrator{
		PhpObjectBase:       rt.PhpObjectBase{}
		schema_config:       rt.new_null()
		meta_column_mapping: rt.new_null()
		core_column_mapping: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_database_migrations_tablemigrator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_TableMigrator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_migrationhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_datetime(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_WP_Error{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_insert_sql_for_batch(mut dispatch_arg_0))
		}
		'generate_update_sql_for_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_update_sql_for_batch(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'get_destination_table_primary_id_schema' {
			return this.get_destination_table_primary_id_schema()
		}
		'generate_column_clauses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.generate_column_clauses(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fetch_sanitized_migration_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_sanitized_migration_data(dispatch_arg_0)
		}
		'process_migration_batch_for_ids_core' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_migration_batch_for_ids_core(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_migration_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.process_migration_data(mut dispatch_arg_0)
		}
		'process_insert_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_insert_batch(mut dispatch_arg_0)
			return rt.new_null()
		}
		'process_update_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.process_update_batch(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'fetch_data_for_migration_for_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.fetch_data_for_migration_for_ids(mut dispatch_arg_0)
		}
		'get_already_existing_records' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_already_existing_records(mut dispatch_arg_0)
		}
		'get_additional_where_clause_for_get_data_to_insert_or_update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_additional_where_clause_for_get_data_to_insert_or_update(mut dispatch_arg_0))
		}
		'build_entity_table_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_entity_table_query(mut dispatch_arg_0))
		}
		'build_meta_data_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_meta_data_query(mut dispatch_arg_0))
		}
		'process_and_sanitize_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.process_and_sanitize_data(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'process_and_sanitize_entity_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.process_and_sanitize_entity_data(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
			return rt.new_null()
		}
		'processs_and_sanitize_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.processs_and_sanitize_meta_data(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
			return rt.new_null()
		}
		'validate_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.validate_data(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_migrated_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Database_Migrations_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			return this.pre_process_row(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_type_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_type_defaults(dispatch_arg_0)
		}
		else {
			return none
		}
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
		'schema_config' {
			this.schema_config = val
			return true
		}
		'meta_column_mapping' {
			this.meta_column_mapping = val
			return true
		}
		'core_column_mapping' {
			this.core_column_mapping = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
