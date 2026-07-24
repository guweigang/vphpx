module hybrid

import rt

// VRedis 纯 V 语言面向对象 Redis 实现 (实现 IPhpObject 接口契约)
pub struct VRedis {
	rt.PhpObjectBase
pub mut:
	host      string
	port      int
	connected bool
}

// new_v_redis 构造函数
pub fn new_v_redis() &VRedis {
	return &VRedis{
		host:      '127.0.0.1'
		port:      6379
		connected: false
	}
}

// dispatch_method 统一遵循 php2v 转译器生成的标准 IPhpObject 契约
pub fn (mut self VRedis) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name.to_lower() {
		'__construct' {
			return rt.new_null()
		}
		'connect', 'pconnect' {
			self.host = if args.len > 1 { args[1].to_string() } else { '127.0.0.1' }
			self.port = if args.len > 2 { int(args[2].to_i64()) } else { 6379 }
			self.connected = true
			eprintln('[VRedis.connect] Connected to V-native Redis cache engine (${self.host}:${self.port})')
			return rt.new_bool(true)
		}
		'get' {
			key := if args.len > 1 { args[1].to_string() } else { '' }
			val := rt.v_shared_cache_get(key)
			eprintln('[VRedis.get] Intercepted key "${key}" -> val: ${val}')
			return val
		}
		'set', 'setex' {
			key := if args.len > 1 { args[1].to_string() } else { '' }
			val := if args.len > 2 { args[2] } else { rt.new_null() }
			rt.v_shared_cache_set(key, val)
			eprintln('[VRedis.set] Intercepted key "${key}"')
			return rt.new_bool(true)
		}
		'del', 'delete' {
			key := if args.len > 1 { args[1].to_string() } else { '' }
			rt.v_shared_cache_del(key)
			return rt.new_bool(true)
		}
		'exists' {
			key := if args.len > 1 { args[1].to_string() } else { '' }
			return rt.new_bool(rt.v_shared_cache_exists(key).to_bool())
		}
		else {
			return none
		}
	}
}
