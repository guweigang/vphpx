import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: '37c66df6df7864ec6b88' }])
}
