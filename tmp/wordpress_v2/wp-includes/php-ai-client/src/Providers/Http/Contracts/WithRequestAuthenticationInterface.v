import rt

interface WithRequestAuthenticationInterface {
	setrequestauthentication(rt.PhpVal) rt.PhpVal
	getrequestauthentication() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_authentication := rt.new_null()
}
