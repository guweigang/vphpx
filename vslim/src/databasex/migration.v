module databasex

import os
import time
import vphp

#include "php_bridge.h"

fn path_is_file(path string) bool {
	return os.is_file(path)
}

fn path_is_dir(path string) bool {
	return os.is_dir(path)
}

fn glob_paths(pattern string) []string {
	return os.glob(pattern) or { []string{} }
}

fn path_join(base string, child string) string {
	return os.join_path(base, child)
}

fn (db &VSlimDatabaseManager) wrap_runtime_value() vphp.PhpValue {
	unsafe {
		if isnil(db) {
			return vphp.PhpValue.null()
		}
		return vphp.bind_borrowed_object_value[VSlimDatabaseManager](db)
	}
}

fn (db &VSlimDatabaseManager) self_value() vphp.PhpValue {
	if self := vphp.PhpObject.current() {
		if self.is_valid() && self.is_instance_of('VSlim\\Database\\Manager') {
			return self.owned().to_value()
		}
	}
	return db.wrap_runtime_value()
}

fn migration_entry_name(path string) string {
	mut name := os.file_name(path)
	if name.ends_with('.php') {
		name = name[..name.len - 4]
	}
	return name
}

fn migration_sorted_files(path string) []string {
	clean := path.trim_space()
	if clean == '' || !path_is_dir(clean) {
		return []string{}
	}
	mut files := glob_paths(path_join(clean, '*.php'))
	files.sort()
	return files
}

fn (subject PhpValueSubject) database_rows() []map[string]string {
	mut out := []map[string]string{}
	rows := subject.value
	arr := rows.as_array() or { return out }
	for idx := 0; idx < arr.count(); idx++ {
		item := arr.index_value(idx)
		if !item.is_array() {
			continue
		}
		out << value_subject(item).database_string_map()
	}
	return out
}

fn database_migration_table_sql(table_name string) string {
	table := database_quote_identifier(table_name)
	return 'CREATE TABLE IF NOT EXISTS ${table} (`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, `migration` VARCHAR(255) NOT NULL, `batch` INT NOT NULL, `applied_at_unix` BIGINT NOT NULL, PRIMARY KEY (`id`), UNIQUE KEY `vslim_migrations_migration_unique` (`migration`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4'
}

fn migration_join_column_defs(columns []string) string {
	mut defs := []string{}
	for column in columns {
		def := column.trim_space()
		if def != '' {
			defs << def
		}
	}
	return defs.join(', ')
}

fn migration_create_table_sql(table_name string, columns []string) string {
	table := database_quote_identifier(table_name)
	column_defs := migration_join_column_defs(columns)
	if column_defs == '' {
		return 'CREATE TABLE IF NOT EXISTS ${table} ()'
	}
	return 'CREATE TABLE IF NOT EXISTS ${table} (${column_defs})'
}

fn migration_drop_table_sql(table_name string) string {
	return 'DROP TABLE IF EXISTS ${database_quote_identifier(table_name)}'
}

fn migration_add_column_sql(table_name string, column_def string) string {
	return 'ALTER TABLE ${database_quote_identifier(table_name)} ADD COLUMN ${column_def.trim_space()}'
}

fn migration_drop_column_sql(table_name string, column_name string) string {
	return 'ALTER TABLE ${database_quote_identifier(table_name)} DROP COLUMN ${database_quote_identifier(column_name)}'
}

fn migration_apply_manager(instance vphp.PhpValue, manager &VSlimDatabaseManager, name string) {
	mut manager_value := manager.self_value()
	defer {
		manager_value.release()
	}
	if instance.method_exists('setManager') && manager_value.is_valid() && manager_value.is_object() {
		instance.with_object[bool](fn [manager_value] (obj vphp.PhpObject) bool {
			return obj.with_method_result[vphp.PhpValue, bool]('setManager', fn (_ vphp.PhpValue) bool {
				return true
			}, manager_value) or { false }
		}) or { false }
	}
	if instance.method_exists('setName') {
		mut name_arg := vphp.PhpString.of(name)
		defer {
			name_arg.release()
		}
		instance.with_object[bool](fn [name_arg] (obj vphp.PhpObject) bool {
			return obj.with_method_result[vphp.PhpValue, bool]('setName', fn (_ vphp.PhpValue) bool {
				return true
			}, name_arg) or { false }
		}) or { false }
	}
}

fn migrator_load_object(file string, expected_class string) !vphp.PhpValue {
	if !path_is_file(file) {
		return error('migration file "${file}" does not exist')
	}
	mut loaded := vphp.PhpIncludeFile.at(file).load()
	if !loaded.is_valid() || !loaded.is_object() {
		loaded.release()
		return error('file "${file}" must return an object')
	}
	if !loaded.is_instance_of(expected_class) {
		class_name := loaded.class_name()
		loaded.release()
		return error('file "${file}" must return ${expected_class}, got ${class_name}')
	}
	return loaded
}

fn (mut migrator VSlimDatabaseMigrator) ensure_migration_table() bool {
	mut manager := migrator.manager()
	create_sql := database_migration_table_sql(migrator.table_name_value())
	mut result := manager.execute(create_sql)
	result.release()
	return true
}

fn (mut migrator VSlimDatabaseMigrator) applied_migration_rows() []map[string]string {
	migrator.ensure_migration_table()
	mut manager := migrator.manager()
	select_sql := 'SELECT migration, batch, applied_at_unix FROM ${database_quote_identifier(migrator.table_name_value())} ORDER BY id ASC'
	mut rows := manager.query(select_sql)
	defer {
		rows.release()
	}
	return value_subject(rows).database_rows()
}

fn (mut migrator VSlimDatabaseMigrator) applied_migration_batches() map[string]int {
	rows := migrator.applied_migration_rows()
	mut out := map[string]int{}
	for row in rows {
		name := row['migration'] or { continue }
		out[name] = (row['batch'] or { '0' }).int()
	}
	return out
}

fn (mut migrator VSlimDatabaseMigrator) current_batch_number() int {
	rows := migrator.applied_migration_rows()
	mut max_batch := 0
	for row in rows {
		batch := (row['batch'] or { '0' }).int()
		if batch > max_batch {
			max_batch = batch
		}
	}
	return max_batch
}

fn (mut migrator VSlimDatabaseMigrator) insert_applied_migration(name string, batch int) {
	mut manager := migrator.manager()
	mut params := database_params_value([name, '${batch}', '${time.now().unix()}'])
	defer {
		params.release()
	}
	mut result := manager.execute_params('INSERT INTO ${database_quote_identifier(migrator.table_name_value())} (`migration`, `batch`, `applied_at_unix`) VALUES (?, ?, ?)',
		params)
	result.release()
}

fn (mut migrator VSlimDatabaseMigrator) delete_applied_migration(name string) {
	mut manager := migrator.manager()
	mut params := database_params_value([name])
	defer {
		params.release()
	}
	mut result := manager.execute_params('DELETE FROM ${database_quote_identifier(migrator.table_name_value())} WHERE `migration` = ?',
		params)
	result.release()
}

fn (mut migrator VSlimDatabaseMigrator) run_migration_file(file string, method_name string) {
	name := migration_entry_name(file)
	mut migration := migrator.load_migration(file)
	defer {
		migration.release()
	}
	if !migration.method_exists(method_name) {
		vphp.PhpException.raise_class('RuntimeException',
			'migration "${name}" does not implement ${method_name}()', 0)
		return
	}
	if migration_obj := migration.as_object() {
		migration_obj.with_method_result[vphp.PhpValue, bool](method_name, fn (_ vphp.PhpValue) bool {
			return true
		}) or { false }
	}
}

@[php_method]
pub fn (mut migration VSlimDatabaseMigration) construct() &VSlimDatabaseMigration {
	migration.name = ''
	return &migration
}

@[php_method: 'setManager']
pub fn (mut migration VSlimDatabaseMigration) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseMigration {
	migration.manager_ref = manager
	return &migration
}

@[php_method]
pub fn (migration &VSlimDatabaseMigration) manager() &VSlimDatabaseManager {
	return migration.manager_ref
}

@[php_method: 'db']
pub fn (migration &VSlimDatabaseMigration) db() &VSlimDatabaseManager {
	return migration.manager_ref
}

@[php_method: 'setName']
pub fn (mut migration VSlimDatabaseMigration) set_name(name string) &VSlimDatabaseMigration {
	migration.name = name.trim_space()
	return &migration
}

@[php_method]
pub fn (migration &VSlimDatabaseMigration) name() string {
	return migration.name
}

@[php_method]
pub fn (migration &VSlimDatabaseMigration) up() bool {
	return true
}

@[php_method]
pub fn (migration &VSlimDatabaseMigration) down() bool {
	return true
}

@[php_arg_name: 'table_name=tableName']
@[php_method: 'createTableSql']
pub fn (migration &VSlimDatabaseMigration) create_table_sql(table_name string, columns []string) string {
	return migration_create_table_sql(table_name, columns)
}

@[php_arg_name: 'table_name=tableName']
@[php_method: 'dropTableSql']
pub fn (migration &VSlimDatabaseMigration) drop_table_sql(table_name string) string {
	return migration_drop_table_sql(table_name)
}

@[php_arg_name: 'table_name=tableName,column_def=columnDef']
@[php_method: 'addColumnSql']
pub fn (migration &VSlimDatabaseMigration) add_column_sql(table_name string, column_def string) string {
	return migration_add_column_sql(table_name, column_def)
}

@[php_arg_name: 'table_name=tableName,column_name=columnName']
@[php_method: 'dropColumnSql']
pub fn (migration &VSlimDatabaseMigration) drop_column_sql(table_name string, column_name string) string {
	return migration_drop_column_sql(table_name, column_name)
}

@[php_arg_name: 'table_name=tableName']
@[php_method: 'createTable']
pub fn (mut migration VSlimDatabaseMigration) create_table(table_name string, columns []string) vphp.PhpValue {
	return migration.execute(migration_create_table_sql(table_name, columns))
}

@[php_arg_name: 'table_name=tableName']
@[php_method: 'dropTable']
pub fn (mut migration VSlimDatabaseMigration) drop_table(table_name string) vphp.PhpValue {
	return migration.execute(migration_drop_table_sql(table_name))
}

@[php_arg_name: 'table_name=tableName,column_def=columnDef']
@[php_method: 'addColumn']
pub fn (mut migration VSlimDatabaseMigration) add_column(table_name string, column_def string) vphp.PhpValue {
	return migration.execute(migration_add_column_sql(table_name, column_def))
}

@[php_arg_name: 'table_name=tableName,column_name=columnName']
@[php_method: 'dropColumn']
pub fn (mut migration VSlimDatabaseMigration) drop_column(table_name string, column_name string) vphp.PhpValue {
	return migration.execute(migration_drop_column_sql(table_name, column_name))
}

@[php_method]
pub fn (mut migration VSlimDatabaseMigration) execute(statement string) vphp.PhpValue {
	if migration.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.PhpValue.null()
	}
	return migration.manager_ref.execute(statement)
}

@[php_method: 'executeParams']
pub fn (mut migration VSlimDatabaseMigration) execute_params(statement string, params vphp.PhpValue) vphp.PhpValue {
	if migration.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.PhpValue.null()
	}
	return migration.manager_ref.execute_params(statement, params)
}

@[php_method]
pub fn (mut migration VSlimDatabaseMigration) query(statement string) vphp.PhpValue {
	if migration.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.PhpValue.null()
	}
	return migration.manager_ref.query(statement)
}

@[php_method: 'queryParams']
pub fn (mut migration VSlimDatabaseMigration) query_params(statement string, params vphp.PhpValue) vphp.PhpValue {
	if migration.manager_ref == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.PhpValue.null()
	}
	return migration.manager_ref.query_params(statement, params)
}

@[php_method]
pub fn (mut seeder VSlimDatabaseSeeder) construct() &VSlimDatabaseSeeder {
	seeder.name = ''
	return &seeder
}

@[php_method: 'setManager']
pub fn (mut seeder VSlimDatabaseSeeder) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseSeeder {
	seeder.manager_ref = manager
	return &seeder
}

@[php_method]
pub fn (seeder &VSlimDatabaseSeeder) manager() &VSlimDatabaseManager {
	return seeder.manager_ref
}

@[php_method: 'db']
pub fn (seeder &VSlimDatabaseSeeder) db() &VSlimDatabaseManager {
	return seeder.manager_ref
}

@[php_method: 'setName']
pub fn (mut seeder VSlimDatabaseSeeder) set_name(name string) &VSlimDatabaseSeeder {
	seeder.name = name.trim_space()
	return &seeder
}

@[php_method]
pub fn (seeder &VSlimDatabaseSeeder) name() string {
	return seeder.name
}

@[php_method]
pub fn (mut seeder VSlimDatabaseSeeder) run() bool {
	return true
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) construct() &VSlimDatabaseMigrator {
	if migrator.migrations_path.trim_space() == '' {
		migrator.migrations_path = 'database/migrations'
	}
	if migrator.seeds_path.trim_space() == '' {
		migrator.seeds_path = 'database/seeds'
	}
	if migrator.table_name.trim_space() == '' {
		migrator.table_name = 'vslim_migrations'
	}
	return &migrator
}

pub fn VSlimDatabaseMigrator.from_manager(manager &VSlimDatabaseManager) &VSlimDatabaseMigrator {
	mut migrator := &VSlimDatabaseMigrator{}
	migrator.construct()
	migrator.set_manager(manager)
	return migrator
}

@[php_method: 'setManager']
pub fn (mut migrator VSlimDatabaseMigrator) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseMigrator {
	migrator.manager_ref = manager
	return &migrator
}

pub fn (mut migrator VSlimDatabaseMigrator) configure_project_paths(project_root string) &VSlimDatabaseMigrator {
	root := project_root.trim_space()
	migrator.set_migrations_path(os.join_path(root, 'database/migrations'))
	migrator.set_seeds_path(os.join_path(root, 'database/seeds'))
	return &migrator
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) manager() &VSlimDatabaseManager {
	if migrator.manager_ref == unsafe { nil } {
		mut manager := &VSlimDatabaseManager{}
		manager.construct()
		migrator.manager_ref = manager
	}
	return migrator.manager_ref
}

@[php_method: 'setMigrationsPath']
pub fn (mut migrator VSlimDatabaseMigrator) set_migrations_path(path string) &VSlimDatabaseMigrator {
	migrator.migrations_path = path.trim_space()
	return &migrator
}

@[php_method: 'migrationsPath']
pub fn (migrator &VSlimDatabaseMigrator) migrations_path_value() string {
	if migrator.migrations_path.trim_space() == '' {
		return 'database/migrations'
	}
	return migrator.migrations_path.trim_space()
}

@[php_method: 'setSeedsPath']
pub fn (mut migrator VSlimDatabaseMigrator) set_seeds_path(path string) &VSlimDatabaseMigrator {
	migrator.seeds_path = path.trim_space()
	return &migrator
}

@[php_method: 'seedsPath']
pub fn (migrator &VSlimDatabaseMigrator) seeds_path_value() string {
	if migrator.seeds_path.trim_space() == '' {
		return 'database/seeds'
	}
	return migrator.seeds_path.trim_space()
}

@[php_arg_name: 'table_name=tableName']
@[php_method: 'setTable']
pub fn (mut migrator VSlimDatabaseMigrator) set_table(table_name string) &VSlimDatabaseMigrator {
	migrator.table_name = table_name.trim_space()
	return &migrator
}

@[php_method: 'table']
pub fn (migrator &VSlimDatabaseMigrator) table_name_value() string {
	if migrator.table_name.trim_space() == '' {
		return 'vslim_migrations'
	}
	return migrator.table_name.trim_space()
}

@[php_method: 'migrationFiles']
pub fn (migrator &VSlimDatabaseMigrator) migration_files() []string {
	return migration_sorted_files(migrator.migrations_path_value())
}

@[php_method: 'seedFiles']
pub fn (migrator &VSlimDatabaseMigrator) seed_files() []string {
	return migration_sorted_files(migrator.seeds_path_value())
}

@[php_method: 'loadMigration']
pub fn (mut migrator VSlimDatabaseMigrator) load_migration(file string) vphp.PhpValue {
	mut migration := migrator_load_object(file, 'VSlim\\Database\\Migration') or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		return vphp.PhpValue.null()
	}
	migration_apply_manager(migration, migrator.manager(), migration_entry_name(file))
	return migration
}

@[php_method: 'loadSeeder']
pub fn (mut migrator VSlimDatabaseMigrator) load_seeder(file string) vphp.PhpValue {
	mut seeder := migrator_load_object(file, 'VSlim\\Database\\Seeder') or {
		vphp.PhpException.raise_class('RuntimeException', err.msg(), 0)
		return vphp.PhpValue.null()
	}
	migration_apply_manager(seeder, migrator.manager(), migration_entry_name(file))
	return seeder
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) migrate() int {
	applied := migrator.applied_migration_batches()
	files := migrator.migration_files()
	mut pending := []string{}
	for file in files {
		name := migration_entry_name(file)
		if name !in applied {
			pending << file
		}
	}
	if pending.len == 0 {
		return 0
	}
	batch := migrator.current_batch_number() + 1
	mut count := 0
	for file in pending {
		migrator.run_migration_file(file, 'up')
		if vphp.has_exception() {
			return count
		}
		migrator.insert_applied_migration(migration_entry_name(file), batch)
		count++
	}
	return count
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) rollback() int {
	rows := migrator.applied_migration_rows()
	mut latest_batch := 0
	for row in rows {
		batch := (row['batch'] or { '0' }).int()
		if batch > latest_batch {
			latest_batch = batch
		}
	}
	if latest_batch <= 0 {
		return 0
	}
	mut files_by_name := map[string]string{}
	for file in migrator.migration_files() {
		files_by_name[migration_entry_name(file)] = file
	}
	mut targets := []string{}
	for row in rows {
		batch := (row['batch'] or { '0' }).int()
		if batch == latest_batch {
			name := row['migration'] or { continue }
			if file := files_by_name[name] {
				targets << file
			}
		}
	}
	targets.sort(a > b)
	mut count := 0
	for file in targets {
		name := migration_entry_name(file)
		migrator.run_migration_file(file, 'down')
		if vphp.has_exception() {
			return count
		}
		migrator.delete_applied_migration(name)
		count++
	}
	return count
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) status() vphp.PhpValue {
	applied := migrator.applied_migration_batches()
	rows := migrator.applied_migration_rows()
	mut applied_at := map[string]string{}
	for row in rows {
		name := row['migration'] or { continue }
		applied_at[name] = row['applied_at_unix'] or { '' }
	}
	mut out := []vphp.DynValue{}
	mut seen := map[string]bool{}
	for file in migrator.migration_files() {
		name := migration_entry_name(file)
		seen[name] = true
		batch := applied[name] or { 0 }
		out << vphp.DynValue.of_map({
			'migration':       vphp.DynValue.of_string(name)
			'file':            vphp.DynValue.of_string(file)
			'applied':         vphp.DynValue.of_bool(name in applied)
			'batch':           vphp.DynValue.of_int(batch)
			'applied_at_unix': vphp.DynValue.of_string(applied_at[name] or { '' })
		})
	}
	for name, batch in applied {
		if name in seen {
			continue
		}
		out << vphp.DynValue.of_map({
			'migration':       vphp.DynValue.of_string(name)
			'file':            vphp.DynValue.of_string('')
			'applied':         vphp.DynValue.of_bool(true)
			'batch':           vphp.DynValue.of_int(batch)
			'applied_at_unix': vphp.DynValue.of_string(applied_at[name] or { '' })
		})
	}
	return database_result_value_from_dyn(vphp.DynValue.of_list(out))
}

@[php_arg_default: 'name=""']
@[php_arg_optional: 'name']
@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) seed(name string) int {
	target := name.trim_space()
	files := migrator.seed_files()
	mut count := 0
	for file in files {
		entry := migration_entry_name(file)
		if target != '' && target != entry && target != file {
			continue
		}
		mut seeder := migrator.load_seeder(file)
		defer {
			seeder.release()
		}
		if !seeder.method_exists('run') {
			vphp.PhpException.raise_class('RuntimeException',
				'seeder "${entry}" does not implement run()', 0)
			return count
		}
		if seeder_obj := seeder.as_object() {
			seeder_obj.with_method_result[vphp.PhpValue, bool]('run', fn (_ vphp.PhpValue) bool {
				return true
			}) or { false }
		}
		if vphp.has_exception() {
			return count
		}
		count++
		if target != '' {
			break
		}
	}
	return count
}
