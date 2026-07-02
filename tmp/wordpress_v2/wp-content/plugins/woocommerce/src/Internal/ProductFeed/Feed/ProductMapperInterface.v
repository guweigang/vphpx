import rt

interface ProductMapperInterface {
	map_product(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
}
