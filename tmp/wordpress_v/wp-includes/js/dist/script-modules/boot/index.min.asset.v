import rt

pub fn init_wp_includes_js_dist_script_modules_boot_index_min_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-dom' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-commands' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-editor' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-keyboard-shortcuts' },
			rt.ArrayItem{ key: none, val: 'wp-keycodes' },
			rt.ArrayItem{ key: none, val: 'wp-notices' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			rt.ArrayItem{ key: none, val: 'wp-theme' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/lazy-editor' },
				rt.ArrayItem{ key: 'import', val: 'dynamic' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) },
		rt.ArrayItem{ key: 'version', val: '54bb5a420026a61c7e4f' },
	])
}
