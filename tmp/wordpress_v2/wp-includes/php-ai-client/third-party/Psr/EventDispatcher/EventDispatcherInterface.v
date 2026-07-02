import rt

interface EventDispatcherInterface {
	dispatch(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_event := rt.new_null()
}
