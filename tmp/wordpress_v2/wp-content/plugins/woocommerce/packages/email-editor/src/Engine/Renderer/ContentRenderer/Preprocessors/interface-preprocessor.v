import rt

interface Preprocessor {
	preprocess(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_parsed_blocks := rt.new_null()
	mut var_layout := rt.new_null()
	mut var_styles := rt.new_null()
}
