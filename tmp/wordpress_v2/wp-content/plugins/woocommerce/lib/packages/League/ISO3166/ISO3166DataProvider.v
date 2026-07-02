import rt

interface ISO3166DataProvider {
	name(rt.PhpVal) rt.PhpVal
	alpha2(rt.PhpVal) rt.PhpVal
	alpha3(rt.PhpVal) rt.PhpVal
	numeric(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_name := rt.new_null()
	mut var_alpha2 := rt.new_null()
	mut var_alpha3 := rt.new_null()
	mut var_numeric := rt.new_null()
}
