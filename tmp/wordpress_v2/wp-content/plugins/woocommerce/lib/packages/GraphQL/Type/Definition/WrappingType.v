import rt

interface WrappingType {
	getwrappedtype() rt.PhpVal
	getinnermosttype() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
