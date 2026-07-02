import rt

interface ScopedContext {
	clone() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
