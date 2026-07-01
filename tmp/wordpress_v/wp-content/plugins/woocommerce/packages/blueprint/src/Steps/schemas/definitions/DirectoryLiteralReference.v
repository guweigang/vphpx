import rt

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_schemas_definitions_directoryliteralreference_php() {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'additionalProperties', val: false },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'literal:directory' },
				rt.ArrayItem{
					key: 'description'
					val: 'Identifies the file resource as a git directory'
				},
			]) },
			rt.ArrayItem{ key: 'files', val: rt.create_array([
				rt.ArrayItem{ key: '$ref', val: '#/definitions/FileTree' },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'files' },
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'resource' },
		]) }])
}
