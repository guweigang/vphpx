import rt

interface ProviderInterface {
	metadata() rt.PhpVal
	model(rt.PhpVal, rt.PhpVal) rt.PhpVal
	availability() rt.PhpVal
	modelmetadatadirectory() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_modelId := rt.new_null()
	mut var_modelConfig := rt.new_null()
}
