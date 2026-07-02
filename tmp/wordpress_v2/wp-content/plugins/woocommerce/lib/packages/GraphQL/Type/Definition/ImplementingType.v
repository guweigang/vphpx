import rt

interface ImplementingType {
	implementsinterface(rt.PhpVal) rt.PhpVal
	getinterfaces() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_interfaceType := rt.new_null()
}
