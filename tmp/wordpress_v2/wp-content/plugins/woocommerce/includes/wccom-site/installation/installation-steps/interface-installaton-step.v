import rt

interface WC_WCCOM_Site_Installation_Step {
	construct(rt.PhpVal) rt.PhpVal
	run() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_state := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
