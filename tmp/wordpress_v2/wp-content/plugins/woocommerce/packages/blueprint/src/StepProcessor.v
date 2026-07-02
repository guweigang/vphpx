import rt

interface StepProcessor {
	process(rt.PhpVal) rt.PhpVal
	get_step_class() rt.PhpVal
	check_step_capabilities(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_schema := rt.new_null()
}
