import rt

interface ServerRequestFactoryInterface {
	createserverrequest(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_method := rt.new_null()
	mut var_uri := rt.new_null()
	mut var_serverParams := rt.new_null()
}
