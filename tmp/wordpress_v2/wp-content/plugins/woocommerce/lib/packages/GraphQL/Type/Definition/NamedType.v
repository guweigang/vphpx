import rt

interface NamedType {
	assertvalid() rt.PhpVal
	isbuiltintype() rt.PhpVal
	name() rt.PhpVal
	description() rt.PhpVal
	astnode() rt.PhpVal
	extensionastnodes() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
