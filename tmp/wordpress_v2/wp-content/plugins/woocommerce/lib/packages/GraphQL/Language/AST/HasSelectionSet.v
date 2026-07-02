import rt

interface HasSelectionSet {
	getselectionset() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
