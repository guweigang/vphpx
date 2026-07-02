import rt

interface ContainerInterface {
	get(rt.PhpVal) rt.PhpVal
	has(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_id := rt.new_null()
}
