import rt

interface ContainerExceptionInterface {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
