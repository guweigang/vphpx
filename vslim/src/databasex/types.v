module databasex

import db.mysql
import vhttpd
import vphp

@[php_class: 'VSlim\\Database\\Config']
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
	pool_size       int    = 5    @[php_prop: poolSize]
	pool_name       string = 'default' @[php_prop: poolName]
	timeout_ms      int    = 1000    @[php_prop: timeoutMs]
	upstream_socket string @[php_prop: upstreamSocket]
}

@[php_class: 'VSlim\\Database\\Manager']
@[heap]
pub struct VSlimDatabaseManager {
mut:
	config_ref          &VSlimDatabaseConfig      = unsafe { nil }      @[php_ignore]
	vhttpd_client_ref   &vhttpd.VSlimVhttpdClient = unsafe { nil } @[php_ignore]
	mysql_pool          mysql.ConnectionPool      @[php_ignore]
	mysql_connected     bool                      @[php_ignore]
	mysql_tx_conn       mysql.DB                  @[php_ignore]
	mysql_tx_active     bool                      @[php_ignore]
	upstream_connected  bool                      @[php_ignore]
	upstream_tx_active  bool                      @[php_ignore]
	upstream_session_id string                    @[php_ignore]
	last_affected_rows  u64                       @[php_prop: lastAffectedRows]
	last_insert_id      i64                       @[php_prop: lastInsertId]
	last_error          string                    @[php_prop: lastError]
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

@[php_class: 'VSlim\\Database\\PendingResult']
@[heap]
pub struct VSlimDatabasePendingResult {
mut:
	async_ref      &VSlimAsyncHandle = unsafe { nil } @[php_ignore]
	active         bool
	resolved       bool
	kind           VSlimDatabaseAsyncKind = .query
	affected_rows  u64           @[php_prop: affectedRows]
	last_insert_id i64           @[php_prop: lastInsertId]
	last_error     string        @[php_prop: lastError]
	result_box     vphp.PhpValue = vphp.PhpValue.invalid() @[php_ignore]
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

@[php_class: 'VSlim\\Database\\Query']
@[heap]
pub struct VSlimDatabaseQuery {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	table_name      string                @[php_prop: tableName]
	kind            VSlimDatabaseQueryKind = .select_
	select_columns  []string                   @[php_ignore]
	where_clauses   []VSlimDatabaseWhereClause @[php_ignore]
	order_clauses   []string                   @[php_ignore]
	limit_count     int = -1                        @[php_prop: limitCount]
	offset_count    int = -1                        @[php_prop: offsetCount]
	mutation_values map[string]string          @[php_ignore]
}

@[php_class: 'VSlim\\Database\\Model']
@[heap]
pub struct VSlimDatabaseModel {
mut:
	manager_ref  &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	table_name   string                @[php_prop: tableName]
	primary_key  string = 'id'                @[php_prop: primaryKey]
	attributes   map[string]string     @[php_ignore]
	exists_in_db bool                  @[php_prop: existsInDb]
}

@[php_class: 'VSlim\\Database\\Migration']
@[heap]
pub struct VSlimDatabaseMigration {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	name        string
}

@[php_class: 'VSlim\\Database\\Seeder']
@[heap]
pub struct VSlimDatabaseSeeder {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	name        string
}

@[php_class: 'VSlim\\Database\\Migrator']
@[heap]
pub struct VSlimDatabaseMigrator {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	migrations_path string                = 'database/migrations'                @[php_prop: migrationsPath]
	seeds_path      string                = 'database/seeds'                @[php_prop: seedsPath]
	table_name      string                = 'vslim_migrations'                @[php_prop: tableName]
}
