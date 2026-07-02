import rt

interface TypeDefinitionNode {
	getname() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
