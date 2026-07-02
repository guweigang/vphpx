import rt

interface BlockTemplateInterface {
	get_id() rt.PhpVal
	get_title() rt.PhpVal
	get_description() rt.PhpVal
	get_area() rt.PhpVal
	generate_block_id(rt.PhpVal) rt.PhpVal
	to_json() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_id_base := rt.new_null()
}
