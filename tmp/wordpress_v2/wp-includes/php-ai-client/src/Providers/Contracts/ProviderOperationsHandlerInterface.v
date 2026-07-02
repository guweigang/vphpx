import rt

interface ProviderOperationsHandlerInterface {
	getoperation(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_operationId := rt.new_null()
}
