import rt

interface ProviderWithOperationsHandlerInterface {
	operationshandler() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
