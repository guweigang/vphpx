import rt

pub fn init_wp_includes_js_dist_script_modules_workflow_index_min_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-dom' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-keyboard-shortcuts' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-private-apis' },
		]) },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/abilities' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) },
		rt.ArrayItem{ key: 'version', val: '13556bc597bbf2a8d620' },
	])
}
