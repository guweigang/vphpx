import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'git:directory' },
				rt.ArrayItem{
					key: 'description'
					val: 'Identifies the file resource as a git directory'
				},
			]) },
			rt.ArrayItem{ key: 'url', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The URL of the git repository' },
			]) },
			rt.ArrayItem{ key: 'ref', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The branch of the git repository' },
			]) },
			rt.ArrayItem{ key: 'path', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{
					key: 'description'
					val: 'The path to the directory in the git repository'
				},
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'resource' },
			rt.ArrayItem{ key: none, val: 'url' },
			rt.ArrayItem{ key: none, val: 'ref' },
			rt.ArrayItem{ key: none, val: 'path' },
		]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}
