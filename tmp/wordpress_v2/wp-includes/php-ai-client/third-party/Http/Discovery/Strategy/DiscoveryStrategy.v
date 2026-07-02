import rt

interface DiscoveryStrategy {
	getcandidates(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_type := rt.new_null()
}
