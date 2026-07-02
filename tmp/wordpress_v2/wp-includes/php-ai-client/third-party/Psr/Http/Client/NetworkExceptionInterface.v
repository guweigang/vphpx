import rt

interface NetworkExceptionInterface {
	getrequest() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
