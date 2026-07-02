import rt

interface ModelInterface {
	metadata() rt.PhpVal
	providermetadata() rt.PhpVal
	setconfig(rt.PhpVal) rt.PhpVal
	getconfig() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_config := rt.new_null()
}
