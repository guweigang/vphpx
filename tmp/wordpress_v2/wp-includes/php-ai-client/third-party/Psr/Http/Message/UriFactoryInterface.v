import rt

interface UriFactoryInterface {
	createuri(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_uri := rt.new_null()
}
