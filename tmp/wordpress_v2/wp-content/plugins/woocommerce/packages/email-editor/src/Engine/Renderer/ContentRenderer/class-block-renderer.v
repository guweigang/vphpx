import rt

interface Block_Renderer {
	render(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_block_content := rt.new_null()
	mut var_parsed_block := rt.new_null()
	mut var_rendering_context := rt.new_null()
}
