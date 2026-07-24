module hybrid

import rt

// VRedis 纯 V 语言面向对象 Redis 实现
pub struct VRedis {
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

// connect 连接 Redis
pub fn (mut self VRedis) connect(host string, port int) bool {
	self.host = host
	self.port = port
	self.connected = true
	eprintln('[VRedis.connect] Connected to V-native Redis cache engine (${host}:${port})')
	return true
}

// get 获取缓存值
pub fn (mut self VRedis) get(key string) rt.PhpVal {
	val := rt.v_shared_cache_get(key)
	eprintln('[VRedis.get] Intercepted key "${key}" -> val: ${val}')
	return val
}

// set 设置缓存值
pub fn (mut self VRedis) set(key string, val rt.PhpVal) bool {
	rt.v_shared_cache_set(key, val)
	eprintln('[VRedis.set] Intercepted key "${key}"')
	return true
}

// del 删除缓存值
pub fn (mut self VRedis) del(key string) bool {
	rt.v_shared_cache_del(key)
	return true
}

// exists 检查 Key 是否存在
pub fn (mut self VRedis) exists(key string) bool {
	return rt.v_shared_cache_exists(key).to_bool()
}
