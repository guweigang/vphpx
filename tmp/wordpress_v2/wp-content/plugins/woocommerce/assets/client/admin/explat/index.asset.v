import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'ed17599085ff789f2e76' },
	])
}
