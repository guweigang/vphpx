import rt

interface DataCache {
	get_data(rt.PhpVal, rt.PhpVal) rt.PhpVal
	set_data(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_data(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_simplepie_src_cache_datacache_php() {
	mut var_key := rt.new_null()
	mut var_default := rt.new_null()
	mut var_value := rt.new_null()
	mut var_ttl := rt.new_null()
	// unsupported statement: Stmt_Declare
}
