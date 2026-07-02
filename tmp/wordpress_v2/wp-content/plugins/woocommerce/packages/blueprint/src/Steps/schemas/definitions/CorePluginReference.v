import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'wordpress.org/plugins' },
				rt.ArrayItem{
					key: 'description'
					val: 'Identifies the file resource as a WordPress Core plugin'
				},
			]) },
			rt.ArrayItem{ key: 'slug', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The slug of the WordPress Core plugin' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'resource' },
			rt.ArrayItem{ key: none, val: 'slug' },
		]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}
