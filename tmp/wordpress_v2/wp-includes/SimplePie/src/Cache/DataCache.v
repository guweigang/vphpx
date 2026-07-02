import rt

interface DataCache {
	get_data(rt.PhpVal, rt.PhpVal) rt.PhpVal
	set_data(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	delete_data(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_key := rt.new_null()
	mut var_default := rt.new_null()
	mut var_value := rt.new_null()
	mut var_ttl := rt.new_null()
}
