module databasex

import db.mysql
import vhttpdx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Config')]
@[heap]
pub struct VSlimDatabaseConfig {
mut:
	driver          string = 'mysql'
	transport       string = 'direct'
	host            string = '127.0.0.1'
	port            int    = 3306
	username        string
	password        string
	database        string
	pool_size       int    = 5         @[vphp.PhpProperty; vphp.PhpProperty_name: 'poolSize']
	pool_name       string = 'default' @[vphp.PhpProperty; vphp.PhpProperty_name: 'poolName']
	timeout_ms      int    = 1000      @[vphp.PhpProperty; vphp.PhpProperty_name: 'timeoutMs']
	upstream_socket string             @[vphp.PhpProperty; vphp.PhpProperty_name: 'upstreamSocket']
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Manager')]
@[heap]
pub struct VSlimDatabaseManager {
mut:
	config_ref          &VSlimDatabaseConfig       = unsafe { nil } @[vphp.PhpIgnoreField]
	vhttpd_client_ref   &vhttpdx.VSlimVhttpdClient = unsafe { nil } @[vphp.PhpIgnoreField]
	mysql_pool          mysql.ConnectionPool                        @[vphp.PhpIgnoreField]
	mysql_connected     bool     @[vphp.PhpIgnoreField]
	mysql_tx_conn       mysql.DB @[vphp.PhpIgnoreField]
	mysql_tx_active     bool     @[vphp.PhpIgnoreField]
	upstream_connected  bool     @[vphp.PhpIgnoreField]
	upstream_tx_active  bool     @[vphp.PhpIgnoreField]
	upstream_session_id string   @[vphp.PhpIgnoreField]
	last_affected_rows  u64      @[vphp.PhpProperty; vphp.PhpProperty_name: 'lastAffectedRows']
	last_insert_id      i64      @[vphp.PhpProperty; vphp.PhpProperty_name: 'lastInsertId']
	last_error          string   @[vphp.PhpProperty; vphp.PhpProperty_name: 'lastError']
}

enum VSlimDatabaseAsyncKind {
	query
	execute
}

struct VSlimDatabaseAsyncJob {
mut:
	config VSlimDatabaseConfig
	kind   VSlimDatabaseAsyncKind
	query  string
	params []string
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\PendingResult')]
@[heap]
pub struct VSlimDatabasePendingResult {
mut:
	async_ref      &VSlimAsyncHandle = unsafe { nil } @[vphp.PhpIgnoreField]
	active         bool
	resolved       bool
	kind           VSlimDatabaseAsyncKind = .query
	affected_rows  u64    @[vphp.PhpProperty; vphp.PhpProperty_name: 'affectedRows']
	last_insert_id i64    @[vphp.PhpProperty; vphp.PhpProperty_name: 'lastInsertId']
	last_error     string @[vphp.PhpProperty; vphp.PhpProperty_name: 'lastError']
	result_box     vphp.PhpValue = vphp.PhpValue.invalid() @[vphp.PhpIgnoreField]
}

pub enum VSlimDatabaseQueryKind {
	select_
	insert
	update
	delete_
}

struct VSlimDatabaseWhereClause {
	column string
	op     string
	value  string
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Query')]
@[heap]
pub struct VSlimDatabaseQuery {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
	table_name      string @[vphp.PhpProperty; vphp.PhpProperty_name: 'tableName']
	kind            VSlimDatabaseQueryKind = .select_
	select_columns  []string                   @[vphp.PhpIgnoreField]
	where_clauses   []VSlimDatabaseWhereClause @[vphp.PhpIgnoreField]
	order_clauses   []string                   @[vphp.PhpIgnoreField]
	limit_count     int = -1                   @[vphp.PhpProperty; vphp.PhpProperty_name: 'limitCount']
	offset_count    int = -1                   @[vphp.PhpProperty; vphp.PhpProperty_name: 'offsetCount']
	mutation_values map[string]string          @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Model')]
@[heap]
pub struct VSlimDatabaseModel {
mut:
	manager_ref  &VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
	table_name   string            @[vphp.PhpProperty; vphp.PhpProperty_name: 'tableName']
	primary_key  string = 'id'     @[vphp.PhpProperty; vphp.PhpProperty_name: 'primaryKey']
	attributes   map[string]string @[vphp.PhpIgnoreField]
	exists_in_db bool              @[vphp.PhpProperty; vphp.PhpProperty_name: 'existsInDb']
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Migration')]
@[heap]
pub struct VSlimDatabaseMigration {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
	name        string
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Seeder')]
@[heap]
pub struct VSlimDatabaseSeeder {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[vphp.PhpIgnoreField]
	name        string
}

@[vphp.PhpExportClass(name: 'VSlim\\Database\\Migrator')]
@[heap]
pub struct VSlimDatabaseMigrator {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil }        @[vphp.PhpIgnoreField]
	migrations_path string                = 'database/migrations' @[vphp.PhpProperty; vphp.PhpProperty_name: 'migrationsPath']
	seeds_path      string                = 'database/seeds'      @[vphp.PhpProperty; vphp.PhpProperty_name: 'seedsPath']
	table_name      string                = 'vslim_migrations'    @[vphp.PhpProperty; vphp.PhpProperty_name: 'tableName']
}
