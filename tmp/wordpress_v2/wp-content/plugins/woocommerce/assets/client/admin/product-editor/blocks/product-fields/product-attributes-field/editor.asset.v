import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: 'version', val: 'aa573e02b041b786818e' }])
}
