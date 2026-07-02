import rt

interface ActionScheduler_Exception {
}

fn main() {
	defer {
		rt.shutdown()
	}
}
