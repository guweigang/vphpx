module rt

import os

// call_function 调度 PHP 函数调用
pub fn call_function(name string, args []PhpVal) PhpVal {
	match name {
		'strlen' {
			if args.len > 0 {
				return new_int(args[0].to_string().len)
			}
			return new_int(0)
		}
		'strtoupper' {
			if args.len > 0 {
				return new_string(args[0].to_string().to_upper())
			}
			return new_string('')
		}
		'strtolower' {
			if args.len > 0 {
				return new_string(args[0].to_string().to_lower())
			}
			return new_string('')
		}
		'count' {
			if args.len > 0 {
				if args[0].is_array() {
					return new_int(args[0].array_count())
				}
				if args[0].is_null() {
					return new_int(0)
				}
				return new_int(1)
			}
			return new_int(0)
		}
		'eval' {
			if args.len > 0 {
				z_ret := new_zval()
				code_str := args[0].to_string()
				unsafe {
					res := C.php2v_eval_string(code_str.str, usize(code_str.len), z_ret)
					if res == 0 {
						return PhpVal{ raw: z_ret }
					}
					free(z_ret)
				}
			}
			return new_null()
		}
		'mysqli_report' {
			return new_bool(true)
		}
		'mysqli_init' {
			mock_obj := new_zval()
			eval_str := "\$obj = new stdClass(); \$obj->connect_errno = 0; \$obj->server_info = '8.0.32-VPHP'; return \$obj;"
			unsafe {
				C.php2v_eval_string(eval_str.str, u64(eval_str.len), mock_obj)
			}
			return PhpVal{ raw: mock_obj }
		}
		'mysqli_get_server_info' {
			return new_string('8.0.32')
		}
		'mysqli_connect', 'mysqli_real_connect' {
			mut host := 'localhost'
			mut user := ''
			mut pass := ''
			mut dbname := ''
			mut port := 3306
			if args.len > 0 { host = args[0].to_string() }
			if args.len > 1 { user = args[1].to_string() }
			if args.len > 2 { pass = args[2].to_string() }
			if args.len > 3 { dbname = args[3].to_string() }
			if args.len > 4 { port = int(args[4].to_i64()) }
			if host == 'localhost' {
				host = '127.0.0.1'
			}
			mut pool := get_mysql_pool()
			conn := pool.get_conn(host, user, pass, dbname, port) or {
				eprintln('rt mysqli_connect error: ${err}')
				return new_bool(false)
			}
			C.php2v_set_last_mysql_conn(voidptr(conn))
			
			mock_obj := new_zval()
			eval_str := "\$obj = new stdClass(); \$obj->connect_errno = 0; \$obj->server_info = '8.0.32-VPHP'; return \$obj;"
			unsafe {
				C.php2v_eval_string(eval_str.str, u64(eval_str.len), mock_obj)
			}
			return PhpVal{ raw: mock_obj }
		}
		'mysqli_query' {
			if args.len < 2 { return new_bool(false) }
			addr := args[0].to_i64()
			mut conn := unsafe { &MysqlConnHandle(voidptr(addr)) }
			if addr < 10000 {
				conn = unsafe { &MysqlConnHandle(C.php2v_get_last_mysql_conn()) }
			}
			query_str := args[1].to_string()

			res := conn.db.query(query_str) or {
				eprintln('rt mysqli_query error: ${err} | SQL: ${query_str}')
				return new_bool(false)
			}
			if voidptr(res.result) == unsafe { nil } {
				return new_bool(true)
			}
			maps_data := res.maps()
			mut field_names := []string{}
			if maps_data.len > 0 {
				field_names = maps_data[0].keys()
			}
			mut handle := unsafe { &MysqlResultHandle(malloc(sizeof(MysqlResultHandle))) }
			handle.maps = maps_data
			handle.cursor = 0
			handle.num_rows = int(res.n_rows())
			handle.num_fields = res.n_fields()
			handle.field_names = field_names
			
			mock_obj := new_zval()
			eval_str := "\$obj = new mysqli_result(); \$obj->handle = " + i64(handle).str() + "; return \$obj;"
			unsafe {
				C.php2v_eval_string(eval_str.str, u64(eval_str.len), mock_obj)
			}
			return PhpVal{ raw: mock_obj }
		}
		'mysqli_fetch_assoc', 'mysqli_fetch_row', 'mysqli_fetch_array' {
			if args.len < 1 { return new_string('') }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_string('') }
			mut handle := unsafe { &MysqlResultHandle(voidptr(val_i)) }
			if handle.cursor >= handle.maps.len {
				return new_string('')
			}
			mut parts := []string{}
			for k, v in handle.maps[handle.cursor] {
				parts << k + '\x02' + v
			}
			encoded_str := parts.join('\x01')
			handle.cursor++
			return new_string(encoded_str)
		}
		'mysqli_fetch_object' {
			if args.len < 1 { return new_null() }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_null() }
			mut handle := unsafe { &MysqlResultHandle(voidptr(val_i)) }
			if handle.cursor >= handle.maps.len {
				return new_null()
			}
			mut eval_parts := []string{}
			eval_parts << '\$obj = new stdClass();'
			for k, v in handle.maps[handle.cursor] {
				escaped_v := v.replace("'", "\\'")
				eval_parts << '\$obj->{\'' + k + '\'} = \'' + escaped_v + '\';'
			}
			eval_parts << 'return \$obj;'
			eval_str := eval_parts.join(" ")
			
			mock_obj := new_zval()
			unsafe {
				C.php2v_eval_string(eval_str.str, u64(eval_str.len), mock_obj)
			}
			handle.cursor++
			return PhpVal{ raw: mock_obj }
		}
		'mysqli_num_rows' {
			if args.len < 1 { return new_int(0) }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_int(0) }
			handle := unsafe { &MysqlResultHandle(voidptr(val_i)) }
			return new_int(handle.num_rows)
		}
		'mysqli_free_result' {
			return new_null()
		}
		'mysqli_close' {
			if args.len > 0 {
				val_i := args[0].to_i64()
				if val_i != 0 {
					mut conn := unsafe { &MysqlConnHandle(voidptr(val_i)) }
					if val_i < 10000 {
						conn = unsafe { &MysqlConnHandle(C.php2v_get_last_mysql_conn()) }
					}
					mut pool := get_mysql_pool()
					pool.put_conn(conn)
				}
			}
			return new_bool(true)
		}
		'mysqli_real_escape_string' {
			if args.len < 2 { return new_string('') }
			s := args[1].to_string()
			escaped := s.replace('\\', '\\\\').replace('\'', '\\\'').replace('"', '\\"')
			return new_string(escaped)
		}
		'mysqli_error' {
			return new_string('')
		}
		'mysqli_errno' {
			return new_int(0)
		}
		'mysqli_select_db' {
			if args.len < 2 { return new_bool(false) }
			val_i := args[0].to_i64()
			mut conn_addr := val_i
			if conn_addr < 10000 {
				conn_addr = i64(C.php2v_get_last_mysql_conn())
			}
			if conn_addr == 0 { return new_bool(false) }
			mut conn := unsafe { &MysqlConnHandle(voidptr(conn_addr)) }
			dbname := args[1].to_string()

			conn.db.query('USE ' + dbname) or {
				eprintln('rt mysqli_select_db error: ${err}')
				return new_bool(false)
			}
			return new_bool(true)
		}
		'mysqli_set_charset' {
			return new_bool(true)
		}
		'call_user_func' {
			if args.len > 0 {
				cb := args[0]
				cb_args := args[1..]
				return call_callable(cb, cb_args)
			}
			return new_null()
		}
		'call_user_func_array' {
			if args.len > 0 {
				cb := args[0]
				mut cb_args := []PhpVal{}
				if args.len > 1 && args[1].is_array() {
					pa := unsafe { extract_from_zval(args[1].raw) }
					mut it := pa.iter()
					for {
						item := it.next_iter() or { break }
						cb_args << item.val
					}
				}
				return call_callable(cb, cb_args)
			}
			return new_null()
		}
		else {
			// 通用动态内置函数绑定
			z_ret := new_zval()
			mut z_args := []&C.zval{}
			for arg in args {
				z_args << arg.raw
			}
			unsafe {
				res := C.php2v_call_zend_function(name.str, usize(name.len), z_ret, u32(args.len), z_args.data)
				if res == 0 { // SUCCESS
					return PhpVal{ raw: z_ret }
				}
				free(z_ret)
			}
			eprintln('Warning: calling unsupported function: ${name}')
			return new_null()
		}
	}
}

pub fn include_file(path string, incl_type string) PhpVal {
	normalized := os.real_path(path)
	
	// incl_type 映射：
	// '1' = include
	// '2' = include_once
	// '3' = require
	// '4' = require_once
	
	is_once := incl_type == '2' || incl_type == '4'
	
	if is_once && is_included(normalized) {
		return new_int(1)
	}
	
	mut r := get_registry()
	if normalized in r.include_registry {
		mark_included(normalized)
		func_to_run := r.include_registry[normalized]
		return func_to_run()
	}
	
	mark_included(normalized)
	unsafe {
		_ = C.php2v_execute_file(path.str)
	}
	return new_int(1)
}

// define_constant 在运行时定义用户空间常量
pub fn define_constant(name string, val PhpVal) {
	unsafe {
		C.php2v_register_constant(name.str, usize(name.len), val.raw)
	}
}

// get_constant 在运行时获取常量值，若未定义会抛出 PHP 异常并返回 null
pub fn get_constant(name string) PhpVal {
	z_ret := new_zval()
	unsafe {
		res := C.php2v_get_constant(name.str, usize(name.len), z_ret)
		if res == 1 {
			return PhpVal{ raw: z_ret }
		}
		free(z_ret)
	}
	return new_null()
}
