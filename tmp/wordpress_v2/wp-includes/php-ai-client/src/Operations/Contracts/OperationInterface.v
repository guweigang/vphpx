import rt

interface OperationInterface {
	getid() rt.PhpVal
	getstate() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
