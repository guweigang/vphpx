import rt

interface Auth {
	register(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_hooks := rt.new_null()
}
