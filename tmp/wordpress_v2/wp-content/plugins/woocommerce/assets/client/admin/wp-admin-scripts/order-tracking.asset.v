import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-customer-effort-score' },
		]) },
		rt.ArrayItem{ key: 'version', val: '9faf1c8a5a7facc6f9ed' },
	])
}
