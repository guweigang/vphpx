import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: '22.6.0-rc.1' },
		rt.ArrayItem{ key: 'build_url', val: rt.call_function('includes_url', [
			rt.new_string('build/'),
		]) }])
}
