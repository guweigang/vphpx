import rt

interface HandlerInterface {
	handle(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_reader := rt.new_null()
	mut var_stream := rt.new_null()
}
