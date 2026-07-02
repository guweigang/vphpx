import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wc-settings-editor' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'd21ed7629b87df25afaf' },
	])
}
