import rt

interface TransformerInterface {
	transform(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	validate(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_value := rt.new_null()
	mut var_arguments := rt.new_null()
	mut var_default_value := rt.new_null()
}
