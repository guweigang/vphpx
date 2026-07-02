import rt

interface TypeExtensionNode {
	getname() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
