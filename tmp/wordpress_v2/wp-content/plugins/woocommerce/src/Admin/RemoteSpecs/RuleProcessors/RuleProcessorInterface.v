import rt

interface RuleProcessorInterface {
	process(rt.PhpVal, rt.PhpVal) rt.PhpVal
	validate(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_rule := rt.new_null()
	mut var_stored_state := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
