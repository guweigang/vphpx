module databasex

import configx as cfgx
import json
import os

@[php_method]
pub fn (mut cfg VSlimDatabaseConfig) construct() &VSlimDatabaseConfig {
	cfg.ensure()
	return &cfg
}

@[php_method: 'setDriver']
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

@[php_method: 'setHost']
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

@[php_method: 'setPort']
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

@[php_method: 'setUsername']
pub fn (mut cfg VSlimDatabaseConfig) set_username(username string) &VSlimDatabaseConfig {
	cfg.username = username
	return &cfg
}

@[php_method]
pub fn (cfg &VSlimDatabaseConfig) username() string {
	return cfg.username
}

@[php_method: 'setPassword']
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

@[php_arg_name: 'timeout_ms=timeoutMs']
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

@[php_arg_name: 'socket_path=socketPath']
@[php_method: 'setUpstreamSocket']
pub fn (mut cfg VSlimDatabaseConfig) set_upstream_socket(socket_path string) &VSlimDatabaseConfig {
	cfg.upstream_socket = socket_path.trim_space()
	return &cfg
}

@[php_method: 'upstreamSocket']
pub fn (cfg &VSlimDatabaseConfig) upstream_socket_value() string {
	return cfg.upstream_socket.trim_space()
}

@[php_method: 'toJson']
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

fn (mut cfg VSlimDatabaseConfig) ensure() {
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

pub fn (mut db VSlimDatabaseManager) configure_defaults(config &cfgx.VSlimConfig) {
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
		cfg.set_upstream_socket(config.get_string('database.upstream.socket',
			cfg.upstream_socket_value()))
	} else {
		env_socket := os.getenv_opt('VHTTPD_DB_SOCKET') or { '' }
		if env_socket.trim_space() != '' {
			cfg.set_upstream_socket(env_socket)
		}
	}
}

pub fn VSlimDatabaseManager.from_config(config &cfgx.VSlimConfig) &VSlimDatabaseManager {
	mut db := &VSlimDatabaseManager{}
	db.construct()
	db.configure_defaults(config)
	return db
}

pub fn empty_database_diagnostics() map[string]string {
	return {
		'database_transport':              ''
		'database_driver':                 ''
		'database_pool_name':              ''
		'database_upstream_socket':        ''
		'database_upstream_socket_source': 'none'
	}
}

pub fn (mut db VSlimDatabaseManager) diagnostics(config &cfgx.VSlimConfig) map[string]string {
	transport := db.transport()
	cfg := db.config()
	mut upstream_socket_source := 'none'
	if transport == 'vhttpd_upstream' {
		if config != unsafe { nil } && config.has('database.upstream.socket') {
			upstream_socket_source = 'config'
		} else if os.getenv_opt('VHTTPD_DB_SOCKET') or { '' } != '' {
			upstream_socket_source = 'env'
		}
	}
	return {
		'database_transport':              transport
		'database_driver':                 cfg.driver()
		'database_pool_name':              cfg.pool_name_value()
		'database_upstream_socket':        cfg.upstream_socket_value()
		'database_upstream_socket_source': upstream_socket_source
	}
}
