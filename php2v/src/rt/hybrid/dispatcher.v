module hybrid

import rt

// HybridManager 常驻单例用于管理 VPdo 与 VRedis 对象实例
pub struct HybridManager {
pub mut:
	default_pdo   &VPdo
	default_redis &VRedis
}

fn get_hybrid_manager() &HybridManager {
	unsafe {
		mut static mgr := &HybridManager(nil)
		if mgr == nil {
			mgr = &HybridManager{
				default_pdo:   new_v_pdo('mysql:host=localhost;dbname=test', 'root', '')
				default_redis: new_v_redis()
			}
		}
		return mgr
	}
}

// dispatch_hybrid_method 统一将 C FFI 拦截的类与方法调度至对应的原生 V 结构体实例方法
pub fn dispatch_hybrid_method(func_name string, args []rt.PhpVal) rt.PhpVal {
	mut mgr := get_hybrid_manager()
	parts := func_name.split('::')
	if parts.len != 2 {
		return rt.new_null()
	}
	class_name := parts[0].to_lower()
	method_name := parts[1].to_lower()

	match class_name {
		'pdo' {
			match method_name {
				'__construct' {
					dsn := if args.len > 1 { args[1].to_string() } else { '' }
					user := if args.len > 2 { args[2].to_string() } else { '' }
					pass := if args.len > 3 { args[3].to_string() } else { '' }
					mgr.default_pdo = new_v_pdo(dsn, user, pass)
					return rt.new_null()
				}
				'query' {
					sql_str := if args.len > 1 { args[1].to_string() } else { '' }
					_ = mgr.default_pdo.query(sql_str)
					return args[0]
				}
				'exec' {
					sql_str := if args.len > 1 { args[1].to_string() } else { '' }
					return mgr.default_pdo.exec(sql_str)
				}
				'prepare' {
					sql_str := if args.len > 1 { args[1].to_string() } else { '' }
					_ = mgr.default_pdo.prepare(sql_str)
					return rt.new_null()
				}
				'fetch', 'fetchall' {
					return mgr.default_pdo.query('')
				}
				'begintransaction' {
					return rt.new_bool(mgr.default_pdo.begin_transaction())
				}
				'commit' {
					return rt.new_bool(mgr.default_pdo.commit())
				}
				'rollback' {
					return rt.new_bool(mgr.default_pdo.roll_back())
				}
				'intransaction' {
					return rt.new_bool(mgr.default_pdo.in_transaction_status())
				}
				else {
					return rt.new_null()
				}
			}
		}
		'pdostatement' {
			mut stmt := VPdoStatement{ statement_sql: '' }
			match method_name {
				'fetch' { return stmt.fetch() }
				'fetchall' { return stmt.fetch_all() }
				else { return rt.new_null() }
			}
		}
		'redis' {
			match method_name {
				'__construct' {
					mgr.default_redis = new_v_redis()
					return rt.new_null()
				}
				'connect', 'pconnect' {
					host := if args.len > 1 { args[1].to_string() } else { '127.0.0.1' }
					port := if args.len > 2 { int(args[2].to_i64()) } else { 6379 }
					return rt.new_bool(mgr.default_redis.connect(host, port))
				}
				'get' {
					key := if args.len > 1 { args[1].to_string() } else { '' }
					return mgr.default_redis.get(key)
				}
				'set', 'setex' {
					key := if args.len > 1 { args[1].to_string() } else { '' }
					val := if args.len > 2 { args[2] } else { rt.new_null() }
					return rt.new_bool(mgr.default_redis.set(key, val))
				}
				'del', 'delete' {
					key := if args.len > 1 { args[1].to_string() } else { '' }
					return rt.new_bool(mgr.default_redis.del(key))
				}
				'exists' {
					key := if args.len > 1 { args[1].to_string() } else { '' }
					return rt.new_bool(mgr.default_redis.exists(key))
				}
				else {
					return rt.new_null()
				}
			}
		}
		else {
			return rt.new_null()
		}
	}
}
