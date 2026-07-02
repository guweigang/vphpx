import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
				rt.ArrayItem{ key: 'import', val: 'dynamic' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) }, rt.ArrayItem{ key: 'version', val: '71aa17bac91628a0f874' }])
}
