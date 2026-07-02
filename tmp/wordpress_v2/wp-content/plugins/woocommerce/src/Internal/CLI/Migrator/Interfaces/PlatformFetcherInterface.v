import rt

interface PlatformFetcherInterface {
	fetch_batch(rt.PhpVal) rt.PhpVal
	fetch_total_count(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_args := rt.new_null()
}
