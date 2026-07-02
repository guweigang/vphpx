import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: 'a6347505717411afe8c2' }])
}
