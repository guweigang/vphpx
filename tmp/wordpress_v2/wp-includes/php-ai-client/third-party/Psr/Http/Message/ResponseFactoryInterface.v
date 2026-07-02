import rt

interface ResponseFactoryInterface {
	createresponse(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_code := rt.new_null()
	mut var_reasonPhrase := rt.new_null()
}
