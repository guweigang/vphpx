import rt

interface ResponseInterface {
	getstatuscode() rt.PhpVal
	withstatus(rt.PhpVal, rt.PhpVal) rt.PhpVal
	getreasonphrase() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_code := rt.new_null()
	mut var_reasonPhrase := rt.new_null()
}
