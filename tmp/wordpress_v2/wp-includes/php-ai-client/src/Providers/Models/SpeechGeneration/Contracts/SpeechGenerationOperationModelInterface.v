import rt

interface SpeechGenerationOperationModelInterface {
	generatespeechoperation(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_prompt := rt.new_null()
}
