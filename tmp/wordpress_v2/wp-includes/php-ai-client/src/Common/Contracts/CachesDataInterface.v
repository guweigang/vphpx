import rt

interface CachesDataInterface {
	invalidatecaches() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
