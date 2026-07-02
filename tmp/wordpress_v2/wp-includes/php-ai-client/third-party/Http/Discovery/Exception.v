import rt

interface Exception {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
