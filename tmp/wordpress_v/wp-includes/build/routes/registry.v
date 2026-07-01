import rt

pub fn init_wp_includes_build_routes_registry_php() {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'connectors-home' },
			rt.ArrayItem{ key: 'path', val: '/' },
			rt.ArrayItem{ key: 'page', val: 'options-connectors' },
			rt.ArrayItem{ key: 'has_route', val: true },
			rt.ArrayItem{ key: 'has_content', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'font-list' },
			rt.ArrayItem{ key: 'path', val: '/font-list' },
			rt.ArrayItem{ key: 'page', val: 'font-library' },
			rt.ArrayItem{ key: 'has_route', val: true },
			rt.ArrayItem{ key: 'has_content', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'fonts-home' },
			rt.ArrayItem{ key: 'path', val: '/' },
			rt.ArrayItem{ key: 'page', val: 'font-library' },
			rt.ArrayItem{ key: 'has_route', val: true },
			rt.ArrayItem{ key: 'has_content', val: false },
		]) },
	])
}
