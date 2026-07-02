import rt

interface ClientAware {
	isclientsafe() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
