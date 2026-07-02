import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: '@wordpress/interactivity.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'd2480d9723d4a2e271a3' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
		rt.ArrayItem{ key: '@wordpress/interactivity-router.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: 'f6891db5910eeaa446d7' },
			rt.ArrayItem{ key: 'type', val: 'module' },
		]) },
	])
}
