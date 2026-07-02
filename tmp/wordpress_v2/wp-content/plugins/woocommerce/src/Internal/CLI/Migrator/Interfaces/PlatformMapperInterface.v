import rt

interface PlatformMapperInterface {
	map_product_data(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_platform_data := rt.new_null()
}
