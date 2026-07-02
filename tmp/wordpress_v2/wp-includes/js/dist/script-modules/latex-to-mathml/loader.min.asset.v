import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/latex-to-mathml' },
				rt.ArrayItem{ key: 'import', val: 'dynamic' },
			]) },
		]) }, rt.ArrayItem{ key: 'version', val: '4f37456af539bd3d2351' }])
}
