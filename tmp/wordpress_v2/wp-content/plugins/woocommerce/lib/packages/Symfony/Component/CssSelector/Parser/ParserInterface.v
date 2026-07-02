import rt

interface ParserInterface {
	parse(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_source := rt.new_null()
}
