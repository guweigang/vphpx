module databasex

import vphp

@[php_method]
pub fn (mut query VSlimDatabaseQuery) construct() &VSlimDatabaseQuery {
	query.kind = .select_
	query.table_name = ''
	query.select_columns = []string{}
	query.where_clauses = []VSlimDatabaseWhereClause{}
	query.order_clauses = []string{}
	query.limit_count = -1
	query.offset_count = -1
	query.mutation_values = map[string]string{}
	return &query
}

@[php_method: 'setManager']
pub fn (mut query VSlimDatabaseQuery) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseQuery {
	query.manager_ref = manager
	return &query
}

@[php_method]
pub fn (query &VSlimDatabaseQuery) manager() &VSlimDatabaseManager {
	return query.manager_ref
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) reset() &VSlimDatabaseQuery {
	manager := query.manager_ref
	query.construct()
	query.manager_ref = manager
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) table(name string) &VSlimDatabaseQuery {
	query.table_name = database_quote_identifier(name)
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) select(columns vphp.PhpValue) &VSlimDatabaseQuery {
	query.kind = .select_
	query.select_columns = value_subject(columns).database_columns()
	return &query
}

@[php_method: 'where']
pub fn (mut query VSlimDatabaseQuery) where_eq(column string, value vphp.PhpValue) &VSlimDatabaseQuery {
	return query.where_op(column, '=', value)
}

fn (mut query VSlimDatabaseQuery) where_eq_string(column string, value vphp.PhpString) &VSlimDatabaseQuery {
	query.where_clauses << VSlimDatabaseWhereClause{
		column: database_quote_identifier(column)
		op:     '='
		value:  value.value()
	}
	return &query
}

@[php_method: 'whereOp']
pub fn (mut query VSlimDatabaseQuery) where_op(column string, op string, value vphp.PhpValue) &VSlimDatabaseQuery {
	query.where_clauses << VSlimDatabaseWhereClause{
		column: database_quote_identifier(column)
		op:     database_normalize_operator(op)
		value:  value_subject(value).database_param()
	}
	return &query
}

@[php_method: 'orderBy']
pub fn (mut query VSlimDatabaseQuery) order_by(column string, direction string) &VSlimDatabaseQuery {
	query.order_clauses << '${database_quote_identifier(column)} ${database_normalize_direction(direction)}'
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) limit(limit int) &VSlimDatabaseQuery {
	query.limit_count = if limit < 0 { -1 } else { limit }
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) offset(offset int) &VSlimDatabaseQuery {
	query.offset_count = if offset < 0 { -1 } else { offset }
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) insert(values vphp.PhpValue) &VSlimDatabaseQuery {
	query.kind = .insert
	query.mutation_values = value_subject(values).database_string_map()
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) update(values vphp.PhpValue) &VSlimDatabaseQuery {
	query.kind = .update
	query.mutation_values = value_subject(values).database_string_map()
	return &query
}

@[php_method: 'delete']
pub fn (mut query VSlimDatabaseQuery) delete_query() &VSlimDatabaseQuery {
	query.kind = .delete_
	query.mutation_values = map[string]string{}
	return &query
}

@[php_method: 'toSql']
pub fn (query &VSlimDatabaseQuery) to_sql() string {
	built_sql, _ := query.build()
	return built_sql
}

@[php_method]
pub fn (query &VSlimDatabaseQuery) params() vphp.PhpValue {
	_, params := query.build()
	return database_params_value(params)
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) get() vphp.PhpValue {
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException',
			'database query manager is not configured', 0)
		return vphp.PhpValue.null()
	}
	built_sql, params := query.build()
	if params.len == 0 {
		return manager.query(built_sql)
	}
	mut params_value := database_params_value(params)
	defer {
		params_value.release()
	}
	return manager.query_params(built_sql, params_value)
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) first() vphp.PhpValue {
	mut first_query := query.clone()
	if first_query.limit_count < 0 {
		first_query.limit_count = 1
	}
	mut manager := first_query.manager_ref
	if manager == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException',
			'database query manager is not configured', 0)
		return vphp.PhpValue.null()
	}
	built_sql, params := first_query.build()
	if params.len == 0 {
		return manager.query_one(built_sql)
	}
	mut params_value := database_params_value(params)
	defer {
		params_value.release()
	}
	return manager.query_one_params(built_sql, params_value)
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) run() vphp.PhpValue {
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException',
			'database query manager is not configured', 0)
		return vphp.PhpValue.null()
	}
	built_sql, params := query.build()
	if params.len == 0 {
		return manager.execute(built_sql)
	}
	mut params_value := database_params_value(params)
	defer {
		params_value.release()
	}
	return manager.execute_params(built_sql, params_value)
}

@[php_method: 'insertGetId']
pub fn (mut query VSlimDatabaseQuery) insert_get_id() i64 {
	if query.kind != .insert {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'insertGetId() requires an insert query', 0)
		return 0
	}
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException',
			'database query manager is not configured', 0)
		return 0
	}
	mut meta := query.run()
	defer {
		meta.release()
	}
	return manager.last_insert_id_value()
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) construct() &VSlimDatabaseModel {
	if model.primary_key.trim_space() == '' {
		model.primary_key = 'id'
	}
	if model.attributes.len == 0 {
		model.attributes = map[string]string{}
	}
	return &model
}

@[php_method: 'setManager']
pub fn (mut model VSlimDatabaseModel) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseModel {
	model.manager_ref = manager
	return &model
}

@[php_method]
pub fn (model &VSlimDatabaseModel) manager() &VSlimDatabaseManager {
	return model.manager_ref
}

@[php_method: 'setTable']
pub fn (mut model VSlimDatabaseModel) set_table(name string) &VSlimDatabaseModel {
	model.table_name = name.trim_space()
	return &model
}

@[php_method]
pub fn (model &VSlimDatabaseModel) table() string {
	return model.table_name
}

@[php_method: 'setPrimaryKey']
pub fn (mut model VSlimDatabaseModel) set_primary_key(name string) &VSlimDatabaseModel {
	model.primary_key = if name.trim_space() == '' { 'id' } else { name.trim_space() }
	return &model
}

@[php_method: 'primaryKey']
pub fn (model &VSlimDatabaseModel) primary_key_name() string {
	if model.primary_key.trim_space() == '' {
		return 'id'
	}
	return model.primary_key
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) fill(values vphp.PhpValue) &VSlimDatabaseModel {
	model.construct()
	for key, value in value_subject(values).database_string_map() {
		model.attributes[key] = value
	}
	return &model
}

@[php_method]
pub fn (model &VSlimDatabaseModel) attributes() vphp.PhpValue {
	return database_result_value_from_dyn(vphp.DynValue.of_map(database_dyn_map_from_string_map(model.attributes)))
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method]
pub fn (model &VSlimDatabaseModel) get(key string, default_value vphp.PhpValue) vphp.PhpValue {
	if value := model.attributes[key] {
		mut result := vphp.PhpString.of(value)
		return result.take_value()
	}
	return default_value.to_request_owned()
}

@[php_method: 'set']
pub fn (mut model VSlimDatabaseModel) set_attr(key string, value vphp.PhpValue) &VSlimDatabaseModel {
	model.construct()
	model.attributes[key] = value_subject(value).database_param()
	return &model
}

@[php_method: 'exists']
pub fn (model &VSlimDatabaseModel) exists_in_database() bool {
	return model.exists_in_db
}

@[php_method: 'newQuery']
pub fn (mut model VSlimDatabaseModel) new_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		query.set_manager(manager)
		return query
	}
	return manager.table_query(table)
}

@[php_method: 'allQuery']
pub fn (mut model VSlimDatabaseModel) all_query() &VSlimDatabaseQuery {
	return model.new_query()
}

@[php_method: 'findQuery']
pub fn (mut model VSlimDatabaseModel) find_query(id vphp.PhpValue) &VSlimDatabaseQuery {
	mut query := model.new_query()
	query.where_eq(model.primary_key_name(), id)
	return query
}

@[php_method: 'saveQuery']
pub fn (mut model VSlimDatabaseModel) save_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		query.set_manager(manager)
		return query
	}
	mut query := manager.table_query(table)
	if model.exists_in_db {
		mut values := model.attributes.clone()
		primary_key := model.primary_key_name()
		id := values[primary_key] or {
			vphp.PhpException.raise_class('InvalidArgumentException',
				'database model primary key `${primary_key}` is required for update', 0)
			return query
		}
		values.delete(primary_key)
		mut values_value :=
			database_result_value_from_dyn(vphp.DynValue.of_map(database_dyn_map_from_string_map(values)))
		defer {
			values_value.release()
		}
		query.update(values_value)
		mut id_value := vphp.PhpString.of(id)
		defer {
			id_value.release()
		}
		query.where_eq_string(primary_key, id_value)
		return query
	}
	mut attrs_value :=
		database_result_value_from_dyn(vphp.DynValue.of_map(database_dyn_map_from_string_map(model.attributes)))
	defer {
		attrs_value.release()
	}
	query.insert(attrs_value)
	return query
}

@[php_method: 'deleteQuery']
pub fn (mut model VSlimDatabaseModel) delete_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		query.set_manager(manager)
		return query
	}
	mut query := manager.table_query(table)
	primary_key := model.primary_key_name()
	id := model.attributes[primary_key] or {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'database model primary key `${primary_key}` is required for delete', 0)
		return query
	}
	query.delete_query()
	mut id_value := vphp.PhpString.of(id)
	defer {
		id_value.release()
	}
	query.where_eq_string(primary_key, id_value)
	query.limit(1)
	return query
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) all() vphp.PhpValue {
	mut query := model.all_query()
	return query.get()
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) find(id vphp.PhpValue) vphp.PhpValue {
	mut query := model.find_query(id)
	return query.first()
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) save() &VSlimDatabaseModel {
	mut query := model.save_query()
	if model.exists_in_db {
		mut result := query.run()
		result.release()
		return &model
	}
	inserted_id := query.insert_get_id()
	if inserted_id > 0 && model.primary_key_name() !in model.attributes {
		model.attributes[model.primary_key_name()] = '${inserted_id}'
	}
	model.exists_in_db = true
	return &model
}

@[php_method: 'delete']
pub fn (mut model VSlimDatabaseModel) delete_model() bool {
	mut query := model.delete_query()
	mut result := query.run()
	defer {
		result.release()
	}
	model.exists_in_db = false
	return true
}

pub fn (model &VSlimDatabaseModel) require_manager() !&VSlimDatabaseManager {
	if model.manager_ref == unsafe { nil } {
		return error('database model manager is not configured')
	}
	return model.manager_ref
}

pub fn (model &VSlimDatabaseModel) require_table() !string {
	if model.table_name.trim_space() == '' {
		return error('database model table is not configured')
	}
	return model.table_name
}

pub fn (query &VSlimDatabaseQuery) clone() VSlimDatabaseQuery {
	return VSlimDatabaseQuery{
		manager_ref:     query.manager_ref
		table_name:      query.table_name.clone()
		kind:            query.kind
		select_columns:  query.select_columns.clone()
		where_clauses:   query.where_clauses.clone()
		order_clauses:   query.order_clauses.clone()
		limit_count:     query.limit_count
		offset_count:    query.offset_count
		mutation_values: query.mutation_values.clone()
	}
}

pub fn (query &VSlimDatabaseQuery) build() (string, []string) {
	if query.table_name == '' {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'database query table is required', 0)
		return '', []string{}
	}
	return match query.kind {
		.select_ { query.build_select() }
		.insert { query.build_insert() }
		.update { query.build_update() }
		.delete_ { query.build_delete() }
	}
}

pub fn (query &VSlimDatabaseQuery) build_select() (string, []string) {
	columns := if query.select_columns.len == 0 { '*' } else { query.select_columns.join(', ') }
	mut statement := 'SELECT ${columns} FROM ${query.table_name}'
	mut params := []string{}
	statement = query.append_where(statement, mut params)
	statement = query.append_order(statement)
	statement = query.append_limit(statement)
	return statement, params
}

pub fn (query &VSlimDatabaseQuery) build_insert() (string, []string) {
	if query.mutation_values.len == 0 {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'database insert values are required', 0)
		return '', []string{}
	}
	mut keys := query.mutation_values.keys()
	keys.sort()
	columns := keys.map(database_quote_identifier(it)).join(', ')
	mut placeholders_parts := []string{}
	mut params := []string{}
	for key in keys {
		placeholders_parts << '?'
		params << query.mutation_values[key]
	}
	placeholders := placeholders_parts.join(', ')
	statement := 'INSERT INTO ${query.table_name} (${columns}) VALUES (${placeholders})'
	return statement, params
}

pub fn (query &VSlimDatabaseQuery) build_update() (string, []string) {
	if query.mutation_values.len == 0 {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'database update values are required', 0)
		return '', []string{}
	}
	mut keys := query.mutation_values.keys()
	keys.sort()
	mut set_parts := []string{}
	mut params := []string{}
	for key in keys {
		set_parts << '${database_quote_identifier(key)} = ?'
		params << query.mutation_values[key]
	}
	mut statement := 'UPDATE ${query.table_name} SET ${set_parts.join(', ')}'
	statement = query.append_where(statement, mut params)
	statement = query.append_order(statement)
	statement = query.append_limit(statement)
	return statement, params
}

pub fn (query &VSlimDatabaseQuery) build_delete() (string, []string) {
	mut statement := 'DELETE FROM ${query.table_name}'
	mut params := []string{}
	statement = query.append_where(statement, mut params)
	statement = query.append_order(statement)
	statement = query.append_limit(statement)
	return statement, params
}

pub fn (query &VSlimDatabaseQuery) append_where(statement string, mut params []string) string {
	if query.where_clauses.len == 0 {
		return statement
	}
	mut parts := []string{}
	for clause in query.where_clauses {
		parts << '${clause.column} ${clause.op} ?'
		params << clause.value
	}
	return statement + ' WHERE ' + parts.join(' AND ')
}

pub fn (query &VSlimDatabaseQuery) append_order(statement string) string {
	if query.order_clauses.len > 0 {
		return statement + ' ORDER BY ' + query.order_clauses.join(', ')
	}
	return statement
}

pub fn (query &VSlimDatabaseQuery) append_limit(statement string) string {
	mut out := statement
	if query.limit_count >= 0 {
		out += ' LIMIT ${query.limit_count}'
	}
	if query.offset_count >= 0 {
		if query.limit_count < 0 {
			out += ' LIMIT 18446744073709551615'
		}
		out += ' OFFSET ${query.offset_count}'
	}
	return out
}
