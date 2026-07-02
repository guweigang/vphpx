import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '1cd9ffa6e3cff96ad1b2' },
	])
}
