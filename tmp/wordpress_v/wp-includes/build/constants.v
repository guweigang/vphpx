import rt

pub fn init_wp_includes_build_constants_php() {
	return rt.create_array([rt.ArrayItem{ key: 'version', val: '22.6.0-rc.1' },
		rt.ArrayItem{ key: 'build_url', val: rt.call_function('includes_url', [
			rt.new_string('build/'),
		]) }])
}
