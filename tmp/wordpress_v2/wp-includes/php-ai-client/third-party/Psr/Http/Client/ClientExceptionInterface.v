import rt

interface ClientExceptionInterface {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
