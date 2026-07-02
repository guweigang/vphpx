import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-tracks' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'c7c2733765b920821fe4' },
	])
}
