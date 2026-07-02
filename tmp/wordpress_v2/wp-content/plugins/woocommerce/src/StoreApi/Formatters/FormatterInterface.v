import rt

interface FormatterInterface {
	format(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_value := rt.new_null()
	mut var_options := rt.new_null()
}
