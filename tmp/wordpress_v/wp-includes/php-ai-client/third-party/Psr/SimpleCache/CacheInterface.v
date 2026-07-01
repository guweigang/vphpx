import rt

interface CacheInterface {
	get(rt.PhpVal, rt.PhpVal) rt.PhpVal
	set(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete(rt.PhpVal) rt.PhpVal
	clear() rt.PhpVal
	getmultiple(rt.PhpVal, rt.PhpVal) rt.PhpVal
	setmultiple(rt.PhpVal, rt.PhpVal) rt.PhpVal
	deletemultiple(rt.PhpVal) rt.PhpVal
	has(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_php_ai_client_third_party_psr_simplecache_cacheinterface_php() {
	mut var_key := rt.new_null()
	mut var_default := rt.new_null()
	mut var_value := rt.new_null()
	mut var_ttl := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_values := rt.new_null()
}
