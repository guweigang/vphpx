import rt

interface HookManager {
	register(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	dispatch(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_hook := rt.new_null()
	mut var_callback := rt.new_null()
	mut var_priority := rt.new_null()
	mut var_parameters := rt.new_null()
}
