import rt

interface Client {
	request(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_method := rt.new_null()
	mut var_url := rt.new_null()
	mut var_headers := rt.new_null()
}
