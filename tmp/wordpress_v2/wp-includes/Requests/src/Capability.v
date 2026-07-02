import rt

interface Capability {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
