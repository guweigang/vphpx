import rt

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_schemas_definitions_literalreference_php() {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'const', val: 'literal' },
				rt.ArrayItem{
					key: 'description'
					val: 'Identifies the file resource as a literal file'
				},
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'description', val: 'The name of the file' },
			]) },
			rt.ArrayItem{ key: 'contents', val: rt.create_array([
				rt.ArrayItem{ key: 'anyOf', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'BYTES_PER_ELEMENT', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'number' },
							]) },
							rt.ArrayItem{ key: 'buffer', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'object' },
								rt.ArrayItem{ key: 'properties', val: rt.create_array([
									rt.ArrayItem{ key: 'byteLength', val: rt.create_array([
										rt.ArrayItem{ key: 'type', val: 'number' },
									]) },
								]) },
								rt.ArrayItem{ key: 'required', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'byteLength' },
								]) },
								rt.ArrayItem{ key: 'additionalProperties', val: false },
							]) },
							rt.ArrayItem{ key: 'byteLength', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'number' },
							]) },
							rt.ArrayItem{ key: 'byteOffset', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'number' },
							]) },
							rt.ArrayItem{ key: 'length', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'number' },
							]) },
						]) },
						rt.ArrayItem{ key: 'required', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'BYTES_PER_ELEMENT' },
							rt.ArrayItem{ key: none, val: 'buffer' },
							rt.ArrayItem{ key: none, val: 'byteLength' },
							rt.ArrayItem{ key: none, val: 'byteOffset' },
							rt.ArrayItem{ key: none, val: 'length' },
						]) },
						rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'number' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'description', val: 'The contents of the file' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'resource' },
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'contents' },
		]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}
