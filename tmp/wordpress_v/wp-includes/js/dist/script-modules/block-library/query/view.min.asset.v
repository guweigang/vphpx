import rt

pub fn init_wp_includes_js_dist_script_modules_block_library_query_view_min_asset_php() {
	return rt.create_array([rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
				rt.ArrayItem{ key: 'import', val: 'dynamic' },
			]) },
		]) }, rt.ArrayItem{ key: 'version', val: '7a4ec5bfb61a7137cf4b' }])
}
