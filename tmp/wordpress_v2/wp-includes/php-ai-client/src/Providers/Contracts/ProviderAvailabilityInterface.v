import rt

interface ProviderAvailabilityInterface {
	isconfigured() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
