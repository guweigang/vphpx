module main

import db.mysql
import json
import os
import vphp

fn C.mysql_thread_init() bool
fn C.mysql_thread_end()

const mysql_client_err_connection_error = 2002
const mysql_client_err_conn_host_error = 2003
const mysql_client_err_ipsock_error = 2004
const mysql_client_err_server_gone_error = 2006
const mysql_client_err_localhost_connection = 2010
const mysql_client_err_tcp_connection = 2011
const mysql_client_err_server_handshake_err = 2012
const mysql_client_err_server_lost = 2013
const mysql_client_err_commands_out_of_sync = 2014
const mysql_client_err_net_packet_too_large = 2020
const mysql_client_err_ssl_connection_error = 2026
const mysql_client_err_malformed_packet = 2027
const mysql_client_err_server_lost_extended = 2055
const mysql_client_err_auth_plugin_err = 2061

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) construct() &VSlimDatabaseConfig {
	ensure_database_config(mut cfg)
	return &cfg
}

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) set_driver(driver string) &VSlimDatabaseConfig {
	clean := driver.trim_space().to_lower()
	cfg.driver = if clean == '' { 'mysql' } else { clean }
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) driver() string {
	if cfg.driver.trim_space() == '' {
		return 'mysql'
	}
	return cfg.driver
}

@[php_method: 'setTransport']
pub fn (mut cfg VSlimDatabaseConfig) set_transport(transport string) &VSlimDatabaseConfig {
	clean := transport.trim_space().to_lower()
	cfg.transport = if clean == '' { 'direct' } else { clean }
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) transport() string {
	if cfg.transport.trim_space() == '' {
		return 'direct'
	}
	return cfg.transport
}

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) set_host(host string) &VSlimDatabaseConfig {
	cfg.host = if host.trim_space() == '' { '127.0.0.1' } else { host.trim_space() }
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) host() string {
	if cfg.host.trim_space() == '' {
		return '127.0.0.1'
	}
	return cfg.host
}

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) set_port(port int) &VSlimDatabaseConfig {
	cfg.port = if port <= 0 { 3306 } else { port }
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) port() int {
	if cfg.port <= 0 {
		return 3306
	}
	return cfg.port
}

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) set_username(username string) &VSlimDatabaseConfig {
	cfg.username = username
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) username() string {
	return cfg.username
}

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) set_password(password string) &VSlimDatabaseConfig {
	cfg.password = password
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) password() string {
	return cfg.password
}

@[php_method: 'setDatabase']
pub fn (mut cfg VSlimDatabaseConfig) set_database(name string) &VSlimDatabaseConfig {
	cfg.database = name
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) database() string {
	return cfg.database
}

@[php_method: 'setPoolSize']
pub fn (mut cfg VSlimDatabaseConfig) set_pool_size(size int) &VSlimDatabaseConfig {
	cfg.pool_size = if size <= 0 { 5 } else { size }
	return &cfg
}

@[php_method: 'poolSize']
pub fn (cfg &VSlimDatabaseConfig) pool_size_value() int {
	if cfg.pool_size <= 0 {
		return 5
	}
	return cfg.pool_size
}

@[php_method: 'setPoolName']
pub fn (mut cfg VSlimDatabaseConfig) set_pool_name(name string) &VSlimDatabaseConfig {
	cfg.pool_name = if name.trim_space() == '' { 'default' } else { name.trim_space() }
	return &cfg
}

@[php_method: 'poolName']
pub fn (cfg &VSlimDatabaseConfig) pool_name_value() string {
	if cfg.pool_name.trim_space() == '' {
		return 'default'
	}
	return cfg.pool_name
}

@[php_method: 'setTimeoutMs']
pub fn (mut cfg VSlimDatabaseConfig) set_timeout_ms(timeout_ms int) &VSlimDatabaseConfig {
	cfg.timeout_ms = if timeout_ms <= 0 { 1000 } else { timeout_ms }
	return &cfg
}

@[php_method: 'timeoutMs']
pub fn (cfg &VSlimDatabaseConfig) timeout_ms_value() int {
	if cfg.timeout_ms <= 0 {
		return 1000
	}
	return cfg.timeout_ms
}

@[php_method: 'setUpstreamSocket']
pub fn (mut cfg VSlimDatabaseConfig) set_upstream_socket(socket_path string) &VSlimDatabaseConfig {
	cfg.upstream_socket = socket_path.trim_space()
	return &cfg
}

@[php_method: 'upstreamSocket']
pub fn (cfg &VSlimDatabaseConfig) upstream_socket_value() string {
	return cfg.upstream_socket.trim_space()
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) to_json() string {
	mut payload := map[string]string{}
	payload['driver'] = cfg.driver()
	payload['transport'] = cfg.transport()
	payload['host'] = cfg.host()
	payload['port'] = '${cfg.port()}'
	payload['username'] = cfg.username()
	payload['database'] = cfg.database()
	payload['pool_size'] = '${cfg.pool_size_value()}'
	payload['pool_name'] = cfg.pool_name_value()
	payload['timeout_ms'] = '${cfg.timeout_ms_value()}'
	payload['upstream_socket'] = cfg.upstream_socket_value()
	return json.encode(payload)
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) construct() &VSlimDatabaseManager {
	if db.config_ref == unsafe { nil } {
		mut cfg := &VSlimDatabaseConfig{}
		cfg.construct()
		db.config_ref = cfg
	} else {
		ensure_database_config(mut db.config_ref)
	}
	db.last_error = ''
	return &db
}

@[php_method: 'setConfig']
pub fn (mut db VSlimDatabaseManager) set_config(config &VSlimDatabaseConfig) &VSlimDatabaseManager {
	db.config_ref = config
	ensure_database_config(mut db.config_ref)
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
	ensure_database_config(mut db.config_ref)
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
pub fn (mut db VSlimDatabaseManager) vhttpd_client() &VSlimVhttpdClient {
	db.construct()
	if db.vhttpd_client_ref == unsafe { nil } {
		mut client := &VSlimVhttpdClient{}
		client.construct(db.config_ref.upstream_socket_value(), f64(db.config_ref.timeout_ms_value()) / 1000.0)
		db.vhttpd_client_ref = client
	}
	return db.vhttpd_client_ref
}

@[php_method: 'poolSize']
pub fn (db &VSlimDatabaseManager) pool_size_value() int {
	return db.config_ref.pool_size_value()
}

@[php_method]
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

@[php_method]
pub fn (mut db VSlimDatabaseManager) connect() bool {
	db.construct()
	if db.config_ref.transport() == 'vhttpd_upstream' {
		if db.upstream_connected {
			return true
		}
		ok := db.database_upstream_ping() or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database connect failed: ${err.msg()}',
				0)
			return false
		}
		db.upstream_connected = ok
		db.last_error = ''
		return ok
	}
	if db.mysql_connected {
		return true
	}
	if db.config_ref.driver() != 'mysql' {
		db.last_error = 'database driver ${db.config_ref.driver()} is not supported yet'
		vphp.throw_exception_class('RuntimeException', db.last_error, 0)
		return false
	}
	config := mysql.Config{
		host:     db.config_ref.host()
		port:     u32(db.config_ref.port())
		username: db.config_ref.username()
		password: db.config_ref.password()
		dbname:   db.config_ref.database()
	}
	db.mysql_pool = mysql.new_connection_pool(config, db.config_ref.pool_size_value()) or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database connect failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_connected = true
	db.last_affected_rows = 0
	db.last_insert_id = 0
	db.last_error = ''
	return true
}

pub fn (mut db VSlimDatabaseManager) ensure_direct_mysql_supported() ! {
	db.construct()
	if db.database_uses_upstream() {
		return
	}
	if db.config_ref.driver() != 'mysql' {
		db.last_error = 'database driver ${db.config_ref.driver()} is not supported yet'
		return error(db.last_error)
	}
}

fn database_result_box_from_dyn(value vphp.DynValue) vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(value) or {
		vphp.ZVal.new_null()
	})
}

fn database_rows_to_box(rows []map[string]string) vphp.RequestOwnedZBox {
	mut out := new_array_zval()
	for row in rows {
		mut item := new_array_zval()
		for key, value in row {
			item.add_assoc_string(key, value)
		}
		out.add_next_val(item)
	}
	return vphp.own_request_zbox(out)
}

fn database_rows_from_mysql_rows(rows []mysql.Row) []map[string]string {
	mut out := []map[string]string{}
	for row in rows {
		mut mapped := map[string]string{}
		for idx, value in row.vals {
			mapped['${idx}'] = value
		}
		out << mapped
	}
	return out
}

fn database_query_maps_with_params(mut conn mysql.DB, query string, params []string) ![]map[string]string {
	built_query := database_inline_mysql_params(mut conn, query, params)!
	mut result := conn.query(built_query)!
	rows := result.maps()
	unsafe {
		result.free()
	}
	return rows
}

fn database_inline_mysql_params(mut conn mysql.DB, query string, params []string) !string {
	if params.len == 0 {
		return query
	}
	mut out := []u8{}
	mut param_idx := 0
	for i := 0; i < query.len; i++ {
		ch := query[i]
		if ch == `?` {
			if param_idx >= params.len {
				return error('query placeholder count mismatch')
			}
			escaped := conn.escape_string(params[param_idx])
			out << `'`
			out << escaped.bytes()
			out << `'`
			param_idx++
			continue
		}
		out << ch
	}
	if param_idx != params.len {
		return error('query placeholder count mismatch')
	}
	return out.bytestr()
}

fn database_rows_with_column_names(rows []mysql.Row, column_names []string) []map[string]string {
	if column_names.len == 0 {
		return database_rows_from_mysql_rows(rows)
	}
	mut out := []map[string]string{}
	for row in rows {
		mut mapped := map[string]string{}
		for idx, value in row.vals {
			key := if idx < column_names.len { column_names[idx] } else { '${idx}' }
			mapped[key] = value
		}
		out << mapped
	}
	return out
}

fn database_exec_meta_box(affected_rows u64) vphp.RequestOwnedZBox {
	return database_result_box_from_dyn(vphp.dyn_value_map({
		'affected_rows': vphp.dyn_value_int(i64(affected_rows))
	}))
}

fn database_dyn_map_from_string_map(values map[string]string) map[string]vphp.DynValue {
	mut out := map[string]vphp.DynValue{}
	for key, value in values {
		out[key] = vphp.dyn_value_string(value)
	}
	return out
}

fn database_params_box(params []string) vphp.RequestOwnedZBox {
	mut values := []vphp.DynValue{}
	for item in params {
		values << vphp.dyn_value_string(item)
	}
	return database_result_box_from_dyn(vphp.dyn_value_list(values))
}

fn database_params_box_from_map(values map[string]string) vphp.RequestOwnedZBox {
	return database_result_box_from_dyn(vphp.dyn_value_map(database_dyn_map_from_string_map(values)))
}

fn database_string_params_box(params []string) vphp.RequestOwnedZBox {
	mut values := []vphp.DynValue{}
	for item in params {
		values << vphp.dyn_value_string(item)
	}
	return database_result_box_from_dyn(vphp.dyn_value_list(values))
}

fn database_param_from_box(value vphp.RequestBorrowedZBox) string {
	if value.is_null() {
		return ''
	}
	if value.to_zval().is_bool() {
		return if value.to_bool() { '1' } else { '0' }
	}
	return value.to_string()
}

pub fn (db &VSlimDatabaseManager) database_uses_upstream() bool {
	return db.config_ref != unsafe { nil } && db.config_ref.transport() == 'vhttpd_upstream'
}

pub fn (db &VSlimDatabaseManager) database_upstream_timeout_seconds() f64 {
	return f64(db.config_ref.timeout_ms_value()) / 1000.0
}

pub fn (mut db VSlimDatabaseManager) database_upstream_client() &VSlimVhttpdClient {
	return db.vhttpd_client()
}

fn database_response_error_message(raw vphp.ZVal) string {
	error_z := zval_key(raw, 'error')
	if error_z.is_array() {
		message := zval_string_key(error_z, 'message', '')
		if message != '' {
			return message
		}
	}
	return zval_string_key(raw, 'message', 'upstream request failed')
}

pub fn (mut db VSlimDatabaseManager) database_upstream_request(op string, statement string, params []string) !vphp.RequestOwnedZBox {
	mut payload := new_array_zval()
	payload.add_assoc_string('mode', 'db')
	payload.add_assoc_long('version', 1)
	payload.add_assoc_string('pool', db.config_ref.pool_name_value())
	payload.add_assoc_string('op', op)
	payload.add_assoc_long('timeout_ms', db.config_ref.timeout_ms_value())
	if statement.trim_space() != '' {
		payload.add_assoc_string('sql', statement)
	}
	if db.upstream_session_id != '' {
		payload.add_assoc_string('session_id', db.upstream_session_id)
	}
	if params.len > 0 {
		mut params_box := database_string_params_box(params)
		add_assoc_zval(payload, 'params', params_box.take_zval())
	}
	mut request_box := vphp.own_request_zbox(payload)
	defer {
		request_box.release()
	}
	mut response := db.database_upstream_client().request(request_box.borrowed())
	if !response.is_valid() || response.is_null() || !response.to_zval().is_array() {
		response.release()
		return error('connect_failed')
	}
	raw := response.to_zval()
	if !zval_bool_key(raw, 'ok') {
		msg := database_response_error_message(raw)
		response.release()
		return error(msg)
	}
	if zval_key(raw, 'session_id').is_valid() {
		db.upstream_session_id = zval_string_key(raw, 'session_id', db.upstream_session_id)
	}
	return response
}

pub fn (mut db VSlimDatabaseManager) database_upstream_ping() !bool {
	mut response := db.database_upstream_request('ping', '', []string{})!
	defer {
		response.release()
	}
	return true
}

pub fn (mut db VSlimDatabaseManager) database_upstream_query(query string, params []string) !vphp.RequestOwnedZBox {
	mut response := db.database_upstream_request('query', query, params)!
	defer {
		raw := response.to_zval()
		db.last_affected_rows = u64(zval_int_key(raw, 'affected_rows', 0))
		db.last_insert_id = i64(zval_int_key(raw, 'last_insert_id', 0))
	}
	raw := response.to_zval()
	rows_z := zval_key(raw, 'rows')
	return vphp.RequestOwnedZBox.of(rows_z)
}

pub fn (mut db VSlimDatabaseManager) database_upstream_execute(query string, params []string) !vphp.RequestOwnedZBox {
	mut response := db.database_upstream_request('execute', query, params)!
	defer {
		response.release()
	}
	raw := response.to_zval()
	db.last_affected_rows = u64(zval_int_key(raw, 'affected_rows', 0))
	db.last_insert_id = i64(zval_int_key(raw, 'last_insert_id', 0))
	return database_exec_meta_box(db.last_affected_rows)
}

pub fn (mut db VSlimDatabaseManager) database_upstream_begin_transaction() !bool {
	_ = db.database_upstream_request('begin_transaction', '', []string{}) or { return err }
	db.upstream_tx_active = true
	return true
}

pub fn (mut db VSlimDatabaseManager) database_upstream_commit() !bool {
	if !db.upstream_tx_active {
		return true
	}
	_ = db.database_upstream_request('commit', '', []string{}) or { return err }
	db.upstream_tx_active = false
	db.upstream_session_id = ''
	return true
}

pub fn (mut db VSlimDatabaseManager) database_upstream_rollback() !bool {
	if !db.upstream_tx_active {
		return true
	}
	_ = db.database_upstream_request('rollback', '', []string{}) or { return err }
	db.upstream_tx_active = false
	db.upstream_session_id = ''
	return true
}

fn database_string_map_from_box(values vphp.RequestBorrowedZBox) map[string]string {
	raw := values.to_zval()
	if !raw.is_array() {
		return map[string]string{}
	}
	source := raw.to_v[map[string]vphp.ZVal]() or {
		map[string]vphp.ZVal{}
	}
	mut out := map[string]string{}
	for key, item in source {
		out[key] = database_param_from_box(vphp.RequestBorrowedZBox.of(item))
	}
	return out
}

fn database_columns_from_box(columns vphp.RequestBorrowedZBox) []string {
	raw := columns.to_zval()
	if raw.is_array() {
		mut out := []string{}
		for item in columns.to_string_list() {
			out << database_quote_identifier(item)
		}
		return out
	}
	column := columns.to_string().trim_space()
	if column == '' || column == '*' {
		return []string{}
	}
	return [database_quote_identifier(column)]
}

fn database_normalize_operator(op string) string {
	clean := op.trim_space().to_upper()
	return match clean {
		'=', '!=', '<>', '>', '>=', '<', '<=', 'LIKE' { clean }
		else { '=' }
	}
}

fn database_normalize_direction(direction string) string {
	clean := direction.trim_space().to_upper()
	return if clean == 'DESC' { 'DESC' } else { 'ASC' }
}

fn database_quote_identifier(name string) string {
	clean := name.trim_space()
	if clean == '' || clean == '*' {
		return '*'
	}
	mut parts := []string{}
	for part in clean.split('.') {
		segment := part.trim_space()
		if segment == '' {
			continue
		}
		mut safe := ''
		for ch in segment {
			if ch.is_alnum() || ch == `_` {
				safe += ch.ascii_str()
			}
		}
		if safe == '' {
			continue
		}
		parts << '`${safe}`'
	}
	if parts.len == 0 {
		return '*'
	}
	return parts.join('.')
}

fn database_last_insert_id_from_conn(mut conn mysql.DB) i64 {
	mut result := conn.query('SELECT LAST_INSERT_ID()') or { return 0 }
	rows := result.rows()
	unsafe {
		result.free()
	}
	if rows.len == 0 || rows[0].vals.len == 0 {
		return 0
	}
	return rows[0].vals[0].i64()
}

fn database_direct_mysql_config(db &VSlimDatabaseManager) mysql.Config {
	cfg := db.config_ref
	return mysql.Config{
		host:     cfg.host()
		port:     u32(cfg.port())
		username: cfg.username()
		password: cfg.password()
		dbname:   cfg.database()
	}
}

fn database_mysql_conn_is_alive(mut conn mysql.DB) bool {
	return conn.ping() or { return false }
}

// These client error codes mean the connection itself is stale or protocol-broken,
// so returning it to the pool would keep poisoning later requests.
fn database_mysql_error_requires_discard(code int) bool {
	return code in [
		mysql_client_err_connection_error,
		mysql_client_err_conn_host_error,
		mysql_client_err_ipsock_error,
		mysql_client_err_server_gone_error,
		mysql_client_err_localhost_connection,
		mysql_client_err_tcp_connection,
		mysql_client_err_server_handshake_err,
		mysql_client_err_server_lost,
		mysql_client_err_commands_out_of_sync,
		mysql_client_err_net_packet_too_large,
		mysql_client_err_ssl_connection_error,
		mysql_client_err_malformed_packet,
		mysql_client_err_server_lost_extended,
		mysql_client_err_auth_plugin_err,
	]
}

fn database_discard_mysql_conn(mut conn mysql.DB) {
	conn.close() or {}
}

fn database_replace_mysql_conn(mut db VSlimDatabaseManager) !mysql.DB {
	config := database_direct_mysql_config(&db)
	return mysql.connect(config)!
}

fn database_config_snapshot(db &VSlimDatabaseManager) VSlimDatabaseConfig {
	cfg := db.config_ref
	return VSlimDatabaseConfig{
		driver:          cfg.driver()
		transport:       cfg.transport()
		host:            cfg.host()
		port:            cfg.port()
		username:        cfg.username()
		password:        cfg.password()
		database:        cfg.database()
		pool_size:       cfg.pool_size_value()
		pool_name:       cfg.pool_name_value()
		timeout_ms:      cfg.timeout_ms_value()
		upstream_socket: cfg.upstream_socket_value()
	}
}

fn database_async_result_to_box(result VSlimAsyncResult, kind VSlimDatabaseAsyncKind) vphp.RequestOwnedZBox {
	return match kind {
		.query { database_rows_to_box(result.rows) }
		.execute { database_exec_meta_box(result.affected_rows) }
	}
}

fn database_async_run(job VSlimDatabaseAsyncJob) VSlimAsyncResult {
	C.mysql_thread_init()
	defer {
		C.mysql_thread_end()
	}
	config := mysql.Config{
		host:     job.config.host
		port:     u32(job.config.port)
		username: job.config.username
		password: job.config.password
		dbname:   job.config.database
	}
	mut conn := mysql.connect(config) or { return VSlimAsyncResult{
		error: err.msg()
	} }
	defer {
		conn.close() or {}
	}
	match job.kind {
		.query {
			mut rows := []map[string]string{}
			if job.params.len == 0 {
				mut result := conn.query(job.query) or {
					return VSlimAsyncResult{
						error: err.msg()
					}
				}
				rows = result.maps()
				unsafe {
					result.free()
				}
			} else {
				rows = database_query_maps_with_params(mut conn, job.query, job.params) or {
					return VSlimAsyncResult{
						error: err.msg()
					}
				}
			}
			return VSlimAsyncResult{
				ok:             true
				rows:           rows
				affected_rows:  conn.affected_rows()
				last_insert_id: 0
			}
		}
		.execute {
			if job.params.len == 0 {
				_ := conn.exec(job.query) or {
					return VSlimAsyncResult{
						error: err.msg()
					}
				}
			} else {
				_ := conn.exec_param_many(job.query, job.params) or {
					return VSlimAsyncResult{
						error: err.msg()
					}
				}
			}
			affected := conn.affected_rows()
			return VSlimAsyncResult{
				ok:             true
				affected_rows:  affected
				last_insert_id: database_last_insert_id_from_conn(mut conn)
			}
		}
	}
}

fn database_async_guard(mut db VSlimDatabaseManager, label string) !VSlimDatabaseAsyncJob {
	db.construct()
	if db.database_uses_upstream() {
		return error('database ${label} async is only supported for direct mysql transport')
	}
	db.ensure_direct_mysql_supported()!
	if db.mysql_tx_active {
		return error('database ${label} async is unavailable while a transaction is active')
	}
	return VSlimDatabaseAsyncJob{
		config: database_config_snapshot(&db)
	}
}

fn database_pending_result_from_job(job VSlimDatabaseAsyncJob) &VSlimDatabasePendingResult {
	mut pending := &VSlimDatabasePendingResult{}
	pending.async_ref = async_spawn(VSlimAsyncJob{
		kind:     if job.kind == .execute { .database_execute } else { .database_query }
		database: job
	})
	pending.active = true
	pending.kind = job.kind
	return pending
}

fn database_pending_cache(mut pending VSlimDatabasePendingResult, result VSlimAsyncResult, kind VSlimDatabaseAsyncKind) vphp.RequestOwnedZBox {
	if pending.result_box.is_valid() {
		mut old := pending.result_box
		old.release()
	}
	pending.affected_rows = result.affected_rows
	pending.last_insert_id = result.last_insert_id
	pending.last_error = result.error
	if result.ok {
		mut request_box := database_async_result_to_box(result, kind)
		defer {
			request_box.release()
		}
		pending.result_box = vphp.PersistentOwnedZBox.from_mixed_zval(request_box.to_zval())
	} else {
		pending.result_box = vphp.PersistentOwnedZBox.new_null()
	}
	pending.resolved = true
	pending.active = false
	return pending.result_box.clone_request_owned()
}

fn database_pending_wait_result(mut pending VSlimDatabasePendingResult) VSlimAsyncResult {
	if pending.async_ref == unsafe { nil } {
		return VSlimAsyncResult{
			error: 'database async handle is missing'
		}
	}
	result := async_wait(pending.async_ref)
	async_release(pending.async_ref)
	pending.async_ref = unsafe { nil }
	return result
}

fn database_pending_wait(mut pending VSlimDatabasePendingResult, kind VSlimDatabaseAsyncKind, label string) vphp.RequestOwnedZBox {
	if pending.resolved {
		if pending.last_error != '' {
			vphp.throw_exception_class('RuntimeException', 'database async ${label} failed: ${pending.last_error}',
				0)
			return vphp.RequestOwnedZBox.new_null()
		}
		return pending.result_box.clone_request_owned()
	}
	result := database_pending_wait_result(mut pending)
	mut response := database_pending_cache(mut pending, result, kind)
	if pending.last_error != '' {
		response.release()
		vphp.throw_exception_class('RuntimeException', 'database async ${label} failed: ${pending.last_error}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return response
}

fn database_params_from_box(params vphp.RequestBorrowedZBox) []string {
	if !params.to_zval().is_array() {
		return []string{}
	}
	return params.to_string_list()
}

pub fn (mut db VSlimDatabaseManager) acquire_mysql_conn() !mysql.DB {
	db.ensure_direct_mysql_supported()!
	if !db.mysql_connected && !db.connect() {
		msg := if db.last_error != '' { db.last_error } else { 'database is not connected' }
		return error(msg)
	}
	if db.mysql_tx_active {
		if database_mysql_conn_is_alive(mut db.mysql_tx_conn) {
			return db.mysql_tx_conn
		}
		db.last_error = 'database transaction connection is no longer alive'
		return error(db.last_error)
	}
	mut conn := db.mysql_pool.acquire()!
	if database_mysql_conn_is_alive(mut conn) {
		return conn
	}
	database_discard_mysql_conn(mut conn)
	replacement := database_replace_mysql_conn(mut db) or {
		db.last_error = 'database pooled connection is stale and reconnect failed: ${err.msg()}'
		return error(db.last_error)
	}
	return replacement
}

pub fn (mut db VSlimDatabaseManager) release_mysql_conn(conn mysql.DB) {
	if db.mysql_tx_active {
		return
	}
	db.mysql_pool.release(conn)
}

fn database_finish_mysql_conn(mut db VSlimDatabaseManager, mut conn mysql.DB, reusable bool) {
	if db.mysql_tx_active {
		return
	}
	if reusable && database_mysql_conn_is_alive(mut conn) {
		db.mysql_pool.release(conn)
		return
	}
	database_discard_mysql_conn(mut conn)
}

fn database_finish_mysql_tx_conn(mut db VSlimDatabaseManager, reusable bool) {
	if reusable && database_mysql_conn_is_alive(mut db.mysql_tx_conn) {
		db.mysql_pool.release(db.mysql_tx_conn)
	} else {
		database_discard_mysql_conn(mut db.mysql_tx_conn)
	}
	db.mysql_tx_active = false
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) disconnect() &VSlimDatabaseManager {
	if db.upstream_tx_active {
		db.database_upstream_rollback() or {}
	}
	if db.mysql_tx_active {
		mut reusable := true
		db.mysql_tx_conn.rollback() or { reusable = false }
		db.mysql_tx_conn.autocommit(true) or { reusable = false }
		database_finish_mysql_tx_conn(mut db, reusable)
	}
	if db.mysql_connected {
		db.mysql_pool.close()
		db.mysql_connected = false
	}
	db.vhttpd_client_ref = unsafe { nil }
	db.upstream_connected = false
	db.upstream_tx_active = false
	db.upstream_session_id = ''
	db.last_affected_rows = 0
	db.last_insert_id = 0
	db.last_error = ''
	return &db
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) ping() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_ping() or {
			db.last_error = err.msg()
			return false
		}
		db.upstream_connected = ok
		db.last_error = ''
		return ok
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		return false
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		return false
	}
	ok := conn.ping() or {
		db.last_error = err.msg()
		database_finish_mysql_conn(mut db, mut conn, false)
		return false
	}
	database_finish_mysql_conn(mut db, mut conn, true)
	db.last_error = ''
	return ok
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) execute(query string) vphp.RequestOwnedZBox {
	if db.database_uses_upstream() {
		result := db.database_upstream_execute(query, []string{}) or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
				0)
			return vphp.RequestOwnedZBox.new_null()
		}
		db.last_error = ''
		return result
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	_ := conn.exec(query) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		database_finish_mysql_conn(mut db, mut conn, reusable)
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	affected := conn.affected_rows()
	db.last_affected_rows = affected
	db.last_insert_id = database_last_insert_id_from_conn(mut conn)
	database_finish_mysql_conn(mut db, mut conn, true)
	db.last_error = ''
	return database_exec_meta_box(affected)
}

@[php_method: 'executeAsync']
pub fn (mut db VSlimDatabaseManager) execute_async(query string) &VSlimDatabasePendingResult {
	mut job := database_async_guard(mut db, 'execute') or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .execute
	job.query = query
	job.params = []string{}
	db.last_error = ''
	return database_pending_result_from_job(job)
}

@[php_method: 'executeParams']
pub fn (mut db VSlimDatabaseManager) execute_params(query string, params vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	values := database_params_from_box(params)
	if db.database_uses_upstream() {
		result := db.database_upstream_execute(query, values) or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
				0)
			return vphp.RequestOwnedZBox.new_null()
		}
		db.last_error = ''
		return result
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	_ := conn.exec_param_many(query, values) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		database_finish_mysql_conn(mut db, mut conn, reusable)
		vphp.throw_exception_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	affected := conn.affected_rows()
	db.last_affected_rows = affected
	db.last_insert_id = database_last_insert_id_from_conn(mut conn)
	database_finish_mysql_conn(mut db, mut conn, true)
	db.last_error = ''
	return database_exec_meta_box(affected)
}

@[php_method: 'executeParamsAsync']
pub fn (mut db VSlimDatabaseManager) execute_params_async(query string, params vphp.RequestBorrowedZBox) &VSlimDatabasePendingResult {
	mut job := database_async_guard(mut db, 'execute') or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .execute
	job.query = query
	job.params = database_params_from_box(params)
	db.last_error = ''
	return database_pending_result_from_job(job)
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) query(query string) vphp.RequestOwnedZBox {
	if db.database_uses_upstream() {
		rows := db.database_upstream_query(query, []string{}) or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
				0)
			return vphp.RequestOwnedZBox.new_null()
		}
		db.last_error = ''
		return rows
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	mut result := conn.query(query) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		database_finish_mysql_conn(mut db, mut conn, reusable)
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	rows := result.maps()
	unsafe {
		result.free()
	}
	database_finish_mysql_conn(mut db, mut conn, true)
	db.last_error = ''
	return database_rows_to_box(rows)
}

@[php_method: 'queryAsync']
pub fn (mut db VSlimDatabaseManager) query_async(query string) &VSlimDatabasePendingResult {
	mut job := database_async_guard(mut db, 'query') or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .query
	job.query = query
	job.params = []string{}
	db.last_error = ''
	return database_pending_result_from_job(job)
}

@[php_method: 'queryParams']
pub fn (mut db VSlimDatabaseManager) query_params(query string, params vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	values := database_params_from_box(params)
	if db.database_uses_upstream() {
		rows := db.database_upstream_query(query, values) or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
				0)
			return vphp.RequestOwnedZBox.new_null()
		}
		db.last_error = ''
		return rows
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	rows := database_query_maps_with_params(mut conn, query, values) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		database_finish_mysql_conn(mut db, mut conn, reusable)
		vphp.throw_exception_class('RuntimeException', 'database query failed: ${err.msg()}',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	db.last_affected_rows = conn.affected_rows()
	db.last_insert_id = 0
	database_finish_mysql_conn(mut db, mut conn, true)
	db.last_error = ''
	return database_rows_to_box(rows)
}

@[php_method: 'queryParamsAsync']
pub fn (mut db VSlimDatabaseManager) query_params_async(query string, params vphp.RequestBorrowedZBox) &VSlimDatabasePendingResult {
	mut job := database_async_guard(mut db, 'query') or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .query
	job.query = query
	job.params = database_params_from_box(params)
	db.last_error = ''
	return database_pending_result_from_job(job)
}

@[php_method: 'queryOne']
pub fn (mut db VSlimDatabaseManager) query_one(query string) vphp.RequestOwnedZBox {
	mut rows := db.query(query)
	defer {
		rows.release()
	}
	raw := rows.to_zval()
	if !raw.is_array() || raw.array_count() == 0 {
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.own_request_zbox(raw.array_get(0))
}

@[php_method: 'queryOneParams']
pub fn (mut db VSlimDatabaseManager) query_one_params(query string, params vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	mut rows := db.query_params(query, params)
	defer {
		rows.release()
	}
	raw := rows.to_zval()
	if !raw.is_array() || raw.array_count() == 0 {
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.own_request_zbox(raw.array_get(0))
}

@[php_method: 'beginTransaction']
pub fn (mut db VSlimDatabaseManager) begin_transaction() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_begin_transaction() or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
				0)
			return false
		}
		db.upstream_connected = true
		db.last_error = ''
		return ok
	}
	if db.mysql_tx_active {
		return true
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
			0)
		return false
	}
	if !db.mysql_connected && !db.connect() {
		return false
	}
	db.mysql_tx_conn = db.mysql_pool.acquire() or {
		db.last_error = err.msg()
		vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
			0)
		return false
	}
	if !database_mysql_conn_is_alive(mut db.mysql_tx_conn) {
		database_discard_mysql_conn(mut db.mysql_tx_conn)
		db.mysql_tx_conn = database_replace_mysql_conn(mut db) or {
			db.last_error = 'database begin transaction failed: pooled connection is stale and reconnect failed: ${err.msg()}'
			vphp.throw_exception_class('RuntimeException', db.last_error, 0)
			return false
		}
	}
	db.mysql_tx_conn.autocommit(false) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		database_finish_mysql_tx_conn(mut db, reusable)
		vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_tx_conn.begin() or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.mysql_tx_conn.autocommit(true) or {
			database_finish_mysql_tx_conn(mut db, false)
			vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
				0)
			return false
		}
		database_finish_mysql_tx_conn(mut db, reusable)
		vphp.throw_exception_class('RuntimeException', 'database begin transaction failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_tx_active = true
	db.last_error = ''
	return true
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) commit() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_commit() or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database commit failed: ${err.msg()}',
				0)
			return false
		}
		db.last_error = ''
		return ok
	}
	if !db.mysql_tx_active {
		return true
	}
	db.mysql_tx_conn.commit() or {
		db.last_error = err.msg()
		if database_mysql_error_requires_discard(err.code()) {
			database_finish_mysql_tx_conn(mut db, false)
		}
		vphp.throw_exception_class('RuntimeException', 'database commit failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_tx_conn.autocommit(true) or {
		db.last_error = err.msg()
		database_finish_mysql_tx_conn(mut db, false)
		vphp.throw_exception_class('RuntimeException', 'database commit failed: ${err.msg()}',
			0)
		return false
	}
	database_finish_mysql_tx_conn(mut db, true)
	db.last_error = ''
	return true
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) rollback() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_rollback() or {
			db.last_error = err.msg()
			vphp.throw_exception_class('RuntimeException', 'database rollback failed: ${err.msg()}',
				0)
			return false
		}
		db.last_error = ''
		return ok
	}
	if !db.mysql_tx_active {
		return true
	}
	db.mysql_tx_conn.rollback() or {
		db.last_error = err.msg()
		if database_mysql_error_requires_discard(err.code()) {
			database_finish_mysql_tx_conn(mut db, false)
		}
		vphp.throw_exception_class('RuntimeException', 'database rollback failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_tx_conn.autocommit(true) or {
		db.last_error = err.msg()
		database_finish_mysql_tx_conn(mut db, false)
		vphp.throw_exception_class('RuntimeException', 'database rollback failed: ${err.msg()}',
			0)
		return false
	}
	database_finish_mysql_tx_conn(mut db, true)
	db.last_error = ''
	return true
}

@[php_method]
pub fn (pending &VSlimDatabasePendingResult) resolved() bool {
	return pending.resolved
}

@[php_method: 'lastError']
pub fn (pending &VSlimDatabasePendingResult) last_error_message() string {
	return pending.last_error
}

@[php_method: 'affectedRows']
pub fn (pending &VSlimDatabasePendingResult) affected_rows_value() int {
	return int(pending.affected_rows)
}

@[php_method: 'lastInsertId']
pub fn (pending &VSlimDatabasePendingResult) last_insert_id_value() i64 {
	return pending.last_insert_id
}

@[php_method]
pub fn (mut pending VSlimDatabasePendingResult) wait() vphp.RequestOwnedZBox {
	label := if pending.kind == .execute { 'execute' } else { 'query' }
	return database_pending_wait(mut pending, pending.kind, label)
}

pub fn (mut pending VSlimDatabasePendingResult) cleanup() {
	if pending.active {
		result := database_pending_wait_result(mut pending)
		_ = database_pending_cache(mut pending, result, pending.kind)
	}
	if pending.async_ref != unsafe { nil } {
		async_release(pending.async_ref)
		pending.async_ref = unsafe { nil }
	}
}

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
pub fn (mut query VSlimDatabaseQuery) select(columns vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	query.kind = .select_
	query.select_columns = database_columns_from_box(columns)
	return &query
}

@[php_method: 'where']
pub fn (mut query VSlimDatabaseQuery) where_eq(column string, value vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	return query.where_op(column, '=', value)
}

@[php_method: 'whereOp']
pub fn (mut query VSlimDatabaseQuery) where_op(column string, op string, value vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	query.where_clauses << VSlimDatabaseWhereClause{
		column: database_quote_identifier(column)
		op:     database_normalize_operator(op)
		value:  database_param_from_box(value)
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
pub fn (mut query VSlimDatabaseQuery) insert(values vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	query.kind = .insert
	query.mutation_values = database_string_map_from_box(values)
	return &query
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) update(values vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	query.kind = .update
	query.mutation_values = database_string_map_from_box(values)
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
pub fn (query &VSlimDatabaseQuery) params() vphp.RequestOwnedZBox {
	_, params := query.build()
	return database_params_box(params)
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) get() vphp.RequestOwnedZBox {
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'database query manager is not configured',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	built_sql, params := query.build()
	if params.len == 0 {
		return manager.query(built_sql)
	}
	mut params_box := database_params_box(params)
	defer {
		params_box.release()
	}
	return manager.query_params(built_sql, params_box.borrowed())
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) first() vphp.RequestOwnedZBox {
	mut first_query := query.clone()
	if first_query.limit_count < 0 {
		first_query.limit_count = 1
	}
	mut manager := first_query.manager_ref
	if manager == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'database query manager is not configured',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	built_sql, params := first_query.build()
	if params.len == 0 {
		return manager.query_one(built_sql)
	}
	mut params_box := database_params_box(params)
	defer {
		params_box.release()
	}
	return manager.query_one_params(built_sql, params_box.borrowed())
}

@[php_method]
pub fn (mut query VSlimDatabaseQuery) run() vphp.RequestOwnedZBox {
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'database query manager is not configured',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	built_sql, params := query.build()
	if params.len == 0 {
		return manager.execute(built_sql)
	}
	mut params_box := database_params_box(params)
	defer {
		params_box.release()
	}
	return manager.execute_params(built_sql, params_box.borrowed())
}

@[php_method: 'insertGetId']
pub fn (mut query VSlimDatabaseQuery) insert_get_id() i64 {
	if query.kind != .insert {
		vphp.throw_exception_class('InvalidArgumentException', 'insertGetId() requires an insert query',
			0)
		return 0
	}
	mut manager := query.manager_ref
	if manager == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'database query manager is not configured',
			0)
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
pub fn (mut model VSlimDatabaseModel) fill(values vphp.RequestBorrowedZBox) &VSlimDatabaseModel {
	model.construct()
	for key, value in database_string_map_from_box(values) {
		model.attributes[key] = value
	}
	return &model
}

@[php_method]
pub fn (model &VSlimDatabaseModel) attributes() vphp.RequestOwnedZBox {
	return database_result_box_from_dyn(vphp.dyn_value_map(database_dyn_map_from_string_map(model.attributes)))
}

@[php_method]
pub fn (model &VSlimDatabaseModel) get(key string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	if value := model.attributes[key] {
		return vphp.RequestOwnedZBox.new_string(value)
	}
	return vphp.RequestOwnedZBox.of(default_value.to_zval())
}

@[php_method: 'set']
pub fn (mut model VSlimDatabaseModel) set_attr(key string, value vphp.RequestBorrowedZBox) &VSlimDatabaseModel {
	model.construct()
	model.attributes[key] = database_param_from_box(value)
	return &model
}

@[php_method: 'exists']
pub fn (model &VSlimDatabaseModel) exists_in_database() bool {
	return model.exists_in_db
}

@[php_method: 'newQuery']
pub fn (mut model VSlimDatabaseModel) new_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
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
pub fn (mut model VSlimDatabaseModel) find_query(id vphp.RequestBorrowedZBox) &VSlimDatabaseQuery {
	mut query := model.new_query()
	query.where_eq(model.primary_key_name(), id)
	return query
}

@[php_method: 'saveQuery']
pub fn (mut model VSlimDatabaseModel) save_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
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
			vphp.throw_exception_class('InvalidArgumentException', 'database model primary key `${primary_key}` is required for update',
				0)
			return query
		}
		values.delete(primary_key)
		mut values_box := database_params_box_from_map(values)
		defer {
			values_box.release()
		}
		query.update(values_box.borrowed())
		mut id_box := vphp.RequestOwnedZBox.new_string(id)
		defer {
			id_box.release()
		}
		query.where_eq(primary_key, id_box.borrowed())
		return query
	}
	mut attrs_box := database_params_box_from_map(model.attributes)
	defer {
		attrs_box.release()
	}
	query.insert(attrs_box.borrowed())
	return query
}

@[php_method: 'deleteQuery']
pub fn (mut model VSlimDatabaseModel) delete_query() &VSlimDatabaseQuery {
	mut manager := model.require_manager() or {
		vphp.throw_exception_class('RuntimeException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		return query
	}
	table := model.require_table() or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		mut query := &VSlimDatabaseQuery{}
		query.construct()
		query.set_manager(manager)
		return query
	}
	mut query := manager.table_query(table)
	primary_key := model.primary_key_name()
	id := model.attributes[primary_key] or {
		vphp.throw_exception_class('InvalidArgumentException', 'database model primary key `${primary_key}` is required for delete',
			0)
		return query
	}
	query.delete_query()
	mut id_box := vphp.RequestOwnedZBox.new_string(id)
	defer {
		id_box.release()
	}
	query.where_eq(primary_key, id_box.borrowed())
	query.limit(1)
	return query
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) all() vphp.RequestOwnedZBox {
	mut query := model.all_query()
	return query.get()
}

@[php_method]
pub fn (mut model VSlimDatabaseModel) find(id vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
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
		vphp.throw_exception_class('InvalidArgumentException', 'database query table is required',
			0)
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
		vphp.throw_exception_class('InvalidArgumentException', 'database insert values are required',
			0)
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
		vphp.throw_exception_class('InvalidArgumentException', 'database update values are required',
			0)
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

fn ensure_database_config(mut cfg VSlimDatabaseConfig) {
	if cfg.driver.trim_space() == '' {
		cfg.driver = 'mysql'
	}
	if cfg.transport.trim_space() == '' {
		cfg.transport = 'direct'
	}
	if cfg.host.trim_space() == '' {
		cfg.host = '127.0.0.1'
	}
	if cfg.port <= 0 {
		cfg.port = 3306
	}
	if cfg.pool_size <= 0 {
		cfg.pool_size = 5
	}
	if cfg.pool_name.trim_space() == '' {
		cfg.pool_name = 'default'
	}
	if cfg.timeout_ms <= 0 {
		cfg.timeout_ms = 1000
	}
}

fn configure_default_database_manager(mut db VSlimDatabaseManager, config &VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	mut cfg := db.config()
	if config.has('database.driver') {
		cfg.set_driver(config.get_string('database.driver', cfg.driver()))
	}
	if config.has('database.transport') {
		cfg.set_transport(config.get_string('database.transport', cfg.transport()))
	}
	if config.has('database.pool_size') {
		cfg.set_pool_size(config.get_int('database.pool_size', cfg.pool_size_value()))
	}
	if config.has('database.pool_name') {
		cfg.set_pool_name(config.get_string('database.pool_name', cfg.pool_name_value()))
	}
	if config.has('database.timeout_ms') {
		cfg.set_timeout_ms(config.get_int('database.timeout_ms', cfg.timeout_ms_value()))
	}
	if config.has('database.mysql.host') {
		cfg.set_host(config.get_string('database.mysql.host', cfg.host()))
	}
	if config.has('database.mysql.port') {
		cfg.set_port(config.get_int('database.mysql.port', cfg.port()))
	}
	if config.has('database.mysql.username') {
		cfg.set_username(config.get_string('database.mysql.username', cfg.username()))
	}
	if config.has('database.mysql.password') {
		cfg.set_password(config.get_string('database.mysql.password', cfg.password()))
	}
	if config.has('database.mysql.database') {
		cfg.set_database(config.get_string('database.mysql.database', cfg.database()))
	}
	if config.has('database.upstream.socket') {
		cfg.set_upstream_socket(config.get_string('database.upstream.socket', cfg.upstream_socket_value()))
	} else {
		env_socket := os.getenv_opt('VHTTPD_DB_SOCKET') or { '' }
		if env_socket.trim_space() != '' {
			cfg.set_upstream_socket(env_socket)
		}
	}
}

pub fn (mut db VSlimDatabaseManager) free() {
	db.disconnect()
}
