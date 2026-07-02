import rt

interface RequestFactoryInterface {
	createrequest(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_method := rt.new_null()
	mut var_uri := rt.new_null()
}
