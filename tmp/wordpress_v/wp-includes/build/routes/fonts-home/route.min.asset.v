import rt

pub fn init_wp_includes_build_routes_fonts_home_route_min_asset_php() {
	return rt.create_array([rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
		rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
				rt.ArrayItem{ key: 'import', val: 'static' },
			]) },
		]) }, rt.ArrayItem{ key: 'version', val: '63fba8ad1ac5f2b9aba8' }])
}
