import rt

interface ContainerInterface {
	get_root_template() rt.PhpVal
	get_formatted_template() rt.PhpVal
	get_block(rt.PhpVal) rt.PhpVal
	remove_block(rt.PhpVal) rt.PhpVal
	remove_blocks() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_block_id := rt.new_null()
}
