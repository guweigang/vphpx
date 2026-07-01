import rt

pub fn init_wp_includes_js_dist_script_modules_edit_site_init_index_min_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
		]) },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/boot' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) },
		rt.ArrayItem{ key: 'version', val: 'e57f44d1a9f69e75d2d9' },
	])
}
