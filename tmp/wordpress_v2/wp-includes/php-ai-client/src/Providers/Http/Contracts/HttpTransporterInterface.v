import rt

interface HttpTransporterInterface {
	send(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_request := rt.new_null()
	mut var_options := rt.new_null()
}
