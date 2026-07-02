import rt

interface NameFilter {
	filter(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_name := rt.new_null()
}
