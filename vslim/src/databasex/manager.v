module databasex

import vhttpd

@[php_method]
pub fn (mut db VSlimDatabaseManager) construct() &VSlimDatabaseManager {
	if db.config_ref == unsafe { nil } {
		mut cfg := &VSlimDatabaseConfig{}
		cfg.construct()
		db.config_ref = cfg
	} else {
		db.config_ref.ensure()
	}
	db.last_error = ''
	return &db
}

@[php_method: 'setConfig']
pub fn (mut db VSlimDatabaseManager) set_config(config &VSlimDatabaseConfig) &VSlimDatabaseManager {
	db.config_ref = config
	db.config_ref.ensure()
	db.vhttpd_client_ref = unsafe { nil }
	return &db
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) config() &VSlimDatabaseConfig {
	if db.config_ref == unsafe { nil } {
		mut cfg := &VSlimDatabaseConfig{}
		cfg.construct()
		db.config_ref = cfg
	}
	db.config_ref.ensure()
	return db.config_ref
}

@[php_method]
pub fn (db &VSlimDatabaseManager) driver() string {
	return db.config_ref.driver()
}

@[php_method]
pub fn (db &VSlimDatabaseManager) transport() string {
	return db.config_ref.transport()
}

@[php_method: 'vhttpdClient']
pub fn (mut db VSlimDatabaseManager) vhttpd_client() &vhttpd.VSlimVhttpdClient {
	db.construct()
	if db.vhttpd_client_ref == unsafe { nil } {
		mut client := &vhttpd.VSlimVhttpdClient{}
		client.construct(db.config_ref.upstream_socket_value(),
			f64(db.config_ref.timeout_ms_value()) / 1000.0)
		db.vhttpd_client_ref = client
	}
	return db.vhttpd_client_ref
}

@[php_method: 'poolSize']
pub fn (db &VSlimDatabaseManager) pool_size_value() int {
	return db.config_ref.pool_size_value()
}

@[php_method: 'isConnected']
pub fn (db &VSlimDatabaseManager) is_connected() bool {
	return db.mysql_connected || db.upstream_connected
}

@[php_method: 'lastError']
pub fn (db &VSlimDatabaseManager) last_error_message() string {
	return db.last_error
}

@[php_method: 'affectedRows']
pub fn (db &VSlimDatabaseManager) affected_rows_value() int {
	return int(db.last_affected_rows)
}

@[php_method: 'lastInsertId']
pub fn (db &VSlimDatabaseManager) last_insert_id_value() i64 {
	return db.last_insert_id
}

@[php_method: 'table']
pub fn (mut db VSlimDatabaseManager) table_query(name string) &VSlimDatabaseQuery {
	mut query := &VSlimDatabaseQuery{}
	query.construct()
	query.set_manager(&db)
	query.table(name)
	return query
}

pub fn (mut db VSlimDatabaseManager) free() {
	db.disconnect()
}
