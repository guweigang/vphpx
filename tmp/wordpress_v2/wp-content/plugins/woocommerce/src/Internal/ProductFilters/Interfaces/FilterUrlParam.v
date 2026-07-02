import rt

interface FilterUrlParam {
	get_param_keys() rt.PhpVal
	get_param(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_type := rt.new_null()
}
