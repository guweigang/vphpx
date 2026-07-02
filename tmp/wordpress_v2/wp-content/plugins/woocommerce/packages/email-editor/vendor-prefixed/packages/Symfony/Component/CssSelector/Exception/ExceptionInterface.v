import rt

interface ExceptionInterface {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
