import rt

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_schemas_definitions_urlreference_php() {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'url' },
				rt.ArrayItem{ key: 'description', val: 'Identifies the file resource as a URL' },
			]) },
			rt.ArrayItem{ key: 'url', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The URL of the file' },
			]) },
			rt.ArrayItem{ key: 'caption', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{
					key: 'description'
					val: 'Optional caption for displaying a progress message'
				},
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'resource' },
			rt.ArrayItem{ key: none, val: 'url' },
		]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}
