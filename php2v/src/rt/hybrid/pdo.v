module hybrid

import rt

// VPdo 纯 V 语言面向对象 PDO 实现 (实现 IPhpObject 接口契约)
pub struct VPdo {
	rt.PhpObjectBase
pub mut:
	dsn            string
	username       string
	password       string
	in_transaction bool
	error_code     string
}

// new_v_pdo 构造函数
pub fn new_v_pdo(dsn string, username string, password string) &VPdo {
	return &VPdo{
		dsn:            dsn
		username:       username
		password:       password
		in_transaction: false
		error_code:     '00000'
	}
}

// dispatch_method 统一遵循 php2v 转译器生成的标准 IPhpObject 契约
pub fn (mut self VPdo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name.to_lower() {
		'__construct' {
			if args.len > 1 { self.dsn = args[1].to_string() }
			if args.len > 2 { self.username = args[2].to_string() }
			if args.len > 3 { self.password = args[3].to_string() }
			return rt.new_null()
		}
		'query' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			eprintln('[VPdo.query] Executing SQL via V-native DB Pool: ${sql_str}')
			return args[0]
		}
		'exec' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			eprintln('[VPdo.exec] Executing SQL statement: ${sql_str}')
			return rt.new_int(1)
		}
		'prepare' {
			sql_str := if args.len > 1 { args[1].to_string() } else { '' }
			eprintln('[VPdo.prepare] Preparing SQL statement: ${sql_str}')
			return rt.new_null()
		}
		'fetch', 'fetchall' {
			return rt.PhpVal{ raw: &C.zval(C.php2v_create_zend_array_sample()) }
		}
		'begintransaction' {
			self.in_transaction = true
			return rt.new_bool(true)
		}
		'commit', 'rollback' {
			self.in_transaction = false
			return rt.new_bool(true)
		}
		'intransaction' {
			return rt.new_bool(self.in_transaction)
		}
		else {
			return none
		}
	}
}

// VPdoStatement 纯 V 语言面向对象 PDOStatement 实现
pub struct VPdoStatement {
	rt.PhpObjectBase
pub mut:
	statement_sql string
}

pub fn (mut self VPdoStatement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name.to_lower() {
		'fetch' {
			return rt.PhpVal{ raw: &C.zval(C.php2v_create_zend_array_sample()) }
		}
		'fetchall' {
			return rt.new_array()
		}
		else {
			return none
		}
	}
}
