module rt

import db.mysql
import sync

// MysqlConnHandle 数据库连接句柄封装
pub struct MysqlConnHandle {
pub mut:
	db          mysql.DB
	is_in_use   bool
	config_hash string
}

// MysqlResultHandle 缓存结果集句柄
pub struct MysqlResultHandle {
pub mut:
	maps        []map[string]string
	cursor      int
	num_rows    int
	num_fields  int
	field_names []string
}

// MysqlPool 零依赖的高性能连接池
pub struct MysqlPool {
pub mut:
	conns []&MysqlConnHandle
	mu    sync.Mutex
}

// get_mysql_pool 获取共享的全局数据库连接池实例
pub fn get_mysql_pool() &MysqlPool {
	mut r := get_registry()
	if r.mysql_pool == unsafe { nil } {
		mut p := &MysqlPool{
			conns: []&MysqlConnHandle{}
			mu: sync.Mutex{}
		}
		r.mysql_pool = voidptr(p)
		return p
	}
	return &MysqlPool(r.mysql_pool)
}

// get_conn 从连接池中借出一个对应配置的数据库物理连接，若没有则建立新连接
pub fn (mut p MysqlPool) get_conn(host string, user string, pass string, dbname string, port int) !&MysqlConnHandle {
	p.mu.lock()
	defer {
		p.mu.unlock()
	}
	
	config_hash := '${host}:${port}:${user}:${dbname}'
	
	// 1. 尝试在现有连接队列中查找闲置的匹配连接
	for conn in p.conns {
		if !conn.is_in_use && conn.config_hash == config_hash {
			unsafe {
				mut mut_conn := conn
				mut_conn.is_in_use = true
			}
			return conn
		}
	}
	
	// 2. 没有匹配的闲置连接 → 建立全新物理连接
	config := mysql.Config{
		host: host
		username: user
		password: pass
		dbname: dbname
		port: u32(port)
	}
	
	db := mysql.connect(config)!
	
	mut conn := &MysqlConnHandle{
		db: db
		is_in_use: true
		config_hash: config_hash
	}
	
	p.conns << conn
	return conn
}

// put_conn 将物理连接归还并重新标记为闲置状态以供重用
pub fn (mut p MysqlPool) put_conn(conn &MysqlConnHandle) {
	p.mu.lock()
	defer {
		p.mu.unlock()
	}
	unsafe {
		mut mut_conn := conn
		mut_conn.is_in_use = false
	}
}
