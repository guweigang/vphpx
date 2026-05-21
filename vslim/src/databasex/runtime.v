module databasex

import db.mysql
import os
import vhttpd
import vphp

$if linux {
	#flag -ldl
	#insert "@VMODROOT/src/database_runtime_linux_helper.h"

	fn C.vslim_mysql_client_plugin_dir() &char
	fn C.free(voidptr)
}

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
pub fn (mut db VSlimDatabaseManager) connect() bool {
	db.construct()
	if db.config_ref.transport() == 'vhttpd_upstream' {
		if db.upstream_connected {
			return true
		}
		ok := db.database_upstream_ping() or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database connect failed: ${err.msg()}', 0)
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
		vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
		return false
	}
	config := mysql.Config{
		host:     db.config_ref.host()
		port:     u32(db.config_ref.port())
		username: db.config_ref.username()
		password: db.config_ref.password()
		dbname:   db.config_ref.database()
	}
	configure_database_client_plugin_dir()
	db.mysql_pool = mysql.new_connection_pool(config, db.config_ref.pool_size_value()) or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database connect failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_connected = true
	db.last_affected_rows = 0
	db.last_insert_id = 0
	db.last_error = ''
	return true
}

fn configure_database_client_plugin_dir() {
	$if linux {
		if os.getenv('MARIADB_PLUGIN_DIR').trim_space() != ''
			|| os.getenv('MYSQL_PLUGIN_DIR').trim_space() != '' {
			return
		}
		plugin_dir_ptr := C.vslim_mysql_client_plugin_dir()
		if plugin_dir_ptr == unsafe { nil } {
			return
		}
		plugin_dir := unsafe { cstring_to_vstring(plugin_dir_ptr) }
		C.free(plugin_dir_ptr)
		if plugin_dir.trim_space() == '' || !os.is_dir(plugin_dir) {
			return
		}
		os.setenv('MARIADB_PLUGIN_DIR', plugin_dir, true)
		os.setenv('MYSQL_PLUGIN_DIR', plugin_dir, true)
	}
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

fn database_result_value_from_dyn(value vphp.DynValue) vphp.PhpValue {
	return value.to_value() or { vphp.PhpValue.null() }
}

fn database_rows_to_value(rows []map[string]string) vphp.PhpValue {
	mut out := vphp.PhpArray.new()
	for row in rows {
		mut item := vphp.PhpArray.new()
		for key, value in row {
			item.string(key, value)
		}
		out.push(item)
		item.release()
	}
	return out.take_value()
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

fn database_exec_meta_value(affected_rows u64) vphp.PhpValue {
	return database_result_value_from_dyn(vphp.DynValue.of_map({
		'affected_rows': vphp.DynValue.of_int(i64(affected_rows))
	}))
}

fn database_dyn_map_from_string_map(values map[string]string) map[string]vphp.DynValue {
	mut out := map[string]vphp.DynValue{}
	for key, value in values {
		out[key] = vphp.DynValue.of_string(value)
	}
	return out
}

pub fn database_params_value(params []string) vphp.PhpValue {
	mut values := []vphp.DynValue{}
	for item in params {
		values << vphp.DynValue.of_string(item)
	}
	return database_result_value_from_dyn(vphp.DynValue.of_list(values))
}

fn (subject PhpValueSubject) database_param() string {
	value := subject.value
	if value.is_null() {
		return ''
	}
	if value.is_bool() {
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

pub fn (mut db VSlimDatabaseManager) database_upstream_client() &vhttpd.VSlimVhttpdClient {
	return db.vhttpd_client()
}

fn database_response_error_message(raw vphp.PhpArray) string {
	error_value := raw.value_at('error')
	if error_array := error_value.as_array() {
		message := error_array.string_at('message', '')
		if message != '' {
			return message
		}
	}
	return raw.string_at('message', 'upstream request failed')
}

pub fn (mut db VSlimDatabaseManager) database_upstream_request(op string, statement string, params []string) !vphp.PhpArray {
	mut payload := vphp.PhpArray.new()
	payload.string('mode', 'db')
	payload.int('version', 1)
	payload.string('pool', db.config_ref.pool_name_value())
	payload.string('op', op)
	payload.int('timeout_ms', db.config_ref.timeout_ms_value())
	if statement.trim_space() != '' {
		payload.string('sql', statement)
	}
	if db.upstream_session_id != '' {
		payload.string('session_id', db.upstream_session_id)
	}
	if params.len > 0 {
		mut params_value := database_params_value(params)
		payload.set_value('params', params_value)
		params_value.release()
	}
	defer {
		payload.release()
	}
	mut response := db.database_upstream_client().request(payload)
	if !response.is_valid() || response.is_empty() {
		response.release()
		return error('connect_failed')
	}
	if !response.bool_at('ok', false) {
		msg := database_response_error_message(response)
		response.release()
		return error(msg)
	}
	session_value := response.value_at('session_id')
	if session_value.is_valid() {
		db.upstream_session_id = response.string_at('session_id', db.upstream_session_id)
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

pub fn (mut db VSlimDatabaseManager) database_upstream_query_value(query string, params []string) !vphp.PhpValue {
	mut response := db.database_upstream_request('query', query, params)!
	defer {
		db.last_affected_rows = u64(response.int_at('affected_rows', 0))
		db.last_insert_id = i64(response.int_at('last_insert_id', 0))
		response.release()
	}
	return response.value_at('rows').owned()
}

pub fn (mut db VSlimDatabaseManager) database_upstream_execute_value(query string, params []string) !vphp.PhpValue {
	mut response := db.database_upstream_request('execute', query, params)!
	defer {
		response.release()
	}
	db.last_affected_rows = u64(response.int_at('affected_rows', 0))
	db.last_insert_id = i64(response.int_at('last_insert_id', 0))
	return database_exec_meta_value(db.last_affected_rows)
}

pub fn (mut db VSlimDatabaseManager) database_upstream_begin_transaction() !bool {
	mut response := db.database_upstream_request('begin_transaction', '', []string{}) or {
		return err
	}
	response.release()
	db.upstream_tx_active = true
	return true
}

pub fn (mut db VSlimDatabaseManager) database_upstream_commit() !bool {
	if !db.upstream_tx_active {
		return true
	}
	mut response := db.database_upstream_request('commit', '', []string{}) or { return err }
	response.release()
	db.upstream_tx_active = false
	db.upstream_session_id = ''
	return true
}

pub fn (mut db VSlimDatabaseManager) database_upstream_rollback() !bool {
	if !db.upstream_tx_active {
		return true
	}
	mut response := db.database_upstream_request('rollback', '', []string{}) or { return err }
	response.release()
	db.upstream_tx_active = false
	db.upstream_session_id = ''
	return true
}

fn (subject PhpValueSubject) database_string_map() map[string]string {
	mut out := map[string]string{}
	values := subject.value
	arr := values.as_array() or { return out }
	for key in arr.assoc_keys() {
		out[key] = value_subject(arr.value_at(key)).database_param()
	}
	return out
}

fn (subject PhpValueSubject) database_columns() []string {
	columns := subject.value
	if columns.is_array() {
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

fn (mut db VSlimDatabaseManager) replace_mysql_conn() !mysql.DB {
	config := database_direct_mysql_config(&db)
	return mysql.connect(config)!
}

fn (db &VSlimDatabaseManager) config_snapshot() VSlimDatabaseConfig {
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

fn (result VSlimAsyncResult) to_database_value(kind VSlimDatabaseAsyncKind) vphp.PhpValue {
	return match kind {
		.query { database_rows_to_value(result.rows) }
		.execute { database_exec_meta_value(result.affected_rows) }
	}
}

fn (job VSlimDatabaseAsyncJob) run_async() VSlimAsyncResult {
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

fn (mut db VSlimDatabaseManager) async_guard(label string) !VSlimDatabaseAsyncJob {
	db.construct()
	if db.database_uses_upstream() {
		return error('database ${label} async is only supported for direct mysql transport')
	}
	db.ensure_direct_mysql_supported()!
	if db.mysql_tx_active {
		return error('database ${label} async is unavailable while a transaction is active')
	}
	config := db.config_snapshot()
	return VSlimDatabaseAsyncJob{
		config: &config
	}
}

fn (job VSlimDatabaseAsyncJob) pending_result() &VSlimDatabasePendingResult {
	mut pending := &VSlimDatabasePendingResult{}
	pending.async_ref = (VSlimAsyncJob{
		kind:     if job.kind == .execute { .database_execute } else { .database_query }
		database: job
	}).spawn()
	pending.active = true
	pending.kind = job.kind
	return pending
}

fn (mut pending VSlimDatabasePendingResult) cache_result(result VSlimAsyncResult, kind VSlimDatabaseAsyncKind) vphp.PhpValue {
	if pending.result_box.is_valid() {
		mut old := pending.result_box
		old.release()
	}
	pending.affected_rows = result.affected_rows
	pending.last_insert_id = result.last_insert_id
	pending.last_error = result.error
	if result.ok {
		mut result_value := result.to_database_value(kind)
		pending.result_box = result_value.retain()
		result_value.release()
	} else {
		pending.result_box = vphp.PhpValue.null().retain()
	}
	pending.resolved = true
	pending.active = false
	mut owned := pending.result_box.owned()
	defer {
		owned.release()
	}
	return owned.owned()
}

fn (mut pending VSlimDatabasePendingResult) wait_result() VSlimAsyncResult {
	if pending.async_ref == unsafe { nil } {
		return VSlimAsyncResult{
			error: 'database async handle is missing'
		}
	}
	result := pending.async_ref.wait()
	pending.async_ref.release()
	pending.async_ref = unsafe { nil }
	return result
}

fn (mut pending VSlimDatabasePendingResult) wait_value(kind VSlimDatabaseAsyncKind, label string) vphp.PhpValue {
	if pending.resolved {
		if pending.last_error != '' {
			vphp.PhpException.raise_class('RuntimeException',
				'database async ${label} failed: ${pending.last_error}', 0)
			return vphp.PhpValue.null()
		}
		mut owned := pending.result_box.owned()
		defer {
			owned.release()
		}
		return owned.owned()
	}
	result := pending.wait_result()
	mut response := pending.cache_result(result, kind)
	if pending.last_error != '' {
		response.release()
		vphp.PhpException.raise_class('RuntimeException',
			'database async ${label} failed: ${pending.last_error}', 0)
		return vphp.PhpValue.null()
	}
	return response
}

fn (subject PhpValueSubject) database_params() []string {
	params := subject.value
	if !params.is_array() {
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
	replacement := db.replace_mysql_conn() or {
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

fn (mut db VSlimDatabaseManager) finish_mysql_conn(mut conn mysql.DB, reusable bool) {
	if db.mysql_tx_active {
		return
	}
	if reusable && database_mysql_conn_is_alive(mut conn) {
		db.mysql_pool.release(conn)
		return
	}
	database_discard_mysql_conn(mut conn)
}

fn (mut db VSlimDatabaseManager) finish_mysql_tx_conn(reusable bool) {
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
		db.finish_mysql_tx_conn(reusable)
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
		db.finish_mysql_conn(mut conn, false)
		return false
	}
	db.finish_mysql_conn(mut conn, true)
	db.last_error = ''
	return ok
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) execute(query string) vphp.PhpValue {
	if db.database_uses_upstream() {
		result := db.database_upstream_execute_value(query, []string{}) or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database execute failed: ${err.msg()}', 0)
			return vphp.PhpValue.null()
		}
		db.last_error = ''
		return result
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	_ := conn.exec(query) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.finish_mysql_conn(mut conn, reusable)
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	affected := conn.affected_rows()
	db.last_affected_rows = affected
	db.last_insert_id = database_last_insert_id_from_conn(mut conn)
	db.finish_mysql_conn(mut conn, true)
	db.last_error = ''
	return database_exec_meta_value(affected)
}

@[php_method: 'executeAsync']
pub fn (mut db VSlimDatabaseManager) execute_async(query string) &VSlimDatabasePendingResult {
	mut job := db.async_guard('execute') or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .execute
	job.query = query
	job.params = []string{}
	db.last_error = ''
	return job.pending_result()
}

@[php_method: 'executeParams']
pub fn (mut db VSlimDatabaseManager) execute_params(query string, params vphp.PhpValue) vphp.PhpValue {
	values := value_subject(params).database_params()
	if db.database_uses_upstream() {
		result := db.database_upstream_execute_value(query, values) or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database execute failed: ${err.msg()}', 0)
			return vphp.PhpValue.null()
		}
		db.last_error = ''
		return result
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	_ := conn.exec_param_many(query, values) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.finish_mysql_conn(mut conn, reusable)
		vphp.PhpException.raise_class('RuntimeException', 'database execute failed: ${err.msg()}',
			0)
		return vphp.PhpValue.null()
	}
	affected := conn.affected_rows()
	db.last_affected_rows = affected
	db.last_insert_id = database_last_insert_id_from_conn(mut conn)
	db.finish_mysql_conn(mut conn, true)
	db.last_error = ''
	return database_exec_meta_value(affected)
}

@[php_method: 'executeParamsAsync']
pub fn (mut db VSlimDatabaseManager) execute_params_async(query string, params vphp.PhpValue) &VSlimDatabasePendingResult {
	mut job := db.async_guard('execute') or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .execute
	job.query = query
	job.params = value_subject(params).database_params()
	db.last_error = ''
	return job.pending_result()
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) query(query string) vphp.PhpValue {
	if db.database_uses_upstream() {
		rows := db.database_upstream_query_value(query, []string{}) or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database query failed: ${err.msg()}', 0)
			return vphp.PhpValue.null()
		}
		db.last_error = ''
		return rows
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	mut result := conn.query(query) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.finish_mysql_conn(mut conn, reusable)
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	rows := result.maps()
	unsafe {
		result.free()
	}
	db.finish_mysql_conn(mut conn, true)
	db.last_error = ''
	return database_rows_to_value(rows)
}

@[php_method: 'queryAsync']
pub fn (mut db VSlimDatabaseManager) query_async(query string) &VSlimDatabasePendingResult {
	mut job := db.async_guard('query') or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .query
	job.query = query
	job.params = []string{}
	db.last_error = ''
	return job.pending_result()
}

@[php_method: 'queryParams']
pub fn (mut db VSlimDatabaseManager) query_params(query string, params vphp.PhpValue) vphp.PhpValue {
	values := value_subject(params).database_params()
	if db.database_uses_upstream() {
		rows := db.database_upstream_query_value(query, values) or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database query failed: ${err.msg()}', 0)
			return vphp.PhpValue.null()
		}
		db.last_error = ''
		return rows
	}
	db.ensure_direct_mysql_supported() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	mut conn := db.acquire_mysql_conn() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	rows := database_query_maps_with_params(mut conn, query, values) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.finish_mysql_conn(mut conn, reusable)
		vphp.PhpException.raise_class('RuntimeException', 'database query failed: ${err.msg()}', 0)
		return vphp.PhpValue.null()
	}
	db.last_affected_rows = conn.affected_rows()
	db.last_insert_id = 0
	db.finish_mysql_conn(mut conn, true)
	db.last_error = ''
	return database_rows_to_value(rows)
}

@[php_method: 'queryParamsAsync']
pub fn (mut db VSlimDatabaseManager) query_params_async(query string, params vphp.PhpValue) &VSlimDatabasePendingResult {
	mut job := db.async_guard('query') or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
		return &VSlimDatabasePendingResult{}
	}
	job.kind = .query
	job.query = query
	job.params = value_subject(params).database_params()
	db.last_error = ''
	return job.pending_result()
}

@[php_method: 'queryOne']
pub fn (mut db VSlimDatabaseManager) query_one(query string) vphp.PhpValue {
	rows := db.query(query)
	if !rows.is_array() || rows.count() == 0 {
		return vphp.PhpValue.null()
	}
	return rows.index_value(0)
}

@[php_method: 'queryOneParams']
pub fn (mut db VSlimDatabaseManager) query_one_params(query string, params vphp.PhpValue) vphp.PhpValue {
	rows := db.query_params(query, params)
	if !rows.is_array() || rows.count() == 0 {
		return vphp.PhpValue.null()
	}
	return rows.index_value(0)
}

@[php_method: 'beginTransaction']
pub fn (mut db VSlimDatabaseManager) begin_transaction() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_begin_transaction() or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database begin transaction failed: ${err.msg()}', 0)
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
		vphp.PhpException.raise_class('RuntimeException',
			'database begin transaction failed: ${err.msg()}', 0)
		return false
	}
	if !db.mysql_connected && !db.connect() {
		return false
	}
	db.mysql_tx_conn = db.mysql_pool.acquire() or {
		db.last_error = err.msg()
		vphp.PhpException.raise_class('RuntimeException',
			'database begin transaction failed: ${err.msg()}', 0)
		return false
	}
	if !database_mysql_conn_is_alive(mut db.mysql_tx_conn) {
		database_discard_mysql_conn(mut db.mysql_tx_conn)
		db.mysql_tx_conn = db.replace_mysql_conn() or {
			db.last_error = 'database begin transaction failed: pooled connection is stale and reconnect failed: ${err.msg()}'
			vphp.PhpException.raise_class('RuntimeException', db.last_error, 0)
			return false
		}
	}
	db.mysql_tx_conn.autocommit(false) or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.finish_mysql_tx_conn(reusable)
		vphp.PhpException.raise_class('RuntimeException',
			'database begin transaction failed: ${err.msg()}', 0)
		return false
	}
	db.mysql_tx_conn.begin() or {
		db.last_error = err.msg()
		reusable := !database_mysql_error_requires_discard(err.code())
		db.mysql_tx_conn.autocommit(true) or {
			db.finish_mysql_tx_conn(false)
			vphp.PhpException.raise_class('RuntimeException',
				'database begin transaction failed: ${err.msg()}', 0)
			return false
		}
		db.finish_mysql_tx_conn(reusable)
		vphp.PhpException.raise_class('RuntimeException',
			'database begin transaction failed: ${err.msg()}', 0)
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
			vphp.PhpException.raise_class('RuntimeException',
				'database commit failed: ${err.msg()}', 0)
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
			db.finish_mysql_tx_conn(false)
		}
		vphp.PhpException.raise_class('RuntimeException', 'database commit failed: ${err.msg()}', 0)
		return false
	}
	db.mysql_tx_conn.autocommit(true) or {
		db.last_error = err.msg()
		db.finish_mysql_tx_conn(false)
		vphp.PhpException.raise_class('RuntimeException', 'database commit failed: ${err.msg()}', 0)
		return false
	}
	db.finish_mysql_tx_conn(true)
	db.last_error = ''
	return true
}

@[php_method]
pub fn (mut db VSlimDatabaseManager) rollback() bool {
	if db.database_uses_upstream() {
		ok := db.database_upstream_rollback() or {
			db.last_error = err.msg()
			vphp.PhpException.raise_class('RuntimeException',
				'database rollback failed: ${err.msg()}', 0)
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
			db.finish_mysql_tx_conn(false)
		}
		vphp.PhpException.raise_class('RuntimeException', 'database rollback failed: ${err.msg()}',
			0)
		return false
	}
	db.mysql_tx_conn.autocommit(true) or {
		db.last_error = err.msg()
		db.finish_mysql_tx_conn(false)
		vphp.PhpException.raise_class('RuntimeException', 'database rollback failed: ${err.msg()}',
			0)
		return false
	}
	db.finish_mysql_tx_conn(true)
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
pub fn (mut pending VSlimDatabasePendingResult) wait() vphp.PhpValue {
	label := if pending.kind == .execute { 'execute' } else { 'query' }
	return pending.wait_value(pending.kind, label)
}

pub fn (mut pending VSlimDatabasePendingResult) cleanup() {
	if pending.active {
		result := pending.wait_result()
		_ = pending.cache_result(result, pending.kind)
	}
	if pending.async_ref != unsafe { nil } {
		pending.async_ref.release()
		pending.async_ref = unsafe { nil }
	}
}
