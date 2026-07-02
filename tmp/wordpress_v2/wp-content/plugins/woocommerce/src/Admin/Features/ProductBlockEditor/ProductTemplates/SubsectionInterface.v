import rt

interface SubsectionInterface {
	add_block(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_block_config := rt.new_null()
}
