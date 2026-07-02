import rt

interface ValidationContext {
	reporterror(rt.PhpVal) rt.PhpVal
	geterrors() rt.PhpVal
	getdocument() rt.PhpVal
	getschema() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_error := rt.new_null()
}
