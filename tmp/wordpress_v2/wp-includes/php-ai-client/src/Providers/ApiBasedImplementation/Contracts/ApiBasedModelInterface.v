import rt

interface ApiBasedModelInterface {
	setrequestoptions(rt.PhpVal) rt.PhpVal
	getrequestoptions() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_requestOptions := rt.new_null()
}
