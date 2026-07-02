import rt

interface RequestAuthenticationInterface {
	authenticaterequest(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_request := rt.new_null()
}
