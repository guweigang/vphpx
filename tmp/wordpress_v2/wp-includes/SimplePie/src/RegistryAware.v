import rt

interface RegistryAware {
	set_registry(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_registry := rt.new_null()
}
