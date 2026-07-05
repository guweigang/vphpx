module rt

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
				println('PHP2V DEBUG - eval code: ' + code_str)
				unsafe {
					res := C.php2v_eval_string(code_str.str, usize(code_str.len), z_ret)
					println('PHP2V DEBUG - eval result: ${res}')
					if res == 0 {
						return PhpVal{ raw: z_ret }
					}
					free(z_ret)
				}
			}
			return new_null()
		}
		'mysqli_connect', 'mysqli_real_connect' {
			mut host := 'localhost'
			mut user := ''
			mut pass := ''
			mut dbname := ''
			mut port := 3306
			if name == 'mysqli_connect' {
				if args.len > 0 { host = args[0].to_string() }
				if args.len > 1 { user = args[1].to_string() }
				if args.len > 2 { pass = args[2].to_string() }
				if args.len > 3 { dbname = args[3].to_string() }
				if args.len > 4 { port = int(args[4].to_i64()) }
			} else { // mysqli_real_connect
				if args.len > 1 { host = args[1].to_string() }
				if args.len > 2 { user = args[2].to_string() }
				if args.len > 3 { pass = args[3].to_string() }
				if args.len > 4 { dbname = args[4].to_string() }
				if args.len > 5 { port = int(args[5].to_i64()) }
			}
			if host.contains(':') {
				parts := host.split(':')
				host = parts[0]
				port = parts[1].int()
			}
			mut pool := get_mysql_pool()
			conn := pool.get_conn(host, user, pass, dbname, port) or {
				eprintln('rt mysqli_connect error: ${err}')
				return new_bool(false)
			}
			if name == 'mysqli_real_connect' {
				return new_bool(true)
			}
			return new_int(i64(conn))
		}
		'mysqli_query' {
			if args.len < 2 { return new_bool(false) }
			conn := &MysqlConnHandle(args[0].to_i64())
			query_str := args[1].to_string()
			res := conn.db.query(query_str) or {
				eprintln('rt mysqli_query error: ${err} | SQL: ${query_str}')
				return new_bool(false)
			}
			maps_data := res.maps()
			mut field_names := []string{}
			if maps_data.len > 0 {
				field_names = maps_data[0].keys()
			}
			mut handle := &MysqlResultHandle{
				maps: maps_data
				cursor: 0
				num_rows: int(res.n_rows())
				num_fields: res.n_fields()
				field_names: field_names
			}
			return new_int(i64(handle))
		}
		'mysqli_fetch_assoc' {
			if args.len < 1 { return new_null() }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_null() }
			mut handle := &MysqlResultHandle(val_i)
			if handle.cursor >= handle.maps.len {
				return new_bool(false)
			}
			mut row_map := new_array()
			for k, v in handle.maps[handle.cursor] {
				row_map.array_set(new_string(k), new_string(v))
			}
			handle.cursor++
			return row_map
		}
		'mysqli_fetch_row', 'mysqli_fetch_array' {
			if args.len < 1 { return new_null() }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_null() }
			mut handle := &MysqlResultHandle(val_i)
			if handle.cursor >= handle.maps.len {
				return new_bool(false)
			}
			mut row_arr := new_array()
			for field_name in handle.field_names {
				val := handle.maps[handle.cursor][field_name]
				row_arr.array_push(new_string(val))
			}
			if name == 'mysqli_fetch_array' {
				for idx, field_name in handle.field_names {
					val := handle.maps[handle.cursor][field_name]
					row_arr.array_set(new_string(field_name), new_string(val))
					row_arr.array_set(new_int(i64(idx)), new_string(val))
				}
			}
			handle.cursor++
			return row_arr
		}
		'mysqli_num_rows' {
			if args.len < 1 { return new_int(0) }
			val_i := args[0].to_i64()
			if val_i == 0 { return new_int(0) }
			handle := &MysqlResultHandle(val_i)
			return new_int(handle.num_rows)
		}
		'mysqli_free_result' {
			return new_null()
		}
		'mysqli_close' {
			if args.len > 0 {
				val_i := args[0].to_i64()
				if val_i != 0 {
					conn := &MysqlConnHandle(val_i)
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
			return new_bool(true)
		}
		'mysqli_set_charset' {
			return new_bool(true)
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
	escaped_path := path.replace('\\', '\\\\').replace('\'', '\\\'')
	
	mut keyword := 'include'
	match incl_type {
		'2' { keyword = 'include_once' }
		'3' { keyword = 'require' }
		'4' { keyword = 'require_once' }
		else {}
	}
	
	code := 'return ${keyword} \'${escaped_path}\';'
	println('PHP2V DEBUG - include_file - eval code: ' + code)
	z_ret := new_zval()
	unsafe {
		res := C.php2v_eval_string(code.str, usize(code.len), z_ret)
		println('PHP2V DEBUG - include_file - result: ${res}')
		if res == 0 {
			return PhpVal{ raw: z_ret }
		}
		free(z_ret)
	}
	return new_null()
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
