import rt

interface TextGenerationOperationModelInterface {
	generatetextoperation(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_prompt := rt.new_null()
}
