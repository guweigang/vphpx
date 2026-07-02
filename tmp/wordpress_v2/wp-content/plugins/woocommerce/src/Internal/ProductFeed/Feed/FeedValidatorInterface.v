import rt

interface FeedValidatorInterface {
	validate_entry(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_row := rt.new_null()
	mut var_product := rt.new_null()
}
