module main

import os
import time
import vphp

#include "php_bridge.h"

fn wrap_runtime_database_manager_zval(db &VSlimDatabaseManager) vphp.ZVal {
	unsafe {
		if isnil(db) || C.vslim__database__manager_ce == 0 {
			return vphp.ZVal.new_null()
		}
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		vphp.return_borrowed_object_raw(payload.raw, db, C.vslim__database__manager_ce,
			&C.vphp_class_handlers(vslimdatabasemanager_handlers()))
		return payload
	}
}

fn database_manager_self_zval(db &VSlimDatabaseManager) vphp.ZVal {
	self_z := vphp.current_this_owned_request()
	if self_z.is_valid() && self_z.is_object() && self_z.is_instance_of('VSlim\\Database\\Manager') {
		return self_z
	}
	return wrap_runtime_database_manager_zval(db)
}

fn migration_entry_name(path string) string {
	mut name := os.file_name(path)
	if name.ends_with('.php') {
		name = name[..name.len - 4]
	}
	return name
}

fn migration_sorted_php_files(path string) []string {
	clean := path.trim_space()
	if clean == '' || !php_is_dir(clean) {
		return []string{}
	}
	mut files := php_glob_paths(path_join(clean, '*.php'))
	files.sort()
	return files
}

fn database_rows_from_box(rows vphp.RequestBorrowedZBox) []map[string]string {
	raw := rows.to_zval()
	if !raw.is_array() {
		return []map[string]string{}
	}
	mut out := []map[string]string{}
	for idx := 0; idx < raw.array_count(); idx++ {
		item := raw.array_get(idx)
		if !item.is_array() {
			continue
		}
		out << database_string_map_from_box(vphp.borrow_zbox(item))
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

fn migration_apply_manager(instance vphp.ZVal, manager &VSlimDatabaseManager, name string) {
	manager_z := database_manager_self_zval(manager)
	if instance.method_exists('setManager') && manager_z.is_valid() && manager_z.is_object() {
		vphp.with_method_result_zval(instance, 'setManager', [manager_z], fn (_ vphp.ZVal) bool {
			return true
		})
	}
	if instance.method_exists('setName') {
		vphp.with_method_result_zval(instance, 'setName', [vphp.RequestOwnedZBox.new_string(name).to_zval()], fn (_ vphp.ZVal) bool {
			return true
		})
	}
}

fn migrator_load_object(file string, expected_class string) !vphp.RequestOwnedZBox {
	if !php_is_file(file) {
		return error('migration file "${file}" does not exist')
	}
	mut loaded := vphp.include(file)
	if !loaded.is_valid() || !loaded.is_object() {
		loaded.release()
		return error('file "${file}" must return an object')
	}
	if !loaded.is_instance_of(expected_class) {
		class_name := loaded.class_name()
		loaded.release()
		return error('file "${file}" must return ${expected_class}, got ${class_name}')
	}
	return vphp.RequestOwnedZBox.of(loaded)
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
	return database_rows_from_box(rows.borrowed())
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
	mut params := database_params_box([name, '${batch}', '${time.now().unix()}'])
	defer {
		params.release()
	}
	mut result := manager.execute_params(
		'INSERT INTO ${database_quote_identifier(migrator.table_name_value())} (`migration`, `batch`, `applied_at_unix`) VALUES (?, ?, ?)',
		params.borrowed(),
	)
	result.release()
}

fn (mut migrator VSlimDatabaseMigrator) delete_applied_migration(name string) {
	mut manager := migrator.manager()
	mut params := database_params_box([name])
	defer {
		params.release()
	}
	mut result := manager.execute_params(
		'DELETE FROM ${database_quote_identifier(migrator.table_name_value())} WHERE `migration` = ?',
		params.borrowed(),
	)
	result.release()
}

fn (mut migrator VSlimDatabaseMigrator) run_migration_file(file string, method_name string) {
	name := migration_entry_name(file)
	mut migration := migrator.load_migration(file)
	defer {
		migration.release()
	}
	if !migration.to_zval().method_exists(method_name) {
		vphp.throw_exception_class('RuntimeException', 'migration "${name}" does not implement ${method_name}()', 0)
		return
	}
	vphp.with_method_result_zval(migration.to_zval(), method_name, []vphp.ZVal{}, fn (_ vphp.ZVal) bool {
		return true
	})
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

@[php_method: 'createTableSql']
pub fn (migration &VSlimDatabaseMigration) create_table_sql(table_name string, columns []string) string {
	return migration_create_table_sql(table_name, columns)
}

@[php_method: 'dropTableSql']
pub fn (migration &VSlimDatabaseMigration) drop_table_sql(table_name string) string {
	return migration_drop_table_sql(table_name)
}

@[php_method: 'addColumnSql']
pub fn (migration &VSlimDatabaseMigration) add_column_sql(table_name string, column_def string) string {
	return migration_add_column_sql(table_name, column_def)
}

@[php_method: 'dropColumnSql']
pub fn (migration &VSlimDatabaseMigration) drop_column_sql(table_name string, column_name string) string {
	return migration_drop_column_sql(table_name, column_name)
}

@[php_method: 'createTable']
pub fn (mut migration VSlimDatabaseMigration) create_table(table_name string, columns []string) vphp.RequestOwnedZBox {
	return migration.execute(migration_create_table_sql(table_name, columns))
}

@[php_method: 'dropTable']
pub fn (mut migration VSlimDatabaseMigration) drop_table(table_name string) vphp.RequestOwnedZBox {
	return migration.execute(migration_drop_table_sql(table_name))
}

@[php_method: 'addColumn']
pub fn (mut migration VSlimDatabaseMigration) add_column(table_name string, column_def string) vphp.RequestOwnedZBox {
	return migration.execute(migration_add_column_sql(table_name, column_def))
}

@[php_method: 'dropColumn']
pub fn (mut migration VSlimDatabaseMigration) drop_column(table_name string, column_name string) vphp.RequestOwnedZBox {
	return migration.execute(migration_drop_column_sql(table_name, column_name))
}

@[php_method]
pub fn (mut migration VSlimDatabaseMigration) execute(statement string) vphp.RequestOwnedZBox {
	if migration.manager_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return migration.manager_ref.execute(statement)
}

@[php_method: 'executeParams']
pub fn (mut migration VSlimDatabaseMigration) execute_params(statement string, params vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if migration.manager_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return migration.manager_ref.execute_params(statement, params)
}

@[php_method]
pub fn (mut migration VSlimDatabaseMigration) query(statement string) vphp.RequestOwnedZBox {
	if migration.manager_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return migration.manager_ref.query(statement)
}

@[php_method: 'queryParams']
pub fn (mut migration VSlimDatabaseMigration) query_params(statement string, params vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if migration.manager_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'migration manager is not set', 0)
		return vphp.RequestOwnedZBox.new_null()
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

@[php_method: 'setManager']
pub fn (mut migrator VSlimDatabaseMigrator) set_manager(manager &VSlimDatabaseManager) &VSlimDatabaseMigrator {
	migrator.manager_ref = manager
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
	return migration_sorted_php_files(migrator.migrations_path_value())
}

@[php_method: 'seedFiles']
pub fn (migrator &VSlimDatabaseMigrator) seed_files() []string {
	return migration_sorted_php_files(migrator.seeds_path_value())
}

@[php_method: 'loadMigration']
pub fn (mut migrator VSlimDatabaseMigrator) load_migration(file string) vphp.RequestOwnedZBox {
	mut migration := migrator_load_object(file, 'VSlim\\Database\\Migration') or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	migration_apply_manager(migration.to_zval(), migrator.manager(), migration_entry_name(file))
	return migration
}

@[php_method: 'loadSeeder']
pub fn (mut migrator VSlimDatabaseMigrator) load_seeder(file string) vphp.RequestOwnedZBox {
	mut seeder := migrator_load_object(file, 'VSlim\\Database\\Seeder') or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	migration_apply_manager(seeder.to_zval(), migrator.manager(), migration_entry_name(file))
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
		if C.vphp_has_exception() {
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
		if C.vphp_has_exception() {
			return count
		}
		migrator.delete_applied_migration(name)
		count++
	}
	return count
}

@[php_method]
pub fn (mut migrator VSlimDatabaseMigrator) status() vphp.RequestOwnedZBox {
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
		out << vphp.dyn_value_map({
			'migration': vphp.dyn_value_string(name)
			'file': vphp.dyn_value_string(file)
			'applied': vphp.dyn_value_bool(name in applied)
			'batch': vphp.dyn_value_int(batch)
			'applied_at_unix': vphp.dyn_value_string(applied_at[name] or { '' })
		})
	}
	for name, batch in applied {
		if name in seen {
			continue
		}
		out << vphp.dyn_value_map({
			'migration': vphp.dyn_value_string(name)
			'file': vphp.dyn_value_string('')
			'applied': vphp.dyn_value_bool(true)
			'batch': vphp.dyn_value_int(batch)
			'applied_at_unix': vphp.dyn_value_string(applied_at[name] or { '' })
		})
	}
	return database_result_box_from_dyn(vphp.dyn_value_list(out))
}

@[php_optional_args: 'name']
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
		if !seeder.to_zval().method_exists('run') {
			vphp.throw_exception_class('RuntimeException', 'seeder "${entry}" does not implement run()', 0)
			return count
		}
		vphp.with_method_result_zval(seeder.to_zval(), 'run', []vphp.ZVal{}, fn (_ vphp.ZVal) bool {
			return true
		})
		if C.vphp_has_exception() {
			return count
		}
		count++
		if target != '' {
			break
		}
	}
	return count
}
