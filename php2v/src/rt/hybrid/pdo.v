module hybrid

import rt
import db.mysql

fn C.php2v_create_zend_hash_array(count int, keys &&char, values &&char) voidptr

struct DsnInfo {
pub mut:
	driver string
	host   string
	port   int
	dbname string
}

fn parse_dsn(dsn string) DsnInfo {
	mut info := DsnInfo{
		driver: 'mysql'
		host:   '127.0.0.1'
		port:   3306
		dbname: ''
	}
	parts := dsn.split(':')
	if parts.len > 0 {
		info.driver = parts[0].to_lower()
	}
	if parts.len > 1 {
		kv_pairs := parts[1].split(';')
		for pair in kv_pairs {
			kv := pair.split('=')
			if kv.len == 2 {
				k := kv[0].trim_space().to_lower()
				v := kv[1].trim_space()
				match k {
					'host' { info.host = v }
					'port' { info.port = v.int() }
					'dbname' { info.dbname = v }
					else {}
				}
			}
		}
	}
	return info
}

// VPdo 纯 V 语言面向对象 PDO 真实 MySQL 驱动实现
pub struct VPdo {
	rt.PhpObjectBase
pub mut:
	dsn            string
	username       string
	password       string
	in_transaction bool
	error_code     string
	db_conn        ?mysql.DB
	last_statement &VPdoStatement
}

// new_v_pdo 构造函数
pub fn new_v_pdo(dsn string, username string, password string) &VPdo {
	mut pdo := &VPdo{
		dsn:            dsn
		username:       username
		password:       password
		in_transaction: false
		error_code:     '00000'
		db_conn:        none
		last_statement: unsafe { nil }
	}
	pdo.last_statement = &VPdoStatement{
		statement_sql: ''
		rows:          []map[string]string{}
		cursor:        0
	}
	if dsn.len > 0 {
		pdo.connect()
	}
	return pdo
}

pub fn (mut self VPdo) connect() bool {
	info := parse_dsn(self.dsn)
	if info.driver == 'mysql' {
		cfg := mysql.Config{
			host:     info.host
			port:     u32(info.port)
			username: self.username
			password: self.password
			dbname:   info.dbname
		}
		if conn := mysql.connect(cfg) {
			eprintln('[VPdo.connect] Successfully connected to real MySQL database (${info.host}:${info.port}/${info.dbname}) as user ${self.username}')
			self.db_conn = conn
			self.error_code = '00000'
			return true
		} else {
			eprintln('[VPdo.connect] MySQL Access Denied / Connection Failed for user "${self.username}": ${err}')
			self.error_code = '1045'
			self.db_conn = none
			return false
		}
	}
	return false
}

// dispatch_method 统一遵循 php2v 转译器生成的标准 IPhpObject 契约
pub fn (mut self VPdo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name.to_lower() {
		'__construct' {
			if args.len > 1 { self.dsn = args[1].to_string() }
			if args.len > 2 { self.username = args[2].to_string() }
			if args.len > 3 { self.password = args[3].to_string() }
			connected := self.connect()
			if !connected {
				eprintln('[VPdo.__construct] Authentication Failed for user: ${self.username}')
			}
			return rt.new_null()
		}
		'query' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			eprintln('[VPdo.query] Executing SQL via real MySQL engine: ${sql_str}')
			
			mut real_rows := []map[string]string{}
			if mut conn := self.db_conn {
				res := conn.query(sql_str) or {
					eprintln('[VPdo.query] SQL execution error: ${err}')
					mysql.Result{}
				}
				real_rows = res.maps()
			} else {
				eprintln('[VPdo.query] Cannot execute query: No active database connection (Check username/password!)')
				return rt.new_bool(false)
			}

			self.last_statement = &VPdoStatement{
				statement_sql: sql_str
				rows:          real_rows
				cursor:        0
			}
			return args[0]
		}
		'exec' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			if mut conn := self.db_conn {
				conn.query(sql_str) or {
					return rt.new_bool(false)
				}
				return rt.new_int(1)
			}
			return rt.new_bool(false)
		}
		'prepare' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			self.last_statement = &VPdoStatement{
				statement_sql: sql_str
				rows:          []map[string]string{}
				cursor:        0
			}
			return args[0]
		}
		'fetch' {
			return self.last_statement.dispatch_method('fetch', args)
		}
		'fetchall' {
			return self.last_statement.dispatch_method('fetchall', args)
		}
		'begintransaction' {
			self.in_transaction = true
			if mut conn := self.db_conn {
				eprintln('[VPdo.beginTransaction] Sending START TRANSACTION to MySQL')
				conn.query('START TRANSACTION') or {
					eprintln('[VPdo.beginTransaction] Failed: ${err}')
					return rt.new_bool(false)
				}
			}
			return rt.new_bool(true)
		}
		'commit' {
			self.in_transaction = false
			if mut conn := self.db_conn {
				eprintln('[VPdo.commit] Sending COMMIT to MySQL')
				conn.query('COMMIT') or {
					eprintln('[VPdo.commit] Failed: ${err}')
					return rt.new_bool(false)
				}
			}
			return rt.new_bool(true)
		}
		'rollback' {
			self.in_transaction = false
			if mut conn := self.db_conn {
				eprintln('[VPdo.rollBack] Sending ROLLBACK to MySQL')
				conn.query('ROLLBACK') or {
					eprintln('[VPdo.rollBack] Failed: ${err}')
					return rt.new_bool(false)
				}
			}
			return rt.new_bool(true)
		}
		'intransaction' {
			return rt.new_bool(self.in_transaction)
		}
		'errorcode' {
			return rt.new_string(self.error_code)
		}
		else {
			return none
		}
	}
}

// VPdoStatement 纯 V 语言面向对象 PDOStatement 真实游标实现
pub struct VPdoStatement {
	rt.PhpObjectBase
pub mut:
	statement_sql string
	rows          []map[string]string
	cursor        int
}

pub fn (mut self VPdoStatement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name.to_lower() {
		'fetch' {
			if self.cursor >= self.rows.len {
				return rt.new_bool(false)
			}
			row := &self.rows[self.cursor]
			self.cursor++
			
			mut c_keys := []&char{cap: row.len}
			mut c_vals := []&char{cap: row.len}
			for k, v in row {
				c_keys << k.str
				c_vals << v.str
			}
			zval_ptr := C.php2v_create_zend_hash_array(row.len, c_keys.data, c_vals.data)
			return rt.PhpVal{ raw: &C.zval(zval_ptr) }
		}
		'fetchall' {
			mut result_list := []rt.PhpVal{}
			for self.cursor < self.rows.len {
				row := &self.rows[self.cursor]
				self.cursor++
				mut c_keys := []&char{cap: row.len}
				mut c_vals := []&char{cap: row.len}
				for k, v in row {
					c_keys << k.str
					c_vals << v.str
				}
				zval_ptr := C.php2v_create_zend_hash_array(row.len, c_keys.data, c_vals.data)
				result_list << rt.PhpVal{ raw: &C.zval(zval_ptr) }
			}
			return rt.create_array_from_list(result_list)
		}
		else {
			return none
		}
	}
}
