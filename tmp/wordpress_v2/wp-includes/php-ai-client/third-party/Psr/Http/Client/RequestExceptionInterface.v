import rt

interface RequestExceptionInterface {
	getrequest() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
