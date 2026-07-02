import rt

interface ClientInterface {
	sendrequest(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_request := rt.new_null()
}
