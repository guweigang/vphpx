import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: '1f9dd32ff73b1f3fe1bc' }])
}
