import rt

interface NodeInterface {
	getnodename() rt.PhpVal
	getspecificity() rt.PhpVal
	magic_tostring() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
