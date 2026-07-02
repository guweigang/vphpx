import rt

interface WithArrayTransformationInterface {
	toarray() rt.PhpVal
	fromarray(rt.PhpVal) rt.PhpVal
	isarrayshape(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_array := rt.new_null()
}
