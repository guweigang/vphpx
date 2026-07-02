import rt

interface ImageGenerationOperationModelInterface {
	generateimageoperation(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_prompt := rt.new_null()
}
