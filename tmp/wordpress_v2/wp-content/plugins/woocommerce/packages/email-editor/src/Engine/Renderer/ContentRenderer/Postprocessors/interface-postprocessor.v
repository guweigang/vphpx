import rt

interface Postprocessor {
	postprocess(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_html := rt.new_null()
}
