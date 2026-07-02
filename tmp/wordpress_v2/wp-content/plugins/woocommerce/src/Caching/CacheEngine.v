import rt

interface CacheEngine {
	get_cached_object(rt.PhpVal, rt.PhpVal) rt.PhpVal
	cache_object(rt.PhpVal, rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_cached_object(rt.PhpVal, rt.PhpVal) rt.PhpVal
	is_cached(rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_cache_group(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_key := rt.new_null()
	mut var_group := rt.new_null()
	mut var_object := rt.new_null()
	mut var_expiration := rt.new_null()
}
