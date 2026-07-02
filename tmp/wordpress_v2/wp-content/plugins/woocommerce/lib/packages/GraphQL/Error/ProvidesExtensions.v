import rt

interface ProvidesExtensions {
	getextensions() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
