import rt

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_schemas_definitions_vfsreference_php() {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'vfs' },
				rt.ArrayItem{
					key: 'description'
					val: 'Identifies the file resource as Virtual File System (VFS)'
				},
			]) },
			rt.ArrayItem{ key: 'path', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The path to the file in the VFS' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'resource' },
			rt.ArrayItem{ key: none, val: 'path' },
		]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}
