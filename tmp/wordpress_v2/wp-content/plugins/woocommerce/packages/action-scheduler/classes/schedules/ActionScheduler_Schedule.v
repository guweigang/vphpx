import rt

interface ActionScheduler_Schedule {
	next(rt.PhpVal) rt.PhpVal
	is_recurring() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_after := rt.new_null()
}
