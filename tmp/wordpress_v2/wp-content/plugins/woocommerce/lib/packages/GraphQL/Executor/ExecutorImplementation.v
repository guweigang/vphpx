import rt

interface ExecutorImplementation {
	doexecute() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
