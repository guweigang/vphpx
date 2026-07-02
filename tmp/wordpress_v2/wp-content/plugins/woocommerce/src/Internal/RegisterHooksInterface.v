import rt

interface RegisterHooksInterface {
	register() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
