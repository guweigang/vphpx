import rt

interface SectionInterface {
	add_subsection(rt.PhpVal) rt.PhpVal
	add_block(rt.PhpVal) rt.PhpVal
	add_section(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_block_config := rt.new_null()
}
