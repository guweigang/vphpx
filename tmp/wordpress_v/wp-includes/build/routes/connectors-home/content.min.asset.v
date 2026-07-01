import rt

pub fn init_wp_includes_build_routes_connectors_home_content_min_asset_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-dom' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
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
				rt.ArrayItem{ key: 'id', val: '@wordpress/connectors' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) },
		rt.ArrayItem{ key: 'version', val: 'b614fcaf0d408b3eff9d' },
	])
}
