import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: '0065d129347f29fbc88a' }])
}
